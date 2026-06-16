Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482D9CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSsU-0007js-HK; Tue, 16 Jun 2026 08:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSsT-0007jT-3C
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:26:49 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSsQ-0004Ex-6h
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:26:48 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-662b76dabfcso586134d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781612805; cv=none;
 d=google.com; s=arc-20240605;
 b=QAb5TziXHYAnES6YoCHxm9iOj/TgK326hZdLW1YTrlbFzA2k/nEbuBJ8GVZ0+M9EOq
 rG5T6ybEdxPcSKn0C7CuXO/I/ohfjw+t2cXA3HOADXIdTVuK1acEqkW8AR+OI+0BPhWl
 cxDquuB8W1VdlJBehC3ENaeMvhcaSYazeS/CWEPUpZFNFw2lTaFQMl3RdTqq69J70IL1
 Jaar/T8SjOjlxJbitlq2x1ozqIK/Gnse/1NHeIyUz2mrVytk2+4u9STJzG/Dh1gZJng2
 4+w1tkdyn9XQuSg14X9o0W8PYNKf1k5kIs6xkbxs7mZwYvbGfkRft3fnvnkedRg50M2V
 wxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XW1YIPWU0bgHm2lScKMLxzRhGW+1ykgETiJsM1WB5h8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=FILsMdH5foAL3aujy/LP4BJJSfGVOlDAFHBqV8QguPe9acvBJNUddHLYTq9zkM7S4Q
 vOrvaAPWyy1ekZux5F32iLgbxyxB/fBKFyPtK0Tcvk8C8ndHdcanWbRzgYjL3GBKXgVc
 qPHyRpMsJ3rPqHKYEcHc3IMFzosclmuwVSR0QpBvibiTSqYVEc6wOgGxOetaH92D9t7q
 xPxgMNa02C50F7tk3i0p6qp4mRezE48x3Eof/FK1TFs8FZ3pVAoiHO7KzifX3cCjp558
 8/rJrCv2KdInu8KceRYEFtwEwviFtGsrIX66NXPpkPOgqrVMoBsg0e94PQfW1B2h5fGd
 PV+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781612805; x=1782217605; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XW1YIPWU0bgHm2lScKMLxzRhGW+1ykgETiJsM1WB5h8=;
 b=NDWl+qYhsN/YYGnS2EWX9bHwG2ipVhaTFXceo9DvSak3sPm/JnfYKZnPKVHsH2J8Xk
 f0kSJlsaioQeToWaw31S9OT/acQz2v/Wx3QuR6rILWbZX70fystqJSqJy4OWQSXDqMq4
 YH2Zaos7MIYseH/SHDyZJEtaX59X/zQulUCrcIsfu4Ohd1BmvMvOlGjQZz1JrHQkMOM4
 lAZhyqW1TlcV/mIlpy20mYmDzrkqUkjd8Fv82PuD6h7+jlkh8/CcC5LgZgGA5SRdHJl6
 Gn0cjILiHEZzM7fKMQYLzXwFK13MNThKg13XVsb9I03bSqsQMWXi60YToqiFk9sNH/2E
 6upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781612805; x=1782217605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XW1YIPWU0bgHm2lScKMLxzRhGW+1ykgETiJsM1WB5h8=;
 b=kSkqoRKuRLZL53fdtAUA943dL2SSAdmQ21wTUWVuwzWIIMmqE1OUNajc/2wHBaQfi0
 LIR3DXZxvyGsnr+aW1TAelbs6EJcbTNl3r7WsJ6n7TGxZYgp4tMDJfQcb3DbidR8kYnm
 Bgg1Lm9lTMPOZXj5mmaGkzCiePbO9ygDkJX0xG3gvKY8VbB84oZPeUo5EFC41skMd0CR
 QpWHciUKDYhTTATMIxPkAeIpjLLSxducIt5zqQL4JvDN4OxdL//EdQJB4jLhCbyWjpYj
 P17VG3F/A3YtPGBIbHJ4CSBCmnbok/Zt2cm+EaR3dAjcvnlLXPx7o8mXVQ01iwD3Mb86
 E7og==
