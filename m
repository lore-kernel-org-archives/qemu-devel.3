Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA109FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB89-0003d3-P4; Wed, 29 Apr 2026 16:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QX-0008KI-Vz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QV-0007io-Es
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so90525495e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471086; x=1778075886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+pbmHQ9yiYCeLpJXoN1CgDASSe1tTJT9TMuxTLM8RU=;
 b=CWDU7Co4dX115W/qDdEILDnKCpnDwRIXHHXd6IVpOh5l/c6O8jcVs4UogBS/sp7Z6o
 urQkCfuXdA82uSBd29HU7hoHjTnofl6UnBqU5HKrK1/jhQP9Pbo86ia12SDyDP55N9ft
 55SaHugRyuQLtsGux71cONydeCsx/ws/HUTa4PrxwtxdzJ+ZRn4Tj1gZp976XjODE5/8
 eCfKHzvaMsBci858Wzhuzbv+xiFFKVGevUMt84b4sxZHYgDAR+HgOxgIXKL8dD70jT0u
 ppNsUt3ec/tbS0hj6x+bkRZ69mCualyDydvAH2vBCLkR7vaHDWJEsebDDSGvE1/Eoy4/
 cJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471086; x=1778075886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M+pbmHQ9yiYCeLpJXoN1CgDASSe1tTJT9TMuxTLM8RU=;
 b=qmiqlyS9wOfJYKo6x/8UHwpszo8ePO8XHavrDrcSXrFkMEGinRTteMZ2EcMCL25BHD
 0XZv6f6BJtnkapI9R6n1YVn0ELV8swWm+fJyjtTyJg17Tt4ISr/KwT5mxGoV7Svd0jHM
 IYnfJkLLSxNuZuyyXuvwsve7G3RY46Yx8teXA99QIRrklbMIp+g9v+zuXx0Xmp8uTuaQ
 SgE8KvtDnD2OrmSukuVOphp8dN+dOsRYUFLkHGA3pB32GbnWmbkuu3cHAfTJchuVdzMG
 5KuXAJRMOZYWjKxwzBM3HGfMroqstVZFUQmHnY6jSWvCRTrEk/mL80GAm1Zlxmp+CGz9
 mt7w==
X-Gm-Message-State: AOJu0YyrZgI36cqDLdr4udqGF6s70TPyCdIb6zWzDc7pR++JqJ+llh7Z
 lUcHFhks4W9EgST00zCW/VYH6nm6PyEDQT2v7zPiwKtS/ZEgU5Cx1gXsvCEpkN2J
X-Gm-Gg: AeBDieu0ygOZ+5XKCqdOQqL3LrTlO8lcGx778QMqzyufMzcAwTH3JSHv+aOHum34Ilc
 KprNZHSPXK3g6CvUsHaU8nlupPtcjdoxxwByPqvtIbhaEfGMBhr98C9HGfg7//d8ZdQ4x9w6Dwj
 67NRNw/AGL79E1R8jxQHVCCknCqGhFeQtrFLUqKdGob8Su/fy96n+3rO7UbojXwsmC24C0Blauf
 z2y0t2hoHVWdAsf1fl48rLm1CYqc4+27tLteBtUGHzLLV3lEFhrjC2SA44BxVDf/meFdwekE+Ti
 u1yoHbCs3ywPx1YERA02xpNgJ+i4fMBiUNBlS5v7X1RVahyLEWi+QYFk2O6ts0mpN3NM7kDCzZH
 JVdfRD3AILpJ1T5hYyKLBAP424MznwszKeCTOyYXUioNEeix51mmxl/hN4F0GmY2E7qLV05R4js
 /aq2OeaU9G88IfpvDc1uDp1MJg/mq2MsXFk+7tJxWSKOYppjvHGQAzdE6wwwAXOPxQeu5swDd7
X-Received: by 2002:a05:600c:630a:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-48a77b19d7dmr144546745e9.22.1777471085901; 
 Wed, 29 Apr 2026 06:58:05 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:58:05 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 09/10] cxl-mailbox-utils: Add support for VCS
 bind/unbind commands.
Date: Wed, 29 Apr 2026 14:48:43 +0100
Message-ID: <20260429135717.3048713-10-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=joshualant@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:14 -0400
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

Adds support for FMAPI commands 0x5201 and 0x5202, for more
information see CXL Specification v3.2 (7.6.7.2.2 and 7.6.7.2.3).

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 81 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 779138cdc8..cf6cb65eb6 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -27,6 +27,7 @@
 #include "system/hostmem.h"
 #include "qemu/range.h"
 #include "qapi/qapi-types-cxl.h"
+#include "hw/cxl/cxl_vcs_switch.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -121,6 +122,9 @@ enum {
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
         #define PHYSICAL_PORT_CONTROL       0x2
+    VIRTUAL_SWITCH = 0x52,
+        #define BIND_VPPB     0x1
+        #define UNBIND_VPPB       0x2
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
     FMAPI_DCD_MGMT = 0x56,
@@ -821,6 +825,51 @@ static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
     }
 }
 
+/* CXL r3.2 Section 7.6.7.2.2: Bind vPPB (Opcode 5201h) */
+static CXLRetCode cmd_bind_vppb(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    struct cxl_fmapi_bind_vppb_req_pl {
+        uint8_t vcs_id;
+        uint8_t vppb_id;
+        uint8_t physp_id;
+        uint8_t rsvd;
+        uint16_t ld_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    if(!cci->vcs) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    // Multi-logical device currently not supported (force 0xFFFF).
+    if(in->ld_id != CXL_UNSUPPORTED_LD_ID) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    return cxl_vcs_bind_vppb(cci->vcs, in->vcs_id, in->vppb_id,
+            in->physp_id, CXL_UNSUPPORTED_LD_ID);
+}
+
+/* CXL r3.2 Section 7.6.7.2.3: Unbind vPPB (Opcode 5202h) */
+static CXLRetCode cmd_unbind_vppb(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    struct cxl_fmapi_bind_vppb_req_pl {
+        uint8_t vcs_id;
+        uint8_t vppb_id;
+        uint16_t option;
+    } QEMU_PACKED *in = (void *)payload_in;
+    if(!cci->vcs) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    return cxl_vcs_unbind_vppb(cci->vcs, in->vcs_id, in->vppb_id, in->option);
+}
+
 /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
@@ -4903,6 +4952,36 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_vcs_mctp[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
+    [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
+        cmd_infostat_bg_op_sts, 0, 0 },
+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
+        cmd_infostat_bg_op_abort, 0, 0 },
+    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
+    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
+                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
+                              0, 0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = { "IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0 },
+    [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
+        cmd_get_physical_port_state, ~0, 0 },
+    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
+        cmd_physical_port_control, 2, 0 },
+    [VIRTUAL_SWITCH][BIND_VPPB] = { "BIND_VPPB",
+        cmd_bind_vppb, ~0, 0 },
+    [VIRTUAL_SWITCH][UNBIND_VPPB] = { "UNBIND_VPPB",
+        cmd_unbind_vppb, ~0, 0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, 0 },
+};
+
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                 size_t payload_max)
 {
@@ -4915,7 +4994,7 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
 void cxl_initialize_vcs_mctpcci(CXLCCI *cci, CXLVCSSwitch *vcs, DeviceState *d,
         DeviceState *intf, size_t payload_max)
 {
-    cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
+    cxl_copy_cci_commands(cci, cxl_cmd_set_vcs_mctp);
     cci->vcs = vcs;
     cci->d = d;
     cci->intf = intf;
-- 
2.47.3


