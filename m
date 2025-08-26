Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CE9CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 05:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqmWk-0000dR-Na; Tue, 26 Aug 2025 01:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWW-0000Xv-2F; Tue, 26 Aug 2025 01:47:16 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWP-0007FC-9N; Tue, 26 Aug 2025 01:47:09 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-32597b88f0dso1632262a91.3; 
 Mon, 25 Aug 2025 22:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756187218; x=1756792018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UiXR8FRiYli5OCixlKdlXRa1V5eOOYhqgAqd+KK4XI=;
 b=h8eTiQK+7vQtQizQOB/UDio6NOCpT98MtKofjr17rYiV7YzAZjfqV4nfaAAOrURvl1
 y8hRZIhtsLIciecTlEMHpBRXZrOZmPpFAESvalsqb8RrwdrV81x2xeg6xSfKLllO+yX7
 ZITIrZo6Z9VCiuESP9wQEjwUkP5haSzfn1uOUT0inl+SM6nd5m4oBAkBgx6xNYxX+iOz
 lsUqfV3l7dK7toIWKRNQ8qSWqpjgKmytdZgpW7dnW78PwDYpz5NhHi1iUph72oDqsyPs
 nFcN0T8sGt0aKtQRdfl3+bRLbLIdHECFnEaHrfRYfw5gnTZV6c3gHA8hAxMbGRsPwFsf
 yyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756187218; x=1756792018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UiXR8FRiYli5OCixlKdlXRa1V5eOOYhqgAqd+KK4XI=;
 b=ehZZXqyqlE9/d9elXdnjIUGlLSN6RNZ+xyN0sRdfEa1p8GcTJhkTmwX9rk0uGHXKUI
 yHpQ3/XD+JHwnNYvScKcsu6KRYuWF0PWhLdGr+tyuLDZFXVT4WSYVustA+Z6BF5xKZW8
 cvp3QFR18RNLhFtv5UfFzic/bsJ8H2QmpZG98FblYIofuKVwzkLFnITE8XYom3QEmfmW
 QUaKwCJTmz0Xm2qbCCa2kSlDu0kdzrIkyJ4jYOHy6bMy71Gkb7caLcK97Iy/1NCw7PAU
 k+M2JdsN4DrCpsx2He5n9YPMU7XxSKVjmzx3gsp21ry1fYqVBwPPWPkhPUmvYgO/tY+d
 sPog==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/eQdOFqyfDOXUf+LwMirhiQeF0qNgbxGuVBFJaLR9q7yrLyPNPweo7Zm11aXct8BBIqeptprHGJ12BA==@nongnu.org,
 AJvYcCXxUh0qn/5Wlms53973xA1Ib5aKggopA43GUq42OBnnB+UEtB4ngw+k1EhjEGBGVadaWqglI0iQ/cDa@nongnu.org
X-Gm-Message-State: AOJu0Yzedw8wzKw2XXCyT/UQZI0ZgmleeYQ8dUf66U/bwQTuDlG2LDGT
 vC8FA9Vrod5CoHqZwJ8lw2vA3kE/gZET+eYqJ4vMtdDn1qZontUSQLNv
X-Gm-Gg: ASbGnct6AlRLdHgUpGb70gWYShtCBxpohEP4CMrMWpmWEZeoQoggkZR9pkfXC3nl8dx
 5k2JNKf06W2PiDYjxU8Wyub33KeU+ZaH2+PWUcAGkUM1mX6UTkw9/l4z4ne2GL5Gp2vMM9OVlB2
 orQR9j7e13NyMc9UrGNMlynZyvFtgmOJtJPBgz+GIrlkiOQ29vnxrG9/vBdB2tYhgSoOcV/ut9T
 g82yc7qqi1a4IbDcav0uDwGJMFupom/mNcT4o79Ys+wLvmV13isM7c8jaq+JhU6hdyJtMIcXNIE
 nOrfHfyEfzKWqS35yQs6Yj2yZARP53Y1EkUcXVMI/Lff2Nw3nxVYLtcnd/y9FqWnwOq1OWWLcYR
 yKgNtle9a6+5Br7siACteLKDDGQ==
X-Google-Smtp-Source: AGHT+IFm8LKJYLDYMjukzBQleQAgmizZXli5ewkl3EvcQEi8qj9rdpRFLVaAQ1AQ1MwZIiIPoZrPiQ==
X-Received: by 2002:a17:90b:53c8:b0:323:7e82:fcd with SMTP id
 98e67ed59e1d1-32517b2bba5mr19935421a91.37.1756187217897; 
 Mon, 25 Aug 2025 22:46:57 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-770401afdaesm9032365b3a.53.2025.08.25.22.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 22:46:57 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 1/4] spdm-socket: add seperate send/recv functions
Date: Tue, 26 Aug 2025 15:46:27 +1000
Message-ID: <20250826054630.222052-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826054630.222052-1-wilfred.opensource@gmail.com>
References: <20250826054630.222052-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pj1-x1029.google.com
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

This is to support uni-directional transports such as SPDM
over Storage. As specified by the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 backends/spdm-socket.c       | 27 ++++++++++++++++++++++++---
 include/system/spdm-socket.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 2c709c68c8..bab1b512c8 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -184,6 +184,29 @@ int spdm_socket_connect(uint16_t port, Error **errp)
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
+    if (!result || command == 0) {
+        return 0;
+    }
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
@@ -200,12 +223,10 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
 
     result = receive_platform_data(socket, transport_type, &command,
                                    (uint8_t *)rsp, &rsp_len);
-    if (!result) {
+    if (!result || command == 0) {
         return 0;
     }
 
-    assert(command != 0);
-
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


