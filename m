Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D39DC87FDA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 03:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulJJ8-0004y0-NE; Sun, 10 Aug 2025 23:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ulJJ0-0004wt-8z
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 23:34:38 -0400
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ulJIw-0004A8-F2
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 23:34:38 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 6DFF3784342;
 Mon, 11 Aug 2025 03:34:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com
 (100-96-19-240.trex-nlb.outbound.svc.cluster.local [100.96.19.240])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 1BBA77841ED;
 Mon, 11 Aug 2025 03:34:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754883269; a=rsa-sha256;
 cv=none;
 b=AGcgBeiIe2ULJd2XpS2H/vJZVHpTM/7uyNLwg2vBJKEJIqGBrdzFhCUMLltZYhe5BYYtsd
 q0vHf5IYpt+TfTQmo8NWcpMYxd6ZRJDDLjLxHGUH7npn0QGmqTBSMCj3JR7CNeGiawXpyF
 Si8Rq+0/5cW4lwG8oPTzVQqhuIFdK+qJjuNHLhwXNAM4ARaXiMMXQTDtiSJWgENekNcjMD
 whqPwPq8GceeVgka1FFHPmjkiGdnwEciFqBZKOTdeQuu/V91yeIUMDWcmpXGRK5VB+ph2p
 ALxdobpJPHWf8ZVMpVOuy8INIrHYmUa9oFHZZYH22XqXOnK6fqmBYgDa6gyolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1754883269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=uILKmGILpKHxLSPUg/Hi6AfLps5Z6p0FAQdbhoZZhtY=;
 b=IXJU18+hfYBnB1y0ZE/Bqsaek4JF/zX6dhsojaxkk87Zlu6iE9bzssPKKu7qTpqYJ+mDie
 YOoSLg9zQq5wGwXU1u8YWf4RWU22V3b8o5oBK01WoSvb7ZGY12ussnMF7qDyVCGSFWRH0/
 VH3xDsghpoEzYPd8qZVRBd1nHFx0oVuuprVwZzDXTDWeD3Nv9p2Um/WKefOC/JiF83v0GN
 1dzLwzJZLRQx5Uj4yzYkTN3jD4YA5TsUo64XUNDPMSC3riYES0IPH9TnMn6NMIhoKeXtWA
 U85duCjnGhLCLHoMztYuWeuNL2BUqU15GZh04RrxhCBVKKcU1gM+vZOvBymcVQ==
ARC-Authentication-Results: i=1; rspamd-698857ffff-tgkvl;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Belong-White: 09d06b067e85cead_1754883269391_2431456918
X-MC-Loop-Signature: 1754883269391:158543795
X-MC-Ingress-Time: 1754883269391
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.19.240 (trex/7.1.3); Mon, 11 Aug 2025 03:34:29 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4c0gH83lRmzHC; 
 Sun, 10 Aug 2025 20:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1754883268;
 bh=uILKmGILpKHxLSPUg/Hi6AfLps5Z6p0FAQdbhoZZhtY=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=bPGmjcxU8CcpmG8bNPC7IXPwln+mfibqYSNnBmzFZUKd3Y7GerjxXWxBdMSh6cqE5
 GJhlvHHT5LPTaNRoUWf0XqNxbak/bY2G52/DsX4Vmsmy8/a9rsF3Y6Gzl1JaUCjeSW
 w/Dn/V9vaTTK6eCagZvbTpRTlh33+gAdVCPqjX5ELgdmuOTQQQV3ClQOnuLZ7j2p0g
 RqL44phP8szeZBsQ48yW+Ng51MPJzIyFZ4xYx5nX9UKu3duKvEiqSbQSX3+f9xO7gx
 nQL/RzLD6ZXzrTtRxcjm9Xl91DnnR6VCy3MU9QxWPACLWnbCcTwkshvnQVoQMjbJZz
 YssjP+jjFRquw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 4/4] hw/cxl: Support type3 HDM-DB
