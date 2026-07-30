Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1D1C55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpRB9-00030R-Cy; Thu, 30 Jul 2026 09:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wpRB6-0002zZ-Af
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:52:04 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wpRB4-0008N3-Ta
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:52:04 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-667b0ced2d3so3178330d50.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 06:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785419521; cv=none;
 d=google.com; s=arc-20260327;
 b=QdLztnoBnimRa7k2YCEY0u5XFZiJzLNBB8qyt1Gv6qzVtIravncEeLRx3YKz0fFInQ
 mVskwu4ZqVIcSR5NCRSNVH75pCNGxvaTSXtbonUCwv0rsEFglm6lRAcEutLAHURbmxDb
 2hOxHvtJ7ljflf1OBITf1fBYK51JwGBiZ+JpxFZs1prEQBNZZzVFdcMiXHHLD5G3yC/f
 5ssAb+EtZmPpWHHekJHFdfVX0CiefNpSh1B+3MofmaelIVWcFN5GMEVJES6O8LMzSTfG
 5GE+ewLR/ICKfh8qz9Kt/ydhIqX5J4pP953TgQOvRbm4ja09/uET5dTa28ZluaaI2Q2l
 xF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UpFZt6TA0GM/LcfAdzAdwRxl6RcGbMKpL4bynEkkW+0=;
 fh=weeZ+I/k7h7EVcDy63vo1ai172Vh7g4N1CNTsRAlT80=;
 b=GeD1WWNGn5EplUZJI/kJjlQFPecw6lsDA9s457AS3sYEbI5M5p3l2IL64X0/gJTU69
 5qxzfYFfVCu3oaSmq4XRv5DkOPBY3Mu3f8FuheOQwgDEfSYPxmKMSJU6faVQqLWltccq
 +rvsGKmLS1QPw7Vr6t267dnddaiphaun3ScIuWDgpI/dM9pXGBFapyTGC5cOuAlhuMNJ
 l6xOpR12qmaSoqn0hzzEAti+C52OYMtpXfifNhKjAI+ssXfPhprazGBVpibK8GX7ZuXw
 9aWa1PLqt1Qz7kwwPwkGQw80ScvUFtGoSuEgQdx4dM3wnpD0U0/5u8+V7JsLjKob7rCo
 EOBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785419521; x=1786024321; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UpFZt6TA0GM/LcfAdzAdwRxl6RcGbMKpL4bynEkkW+0=;
 b=NoR391GOghG9ePrOQiowdpUcAP3kmiN8jbeaXC3/4HwZGEu6hmBUkD+PfeLP9eTbpp
 4y0MNYxWioxQn+Yh6xG/BFOGxA9Ppec57JSzlrpDXVUIPzIrmZT2Ijmf0hvcDMn85B6W
 k2ptPdnZewKkCN2o0XRxu189CcXwMeA7gTwx+R/mN/CUXvW3xYbCA7gF3PJT2N33Wx0Z
 VI3CaVA2RR6F5wzZQ5E1LWkb0mrXgmsKlJo4tMLxkP9SuRT84byg4gorhkovS8Rvx3tB
 Wy3q8Pd0amUohkiym1b8Oy8Vc9Tpoh4HjjNwmBv/EtB0BZYF2kjOejJpftPq0aw1KlTi
 FCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419521; x=1786024321;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UpFZt6TA0GM/LcfAdzAdwRxl6RcGbMKpL4bynEkkW+0=;
 b=jYSRIQ1gHFw9zHd2aP2teJVIRCUk2mvXIgbZu9D6RT8cBOybydofLHxpcguRc9hDyM
 K36/XPF/qdZ3AhkYU/2NkLkHGavjb50CnYURupgQkboDxEjJoQpu/HmNuD9zOXZ1VrOw
 vIX9XlaCAyFe8f9h9Vg1ghu64JouMGVSGMuVdJfF6M7Ij3lnzEAcaiqW6iD/UOaRwbzV
 ayCPDcJip74lMM/pjTPDmWUckQWzTYPHxJO/XfvLO6/1WzFld7mWTO87hbfABUJtjKKL
 pJn86oJxQDahx/vkj71z23EZ+e+eJTwjV7ASxkLE0r0LTGD+zi3HQ91qwNlZe+/J1GSi
 wvqw==
