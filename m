Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B130ECAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3MrJ-0007HW-43; Mon, 29 Sep 2025 19:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3MrF-0007GU-7U
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:00:37 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3MrD-0006g4-6s
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:00:36 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-33274fcf5c1so5062205a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759186832; x=1759791632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hpwd6krp6Tc9qVQMPcTDxC33QQgMzfj5ts3gjl40OYc=;
 b=L6gupSITEmxiwOXfnS+yUtwLUUOZwKwt3mq98WDwOkWlwRsaoge4wt80H1NgpJiyJf
 TkgZkmjbLzpuVxmYSDds8lF5lC0zmiDBP6a0Rkn+DLRh2qIdBzwSjAI+Vx7momflXV6J
 viPv/klsf9n01T4ExqSub4Ha/ft/kJj8a+JBb5qP+fyL8lufo1jmVJpkP2LZjcX0t+hq
 /aQjtiOoBAaSVE6xlFpbLJTJqhC9dD6EmOqnxq5e8F8pUPjvN7+gOWhRitzJ9NKRpJ/F
 YLGLA63l+3cuUJZum0ifCh/h5HXKV8QoazADTyhZxxg1M+1ONj2kyHNkNx/H8uXK0Y0/
 tAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759186832; x=1759791632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hpwd6krp6Tc9qVQMPcTDxC33QQgMzfj5ts3gjl40OYc=;
 b=vHNvW1hEdhVoj4G2fePdU8sd3u5idHIXXxJt/x6mAA+kWR1OF4NnPmNmDHVQ7vHZnI
 7VZMlKtfyN6irfVsB93jL1KiLWY6D+UbQ1+dBGL28YWOwgQH5bty8bn5UXxdgYVlhMEh
 vJIKecv9sio6Zmaw16YGRMPqMQlQvu70l+BGyBoZ0xLJY7hhv7DpSMdKSOzrAjJQIB+q
 UTw3vZ+ZHN6Hp8u5qRehWI98DQCEF+gbqX6hrMGgk7YUoWkuQNuKEOm5+uOuCB43wri5
 q0b0QPH3NinPokrxfeVAJt3t7rXgEWwGlShITb5EfueDCuMeMgvl2MWYMHthTn6E2SyQ
 eAjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCdLDfJ0EXTwZl05aOFhD6sslmIB6Fhn/5vLOLrfvO84goAiv9KsTLy5OdYtCWIUk/1GUdU56wo0Qb@nongnu.org
X-Gm-Message-State: AOJu0YykV3S/MMz8iU8of8Wo/gvijs2dj10mrUQR87sJEhmPRQ0HCQ3u
 hv3QVD8b7fOAQU95pFBlWxJgW2jS8I9Mu4LBeONDbBkvdjUgayL1w11NfHgfi8Xs01U=
X-Gm-Gg: ASbGncsAZT8zY+ZuCUE7n9OI6p2LEFF4DT0f327fE+SzEyULpwqujG6G97b0OM3yqK4
 AVUyU38U80sY4ODN01CKnHWRD+R4CnguOjV+RuuP6GOvON29g+WRYP/Q0Jk9zfoCW57zFfViilb
 MBAmFoZ5MFY3GyreAz9cqLodrOHP/gkfUpRJz7eXdpZK8SOuntyTvJYKrEkGWglZw4yfM8adWWy
 Od1bsHCwRicQi7/nfbi0jGiUYUbl7FjA9h9ReCRIba1F3uO58EbKQ4dcmuxPjCSN5Cn6mQNUB+5
 DHh/FF1zYuBq2NvuB4LCbJ8SqnKQ9adED+QbjOpAe3WYEtNZXeD4DZ5TyxNv9e4CFjaACQWZHIB
 40tjbu++aQDRiJyPiiBKT4svW+CKafZT1kYk=
X-Google-Smtp-Source: AGHT+IHctUn1DmR04UVSKPmXFltNAn5MLvEESmhhOnWsOmTfn0yAGW0VFOjdso6CiW3NMVYk8c6teA==
X-Received: by 2002:a17:90b:4d8a:b0:330:48d1:f90a with SMTP id
 98e67ed59e1d1-3342a2cb65bmr19031409a91.27.1759186832202; 
 Mon, 29 Sep 2025 16:00:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3399bc02e26sm108281a91.1.2025.09.29.16.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 16:00:31 -0700 (PDT)
Message-ID: <7cf7e3ce-2a04-4bbc-b0ae-5a2db3b53f45@linaro.org>
Date: Mon, 29 Sep 2025 16:00:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] target/arm: Add isar feature test for FEAT_RME_GPC2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250926001134.295547-1-richard.henderson@linaro.org>
 <20250926001134.295547-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250926001134.295547-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/25/25 5:11 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-features.h | 5 +++++
>   1 file changed, 5 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


