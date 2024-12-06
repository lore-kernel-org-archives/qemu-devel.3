Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5BDE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTuS-0007vj-A4; Fri, 06 Dec 2024 03:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTuQ-0007vI-KE
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:41:58 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTuO-0001U1-TD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:41:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a2033562so17496995e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474515; x=1734079315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YXeNV430RbCqMtLJfxr0i4T2gHs2Bp72iIkuGaTtL7w=;
 b=qap6bjK4SXBB4MjZCdnN2apLzkgvTW4eJJLgZQpso0nYnMVY0Lz0BaNg/uUbVoZP2u
 oYglRqovronjT+fltlWu8KWXl74V17Jgkz9tdfnT/Fgbrz/2BST3ba51v8VE7aqrvNAr
 fuoK2BJw9hF8D9WKMZ/pkD/9bX8ip992WC7siIRFztw6LFWqNMQhSXBola8LRDS+DDHc
 IptvS7unx1WWWuUilY8Dyr8bR7nZT3uEDs4Ss2v/PKcq0a5yCq99taUcKAhvjZhPR8R1
 GfHN+jzizgIFgONWEdvLO89KY7hLQbC2rY+jUFEay96sUUoxHmEga0Xa9V1SXCI6ustj
 ZkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474515; x=1734079315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YXeNV430RbCqMtLJfxr0i4T2gHs2Bp72iIkuGaTtL7w=;
 b=lr67s9LOuod/gbd5a7StDPZKAW8t0jp3mQtbJc2hiSgT2T46GDDtM5bUuiNunbtP9E
 vbYhkoLpTv4jdOnZdwNO1t221tLnLudcNlfwvJR3D8Srv0HdwT8/cENTEf0cfcmSBZJs
 +EhJXtlTJquG1C7Cpo8ALpJfsKSxyodgX6fxWfmIK+RdmZVG8+LTfDwgtDupA1/bn/qp
 +iU8/2ThJmG4dh7KPXNzDgPFG9xSWNMstZBf2nP0xQWC9vFNNGwuVxDEVw+ari1BN/nk
 VsQX0gQTC+/jmHkYFNB7s5HpueEwmWXihvDpWh2f3D61Nj6/LqUXNJ1sofQuwKExRzMc
 hOdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRMwK9yUUk3BLHYPvfsHVZdg+7T1Dj/0itinP9PnwOthyhQzM2aeGdNPpdBKYuQieBWGlhnukhWGk7@nongnu.org
X-Gm-Message-State: AOJu0YyyyW4D1wU4GnUD4cAgnor5G+bdOBl4A0pAKimwkLGNs86A8Cbk
 h/vxoZ1MaTUU3Yr2rslzotH2KRcRuTj0uFjyND/Q0GqWOi3XUpslenj+Mq4mWYRtKBgv6Auif/y
 1
X-Gm-Gg: ASbGncsUvs9vrZyfjzQR6fxibNR1qF7PJA4hbBX1GbwqbW8brIaZk5pIGptkC3RXXav
 rAfm/xUQCABtyjJVfqn5yKLzegDONrQMuXevanV88jUMM5BjLYQTNR8aK6NKHYOfyG4umbk227h
 kz4Ze4FZz87MelRVqzs3p7OE2BCi8c14/f010OAu2Hej1Tdna61Ld9YbR9tza4xxK7jLyxurbqN
 9BfDTKI1YRfzs1tVxHqZbedBX5+CIKHhbD2zK899kTkdFXlaYa4gZFZQVZulCq6nJoMWlZ0xlNI
 UlYCvdc6ruBfzc0FIQ==
X-Google-Smtp-Source: AGHT+IEhRygbiC5T5Do8t1PMNicb97xl6TzcGIgiYGK961y79Q6SzXCY+CflLSlNpfgZXitwi0dBog==
X-Received: by 2002:a05:6000:1a86:b0:385:fc70:826 with SMTP id
 ffacd0b85a97d-3862b3e3118mr1248864f8f.52.1733474515430; 
 Fri, 06 Dec 2024 00:41:55 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d5280120sm85734735e9.20.2024.12.06.00.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:41:54 -0800 (PST)
Message-ID: <8c910be5-3d59-4632-9818-bcc2c860fa5d@linaro.org>
Date: Fri, 6 Dec 2024 09:41:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: Use float_status in helper_vfp_fcvt{ds,sd}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031952.78776-1-richard.henderson@linaro.org>
 <20241206031952.78776-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031952.78776-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 6/12/24 04:19, Richard Henderson wrote:
> Pass float_status not env to match other functions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h            |  4 ++--
>   target/arm/tcg/translate-a64.c | 15 ++++++++++-----
>   target/arm/tcg/translate-vfp.c |  4 ++--
>   target/arm/vfp_helper.c        |  8 ++++----
>   4 files changed, 18 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


