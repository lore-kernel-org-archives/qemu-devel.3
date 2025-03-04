Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9E4C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 18:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpXN8-00078g-2j; Tue, 04 Mar 2025 13:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpXMv-00076l-3I
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 13:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpXMr-00009c-5e
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 13:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741114306;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+rOoTF5vT9PFsxUPw9Ct9diTksemZvlYYDAh+19S/Q=;
 b=PCJRdjGHrxPLQeMpiI3DhhsktlcvKn6SxApiKFqliBtTHwSeEmH7r/GVl7BeqwlNahIehF
 /YNtQEhltQPw0n5gYb5h6rlhD6VPG4fRo+KJtzJcTHG8/X8+FxewS41BETPh2moCFITeXf
 /qW62YcNmpFzgoI7W7VvansOwJ6gPaU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-nOGHPyMlO1aI0Mj3VdbweQ-1; Tue,
 04 Mar 2025 13:51:45 -0500
X-MC-Unique: nOGHPyMlO1aI0Mj3VdbweQ-1
X-Mimecast-MFC-AGG-ID: nOGHPyMlO1aI0Mj3VdbweQ_1741114303
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F5321801A2F; Tue,  4 Mar 2025 18:51:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.210])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D078B19560AA; Tue,  4 Mar 2025 18:51:38 +0000 (UTC)
Date: Tue, 4 Mar 2025 18:51:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 bsd@redhat.com, joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v4 1/2] hw/i386/amd_iommu: Isolate AMDVI-PCI from
 amd-iommu device to allow full control over the PCI device creation
Message-ID: <Z8dLt5kbiDjqBRUa@redhat.com>
References: <20250304141716.638880-1-suravee.suthikulpanit@amd.com>
 <20250304141716.638880-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304141716.638880-2-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Mar 04, 2025 at 02:17:15PM +0000, Suravee Suthikulpanit wrote:
> Current amd-iommu model internally creates an AMDVI-PCI device. Here is
> a snippet from info qtree:
> 
>   bus: main-system-bus
>     type System
>     dev: amd-iommu, id ""
>       xtsup = false
>       pci-id = ""
>       intremap = "on"
>       device-iotlb = false
>       pt = true
>     ...
>     dev: q35-pcihost, id ""
>       MCFG = -1 (0xffffffffffffffff)
>       pci-hole64-size = 34359738368 (32 GiB)
>       below-4g-mem-size = 134217728 (128 MiB)
>       above-4g-mem-size = 0 (0 B)
>       smm-ranges = true
>       x-pci-hole64-fix = true
>       x-config-reg-migration-enabled = true
>       bypass-iommu = false
>       bus: pcie.0
>         type PCIE
>         dev: AMDVI-PCI, id ""
>           addr = 01.0
>           romfile = ""
>           romsize = 4294967295 (0xffffffff)
>           rombar = -1 (0xffffffffffffffff)
>           multifunction = false
>           x-pcie-lnksta-dllla = true
>           x-pcie-extcap-init = true
>           failover_pair_id = ""
>           acpi-index = 0 (0x0)
>           x-pcie-err-unc-mask = true
>           x-pcie-ari-nextfn-1 = false
>           x-max-bounce-buffer-size = 4096 (4 KiB)
>           x-pcie-ext-tag = true
>           busnr = 0 (0x0)
>           class Class 0806, addr 00:01.0, pci id 1022:0000 (sub 1af4:1100)
>     ...
> 
> This prohibits users from specifying the PCI topology for the amd-iommu device,
> which becomes a problem when trying to support VM migration since it does not
> guarantee the same enumeration of AMD IOMMU device.
> 
> Therfore, decouple the AMDVI-PCI from amd-iommu device and introduce pci-id
> parameter to link between the two devices.

Suggest slightly rewording to make it clear this new approach is opt-in:

 Therefore, allow the 'AMDVI-PCI' device to optionally be pre-created and
 associated with a 'amd-iommu' device via a new 'pci-id' parameter on the
 latter.

> 
> For example:
>   -device AMDVI-PCI,id=iommupci0,bus=pcie.0,addr=0x05 \
>   -device amd-iommu,intremap=on,pt=on,xtsup=on,pci-id=iommupci0 \
> 
> For backward-compatibility, internally create the AMDVI-PCI device if not
> specified on the CLI.
> 
> Co-developed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  hw/i386/acpi-build.c |  8 +++----
>  hw/i386/amd_iommu.c  | 52 +++++++++++++++++++++++++++-----------------
>  hw/i386/amd_iommu.h  |  3 ++-
>  3 files changed, 38 insertions(+), 25 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


