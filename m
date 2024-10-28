Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41549D5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRW-0001bM-O9; Tue, 29 Oct 2024 02:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRS-0001YY-Vc
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRP-0007Dv-Cj
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so46980605e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182254; x=1730787054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vdprgcuz7bb7byZBLscoga4XNpSMzSOLnmRWmYyTOpo=;
 b=OilPDfmTj+yYdXn1psQ4AY/AD6KyQB73LQxX8fMTO7xYbJCtB0C8rqllr9Xe6vIey8
 arznfWYS48d8LAUe3zwNA41tZLdHCABXjjswKoIKH3LV1pOKq0a/t3OXOe75tHrl0WEb
 BFQfTy+I5lI8jXU3YQpAT8G8LQkGieDRv8mQ+YWI7UCYeeEf+j+Qs2+ypKKQNlaRHSgF
 I7+9kkbWmxXffcYsq36NXlKxMOLEuq9BGVOOIfLLoKZfVVyt6wCrKZoLN5Ff6qJGJFQf
 A6W7vrNsgmLhM0+7vvXysy1h1LM7/VYZsJaq1VT74vg7/6arPNyiozrhy1TFIXhoKi8V
 hbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182254; x=1730787054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vdprgcuz7bb7byZBLscoga4XNpSMzSOLnmRWmYyTOpo=;
 b=dAc7u1ut4Pm1a5SKRZMeOwXdTqAHgWkmK+aDQBkPcUPV0vx5fQP9af6rGYcLyY3FH4
 DIwcGL5DMX7820tj2WQN8WkVls3y7A1vUTE2on0u7BtX/HKndvO8X39xPvYq4tNFVO/1
 ykyvaiKT76I7a3X3CQHNuOrJ+acxynCzy4ewUmEhNghLMK5z5kbeh/dZohIZ6fYfaaYL
 hm4WgvBhHbih3UUX4aH+2deVVQRJdhwBcOEFnJi7HGti9eaA5KL68dltlBUOxKCT6n//
 15otrtOU8SA6xLlQ2GL2lHFr1po2phWu1SQ6S6SForVIte2JGM/yjmoCM9tncgg60Py+
 38LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrJDrY+MTR6rjQgzDi42uampBBDPDP8/TAGJw66z46znPQvPiBJQJIFv2JS1TQkI3XwAqpqjjW8yMe@nongnu.org
X-Gm-Message-State: AOJu0YxDucYOOjtVbAItC4f5SFcE1rzZgat41q5q17Rde6aYr8A5eo2q
 yX4x4loQP3H/7p9GbjlQGfI5WTQn022BNW22qV2DwC34IvL68YQgN4Z0b7EJfGU=
X-Google-Smtp-Source: AGHT+IEttoKAn4x9RZQWbeBvw17DYN/C8JqnY0VyjPOAUVm1zU6rk9Ah9WZu50EGFYDOw0wFxBGzpg==
X-Received: by 2002:a05:600c:35cd:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-4319ad0f10cmr90532585e9.24.1730182253825; 
 Mon, 28 Oct 2024 23:10:53 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f5e1sm165298915e9.14.2024.10.28.23.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:53 -0700 (PDT)
Message-ID: <74a8c6b7-9a4c-4595-b3b0-c900dcb01560@linaro.org>
Date: Mon, 28 Oct 2024 12:20:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/21] target/sparc: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-13-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly in the float_status
> words we use.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/sparc/cpu.c             |  8 ++++++++
>   target/sparc/fop_helper.c      | 10 ++++++++--
>   fpu/softfloat-specialize.c.inc |  6 ++----
>   3 files changed, 18 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

