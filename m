Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE669EB48E8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSPC-0002en-JP; Thu, 12 Feb 2026 03:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSPA-0002a0-HA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSP8-0001bm-Th
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770886230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTMUfTLBP3siZVKRvBSgPtyl1JF9n3OVxDFJEwc5d4U=;
 b=OX4vSwSbn2wyobLBFm1E5i4K0tslbHgARcKUbp3fQ62F0zSqBuSqYz0ppOqcLVqNePvn0P
 XdBHAD34LWD+hhu0wCvsghjDRmz9Wp/K897dRFSDvP8m2IlWIIU4VytODzNW81Qq/PZ0iv
 RjCJvwcSi0e68jItakcE9yTcx+QYxi4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-pe3hKnePOGm3dWRbJAnM1A-1; Thu,
 12 Feb 2026 03:49:50 -0500
X-MC-Unique: pe3hKnePOGm3dWRbJAnM1A-1
X-Mimecast-MFC-AGG-ID: pe3hKnePOGm3dWRbJAnM1A_1770886189
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DBFE19560B2; Thu, 12 Feb 2026 08:49:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A408130001B9; Thu, 12 Feb 2026 08:49:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jaehoon Kim <jhkim@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 05/14] s390x/pci: Fix endianness for zPCI BAR values.
Date: Thu, 12 Feb 2026 09:49:18 +0100
Message-ID: <20260212084927.258642-6-thuth@redhat.com>
In-Reply-To: <20260212084927.258642-1-thuth@redhat.com>
References: <20260212084927.258642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jaehoon Kim <jhkim@linux.ibm.com>

During zPCI scan, BAR configuration data retrieved via CLP Query was
misinterpreted due to an endianness mismatch between QEMU and the guest
kernel.

The guest kernel's clp_store_query_pci_fn() expects BAR values in
little-endian format and converts them with le32_to_cpu(). However, QEMU
was incorrectly sending them in big-endian format, not following the
architecture specification. This caused incorrect bit-swapping in the
kernel, leading zpci_setup_bus_resources() to perform registration checks
against invalid flags, making the process ineffective.

Observation values for zPCI device (NVMe passthrough):
LPAR from real CLP:
[    0.865595] Resource: PCI Bus 0000:00 -> zdev->bar[0].val: 0x4
[    0.865597]  start: 0x4000000000000000
[    0.865598]  end:   0x4000000000003fff
[    0.865600]  flags: 0x100200

QEMU before fix (wrong):
[    0.601083] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4000000
[    0.601085]  start: 0x4003000000000000
[    0.601086]  end:   0x4003000000003fff
[    0.601087]  flags: 0x200

QEMU after fix (correct):
[    0.601116] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4
[    0.601117]  start: 0x4003000000000000
[    0.601118]  end:   0x4003000000003fff
[    0.601119]  flags: 0x100200

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20260206164645.1845366-1-jhkim@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 6b67c3c109f..10066ca6180 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -307,7 +307,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
             uint32_t data = pci_get_long(pbdev->pdev->config +
                 PCI_BASE_ADDRESS_0 + (i * 4));
 
-            stl_be_p(&resquery->bar[i], data);
+            stl_le_p(&resquery->bar[i], data);
             resquery->bar_size[i] = pbdev->pdev->io_regions[i].size ?
                                     ctz64(pbdev->pdev->io_regions[i].size) : 0;
             trace_s390_pci_bar(i,
-- 
2.53.0


