Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAB3C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxph-0000yQ-TJ; Mon, 17 Aug 2026 09:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvxpY-0000xF-Aw
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:56:48 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvxpT-0004WJ-Bf
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:56:46 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-836c8bdac50so44503877b3.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786974998; cv=none;
 d=google.com; s=arc-20260327;
 b=ewpqpsaWHoiGLUjKrujEz9sHSb5AH1UNPNA5agP39BRD3sjnYFDR+SXd4aKqX6KUQb
 12o3tAqYVCgMO/1P5n4VwyLtGz6FieZzykVoRFqIvzDvA4vRLnZNz+c1Ox4NXHygcQCQ
 uuVZf8T/P50m8uDbxgkvzzYdRyNY4AFTc3oStZWuuoB0CmI1FQ9ryurHdQSG0MtGWrML
 TRsxS8fT+DR3DF8IRJaHoMRbmKoBs+5AdmomXiLoPqXciIioYTrpN8E+XYEo3EUwLBOu
 VhwblTy+u9xC5RhHEq8RYdEL/MR4Fwf/UjoVLWVFJ+yGEgnuWVe7UCwIot37XeyWJ0kw
 IMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QyuIcO1Yg4qfv1c2aYPmYXGMuYlX/H9PVinchfs/+p0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=XKsu1Dk7ceSCKee040YmYpzVifaMmQrWdg6US829ZfRl8g+7VjTsrb5uRqZ6UoZ8/+
 m7CroObyqt2hSXBBAWm0cYkIh6pr4RQpcmWTxlIrW1SBs9krSAIRw+ky8QFFCL/kZVFo
 vuAb7kNmbAO8cp61T3bd/Wlu+SjwJdg87opjg/l3H2tRujh8WEvbA5/5RgRjF2uyO5+R
 CEG9nSkaCmjMurt264aLw1/G1NpGTB88JJJ9/0TJbqJ1Kdq4/0BV3pFjLR8kmGKn6P6G
 lEiwx9GQ911qxRCaaTk5Kv1EDVKkdzHyS4qY5ALDkrl6QGiP9KuVNERfXvVNvypvnUzZ
 gL+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786974998; x=1787579798; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QyuIcO1Yg4qfv1c2aYPmYXGMuYlX/H9PVinchfs/+p0=;
 b=D1hQv+WbBmtpGfXFFPbhl20cLjosF04e6MrxPGSTNscHYMOQWfXN/V/YHWibhlOiIL
 xQ5iAQAzehhzAr9B6uC6z/Grnd5duL+lUTT+oIHRw5AzatB4lk9xEt5vInfBKVDd61yc
 L4hXKmFY1RwDEcYuz8g6KrS60WyE8tzga4wnE6gllEgzb8miNgU71cRcEamxeIwvsQy6
 XHWDIcU1ndagLNm1guv56T3pKfoYvOPA3x2pdlGE/0FpIAWx8bxL8dqJJ3pg4fl5fdum
 lnjx4WULhT32QDXU3JltiaWN8YHslE7BV+bKdLxJ8VXGXJFlcoWNhCdHxTGWUAdbz63n
 7I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974998; x=1787579798;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QyuIcO1Yg4qfv1c2aYPmYXGMuYlX/H9PVinchfs/+p0=;
 b=WCyL6Y+EpxtUDk6NLjE3g60HP4c4eBBLGcQSR/abhaYiD7ndtE/B3uETHBv+1OQN+z
 P6pv1sGLqc5TLkCopvJUpQ+q67tL7NnppwWsOfo+WDXgK7AOE+nWMFQgmNvC8PZfxpaK
 X6i2zcXAowsuQNzRgIod+m92bc9MpUB6ji45+Sku65/LyaRtWYpGks4kEHw8z7S3VOCL
 sq9I9pPog0Rrg+Upw7IMqgF94QFCPxCpFCeyf1afkw5/NO/UsYIcCE1ChmQTkHBsxTkZ
 JaMgNgMut7DCn0NSx+8nMGkvm8w1wfcHZh7jOXsDMrc03xRRUMQA/W2u/9rrlhFD2/6l
 Izfg==
X-Gm-Message-State: AOJu0YzyaZoOXXVP7AjugaBP56HuRISsGZbTcdgxgmRsS7LKER6iAc1/
 q8NWiQtJ+tWo6i38UI/q+Kollrhd8RVLqQMSS0qZKHj2ecbLLkl2xFYbsPH4VQk2/NyUv15JKc1
 3kIGUwgTVPX18I0Sk7GJjecwkttbBbiqXo8RqK5WUOA==
