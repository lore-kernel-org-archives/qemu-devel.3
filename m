Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25A7C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YwU-0002pi-AQ; Wed, 23 Apr 2025 08:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7Yvt-0001zP-4M
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7Yvq-000163-Ra
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745410224;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KmXF58PxFm45emSrX0DwYBDcQat+1dUc5oebcO2OeLo=;
 b=K8o9yal3gcomDG7VJkz7zAJy3jecG3orRMijs0QuQMn0EbNca1WRNVSB5evExM+tM//hEW
 6VpkOh/D6gPeIJfz4pEmVpEfFns2+XFPNXH9QIG+GKr/plwbFeCia6/01qrwc91FkTZhU3
 ZHSJdo6vaf72J1foVeptNox1fO+A98c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-R8AuKwB4Nc-5OV6Cwvf0aQ-1; Wed,
 23 Apr 2025 08:10:21 -0400
X-MC-Unique: R8AuKwB4Nc-5OV6Cwvf0aQ-1
X-Mimecast-MFC-AGG-ID: R8AuKwB4Nc-5OV6Cwvf0aQ_1745410220
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 599431956094; Wed, 23 Apr 2025 12:10:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDA461800352; Wed, 23 Apr 2025 12:10:17 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:10:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/9] add vnc h264 encoder
Message-ID: <aAjYpqobbq1fS-E1@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-3-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 18, 2025 at 01:29:46PM +0200, Dietmar Maurer wrote:
> This patch implements H264 support for VNC. The RFB protocol
> extension is defined in:
> 
> https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#open-h-264-encoding
> 
> Currently the Gstreamer x264enc plugin (software encoder) is used
> to encode the video stream.
> 
> The gstreamer pipe is:
> 
> appsrc -> videoconvert -> x264enc -> appsink
> 
> Note: videoconvert is required for RGBx to YUV420 conversion.
> 
> The code still use the VNC server framebuffer change detection,
> and only encodes and sends video frames if there are changes.
> 
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/meson.build    |   1 +
>  ui/vnc-enc-h264.c | 282 ++++++++++++++++++++++++++++++++++++++++++++++
>  ui/vnc-jobs.c     |  49 +++++---
>  ui/vnc.c          |  21 ++++
>  ui/vnc.h          |  21 ++++
>  5 files changed, 359 insertions(+), 15 deletions(-)
>  create mode 100644 ui/vnc-enc-h264.c
> 
> diff --git a/ui/meson.build b/ui/meson.build
> index 35fb04cadf..34f1f33699 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -46,6 +46,7 @@ vnc_ss.add(files(
>  ))
>  vnc_ss.add(zlib, jpeg)
>  vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
> +vnc_ss.add(when: gstreamer, if_true: files('vnc-enc-h264.c'))
>  system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
>  system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
>  
> diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> new file mode 100644
> index 0000000000..3abe6a1528
> --- /dev/null
> +++ b/ui/vnc-enc-h264.c
> @@ -0,0 +1,282 @@
> +/*
> + * QEMU VNC display driver: hextile encoding
> + *
> + * Copyright (C) 2025 Proxmox Server Solutions GmbH
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */

New code is expected to use SPDX-License-Identifier, without this
boilerplate text. We'd also expect it to be GPL-2.0-or-later, and
if this is not possible for some reason (eg derived from pre-existing
code), it should be justified in the commit message.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