Date: Sun, 10 Aug 2025 20:34:05 -0700
Message-Id: <20250811033405.332295-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811033405.332295-1-dave@stgolabs.net>
References: <20250811033405.332295-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.164; envelope-from=dave@stgolabs.net;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Add basic plumbing for memory expander devices that support Back
Invalidation. This introduces a 'hdm-db=on|off' parameter and
exposes the relevant BI RT/Decoder component cachemem registers.

Some noteworthy properties:
 - Devices require enabling Flit mode.
 - Explicit BI-ID commit is required.
 - HDM decoder support both host and dev coherency models.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 docs/system/devices/cxl.rst    |  23 ++++++
 hw/cxl/cxl-component-utils.c   | 135 +++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c             |  14 +++-
 include/hw/cxl/cxl_component.h |  54 ++++++++++++-
 include/hw/cxl/cxl_device.h    |   3 +
 5 files changed, 217 insertions(+), 12 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index bf7908429af8..4815de0f2dc4 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -384,6 +384,29 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+An example of 4 type3 devices with volatile memory below a switch. Two of the devices
+use HDM-DB for coherence::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
+  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
+  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
+  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
+  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
+  -device cxl-upstream,bus=root_port0,id=us0,256b-flit=on \
+  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
+  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,256b-flit=on,hdm-db=on \
+  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
+  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,256b-flit=on,hdm-db=on \
+  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
+  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
+  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
+  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
 
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a43d227336ca..dfdbf23a427c 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -71,10 +71,40 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
     case 4:
         if (cregs->special_ops && cregs->special_ops->read) {
             return cregs->special_ops->read(cxl_cstate, offset, 4);
-        } else {
-            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
-            return cregs->cache_mem_registers[offset / 4];
         }
+
+        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
+
+        if (offset == A_CXL_BI_RT_STATUS ||
+            offset == A_CXL_BI_DECODER_STATUS) {
+            int type;
+            uint64_t started;
+
+            type = (offset == A_CXL_BI_RT_STATUS) ?
+                    CXL_BISTATE_RT : CXL_BISTATE_DECODER;
+            started = cxl_cstate->bi_state[type].last_commit;
+
+            if (started) {
+                uint32_t val, *cache_mem = cregs->cache_mem_registers;
+                uint64_t now;
+                int set;
+
+                val = cregs->cache_mem_registers[offset / 4];
+                now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+                /* arbitrary 100 ms to do the commit */
+                set = !!(now >= started + 100);
+
+                if (offset == A_CXL_BI_RT_STATUS) {
+                    val = FIELD_DP32(val, CXL_BI_RT_STATUS, COMMITTED, set);
+                } else {
+                    val = FIELD_DP32(val, CXL_BI_DECODER_STATUS, COMMITTED,
+                                     set);
+                }
+                stl_le_p((uint8_t *)cache_mem + offset, val);
+            }
+        }
+
+        return cregs->cache_mem_registers[offset / 4];
     case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
@@ -123,6 +153,47 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
     }
 }
 
+static void dumb_bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
+                            uint32_t value)
+{
+    ComponentRegisters *cregs = &cxl_cstate->crb;
+    uint32_t sts, *cache_mem = cregs->cache_mem_registers;
+    bool to_commit = false;
+    int type;
+
+    switch (offset) {
+    case A_CXL_BI_RT_CTRL:
+        to_commit = FIELD_EX32(value, CXL_BI_RT_CTRL, COMMIT);
+        if (to_commit) {
+            sts = cxl_cache_mem_read_reg(cxl_cstate,
+                                         R_CXL_BI_RT_STATUS, 4);
+            sts = FIELD_DP32(sts, CXL_BI_RT_STATUS, COMMITTED, 0);
+            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_RT_STATUS, sts);
+            type = CXL_BISTATE_RT;
+        }
+        break;
+    case A_CXL_BI_DECODER_CTRL:
+        to_commit = FIELD_EX32(value, CXL_BI_DECODER_CTRL, COMMIT);
+        if (to_commit) {
+            sts = cxl_cache_mem_read_reg(cxl_cstate,
+                                         R_CXL_BI_DECODER_STATUS, 4);
+            sts = FIELD_DP32(sts, CXL_BI_DECODER_STATUS, COMMITTED, 0);
+            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_DECODER_STATUS, sts);
+            type = CXL_BISTATE_DECODER;
+        }
+        break;
+    default:
+        break;
+    }
+
+    if (to_commit) {
+        cxl_cstate->bi_state[type].last_commit =
+                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    }
+
+    stl_le_p((uint8_t *)cache_mem + offset, value);
+}
+
 static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
                                     unsigned size)
 {
@@ -146,6 +217,9 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
         if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
             offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
             dumb_hdm_handler(cxl_cstate, offset, value);
+        } else if (offset == A_CXL_BI_RT_CTRL ||
+                   offset == A_CXL_BI_DECODER_CTRL) {
+            dumb_bi_handler(cxl_cstate, offset, value);
         } else {
             cregs->cache_mem_registers[offset / 4] = value;
         }
