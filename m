Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F663C369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 17:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u56EV-0003Vp-N7; Wed, 16 Apr 2025 13:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u56EN-0003Rh-0k
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u56EK-0004sU-72
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744823236;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cKMKvmpYE78S6DCtSJgygrJbvRKAANyqGnejZlIJXbk=;
 b=c/FwKCfKvU+TFgiRLEkymgnsSlQ4FhNUnkv1SViJKanjqdnlborvoSanm+B37VPWy6rHvE
 Jp38usAGBvPBAPnhMrMBzGda9si9uLm/B7REo6tFO4egfIOEZYB2ipQCj7dl7GEpZflwv/
 luBDT77zGtp9XhIpF0nHOsssgYg8ETI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-6mzeogHrMMmK9mTrt1tMNA-1; Wed,
 16 Apr 2025 13:07:13 -0400
X-MC-Unique: 6mzeogHrMMmK9mTrt1tMNA-1
X-Mimecast-MFC-AGG-ID: 6mzeogHrMMmK9mTrt1tMNA_1744823232
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 102FC18001CA; Wed, 16 Apr 2025 17:07:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 172F918002AD; Wed, 16 Apr 2025 17:07:04 +0000 (UTC)
Date: Wed, 16 Apr 2025 18:07:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yuri Nesterov <yuri.nesterov@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] usb-host: enable autoscan for bus+addr to survive host
 suspend/resume
Message-ID: <Z__jtQe0nYsaGnoH@redhat.com>
References: <20250416161929.2846102-1-yuri.nesterov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250416161929.2846102-1-yuri.nesterov@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Apr 16, 2025 at 07:19:29PM +0300, Yuri Nesterov wrote:
> Currently, there is a special case for usb-host devices added using the
> hostbus= and hostaddr= properties to avoid adding them to the hotplug
> watchlist, since the address changes every time the device is plugged
> in. However, on Linux, when the host system goes into suspend and then
> resumes, those devices stop working in both the guest and the host.
> 
> Enabling autoscan and adding those devices to the watchlist allows them
> to keep working in the guest after host suspend/resume.

So IIUC what you're saying is that on suspend the host device
is removed by the kernel, and on resume, the USB device is
recreated. So QEMU's open file handle for the USB device is
invalid after resume.

If the /dev/bus/usb/NNN/NNN file goes away and then gets
re-created by the kernel though, we can't assume QEMU is
going to be able to re-open the new /dev/bus/usb device
file though.

When QEMU runs under libvirt, QEMU won't have any access
to the /dev/bus/usb device node unless libvirt has set the
right permissions and (where appropriate) also set the
SELinux label.

The current autoscan logic seems rather crude. AFAIK every 2
seconds it will re-scan every host USB device to see if any
has gone away and close it, and/or re-open if re-appeared.

If we enable this autoscan logic, then under libvirt, AFAICS,
QEMU is going to fail to re-open the device, and a counter in
the autoscan logic means that after 3 attempts to re-open QEMU
will stop attempting it at all...but strangely it appears QEMU
will keep the timer running, so every 2 seconds it will iterate
over every USB device, but never try to open any of them.

Regardless of your current patch this autoscan logic feels like
it needs improvement. We shouldn't need to busy-poll to see that
a USB device goes away, it should be possible to rely on event
notifications in some way.

Even then we'd still need a way to prevent this immediate auto
re-opening when under libvirt. Libvirt would have to detect the
reappearance of the device and perform relabelling and permissions
changes, before QEMU is able to be told to try to re-open.
Potentially this implies a new QMP command to tell QEMU to try
to re-open, unless perhaps QEMU can be triggered off an inotify
event for the permissions/label change of the device node.

> 
> Signed-off-by: Yuri Nesterov <yuri.nesterov@gmail.com>
> ---
>  hw/usb/host-libusb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index c3d642c9d3..32c0251471 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -1227,7 +1227,7 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
>          !s->match.vendor_id &&
>          !s->match.product_id &&
>          !s->match.port) {
> -        s->needs_autoscan = false;
> +        s->needs_autoscan = true;
>          ldev = usb_host_find_ref(s->match.bus_num,
>                                   s->match.addr);
>          if (!ldev) {
> @@ -1244,6 +1244,9 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
>          }
>      } else {
>          s->needs_autoscan = true;
> +    }
> +
> +    if (s->needs_autoscan) {
>          QTAILQ_INSERT_TAIL(&hostdevs, s, next);
>          usb_host_auto_check(NULL);
>      }
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


