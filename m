Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B51C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 07:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCZ24-0008WG-LY; Wed, 07 May 2025 03:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCZ23-0008Vr-9S
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCZ21-0005sH-D1
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746602248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZIkCvJIuf4jYdmTNfAgY6Dihn0ApFOiX54QYNWVmpBY=;
 b=h6vKzav1PpIbpkiDiY8bwxQN437DqfocYCQFUqV0PaAnwrAuYUwegGWA9gjV3Nyg3zA6zX
 4zHi4GIGE8kFEQEvsbl2drsayKTKdpJO0mNEXkysO4f0izr3mvMqeSGDYQxHsOUXQdtBjX
 /eKnTxTtkBVkkkbp3dod6TPtKi543Uk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-5YgLfgqzN2az4tHIVNc9xQ-1; Wed,
 07 May 2025 03:17:25 -0400
X-MC-Unique: 5YgLfgqzN2az4tHIVNc9xQ-1
X-Mimecast-MFC-AGG-ID: 5YgLfgqzN2az4tHIVNc9xQ_1746602242
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B0571800446; Wed,  7 May 2025 07:17:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A85019560A7; Wed,  7 May 2025 07:17:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 78E8F21E66C2; Wed, 07 May 2025 09:17:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Donald Dutile <ddutile@redhat.com>
Cc: Shameer Kolothum via <qemu-devel@nongnu.org>,  qemu-arm@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 eric.auger@redhat.com,  peter.maydell@linaro.org,  jgg@nvidia.com,
 nicolinc@nvidia.com,  berrange@redhat.com,  nathanc@nvidia.com,
 mochs@nvidia.com,  smostafa@google.com,  linuxarm@huawei.com,
 wangzhou1@hisilicon.com,  jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com,  zhangfei.gao@linaro.org
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
In-Reply-To: <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com> (Donald
 Dutile's message of "Tue, 6 May 2025 16:48:57 -0400")
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
Date: Wed, 07 May 2025 09:17:18 +0200
Message-ID: <87frhglwjl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Donald Dutile <ddutile@redhat.com> writes:

[...]

> In this series, an iommu/smmu needs to be placed -BETWEEN- a sysbus and a PCIe-tree,
> or step-wise, plug an smmuv3 into a sysbus, and a pcie tree/domain/RC into an SMMUv3.

RC = root complex?

> So, an smmu needs to be associated with a bus (tree), i.e., pcie.0, pcie.1...
> One could model it as a PCIe device, attached at the pcie-RC ... but that's not how it's modelled in ARM hw.

Physical ARM hardware?

Assuming the virtual devices and buses we're discussing model physical
devices and buses:

* What are the physical devices of interest?

* How are they wired together?  Which of the wires are buses, in
  particular PCI buses?

> SMMU's are discovered via ACPI tables.
>
> That leaves us back to the 'how to associate an SMMUv3 to a PCIe tree(RC)',
> and that leads me to the other discussion & format I saw btwn Eric & Shameer:
>  -device arm-smmv3,id=smmuv3.3
>  -device xxxx,smmuv3= smmuv3.3
> where one tags a (PCIe) device to an smmuv3(id), which is needed to build the (proper) IORT for (pcie-)device<->SMMUv3 associativity in a multi-SMMUv3 configuration.
>
> We could keep the bus=pcie.X option for the -device arm-smmuv3 to indicate that all PCIe devices connected to the pcie.0 tree go through that smmuv3;
> qdev would model/config as the smmuv3 is 'attached to pcie.0'... which it sorta is...  and I think the IORT build could associate all devices on pcie.0 to be associated
> with the proper smmuv3.

Device property "bus" is strictly for specifying into which the bus the
device is to be plugged.  The device's type must match the bus: only a
PCI device can plug into a PCI bus, and so forth.

A PCI device has a PCI address (dev.fn) on the bus it's plugged into.
If that's not the case for a physical smmuv3, we should not make the
virtual smmuv3 a PCI device.

Is there any prior art in QEMU, or is this the first device of this
kind?


