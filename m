Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B02CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 16:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ6P9-0000Gu-73; Thu, 21 May 2026 12:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ6Oi-0000FI-Q3
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:37:26 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ6Of-0000RG-Oh
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:37:22 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c396d3b36so6511037d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 09:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779381440; cv=none;
 d=google.com; s=arc-20240605;
 b=N0gOISAFQ+isyFzjeDYr8FE1NziudLEtlFLwpjea7cF7/aVdsPy2J59yDlBo9UoTLs
 01s6Gyd1V6Lbx19VU02eeUnyqSci2Nayr/+QIJw6/UBy0MtM7xnXV8cDorc+ksldYFNi
 Js74GEKGC4oTzXQzrMEoT4D8GeLgOVMdr6QoBgllwNnexyFDPXjgFC+kzDOFEKpbPFyX
 230vGetX/GcbluCp7lLUb4Pp2FCqlsFY2vFCPyL70ZnYwxhnf2MMYAyFOez5i/K6++6d
 K8dOLzrOpH7XJGpkmSAseHBbynuDiIoXMCJ4MSvC8NMzEQ93p0K7bQTacg+EZ2rWLbNU
 NYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lPk63ZgkDrbHPWKn8uD25iZ2a3WZoMh5W6q3ucoaSgI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Lnd0Rf3iOkJmicm5K+Qd7aMfWjTt4RWEtNSewmIr9JilkZUrW+R8Xn/It9AH+/KaXR
 hQ2LCY+LZVUw2ZcVsxXXRgjy/OEO1Hbva9zqu60uTqRafT2HdZ9ZvNxn7qs74TLC25kA
 KC0IjsmvGSPTh5o/X4pwXK3R44MzYKrpThs5nsLri0lIZqRDDZEm9RY+wzLwL8jPyg31
 EdjfcdAliGyHi6EiPgyQvbEwjso5FKibEo/vmNweZfS3UMEWGZbh/w8SQTjmd7oQK0Jc
 2wyL9DBtqXWjn/LYoM7sx3Ccmy/wtdkjQcdOjQukUsCD8P2lWNtm/CtGnj0W3htrik70
 5x6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779381440; x=1779986240; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lPk63ZgkDrbHPWKn8uD25iZ2a3WZoMh5W6q3ucoaSgI=;
 b=KjprvUXl3IPkYVTJZQug7gxqBHW4DHaMbA34axFWN0uzLDQq/dG3Fv8m5os9nxqgeq
 EypR8oG/4on4w9asx1fttdDEk8pz9rgdNxi59lYkyp3tyN2o/HZzxkSHwXBLH7CjjY2G
 sUq8cQJg4yNv7dUJoxxI81RO+sOeyQ2fUFn1iYWGofjZKXbsSSHGMRFcuMzmo+X2GkbC
 UdQA8WecOivPQS8YGbxTXI7KcMX1jSVBBI22r2QiOyJgI31rGmI4lv1iwiC7usxe88c5
 RN1y7Sq1TSrKnGu1mtokFeIAzh1l03MS/nKPipHUDFx9qMCu4Y1gz1TGKHIhHX2karKu
 gsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779381440; x=1779986240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPk63ZgkDrbHPWKn8uD25iZ2a3WZoMh5W6q3ucoaSgI=;
 b=MaVki59j8UQFs9y7aitCqntnTG/BVi7C2c9oXnzfmvrBKj4NLUaUgMKOGDJbbkI4hW
 pjVqCO92NGbRN1jRWjLomAXe0eG/EZINWrSsbfarVSx3F5rjQhSogNrzc+qbFbt9J5yH
 kh0G+dAAD9pyCvY/tX7NOpD9Tbkd3lR4ZlpDVAzUMZj90wTI1I+KzorujwinrDoiayng
 bXFiPkjtGC6dsQOyEAdIO8ZhMPyty8e7BbEyiKre03W5M4sUAgf6eEyg33padYCjiIB7
 tYTCH1QiWp7mXlcQAFxyUHYEtPYC/KboruYWv8CfJ7GSgnv8WZDwG39WvPXeGMpyShfj
 m7LQ==
X-Gm-Message-State: AOJu0YyhGdgixC57DF+qn3LI8WtlXpMEvVR3xWwZmFOOeCpmR2HmdZX0
 uwVmdY+z0JUgkiFQLvarOo+yn+xkUg1mwqGmarEoAPTTO6tBdnUI0zMHSyRC+bc9/NZBn92Lqtn
 GqvdAFfjumjgKTJ/7PCfBxU3J6icqs5mFcHnxxpB4CQ==
X-Gm-Gg: Acq92OEwnCtlWGdAFW/tdi+NOswG6o/4Htrp/Gbl9Dj8ipm82PEIyNQrh1KgxKv902K
 lLoYaupkAG4mP1TjlaUv8z+OHeCpi1wEspwLDlgbfsTbDkjPvrTSmJhnS6s6a3ULEXhQhdjIbgH
 jVV/OxaPSXC/wQvMI2JgnuW8akFfyKuusgjtaNxB+HqzdKcmHLQFWK5GipmK97Dr37yzM+m6GgK
 IAV7WOVlIkalZpIhZ3/GbD4m/F8gYZjpYCfg0ziTFxrGWx/d1U9b+x5lQZuL/9rSFUuVMq2BY/R
 DT1ChcRY1agE4uBP9UlbTI775EPmxcZ8YTGbDIuR1fXq1FQYg+XtcsMFYnORHKBBXPU=
X-Received: by 2002:a05:690e:d41:b0:65d:f5e7:72bc with SMTP id
 956f58d0204a3-65eae285998mr2836834d50.22.1779381440283; Thu, 21 May 2026
 09:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-26-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 17:37:07 +0100
X-Gm-Features: AVHnY4KBGBEpBw7mn0glej0bkyHCRQ4UOnweT5rW1LsUY9rlG_ILUPH1JDEz6R4
Message-ID: <CAFEAcA-fwHraHrEuGXeDC93bctG7AAq+gv8Ew39OpR_6wzpdTw@mail.gmail.com>
Subject: Re: [PATCH v6 25/64] target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT, 
 BF2CVTLT for SVE
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

On Wed, 20 May 2026 at 19:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  6 ++++++
>  target/arm/tcg/helper-fp8-defs.h |  1 +
>  target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
>  target/arm/tcg/translate-sve.c   | 23 +++++++++++++++++++++++
>  target/arm/tcg/sve.decode        |  6 ++++++
>  5 files changed, 52 insertions(+)

> +static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
> +                     gen_helper_gvec_2_ptr *fn, bool issrc2, bool isodd)
> +{
> +    if (fpmr_access_check(s) && sve_access_check(s)) {
> +        unsigned vsz = vec_full_reg_size(s);
> +        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
> +                           vec_full_reg_offset(s, a->rn),
> +                           tcg_env, vsz, vsz,
> +                           issrc2 | (isodd << 1) | (FPST_A64 << 2), fn);
> +    }
> +    return true;
> +}
> +
> +TRANS_FEAT(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
> +           gen_helper_sve2_bfcvt, false, false)
> +TRANS_FEAT(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
> +           gen_helper_sve2_bfcvt, true, false)
> +TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
> +           gen_helper_sve2_bfcvt, false, true)
> +TRANS_FEAT(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
> +           gen_helper_sve2_bfcvt, true, true)

Again, I'm not sure if this gets the "only legal in streaming
mode from SME2" logic right, but otherwise this looks good.

-- PMM

