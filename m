Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F09CE7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 14:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVABG-0000TJ-1j; Tue, 07 Jan 2025 09:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=095394c9e=wilfred.mallawa@wdc.com>)
 id 1tV3cV-0007wf-Dl; Tue, 07 Jan 2025 02:03:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=095394c9e=wilfred.mallawa@wdc.com>)
 id 1tV3cO-0004zZ-2y; Tue, 07 Jan 2025 02:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1736233392; x=1767769392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gYmecUfEHFrflkAIsndmLPSY9mdKQbd3wN3YyLyxmmc=;
 b=rYCWKpcm3FNXR8i7bO9S5tAHVRpKjejZsEa1QM9hmYtzGV2o4RXsfEFb
 m4u5NI9ojjYquEl/XnsYarWVlXpe83Jsfb5CqhAMB8ccWVAn83r/cpbuC
 GxFvS66LOyVkxSmbGFqjLa9nu69lb6dQcw3EJ+ek7l5m8yMaRY8z1DLdy
 1O6y3ugb4pQmZ1KNz5KdJldzhM1no+dLeuS6BLJfnvhxeKz7fHLDhIDmU
 febyPkiRfVm1KYT5fGB7P0f4vYEO8CGDHXDI7IEnDMw9R7m6tE2lQSwLl
 g8rkQzF2Xy/53o9uLv295QzgkT5kliS/RUyhvwl+fMajUWixXhZVBG3Fe A==;
X-CSE-ConnectionGUID: 1GvPkIT1SQOWoiPSONDu5g==
X-CSE-MsgGUID: wUAtLr6UT5mWTHdCMAh+Ow==
X-IronPort-AV: E=Sophos;i="6.12,294,1728921600"; d="scan'208";a="35368515"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2025 15:03:07 +0800
IronPort-SDR: 677cc2dd_Ob7RuuFP5XDg3A5i2GtWeRMrDB1Hk7Mzclm7SBN3FK8eWTS
 M9JZxn2PUZ8lg8HwIaQraJnd+wW4et5n6stM1pw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Jan 2025 21:59:57 -0800
WDCIronportException: Internal
Received: from unknown (HELO fedora.wdc.com) ([10.225.165.88])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Jan 2025 23:03:02 -0800
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: alistair.francis@wdc.com, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, stefanha@redhat.com, fam@euphon.net, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 1/4] spdm-socket: add seperate send/recv functions
Date: Tue,  7 Jan 2025 15:29:05 +1000
Message-ID: <20250107052906.249973-4-wilfred.mallawa@wdc.com>
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

This is to support uni-directional transports such as SPDM
over Storage. As specified by the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 backends/spdm-socket.c       | 25 +++++++++++++++++++++++++
 include/system/spdm-socket.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 2c709c68c8..4421b5c532 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -184,6 +184,31 @@ int spdm_socket_connect(uint16_t port, Error **errp)
     return client_socket;
 }
 
+uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
+                             void *rsp, uint32_t rsp_len)
+{
+    uint32_t command;
+    bool result;
+
+    result = receive_platform_data(socket, transport_type, &command,
+                                   (uint8_t *)rsp, &rsp_len);
+
+    if (!result) {
+        return 0;
+    }
+
+    assert(command != 0);
+
+    return rsp_len;
+}
+
+bool spdm_socket_send(const int socket, uint32_t socket_cmd,
+                      uint32_t transport_type, void *req, uint32_t req_len)
+{
+    return send_platform_data(socket, transport_type,
+                              socket_cmd, req, req_len);
+}
+
 uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
                          void *req, uint32_t req_len,
                          void *rsp, uint32_t rsp_len)
diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 5d8bd9aa4e..2b7d03f82d 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -50,6 +50,35 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
                          void *req, uint32_t req_len,
                          void *rsp, uint32_t rsp_len);
 
+/**
+ * spdm_socket_rsp: Receive a message from an SPDM server
+ * @socket: socket returned from spdm_socket_connect()
+ * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ * @rsp: response buffer
+ * @rsp_len: response buffer length
+ *
+ * Receives a message from the SPDM server and returns the number of bytes
+ * received or 0 on failure. This can be used to receive a message from the SPDM
+ * server without sending anything first.
+ */
+uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
+                             void *rsp, uint32_t rsp_len);
+
+/**
+ * spdm_socket_rsp: Sends a message to an SPDM server
+ * @socket: socket returned from spdm_socket_connect()
+ * @socket_cmd: socket command type (normal/if_recv/if_send etc...)
+ * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ * @req: request buffer
+ * @req_len: request buffer length
+ *
+ * Sends platform data to a SPDM server on socket, returns true on success.
+ * The response from the server must then be fetched by using
+ * spdm_socket_receive().
+ */
+bool spdm_socket_send(const int socket, uint32_t socket_cmd,
+                      uint32_t transport_type, void *req, uint32_t req_len);
+
 /**
  * spdm_socket_close: send a shutdown command to the server
  * @socket: socket returned from spdm_socket_connect()
@@ -60,6 +89,9 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
 #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
+#define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
+#define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
+#define SOCKET_SPDM_STORAGE_ACK_STATUS            0x0004
 #define SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE  0x8001
 #define SPDM_SOCKET_COMMAND_CONTINUE              0xFFFD
 #define SPDM_SOCKET_COMMAND_SHUTDOWN              0xFFFE
@@ -68,7 +100,10 @@ void spdm_socket_close(const int socket, uint32_t transport_type);
 
 #define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
 #define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
+#define SPDM_SOCKET_TRANSPORT_TYPE_SCSI           0x03
+#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
 
 #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
+#define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
 
 #endif
-- 
2.47.1


