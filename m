Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1634C28B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 12:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tshJm-0008RH-7t; Thu, 13 Mar 2025 08:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tshJe-0008PG-G7
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tshJX-0007dn-Gh
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741867523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=DUoeT18UWkXNBuWXjXC0UblShu8wB0YW5cfql0LI7S8=;
 b=PlCm09uEUfsO/ZHBqr7mq1+NmV3RkUyhm8hNtYq/ltuePSEKqXLuZPmMckqM3BZcPmHTUP
 4Z/maloeJLHAd26tjjdUl2SPUUneDuWMmrOsRbg/vUtuXUdCQwXFmqtAARo1JzzM6DC0vP
 O1e3r7NRAkNLf+hTYFxQZ0NvmI2k29M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-DTJqATdROSu8uKIIgk7tRQ-1; Thu,
 13 Mar 2025 08:05:19 -0400
X-MC-Unique: DTJqATdROSu8uKIIgk7tRQ-1
X-Mimecast-MFC-AGG-ID: DTJqATdROSu8uKIIgk7tRQ_1741867518
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68311180AF56; Thu, 13 Mar 2025 12:05:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.205])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 674B019560AB; Thu, 13 Mar 2025 12:05:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 030B11800094; Thu, 13 Mar 2025 13:05:14 +0100 (CET)
Date: Thu, 13 Mar 2025 13:05:13 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> The devil lies in "same order of setup calls". Without a way to define
> this order through the vmfwupdate interface there is a lot of implicit
> knowledge required about how KVM/QEMU setup the TEE context to calculate
> the expected after-reset launch measurement. Even worse, the exact way
> this setup is done then becomes ABI, because any change in this process
> will lead to a different launch measurement.
> 
> Some examples of initial memory layout calls which influence the launch
> measurment:
> 
> 	1) Launch VMSA(s) (SEV-SNP only, though I believe on TDX the
> 	   initial register state can also be changed to some
> 	   degree).
> 	2) Pre-Validated/Accepted memory regions (TDX and SEV-SNP). This
> 	   is especially important, as different FWs have different
> 	   requirements on what memory is pre-validated, zeroed, etc.
> 	3) Zero-pages, measured and unmeasured (TDX and SEV-SNP).
> 	4) Position of the CPUID page, secrets page, and id-blob
> 	   (SEV-SNP).
> 	5) Pre-populated data (TDX and SEV-SNP).
> 
> If I understand the vmfwupdate interface correctly, and please let me
> know if I am wrong here, it only allows to specify a call for part 5) of
> the above list. Some of the other parts can be specified in architecture
> dependent ways in the FW image itself, but not all of them.

v6 patch is outdated, latest approach is to pass a list of regions:

// regions_addr points to an array of this structure
struct vmfwupdate_regions {
    uint64_t size;
    uint64_t src_addr;       // source address (before update)
    uint64_t dst_addr;       // destination address (after update)
    uint64_t flags;          // control bits
};

// flags
#define VMFWUPDATE_REGION_FLAG_COPY     // data must be copied
#define VMFWUPDATE_REGION_FLAG_ZERO     // dest must be cleared
#define VMFWUPDATE_REGION_FLAG_MEASURE  // data must be measured

(1)   is still not covered.
(2+3) can be handled with FLAG_ZERO regions, with and without
      FLAG_MEASURE.
(4)   Alex already pointed that the cpuid page is special, guess we
      need additional flags for those oages.

Open question is what we do about IGVM.

One option would be the guest vmfwupdate tool loading and parsing igvm,
preparing the region list, then invoke the update.  Problem is that some
igvm feaures such as initial register state can not be easily supported
that way.

We could also expect the hypervisor support igvm, so the guest can
simply load the file into memory and pass address and size to the
hypervisor.  Either as option, say via VMFWUPDATE_REGION_FLAG_IGVM, or
mandatory, i.e. scratch the region list and use IGVM exclusively.

take care,
  Gerd


