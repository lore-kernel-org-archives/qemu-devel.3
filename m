Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFD8C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKfV-0000LP-1X; Fri, 24 Jan 2025 09:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tbKfT-0000L1-G1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tbKfR-0002b7-Pl
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737728896;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qfxHBh307pomD7AKZxaF/ovGZl8n34HVgvBW9ww/GEI=;
 b=NQ6nW7ElkSXZl+OqzhZyMUPlml3Xxa7e2K90glQhx4tKbOywH+NsUFIplGSbJmAJNuMUDM
 8MQEKvOngofCWMUry8wTSQ+CGOE6Pc/raegasz88XRvjgTbrKE3E8HwMP54C+Or1uvvZut
 7fNFc1mcPa4lT5/5OLjJVrc/ZfToq38=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-t2tLiMghPoClSUqHApZcjA-1; Fri,
 24 Jan 2025 09:28:14 -0500
X-MC-Unique: t2tLiMghPoClSUqHApZcjA-1
X-Mimecast-MFC-AGG-ID: t2tLiMghPoClSUqHApZcjA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C117F180035E
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 14:28:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F40F81800344; Fri, 24 Jan 2025 14:28:11 +0000 (UTC)
Date: Fri, 24 Jan 2025 14:28:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC 0/6] RFC: hw/display/virtio-gpu: problems with coloured
 cursors
Message-ID: <Z5OjeMNP2nS9w94x@redhat.com>
References: <20250123191536.142753-1-berrange@redhat.com>
 <zde3tzhqrwc66txzl6ydp3xeipg5ohvj7saankjq2ri7p3ofhl@l6aoobdmfrz3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <zde3tzhqrwc66txzl6ydp3xeipg5ohvj7saankjq2ri7p3ofhl@l6aoobdmfrz3>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 24, 2025 at 11:00:33AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> >    The cursor data virtio-gpu is receiving from the guest has
> >    had the alpha channel pre-multiplied into the RGB components.
> 
> The kernel driver simply passes through whatever it gets from userspace.
> 
> Not sure what userspace passes to the kernel, I suspect it is whatever
> typical GPUs can use unmodified as cursor sprite.
> 
> >    The cursor data virtio-gpu is receiving from the guest appears
> >    to be in BGRA8888 format, while GTK/VNC both expect the data to
> >    be in RGBA8888 format.
> 
> The format used by virtio-gpu is DRM_FORMAT_ARGB8888
> (VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM) on little endian guests.  Byteswapped
> (DRM_FORMAT_BGRA8888 / VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM) on bigendian
> guests.
> 
> > This series has patches to virtio-gpu which reverse the RGB
> > components and un-multiply the alpha channel.
> 
> I'd tend to simply pass the cursor format information to the ui and
> leave it to the ui to convert if needed, or just use the data as-is if
> possible (like SDL does).  Same approach we are using for the
> framebuffer data.
> 
> IIRC the cursor code predates the adoption of pixman in qemu, maybe it
> makes sense to redesign this around pixman images.

Yeah that all makes sense, but trying it I hit something odd. The
virtio_gpu_resource_create_2d *always* seems to report the format
as VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM rather than
VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM for the cursor resources.

IOW, the guest is incorrectly telling us there's no alpha channel
data, so if I honour the guest format, the cursor is filled in
black wherever there is supposed to be 100% alpha :-(

I can see a place in linux.git virtiogpu_gem.c that has harcoded
the DRM_FORMAT_HOST_XRGB8888 format for resources, which I guess
is where its going wrong :-(

I could try to workaround this in QEMU, and blindly assume that
guests always intend to have an alpha channel with cursors, as
it makes no sense to not do so.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


