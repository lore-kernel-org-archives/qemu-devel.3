Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA7DC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc53L-00060Y-Cb; Mon, 19 Feb 2024 09:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc53I-0005zc-UQ
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:55:29 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc53G-0008JV-Uk
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:55:28 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso4288609a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708354525; x=1708959325; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMCvsVDJbHcWYYwpZtD1yVzcg33BPbr0qCKmGsuZidw=;
 b=NZAaBDO690uMEeB6jzsbk5SZubE6T+cR3bWguESf8eCP9pax3u0sBDuxwz8xNDpD+6
 MvxvDTbSzQbOCRp7je0IwDl47BmblowpTE8R2z0+QpVS3SJOosJjfaDA2TUtzjsJa3O7
 A8U9PrgHfEq4Isbh8LwhAHqVWZx/C85VTXn6Nk7P94NsbY4WNW+Sy0/LxbvDKw8Xq9gA
 Ge2vZstAbNDWjccU32WsTlBIrQ+gB4gZxfLxvw0qjBJ/8mbCG4BJ0uXNGGy/ftJBcjY4
 H36Og8rnmraZ036gQ0P2SLSiEr7NzrxPb1lkFgt5qevKSzFK605VzB1lsS+FbH1VfTFP
 D1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708354525; x=1708959325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMCvsVDJbHcWYYwpZtD1yVzcg33BPbr0qCKmGsuZidw=;
 b=q/fuF8uGXvzfMLswAjgPC2v+lckaXfocuyek5icrYUZrvqEDIu680xNr+hifhyUMbA
 snskdhertZNW6gdzMExYq/ObplPCbPRC207nRBHTh7IUaiD1h9B3LWUE/rOxQ1cSAOAT
 xJsxzs9teG/acD+Us5YbUbS3+v6piTglg6/Hj3FCHVKAN64N4+/YttkR2imHpMC9nG8B
 5Qei40YsPDVCul2fUky1Prjm4vMh9jpcvpYwA02gHMIbvLnolfp01AcEIJPhNFRhHTZ8
 HrSKvBcMi0dCQLecHemIY+5VfbduP7LnzezkfWgpreRi1iTS3dNUTDncL+Aunb5vpO8g
 CkBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsxFw8Olc1Pr3BD/6/BGF99dvU4kSyI9mwUKcwHDp4SDiVI32sA7uP0FVuZf6QG5FvX7HuUev8e75wY5DexOe3exaPze8=
X-Gm-Message-State: AOJu0Yx7bYzIczM2GrLRifaurQntJBTOrpwCmKMz9IRo1pLYchuYm43+
 XtU1vyurii0CEDw0IsZvsH2brNv/l3AOnKHV9+Yk6mcRrPbd3EpFNsRFdhCr0lRiTvMSqZwOXdL
 J5R0iW5Va5cVMnvM3uOSC3I2vjjV0yu9M9HBLxw==
X-Google-Smtp-Source: AGHT+IHMr+iq00gSuTUZj3/LoLblnntZzobTw7wwDS/Enco28C1IuETyxwxQvRPu/vgx1GlT7qDNWRoT58E67ohJRyY=
X-Received: by 2002:a05:6402:1a4d:b0:564:391:ec1e with SMTP id
 bf13-20020a0564021a4d00b005640391ec1emr1280295edb.17.1708354525178; Mon, 19
 Feb 2024 06:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20240219082938.238302-1-npiggin@gmail.com>
 <20240219082938.238302-23-npiggin@gmail.com>
 <754804d1-8bde-b23b-d136-e93d6d967987@eik.bme.hu>
 <b2820e70-9e58-4087-b072-5049dda7023a@kaod.org>
In-Reply-To: <b2820e70-9e58-4087-b072-5049dda7023a@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2024 14:55:13 +0000
Message-ID: <CAFEAcA93B8cJRhuqROufrrY37d-Rp=grp9mApiX=f1W65mKSag@mail.gmail.com>
Subject: Re: [PULL 22/49] hw/pci-host/raven.c: Mark raven_io_ops as
 implementing unaligned accesses
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 19 Feb 2024 at 14:53, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 2/19/24 15:49, BALATON Zoltan wrote:
> > On Mon, 19 Feb 2024, Nicholas Piggin wrote:
> >> From: Peter Maydell <peter.maydell@linaro.org>
> >>
> >> The raven_io_ops MemoryRegionOps is the only one in the source tree
> >> which sets .valid.unaligned to indicate that it should support
> >> unaligned accesses and which does not also set .impl.unaligned to
> >> indicate that its read and write functions can do the unaligned
> >> handling themselves.  This is a problem, because at the moment the
> >> core memory system does not implement the support for handling
> >> unaligned accesses by doing a series of aligned accesses and
> >> combining them (system/memory.c:access_with_adjusted_size() has a
> >> TODO comment noting this).
> >>
> >> Fortunately raven_io_read() and raven_io_write() will correctly deal
> >> with the case of being passed an unaligned address, so we can fix the
> >> missing unaligned access support by setting .impl.unaligned in the
> >> MemoryRegionOps struct.
> >>
> >> Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > Hm, this seems to be missing the actual patch.
>
> It's merged already and git knows how to handle this.

Mmm, though this is the result of "rebased onto a tree that
already had the commit" rather than "two merges both contain
the commit", so we end up with a genuinely empty commit upstream,
which is a bit odd looking, though harmless.

-- PMM

