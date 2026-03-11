Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C75112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L5B-0004Ql-O0; Wed, 11 Mar 2026 11:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L4u-0004Ng-Ka; Wed, 11 Mar 2026 11:02:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L4r-0003hf-7w; Wed, 11 Mar 2026 11:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241303; bh=UC2nUUBeCWy1t4hy/Y/w1gkN+VN65Za29soopU2COAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tT/x3ElPClmO86Og2SN6dW2QCLS5wfhwFMUhvs2M80t9T+HaMv5WdcZEkSBQ4CfkN
 oMke3LGLGCrFCIo7PJ2FwnqIYIBDY+4tQhizeuTjxk3YT3TvoXNntrmq1ftCIVaUWS
 vWUsdgYP5u2lSbxcNReuNFeIo1nqejQHNdRmxf1vEKZ0HMFEko1jvlhw+fUYQHVKes
 6OdirRF5RghUW8KceodQkkdqur8qDsT1KrhuEBKSrfy2PQF9MJyqjn2uIQjIjYHVYy
 BoawijxNLcXphhwd9nlti440wrH2LH1ny9y7AThNXuYpOdj8Y+/Vzjh+nGuC500Zdd
 51/Qb0rihDzaw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 30ADB191E3F;
 Wed, 11 Mar 2026 18:01:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 17CC537C291;
 Wed, 11 Mar 2026 18:02:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jaehoon Kim <jhkim@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 01/44] s390x/pci: Fix endianness for zPCI BAR values.
Date: Wed, 11 Mar 2026 18:01:33 +0300
Message-ID: <20260311150221.1084186-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
(cherry picked from commit 00ebc44514a67fb75a46d60e4b44614ebf91230f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 8cdeb6cb7f..6d95b96bef 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -305,7 +305,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
             uint32_t data = pci_get_long(pbdev->pdev->config +
                 PCI_BASE_ADDRESS_0 + (i * 4));
 
-            stl_be_p(&resquery->bar[i], data);
+            stl_le_p(&resquery->bar[i], data);
             resquery->bar_size[i] = pbdev->pdev->io_regions[i].size ?
                                     ctz64(pbdev->pdev->io_regions[i].size) : 0;
             trace_s390_pci_bar(i,
-- 
2.47.3


