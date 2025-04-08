Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C53C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 11:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26qs-0003nc-OS; Tue, 08 Apr 2025 07:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u26qp-0003mw-2S
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:10:43 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u26ql-00045n-SK
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:10:42 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id F11E543FC5;
 Tue,  8 Apr 2025 13:10:34 +0200 (CEST)
Date: Tue, 8 Apr 2025 13:10:34 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Message-ID: <749745338.1328.1744110634283@webmail.proxmox.com>
In-Reply-To: <CAJ+F1CKZUWEvJ54kF4J=pPuxZoozGcjB9H5KBJY+fzBrdLVBDw@mail.gmail.com>
References: <20250407105939.1997660-1-dietmar@proxmox.com>
 <20250407105939.1997660-2-dietmar@proxmox.com>
 <CAMxuvaxs+qM3msR-tdCXZfMZkQvHqNbHhHwhYKBPtRPLZGyuMA@mail.gmail.com>
 <1880642940.1156.1744105987725@webmail.proxmox.com>
 <CAJ+F1CKZUWEvJ54kF4J=pPuxZoozGcjB9H5KBJY+fzBrdLVBDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] add vnc h264 encoder
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev75
X-Originating-Client: open-xchange-appsuite
Received-SPF: pass client-ip=94.136.29.106; envelope-from=dietmar@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > > > +#include <gst/gst.h>
> > > > +
> > > > +static void libavcodec_destroy_encoder_context(VncState *vs)
> > >
> > > it's not libavcodec.
> >
> > I will fix that in v2.
> 
> What about encodebin suggestion?

I found no way to configure codec specific option (i.e. x264 zerolatency). I there a way? It is crucial to set those option
to get reasonable quality.

Anyway, I can test a view option, for example x264, openh264, and
maybe vah264enc (hardware support), and then simply use what is available.

I think we should also have the option to allow h264 if we detect
HW support, but disable software encoders. Or let the user select
the list of allowed codec?

> >
> > > > +#ifdef CONFIG_GSTREAMER
> > > > +        case VNC_ENCODING_H264:
> > > > +            if (vnc_h264_encoder_init(vs) == 0) {
> > > > +                vnc_set_feature(vs, VNC_FEATURE_H264);
> > >
> > > Before advertising support for the codec, it should actually check if
> > > the encoder is present.
> >
> > ok.
> >
> > > It would also be useful to have an extra VNC
> > > option like H264=on/off/auto.
> >
> > I thought it would be better to do that at the client?
> 
> Well, it can be worth it to prevent h264 usage from the server too. Or
> to ensure the server is h264-capable. (this wasn't seen as much
> necessary for other codecs that are low-resource and/or patent-free,
> but may make sense too)

Maybe H264=on,off,codec-list

on: automatically select the codec
off: disable h264
codec-list: a list of allowed codecs


- Dietmar


