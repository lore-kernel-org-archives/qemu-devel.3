Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58085CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4e9H-0002x9-Or; Fri, 03 Oct 2025 07:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e9F-0002wP-60
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:29 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e98-0006a7-JZ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:28 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3324523dfb2so1866520a91.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759491614; x=1760096414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhT7qXe85uoN2MQpytD0lVke830oeE9rrN9Y/OiM4UI=;
 b=DRehekA1gBvgv3NJxUedfqNbWZ9GS4mOd0eEeM/s9dqWlcInxfsG0/gVJqQPPqVyFE
 27lJouywbsEWriqnMU0H3r0SrNWvx5dhsTM9Mzaxkp31SQUiU71H0UkYBxAR0k+0iQyZ
 zjnsnMMPvRA0xhioUL+38RrbhwIDrS8uCISFkhqrjJvjXR+EgamV6sx+Z3UQJPxpegdG
 WL7eFWTIbcUUCPlyWWcQDj3IMeTw0sJI7ZCuJw+4L0IBCg8X0HoN5+KLn9/YC3DNgROe
 KR6SDNXT1NzGhGlqXbMqGzILIlp5Gi1113dX8yCraLfewOQ90kvJAl75yeOtvvkd3jIH
 wGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759491614; x=1760096414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhT7qXe85uoN2MQpytD0lVke830oeE9rrN9Y/OiM4UI=;
 b=XirenCgS7wyO7YO9DnlD9XkeHcDNsVmjJBN2l2jTnTdSE//crjaD/ewZepJo0nLGhE
 GpcvsQqD1ap79cgYVr/DNhgItdiuBfBWMIELjrXiUelWNbHEJaEx85nFCjO/zLEcqbzt
 RBswXFF/Zz8fZ+DHdaa5DnDrRO1KFiB+hjelMGQskfJk6f5hd5c3ryIGUIqwrumXCQJ8
 De6zq78CFEzEMy/1Xt+D5pnTVXh/ARTTFOl8Py7jmXJBYmNF9y1xtJbyxs/djU+u+zEh
 UUyNs5u6tLzeYud/94AMXQbrh/Kztf/KO6U7/99csRhIRrfpUt5mOtKxWlnxaBaM7Vg3
 W/eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMD7n6Hxvfs37BG5kNEKErgLx74CqJk5lrcz+bJg1WAXjL03GiS5tGSKOo4FaGQmSnGJg8YEEg0Csa@nongnu.org
X-Gm-Message-State: AOJu0YxXaouoX0spvMaGUknfokvQyaAyQxXigMLx7YmTaTCIpkTfLdaI
 RdCyNR9KUNvYQpKdIgwBCZiwCo0EazeBnebfPVEgH1lGEKpapRJnFwuk
X-Gm-Gg: ASbGncsLJQiafVpPh0s03rCBJLwawgppwddD5jR9QGtIHKYDUfYyB531NsHbe6bD9mz
 kKq5KRt2Th4xQ2RhV3EfuOgRZIsZcyZB6CsIu1WHn9FHk9zSWD4DoJl2ft+buFKqIuBg1bYtCed
 t4NwEZGYmBKUVRLfPeyHVSz+s41RIPX5ISAGoWWfJusqaZmOoKf+FScTS8GfnzqBc1HhKa56MSn
 SK1t+KZz4QvY2X1eUT2bpQwvsSzy6I88mTyEsv47SZJzxvUWLXbTVT3zlqV+TRtay42/3mjFeo9
 GVZQm5HQ/EjyO8d32nfyqfGE76g6HzxdaQWSR3lXW+hH7jPOaYYSc9mVFtoWIRPbQg6lF2K8lmi
 U47Nz3DK08BPVSI0xrnFlwezFC05BcBU3FsS07x+rUy3aN3L71d8=
X-Google-Smtp-Source: AGHT+IFB+tiWTu0mYLC6+mWduMEb536JRrL/LOeMlsRt3SpnmXFk/1vQO3J++FL/HVjRAbHj/6sS4Q==
X-Received: by 2002:a17:90b:1b07:b0:32b:cb15:5fdc with SMTP id
 98e67ed59e1d1-339c27af443mr3189729a91.30.1759491614387; 
 Fri, 03 Oct 2025 04:40:14 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ff26f8sm7804995a91.13.2025.10.03.04.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 04:40:14 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v8 1/5] spdm-socket: add seperate send/recv functions
Date: Fri,  3 Oct 2025 21:39:42 +1000
Message-ID: <20251003113945.87962-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003113945.87962-2-wilfred.opensource@gmail.com>
References: <20251003113945.87962-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pj1-x102c.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 backends/spdm-socket.c       | 56 ++++++++++++++++++++++++++++--------
 include/system/spdm-socket.h | 32 +++++++++++++++++++++
 2 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 2c709c68c8..ab74a02d9c 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -184,29 +184,61 @@ int spdm_socket_connect(uint16_t port, Error **errp)
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
-    return rsp_len;
+    return spdm_socket_receive(socket, transport_type, rsp, rsp_len);
 }
 
 void spdm_socket_close(const int socket, uint32_t transport_type)
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


