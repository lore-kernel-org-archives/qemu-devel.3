Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10849C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCQu-0003qZ-Ao; Mon, 29 Jun 2026 09:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weCQq-0003pf-F4
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:53:52 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weCQo-00033V-KN
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:53:52 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-664b3831a20so2603351d50.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741229; cv=none;
 d=google.com; s=arc-20260327;
 b=MngTrg28xPRw6vgnPuEwv6KjQp3wl3kFuyUHrhXT6mVFbNLtoLo7pAaK3pwVQbfmNb
 iG+WjgQsoV3gMKiJz/bNpIn2zqiaX2J9sTmlFE/Sh+ta11TdLrR9mxErHdXanKiGrF3B
 3PxtFONhs5kuoaq4IDHNqatY8DmHDFHAkcfdAWktTO6GpNs4ggcee2DdI61Cne1wYNU6
 2LVJQ+xikGYew/e92QgomTSMbGbcn6F+k5bpkagSiPKlWFjZHSlqye83sDI05ZMrFmJo
 7iqTfXdgphUG1gBDCeRRcOO+KnEs/PhzQLoABTPx/PL4/PBY0BcJdrBnyc3CJi/ZU412
 zEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MxI7l67+ARTiQp2Dg96U9G6lCaV1NIe40wxMSlk72rI=;
 fh=xXUECa7x/m9222uVR6doJyAafWA+wMRf05AlemDJ3Gc=;
 b=ZoTusxhxRdCGQRR103jVMaHogOcYEb+ffWILgk0ZZr8V644T5nl0PuYYoQfLz5z72L
 nuOrnDs4z1qT4+GZ4pj36Q2SeBuwZjcp8I7A3HbSUvvvg4eiMNEQ8zRlROFYRjzhbyVo
 lFRnocGkeeUhUgCptQ997jU5oCFvbVW3d3M8L6x5ZqAIQA+NtQmFvIKUwlTJ3Aj5C/YF
 o3oihPIZz1gml4iiE9czSb7v1kPUm+65czNwt5MsuD6Guy7aAE3Ai0nZ3KBU4ae4KeaF
 CiE3pnQS7r9Q1MlOKxt9da8WkxX7MlbEO/maS6212aLunMupdCoESeovb7QBZ2FpizFb
 3skg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782741229; x=1783346029; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MxI7l67+ARTiQp2Dg96U9G6lCaV1NIe40wxMSlk72rI=;
 b=w09Y4/Ge64Qv2e5CRj+EVVuyJEd292NaEQSThEHX7kDc1xD92ATJNASB79DRdNXnnA
 88bGq67/m/mPVDnDhIAzDgdk3efi0u4n2H8AlwKhZc8USNGd2blS9gJYYhaAK7tt6HJk
 Q0MiX5AqanyZypnEzTXrnBfaGA2N/rWYDnLRzIXJ6qI0emgO2ctqKTZNHoevBLnWzr1e
 xl6pkhHo+v/DGv9Lh5J1tIGDbXkW7uhnsKMkmUQtCJxgCrfm+4q5Nxt0fyFnmqyJk0sg
 mRh4/ti70X1MM1lfzFpeJwKOFx+C5dE9KLreKFGKJajvB7dDslRrVCS++oP2oRtg/Zyu
 aG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782741229; x=1783346029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxI7l67+ARTiQp2Dg96U9G6lCaV1NIe40wxMSlk72rI=;
 b=dvK4fD7UOtbCAt5hTP+EykPCfEIeH8Kdg5kun9vfC//kY/fANSPcuY5oTfOqtnrHSS
 wSrozR7HY25f7Dfice2M3+xDjxypnreLvO67jLlm+9n1kSSYJ+IjD+HeVOrOasfaZWOV
 7HLc6KMBq9vSVrkEaP9tpbo/tyJ1i1Xa581o9pGAWXkDwEVKTIKquCGUGRmddNkgcV0k
 TkA+/TZCUcZrFlTy5/PlFubrMEoIgDWhrgtls+WZLYf+QNJc0J7OAdWYTypTmCatNaLS
 iXSv32q/x47mQeNTkQjhSI5gjBm/UK7XEbQlpzkLCmRvGZtw+fIU+C/S0gRYzPcWPrn2
 8j6Q==
