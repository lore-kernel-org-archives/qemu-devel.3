Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DB9E77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 02:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUz3r-00070f-Hs; Mon, 06 Jan 2025 21:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1tUz3p-00070A-T5
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 21:11:13 -0500
Received: from bedivere.hansenpartnership.com ([104.223.66.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <James.Bottomley@HansenPartnership.com>)
 id 1tUz3o-0006Wb-4V
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 21:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1736215870;
 bh=mfxU72G4eSGdFLfGbL1wTIlEa432yZOUFx+qo5wPLPY=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=dcCBTpjGGWByssqwr/zy92cV8VH3n9s0dewpRZAiVdMwWi9EU8ysZjnGZrKKhLJij
 38CvDy3UGnGeeqtnvNkdeYKdWJ3xHWeTqGTvNX+pZk0popyLLBH8C8pJks4edFWXnK
 wHUUkfUPORoprOXrx21VW0Oxlax8rX4oB9XfGres=
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6289D128036E;
 Mon, 06 Jan 2025 21:11:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id CQOzB_GZjynD; Mon,  6 Jan 2025 21:11:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1736215870;
 bh=mfxU72G4eSGdFLfGbL1wTIlEa432yZOUFx+qo5wPLPY=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=dcCBTpjGGWByssqwr/zy92cV8VH3n9s0dewpRZAiVdMwWi9EU8ysZjnGZrKKhLJij
 38CvDy3UGnGeeqtnvNkdeYKdWJ3xHWeTqGTvNX+pZk0popyLLBH8C8pJks4edFWXnK
 wHUUkfUPORoprOXrx21VW0Oxlax8rX4oB9XfGres=
Received: from [172.20.4.117] (unknown [74.85.233.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0DFD41280198;
 Mon, 06 Jan 2025 21:11:10 -0500 (EST)
Message-ID: <f83258defb96927b2656c2834108f9603bdd0e9a.camel@HansenPartnership.com>
Subject: Re: [PATCH v11 2/2] tpm: add backend for mssim
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan
 Berger <stefanb@linux.ibm.com>
Date: Mon, 06 Jan 2025 18:11:09 -0800
In-Reply-To: <Z2RaYsLkazgciofM@redhat.com>
References: <20241212170528.30364-1-James.Bottomley@HansenPartnership.com>
 <20241212170528.30364-3-James.Bottomley@HansenPartnership.com>
 <Z2RaYsLkazgciofM@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.223.66.194;
 envelope-from=James.Bottomley@HansenPartnership.com;
 helo=bedivere.hansenpartnership.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2024-12-19 at 17:39 +0000, Daniel P. Berrangé wrote:
> On Thu, Dec 12, 2024 at 12:05:28PM -0500, James Bottomley wrote:
> > The Microsoft Simulator (mssim) is the reference emulation platform
> > for the TCG TPM 2.0 specification.
> > 
> > https://github.com/Microsoft/ms-tpm-20-ref.git
> > 
> > It exports a fairly simple network socket based protocol on two
> > sockets, one for command (default 2321) and one for control
> > (default
> > 2322).  This patch adds a simple backend that can speak the mssim
> > protocol over the network.  It also allows the two sockets to be
> > specified on the command line.  The benefits are twofold: firstly
> > it
> > gives us a backend that actually speaks a standard TPM emulation
> > protocol instead of the linux specific TPM driver format of the
> > current emulated TPM backend and secondly, using the microsoft
> > protocol, the end point of the emulator can be anywhere on the
> > network, facilitating the cloud use case where a central TPM
> > service
> > can be used over a control network.
> > 
> > The implementation does basic control commands like power off/on,
> > but
> > doesn't implement cancellation or startup.  The former because
> > cancellation is pretty much useless on a fast operating TPM
> > emulator
> > and the latter because this emulator is designed to be used with
> > OVMF
> > which itself does TPM startup and I wanted to validate that.
> > 
> > To run this, simply download an emulator based on the MS
> > specification
> > (package ibmswtpm2 on openSUSE) and run it, then add these two
> > lines
> > to the qemu command and it will use the emulator.
> > 
> >     -tpmdev mssim,id=tpm0 \
> >     -device tpm-crb,tpmdev=tpm0 \
> > 
> > to use a remote emulator replace the first line with
> > 
> >     -tpmdev
> > "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote'
> > ,'port':'2321'}}"
> > 
> > tpm-tis also works as the backend.
> > 
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > 
> > ---
> > 
> > v2: convert to SocketAddr json and use
> > qio_channel_socket_connect_sync()
> > v3: gate control power off by migration state keep control socket
> > disconnected
> >     to test outside influence and add docs.
> > v7: TPMmssim -> TPMMssim; doc and json fixes
> >     Make command socket open each time (makes OS debugging easier)
> > v11: add startup method to make sure TPM is reset on reboot
> > ---
> >  MAINTAINERS              |   6 +
> >  backends/tpm/Kconfig     |   5 +
> >  backends/tpm/meson.build |   1 +
> >  backends/tpm/tpm_mssim.c | 335
> > +++++++++++++++++++++++++++++++++++++++
> >  backends/tpm/tpm_mssim.h |  44 +++++
> >  docs/specs/tpm.rst       |  39 +++++
> >  qapi/tpm.json            |  31 +++-
> >  system/tpm-hmp-cmds.c    |   9 ++
> >  8 files changed, 466 insertions(+), 4 deletions(-)
> >  create mode 100644 backends/tpm/tpm_mssim.c
> >  create mode 100644 backends/tpm/tpm_mssim.h
> > 
> 
> 
> > diff --git a/backends/tpm/tpm_mssim.c b/backends/tpm/tpm_mssim.c
> > new file mode 100644
> > index 0000000000..8f105fc924
> > --- /dev/null
> > +++ b/backends/tpm/tpm_mssim.c
> > @@ -0,0 +1,335 @@
> > +/*
> > + * Emulator TPM driver which connects over the mssim protocol
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * Copyright (c) 2022
> 
> Copyright by whom ? I presume yourself, but I wouldn't normally
> assume the 'Author' line applies to the Copyright line.

I'll fix up this one (and all the others below) but:

[...]
> > diff --git a/backends/tpm/tpm_mssim.h b/backends/tpm/tpm_mssim.h
> > new file mode 100644
> > index 0000000000..397474e4f6
> > --- /dev/null
> > +++ b/backends/tpm/tpm_mssim.h
> > @@ -0,0 +1,44 @@
> > +/*
> > + * SPDX-License-Identifier: BSD-2-Clause
> > + *
> > + * The code below is copied from the Microsoft/TCG Reference
> > implementation
> > + *
> > + *  https://github.com/Microsoft/ms-tpm-20-ref.git
> > + *
> > + * In file TPMCmd/Simulator/include/TpmTcpProtocol.h
> > + */
> 
> That file has a volumous copyright header that I would expect to be
> preserved here.

Actually, the file itself has no copyright header at all (seems to be
standard practice for all header files in the repository). Did you want
me to paste the copyright lines from the LICENSE file; i.e.

Copyright 2010-2022 Microsoft Corporation
Copyright 2022-2024 Trusted Computing Group and its contributors

?

James



