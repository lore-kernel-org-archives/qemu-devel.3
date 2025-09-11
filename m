Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9923ECAC583
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 06:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwaNT-00019h-20; Thu, 11 Sep 2025 02:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNS-00019R-0a
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:01:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNQ-0000ZR-4q
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:01:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7725de6b57dso435343b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 23:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757570507; x=1758175307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3Ue5pghwP4uwx+oHlIvFn46LDHxEJsAXYRGOuLoMuY=;
 b=Cx9vB2DKFBu2x7N5mQKUu/F5Zd2pbcBomf8PbzdUavXTmT4UBduCwu4CDLQ55TSNVR
 b/NcsSSA41tXFzuZ0sPxBKUiQkjTHKfrZvvH2wm0YMaICoeBIe/RcbQ2z/NvKQmOaB6c
 IHcDkpaDa5mziXfFq7sdba1rjRiMpm0ZtYeQ2tHGDv+Sq2MQ/2wp0DGLF0nqhYLp0nuu
 2K0V6H2WC88M2cVQjMdtXZqjZHRwSyrs79SHr7o20Jw1jcnHXoszQMt9XMJP6Xsvtzft
 xYXmqDfg0CQljcZaX3QhucWHf1MSLIqgECR6STbilsnsRtJCLhO/cBKtrA4COg84Zad2
 yMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757570507; x=1758175307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3Ue5pghwP4uwx+oHlIvFn46LDHxEJsAXYRGOuLoMuY=;
 b=RG0W8VyBAd4FGIWcxNSV/gKFJIHvk8+ey9bRAHkEQYR5VjTUg3Ug3TcMP9XnR2goOZ
 T7uOmQbgaWFW18rsQ9Yfp+P0bWsTv2pwbMcFOzGdO9I2F3NIXniensSXdtY6yx9cxlm9
 CPzNzw+krasqAa0D3h4dCEletyqvWxZt0x5SBCenG6ziKYaTsr4D3jv2rxgSC/y3KShP
 X5nfbIkPQ0QkgPoNVkHLrgPC3UsiNZnsQmkAl7cCH+qyyLFx9KXpwR5LPe+UaGlRVR+z
 uSC3RwiHNaGQqBP06UQGGZRCuqeJUnYtc+HWCLivMZRVRPuPD6/GW/ULH9DNZKcNvH8f
 wcYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfx2qtO4hjTZgzUbIxuqjomOnKGumoTaxj89xhzLtrnJcyUbNlBwOT9YLvN0yP1D0TkWD0MzwIT/vQ@nongnu.org
X-Gm-Message-State: AOJu0Yyg6sKvJGgbBuTbsZgQID51u2dTsd9zQrk6eY9cbxqHS4Xk0VcL
 yFJvjAUG8BLvlve0mgGuuLu4pettOPib3DWRrbfbUpWjlgIVUWLMaDfX
X-Gm-Gg: ASbGncsxSQ6ROM9KnUC04u9FVXudHP6UQeasFmj2Wf9e/lY0YpUEKqSodA4ZeSyL7XH
 4E9yXPsrmr1/ryb/LOCFOEM/66416aZicyaKU8mg0/IBqSnJDjml2xDcwz7VaBNw6L3qjbriI9S
 5VhcSxmU4pSWSCKwT8QB9FPV3KGNRD9IHY7RMLTVfnbYhC5iFo5oNG4teMhJ4VerFF/ZE4nMGEI
 nfKXVe5AHW8eYYLqDs52k0fZ6dKRhWa/2DvEsMrNtRnjulJbaj9YOPPAvxnj2MvrTBQfgAGtN9J
 wFwLN/ihLouKyaVWmiovwzfDLqT/OkPemadaL6s/8BpsnlQtFGC3Y5qQ8AjyEbWnfb8jzDKfbdY
 Y3bConOShFSTtwzJ8foqzZ0krU/c/XVU4GKAtY3VhiQ==
X-Google-Smtp-Source: AGHT+IGp2w21sBmIdKdqdvKCQEnxbla7TE0HvfpiIH4z+t/wVnd3Xms1kkXHiNoTm0lsFqwjsiQ7YQ==
X-Received: by 2002:a05:6a00:464f:b0:76e:7ae5:ec92 with SMTP id
 d2e1a72fcca58-7742df08f8emr19844550b3a.28.1757570506222; 
 Wed, 10 Sep 2025 23:01:46 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607c54a71sm795381b3a.102.2025.09.10.23.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 23:01:45 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v6 1/5] spdm-socket: add seperate send/recv functions
Date: Thu, 11 Sep 2025 16:00:27 +1000
Message-ID: <20250911060031.124683-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911060031.124683-1-wilfred.opensource@gmail.com>
References: <20250911060031.124683-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x42f.google.com
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


