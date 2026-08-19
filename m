Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88DDC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwi1q-0002Ws-BP; Wed, 19 Aug 2026 11:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwi1m-0002Wd-Qm
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:16:31 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwi1j-0003pp-P4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:16:30 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc1469c1b83so1217451a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787152586; x=1787757386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DiOxDx6z4zphJMFzoXW1br/CGj5MkQxMs5otCG90eds=;
 b=K/6lrAURNDkooqv6fQ5KlA+B3BqPXsw+KXwL7BF/zoqvl8UOVC4vDmv4432GZ0FuN+
 ZaAX0CEkOSbyNyMJm3iIIz+9xasWMsEcv6F1Ultsg7GWr+0y5Lo/uxN33COcDHV1L5kp
 j0X9qjYszXhntpaRUad9DyRkwehGa85rYsbHaLj9OG0QLDF53pA6CsDU683bm9M11ewH
 S3NBZEOlD6FJcIwAIxtPXYVYmVDn4Tca5DwQeBb0p/GtSj56ZpxEGrVdbo34iObIHq82
 ioSvIi7vl0008gxve1fMOkLSsv6kRFXZNpkU0KDToWIs7ZTyiIjQrfRQUlcjH2CEpiGP
 DPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152586; x=1787757386;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DiOxDx6z4zphJMFzoXW1br/CGj5MkQxMs5otCG90eds=;
 b=V5X2L8gjkllL21XXzQ8iDz9isJ4Qrc17n1H+L+hKsJ02t2P2DNaMXAi0ANdTVitQ7Q
 YhwAmiTcEyEpvErAmsdaSenpwQlgRRERe2cxjj2UEq9g5g+065FgzpZtIVpXyXxnW8FI
 XCgn7e4HlcgYFG9Vw6rcIWOoLftM8DagBCk5aZNBBz5SVPmfbZHFsAOyS0d8tHijCGTc
 dMqzfHYMMqy5FkD1HP/tE0W5aPmWOjfVJ0HQCpfzPi2LAfZrSMZwP0shzkBuLB5jdpiH
 2lCVVo3ugwDdtJgr+Ogg3C9wPy44Wsma07MYwWcFXmPBVaVPUt3Iel9PgUzrGAHkmx1L
 uPTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0d6xbfE2+EhdhfXiO11JF3RSLUH196kq2a+ZA3pEy6PxhrOfkcoI0OW5ZeTysY+J09Qrdz3gI4hj+@nongnu.org
X-Gm-Message-State: AOJu0YyyMJaz+T/boMmQPGjHM1ZCF8pQEnf/wHunsAhYMnaDt8XpzD06
 mnbZLxTitvSMmtauLum+QKzThHK2jEC6s6RvzvT5RDlHlxKJnBki1ielLoxulJ4IjUkBg8Srzl0
 8hxyWVzI=
X-Gm-Gg: AR+sD10xgZLCR9zYVGQOywMY9Dv/sRKBOmH9WscAOmRWtVoLhlsmiVrZgg699TvR3kK
 /iXvrxmLpSlDKFfUhae++Bxa8vOoF8IFJt7+AZOIMl3LqOk28Ul8wCz/gAAEWJw5HoQkNPn0lpl
 /V7S+tuDxFnQP5lEQjkirxV+eaNtNMquVXuAPvwTrr9rjV/jUoESv6yTNt0nsB3chX4KGMyg4Y7
 mw5l3/MshyVkQC90Y7RJqCRfetO4fTIte7xqiANCfyyJx/x+eRFhXRwrfbCwqy75az1hEyZljLN
 3O9d5DsO+ipRM7nqhFE9EReOZhOP4fpffX8z0hJn5SYmMpQ4T3QqOHUtmyNyhUjnmid0PhxZ2+f
 HXg6FwuVeqAEY8hRGrXhgZxt3V3KffCOq48PdvpartB76uPU8j5MT3X5/waJnX717QGhjuMEuAT
 0JwdZ8y6/A5yTVRei81JrVLIuEQIokODD4mHcw2PKiOjhOq7YfKk1+XVieTrL2fuhnFSYLDR77S
 URgYkmp
X-Received: by 2002:a05:6a00:848:b0:84a:2c46:3fdb with SMTP id
 d2e1a72fcca58-851d3862b92mr9314731b3a.5.1787152586101; 
 Wed, 19 Aug 2026 08:16:26 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d33627f7sm807025b3a.11.2026.08.19.08.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 08:16:25 -0700 (PDT)
Message-ID: <6ba6aca5-5e3b-411f-915b-eeb0c3332806@linaro.org>
Date: Wed, 19 Aug 2026 08:16:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] target/arm: Pull VFP dregs checks out into a
 function
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260817123838.1578060-1-peter.maydell@linaro.org>
 <20260817123838.1578060-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260817123838.1578060-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/17/26 05:38, Peter Maydell wrote:
> Currently we directly call dc_isar_feature(aa32_simd_r32, s) for VFP
> insns that use D16-D31 to see if they should UNDEF.  For some v7A
> CPUs (Cortex-A7, Cortex-A9) there is also a CPACR.D32DIS trap bit
> that will make VFP (and only VFP, not Neon) insns using D16-D31
> UNDEF.
> 
> Abstract out the register check for VFP insns into a new function
> which will provide us a place where we can make this check.
> 
> Since D32DIS takes precedence over traps to EL2 and EL3 and simply
> makes the insns UNDEF, we are OK to check it at the same point when
> we do the CPU feature check, rather than having to wait until
> vfp_access_check().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-vfp.c | 70 ++++++++++++++++++++--------------
>   1 file changed, 42 insertions(+), 28 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

