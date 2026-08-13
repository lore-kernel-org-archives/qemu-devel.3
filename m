Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83272C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYBs-000748-0n; Thu, 13 Aug 2026 12:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYBm-00073l-AW; Thu, 13 Aug 2026 12:21:54 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYBk-0000FY-Ul; Thu, 13 Aug 2026 12:21:54 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCnrxsd731qWhRvAw--.34435S2; 
 Fri, 14 Aug 2026 00:21:49 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dw43MZ731q2SwjAA--.57107S3;
 Fri, 14 Aug 2026 00:21:46 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 23/28] hw/pci: Add sec-sid property to PCIDevice
Date: Fri, 14 Aug 2026 00:21:45 +0800
Message-Id: <20260813162145.2800835-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw43MZ731q2SwjAA--.57107S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HiQABsf
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cr4UJr48ZFyktw1xXF4rGrg_yoW8Zw1xpF
 Z3CFyIkFn5Ga4Ikws2qa1xCrZruFZ7K3yYkrWj9w17CF1xAry3Xw45KFWj9r40qrWvgF1Y
 ka42kFy8ur1DJFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/pci/pci.c                | 7 +++++++
 include/hw/pci/pci_device.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e28..b86135af96d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -104,6 +104,13 @@ static const Property pci_props[] = {
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
index 5cac6e16886..6e6c49fdd19 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -187,6 +187,9 @@ struct PCIDevice {
     uint32_t max_bounce_buffer_size;
 
     char *sriov_pf;
+
+    /* Arm SMMU SEC_SID */
+    char *sec_sid;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
-- 
2.34.1


