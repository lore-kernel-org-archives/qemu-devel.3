Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB177CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHUv-0007ih-Hn; Tue, 19 May 2026 06:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPHUu-0007iQ-2w
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:16:24 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPHUs-0000yF-Ac
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:16:23 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c52bb5dd7so3228931d50.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 03:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779185781; cv=none;
 d=google.com; s=arc-20240605;
 b=KTZmMj+k0a+2NbpQeqhnoqu97x2ejJwPSMORqP+QIKzdhNJfMg8RlxMo2feQHPzZgn
 Wu5QsB9Mr/smeqcpmzVxnn6FkIh4ODWJT31GqIwPaizkBLyxnWr1I0OFg06tSwN5wXbr
 OTPAqSMmiokoVyF3+7+vIynhiBmgMbL4bRcJN3OmfjKrcBwLvTsj7ltqpwbsJ6pCXhSO
 hYlmqUbU0/9rryPU9h4/DOS/EeYzumXpJGWnzZrcoyg3Aoe1dZL1FTUwnpXpY5YIcDP6
 lSpXsQMNNDwlTHW4Kb1W6OMoG3pSyLkRG9N5Y3iXRTCQDw9lxAomnAuXYBfhtz8amS1t
 icAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yTyx6icNp+PtefdG2rAba+1ZkoOV/jBRopLskuSBbkQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ZyVh/ZwbKGCxTXKKFdQckvODV1MIf0XRAx/6m9WKJijU9bT++lm125/GRfwJ7JDmzV
 Clwh8eDXRgb9N8soYhY7VLzIVXRC+SbgDHeAp/0gvCVfjvmHP8MPvDKgIRoMTUHHQIbV
 I72bXMLjKmB8y27DmuyzMxIEKNumoiJ9rABHhHD4fwcQTyv2BIKVJTjtS3Yzc1MdejpQ
 eNB86whkGCmv2ZqOJspMzZWjtmlNsGT1s4FNObhrzbr5HMvekMfwNi9OVhfSO01u5EoC
 bkssczWV8KZLqi5J5iWM/lvLiNwuOqVlcDNR4BOwQXpahhQ1mO1a5CVEg/CWwTimYVtj
 kpww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779185781; x=1779790581; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yTyx6icNp+PtefdG2rAba+1ZkoOV/jBRopLskuSBbkQ=;
 b=jMdsodI4Ahsfs2eLOlIjgneCHQK9/jIjQkBeghbNigNqRykE3699nOKf47w3QqaZE2
 RZsBKizcfo6m9ZdRGsD8w5nPAzaQYVfav06fPNowxGKQGktreI3IeQvrqWRhEI3d95V7
 3NxZjjwYM81ENEQpQC6MK4VGN61cyUaxD5cWjNGCfm2cuKA/WmFVM3H0yhyp0Zm4NZLc
 yqaVczBnbiunfzR+XtLEsRhDG+/mwSPcMbzNPwgqdjC84Bkzj+MpToxFef1W0FScIGiz
 LIklZkEEf1w8OsxwPpFrvZ8hQ2ekCw+HVN5iw1kdPySOaSqRUiZ+rpSmbeRr2dfVujA4
 g4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779185781; x=1779790581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTyx6icNp+PtefdG2rAba+1ZkoOV/jBRopLskuSBbkQ=;
 b=kUgfIsiGq5ltToQA7G4nJI/ITMal9lKgeHonNZa82Fez7FZR1Cc1At28E2mK1FO/jk
 rOz/BsyMRsodVuBDN3C9L2rI4FK1b+Dfoyuax91fK7/dS2kcdDePpFWX7CM5KIVF8ER7
 UoRMxLidxslQtArD+6JOWuYeMKYzCOvQtxryqnkbPlZcxIYy9hQkQmsHo5ETUv7Key6K
 yxOkUu7Rftj2sV269b0RYuKOtCZEiTGkDXjDpBsatxu/BwYhTNy2Zgs8rtHsitxsvu1s
 vB+yf4Qo6n9OKe3kdmyrlqsPZO4SsjhQWEyoBtdscI9YfFO1v6lb3S5WVNQgxFF8iBzE
 mPPw==