@@ -248,7 +322,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      POISON_ON_ERR_CAP, 0);
-    if (type == CXL2_TYPE3_DEVICE) {
+    if (type == CXL2_TYPE3_DEVICE || type == CXL3_TYPE3_DEVICE) {
         ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 1);
         ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 1);
     } else {
@@ -260,7 +334,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                      UIO_DECODER_COUNT, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
-                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
+                     SUPPORTED_COHERENCY_MODEL,
+                     type == CXL3_TYPE3_DEVICE ? 3:0); /* host+dev or Unknown */
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
@@ -271,7 +346,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
         write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
         write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
         if (type == CXL2_DEVICE ||
-            type == CXL2_TYPE3_DEVICE ||
+            type == CXL2_TYPE3_DEVICE || type == CXL3_TYPE3_DEVICE ||
             type == CXL2_LOGICAL_DEVICE) {
             write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
                 0xf0000000;
@@ -283,6 +358,37 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     }
 }
 
+static void bi_rt_init_common(uint32_t *reg_state, uint32_t *write_msk)
+{
+    /* switch usp must commit the new BI-ID, timeout of 2secs */
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_CAPABILITY, EXPLICIT_COMMIT, 1);
+
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_CTRL, COMMIT, 0);
+    write_msk[R_CXL_BI_RT_CTRL] = 0xffffffff;
+
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMITTED, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, ERR_NOT_COMMITTED, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMIT_TMO_SCALE, 0x6);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMIT_TMO_BASE, 0x2);
+}
+
+static void bi_decoder_init_common(uint32_t *reg_state, uint32_t *write_msk)
+{
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CAPABILITY, HDM_D, 0);
+    /* switch dsp must commit the new BI-ID, timeout of 2secs */
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CAPABILITY, EXPLICIT_COMMIT, 1);
+
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, BI_FW, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, BI_ENABLE, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, COMMIT, 0);
+    write_msk[R_CXL_BI_DECODER_CTRL] = 0xffffffff;
+
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMITTED, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, ERR_NOT_COMMITTED, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMIT_TMO_SCALE, 0x6);
+    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMIT_TMO_BASE, 0x2);
+}
+
 void cxl_component_register_init_common(uint32_t *reg_state,
                                         uint32_t *write_msk,
                                         enum reg_type type)
@@ -323,6 +429,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     case CXL2_UPSTREAM_PORT:
     case CXL2_TYPE3_DEVICE:
     case CXL2_LOGICAL_DEVICE:
+    case CXL3_TYPE3_DEVICE:
         /* + HDM */
         init_cap_reg(HDM, 5, 1);
         hdm_init_common(reg_state, write_msk, type);
@@ -340,6 +447,22 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         abort();
     }
 
