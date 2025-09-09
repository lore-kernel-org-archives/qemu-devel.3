Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B54CAC581
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 04:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvq3W-0006F7-Pi; Tue, 09 Sep 2025 00:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uvq3U-0006EL-Ia; Tue, 09 Sep 2025 00:34:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uvq3R-0003DZ-8j; Tue, 09 Sep 2025 00:34:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so4604280b3a.1; 
 Mon, 08 Sep 2025 21:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757392442; x=1757997242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5g8XeO54kr+q7zWCREG86S9uAOS/RrMRa5OI3IBauo=;
 b=WjYJA2NqXwDJ8IBnKdlatzPqZJOlKQxmLVjJevn6HqrWc+8lQUWBv1YTDKBVVurQWy
 VRad4v8qW0X6bGK4Yujc1Rk1A96irUSU0FQm3H1YQ8nt/kjbSkwEkC+RzOYmWyL8ZXM/
 LUfrMrJIeT9IxYIbKSci6/Pf+PVivfgQFGkEbRoql+GujtjmPQa5UdG2brE6onHR6Snv
 F/uVOSmX2+Rpna6Deb9EgcHafEs1eRqBKWBhgXow6Qq/7isJFOCOS7HybTG6kwefoD2G
 kXDQS5t1hVogHEbaKbvt5xhqtffdwMNvOMFJLRlo8VQjOQvRvzpL0CxS29rtAul6GBLa
 TFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757392442; x=1757997242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5g8XeO54kr+q7zWCREG86S9uAOS/RrMRa5OI3IBauo=;
 b=Nf6jORs1TX/UZH5QoOdYhzEiOMSfs5ktjBzS1FmMxEdnKAuGrljOLs6+BYyosROBo0
 RRqT4eDV7cY6SiYN+Tm4BbOhwa919R05GgrmHdBofy5vgsYvHuv9F02o70qc7hyseQZQ
 pvyX1/q5fvL3mXxlpE1U9Y5OdtATkltL3b+nxD9qDap71Xfrp5q5hFYCK5Hv9AvKbdkW
 WR6LOjSME+Vb8eFzNKcZE4+ME3EqxW2eL5SbTu/mebr7EHpOK0y8A84yGheYb9hQq1Wu
 NVrQETA0Z9DVWUSjAmpMbs0GE3HafdpWbrgWZessjm2+0SDXMfg4SmDkfz5peMx2qcda
 FyGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv91VnxQssyRTwIHjjAC+vgDf1vRBOITBxxAzs25OEyBkHr01xsl5hbapX5urEHNcAtPoHNuDfd7CY@nongnu.org
X-Gm-Message-State: AOJu0YzYSxNcazLj1E8S+0eJtk2egxmJvvv8lQ7yXLYrGQxUkQw3BVrj
 eWZpOU5ffktb5z7LAtp2jbWJMZrq9WF4K15dLa7OzeRvhsQZ7uNsLKrc
X-Gm-Gg: ASbGncsFm3Vyi+6jnHF7yxm002VGZzMEuWN9mUKqtPD5H8exRqlcJFQnDRS6by18VLA
 WW4pTtZPmjAzIX5YbrgXrFIcAAaOA5j+7x6UJcpMREeQJuA/nUr+GmEpCRFmepQtM+ReU2EM0IH
 Q9h95EsXzLrLHkumlXbSL1UvoibJknsWCTv1RP/xClnfafAa0tHZECKshnILcbPcgGSy+ufD7BG
 Kv1kY2U4BxSI7kHvT4V6yY6owi1CY3wOCSnSKIAH//AXLgnzB+tqZNJaBoljQkFbIRtnYlRm82Q
 UqKB0gyHubxRpJAQq7SBNEnpSdNxo1RClnUfcd9VQ9lzQD+Ilb2bOEHZF3PXcMqDW8rjh9+mhvw
 gGvj75fGCZedPgCukjnk0eui/l0EMhG9pi1nHS46T5+RxWbXib/zl
