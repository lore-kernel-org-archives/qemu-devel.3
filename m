Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15B1C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkoMd-0000oe-8l; Wed, 19 Feb 2025 13:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkoMb-0000nW-0m
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkoMZ-00023q-2y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739987996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=721aHFcs2gDmNkVJKUVLmGwc0nAgx68r9DjMe0IKIh8=;
 b=iBDr/GwjlT+phq3bglmjgjmCWaSZhosBwgwcAJy++IixUW02Qp55N5v89g5yCaB4f9IffB
 /8ZXscovK6ArbcgfwDf3rXqPxp+OKD9VBX8EkQ6+GlOrDnrOs54syPdqWRjlKe98ztuwBp
 ZYiOegtL2USfqg+vblBdcVRmLLhEIc0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-MjOT7nNjN7-WsD6hezY1Jw-1; Wed,
 19 Feb 2025 12:59:53 -0500
X-MC-Unique: MjOT7nNjN7-WsD6hezY1Jw-1
X-Mimecast-MFC-AGG-ID: MjOT7nNjN7-WsD6hezY1Jw_1739987993
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D519018EAB3A; Wed, 19 Feb 2025 17:59:52 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.254])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A93F180087E; Wed, 19 Feb 2025 17:59:49 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, zhenzhong.duan@intel.com
Subject: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in d3hot
 state
Date: Wed, 19 Feb 2025 18:58:58 +0100
Message-ID: <20250219175941.135390-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

Since kernel commit:
2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
in D3hot power state")
any attempt to do an mmap access to a BAR when the device is in d3hot
state will generate a fault.

On system_powerdown, if the VFIO device is translated by an IOMMU,
the device is moved to D3hot state and then the vIOMMU gets disabled
by the guest. As a result of this later operation, the address space is
swapped from translated to untranslated. When re-enabling the aliased
regions, the RAM regions are dma-mapped again and this causes DMA_MAP
faults when attempting the operation on BARs.

To avoid doing the remap on those BARs, we compute whether the
device is in D3hot state and if so, skip the DMA MAP.

This series can be found at:
https://github.com/eauger/qemu/tree/d3hot_dma_map


Eric Auger (2):
  hw/vfio: Introduce vfio_is_dma_map_allowed() callback
  hw/vfio/pci: Prevents BARs from being dma mapped in d3hot state

 hw/vfio/common.c              | 57 +++++++++++++++++++++--------------
 hw/vfio/pci.c                 | 22 ++++++++++++++
 hw/vfio/trace-events          |  1 +
 include/hw/vfio/vfio-common.h | 11 +++++++
 4 files changed, 69 insertions(+), 22 deletions(-)

-- 
2.47.1


