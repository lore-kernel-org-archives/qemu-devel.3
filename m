Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B912CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4oe-0000SV-Nk; Thu, 21 May 2026 10:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ4oc-0000Px-Cv
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:56:02 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ4oa-000288-HF
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:56:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so67601365e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779375359; x=1779980159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeLnYydOY6C1on1JYZ0Lljl2v6DuXTKrKNciKZSkIK4=;
 b=GX4tlpdsrovEN04HK3MI6rOCYy/NvpMRdWltHgo4qoZsSwboAybjF1g5sVaxcYwMo3
 REDRiy9kAZ1A+Xf92BVTnnh9fC5eY1eVC0JoNuraG+y1RfcO/ohCE7fmMLYRMJAyJdyy
 fhMVh4nT0sq+D+RNLhrOnulbYHoeHW5IKw/d0/V/QyY7Ug+RRrRKUeFnTafc7xT+DU7D
 BdneuXcejUJrWU1JM0Wt4ZfxfsbwthYazX1I5Ha4HW9YyLMIyM2yuLVkyLcmfAAi9G7N
 lJZANwe+hevlSJimIWD5P0Pv6nqy79ZcNWVzWApkvqRbtU3X22JnNKc9Ilmx0m3/GEzR
 4lRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375359; x=1779980159;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QeLnYydOY6C1on1JYZ0Lljl2v6DuXTKrKNciKZSkIK4=;
 b=DLEEAcIjA/pr6nh9gNroRhp7ETRD77+xSx4NmkIQ3bdBb6IKv3UXoNN72Cf0SN91rk
 IFKQDCcE4hVYgUlFTeC0+gEGcVhyXUKKzUWll1bphPdreNC8hvleNr6N5Cb1wwtRVZFu
 jw1cInq5Jmlfs/wWWSXz1dzpXX7X6obi/W9FcYwJuv+fQPV/EjIpuH4T2mgOcA3eVz5F
 bbR5uptAjYCHAgV92YFuvIYZjcyWufg/9MI8tSRCfvoe2kpASsbN7cVOiSs8JXRV2ESx
 R1W3YS+HaeLhz+CYxiqdxjfV4t4q5dDSns9b4oirJQGiUMmfS+rd9IwWgTEztuA5G/p9
 az6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yrB2Gx9yb9Gt31oM1E4eMWDFwhOdJgX+zmJidZ0nT+/gM8QR5aatuEaB8SpMtsA7zIM/Ch0T+7Npg@nongnu.org
X-Gm-Message-State: AOJu0YzngUF8CMl2IMAU70GuKiUtm1qlpTDlNNZfwOs/Dxapvnze5PCt
 pWAMBD2vLSo7cedJuKpChOS+sWC7kl2d/icVIJZX6OJb0MZHSuRoGil6dK3+cjHd8HY=
X-Gm-Gg: Acq92OGa2ipHApo+AjAD3ylbDpNhfjm0FiGv0ypfb8SJUg6LKJ0A85KYB+iXLuuaggp
 2Ofh23xM46xTNacqeAgRoO08T9tjyEwPAzrKafdgmmT3UNGvFBkVEzVDDcAdR80MNgaCBDo+KT9
 om0Nj/lBWWjyikpL/QmyIWH0nu/QyEzBJGy7ABXaDHCOcyuVarfnHbhvID2weJ+RCg5C19uXmPo
 ljxQNwfDeqJQWl3cwcRn0F/eKkSrvCRrndKjp8Kgz1HnMP2yVA4DtWnMYtmq/geVafaY19NbvAL
 LsFJdWo3gV0JUL+c7M/L6Llo+rNCdeDP8CCRg1LIJFZNtI1aZr2WfYrCKuX60FjoPUd7lelpiAm
 70OIwdZ9qaxjlOnsJYjUyaPBBkywRTaBCst+QGc4SNVIWSEKP+TBcg6s6zjEgPaEBioOEDpRM//
 PrlxplnESIbUvS6TJErC23vOPjYOqjJUzjX/RFW0BdCVjk
X-Received: by 2002:a05:600c:1f89:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-4903607fd11mr43905065e9.15.1779375358449; 
 Thu, 21 May 2026 07:55:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903cadc03esm29445545e9.9.2026.05.21.07.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:55:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE3A15F886;
 Thu, 21 May 2026 15:55:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 2/3] target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
In-Reply-To: <20260521122913.1565011-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 21 May 2026 13:29:12 +0100")
References: <20260521122913.1565011-1-peter.maydell@linaro.org>
 <20260521122913.1565011-3-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 21 May 2026 15:55:56 +0100
Message-ID: <87mrxsolqb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The SVE FCVTLT_hs operation produces a halfprec result, so we should
> use the FPST_A64_F16 fpstatus for it.

Maybe I'm reading the Arm ARM wrong (I can't find FCVTLT_hs but I can
see FCVTLT in the SVE encodings). But these are all widening operations
so I can see halfprec to single, not the other way around.

> Getting this wrong means we
> will incorrectly set FPCR.IDC for input-denormals when FPCR.AH=3D1.
>
> We missed this instruction when we updated the halfproc-to-other
> conversion insns to use FPST_A64_F16 in commit e07b48995aaa
> as part of implementing FEAT_AHP.
>
> Cc: qemu-stable@nongnu.org
> Fixes: e07b48995aaa ("target/arm: Use FPST_A64_F16 for halfprec-to-other =
conversions")a
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sv=
e.c
> index bf9f0ae179..59b8c494a8 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -7827,7 +7827,7 @@ TRANS_FEAT(BFCVTNT, aa64_sme_sve_bf16, gen_gvec_fps=
t_arg_zpz,
>             s->fpcr_ah ? FPST_AH : FPST_A64)
>=20=20
>  TRANS_FEAT(FCVTLT_hs, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
> -           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
> +           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64_F16)
>  TRANS_FEAT(FCVTLT_sd, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
>             gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

