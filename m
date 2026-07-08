Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADA3C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whQyR-00023h-UZ; Wed, 08 Jul 2026 08:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1whQyL-00022c-QJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:01:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1whQyK-0003kQ-4i
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:01:49 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso522873f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783512106; cv=none;
 d=google.com; s=arc-20260327;
 b=SmsxktnjoROu/H13C55RqtJvyKYSB4/jI8nJ4jJtgdACck024jved9yD+62HZ/nxje
 69hdXH/HwbgfiaaXeI8BPoynvLngyzEucrqWzUEvcPpKMFRqNDLhfJW6WqJzijdjLpC7
 MECgWP+3V93IVMLY92OLik+MpKJWS2LJrpDMsABy772+2qQXqqUAI3LcBYt8qF2XNqNA
 i6NLRTLCMUAP9AtKXeB4Sw8Y9NPiRfgB17amwrjShrtyTdOrZxomkU91GCKvpp4sua8/
 e8TOpVrmqpAOC9oOJy87w4crMOHe1j894XHXl9gnxl0ossXSjcHRgveRoPj2xPD5TsVP
 qwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yaGXvrvH9bqIxb74alKCuEDveDaENMbN4XgNE0SH7ks=;
 fh=fx6CbNIrG+SMrgGEYWUFkPAR0zwPLh3pqyRAXj+FI1A=;
 b=nm/7/ptkWmBdGlK03h1fIC2UBV5uCBr0neSBJ5NCeBm7yxKngioLPB3/k+8noki+21
 ItC4URLuwJ4Hoa+1J9lgKwDuBO1sJt91TUTAmPmx9+xGJEBzSr+0e0a2itaNn1C48HWh
 UDFYCTBPiZbhm3O59SKc6ZOK5la1fSvPW6hfbWHYyMAfLLWNdckvD5EbSm7h3A27ip95
 IJveXwRuvY8M3/Pe3/ZtU0kD4fVU2VkoyzCaWtGvE3soN7C8k/hhJZmpjFlwfm2p5J24
 8Y3PaJ+4mYzWBa5khmiI+DYqcif+aZBT9JWgLZ3YcHkyHDDITlPtIL6+kH2oSFE9RaW9
 kGDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783512106; x=1784116906; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yaGXvrvH9bqIxb74alKCuEDveDaENMbN4XgNE0SH7ks=;
 b=tIuSBaK/mdTabI0Qbb1juosvC/j9583bjW8LtKSaqo3wBqvQA4r011WK3rKYhf+iXh
 cUPEzG7UIjPZ3Zyt9bs7Cb//qwKxkZARxejfeD1oTyaYqu4gJYI7LqkcYCx36ywUPKbS
 ghJ+PaIpm/mjUWO2k4W3SaTQA/V8iKKem7cbM47yRJYTXORlt0BaaWWXv9EE4Grw2hAY
 X0IPHboUAJ0/vpzXu8CxcjN5YTPjje3fond+Ad4dbsrZSvp2nGgjql8b83a9P58yWsWQ
 bueVCW8DahEz9zLnNNbDq9PgozyCXnXmEBfJFX2XEATHccF2Q0YD6Ub1AgDqY7IooGuE
 j3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783512106; x=1784116906;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yaGXvrvH9bqIxb74alKCuEDveDaENMbN4XgNE0SH7ks=;
 b=mXI9Qz+7bHHyZ8pcIfemgBpZ8FTagoZAsdGusvFL08Ia+6nzePGEO1jXvy7gbFuZ9X
 32XewmgNajLLGI8oQDfggq+T7IXNFr9rMA7MmMKjq+aFEKeWxc04R1J07bcFnGsX9wiX
 V1q1t+Xw9f2KC7yQTfYO1RtVd5H2vw71a2fIYzdvc6nUUo9MjltSoS1mzgvE2UctL16O
 E+OQ+djQ72vF7sAy9Mzq2oJ0zBIBBAWc+aFJPeJWtkfGT0Fp+gBjl4QxhTcrTYimijqq
 Pv003RfjDECpM7g/yUjmpFNT/5Kj5wCECnbbNqDh/2Czq9OIrAWO3EzyM01ALSZqkfkD
 NxVQ==
