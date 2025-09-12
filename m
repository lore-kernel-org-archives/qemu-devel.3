Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3C1CAC58E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 02:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwtGy-0002Kv-Nv; Thu, 11 Sep 2025 22:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtGx-0002KS-OT
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:23 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtGq-00055o-16
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:23 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b49c1c130c9so990894a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 19:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757643134; x=1758247934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3Ue5pghwP4uwx+oHlIvFn46LDHxEJsAXYRGOuLoMuY=;
 b=nDl7+BQWyzN/cXAh7YDEStRNn3ZYcMlWzTAs43Gi7AzrXd/VBttrTKHu6DKOflKJY0
 S0WJ9W9BWLEb6HDTgraL6WWz3STrdUoLaFYGooZD0OaE70wfukdfjn74KpP4CFQBiWPU
 ZrnrT14pLCCEgQGmMqu0bJn++Tqel2bJhmyXQmFfcHrLHknhflCD55PZhnHqPBeHfxz7
 VXLfZRqwrRrHy41r04qlGbbLXgxtvKn8lXKccPZ1sz6aDpS4WGJzHgEZIewwJ6Rri2/u
 L22+ETomeeMMph5Ez9tPtdmIAFSs7pB2ParPpvtUDH4uovEQZGakw6HkKKXcGuR/Y7ug
 nKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757643134; x=1758247934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3Ue5pghwP4uwx+oHlIvFn46LDHxEJsAXYRGOuLoMuY=;
 b=b3PjhIifirPox78t+d0svuAhpUdhPkHkU4tM76JKUprvQQ34ZNhKKC1Sfqh63xp5zk
 RUNPqroO1KfXhUC/W7ZbQ7Fu6AJUqsRhoVfFCcFdNxMg9+kPtaxknn8WRu91UT2ZRvac
 pS1fw+QIvEgV/NWfdnulbFDlxcoZ4vvQnsZn2OE+GW2xJkSqwwSmDV05Z1SaQKHqbXk6
 ir72iZuTdPF4lEHfXS4HjHqbXpeRNufV3LHE653kfkLMC3ES9xcKH3c7XVJaH9NHpW1c
 HWqgMet31QvGQUQIxk4MjoZV94WcdqUczyDnELTvbVjDd+607/EnW/H4d6i1fmNUU5hY
 LThQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVol3szs7tyyAgmFEvhfKw4sT3aCz1eJA3W6n/UyAqf7DL+6YUB01VhYIaT6L1izSeDh9q/kiAwcYac@nongnu.org
X-Gm-Message-State: AOJu0YwTs6/hs/eBKAiDgHnjX6CGPj6RxBgsZ2HLEdRSmfWtBSEy/t/I
 /0U28qBmrJ+L0bXfLfqdg5uZ4CMsrTpgkIhkZK0pJvy7oXq03vmKuohB
X-Gm-Gg: ASbGncsFbBZVCyPuz4T+CI8qM/39ta+A5LS70OI+mCY3or6Vtr6QsK0r3slsdZPBzKB
 KoxYELq9GvlJtXbgHx2mrCbWDWiojCAetmiypwnQtnWtyLw6F4HIQ2D7ABAsL1uP5HsWSBk10j3
 fBvZRwpCEo5ARcmrxhJYxw1sQAeby7c6GjEcAK6xOFgSXjD1cSvhCGiSY6f8UD0zV6fWMmy+zrz
 UHFLH7gkPbw/bRFZDujPe8LTSq+Vz65wQvEt0cKI5TubV3T6dq5fUAeefKhiGLEd94mLhwHF7n/
 /Auyt+qSHUQhBCfthiS2iNHXmowSxy0Yn+RirwUrEieqT5oWkjcITDHy4LQarW0+Y8bhTtDvIbg
 C3H4M/BuslZuFbZnb14Kz4ltbsLB5N4eAC1okqU55ug==
X-Google-Smtp-Source: AGHT+IE+rYjmSR/VVbCN0aR+BJP0IiqXSo9nbYhYwLaiEHUXFKvOUP3Lt7vVuzFVoi32bUDCBMhcxQ==
X-Received: by 2002:a17:903:2351:b0:24c:d6c6:c656 with SMTP id
 d9443c01a7336-25d24cac504mr16621855ad.4.1757643134162; 
 Thu, 11 Sep 2025 19:12:14 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25c3ad3349fsm32853205ad.104.2025.09.11.19.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 19:12:13 -0700 (PDT)
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
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v7 1/5] spdm-socket: add seperate send/recv functions
Date: Fri, 12 Sep 2025 12:11:48 +1000
Message-ID: <20250912021152.46556-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912021152.46556-1-wilfred.opensource@gmail.com>
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


