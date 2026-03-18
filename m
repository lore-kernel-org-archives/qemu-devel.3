Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AFA10706D6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nsn-0005oA-80; Wed, 18 Mar 2026 06:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2nsc-0005m3-Rm
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:12:01 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2nsb-0006o2-Gz
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:11:58 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9a6d7f81so6663475d50.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773828716; cv=none;
 d=google.com; s=arc-20240605;
 b=aO0LrTMeGEI78z2DMoK5LTwOPYiOgG0hQW0i3SJ5WtBa7cfrhxUmhBu3mh+OriFxfH
 0vLzR4S2+MOV5W2o2FkSo0WFi0pKWOszOEtyxuv9Gqb2a7oGCHe2xrEg0p299JxfDFEz
 rFMMH4o0AcoATEiClf0khuQKrYjpFOXcVC9JDtaxy4hSaCXTRdkZVByuya/ubTYLylTX
 NAEZAE9eFEAj8UM+iVDEnYDd1r+S5Zoe1HKIG2+Ety1/C+5wXuSyO1P+qmo+6p0mrgPn
 xphwEWbheafxx0xOPGCiLEWNOKh+T/jQkOHfQRjyOKhkG76USsgo3qWoyh6kTin5Cbax
 1QpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PWZm1lt5xPEvN0oB3gEHrQWiTrSAtfJInq3Bx1da5qg=;
 fh=imp3a1zOamCT2wVB4mhTeFcsaqSUAsHzgGZj1DD4DCA=;
 b=iA/WckGdrqLLPCa42Wh+m7ayvRLLGsUU7lbZVXrOvcbHiAB/NHoGvxzlWVs9ZLpw2H
 K4F+aW7fYCQHplcXlPWke6K2QB4qv2dPQNbcPqIfXF/HEuZT24fNMm77CcbTh6SGIeyS
 yPxS3cKWq0JzzOyI35EV7B337n4bbgJrLna0gGtQYc8tXmcr+Q5wm0nRm6oiA199v7pb
 1qVgsADM+3oECmlQag5nnNIRmmiLfF71/pfgCUs1JycyGmQO4vOtc+AlwHxh5Q2Uvj4l
 yMpEB3PxK4tpmwsy/u0Q8kEyCUVJ4Nnl2qi4rcprqpi2b4u3NYQBJPtDcfoRetZpM6QU
 nZjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773828716; x=1774433516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PWZm1lt5xPEvN0oB3gEHrQWiTrSAtfJInq3Bx1da5qg=;
 b=zq2BTSf+LVZ1uIF72TOjGzfRKGoa6nxIvx24lITHGCYUb2nOF2vndS8aVKg7u2nRg9
 UOLOzeUv9njL4vf88bz0ZdoEsavPsIiWzXn3osGznTdjwVgRFgk7p1VmwV0lPIA/LxGn
 WAY2+yCjnzDmzCs1xtUXpUVRPKLptX8rv8xZgzAuUsm0CgvZnolKNQcYWYsdn8lZ4sTU
 imOIHTNKn29ZL6olt/7xSKKr4ZbVoSyFl5bF4yFP5S7SDN6mgKCVlF42ipb0v71KLLpk
 RiCPAyNqBP91+2volKiN7cl7TcZqF3dsk2MgeYhuZHUZbrxdyMxL6vqTRL1pFXD0rAcR
 PD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773828716; x=1774433516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWZm1lt5xPEvN0oB3gEHrQWiTrSAtfJInq3Bx1da5qg=;
 b=miWiwD+sUYWLiSsfWYzZrbwZHj2/vH+yii1AJ4zma+/dcUxrFP1FikiVMSxH9oga0H
 pMmD7KgS9cjVcN0Y8fWZ54VhQk5u2qBBQRFCPA5IL+ED6UcNIfHwiDrpUOv0QFaSXE5n
 77gI4SYYCkPokckpJyCe2JGZQwCzBhBHP/aqEjBiUymvM4wgpJJ1roAoFYQGtqVkONyD
 HXFvsdEyCiiN1E9GpCXoD6SGOJ8NszZG3rwHuV0PqS40LvwySoxbzCRAKSqj9mPAUTQQ
 B39uya/CFsf7GOHvIsosbrr4ompSLrhxj5Ygli82CywC0mMPBfg7gTaKuz0Q9QgAS8Lh
 BrpQ==
X-Gm-Message-State: AOJu0YyG6+rvunJv8UOP65i3Q5A2d5qwRIuw7CN7IGu7JdLAx2BY/4ir
 ex0WZIdayiP7pnTBY5cfjCUfgAldhVt+AKovUQn87xSAOwZz7hNePZhj1UqolCSVDn/tzQW41eg
 r5FfLxYn9fMnlWNJtxqDh0TqtD4EHEbhZ90OrsoKlYQ==
X-Gm-Gg: ATEYQzytPKy+1uNFRLoJUyEWAN5QHHNiompCWxngX5WH9diUA+Np61J5+f3LM+RvleB
 RtMkgYOLzG+brNsf33+NZhM9HJHmJFe4Hf/DSEL31upNNa6Sb5Eq9mQHzl+2NrBr3ptt32Ccnx7
 0X2oHy8uUbf2Yn23khNrE+UggIxx/yH9Y/7L++OEPYP7dAfAXgejhaCcFN5WkJM9mredEWwxBGy
 6nox453qwzoo0ujbAFefHGTL8JvY9Oaf8STIxyuzPVwUXsqyY5POemPqmUJpoA0vBIOdmJBG3aD
 lmSJtgLI3FPIkk5wRb31IaQq3cNErbA69BjG9Vt9Nc2E6tL3pY/4RGV3vN02Qru+KnU=
X-Received: by 2002:a53:dd46:0:b0:64c:9798:754a with SMTP id
 956f58d0204a3-64e91611319mr1853870d50.74.1773828715985; Wed, 18 Mar 2026
 03:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260317150758.53781-1-harshpb@linux.ibm.com>
In-Reply-To: <20260317150758.53781-1-harshpb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2026 10:11:44 +0000
X-Gm-Features: AaiRm52IVGfeT9UIGyfS6geaEWu9EvlcHv1fmKjpRZoMsw-XX2P5RtM0FFb1ox4
Message-ID: <CAFEAcA8sq=pk-htS2V13qd2x=V6OzdiueqEFe=20PAP370zxTw@mail.gmail.com>
Subject: Re: [PULL 0/1] ppc-for-11.0-hardfreeze queue
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
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

On Tue, 17 Mar 2026 at 15:08, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> The following changes since commit 6667668e0cf369e47aa9dd0bae40989896e9ed9f:
>
>   Merge tag 'pr-plugins-20260316' of https://gitlab.com/pbo-linaro/qemu into staging (2026-03-17 10:20:30 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.0-hardfreeze-20260317
>
> for you to fetch changes up to a16d4c2f162a86db1f84ef0836d42eabaf57fe69:
>
>   ppc/pnv: fix dumpdtb option (2026-03-17 20:31:42 +0530)
>
> ----------------------------------------------------------------
> ppc queue for 11.0
>
> * ppc/powernv: fix dumpdtb option



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