X-Gm-Gg: AR+sD12Ht4sBrc/IcRYrhwUg3QjFvf+YDkVG4dhM06EXHU+CxWAa6Z3whWOJzuC9SJM
 xM/IjgkiDpnqcvPJQkCZdkPWUkSXOcR95gXECRmn/Rv03xJc7fhY6oItjQJ+duWYzX6ckRfJ/vX
 TsNehRbmJbPEoeIQgikPKBifPw3F5sgwdUttx/5G5Wtgip75iIXiNWwgKzFdYwtqT2Bml4S0Aw3
 XqfC5P9rxOKUqotk2SJAdb+D2/VSgPxRVPOg5yX9JBizyK8tlbHDXO9FgDZkStSul0xGnl+31Nj
 DCQtM1WfyZXrE+hnqOFgQYDg7PlrX1oEWt4PV7WGJ+1vt57IxDTwddoeqW31JKn+dPpLF+f9/JI
 CRBIM6Fq7M4LdWEy8o+PIaC5rH0fW
X-Received: by 2002:a05:690c:30c:b0:81e:695b:585c with SMTP id
 00721157ae682-8412cd49515mr4866597b3.4.1786974997798; Mon, 17 Aug 2026
 06:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260812204435.295067-1-richard.henderson@linaro.org>
 <20260812204435.295067-11-richard.henderson@linaro.org>
In-Reply-To: <20260812204435.295067-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 14:56:26 +0100
X-Gm-Features: AcwNN1VZS4tJE_0DoedOdMZptRpMrncQTQd59_QRvhCQ4_WjQDriUpvNDLV3EcY
Message-ID: <CAFEAcA-xY3cyQYCvwLeFj91pMnG5FkhbgJmAYoF2VGCqssLSKg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] target/arm: Separate cpu types max-v8 and max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 12 Aug 2026 at 21:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not include v9-only features in "max-v8".
> Do not include the prohibited v8 features in "max-v9".
> In tcg mode, define "max" as "max-v9".
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



> +/*
> + * -cpu max-v9: an ARMv9 CPU with as many features enabled as
> + * our emulation supports.
> + */
> +void aarch64_max_v9_tcg_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    ARMISARegisters *isar = &cpu->isar;
> +    uint64_t t;
> +
> +    /* Armv9.0 is based on a minimum of Armv8.5. */
> +    aarch64_max_v8_tcg_initfn(obj);
> +
> +    /*
> +     * Armv9.0 does not support AArch32 except at EL0,
> +     * therefore indicate EL1 through EL3 are AArch64-only.
> +     */
> +    t = GET_IDREG(isar, ID_AA64PFR0);
> +    t = FIELD_DP64(t, ID_AA64PFR0, EL1, 1);
> +    t = FIELD_DP64(t, ID_AA64PFR0, EL2, 1);
> +    t = FIELD_DP64(t, ID_AA64PFR0, EL3, 1);
> +    SET_IDREG(isar, ID_AA64PFR0, t);
> +
> +    /* v9.0 prohibits FEAT_DoubleLock. */
> +    FIELD_DP64_IDREG(isar, ID_AA64DFR0, DOUBLELOCK, -1);
> +    FIELD_DP64_IDREG(isar, ID_AA64PFR0, RAS, 1);

Don't these two lines need to go inside the relevant
GET_IDREG...SET_IDREG blocks ?

> +    isar->dbgdevid = FIELD_DP32(isar->dbgdevid, DBGDEVID, DOUBLELOCK, 0);

...and this line is setting a field in DBGDEVID, which isn't
accessible unless we have AArch32 EL1, which v9 doesn't.

> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index cc42db9e0b..0a1a5bec93 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -230,7 +230,16 @@ to the `Arm Architecture Reference Manual for A-profile architecture
>  When a specific named CPU is being emulated, only those features which
>  are present in hardware for that CPU are emulated. (If a feature is
>  not in the list above then it is not supported, even if the real
> -hardware should have it.) The ``max`` CPU enables all features.
> +hardware should have it.)
> +
> +The ``max-v8`` CPU enables all of the listed Armv8-A architecture
> +extensions but none of the Armv9-A architecture extensions.
> +
> +The ``max-v9`` CPU enables all of the listed extensions except for
> +those that are prohibited by the Armv9-A architecture: FEAT_AA32EL1,
> +FEAT_AA32EL2, FEAT_AA32EL3, and FEAT_DoubleLock.
> +
> +The ``max`` CPU is an alias for ``max-v9`` under TCG emulation.

Testing, I see that qemu-arm and qemu-system-arm don't have
"max-v8" visible. I think they should.

thanks
-- PMM

