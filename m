Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE56DC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 16:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujgYF-0007J2-FV; Wed, 06 Aug 2025 11:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpi-00015A-Kb; Wed, 06 Aug 2025 11:13:40 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpf-0006F6-J9; Wed, 06 Aug 2025 11:13:38 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwB3DWEbcZNo805LBA--.45958S2;
 Wed, 06 Aug 2025 23:13:31 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXIQnfcJNos_oJAA--.14849S11;
 Wed, 06 Aug 2025 23:13:30 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 08/11] hw/arm/smmuv3: Enable secure-side stage 2 TLB
 invalidations
Date: Wed,  6 Aug 2025 23:11:31 +0800
Message-Id: <20250806151134.365755-9-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXIQnfcJNos_oJAA--.14849S11
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HLAAAs4
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAryrXr4rKFW8Cr4xtw43Wrg_yoW5Ww1Dpr
 48Wr98Gry3GFnxJF9Fgw48uan8Wa95GryUCrWDWas3Aas3tFyrXr4qkFyFk3yDGrWFya1f
 WayUXan5Gr1jq3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 11:27:14 -0400
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

This change expands the secure command queue's capabilities by adding
two commands for managing secure stage 2 translation caches, as defined
by the Arm SMMUv3 architecture.

The following commands are now processed by the secure command queue:

- CMD_TLBI_S_S2_IPA: Invalidates secure stage 2 TLB entries by IPA for
a given secure VMID.
- CMD_TLBI_S_S12_VMALL: The secure equivalent of VMALLS12E1, this
invalidates all stage 1 and stage 2 entries for a specific secure
VMID.

The command handler verifies that these commands are issued only via the
secure queue and that secure stage 2 functionality is supported by the
model, raising an illegal command error otherwise.

This will be followed by a refactoring of the Configuration and
Translation lookup caches, paving the final path for enabling the
end-to-end processing of secure transactions.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3-internal.h |  4 ++++
 hw/arm/smmuv3.c          | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 852186cea4..82821cbbcc 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -391,6 +391,8 @@ typedef enum SMMUCommandType {
     SMMU_CMD_RESUME          = 0x44,
     SMMU_CMD_STALL_TERM,
     SMMU_CMD_SYNC,
+    SMMU_CMD_TLBI_S_S12_VMALL  = 0x58,
+    SMMU_CMD_TLBI_S_S2_IPA     = 0x5a,
 } SMMUCommandType;
 
 static const char *cmd_stringify[] = {
@@ -419,6 +421,8 @@ static const char *cmd_stringify[] = {
     [SMMU_CMD_RESUME]          = "SMMU_CMD_RESUME",
     [SMMU_CMD_STALL_TERM]      = "SMMU_CMD_STALL_TERM",
     [SMMU_CMD_SYNC]            = "SMMU_CMD_SYNC",
+    [SMMU_CMD_TLBI_S_S12_VMALL] = "SMMU_CMD_TLBI_S_S12_VMALL",
+    [SMMU_CMD_TLBI_S_S2_IPA]   = "SMMU_CMD_TLBI_S_S2_IPA",
 };
 
 static inline const char *smmu_cmd_string(SMMUCommandType type)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 69b19754f1..5f28e27503 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1591,6 +1591,26 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, bool is_secure)
              */
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, false);
             break;
+        case SMMU_CMD_TLBI_S_S2_IPA:
+            if (!is_secure || !STAGE2_SUPPORTED(s) ||
+                    (SECURE_IMPLEMENTED(s) && SECURE_S2_SUPPORTED(s))) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, true);
+            break;
+        case SMMU_CMD_TLBI_S_S12_VMALL:
+            if (!is_secure || !STAGE2_SUPPORTED(s) ||
+                    (SECURE_IMPLEMENTED(s) && SECURE_S2_SUPPORTED(s))) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+
+            int vmid = CMD_VMID(&cmd);
+            trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
+            smmu_inv_notifiers_all(&s->smmu_state);
+            smmu_iotlb_inv_vmid(bs, vmid);
+            break;
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
         case SMMU_CMD_TLBI_EL2_ALL:
-- 
2.34.1


