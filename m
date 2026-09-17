Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32E7C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7G18-00006Y-F8; Thu, 17 Sep 2026 13:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7G16-00005q-EW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7G12-000832-Ja
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789666519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1WZnmNcNcrDJJukkGRpeyaPStQcUVDUa+3SMSz6J3hM=;
 b=TZ+5rAT2kfBdhV0TExIxNt1cc+RTDBYIvGXrbyi59AsaoNM5pkhpRwgUVKptLB0smkFULF
 I6cYF7sL3Gfrw2cVzbDsw/pe74n499uIBq4jME2V4oWi5eToiaXhPdo0XIT/ybXeAvtgZH
 xhvj/h0ez1kn/AWFmnz2wdaYndXXOYA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-WLxgpl1VNNOE9VbfatQquw-1; Thu,
 17 Sep 2026 13:35:14 -0400
X-MC-Unique: WLxgpl1VNNOE9VbfatQquw-1
X-Mimecast-MFC-AGG-ID: WLxgpl1VNNOE9VbfatQquw_1789666512
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E0961955F26; Thu, 17 Sep 2026 17:35:11 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E21E0214; Thu, 17 Sep 2026 17:35:08 +0000 (UTC)
Date: Thu, 17 Sep 2026 18:35:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 15/16] s390x/pci: Implement migration for emulated
 devices
Message-ID: <aqwkyvY8mxIEqDyH@redhat.com>
References: <20260911152137.676602-1-kshk@linux.ibm.com>
 <20260911152137.676602-16-kshk@linux.ibm.com>
 <7a2ec98c-6756-4c9f-8f86-1b0db94c8053@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a2ec98c-6756-4c9f-8f86-1b0db94c8053@linux.ibm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 17, 2026 at 10:25:32AM -0700, Farhan Ali wrote:
> 
> On 9/11/2026 8:21 AM, Konstantin Shkolnyy wrote:
> > @@ -1303,11 +1380,22 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >           pbdev = S390_PCI_DEVICE(dev);
> >           pbdev->fid = 0;
> >           QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
> > -        g_hash_table_remove(s->zpci_table, &pbdev->idx);
> > +        /*
> > +         * If this QEMU is running a migrated guest, and was configured with
> > +         * more zpci devices than the source QEMU, extra zpci devices could be
> > +         * excluded from zpci_table and invisible to the guest and have
> > +         * pbdev->idx values duplicating those of active devices. If the
> > +         * pbdev being unplugged is such, the zpci_table entry for pbdev->idx
> > +         * can find a different pbdev which we must not remove.
> > +         */
> > +        if (g_hash_table_lookup(s->zpci_table, &pbdev->idx) == pbdev) {
> > +            g_hash_table_remove(s->zpci_table, &pbdev->idx);
> > +        }
> 
> If we are migrating, won't we re-create the exact same state and devices on
> the target host? Is it possible that the target QEMU can have more devices
> than source?

It is expected that the source and dest QEMU processes have identical
virtual hardware configuration, and also no attempts should be made to
hot-add/remove devices while migration is running.

> 
> 
> >           if (pbdev->dma_limit) {
> >               s390_pci_end_dma_count(s, pbdev->dma_limit);
> >           }
> >           g_hash_table_destroy(pbdev->iotlb);
> > +        s390_clear_zpci_migration_blocker(pbdev);
> >           qdev_unrealize(dev);
> >       }
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