X-Gm-Message-State: AOJu0YyO3qqOZkUbqISUazptz0Jn2EF0KT7rDk0+ZBPuWhNX1mjYrDn6
 cl4a/hoXubJdelhQqmF5qInMqv2putopdqM5c4OFEehIY/+LtwhFNyZDe6D1OKxI3Zk7ipI4rmf
 wfr5AvV0uGOq2yYa5DDUqZKnjZdl2iJLRyArLPIGQXw==
X-Gm-Gg: Acq92OGXdxwMoONCIxdhpVYSfd4SFAR+mPV58EME94vxU7wAmNzsCdfSuSU+mgZVll2
 uvR9Eu+b4T6vTQmoP4lSIiEWgh68Kw6mUpbOd/IHBXD/oRv4VvJ0Uu1vTUtBUQWNaLsQb7jodvx
 t30UJ6twVNN2dAwBhrbSMNfJc5l2SErzgV/ThkY5AwSfz8qy5OeQESb7G51oW2pPI3im8XWKQKq
 ODamIu4DLFRUy8SymGSzM8jjndbtxIqWkRmy9E/MiFUb0lFgxnJg4X515lVSPMm9WfYmZenY7ox
 fvG8SNieBTS4IT9kB+grox/tREQUWciIwCB7eQd/3FqFJ8Ccrtbe/nHWqU686ZM6Kxg=
X-Received: by 2002:a05:690e:1501:b0:649:ed08:1a01 with SMTP id
 956f58d0204a3-65e2284594dmr16999700d50.35.1779185780962; Tue, 19 May 2026
 03:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-31-richard.henderson@linaro.org>
In-Reply-To: <20260517003002.321430-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 11:16:07 +0100
X-Gm-Features: AVHnY4JDvOXrMutrNiQb5KflYANEe1wst8LCHWwryIQ8TQfuHyaLf78j3ooscGs
Message-ID: <CAFEAcA-q4GdT-uawv-hw6j9ixdO=Nw60hkJ=mq61G3CxRE5t0w@mail.gmail.com>
Subject: Re: [PATCH v5 30/63] target/arm: Implement BFCVTN for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sun, 17 May 2026 at 01:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


> +static uint8_t fcvt_fp8_e4m3_output(FloatParts64 *p, int scale,
> +                                    bool saturate, float_status *s)
> +{
> +    *p = parts64_scalbn(p, scale, s);
> +    /*
> +     * Saturating Inf -> Max handled in uncanon_e4m3_overflow
> +     * because there is no infinity encoding.
> +     */
> +    return float8_e4m3_round_pack_canonical(p, s, saturate);
> +}

The E4M3 conversion code doesn't seem to produce the right
output for an input NaN. This looks like it's because the
fpu/ code isn't special-casing "there's only one NaN value
for this format". Here, if we input a QNaN the scalbn operation
will ignore the specific input NaN and return the default NaN.
There's no special-casing of E4M3 in partsN(default_nan), so
you get a frac value that's based on the default_nan_pattern,
which for Arm has the MSB frac bit clear. Then in partsN(uncanon)
we just move that frac value down into the right place for E4M3,
without enforcing that it really is the all-ones NaN.

I think this should fix this, but maybe there's a better way?

@@ -519,6 +519,14 @@ static void partsN(uncanon)(FloatPartsN *p,
float_status *s,
         case float_class_snan:
             assert(fmt->exp_max_kind != float_expmax_normal);
             p->exp = fmt->exp_max;
+            if (fmt->exp_max_kind == float_expmax_e4m3) {
+                /*
+                 * E4M3 has exactly one NaN, with the frac field all-ones.
+                 * Using the frac from the input NaN might result in
+                 * a non-NaN value.
+                 */
+                fracN(allones)(p);
+            }
             fracN(shr)(p, fmt->frac_shift);
             return;
         default:

-- PMM

