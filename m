Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E2EC0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 16:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdXc8-00061W-GC; Thu, 30 Jan 2025 11:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tdXc3-0005xU-SV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 11:41:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tdXc1-0005Xs-I2
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 11:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738255310;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3arpfGjz6zW/uQSYzu6lLVfacbd5PeZ0F2jl58xZJ9I=;
 b=XiB85PDsJ78cfQ70Ai6pBH0pjL+5W5LINUPYFoNcD2gl5PfF4GecxTcza5TqWcmJv0gHrg
 SwyEHhfD9A7hFda9UBBXezYHsFK4wAKNloWFww3tuK+XzADU3nTznt6BxEbMoyW7JNDJv9
 eaVjhfHyKs2WudsSW0P1XxvpkPqD/+w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-s5c8dsQbO0KASBhwAG12-g-1; Thu,
 30 Jan 2025 11:41:47 -0500
X-MC-Unique: s5c8dsQbO0KASBhwAG12-g-1
X-Mimecast-MFC-AGG-ID: s5c8dsQbO0KASBhwAG12-g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B2D01801F1F; Thu, 30 Jan 2025 16:41:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.184])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35AAE18008D8; Thu, 30 Jan 2025 16:41:39 +0000 (UTC)
Date: Thu, 30 Jan 2025 16:41:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z5urwACWPO7CiQYN@redhat.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <8ce24003-66ad-43da-b68a-14686758a85a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ce24003-66ad-43da-b68a-14686758a85a@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Nov 18, 2024 at 11:50:46AM +0100, Eric Auger wrote:
> Hi Shameer,
> 
> On 11/8/24 13:52, Shameer Kolothum wrote:
> > Hi,
> >
> > This series adds initial support for a user-creatable "arm-smmuv3-nested"
> > device to Qemu. At present the Qemu ARM SMMUv3 emulation is per machine
> > and cannot support multiple SMMUv3s.
> >
> > In order to support vfio-pci dev assignment with vSMMUv3, the physical
> > SMMUv3 has to be configured in nested mode. Having a pluggable
> > "arm-smmuv3-nested" device enables us to have multiple vSMMUv3 for Guests
> > running on a host with multiple physical SMMUv3s. A few benefits of doing
> > this are,
> >
> > 1. Avoid invalidation broadcast or lookup in case devices are behind
> >    multiple phys SMMUv3s.
> > 2. Makes it easy to handle phys SMMUv3s that differ in features.
> > 3. Easy to handle future requirements such as vCMDQ support.
> >
> > This is based on discussions/suggestions received for a previous RFC by
> > Nicolin here[0].
> >
> > This series includes,
> >  -Adds support for "arm-smmuv3-nested" device. At present only virt is
> >   supported and is using _plug_cb() callback to hook the sysbus mem
> >   and irq (Not sure this has any negative repercussions). Patch #3.
> >  -Provides a way to associate a pci-bus(pxb-pcie) to the above device.
> >   Patch #3.
> >  -The last patch is adding RMR support for MSI doorbell handling. Patch #5.
> >   This may change in future[1].
> >
> > This RFC is for initial discussion/test purposes only and includes patches
> > that are only relevant for adding the "arm-smmuv3-nested" support. For the
> > complete branch please find,
> > https://github.com/hisilicon/qemu/tree/private-smmuv3-nested-dev-rfc-v1
> >
> > Few ToDos to note,
> > 1. At present default-bus-bypass-iommu=on should be set when
> >    arm-smmuv3-nested dev is specified. Otherwise you may get an IORT
> >    related boot error.  Requires fixing.
> > 2. Hot adding a device is not working at the moment. Looks like pcihp irq issue.
> >    Could be a bug in IORT id mappings.
> > 3. The above branch doesn't support vSVA yet.
> >
> > Hopefully this is helpful in taking the discussion forward. Please take a
> > look and let me know.
> >
> > How to use it(Eg:):
> >
> > On a HiSilicon platform that has multiple physical SMMUv3s, the ACC ZIP VF
> > devices and HNS VF devices are behind different SMMUv3s. So for a Guest,
> > specify two smmuv3-nested devices each behind a pxb-pcie as below,
> >
> > ./qemu-system-aarch64 -machine virt,gic-version=3,default-bus-bypass-iommu=on \
> > -enable-kvm -cpu host -m 4G -smp cpus=8,maxcpus=8 \
> > -object iommufd,id=iommufd0 \
> > -bios QEMU_EFI.fd \
> > -kernel Image \
> > -device virtio-blk-device,drive=fs \
> > -drive if=none,file=rootfs.qcow2,id=fs \
> > -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> > -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \
> > -device arm-smmuv3-nested,id=smmuv1,pci-bus=pcie.1 \
> > -device vfio-pci,host=0000:7d:02.1,bus=pcie.port1,iommufd=iommufd0 \
> > -device pxb-pcie,id=pcie.2,bus_nr=16,bus=pcie.0 \
> > -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2 \
> > -device arm-smmuv3-nested,id=smmuv2,pci-bus=pcie.2 \
> > -device vfio-pci,host=0000:75:00.1,bus=pcie.port2,iommufd=iommufd0 \
> > -append "rdinit=init console=ttyAMA0 root=/dev/vda2 rw earlycon=pl011,0x9000000" \
> > -device virtio-9p-pci,fsdev=p9fs2,mount_tag=p9,bus=pcie.0 \
> > -fsdev local,id=p9fs2,path=p9root,security_model=mapped \
> This kind of instantiation matches what I had in mind. It is
> questionable whether the legacy SMMU shouldn't be migrated to that mode
> too (instead of using a machine option setting), depending on Peter's
> feedbacks and also comments from Libvirt guys. Adding Andrea in the loop.

Yeah, looking at the current config I'm pretty surprised to see it
configured with '-machine virt,iommu=ssmuv3', where 'smmuv3' is a
type name. This effectively a back-door reinvention of the '-device'
arg.

I think it'd make more sense to deprecate the 'iommu' property
on the machine, and allow '-device ssmu3,pci-bus=pcie.0' to
associate the IOMMU with the PCI root bus, so we have consistent
approaches for all SMMU impls.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