X-Gm-Message-State: AOJu0Yx5SXFqOEb+pe6VzAeJy3EiTkAd4/a8W43LHn2R61ZgssUJK4da
 4i7NuDHQh/9Vq9T5tAC9N0Z265SMCvfalhHzm73MDxpEDcnIf8SwDrARzJ9fyEOdSfouPvHL6YO
 2/WwZoLZ6Bo/RWA0twwLapt70JchK0tk=
X-Gm-Gg: AR+sD120+uUMsR12964havJT535epzdHoXpwXhsDdBFuZq+EKuigUr5VfxLwZqzaYxw
 92BgwFwOKKZ+NQfhZLovXzMiKl+wen65ipouMHmvnsmLsG0zugECM9uUDmz7OACutPqAP5IijYb
 txBGjNR1oxrShwKwbCvHcB20C+JOR9kjMnQ0xFJlPhq5Yb4aDZ7nDYDeI09UDqgFvZJWy/nI4Cx
 rZRL2YiDA+h90ObaaWYxIGZEEVotZxMTujTKtC+d7C2p0jI1Z2rSOysdcer3j4Qj2yJLyWLvDIi
 B2u3hK89bIIBnjbEZcixJ1PfNVxqB6bAdadB8yh+fHbg
X-Received: by 2002:a53:c38b:0:b0:668:768:9199 with SMTP id
 956f58d0204a3-6692f740434mr1303486d50.87.1785419521011; Thu, 30 Jul 2026
 06:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260627154225.863984-1-bin.meng@processmission.com>
 <20260627154225.863984-2-bin.meng@processmission.com>
 <CAEUhbmXe=aJ+K8isdCpdFn9Y4LLTf9SARY7VaZoMo39SeYJAcQ@mail.gmail.com>
In-Reply-To: <CAEUhbmXe=aJ+K8isdCpdFn9Y4LLTf9SARY7VaZoMo39SeYJAcQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 30 Jul 2026 21:51:46 +0800
X-Gm-Features: AUfX_mywJvB_MR-3G8HG8IE6qcEWKXf9fAE416Ku7kb3TdhRy3voyOZWjtneJ2E
Message-ID: <CAEUhbmXchynHnz1Zrh=WZC4RrmamRGcUm7uGda45kUUVSrzBjA@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm: xlnx-zcu102: Fix up DTB for direct Linux boot
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jul 8, 2026 at 11:50=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>
> On Sat, Jun 27, 2026 at 11:44=E2=80=AFPM Bin Meng <bin.meng@processmissio=
n.com> wrote:
> >
> > Real-board ZCU102 DTBs describe the UART, SDHCI and GQSPI nodes
> > in terms of ZynqMP PM firmware providers for clocks, resets, power
> > domains and pin control. QEMU does not model those runtime firmware
> > providers, so using such a DTB with -kernel currently requires users
> > to edit the DTB before Linux can probe the boot-critical devices.
> >
> > Add a board DTB fix-up for direct kernel boot that removes those
> > provider-only properties from the boot-critical nodes and rewrites
> > their clocks to fixed reference clocks already present in the DTB.
> > This keeps the user command line using the Buildroot-generated DTB
> > while limiting the compatibility adjustment to devices modeled by
> > QEMU.
> >
> > Document the direct boot flow, the SD and QSPI image layout details,
> > and the remaining firmware and real-board peripheral limitations.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >
> > ---
> >
> >  docs/system/arm/xlnx-zcu102.rst | 139 +++++++++++++++++++++++++++++++-
> >  hw/arm/xlnx-zcu102.c            | 109 +++++++++++++++++++++++++
> >  2 files changed, 247 insertions(+), 1 deletion(-)
> >
>
> Ping?

Ping for review?

