Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B03ECDE00E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2uo-0003IN-PM; Fri, 26 Jun 2026 05:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2uh-0003GR-38
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:32:01 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2uf-00015U-IK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:31:54 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6647bc8f900so951033d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 02:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782466312; cv=none;
 d=google.com; s=arc-20260327;
 b=TH4l8VKzsE9h64PIlIm5JHO/T8RpFJfjPPtkQaypJQd/PNihnvXwhH9/YSsOgQcq/5
 Brk1j6MSnbK62Be0F6IIZ6dJHTbk03gGOcervaAiJ95voiNs+DADCwMgVgbdhFXKGbeC
 Y4eM4kavYhhydyqEvBvckiDt8WoY5xA4Xunnh9t3H7ybC343/cHedxvhzc9yXpYFwttb
 Q5KGcVvNfZbbc2xAyuy4CqEBaxRMfZsFpDyoS0MrOseNejXDHEollA/eht7JuJ/+lRFL
 EOF2biy//MbcMnBIxnv/m1PZn+copFovipw1yp1s2+SMPFUMNjqCycOkU9cR+hN/6BfM
 HiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=anzMaGLv3SjUYf3ORAILJUaQFKa6Pr43gCSes0FQBtU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ALC+I4yBAIqoBpXUOuFm8Jqgd+vvsrLocDXNaUlWP7WkfRXcPBLrSQLm6Qpyd7PyUU
 CbYYxYETffiD49t04LwzLJjg7nUDi6dZ43VuZl5k3exkZKXijjSaDVmiMpAtLQeomdGY
 Bm5yNRMC3duuaBz799TJccMKci05Cf0IOjeN61LtsrqKwEnW+5fwMhAALk77lLT5VnIz
 iUF7R+RdwFv5moL14R9gxma9HeX205mBl+VfLoMNQMwwS8cE9jima40n6erBpgCWyXBK
 cVc+AOe6iRsBWk4EPlkO63drkfoy7oZfxYFM6ip3pHXhMemhrb7ldtKN7Gl3yW4cedx1
 T+3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782466312; x=1783071112; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=anzMaGLv3SjUYf3ORAILJUaQFKa6Pr43gCSes0FQBtU=;
 b=nurDVeQKuv2jrbxnfn+bmX1xCj9VBUUmxANPQATcbRqzfamUHRnVWiW+EQyOouqQgZ
 5AEgWTy74JUG4R8WtkCc2J6pUPT48vSVKdaDz4bByzhVJs4hPL5+E7yOPMs5jqYqb993
 sVq3Y7nLySBvM5ixm2VRuHWbMcAsSZkr/WMv0Hxh5SGjyp7RA269NWZFkq0BZZ6GrbXP
 Bvi83vLBWQU8jrx3j8yN0C2CNSwOvFvrRxhobf8pySwcv6JCkEQFDRtJvv3DhVDhpbJM
 5U1vZCZYQCPZQBQMnf18CPQX2gY10/XG/2Tl4jrzJUdYXV0XUwHfW2pzmV52zlf2Sbpz
 PFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782466312; x=1783071112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anzMaGLv3SjUYf3ORAILJUaQFKa6Pr43gCSes0FQBtU=;
 b=T1Q04voLkQKYH0cTAVybGvckKaCBsdBsQpNrU6c+9wt5ofug4Y+dAvz0RBT9knF+oo
 rJRbyIlA8q/p8LvnX74BOmK3jwoRiiDk00cC//4e/6tyqOmmoeIfKUbzbDyffuUDfhAF
 ebyWvVKt65QxZAYabKzvCP+pXas988ldd+/9ej35Xc8U6Z3cJyGRQzCXsJEU63Qxj1XQ
 sJMT8O7VPLT84x0x90JtZYwfw8KBc/01Lh9f4e7xu2JAqXETh3hFtrzyQhA3g0ui3YWK
 zcDsTLsk6QPgAtE8ZMze6FwHRp6YIU44pA8H25oVed97VFH1uLp5tnM82S7hV7Ml09Vb
 2scg==
X-Gm-Message-State: AOJu0YwQmluATlNatUuGBCwU3yJdQykzvFyx3j8gMQOigptnzaCFp/1P
 42lWvFVJen6wDja7FPW7C9QPbpYI6dNMQeeh/Zwx0JnlSl751PPUbh6fph8C8kG2T3vNfLg4tKJ
 zpSWa+rbdsoJK8aQvVq3rugmd1iqi4Oe+E/LboQm2oA==
X-Gm-Gg: AfdE7ckCGpdIKIwpHooaEeKXjqk+Zagyqc+an4ghqaoj1+BrykDxRdkHFKbTEY10oqW
 akKtw2WAA85/GcXscZil1XngNAMrrJB0Id+Ol+A+XKXil39/k4opL3oldnBrapXd/300bEqeEbs
 zbEVcJqmV7p4v85/pGEdK9mM0hgQhJugME9Uo9Vma9uhJ6fC0sNYV9828yoPAjy7nnz9KFZf4Lq
 nBSYFFEscOd0s41oTk26vOq2M+IYnDxpXchPaX5tqSJkBFslKLI9f4QXLDN61zNksbP3pniiJ4c
 yLL4ThAbUxhzZr6NOZFbVSiFT8I1CZt1MtFvEk8hfsOuM6PJ0Mp8na43
X-Received: by 2002:a05:690e:1207:b0:662:f28b:7c63 with SMTP id
 956f58d0204a3-66487e77653mr4688202d50.63.1782466311977; Fri, 26 Jun 2026
 02:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260625224723.766270-1-richard.henderson@linaro.org>
In-Reply-To: <20260625224723.766270-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 10:31:40 +0100
X-Gm-Features: AVVi8CfBEbcv0T26ZbVFGbyX0iMZQwkEPA02gc_sXbTNkaF55yYv5OkVlccxgMk
Message-ID: <CAFEAcA_LE9O0Ax0AKnsJi-7FAxfmcLxxSYrOTUU-VYmgJEaKEA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Implement and enable FEAT_SSVE_FEXPA for -cpu
 max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 25 Jun 2026 at 23:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -1373,7 +1373,7 @@ static gen_helper_gvec_2 * const fexpa_fns[4] = {
>      NULL,                   gen_helper_sve_fexpa_h,
>      gen_helper_sve_fexpa_s, gen_helper_sve_fexpa_d,
>  };
> -TRANS_FEAT_NONSTREAMING(FEXPA, aa64_sve, gen_gvec_ool_zz,
> +TRANS_FEAT_STREAMING_IF(FEXPA, aa64_sve, aa64_ssve_fexpa, gen_gvec_ool_zz,
>                          fexpa_fns[a->esz], a->rd, a->rn, s->fpcr_ah)

The FEXPA feature gate also changes to FEAT_SVE || FEAT_SSVE_FEXPA,
so I think we need the second argument to be a new feature
check function aa64_sve_or_ssve_fexpa.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

