Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB20CEDDB1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 01:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syiDq-0006HA-0m; Wed, 09 Oct 2024 21:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1syiDn-0006H1-N3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 21:44:07 -0400
Received: from dormouse.elm.relay.mailchannels.net ([23.83.212.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1syiDl-0000IO-Qs
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 21:44:07 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BE77D325D71;
 Thu, 10 Oct 2024 01:44:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a297.dreamhost.com
 (trex-11.trex.outbound.svc.cluster.local [100.98.255.245])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4FEBA3250C5;
 Thu, 10 Oct 2024 01:44:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1728524642; a=rsa-sha256;
 cv=none;
 b=aNKvsXahHaL8ZtWO96p+95CwnGxCkugJHW4OOJlBNI+wyCRb4U7jyRIBNoQ/GZYnqBKWM4
 dB/wvlcZevctprFbCQQp3hjt32ky94ERZy7OcH9z1+0VjM+dHUtjqaDJZOXd0YdYNvoaYK
 qe0S9BO7xYon1JShj0socwTwrVREQ8N4r1DqZR/zfwoZOVh0fOrJAtRQk2jzpOwuPiIFP+
 3bau/10JjMwXfocOmarlDcdm7yF+/eVhke9CzallmT8bcADiUXH/pcBK+j0YtDUOS4soVL
 T3rfmr9tH9aHR+U4TGQnR6rHnzo1NrFAuJv3A5RFhcd/+ffWik6aidBj8pxZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1728524642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=NqrxnXGiiQfljak1MBS98Jqy6zC08yTGa6fSZ3v41OI=;
 b=Mc6eofpDl3vjwdbKBhxa0r6O5dQxYSpD5rIoLP3N9VgvmIewDlxDiaF8brBISRlvuaekUb
 fVUlYHHHgXY/S1c07NtOlYnQWucCyN6El/wPMZJ6yBdNDpxhuOghX0xND1MyYvVaLLfwvg
 cP0CQXDEe1dEy74n//dK/JTTGYfZWPtBZ9Lf8ZNVzDyqiexHLKLN2lRrxqcaG5zIRcihbt
 42S1SYLsHmdu2rgvledlYGpk4zjtsn++LuhWjfJw1SKxUZJfHKWftGcoLNSxMlWJdHraSn
 UcjZMYX+km9ijjsb0noM9FshWnzfnkFBShsgNREmsqiUkuOHBo2hXHKxD7q2bw==
ARC-Authentication-Results: i=1; rspamd-5fcd6bf96c-tz4fs;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Juvenile: 39e0825c34d70b95_1728524642581_1154290375
X-MC-Loop-Signature: 1728524642581:937976098
X-MC-Ingress-Time: 1728524642581
Received: from pdx1-sub0-mail-a297.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.98.255.245 (trex/7.0.2); Thu, 10 Oct 2024 01:44:02 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net
 [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a297.dreamhost.com (Postfix) with ESMTPSA id 4XPCGT62rBzJJ; 
 Wed,  9 Oct 2024 18:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1728524642;
 bh=NqrxnXGiiQfljak1MBS98Jqy6zC08yTGa6fSZ3v41OI=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=gHwJuKr7IBgS8jLC0CkCMxYhnZ+Y1WiuHOmrbaxs5nmoPYSfSrZ2j0JChzWZQkjMX
 NRYFl+38tpMpYCBo/wYcBfUr12+ao7bs8cPy2ye5TT1m6ubs92mfnBqAChfqclzPdD
 bu6oh5vbsO40ke9mGBNKEbLg8vY2l/G2MN6Hlv6W9mSIned+TiPzb0FUGvuqjNusSe
 Q9DzTFE2KLe2t9TTNGRXPSrbljEHN9HfOLhtPBUPrMGrbkCm+XcX5o+jVI3IzeVmRN
 3QJBJkSFEtfaamRt4kWhe8wBYd+h06T/0U9Kk9Xj2Yn3hv/1sPs1TxgDPd+rcP+ecW
 u/sc4Ky4Q4zBg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com, dave@stgolabs.net, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH -qemu] hw/cxl: Support get/set mctp response payload size
Date: Wed,  9 Oct 2024 18:41:57 -0700
Message-ID: <20241010014157.175548-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.212.50; envelope-from=dave@stgolabs.net;
 helo=dormouse.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add Get/Set Response Message Limit commands.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 68 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c2d776bc96eb..98416af794bb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
 
+#include <math.h>
+
 #include "qemu/osdep.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
@@ -56,6 +58,8 @@ enum {
     INFOSTAT    = 0x00,
         #define IS_IDENTIFY   0x1
         #define BACKGROUND_OPERATION_STATUS    0x2
+        #define GET_RESPONSE_MSG_LIMIT   0x3
+        #define SET_RESPONSE_MSG_LIMIT   0x4
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -393,7 +397,7 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
         uint16_t pcie_subsys_vid;
         uint16_t pcie_subsys_id;
         uint64_t sn;
-    uint8_t max_message_size;
+        uint8_t max_message_size;
         uint8_t component_type;
     } QEMU_PACKED *is_identify;
     QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
@@ -422,12 +426,58 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
         is_identify->component_type = 0x3; /* Type 3 */
     }
 
-    /* TODO: Allow this to vary across different CCIs */
-    is_identify->max_message_size = 9; /* 512 bytes - MCTP_CXL_MAILBOX_BYTES */
+    is_identify->max_message_size = (uint8_t)log2(cci->payload_max);
     *len_out = sizeof(*is_identify);
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.1.3: Get Response Message Limit (Opcode 0003h) */
+static CXLRetCode cmd_get_response_msg_limit(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint8_t rsp_limit;
+    } QEMU_PACKED *get_rsp_msg_limit = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*get_rsp_msg_limit) != 1);
+
+    get_rsp_msg_limit->rsp_limit = (uint8_t)log2(cci->payload_max);
+
+    *len_out = sizeof(*get_rsp_msg_limit);
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.1.4: Set Response Message Limit (Opcode 0004h) */
+static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint8_t rsp_limit;
+    } QEMU_PACKED *in = (void *)payload_in;
+    QEMU_BUILD_BUG_ON(sizeof(*in) != 1);
+    struct {
+        uint8_t rsp_limit;
+    } QEMU_PACKED *out = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*out) != 1);
+
+    if (in->rsp_limit < 8 || in->rsp_limit > 10) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    cci->payload_max = 1 << in->rsp_limit;
+    out->rsp_limit = in->rsp_limit;
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
                                   void *private)
 {
@@ -3000,6 +3050,10 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 
 static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
@@ -3035,6 +3089,10 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
 
 static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0,  0},
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
@@ -3055,6 +3113,10 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
 
 static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
-- 
2.46.1


