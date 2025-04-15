Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7B8C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cdg-00070j-Ew; Tue, 15 Apr 2025 05:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4cdH-0006v1-O5
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4cdF-000354-5S
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744709463;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=C94tr+jixKhsnt7SGY9mXCayUlxMp6mwPtpKTnMYhdM=;
 b=jMnlu7rwcPqgv0uqzb129VqR0tRuhtkoIodbMMGp2p7H5HKZgXI4Tm5FkM7eoHnCGP2aWt
 7OxObSbNwK04SZYVyBevhPXB5gGgv5asvWnEkJ0OLMLA3K4ozmrSjsYZPzgEVzC/Cn0ITs
 XbI3DG272rWHYL4aYE1imWaXlDN87+s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-d4kGaj37ME-eoeMkqpG0hw-1; Tue,
 15 Apr 2025 05:30:58 -0400
X-MC-Unique: d4kGaj37ME-eoeMkqpG0hw-1
X-Mimecast-MFC-AGG-ID: d4kGaj37ME-eoeMkqpG0hw_1744709456
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87D5919560BB; Tue, 15 Apr 2025 09:30:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D28331808869; Tue, 15 Apr 2025 09:30:49 +0000 (UTC)
Date: Tue, 15 Apr 2025 10:30:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linuxarm@huawei.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH 4/5] hw/arm/virt: Add support for smmuv3 device
Message-ID: <Z_4nRnwNOylcENYh@redhat.com>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
 <20250415081104.71708-5-shameerali.kolothum.thodi@huawei.com>
 <20250415102542.00007fd7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415102542.00007fd7@huawei.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Apr 15, 2025 at 10:25:42AM +0100, Jonathan Cameron wrote:
> On Tue, 15 Apr 2025 09:11:03 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> 
> > Allow cold-plug of smmuv3 device to virt If the machine wide smmuv3
> > or a virtio-iommu is not specified.
> > 
> > Also restrict the usage if virt <= 9.2. This will prevent accidently
> > creating a SMMUv3 device on machines prior to 9.2 and cause failure
> > on migrating to machines with same version but has a legacy smmuv3
> > device.
> 
> Hi,
> 
> As we discussed internally I'm not convinced we need to prevent this particular
> way for a user to shoot themselves in the foot.
> 
> To be a problem they have to specifically request an old machine + the
> device that didn't exist for that machine, then migrate to a real old
> version of QEMU.  Agreed it is possible but I'm not sure we need to
> prevent that particular crazy.

Agreed, there are a million ways to screw up using old machine types
with new features, so there's no compelling need to single out smmu for
special protection in this respect.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


