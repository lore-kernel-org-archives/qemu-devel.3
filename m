Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF28E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 14:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVABK-0000WF-ET; Tue, 07 Jan 2025 09:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=095394c9e=wilfred.mallawa@wdc.com>)
 id 1tV3cp-0008Bs-TR; Tue, 07 Jan 2025 02:03:40 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=095394c9e=wilfred.mallawa@wdc.com>)
 id 1tV3cR-0004zw-Mi; Tue, 07 Jan 2025 02:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1736233414; x=1767769414;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j/q79xHdmnI7HhNKdxz8x34ZiOnrEIZxDdCCKCaV8S8=;
 b=LIYgPS6F55D+MIbiNDURclURrl+V0lUs3vRTE42W1JbUauewfo23T/y7
 hIUTBPIQxhpzTbO9inujc0LPIscLHvvxoRwFqMf+a/Ewp9StKoqYW7ZEm
 YKHItgHUZc0LJyod43FSsZ2HWGPQk3dx96FMkWV3erRnQRRCtZ04ajflH
 ToBKdksDmOnfuq0Y4AkqibtEBGza6e/MIWFm4q528MfAZmxXi4phblrzm
 bV7l307HbPZ10VDRAw9HhbvpBNRn5eiT9d1OSftC2lg0vBE/rpWCOvHP8
 meMPlTkQkABQkLHoSvpmFvkhLAqCXWONspY1y1RXfETi80V4U1vJxmn9X Q==;
X-CSE-ConnectionGUID: QcRBScmSRoOQE0AxdCsiHw==
X-CSE-MsgGUID: Via1vERIRfCyh7tJccuQag==
X-IronPort-AV: E=Sophos;i="6.12,294,1728921600"; d="scan'208";a="35368529"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2025 15:03:14 +0800
IronPort-SDR: 677cc2e3_exhgayasJ6nIAHIASOx6EMl3hBNULGgWIpewD+SgWZT9REJ
 FRkTAuqYpg6LS/XtbV9mC1ZVHCSq3g6FxkZFHtA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Jan 2025 22:00:04 -0800
WDCIronportException: Internal
Received: from unknown (HELO fedora.wdc.com) ([10.225.165.88])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Jan 2025 23:03:08 -0800
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: alistair.francis@wdc.com, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, stefanha@redhat.com, fam@euphon.net, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 2/4] spdm: add spdm storage transport virtual header
Date: Tue,  7 Jan 2025 15:29:06 +1000
Message-ID: <20250107052906.249973-5-wilfred.mallawa@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
References: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=095394c9e=wilfred.mallawa@wdc.com; helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Jan 2025 09:03:36 -0500
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
Reply-to:  Wilfred Mallawa <wilfred.mallawa@wdc.com>
From:  Wilfred Mallawa via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This header contains the transport encoding for an SPDM message that
uses the SPDM over Storage transport as defined by the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/system/spdm-socket.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 2b7d03f82d..fc007e5b48 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -88,6 +88,18 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
  */
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
+/*
+ * Defines the transport encoding for SPDM, this information shall be passed
+ * down to the SPDM server, when conforming to the SPDM over Storage standard
+ * as defined by DSP0286.
+ */
+typedef struct QEMU_PACKED {
+    uint8_t security_protocol;
+    uint16_t security_protocol_specific;
+    bool inc_512;
+    uint32_t length;
+} StorageSpdmTransportHeader;
+
 #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
 #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
 #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
-- 
2.47.1