X-Gm-Message-State: AOJu0YxmqnO/bBAE2+gK3e/tiWeBqHIceldSOH4OZOQ2B56SK3HqZSZB
 X/LvFLSicRwCdlRfwaVnUHpmOZYZJjHuiSSNykKumQaoMGIEDZJ6ytBpP5VXKnkMJl56s57lAuX
 f8gnjnL5GiCRNSqkSOsl1l7oSuad1bNOKvbv1RHUhaQ==
X-Gm-Gg: AfdE7clpki2g4Q2J2dL47Ka5dg8tTdh5c9tpdnteLXGikgugUwy0tAq9XYtdOmmXMKA
 boauGOLfkyI2rcliXx0/myGF2YVh3kNw38xmDOATWZCCz40FP6PYyFZo69MTWfbusyVaxCWR4Js
 wiuhId3F7+lTisASnc4HJ9alHgcXh4BwsW29d9z9ZT09UhF00Kjbt3JCGuesvGMdiI0y+ovE/q2
 kgTmzcv7Q5TjL4kyvboB9vRfl4XFWbmsRokKywb51+QlpY9JKqNX1/Ln62lrONHjrZCtzXubNjx
 /HxytiHF8Lspia+WDv8LXfUgePHZ7gjnerVBnP9wX1WqsqJKKe5J27VwnLK/8rzyA7V7+tDv7UV
 g/6W87t2/Jco8/+iG0GAIZlyz1sv1+Jw8UrGsxp2vmBGkFnNbMfA=
X-Received: by 2002:a05:6000:2002:b0:475:94e1:29d5 with SMTP id
 ffacd0b85a97d-47df0723560mr2537258f8f.20.1783512105530; Wed, 08 Jul 2026
 05:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-virtio-fixups-v3-0-07aef1eff9d2@linaro.org>
 <99126226-5f73-4853-869f-0fcdc30c13a4@tls.msk.ru>
In-Reply-To: <99126226-5f73-4853-869f-0fcdc30c13a4@tls.msk.ru>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 8 Jul 2026 15:01:19 +0300
X-Gm-Features: AVVi8CfZIn1aEL7Gneo7nC4nfO0-JC7WLhXzmVLn-vvddjuNUMWFoN_iNuDyqCk
Message-ID: <CAAjaMXagdexkBXM8acCq7d+N51BG1qLGs-J7Ctz+ZFe2zzSOFg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] More virtio-snd fortifications/coverity fixes
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

On Wed, Jul 8, 2026 at 12:09=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 20.04.2026 08:07, Manos Pitsidianakis wrote:
> > Added checks for stuff coverity pointed out (CID 1547527).
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> > Changes in v3:
> > - Added Coverity CID in patch message (thanks Alex)
> > - Link to v2: https://lore.kernel.org/qemu-devel/20260417-virtio-fixups=
-v2-0-4a0d8636a628@linaro.org
> >
> > Changes in v2:
> > - Use g_size_checked_add (thanks rth)
> > - Link to v1: https://lore.kernel.org/qemu-devel/20260416-virtio-fixups=
-v1-0-ec14e2de0852@linaro.org
>
> Hi!
>
> It looks like this patchset has been lost somehow.  Is it still needed?
>
> /mjt

Patch 2 is still unreviewed it seems. I might send a new series with
more patches soon. Thanks for the reminder!

>
> > ---
> > Manos Pitsidianakis (2):
> >        virtio-snd: check rx buffer descriptor size
> >        virtio-snd: check for overflow before g_malloc0
> >
> >   hw/audio/virtio-snd.c | 24 +++++++++++++++++-------
> >   1 file changed, 17 insertions(+), 7 deletions(-)
> > ---
> > base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
> > change-id: 20260415-virtio-fixups-3bc3a1a1cd27
> >
> > --
> > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
> >
> >
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

