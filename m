Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2849C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsP7O-0002NV-O4; Wed, 12 Mar 2025 12:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsP7I-0002ML-1U
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsP7F-0004n1-NQ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741797571;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hpe2W+Dkw0YBLMVG1GZ0GpT5m6A3qjGlwirPj3HlREs=;
 b=E5tOd0iT9MFdpBGS6U53A02M/lzsuIefwtR5GngfSa2uiW8VjgYZuAKlyeyyIdR9+4Hr9w
 4jtDuLWzj5GHqyLrWbFrvGVbolYfSV7Ib5dcYgGgXVAmcjaepzRfP1YEOeeEOzEjtXhw5Z
 E7Dgyzu81RlqzhNVCTzlDQe/X17ve0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-ILaNx7quPZ6PLyUsjPAsQw-1; Wed,
 12 Mar 2025 12:39:27 -0400
X-MC-Unique: ILaNx7quPZ6PLyUsjPAsQw-1
X-Mimecast-MFC-AGG-ID: ILaNx7quPZ6PLyUsjPAsQw_1741797565
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A18319560B2; Wed, 12 Mar 2025 16:39:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAA9A19560AD; Wed, 12 Mar 2025 16:39:17 +0000 (UTC)
Date: Wed, 12 Mar 2025 16:39:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Message-ID: <Z9G4sj9sHNYb1t78@redhat.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <79bcc36c-1a12-4b18-a54c-afe734d6bef0@redhat.com>
 <9ffee8119fc441aeb760073c5f152fa4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ffee8119fc441aeb760073c5f152fa4@huawei.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 12, 2025 at 04:34:18PM +0000, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
> > -----Original Message-----
> > From: Eric Auger <eric.auger@redhat.com>
> > Sent: Wednesday, March 12, 2025 4:08 PM
> > To: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
> > qemu-devel@nongnu.org
> > Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
> > ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
> > mochs@nvidia.com; smostafa@google.com; Linuxarm
> > <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> > Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
> > pcie bus
> > 
> > Hi Shameer,
> > 
> > 
> > On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> > > User must associate a pxb-pcie root bus to smmuv3-accel
> > > and that is set as the primary-bus for the smmu dev.
> > why do we require a pxb-pcie root bus? why can't pci.0 root bus be used
> > for simpler use cases (ie. I just want to passthough a NIC in
> > accelerated mode). Or may pci.0 is also called a pax-pcie root bus?
> 
> The idea was since pcie.0 is the default RC with virt, leave that to cases where
> we want to attach any emulated devices and use pxb-pcie based RCs for vfio-pci.

The majority of management applications will never do anything other
than a flat PCI(e) topology by default. Some might enable pxb-pcie as
an optional but plenty won't ever support it. If you want to maximise
the potential usefulness of the ssmmuv3-accel, and it is technically
viable, it would be worth permitting choice of attachment to the root
bus as an alteranative to the pxb.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


