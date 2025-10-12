Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D98CCD18D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xfa-0001hN-91; Sun, 12 Oct 2025 11:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfQ-0001e8-Pe; Sun, 12 Oct 2025 11:07:24 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfL-0001cn-I7; Sun, 12 Oct 2025 11:07:24 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDX31MfxOtodicrAA--.7514S2;
 Sun, 12 Oct 2025 23:07:11 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXPOoXxOto33dMAA--.3068S14;
 Sun, 12 Oct 2025 23:07:11 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 11/21] hw/arm/smmuv3: Decode security attributes from
 descriptors
Date: Sun, 12 Oct 2025 23:06:51 +0800
Message-Id: <20251012150701.4127034-12-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXPOoXxOto33dMAA--.3068S14
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBZgAAsX
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXrW7Ww43try5uryxWw1Dtrb_yoWrCw15pa
 97Gr98KrW5G3WI93ykXr43uFsxXws5JF1UCr9Fgr95Ar4aqw17Xr1Ika45KF9FgrZ5Jr47
 Zr4q9348urWjqrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

As the first step in implementing secure page table walks, this patch
introduces the logic to decode security-related attributes from various
SMMU structures.

The NSCFG bits from the Context Descriptor are now decoded and stored.
These bits control the security attribute of the starting-level
translation table, which is crucial for managing secure and non-secure
memory accesses.

The SMMU_S_IDR1.SEL2 bit is read to determine if Secure stage 2
translations are supported. This capability is cached in the
SMMUTransCfg structure for the page table walker's use.

Finally, new macros (PTE_NS, PTE_NSTABLE) are added to prepare for
extracting attributes from page and table descriptors. To improve
clarity, these different attribute bits are organized into distinct
subsections in the header file.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-internal.h       | 16 ++++++++++++++--
 hw/arm/smmuv3-internal.h     |  2 ++
 hw/arm/smmuv3.c              |  2 ++
 include/hw/arm/smmu-common.h |  3 +++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index d143d296f3..a0454f720d 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -58,16 +58,28 @@
     ((level == 3) &&                                                    \
      ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE))
 
+/* Block & page descriptor attributes */
+/* Non-secure bit */
+#define PTE_NS(pte) \
+    (extract64(pte, 5, 1))
+
 /* access permissions */
 
 #define PTE_AP(pte) \
     (extract64(pte, 6, 2))
 
+/* access flag */
+#define PTE_AF(pte) \
+    (extract64(pte, 10, 1))
+
+
+/* Table descriptor attributes */
 #define PTE_APTABLE(pte) \
     (extract64(pte, 61, 2))
 
-#define PTE_AF(pte) \
-    (extract64(pte, 10, 1))
+#define PTE_NSTABLE(pte) \
+    (extract64(pte, 63, 1))
+
 /*
  * TODO: At the moment all transactions are considered as privileged (EL1)
  * as IOMMU translation callback does not pass user/priv attributes.
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 99fdbcf3f5..1e757af459 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -703,6 +703,8 @@ static inline int oas2bits(int oas_field)
 #define CD_R(x)          extract32((x)->word[1], 13, 1)
 #define CD_A(x)          extract32((x)->word[1], 14, 1)
 #define CD_AARCH64(x)    extract32((x)->word[1], 9 , 1)
+#define CD_NSCFG0(x)     extract32((x)->word[2], 0, 1)
+#define CD_NSCFG1(x)     extract32((x)->word[4], 0, 1)
 
 /**
  * tg2granule - Decodes the CD translation granule size field according
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 55f4ad1757..3686056d8e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -812,6 +812,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
             tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
         }
 
+        tt->nscfg = i ? CD_NSCFG1(cd) : CD_NSCFG0(cd);
         tt->had = CD_HAD(cd, i);
         trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
     }
@@ -915,6 +916,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
             cfg = NULL;
             return cfg;
         }
+        cfg->sel2 = FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SEL2);
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
             SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index bccbbe0115..90a37fe32d 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -109,6 +109,7 @@ typedef struct SMMUTransTableInfo {
     uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
     uint8_t granule_sz;        /* granule page shift */
     bool had;                  /* hierarchical attribute disable */
+    int nscfg;                /* Non-secure attribute of Starting-level TT */
 } SMMUTransTableInfo;
 
 typedef struct SMMUTLBEntry {
@@ -116,6 +117,7 @@ typedef struct SMMUTLBEntry {
     uint8_t level;
     uint8_t granule;
     IOMMUAccessFlags parent_perm;
+    SMMUSecSID sec_sid;
 } SMMUTLBEntry;
 
 /* Stage-2 configuration. */
@@ -156,6 +158,7 @@ typedef struct SMMUTransCfg {
     struct SMMUS2Cfg s2cfg;
     MemTxAttrs txattrs;        /* cached transaction attributes */
     AddressSpace *as;          /* cached address space */
+    int sel2;                 /* Secure EL2 and Secure stage 2 support */
 } SMMUTransCfg;
 
 typedef struct SMMUDevice {
-- 
2.34.1


