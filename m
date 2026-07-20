Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4411CC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmKi-0001rK-K4; Mon, 20 Jul 2026 07:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wlmKg-0001qw-Sm
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wlmKe-0000kO-QJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784547527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9tgFpnE8BEVaE8N0y9j1psZx7Y99X+Bi5/bEEfuZEE=;
 b=MkyrSr6zOblm36HbCl2JN/62qSnGtc+iEpF7R0epoMviCQFFo9Z7gxpgMFpGoEJBYBuieu
 yS2CUwZhdpQ9r0PH2A5T97KRFCF8p8pW7vkbRLJ6oB/ObNP1ZlDhDTpZhuTkojpmBBXEa1
 +Yf6o2ZfdHoZpEGLQaEtIef4m2dDyJQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-EntCse2nNUac4jCboNcC8A-1; Mon,
 20 Jul 2026 07:38:44 -0400
X-MC-Unique: EntCse2nNUac4jCboNcC8A-1
X-Mimecast-MFC-AGG-ID: EntCse2nNUac4jCboNcC8A_1784547524
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B87CD1944B3D; Mon, 20 Jul 2026 11:38:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DD691956094; Mon, 20 Jul 2026 11:38:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1E9BB1800391; Mon, 20 Jul 2026 13:38:42 +0200 (CEST)
Date: Mon, 20 Jul 2026 13:38:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Timo =?utf-8?B?VGVyw6Rz?= <timo.teras@iki.fi>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/usb/host-libusb: keep autoscan enabled for bus+addr
 selector
Message-ID: <al4GiC3G1u2lgTJD@sirius.home.kraxel.org>
References: <20250912-usbhost-disconnect-v1-1-9c7c5fa9b50a@iki.fi>
 <bb76dd56-e97e-4d1c-aaf8-9eb55e6858b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb76dd56-e97e-4d1c-aaf8-9eb55e6858b3@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=kraxel@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Jul 20, 2026 at 10:12:27AM +0200, Thomas Huth wrote:
> 
>  Hi Gerd,
> 
> since you originally wrote commit e058fa2dd599, could you maybe have a look
> at this patch?

Not sure what is going on here, I'm confident I had tested this back
then.  Maybe behavior depends on the kind of usb device or libusb
version or host os or a combination of those.  If disconnect detection
does not work reliable (as written in the gitlab issue) turning
autoscan back on should indeed fix it and it should also not cause
other problems.

Commit message should be a bit more verbose so it is not needed to
visit gitlab for additional info.  With that:

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

> 
>  Thanks,
>   Thomas
> 
> 
> On 12/09/2025 13.14, Timo Teräs wrote:
> > This is partial revert of commit e058fa2dd599.
> > 
> > The portion to immediately validate the device is kept, but this
> > adds and enables again the autoscan functionality. This is needed
> > to detect and relay USB device disconnect event to the guest.
> > 
> > Fixes: e058fa2dd599 ("usb-host: add special case for bus+addr")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3111
> > Signed-off-by: Timo Teräs <timo.teras@iki.fi>
> > ---
> >   hw/usb/host-libusb.c | 14 ++++----------
> >   1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> > index b74670ae25696b5252f0d034cb9b759e338a050f..f0baf6b2f2d12fbf8feb5b788b46d3187028df58 100644
> > --- a/hw/usb/host-libusb.c
> > +++ b/hw/usb/host-libusb.c
> > @@ -90,7 +90,6 @@ struct USBHostDevice {
> >       uint32_t                         iso_urb_frames;
> >       uint32_t                         options;
> >       uint32_t                         loglevel;
> > -    bool                             needs_autoscan;
> >       bool                             allow_one_guest_reset;
> >       bool                             allow_all_guest_resets;
> >       bool                             suppress_remote_wake;
> > @@ -1211,7 +1210,6 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
> >   #if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
> >       if (s->hostdevice) {
> >           int fd;
> > -        s->needs_autoscan = false;
> >           fd = qemu_open(s->hostdevice, O_RDWR, errp);
> >           if (fd < 0) {
> >               return;
> > @@ -1227,7 +1225,6 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
> >           !s->match.vendor_id &&
> >           !s->match.product_id &&
> >           !s->match.port) {
> > -        s->needs_autoscan = false;
> >           ldev = usb_host_find_ref(s->match.bus_num,
> >                                    s->match.addr);
> >           if (!ldev) {
> > @@ -1242,14 +1239,13 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
> >                          s->match.bus_num, s->match.addr);
> >               return;
> >           }
> > -    } else {
> > -        s->needs_autoscan = true;
> > -        QTAILQ_INSERT_TAIL(&hostdevs, s, next);
> > -        usb_host_auto_check(NULL);
> >       }
> >       s->exit.notify = usb_host_exit_notifier;
> >       qemu_add_exit_notifier(&s->exit);
> > +
> > +    QTAILQ_INSERT_TAIL(&hostdevs, s, next);
> > +    usb_host_auto_check(NULL);
> >   }
> >   static void usb_host_instance_init(Object *obj)
> > @@ -1267,9 +1263,7 @@ static void usb_host_unrealize(USBDevice *udev)
> >       USBHostDevice *s = USB_HOST_DEVICE(udev);
> >       qemu_remove_exit_notifier(&s->exit);
> > -    if (s->needs_autoscan) {
> > -        QTAILQ_REMOVE(&hostdevs, s, next);
> > -    }
> > +    QTAILQ_REMOVE(&hostdevs, s, next);
> >       usb_host_close(s);
> >   }
> > 
> > ---
> > base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
> > change-id: 20250912-usbhost-disconnect-192ecaa8fc3e
> > 
> > Best regards,
> 

-- 


