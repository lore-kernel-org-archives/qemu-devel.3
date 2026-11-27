Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yrn6u2cF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzZf-0004wa-5R; Fri, 27 Nov 2026 12:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWzZa-0004tX-HB
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:17:22 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWzZY-0002p3-JX
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:17:22 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-677bc4704cbso9733264d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:17:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795799839; cv=none;
 d=google.com; s=arc-20260327;
 b=UaU1vymMRajyzeUvOYWBeZlvjMLx6OgVMh2cVXJ95CXTHtsojSlFS8eYxAc4OFqAqE
 c3j8pMlWpKoRjaE308IHGflPC0n7YNoJdhsVl/mXyY8FBcjM5e/VdD5r4Kph7RkmJfdk
 OKiAATjbam40OcXPaOvcvd98hgaJx184eXDYmRsGcLbyQU85aaPy7e0wwHkAWOwf9tIZ
 zFGL0Rxmyh8puBvyGjQyTghpuDVYwHKC0xz3XWdFNdt8Vmz198X9nKAcZm+K1+CosXoA
 U9oCGVZ1EbeQyBm69OQ87+5seh13BW9s0lUzBWEtsE990yoGH7aUx9gJ/MW6pXXAgxzh
 yi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zqYWPvCQdhC8VkAwyAD3mqAxOAAIJTq9mssUMtc/L/8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=aO1Lvbmik24KdKOaYmydEP9TYxsXP3ZQEXHdZqqSGqNGdWRzrFkxHlKiuqntBllpOz
 px4cDpQuRTVHH7wb0ZZJR+VLKVJlItFvCblLzKx8/srBxHsMbxSmguViEfCryQDV2wRM
 nwTP/p2YXkw4UQIBdZIN8NouD1oCbq/QNbTGl5uZ5yr78FALSdD1QM5Qi2OJlWnll0dz
 V/aftcgXVXHI1jXEe3le1dsqXx43cdM2D2ZYtLdM8rtSut2iL2wXjK+KMNZZjcJ0X+HI
 N06uPvlIODHv1joFGeEsWU2Y605D1LQ9jEJ4L+rpWsOGfaWIPgQFPU5SS8N4xCCw/6P4
 2JDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795799839; x=1796404639; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zqYWPvCQdhC8VkAwyAD3mqAxOAAIJTq9mssUMtc/L/8=;
 b=yrn6u2cFV+a0/ZZf0BXe6CJpvQKIXu3IWBN1a9I2iUR6sItRBXXUcUfrmBnzPQ3t7l
 qD/9+AiRvcqjM2i15T8qglHAJ/kePkZOmlJUBHR5XuX1dPPw9NaPLTKQfyNxNtQbj4ZY
 ljVz3c+q69JqDozby0GdQ2I2uayv/tV2JDTm0/169xR3CesRboawofpqUaCXJgH0RmKE
 GlU+5OWJjrPo/rk0cQRR6St+INxatB80Q30aP/gMgJOGDpstlCdKNBYXVRqSp4QMj4F1
 nSSwFEWZp3t53xf4sJovdOfFgpTNKGR9p+n8Lg0QaVzHQaiUbJAxa5uiUkoMEIo0q+pu
 SJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795799839; x=1796404639;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zqYWPvCQdhC8VkAwyAD3mqAxOAAIJTq9mssUMtc/L/8=;
 b=uYT4C01PnNL9yRvwix8xPf46Z3dpmn2YVVpPE+tXGKxF6G7oREcU13vb/Mrsc0FFIJ
 X+xXOIiTGvsJUCALYAqSdFcDQ5cHMG9swmF0NJogUtZa4bppJ7gs/9o2BfocHBaXU6aI
 PyypGKIf05EW3N9b6beiBNkne+enE+S+jvbGdimorlPEDMpI2/1IRA4Fa6KvN46nE/Wi
 6c5UtnIbPLe1rHCK2jYP/AlTN1uBiKtItHPRxlJMmcuQszYZBzVAqxiaFc48PMmtYkSl
 PFckP9Lj1MP50pvYrgALrCe8aF14bkU9IKwG4JOdfoBD4J2clCMfP+5iH6mMkJBpBqJX
 jBNg==
X-Gm-Message-State: APuU4Z9HkaoKI+sZPyBe/Ku/LBWniD39Rp/zQoqClgpN5PSriuRCTDv6
 pBEWZN2c/W6lELwuTNQtFJcOJfDyJKnTleVvAfei2xnEjQL2yw5RLUeK84+CzD81lM5mXuwWFBF
 goHMVS7K3QfUerrHtVaEbEx2zWmg2reWmLJNp0s5F2A==
X-Gm-Gg: AZFdTZfrML/xnAtduRNW8xr0gWXv/prN3Zr9i08ZUDQ7YfrR1028AR3nptmg+3MHlPf
 gpTreXj+fH70Wp1WrPr7fPKme+64BwmJK8Qsp0UTZERC4p3vdFimRN+YwYS0hHfbTDhmDKW3UvA
 RtTGrT4JbT2TArkEja3eEy39LlhjPMGLqVHFruvafV9HiDaSYoybW5gDyAZxmtqd/dtLvPc6ROH
 PvlHQ4no8nu2s34VmS4WJA4PqhwbkoisYo2ebP7ybA6UkTPJYBYKR9qk+Qe4NKaqKUIpB0Tr+dF
 iGK8NvfViEtixEt1dloYk/4SLQYMQ63VH+yRrMzk37kDF3ZkAJpH8lROlvzECmYS7QavgKf4eaJ
 XO1Sdx3sMs73JvZIRQ+F57I8FBa1po+sMHPWdHaoDEwyJt5ObzHYkks2quy6hQdOlpTjevSIOsc
 skfWcKVc9BZMp9WSoBkhXR
X-Received: by 2002:a05:690e:190c:b0:67e:58f:5736 with SMTP id
 956f58d0204a3-67e058f5a79mr7310752d50.77.1795799838936; Fri, 27 Nov 2026
 09:17:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030194318.319310-1-richard.henderson@linaro.org>
 <20261030194318.319310-3-richard.henderson@linaro.org>
In-Reply-To: <20261030194318.319310-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 17:17:06 +0000
X-Gm-Features: Aa3M54r8hSrW6uZe_zdKxjwKFun8OgkGk39dqVUmWGrhFUoCGdV5jF5gnlLf-Y4
Message-ID: <CAFEAcA-fgXkrRfN_pTNxoD7h+b=pr1X9OaGJzAiBkhE4PKW=LQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] target/arm: Retain btype in DisasContext.tbflags
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 19:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Replace btype = -1 with btype_set = true.  This is both
> less confusing and keeps the state separate from the
> per-insn iteration.  Set tbflags_invalid when we need
> to read the btype from the page tables and therefore
> we cannot keep DisasContext.tbflags up to date.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

This looks OK, but how can we know when a TBFLAGS flag is like
btype (must be kept in s->tbflags and update s->tbflags_invalid
if we emit something that changes it) versus it being like most
of the TBFLAGS (OK to extract and keep in a more convenient form
in some other s->whatever field, no need to worry about updating
s->tbflags) ?

thanks
-- PMM

