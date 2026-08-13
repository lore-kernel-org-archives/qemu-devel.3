Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE74C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYFA-0001JI-Ng; Thu, 13 Aug 2026 12:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYF8-00016n-C0; Thu, 13 Aug 2026 12:25:22 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYF5-00010G-Vn; Thu, 13 Aug 2026 12:25:22 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwBnbLTt731qxVDmAA--.5018S2;
 Fri, 14 Aug 2026 00:25:17 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwBnPo731q5SwjAA--.54277S6;
 Fri, 14 Aug 2026 00:25:16 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 14/28] hw/arm/smmuv3: Make evtq producer use SEC_SID
Date: Fri, 14 Aug 2026 00:25:11 +0800
Message-Id: <20260813162512.2807281-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBnPo731q5SwjAA--.54277S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HoQAAs2
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF4xAFy7XF1rXF4xXw4rAFb_yoW8ZF43pr
 Wqkwn5K34YyFsxJF95Zrs5u3W7u3yIqr9rGrWxKFy5uw1UAw43XF1UKryFyryvqr97J3y5
 ZFWfCay5Zr45t3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

The event queue producer path wrote entries through address_space_memory
with MEMTXATTRS_UNSPECIFIED, so produced entries did not use the
sec_sid-selected DMA context. Pass AddressSpace and MemTxAttrs to
queue_write() based on sec_sid.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index fa13191fc3b..7e08b88689f 100644
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


