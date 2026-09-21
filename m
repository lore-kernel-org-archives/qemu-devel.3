Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D430EC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8fnh-0008Ki-49; Mon, 21 Sep 2026 11:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8fnf-0008Jy-CA
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 11:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8fnd-0005uB-1Z
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 11:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790003959;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/7wST/fd/3Zl3ROTkIII+r6L667gezrRkHIS9tV4Uc=;
 b=Ac7L1YUehKNopNcm1WulDFMIg2kNtzNdfyA3GS007td6CkYglwvgkUK+2NMgWm2hHGcsfZ
 lHCRYLN9mCKYxEu27aZ4xJBMTEQ6STg+I3qQvPhekJEliOOZNfjeLALI5eeMCdANWtqiCT
 eiQbfEGKbx9T93X4OTg9/Owlq2d31N4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-UcjhciGFM5-OrvlGmswixw-1; Mon,
 21 Sep 2026 11:19:14 -0400
X-MC-Unique: UcjhciGFM5-OrvlGmswixw-1
X-Mimecast-MFC-AGG-ID: UcjhciGFM5-OrvlGmswixw_1790003952
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 107CB184B3B8; Mon, 21 Sep 2026 15:19:12 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 014681956089; Mon, 21 Sep 2026 15:19:08 +0000 (UTC)
Date: Mon, 21 Sep 2026 16:19:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 15/16] s390x/pci: Implement migration for emulated
 devices
Message-ID: <arFK6US5kWAMvDPp@redhat.com>
References: <20260911152137.676602-1-kshk@linux.ibm.com>
 <20260911152137.676602-16-kshk@linux.ibm.com>
 <7a2ec98c-6756-4c9f-8f86-1b0db94c8053@linux.ibm.com>
 <aqwkyvY8mxIEqDyH@redhat.com>
 <0e59d36a-4757-4dc6-a72d-a2f185db835c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e59d36a-4757-4dc6-a72d-a2f185db835c@linux.ibm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 21, 2026 at 10:12:34AM -0500, Konstantin Shkolnyy wrote:
> On 260917 12:35, Daniel P. Berrangé wrote:
> > On Thu, Sep 17, 2026 at 10:25:32AM -0700, Farhan Ali wrote:
> > > 
> > > On 9/11/2026 8:21 AM, Konstantin Shkolnyy wrote:
> > > > @@ -1303,11 +1380,22 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > > >            pbdev = S390_PCI_DEVICE(dev);
> > > >            pbdev->fid = 0;
> > > >            QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
> > > > -        g_hash_table_remove(s->zpci_table, &pbdev->idx);
> > > > +        /*
> > > > +         * If this QEMU is running a migrated guest, and was configured with
> > > > +         * more zpci devices than the source QEMU, extra zpci devices could be
> > > > +         * excluded from zpci_table and invisible to the guest and have
> > > > +         * pbdev->idx values duplicating those of active devices. If the
> > > > +         * pbdev being unplugged is such, the zpci_table entry for pbdev->idx
> > > > +         * can find a different pbdev which we must not remove.
> > > > +         */
> > > > +        if (g_hash_table_lookup(s->zpci_table, &pbdev->idx) == pbdev) {
> > > > +            g_hash_table_remove(s->zpci_table, &pbdev->idx);
> > > > +        }
> > > 
> > > If we are migrating, won't we re-create the exact same state and devices on
> > > the target host? Is it possible that the target QEMU can have more devices
> > > than source?
> > 
> > It is expected that the source and dest QEMU processes have identical
> > virtual hardware configuration, and also no attempts should be made to
> > hot-add/remove devices while migration is running.
> 
> Do you suggest to completely delete this hunk, or keep as "defensive tactic"
> and correct the comment?

I don't think it is worth trying to add defensive checks, as if the
config is not identical, the code may well not even be reached as
vmstate parsing/loading typically fails during migration.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


