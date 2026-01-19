Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80CCCCF2D2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 09:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhlna-0003Hm-3F; Mon, 19 Jan 2026 04:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vhlnL-0003Cv-4p
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vhlnH-0001Sk-KD
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768815808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+W96EAEa6nSFQu+j3DRT5eipSHguEtdyl8DdyEaxxwM=;
 b=hahgRLBYkaetjKH72ZnyxapoL/ndIEl4oOAQpiv+E+A5ZjQVPy+smLIkemNr76C2HGiDA6
 17fSxNMhUSv1FY7mQiD/FGk17SoxGS/uh/A0Y0H5yKiYUtVpc9ATRTRf9tIMdTgcM4U3aF
 OhwfCVwRfHDdK/WrJPmQXYwQeVVQ6Yg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-Tk6FdtYDN2K1-hqX3YEUkA-1; Mon, 19 Jan 2026 04:43:26 -0500
X-MC-Unique: Tk6FdtYDN2K1-hqX3YEUkA-1
X-Mimecast-MFC-AGG-ID: Tk6FdtYDN2K1-hqX3YEUkA_1768815805
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fc83f58dso2781670f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 01:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768815805; x=1769420605; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+W96EAEa6nSFQu+j3DRT5eipSHguEtdyl8DdyEaxxwM=;
 b=PNkuTAZXOs6f+KGjviR8TRkGMuPsAgeVX6gYWkozAhvRDhgTFVUhQdEFncWYCNYmli
 /MHmso9xFIXcyXr+80g5HG+i3ZDFW5lg/nPbwBi00ra1emrukFpEKJbz8Bm37PZWKn/1
 0aKMbt4Fq8ZpZMa0e7bdS1pWS/AbOB/Wf7opUMm01YsEBUQAEMDxs1Lqr4CMMkZnn7Pl
 v8yNsVBxLtzO0hOLq37NXA8zmYDYnBZClnhN8zM6MK5tGfIfbjqoOLTTJ7kzl8A2O9wS
 ZV4nhVpi/S2fpLCBL+xL4bzU/SeUl3u8WtcIHJYeIVZg7VZuZiHQSyroqsVgYKU9MCvz
 JeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768815805; x=1769420605;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+W96EAEa6nSFQu+j3DRT5eipSHguEtdyl8DdyEaxxwM=;
 b=AAI7pPcYKypD3Bu82/K+ScmlXphCY9HP51kO6ixO2sM+/Nh/a7zafAZpiBV4hBaCIW
 Uv+9k/vH5SSwKUB2Q+d8m6hUEGkzog6UjuhAUKk32iC/+z+0vD9/u/1IAzim5AV3xUaD
 C69U01fH7GlM2GWuS/WbFNaAbt7ICQeohePoR7lPQEbaxW5qPC3Ju92MnoVLcSwipSMO
 ZvJychaniHAzN5K6vwkbWCjXB4qbk5QNjWScciDZmtzxNVINfcLY1Lycw9mKVz67aZhZ
 LBbvQie2ZeuZ7HZlwCDOsj0aJQrholWEHn+yYLrHK1iUcOeGoQzkxvVIxmHFLhkRSpoQ
 hwxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPQVmwIkJ0gOLRVBussSwCv96YLS9622sKnInl9aabc4XbSmINPbRzdfE6gzmTE5hjepvi5B7GS1r+@nongnu.org
X-Gm-Message-State: AOJu0Yx6/2xpoBRQgBGKygO5wtdapGwgTUkAHwBF8EdMkRycqVPTXUsg
 7KnCOjw6wzT76BkscAulWMOHNnL+qrdJ25wAfNcGkkMJFgGuzYZckUKBsOrERoA6foP49vr4ODg
 4LrhcCmpXqOU/NwJq8TjngKpTQFi/55a2e00s/zNGDxULo05o0eO9dJkL