X-Google-Smtp-Source: AGHT+IF/1UhUxEc9qpZlyDWLVd1wC1YKqzxcd+gcvFkBcFXzCS1XOnOwmWCjzx6Jsu5C6DSGxJfGCA==
X-Received: by 2002:a05:6a00:3e29:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-7742e3b8783mr11811177b3a.6.1757392442399; 
 Mon, 08 Sep 2025 21:34:02 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-774661247cdsm606534b3a.33.2025.09.08.21.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 21:34:01 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v5 1/5] spdm-socket: add seperate send/recv functions
Date: Tue,  9 Sep 2025 14:32:56 +1000
Message-ID: <20250909043259.93140-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909043259.93140-2-wilfred.opensource@gmail.com>
References: <20250909043259.93140-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This is to support uni-directional transports such as SPDM over Storage.
As specified by the DMTF DSP0286.

Also update spdm_socket_rsp() to use the new send()/receive() functions. For
the case of spdm_socket_receive(), this allows us to do error checking
in one place with the addition of spdm_socket_command_valid().

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 backends/spdm-socket.c       | 55 ++++++++++++++++++++++++++++--------
 include/system/spdm-socket.h | 32 +++++++++++++++++++++
 2 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 2c709c68c8..845ea87b72 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -184,28 +184,61 @@ int spdm_socket_connect(uint16_t port, Error **errp)
     return client_socket;
 }
 
-uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
-                         void *req, uint32_t req_len,
-                         void *rsp, uint32_t rsp_len)
+static bool spdm_socket_command_valid(uint32_t command)
+{
+    switch (command) {
+    case SPDM_SOCKET_COMMAND_NORMAL:
+    case SPDM_SOCKET_STORAGE_CMD_IF_SEND:
+    case SPDM_SOCKET_STORAGE_CMD_IF_RECV:
+    case SOCKET_SPDM_STORAGE_ACK_STATUS:
+    case SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE:
+    case SPDM_SOCKET_COMMAND_CONTINUE:
+    case SPDM_SOCKET_COMMAND_SHUTDOWN:
+    case SPDM_SOCKET_COMMAND_UNKOWN:
+    case SPDM_SOCKET_COMMAND_TEST:
+        return true;
+    default:
+        return false;
+    }
+}
+
+uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
+                             void *rsp, uint32_t rsp_len)
 {
     uint32_t command;
     bool result;
 
-    result = send_platform_data(socket, transport_type,
-                                SPDM_SOCKET_COMMAND_NORMAL,
-                                req, req_len);
-    if (!result) {
+    result = receive_platform_data(socket, transport_type, &command,
+                                   (uint8_t *)rsp, &rsp_len);
+
+    /* we may have received some data, but check if the command is valid */
+    if (!result || !spdm_socket_command_valid(command)) {
         return 0;
     }
 
-    result = receive_platform_data(socket, transport_type, &command,
-                                   (uint8_t *)rsp, &rsp_len);
+    return rsp_len;
+}
+
+bool spdm_socket_send(const int socket, uint32_t socket_cmd,
+                      uint32_t transport_type, void *req, uint32_t req_len)
+{
+    return send_platform_data(socket, transport_type, socket_cmd, req,
+                              req_len);
+}
+
+uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
+                         void *req, uint32_t req_len,
+                         void *rsp, uint32_t rsp_len)
+{
+    bool result;
+
+    result = spdm_socket_send(socket, SPDM_SOCKET_COMMAND_NORMAL,
+                              transport_type, req, req_len);
     if (!result) {
         return 0;
     }
 
-    assert(command != 0);
-
+    rsp_len = spdm_socket_receive(socket, transport_type, rsp, rsp_len);
     return rsp_len;
 }
 
diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 5d8bd9aa4e..29aa04fd52 100644
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
-- 
2.51.0


