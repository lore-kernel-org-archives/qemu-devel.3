Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8036C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 11:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sObda-0003IW-19; Tue, 02 Jul 2024 07:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sObdY-0003I4-4O
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 07:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sObdW-0001Vl-9f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 07:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719919523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oP6AuWFZ0En5VhRV0SwDNNNVIFdJQwwFqR/YaXw8C4=;
 b=FHarMRv4uoJmjA+ESKWHZyrEP+qRXHAM0aJenMcM/m6vQHyIaWY9Ceg+sG+3nZSTfDOG1h
 KU1/9JNuuMSGx8WxU/qTHYNpQmOgsZHWflr6quwALRHPQBnW5E6wTYEHq7pRfWi/jLpnF7
 UBeVIBbn0Qu+HLPt1TT9N0p/NgpJzN0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-eGh3cfGcPUG6YSiqT5n-oA-1; Tue,
 02 Jul 2024 07:25:18 -0400
X-MC-Unique: eGh3cfGcPUG6YSiqT5n-oA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 506671945110; Tue,  2 Jul 2024 11:25:16 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.206])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EB5419560AA; Tue,  2 Jul 2024 11:25:12 +0000 (UTC)
Date: Tue, 2 Jul 2024 13:25:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] scsi: Don't ignore most usb-storage properties
Message-ID: <ZoPjloHDVhXR8xtq@redhat.com>
References: <20240131130607.24117-1-kwolf@redhat.com>
 <ce81d0ec-688d-4545-b008-123cd01cbd5a@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce81d0ec-688d-4545-b008-123cd01cbd5a@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 01.07.2024 um 15:08 hat Fiona Ebner geschrieben:
> Hi,
> 
> we got a user report about bootindex for an 'usb-storage' device not
> working anymore [0] and I reproduced it and bisected it to this patch.
> 
> Am 31.01.24 um 14:06 schrieb Kevin Wolf:
> > @@ -399,11 +397,10 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
> >      object_property_add_child(OBJECT(bus), name, OBJECT(dev));
> >      g_free(name);
> >  
> > +    s = SCSI_DEVICE(dev);
> > +    s->conf = *conf;
> > +
> >      qdev_prop_set_uint32(dev, "scsi-id", unit);
> > -    if (bootindex >= 0) {
> > -        object_property_set_int(OBJECT(dev), "bootindex", bootindex,
> > -                                &error_abort);
> > -    }
> 
> The fact that this is not called anymore means that the 'set' method
> for the property is also not called. Here, that method is
> device_set_bootindex() (as configured by scsi_dev_instance_init() ->
> device_add_bootindex_property()). Therefore, the device is never
> registered via add_boot_device_path() meaning that the bootindex
> property does not have the desired effect anymore.

Hmm, yes, seem I missed this side effect.

Bringing back this one object_property_set_int() call would be the
easiest fix, but I wonder if an explicit add_boot_device_path() call
(and allowing that one to fail gracefully instead of directly calling
exit()) wouldn't be better than re-setting a property to its current
value just for the side effect.

> Is it necessary to keep the object_property_set_{bool,int} and
> qdev_prop_set_enum calls around for these potential side effects? Would
> it even be necessary to introduce new similar calls for the newly
> supported properties? Or is there an easy alternative to
> s->conf = *conf;
> that does trigger the side effects?

I don't think the other properties whose setter we don't call any more
have side effects. They are processed during .realize, which is what I
probably expected for bootindex, too.

And that's really how all properties should be if we ever want to move
forward with the .instance_config approach for creating QOM objects
because then we won't call any setters during object creation any more,
they would only be for runtime changes.

Kevin