X-Gm-Message-State: AOJu0Yw4wTLxW3d+ndgfQujMcC25e1rX3t4Wv1BJju/DIrSP8yBwgRL+
 PurYH61gpeFh9hx6Rbn+Mzlatq9hRtsl4PsmFrhpJj3lhGsoh+MawOGPWFi2+sY86Xmcsrb3B3v
 m4K/GZ8TmNY18xbsZUzBF+mNZdhevRWjEfyljN2bnqA==
X-Gm-Gg: Acq92OGA9mJapm2E32+0meywxBCT8AB5DE83BbR6Qm5/y0G+2r/7WBTZmhULFfmBeTF
 ikQjTgFHDa3gFj6Y3iNxMsnnqruXNXBWJf0rWdRW1AtqwDECKe4MNwy1EfV1TVC8PP6XjyXGCBj
 aT5xNJ1osjcyE1ntbdIsHHrkarTCHTcibfKZJ8abl/UmTOhw3lfOy8iFEmqcr4WVr/f2Ekxn1xS
 OY2yZ5V7uCd+zjlnU/4HqcVMx+HE/we9OSx8pSvxDXY/wEhYH2DUdQ5s6Iax5oc1t9Uy7uureM2
 Q6ujcL0Zka5femFRslQGeRshzJznf/xymqC+JKhdnZPPOwVPNQv/D9/S5T0AzdS0tSk=
X-Received: by 2002:a53:c146:0:b0:660:60a9:2b33 with SMTP id
 956f58d0204a3-6628500a341mr10278526d50.53.1781612804531; Tue, 16 Jun 2026
 05:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-7-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:26:30 +0100
X-Gm-Features: AVVi8Cfhi__nhw-4Yg6hoWK6Xyztxz3YSauEQpS_W1qEU45LloDWZHWNsEGd8c0
Message-ID: <CAFEAcA-snZqV9wT=U8Z_WS8SLuC0Sk9SLd=GNMRTqTKMBuBFDA@mail.gmail.com>
Subject: Re: [PATCH 06/25] target/arm: Implement SVE bitwise unary operations
 (predicated, zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes CLS, CLZ, CNT, CNOT, NOT, FABS, FNEG.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 21 ++++++++++++++++++---
>  target/arm/tcg/sve.decode      |  8 ++++++++
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index e090a0383d..2e138f9ac0 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -781,30 +781,41 @@ static gen_helper_gvec_3 * const sve_cls_fns[4] = {
>      gen_helper_sve_cls_s, gen_helper_sve_cls_d,
>  };
>  TRANS_FEAT(CLS_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_cls_fns[a->esz], a, 0)
> +TRANS_FEAT(CLS_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sve_cls_fns[a->esz], a, 1)
>
>  static gen_helper_gvec_3 * const sve_clz_fns[4] = {
>      gen_helper_sve_clz_b, gen_helper_sve_clz_h,
>      gen_helper_sve_clz_s, gen_helper_sve_clz_d,
>  };
>  TRANS_FEAT(CLZ_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_clz_fns[a->esz], a, 0)
> +TRANS_FEAT(CLZ_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sve_clz_fns[a->esz], a, 1)
>
>  static gen_helper_gvec_3 * const sve_cnt_zpz_fns[4] = {
>      gen_helper_sve_cnt_zpz_b, gen_helper_sve_cnt_zpz_h,
>      gen_helper_sve_cnt_zpz_s, gen_helper_sve_cnt_zpz_d,
>  };
> -TRANS_FEAT(CNT_zpz_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_cnt_zpz_fns[a->esz], a, 0)
> +TRANS_FEAT(CNT_zpz_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
> +           sve_cnt_zpz_fns[a->esz], a, 0)
> +TRANS_FEAT(CNT_zpz_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
> +           sve_cnt_zpz_fns[a->esz], a, 1)

With this and the others below, if we want to wrap then we should
wrap the CNT_zpz_m line in the earlier patch where we added it,
not add it unwrapped and then wrap here.

(If there's nothing else in the series that needs a respin,
it's not worth respinning just for this.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

