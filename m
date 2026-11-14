Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B2606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGSo-0007O9-9Z; Sat, 14 Nov 2026 11:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGSD-00078Y-NM; Sat, 14 Nov 2026 11:18:22 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGS8-0003E1-7a; Sat, 14 Nov 2026 11:18:13 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwDHz6e3ifhquVkqBg--.31412S2; 
 Sun, 15 Nov 2026 00:17:59 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwOHSyifhq4Nv6AA--.29617S7;
 Sun, 15 Nov 2026 00:17:58 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 14/35] hw/arm/smmuv3: Make evtq producer use SEC_SID
Date: Sun, 15 Nov 2026 00:17:48 +0800
Message-Id: <20261114161753.3645568-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwOHSyifhq4Nv6AA--.29617S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBeAAAsd
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF4xAFy7XF1rXF4xtryxKrg_yoW8uF48pr
 Z0k3s5KryFyFs3JF95Zrs5u3W7u3yIqr13GrZ7Ka45uw1UAr1aqF1UKryFkryvqrZ7J3y5
 uFWxCa15Zw15t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The event queue producer path wrote entries through address_space_memory
with MEMTXATTRS_UNSPECIFIED, so produced entries did not use the
sec_sid-selected DMA context. Pass AddressSpace and MemTxAttrs to
queue_write() based on sec_sid.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 55b3970bbf2..f7ca3859bc2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -129,7 +129,8 @@ static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd,
     return ret;
 }
 
-static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
+static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in,
+                               AddressSpace *as, MemTxAttrs attrs)
 {
     dma_addr_t addr = Q_PROD_ENTRY(q);
     MemTxResult ret;
@@ -139,8 +140,7 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
     for (i = 0; i < ARRAY_SIZE(evt.word); i++) {
         cpu_to_le32s(&evt.word[i]);
     }
-    ret = dma_memory_write(&address_space_memory, addr, &evt, sizeof(Evt),
-                           MEMTXATTRS_UNSPECIFIED);
+    ret = dma_memory_write(as, addr, &evt, sizeof(Evt), attrs);
     if (ret != MEMTX_OK) {
         return ret;
     }
@@ -155,6 +155,9 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUQueue *q = &bank->eventq;
     MemTxResult r;
+    SMMUState *bs = ARM_SMMU(s);
+    MemTxAttrs txattrs = smmu_get_txattrs(sec_sid);
+    AddressSpace *as = smmu_get_address_space(bs, sec_sid);
 
     if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return MEMTX_ERROR;
@@ -164,7 +167,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
         return MEMTX_ERROR;
     }
 
-    r = queue_write(q, evt);
+    r = queue_write(q, evt, as, txattrs);
     if (r != MEMTX_OK) {
         return r;
     }
-- 
2.34.1


