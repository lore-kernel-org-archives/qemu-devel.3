Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27837C61DE1
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk51-0003cN-4p; Sat, 21 Feb 2026 05:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4j-0003Ij-93; Sat, 21 Feb 2026 05:19:01 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk4g-0003rW-QN; Sat, 21 Feb 2026 05:19:00 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3vJiOhplpD7BVBw--.4499S2;
 Sat, 21 Feb 2026 18:18:54 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3TeuNhplpgE4cAA--.34143S3;
 Sat, 21 Feb 2026 18:18:53 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 27/31] hw/pci: Add sec-sid property to PCIDevice
Date: Sat, 21 Feb 2026 18:18:50 +0800
Message-Id: <20260221101850.2996913-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3TeuNhplpgE4cAA--.34143S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUASwAAsZ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cr4UJr48ZFyktw1xWF45KFg_yoW8uF1fpF
 Z3AFyIkrs5Ga4Ik3yIqa17CrZrCFZ3K3yYkrWj9r17CF47Ary5Xay5KFyj9w40qrZ5uF1j
 ka4jyFy8ur1DZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Arm SMMUv3 uses a SEC_SID (StreamID Security state) to determine the
security state of the programming interface that controls a transaction.
The architecture explicitly states that the association between a device
and its SEC_SID is a system-defined property, not something derived from
the physical address space.

We need a way to represent this system-defined SEC_SID for PCI devices
if we want to implement SMMU's Secure state. So that SMMUv3 can select
the correct register bank and configuration when handling their streams.

This patch adds a new char *sec_sid field to PCIDevice, together with
a "sec-sid" QOM property. The property is intended to carry the
platform-defined SEC_SID for the device; for now only Non-secure and
Secure security states are supported.

Future RME-DA/TDISP work will use the PCIe TDISP/DTI protocol to model
Realm and Non-secure streams, instead of extending this static field.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/pci/pci.c                | 7 +++++++
 include/hw/pci/pci_device.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 90d6d71efdc..aca0509f705 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -98,6 +98,13 @@ static const Property pci_props[] = {
     DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
     DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
                     QEMU_PCIE_EXT_TAG_BITNR, true),
+
+    /*
+     * System-defined, statically configured SEC_SID for this PCI device, used
+     * by Arm SMMU. Only support "non-secure" and "secure" security states.
+     */
+    DEFINE_PROP_STRING("sec-sid", PCIDevice, sec_sid),
+
     { .name = "busnr", .info = &prop_pci_busnr },
 };
 
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 88ccea50113..47ed4a13e40 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -184,6 +184,9 @@ struct PCIDevice {
     uint32_t max_bounce_buffer_size;
 
     char *sriov_pf;
+
+    /* Arm SMMU SEC_SID */
+    char *sec_sid;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
-- 
2.34.1


