Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2352C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 17:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugoae-0002u1-W2; Tue, 29 Jul 2025 13:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ugnbb-0003LS-La
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:55:12 -0400
Received: from azure.banana.relay.mailchannels.net ([23.83.217.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ugnbU-0006BW-5c
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:55:08 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BDFDE1A5FBE;
 Tue, 29 Jul 2025 16:54:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com
 (trex-blue-0.trex.outbound.svc.cluster.local [100.97.47.152])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 6555B1A6A1B;
 Tue, 29 Jul 2025 16:54:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1753808099; a=rsa-sha256;
 cv=none;
 b=BuFPeRsxwGZRhkSUyrmylF7LVAHBcFkJ4Um1ZYEAP3tXq0Rc1kAh6fyfOygr4rcKlsD5uz
 cKpKicgKnKzC22v+v6gjce7svrjMUqF/fLgF6WOWqKHQMnW8zcszoh+reZdk0NiloSHwct
 oNx0HtTb3J2z4MTMxT10u/vCjaWXTviUtlUEbnXmUVm1af8GcjmSkFf54x8oAhkiQu62Kr
 thNEf9uIbjNGjZNGvAYQFmKxp0+OG20hg1Kg55dpOl2pAA5LWtNy3IAziNGBZOufRGPcXX
 pJGinJ/m6oSgfzustNsefDJQdx+hzKzPrvKVWhUez2yhzOLjD3n+ani0b3whjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1753808099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=SSKY9j0C8ik1w8HXeNrmP+gIjQnzzMnhn4wzueihAg0=;
 b=T6hDOoO9apiPvNkW/rRDf4GEpPxFl6XJ/jo6SKi80dhb1zYs3DlHU92QEh48nNyt6j/df+
 l3hgCoWZqpHiDBdEdULIYco6YCSsxEgVakl+KUE+Jl89nCmFo0bWDkz5XaDYjeAL2qj+Mh
 +yKEccmRpPrtOp9XSGPzfx2Lq67x+HztTKsWnyEr+OsCJflRj0oN5l0KVLgsKX3maci0O7
 DP8BbUelxlo/aIa161bqSPOrmzMlCpmDLlNYaDNqBhituT7O3wyO9WUGRw66KYuj75DUh+
 e0+/2FqFQwPZEIntDyhi4EFg9VqshM2Nn1jdH321tkj9lXwNIroSNOG/xmPmgA==
ARC-Authentication-Results: i=1; rspamd-696f8998d-ps5xn;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Stop: 23031a606d3abb61_1753808099700_315847281
X-MC-Loop-Signature: 1753808099700:1908830250
X-MC-Ingress-Time: 1753808099699
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.97.47.152 (trex/7.1.3); Tue, 29 Jul 2025 16:54:59 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4bs1fp5TNrzGy; 
 Tue, 29 Jul 2025 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1753808099;
 bh=SSKY9j0C8ik1w8HXeNrmP+gIjQnzzMnhn4wzueihAg0=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=E8m0Yrm27obCMhvFvHJK8gu48oXrcBGefHiWb8pd/JeA7rwBUu6m8eHjJlZum6y19
 ryzn2xnwWw5ucWRjEpKKJrVgGyHV1aFizmIzs1eqvKk/3UMRgSAg5lkMgB9TuE40Fi
 29Brh0lk9OGi3uhkbbUZtMG48EncmCtQzHhuaXYWSm0d4wsIgNm4TLtjSBbLCZBzJN
 C4U/SRuhql+F+gt/yNNPNhlH/KP9uIoTklcAg/cQUcSP+w9sl80055HuDLhm30yD7Y
 ZRP4igEc7Vif6EFXnDllsbN9HCc4hm9G/XtGfHIQMy0X7MDsdSvmlGFWcl+nUSO0Zu
 GJWGUmQZs67Wg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 2/2] hw/cxl: Support Type3 HDM-DB
Date: Tue, 29 Jul 2025 09:54:41 -0700
Message-Id: <20250729165441.1898150-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729165441.1898150-1-dave@stgolabs.net>
References: <20250729165441.1898150-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.217.7; envelope-from=dave@stgolabs.net;
 helo=azure.banana.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-component-utils.c   | 135 +++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c             |   5 +-
 include/hw/cxl/cxl_component.h |  54 ++++++++++++-
 include/hw/cxl/cxl_device.h    |   3 +
 4 files changed, 188 insertions(+), 9 deletions(-)

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
index c4658e0955d5..c0eb99519975 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1501,8 +1501,10 @@ void ct3d_reset(DeviceState *dev)
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
+
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
+    cxl_component_register_init_common(reg_state, write_msk,
+                           ct3d->hdmdb ? CXL3_TYPE3_DEVICE : CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
@@ -1541,6 +1543,7 @@ static const Property ct3_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
+    DEFINE_PROP_BOOL("hdm-db", CXLType3Dev, hdmdb, 0),
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index cd92cb02532a..4872ec5ead39 100644
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
+    BIState bi_state[CXL_BISTATE_MAX]; /* for ups+dsp switches */
 } CXLComponentState;
 
 void cxl_component_register_block_init(Object *obj,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 068c20d61ebc..ee5bcf0652b9 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -840,6 +840,9 @@ struct CXLType3Dev {
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