X-Gm-Gg: AZuq6aLqPTrl7i985yDkzFNAyYE5CMX9gaC8du5eJ9PhMohFoER+Iz/8wa2JYHfcFUz
 jvr4hMXNihGdXjP+Ggwfer7Spo6O3Kc/0hd+5l5CS67bHrQG/ULHtPerVVgMsaN7JB6Kmexuu/X
 wBTKUISDYFN9zohqrnKFubbpttJUeRJu7BbWV2Gr1SieA6Bd9bo0uSrTZJxqtiUNbF3+wW4aT9q
 ZPS+bNTObAUzuGM6/KDnwyUiVqvxYHPL8DS4gk3+Z4pE2rrTR4cGfSB2TeZsHIkKMQgc59stCLq
 I8H/U0SO+5NUODjr113rbRm1a+Qpq9aZVdm0Zy/Xw08qrluW7jv+rC/q8QBrWhNPm03/VvQt2R2
 mp3kVccbx217gxUUDXf8Zlfp89h6LXs4=
X-Received: by 2002:a05:6000:1ac5:b0:430:feb3:f5b4 with SMTP id
 ffacd0b85a97d-43569bd47dcmr10215653f8f.59.1768815805127; 
 Mon, 19 Jan 2026 01:43:25 -0800 (PST)
X-Received: by 2002:a05:6000:1ac5:b0:430:feb3:f5b4 with SMTP id
 ffacd0b85a97d-43569bd47dcmr10215613f8f.59.1768815804582; 
 Mon, 19 Jan 2026 01:43:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm22042594f8f.32.2026.01.19.01.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 01:43:24 -0800 (PST)
Date: Mon, 19 Jan 2026 04:43:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v6 08/12] virtio-serial-bus: add terminal resize messages
Message-ID: <20260119044148-mutt-send-email-mst@kernel.org>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <aW37oZ1X_7O6AXvo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aW37oZ1X_7O6AXvo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 19, 2026 at 09:38:41AM +0000, Daniel P. Berrangé wrote:
> On Mon, Jan 19, 2026 at 04:27:51AM +0100, Filip Hejsek wrote:
> > Implement the part of the virtio spec that allows to notify the virtio
> > driver about terminal resizes. The virtio spec contains two methods to
> > achieve that:
> > 
> > For legacy drivers, we have only one port and we put the terminal size
> > in the config space and inject the config changed interrupt.
> > 
> > For multiport devices, we use the control virtqueue to send a packet
> > containing the terminal size. Note that old versions of the Linux kernel
> > used an incorrect order for the fields (rows then cols instead of cols
> > then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.
> > 
> > As a result, when using a Linux kernel older than 6.15, the number of rows
> > and columns will be swapped.
> > 
> > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
> > but partially rewritten to fix various corner cases.
> > 
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > ---
> >  hw/char/trace-events              |  1 +
> >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++++++++++++--
> >  hw/core/machine.c                 |  4 ++-
> >  include/hw/virtio/virtio-serial.h |  5 +++
> >  4 files changed, 83 insertions(+), 3 deletions(-)
> > 
> 
> > @@ -1158,6 +1228,8 @@ static const Property virtio_serial_properties[] = {
> >                                                    31),
> >      DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
> >                        VIRTIO_CONSOLE_F_EMERG_WRITE, true),
> > +    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
> > +                      VIRTIO_CONSOLE_F_SIZE, true),
> >  };
> 
> Given the horrible mess with the kernel intentionally changing its
> behaviour after 15 years, I don't think we can we set this to be
> enabled by default.
> 
> The recent behaviour change is never going to be backported to enough
> stable distros that we can rely on the new behaviour, and thanks to
> the change we can't rely on the old behaviour either. We're doomed no
> matter what ordernig we use.
> 
> Thus, IMHO, this has to stay set to false indefinitely.

Not sure. But what we can do is add another flag to detect new kernels.
I'll try to think of a good name but suggestions are welcome.

> >  static void virtio_serial_class_init(ObjectClass *klass, const void *data)
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 6411e68856..50554b8900 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -38,7 +38,9 @@
> >  #include "hw/acpi/generic_event_device.h"
> >  #include "qemu/audio.h"
> >  
> > -GlobalProperty hw_compat_10_2[] = {};
> > +GlobalProperty hw_compat_10_2[] = {
> > +    { "virtio-serial-device", "console-size", "off" },
> > +};
> >  const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
> >  
> >  GlobalProperty hw_compat_10_1[] = {
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


