Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC51C25B10
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29Ft-0002TU-N1; Wed, 01 May 2024 08:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29Fr-0002Sp-P3; Wed, 01 May 2024 08:40:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29Fn-0001Vj-KY; Wed, 01 May 2024 08:40:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e4266673bbso60913845ad.2; 
 Wed, 01 May 2024 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714567205; x=1715172005; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BIm4pgGKNf8okZ2IErhShj3MesXwQRAI20Hssshcfo=;
 b=S2lUp1dSU8DmUWCp9hDqVtrJ+D6eyhqiKRFg25MKU3XNaInP4uFnsP5ez4VO2ZFlYZ
 9NAsAt45sdMiXvjIks3cMMWEFuhJpWen9fyZwlC/oxPIAbPP2bmKdq02fE3wAW6Wl1Pe
 zaj4mKyNMWx9KM9tyErWtq051Rrdm03knMdLpu6C4y/8Srlsp1e7uCFfP6F7fEn55uPn
 yg/inY7Khy/yMQnBFLgDNiFFf5r4KTCaYVz/QI1epx+Qdfh+LwCcUNKBQYOzQaFysN9I
 NAmF0eZszfyhgzj9rk0yxDYEiz7TELyIud0IIEA8ldsyt6l3rCkRndPQLc1qC0EaTDNq
 p74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714567205; x=1715172005;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3BIm4pgGKNf8okZ2IErhShj3MesXwQRAI20Hssshcfo=;
 b=IlRR6tEy5wndO+fYejjLP9Oh3W+Uhxj7raqQTjkMkXUdowOPiimsdsQ3WWYORJ4F19
 26yxT7r4hjgoTFA/MJO9TS1ftNxGFqS4QZK1xz8qVsaVyHLMMvZZ2/7YqVWEAEA5unBk
 7uc18Y4m2an/VnHZcvC9lsvTUNgj8He5ZFzdNeR0yszfFdfM5g95pi5v79pkeuBOYbkX
 dGVyxeIPk8yY7/ky7ki+6XN+1qXPb2mgR+SMc0ktCu+a9gPpT7GEGD6CiU5TBKkMMjgz
 +IKTlWbW8yE6W5QtpdfZ6hM7O1P3OdB1kqqno3eT5pV9V3mkoVpZzr0gYQqHh+kvoBMm
 xb0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxWDynbStrlxcL1TXX1Ygv5RY8gCYEDaG8U/4Ga9yPcTuSe9Evx0ZDf33HtmlFHu4qgtAigJJYT77Eovt2OP36jIq9
X-Gm-Message-State: AOJu0YzFBfj6S5Qj6xn1wnRIxkSuj2lBJockKVe25vTl2wE+k47PUFKP
 U0/mLVeafg11hCwNhfqKLnq8jS3URit6jpSG4jGeBZOwlIHyPNSn
X-Google-Smtp-Source: AGHT+IE4AGzpqKaVPr276/gQw32EGb3jLr5E6v5yW3uDb9HVs/gXuqMF6jdjtxwcoGVTJyx/8IXD2w==
X-Received: by 2002:a17:903:904:b0:1e6:413:9df1 with SMTP id
 ll4-20020a170903090400b001e604139df1mr2512192plb.41.1714567205458; 
 Wed, 01 May 2024 05:40:05 -0700 (PDT)
Received: from localhost ([1.146.40.196]) by smtp.gmail.com with ESMTPSA id
 w3-20020a170902a70300b001e83a718d87sm24149256plq.19.2024.05.01.05.40.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 05:40:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 May 2024 22:39:59 +1000
Message-Id: <D0YBCHP9K12V.3JU88W5WITYRM@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Saif Abrar" <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] ppc/pnv: Begin a more complete ADU LPC model for
 POWER9/10
X-Mailer: aerc 0.17.0
References: <20240417110215.808926-1-npiggin@gmail.com>
 <20240417110215.808926-2-npiggin@gmail.com>
 <577fd77f-a6b9-41f5-8193-f2cc80503a7d@kaod.org>
In-Reply-To: <577fd77f-a6b9-41f5-8193-f2cc80503a7d@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed Apr 17, 2024 at 9:25 PM AEST, C=C3=A9dric Le Goater wrote:
> Hello Nick,
>
> On 4/17/24 13:02, Nicholas Piggin wrote:
> > This implements a framework for an ADU unit model.
> >=20
> > The ADU unit actually implements XSCOM, which is the bridge between MMI=
O
> > and PIB. However it also includes control and status registers and othe=
r
> > functions that are exposed as PIB (xscom) registers.
> >=20
> > To keep things simple, pnv_xscom.c remains the XSCOM bridge
> > implementation, and pnv_adu.c implements the ADU registers and other
> > functions.
> >=20
> > So far, just the ADU no-op registers in the pnv_xscom.c default handler
> > are moved over to the adu model.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   include/hw/ppc/pnv_adu.h   |  34 ++++++++++++
> >   include/hw/ppc/pnv_chip.h  |   3 +
> >   include/hw/ppc/pnv_xscom.h |   6 ++
> >   hw/ppc/pnv.c               |  16 ++++++
> >   hw/ppc/pnv_adu.c           | 111 ++++++++++++++++++++++++++++++++++++=
+
> >   hw/ppc/pnv_xscom.c         |   9 ---
> >   hw/ppc/meson.build         |   1 +
> >   hw/ppc/trace-events        |   4 ++
> >   8 files changed, 175 insertions(+), 9 deletions(-)
> >   create mode 100644 include/hw/ppc/pnv_adu.h
> >   create mode 100644 hw/ppc/pnv_adu.c
> >=20
> > diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
> > new file mode 100644
> > index 0000000000..9dc91857a9
> > --- /dev/null
> > +++ b/include/hw/ppc/pnv_adu.h
> > @@ -0,0 +1,34 @@
> > +/*
> > + * QEMU PowerPC PowerNV Emulation of some ADU behaviour
> > + *
> > + * Copyright (c) 2024, IBM Corporation.
> > + *
> > + * SPDX-License-Identifier: LGPL-2.1-or-later
>
>
> Did you mean GPL-2.0-or-later ?

Hey Cedric,

Thanks for reviewing, I've been away so sorry for the late reply.

It just came from one of the headers I copied which was LGPL. But
there's really nothing much in it and could find a GPL header to
copy. Is GPL-2.0-or-later preferred?

Thanks,
Nick

