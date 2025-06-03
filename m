Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B45C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMS1m-0000Sj-64; Tue, 03 Jun 2025 09:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMS1j-0000SC-1S
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 09:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMS1d-0003JA-0r
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 09:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748958592;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2i6VV7PI8f82RT+L1bn6PcWel3gpjRUakBS/ECk1Hcw=;
 b=QBCtxvzBke4HG5XO4Dh4otOXLcr7VMyORlHzHPLNPx2wzb4NR8+QJKoGCCw1PXvaJfJM9A
 OI8DEPe8wZZu+L/6fMLGJj8VhWwBahKb1M6TJ25HoC8dTBpLcrRfyCeBV6qT78HCfV/mSK
 nAVtEmDA+9II5Szxt+QocIoXmCXFqaM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-QZHggIoPNiW7dPrEPi3cKA-1; Tue,
 03 Jun 2025 09:49:50 -0400
X-MC-Unique: QZHggIoPNiW7dPrEPi3cKA-1
X-Mimecast-MFC-AGG-ID: QZHggIoPNiW7dPrEPi3cKA_1748958590
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1C0C1956046; Tue,  3 Jun 2025 13:49:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C58DC1800361; Tue,  3 Jun 2025 13:49:46 +0000 (UTC)
Date: Tue, 3 Jun 2025 14:49:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 02/23] ui/vnc: take account of client byte order in pixman
 format
Message-ID: <aD79d0XPK_dARai_@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
 <20250522102923.309452-3-berrange@redhat.com>
 <e6c7920b-8078-4d97-92ce-2efafb645953@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6c7920b-8078-4d97-92ce-2efafb645953@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 03, 2025 at 01:18:55PM +0200, Thomas Huth wrote:
> On 22/05/2025 12.29, Daniel P. Berrangé wrote:
> > The set_pixel_conversion() method is responsible for determining whether
> > the VNC client pixel format matches the server format, and thus whether
> > we can use the fast path "copy" impl for sending pixels, or must use
> > the generic impl with bit swizzling.
> > 
> > The VNC server format is set at build time to VNC_SERVER_FB_FORMAT,
> > which corresponds to PIXMAN_x8r8g8b8.
> > 
> > The qemu_pixman_get_format() method is then responsible for converting
> > the VNC pixel format into a pixman format.
> > 
> > The VNC client pixel shifts are relative to the associated endianness.
> > 
> > The pixman formats are always relative to the host native endianness.
> > 
> > The qemu_pixman_get_format() method does not take into account the
> > VNC client endianness, and is thus returning a pixman format that is
> > only valid with the host endianness matches that of the VNC client.
> ...
> 
>  Hi Daniel,
> 
> this patch breaks the output in the TigerVNC viewer for me.
> If I run "./qemu-system-x86_64 -vnc :1" on my laptop, and then connect to it
> via "vncviewer :1", the output of the BIOS now appears in yellow letters
> (instead of grey ones).

It turns out that historically we never set the 'client_be' flag
when a client does NOT send a "set pixel format" message. By luck
this was OK for little endian platforms as the default value of
0 matched little endian.

When I replaced 'client_be' with "client_endian", the default
value of 0 matches neither big or little endian.

I didn't see this with remote-viewer as it unconditionally
sends "set pixel format", but tigervnc always uses the server's
default pixel format.

So this patch is fine, but it exposes a pre-existing latent
bug there was probably causing problems on big endian platforms
in the past, but now causes problems on little endian platforms.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


