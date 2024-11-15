Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4044D68BCF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 18:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC19O-0001rg-EC; Fri, 15 Nov 2024 13:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC19K-0001rJ-B5
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 13:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC19I-0003LU-QR
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 13:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731695666;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfIatV40AKo+DheOGmVH14j20IFcpkpDZBMeqPsxiIs=;
 b=aL3eI36F6b1/nHA9yRaNhBMtysk2q/eptCc+ZMZ1gbYDMjjS7HvK4fygbhFbF6uTuRmg8A
 n0ip1r743YBdwtKYsh1Pw82qUdUa0szwiGeqO4D9TC2FWMhGoFaSEZ4fReJVi1Hzmmcn7d
 Qhs6BmQAGREjjte7ZAZfAoL+AXW4A7s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-IxYRIMcLNrmkiYS1sMjaTw-1; Fri,
 15 Nov 2024 13:34:24 -0500
X-MC-Unique: IxYRIMcLNrmkiYS1sMjaTw-1
X-Mimecast-MFC-AGG-ID: IxYRIMcLNrmkiYS1sMjaTw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4E8F19560B8
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 18:34:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EFD419560A3; Fri, 15 Nov 2024 18:34:21 +0000 (UTC)
Date: Fri, 15 Nov 2024 18:34:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 1/9] hw: eliminate qdev_try_new, isa_try_new &
 usb_try_new
Message-ID: <ZzeUKvl2PCVa7g4j@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
 <20241115172521.504102-2-berrange@redhat.com>
 <ZzeKwvuYPRfjaP-X@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzeKwvuYPRfjaP-X@x1n>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 15, 2024 at 12:54:10PM -0500, Peter Xu wrote:
> On Fri, Nov 15, 2024 at 05:25:13PM +0000, Daniel P. Berrangé wrote:
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 40b2567aa7..558f17d3ba 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -922,11 +922,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
> >      Error *local_err = NULL;
> >      DeviceState *dev;
> >  
> > -    dev = qdev_try_new(TYPE_S390_PCI_DEVICE);
> > -    if (!dev) {
> > -        error_setg(errp, "zPCI device could not be created");
> > -        return NULL;
> > -    }
> > +    dev = qdev_new(TYPE_S390_PCI_DEVICE);
> 
> This one used to allow failures, but now it asserts.  Especially, see:
> 
> b6e67ecc7b ("s390x/pci: properly fail if the zPCI device cannot be created")
> 
> Would it be safer to use module_object_class_by_name() too here?

Yes, my bad. I was mixed up with the HPET case which did exit(), this
one must propagate the error.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