+    /* back invalidate */
+    switch (type) {
+    case CXL2_UPSTREAM_PORT:
+        init_cap_reg(BI_RT, 11, CXL_BI_RT_CAP_VERSION);
+        bi_rt_init_common(reg_state, write_msk);
+        break;
+    case CXL2_ROOT_PORT:
+    case CXL2_DOWNSTREAM_PORT:
+    case CXL3_TYPE3_DEVICE:
+        init_cap_reg(BI_DECODER, 12, CXL_BI_DECODER_CAP_VERSION);
+        bi_decoder_init_common(reg_state, write_msk);
+        break;
+    default:
+        break;
+    }
+
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 #undef init_cap_reg
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ecd3a7703b35..1e55d13c1e93 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -447,6 +447,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
+    uint16_t type = ct3d->hdmdb ? CXL3_TYPE3_DEVICE : CXL2_TYPE3_DEVICE;
     uint32_t range1_size_hi = 0, range1_size_lo = 0,
              range1_base_hi = 0, range1_base_lo = 0,
              range2_size_hi = 0, range2_size_lo = 0,
@@ -491,7 +492,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
         .range2_base_hi = range2_base_hi,
         .range2_base_lo = range2_base_lo,
     };
-    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
+    cxl_component_create_dvsec(cxl_cstate, type,
                                PCIE_CXL_DEVICE_DVSEC_LENGTH,
                                PCIE_CXL_DEVICE_DVSEC,
                                PCIE_CXL31_DEVICE_DVSEC_REVID, dvsec);
@@ -521,14 +522,14 @@ static void build_dvsecs(CXLType3Dev *ct3d)
         },
     };
 
