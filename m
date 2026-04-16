Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696A9F8A162
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL0g-0004TF-JH; Thu, 16 Apr 2026 07:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDL0f-0004T6-GC
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:35:49 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDL0d-0002iG-Ur
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:35:49 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-38be5e86918so83214161fa.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776339346; x=1776944146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ohj3VNKc/MZ4fTcCgvTHPXj2AFr5WfdaTZy5Xc6ua94=;
 b=K+c2NnIaom9rsIpJfj5SWUldGWmHmHCKejJloKEQL30Pb3oLE5CjAF8nxTsaXLJD9L
 Rhlyrr5vxfqjkldcMxbaFfohbjfVZZOF0qaKzmN1IkO5R1Y+J4/QfQA9sNXB3rd1nOli
 1aGLRnLrN4wxLeh/aFiM2rhZWDK80cKGEH5qiP58UoiQQPurOt9AAiyUsQe45oodu5V5
 21IGNc+nl1YaGaDgMj9bKFe9yS2E4pHO0dGUOCbGyFm8HyVvOOmdU6sJ9U6G0gHNIlOb
 qwKrncD1tyJRDHF3DF+OJJkEL4KmXzY6Ib50pgQaY1+jBcwlXyo/bTugOV5Ji3uWZn2n
 1vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339346; x=1776944146;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ohj3VNKc/MZ4fTcCgvTHPXj2AFr5WfdaTZy5Xc6ua94=;
 b=hjPv8IZNe9s7sbH0V4M+J3uHagt4OovsLxEY1d14iBbylBVgQzfSeOxjVR3nsmpKYt
 kP356etcr2lbY9cJI8IYHaR5mt3+pVeSLZygpmIW0Nrqz4gOcRm/dUBDRAyzPcrJV4uN
 SPDWOkl8Yo69bnr6VU6DY3thKJ/VwqDtsIWldqet8B+W9WpxlrsMlT7EZRUVFuQl4D8a
 E9pNwSPI0Ef6M6D/8boiPUL7gPQt//j0OcT70jenZo/RoQnivQV30igmHWy/2kF/0pOQ
 GiDyJpZAlssRuDoStupLgbBqg4VgKbHF9K1dpcXIFZkUlFKkEl9jGMf2+VOq3wxf7EPD
 45Cg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7tI1Rdj3Y3Dkxw+D1ttT0kTYv7huNYAOGT6UlviDoTeewH+6uzS+KvxO3AWZIP8GWMPTTFHRUVd1q@nongnu.org
X-Gm-Message-State: AOJu0YwUKq1IsxfHL0kHZGo2pQaqHVnRE8QK5RGmOwM0z3PiVpCatHes
 2BA7HkcbWsGImk5Gi/8PWmw6f7KR3jZ89McObOJ9g/6MJchLFXaE6Uj8P8xqyvImHw0=
X-Gm-Gg: AeBDiesPx0Bfsd7PysfEHzyovYWIF9WUhYLBFUANlWtLt50LTchlHbN+Y4Oq0HlSwl2
 jE7W3tF2L0fE0TORNIWyLsbkAEEqK6IM3iZysTxJRuu7I0qZm6k0ua6XXO80g6k4d2rispt5KJ+
 ltr6dSPbh/i1INartNqFDm+uH0EsQbTs11xuQn1C78zvlXF8QajrAiV9M3hOjGFDfVZiBvznbja
 5sUASnEdJRaSRa7UzU/R8M/4/LM96bkFU0z0QhTlpNOyLncY8eFgCkr+FmyaeHDMWP0CYm7Ujjn
 W5NWCHUZ5LgaKPqZl+Qr3ORLiKSYaJCCyIpIsMgq/JKbPRkakN6MCR1GMTC+KuaY2DuFWmYr1N/
 ffR+x9XJ+DqH85z1Sq7JZLxyXS09R4ON+nPATJ23Twm4Xgwn62FwMZH5YecoN7a8DINow5dRjdq
 T3xUC72X3YetT6cpaCFYEF4I3iJ8rrSFDChxPhtyMgju0mg0anSOt/iq8b+GwppIIstw==
X-Received: by 2002:a05:6512:31d0:b0:5a3:ff73:29d6 with SMTP id
 2adb3069b0e04-5a3ff732d71mr4499671e87.7.1776339345572; 
 Thu, 16 Apr 2026 04:35:45 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a40a2f9c0fsm1208012e87.58.2026.04.16.04.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 04:35:43 -0700 (PDT)
Message-ID: <41813663-757c-4022-92b2-0c285f63d553@linaro.org>
Date: Thu, 16 Apr 2026 13:35:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/28] MAINTAINERS: Remove Bastian Koppelmann
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-12-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Eitan Eliahu <eitan_eliahu@hotmail.com>,
 Anton Kochkov <anton.kochkov@proton.me>
In-Reply-To: <20260416091654.316158-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/26 11:16, Peter Maydell wrote:
> Bastian Koppelmann has not posted to qemu-devel in some years and did not
> respond to a query about whether they still wished to be listed in
> our MAINTAINERS file.  Remove them, on the assumption that they are
> no longer active in QEMU.
> 
> This makes the Tricore TCG CPUs orphan.

Cc'ing TriCore users.

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc7c9b61da..7817a1c97d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -446,8 +446,7 @@ F: include/hw/xtensa/xtensa-isa.h
>   F: configs/devices/xtensa*/default.mak
>   
>   TriCore TCG CPUs
> -M: Bastian Koppelmann <kbastian@rumtueddeln.de>
> -S: Odd Fixes
> +S: Orphan
>   F: target/tricore/
>   F: hw/tricore/
>   F: include/hw/tricore/


