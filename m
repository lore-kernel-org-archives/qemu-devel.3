Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7076AC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 13:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdr88-0002gj-C9; Fri, 31 Jan 2025 08:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tdr7v-0002fq-8r
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:32:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tdr7t-0006zM-NM
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738330322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxldpuGbtOAylxynDZXG+yxBsTR164Rf3IvINXRAy6Y=;
 b=Ka5b5EIHKuGdAqbuohz/7EcLVMTNsM7FGpZHLxo1/go4iPogj+CKMkWu+bB8rtrDAXrFwl
 NJfNt7T14dXxBW1Umc/dQETvryktYKuqlQ+uJ1DQl1PKKyxuwPte9kEDD6UeH/y7MdQDag
 +utvB3qZMnjp/s0uuX0pASD3xwhjJ04=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-FTXVPYyFNraW-wYJFuTQjw-1; Fri,
 31 Jan 2025 08:32:00 -0500
X-MC-Unique: FTXVPYyFNraW-wYJFuTQjw-1
X-Mimecast-MFC-AGG-ID: FTXVPYyFNraW-wYJFuTQjw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2AB31956083
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:31:59 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.39.193.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 223FA19560AA; Fri, 31 Jan 2025 13:31:59 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 17D712EE2E9; Fri, 31 Jan 2025 14:23:58 +0100 (CET)
Date: Fri, 31 Jan 2025 14:23:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU
 address space width
Message-ID: <24w7fzx5rf2zdnowtjmuvwuirydryc366xumjf3isgzrhei2ty@ymyjyzdbggr2>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
 <20250130115800.60b7cbe6.alex.williamson@redhat.com>
 <9cfaf81e-d8cc-4ec0-9c56-956b716891e7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cfaf81e-d8cc-4ec0-9c56-956b716891e7@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 31, 2025 at 01:42:31PM +0100, Cédric Le Goater wrote:
> + Gerd for insights regarding vIOMMU support in edk2.
> 
> > > +static bool vfio_device_check_address_space(VFIODevice *vbasedev, Error **errp)
> > > +{
> > > +    uint32_t cpu_aw_bits = cpu_get_phys_bits(first_cpu);
> > > +    uint32_t iommu_aw_bits = vfio_device_get_aw_bits(vbasedev);
> > > +
> > > +    if (cpu_aw_bits && cpu_aw_bits > iommu_aw_bits) {
> > 
> > Should we be testing the 64-bit MMIO window and maximum RAM GPA rather
> > than the vCPU physical address width?

Placing the 64-bit  mmio window is done by the guest firmware,
so this isn't something qemu can check before boot.

> > However, we've decided to do exactly that for the 64-bit MMIO window.
> > It's not that the vCPU width being greater than the IOMMU width is a
> > fundamental problem, it's that we've chosen a 64-bit MMIO policy that
> > makes this become a problem and QEMU only has a convenient mechanism to
> > check the host IOMMU width when a vfio device is present.  Arguably,
> > when a vIOMMU is present guest firmware should be enlightened to
> > understand the address width of that vIOMMU when placing the 64-bit
> > MMIO window.  I'd say the failure to do so is a current firmware bug.

edk2 has no iommu driver ...

Is there some simple way to figure what the iommu width is (inside the
guest)?

Note that there is a 'guest-phys-bits' property for x86 CPUs, which is a
hint for the guest what the usable address width is.  It was added
because there are cases where the guest simply can't figure that it is
not possible to use the full physical address space of the cpu.  There
are some non-obvious limitations around 5-level paging.  Intel has some
CPUs with phys-bits > 48 but only 4-level EPT for example.

So one option to handle this is to make sure guest-phys-bits is not
larger than the iommu width.

take care,
  Gerd