X-Gm-Message-State: AOJu0YwYNzca1PHQarCb6yKoEhgYTh08bsydlVKsv9b3lwzQkxp7vOcN
 JLg8mX1iEj9IFfJe0XV4gZbjoBjE5v2IIy2hNu6R6J30JBB6nqJ+mMZxwwk5JH/0FIEdfDSwaG+
 4Mpr9EhyLFbYMLwNa2zjByd107JLKRNVe32Hbqy3Aug==
X-Gm-Gg: AfdE7cmys4zVe/0j2GVP+PG6eWKAo38W5liMzQ67LaaRjMPeGkvXZbaMnQD3LrGVY2p
 1MgiPXgZH4k0j3VLRpJb1WMonCbeDCwArEnKmEWsZixDmlBUkWuMJ6ay0lPSGOT39nszQaJd7xO
 gxcoifWUe4CejjnLVZU4q4wr9A/9K0boPGHr8y0wJjPyKkCuf6l6QA+AkfknXJDumHF3Tu3vlWQ
 bMJRgeKyPjieBh2tq+FPvVRQYJNnzEjtbdb/2WU03VkYQVViPLbOBOU+A32mbP3C7LXqwkHIuUS
 e295HOaLLNQ9PytIdrqEloAE8E+XynSXq/NXTfca0IDBGIyxYZpgLVV4
X-Received: by 2002:a05:690e:b4a:b0:664:ac17:6014 with SMTP id
 956f58d0204a3-664f60b3266mr463127d50.31.1782741229154; Mon, 29 Jun 2026
 06:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <rxuL-6ZdTjc0-X6Ez2rU4TPEObWUUb4HjRf6X2__bLs3i-9N2d5NX3HbQK2Zyrh5V2c1szltCX91cL-s-WHxX1XoBDSyx5_m6FCvmBmblIY=@proton.me>
 <ad4b1u-MEfso3miW@redhat.com>
 <0NssTF_XyAbzwx4DB1ecmeaWsoqoRMwGSrf6SCVUaBsAR3aN_FinUY8ucoU3PrTya2Jdf09HrEMWR9mwdFI0HW_ZF6SBe6gi6aIgrVpZd3g=@proton.me>
 <CAFEAcA-BW-W0tD=_Cy6AR-E637h_Ryo0JBTHTzXqB3o3f71Rxg@mail.gmail.com>
In-Reply-To: <CAFEAcA-BW-W0tD=_Cy6AR-E637h_Ryo0JBTHTzXqB3o3f71Rxg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 14:53:36 +0100
X-Gm-Features: AVVi8Cdj7cy0fg1useHXpScEewKdutw6IrQ3pEum1zg_5BVgC29D2znrzQdxjhs
Message-ID: <CAFEAcA_D3u900UDM5dzPrMvs1CF_XJD6HdgnKTvHXa0H=ysSbg@mail.gmail.com>
Subject: Re: [PATCH] hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()
To: Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping again -- are PPC or net maintainers going to pick this up?

thanks
-- PMM

On Fri, 29 May 2026 at 15:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 15 Apr 2026 at 05:08, Feifan Qian <bea1e@proton.me> wrote:
> >
> > The TX Frame Control Block (FCB) is prepended to a TX frame when
> > BD_TX_TOEUN is set. It contains two guest-controlled u8 offset
> > fields that process_tx_fcb() uses to locate L3/L4 headers within
> > the frame buffer:
> >
> >   l3_header_offset = FCB byte 3 (0..255)
> >   l4_header_offset = FCB byte 2 (0..255)
> >
> > These offsets are applied without any bounds check. When the
> > UDP-no-CTU branch is taken, the function writes zero to
> > l4_header[6] and l4_header[7]. With both offsets set to 0xFF the
> > write target is:
> >
> >   tx_buffer + 8 + 255 + 255 + 6/7 = tx_buffer + 525
> >
> > A malicious guest can therefore corrupt up to 509 bytes of heap
> > memory beyond a minimally-sized (16 B) TX frame.
> >
> > Fix: reject the frame and log a guest error when the minimum
> > required buffer length
> >
> >   8 (FCB) + l3_header_offset + l4_header_offset + 8
> >
> > exceeds tx_buffer_len. Move the l3_header and l4_header pointer
> > declarations past the new guard so that out-of-bounds pointers
> > are never materialised.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Feifan Qian <bea1e@proton.me>
>
> This bug just got re-found by somebody recently, so:
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3517
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Jason, are you going to pick this one up, or one of the PPC
> folks? (I found it didn't quite apply cleanly for some reason,
> but I don't know why as that file hasn't changed in ages.)
>
> thanks
> -- PMM