-    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
+    cxl_component_create_dvsec(cxl_cstate, type,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
                                REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
     dvsec = (uint8_t *)&(CXLDVSECDeviceGPF){
         .phase2_duration = 0x603, /* 3 seconds */
         .phase2_power = 0x33, /* 0x33 miliwatts */
     };
-    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
+    cxl_component_create_dvsec(cxl_cstate, type,
                                GPF_DEVICE_DVSEC_LENGTH, GPF_DEVICE_DVSEC,
                                GPF_DEVICE_DVSEC_REVID, dvsec);
 
@@ -539,7 +540,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
         .status                  = ct3d->flitmode ? 0x6 : 0x26, /* same */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
-    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
+    cxl_component_create_dvsec(cxl_cstate, type,
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
                                PCIE_FLEXBUS_PORT_DVSEC,
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
@@ -969,6 +970,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         return false;
     }
 
+    if (!ct3d->flitmode && ct3d->hdmdb) {
+        error_setg(errp, "hdm-db requires operating in 256b flit");
+        return false;
+    }
+
     if (ct3d->hostvmem) {
         MemoryRegion *vmr;
         char *v_name;
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index cd92cb02532a..acec76152ad0 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -29,6 +29,7 @@ enum reg_type {
     CXL2_UPSTREAM_PORT,
     CXL2_DOWNSTREAM_PORT,
     CXL3_SWITCH_MAILBOX_CCI,
+    CXL3_TYPE3_DEVICE, /* hdm-db */
 };
 
 /*
@@ -67,6 +68,8 @@ CXLx_CAPABILITY_HEADER(LINK, 2)
 CXLx_CAPABILITY_HEADER(HDM, 3)
 CXLx_CAPABILITY_HEADER(EXTSEC, 4)
 CXLx_CAPABILITY_HEADER(SNOOP, 5)
+CXLx_CAPABILITY_HEADER(BI_RT, 6)
+CXLx_CAPABILITY_HEADER(BI_DECODER, 7)
 
 /*
  * Capability structures contain the actual registers that the CXL component
@@ -211,10 +214,56 @@ HDM_DECODER_INIT(3);
     (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
 #define CXL_SNOOP_REGISTERS_SIZE   0x8
 
-QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
-                    CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
+#define CXL_BI_RT_CAP_VERSION 1
+#define CXL_BI_RT_REGISTERS_OFFSET \
+    (CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE)
+#define CXL_BI_RT_REGISTERS_SIZE   0xC
+
+REG32(CXL_BI_RT_CAPABILITY, CXL_BI_RT_REGISTERS_OFFSET)
+    FIELD(CXL_BI_RT_CAPABILITY, EXPLICIT_COMMIT, 0, 1)
+REG32(CXL_BI_RT_CTRL, CXL_BI_RT_REGISTERS_OFFSET + 0x4)
+    FIELD(CXL_BI_RT_CTRL, COMMIT, 0, 1)
+REG32(CXL_BI_RT_STATUS, CXL_BI_RT_REGISTERS_OFFSET + 0x8)
+    FIELD(CXL_BI_RT_STATUS, COMMITTED, 0, 1)
+    FIELD(CXL_BI_RT_STATUS, ERR_NOT_COMMITTED, 1, 1)
+    FIELD(CXL_BI_RT_STATUS, COMMIT_TMO_SCALE, 8, 4)
+    FIELD(CXL_BI_RT_STATUS, COMMIT_TMO_BASE, 12, 4)
+
+/* CXL r3.2 8.2.4.27 - CXL BI Decoder Capability Structure */
+#define CXL_BI_DECODER_CAP_VERSION 1
+#define CXL_BI_DECODER_REGISTERS_OFFSET \
+    (CXL_BI_RT_REGISTERS_OFFSET + CXL_BI_RT_REGISTERS_SIZE)
+#define CXL_BI_DECODER_REGISTERS_SIZE   0xC
+
+REG32(CXL_BI_DECODER_CAPABILITY, CXL_BI_DECODER_REGISTERS_OFFSET)
+    FIELD(CXL_BI_DECODER_CAPABILITY, HDM_D, 0, 1)
+    FIELD(CXL_BI_DECODER_CAPABILITY, EXPLICIT_COMMIT, 1, 1)
+REG32(CXL_BI_DECODER_CTRL, CXL_BI_DECODER_REGISTERS_OFFSET + 0x4)
+    FIELD(CXL_BI_DECODER_CTRL, BI_FW, 0, 1)
+    FIELD(CXL_BI_DECODER_CTRL, BI_ENABLE, 1, 1)
+    FIELD(CXL_BI_DECODER_CTRL, COMMIT, 2, 1)
+REG32(CXL_BI_DECODER_STATUS, CXL_BI_DECODER_REGISTERS_OFFSET + 0x8)
+    FIELD(CXL_BI_DECODER_STATUS, COMMITTED, 0, 1)
+    FIELD(CXL_BI_DECODER_STATUS, ERR_NOT_COMMITTED, 1, 1)
+    FIELD(CXL_BI_DECODER_STATUS, COMMIT_TMO_SCALE, 8, 4)
+    FIELD(CXL_BI_DECODER_STATUS, COMMIT_TMO_BASE, 12, 4)
+
+QEMU_BUILD_BUG_MSG((CXL_BI_DECODER_REGISTERS_OFFSET +
+                    CXL_BI_DECODER_REGISTERS_SIZE) >= 0x1000,
                    "No space for registers");
 
+/* to track BI explicit commit handling */
+enum {
+    CXL_BISTATE_RT = 0, /* switch usp */
+    CXL_BISTATE_DECODER, /* switch dsp */
+    CXL_BISTATE_MAX
+};
+
+typedef struct bi_state {
+    /* last 0->1 transition */
+    uint64_t last_commit;
+} BIState;
+
 typedef struct component_registers {
     /*
      * Main memory region to be registered with QEMU core.
@@ -260,6 +309,7 @@ typedef struct cxl_component {
 
     CDATObject cdat;
     CXLCompObject compliance;
+    BIState bi_state[CXL_BISTATE_MAX];
 } CXLComponentState;
 
 void cxl_component_register_block_init(Object *obj,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 0abfd678b875..75603b8180b5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -841,6 +841,9 @@ struct CXLType3Dev {
     CXLMemSparingReadAttrs rank_sparing_attrs;
     CXLMemSparingWriteAttrs rank_sparing_wr_attrs;
 
+    /* BI flows */
+    bool hdmdb;
+
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
-- 
2.39.5


