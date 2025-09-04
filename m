Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04032CA1014
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu0OU-0006zQ-0U; Wed, 03 Sep 2025 23:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0OR-0006yS-OM; Wed, 03 Sep 2025 23:12:11 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0OP-00013i-VD; Wed, 03 Sep 2025 23:12:11 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so495731b3a.2; 
 Wed, 03 Sep 2025 20:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756955528; x=1757560328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjacYaLKOhLtcN2plgF+C3NWVsLcWnhBIR1v/WVcDRc=;
 b=XxeD9HgAAMDuEYO7HUDt6mC0Yp77N70ofgjBBPl1QU3vudWUYUsyberakWevWkoYfP
 KIHcahz7uYgaXDzcIXrmS9pECBbEzphDxWqdBGj/Qb2YY2cACxFTaCjLIY7gX02nWeX9
 DRTX00HWjFVSLVYOaxEtqxcobbuQSaZ02XGqhW4LyKrSIoKT9R2nDqIzgz9kmpYH4mL4
 vHlCXWWLEu3xphvZttjNWsAAVTW5VLRdA6dluq8rugwGuWnWYBqA8MCuyxcF0e+9WtpF
 gwBjZ2d9jIR+sFX8fYvWLqAYIJkPgN3TLy3cWO2ln7EznTkgNrtzUTe3cLB+AUJ1lfYg
 Nn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756955528; x=1757560328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjacYaLKOhLtcN2plgF+C3NWVsLcWnhBIR1v/WVcDRc=;
 b=GAmqK4W33uWiq5Z+Mv8/6x+Yo0XIWlMFF2WGA9JpjfNIn/IeFrlw3pZi2kb4mmOyVx
 2P8tyUl3ocZ/SO1CdgDuJ8vvAx6XL1W/9Eit59R2lZpN21iJbgs5VDRbSRSWhRGyJLtG
 RthS1Q/Qtmlqm6DD+lbvz7HttIgrp2GgX9pjLjLnTK5NCKZdET8rV17VSann4XSsWieV
 4N14tdgYDsJjDT/KS6lpUzYaWFQvamJX57NpPVnBUqr3JkZ9i7Uj8jgjPgKcVeftjCRh
 b5vRwSARVhSpfgiXJPEbMgoNooLbAcHKT9l9O4PYPmxTk/SxxgmHuFzrdiOdUWx1wTyI
 enkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFK2nI/N2L2N1696F2CcXV3Jb9sICgmvWASRXKFoSMddzQ355MripB6zFrgAxULdqLIowYZlM/G5oX@nongnu.org,
 AJvYcCXzh69M2UBy1HV1LtOcA7AEK76raFY1HBn2ZL0ojJ1S+cTNResEmEFp3x0UFx8L0rnm8BvfBJAtNWpO5A==@nongnu.org
X-Gm-Message-State: AOJu0YzlQaOSmKXBQotQNAci+PzNSivXE5mNCBx6whHCEeTqruUDyEmL
 VTaUujj6F2fu5VFJIUyBCowqHmX0dbdq5V8EZ+q3MOMhvpkmw/7ayMzi
X-Gm-Gg: ASbGncvk/WJrWu67LFTLsdcO/gm7px659An4OOAz75TRdT06LXhmTvXnJZLkJWIYzn1
 BFtzUyAfNapEElXx4+bFueQ7s9qcawd/JQ8XjQOazc2EoRhKzTFXHh5zDtNIDOFsGuU6090qy/x
 JJNbdVb6e2pbCUtY6MEWa6XWp2pg5XWz3PjHlR66zSdGy8prZpH4fu/qVSeAYd2vuvVW2S5D4oj
 cTIMLxxSdzU/ZiHucNTaiP2DfU+CXMVrC0oWuTRBw+jy4zVObCFTvlYTiA+0zJq9aDJRMndFtBU
 /JTfLN2D2SUPAGvl10Ou2vhFT3AlqfNESQg8WYXbx6uvopDcdvHUXmCX7FOOq8b73g3kBvLoLWi
 fAnAfV0XmUNGYMxb2Z5tVHZw7bBF7oF5GWFGR
X-Google-Smtp-Source: AGHT+IG+qr2xTwpMaS2kmWJDNH9C31Hpn3BQgNm3bmBmDP+jxfR75hRHTxndz/SWJlWLYjn2VVCg1g==
X-Received: by 2002:a17:903:3847:b0:248:e3fb:4dc8 with SMTP id
 d9443c01a7336-24944aa2905mr250624175ad.39.1756955527760; 
 Wed, 03 Sep 2025 20:12:07 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490375a9ccsm176497715ad.63.2025.09.03.20.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 20:12:07 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dlemoal@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v4 1/5] spdm-socket: add seperate send/recv functions
Date: Thu,  4 Sep 2025 13:10:55 +1000
Message-ID: <20250904031058.367667-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904031058.367667-2-wilfred.opensource@gmail.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x42d.google.com
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


