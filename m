Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58387CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usvXv-0002Sa-Ip; Sun, 31 Aug 2025 23:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvXr-0002Qt-DV; Sun, 31 Aug 2025 23:49:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvXp-0005ff-Hs; Sun, 31 Aug 2025 23:49:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-249406d5878so12836555ad.0; 
 Sun, 31 Aug 2025 20:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756698562; x=1757303362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjacYaLKOhLtcN2plgF+C3NWVsLcWnhBIR1v/WVcDRc=;
 b=MwG+Ob2rTqSDXUppg4RVznGnW+A2sMiW5pKG3XaRva4AFRS3JkFvfk/mTlGTDzXVTZ
 LpI2G/wh8OIBrF0g7HZsFF5CGxaNPr7Se1etH68rWcK1dXlsrcX0SkhuQfzD/bDL13BT
 //Zc9XRCOL5iuD7VtIWYAr5NzUPVfPBMGkZZp4W6CxnyZ6x1b1T58Ju3SiYGLoqXg124
 cr1PqKuOUFBFdZmkdlsF15ZvtC9tn2K+rv9sdiky41c4+tDNlrYl5xAVfqx4qSumoqDV
 U7IKyoVG5MWp9+3PiguBSDpBkmfODL+3ioYY8ukGXHsjllABn+d8pT05+JjO1gyZLDwY
 BC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756698562; x=1757303362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjacYaLKOhLtcN2plgF+C3NWVsLcWnhBIR1v/WVcDRc=;
 b=eQ+HiqExkWfo0VpXSN9a7nz0RYTxgn/60Fl2yZHsjl70FUpQjAOOBk5e8yc/Ww2y9p
 0v8JKRLNRHR4VCm5UTKOiDq7Lrab/HCFOYY248+cRkcBcoj30r7VgVm9jFUdZjYnloA1
 3iAJ5Hu5XvOB2hFbxcz2gXDcuxP1P7fsCdqcGG4KQ0b4vx6DdUzKsOHcEuRPeDxhiRMv
 /VjSKXQq9AFVXHskSABcGf8DMn0M6Ogr1jnsGIl5lBv0H9O4Qp/UbUWDsTPgu6tWvlIt
 o4SXv1ZWuQY28c/njVLb/3ZU4ZQ7WlprrnYuyoO5zUzuVRtbGXbdzBh12EuIxJcSly+a
 OY4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvYqgLMh1xTTNcvdCiZojMb0E5jDtb3JX9PaT2DMnWyKhObPZZ7G4nBpiBryt3JDy+ajJfu2PX+QDL@nongnu.org,
 AJvYcCV4O0ZvUzMeuJDyDp+tWGS5obvqLUT9aKtCdAM4ednSvK/ciuLp1gP/n5a+uFRdc3VBJJ8o8x3QyKR9Xg==@nongnu.org
X-Gm-Message-State: AOJu0YycQL3JVTvvYUhwqeESleO8JSXWehrU31nVTnFTpwYg6yD0uveG
 Wr0/U0XQF8vbcVvutGd5JfvTPKn5wV5o0tnmiVE0+cYK+XW+Idg2TWI5
X-Gm-Gg: ASbGncvjNagyRNN37bdmMMnDb/ggppo5u1asjjH5bZ/BUZm81r3uHTBXiDPYfbKh7X/
 XJnCYy5LVXSPx5FW/Yj3s3yqqY0utxNFG8upHKAbInPTO5Ix2+CBxRWAiiLVi1OE+8nbU5mrgpW
 nDjZ5axJUZWeetDbWbG8bvJTVarvjYkW4ffgJxni6AaSfDtc/fCSoNzA5spN9WXxuvXMmYrIsps
 2nuLd3reHAUhZnS4a3OcaopOwt19LMu1Yyf3t1bN2Tx57Uu4B+DttIEqMSFls4aStLB7sBLiuco
 zNFwSwNULJuaTFSdZ9yabkVYFk9BfAZpM15EMuJBf2qjz+2Iv/AY2q7K20mxCgB6huqAnL80FBh
 KCYJPLq4S5nyLEM0QIAVB7obIi4nKSEKOgVR5
X-Google-Smtp-Source: AGHT+IGuz0kVu9sKmb8wZxrpAQckq5F0pWTtVRV7KjQb/4qmOq2Zmw6Zdgya5GGleFVXpYS9WOg0sg==
X-Received: by 2002:a17:903:41c9:b0:249:147:95bb with SMTP id
 d9443c01a7336-249448de13fmr71926095ad.13.1756698562433; 
 Sun, 31 Aug 2025 20:49:22 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da26b9sm89802815ad.93.2025.08.31.20.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 20:49:21 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v3 1/5] spdm-socket: add seperate send/recv functions
Date: Mon,  1 Sep 2025 13:47:56 +1000
Message-ID: <20250901034759.85042-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901034759.85042-2-wilfred.opensource@gmail.com>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x62f.google.com
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
 backends/spdm-socket.c       | 56 +++++++++++++++++++++++++++++-------
 include/system/spdm-socket.h | 35 ++++++++++++++++++++++
 2 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 2c709c68c8..3d264814df 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -184,28 +184,62 @@ int spdm_socket_connect(uint16_t port, Error **errp)
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
+    return send_platform_data(socket, transport_type,
+                              socket_cmd, req, req_len);
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
+    rsp_len = spdm_socket_receive(socket, transport_type, (uint8_t *)rsp,
+                                  rsp_len);
     return rsp_len;
 }
 
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
2.51.0


