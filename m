Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EBDC54754
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 20:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGNt7-0005S5-6Q; Sat, 17 May 2025 16:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uGNt4-0005R9-AY; Sat, 17 May 2025 16:12:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uGNt2-0001zz-Pj; Sat, 17 May 2025 16:12:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso18143275e9.1; 
 Sat, 17 May 2025 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747512719; x=1748117519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIMMYJUwbBBktOXZV3ZqZIlfvVDKWD/JTEdHmGS7mkE=;
 b=OinnNcKu4at1hS+vUfX/UKHbA5GavoJf6rWx7sCBcJVfJ4v1EISY/xTjRcp9VFw8Jz
 tLQAk8FhC2HMb2Ml8cTH007ZF/oRyXl9UDvcX/dlDGHO2EAcZB3PEqjSq4+wvjGwnzZj
 IowgdXxC6J4KB8Sq0T/tFpHoKrGNv2I1dxKb9CrWY4roHldox2+DNJvBQLh/i3Pl6CKB
 fp6VBITnX66riLkKuSFHPcWnRsBHGfjsNU0BgoXAx01IKZ8MrCS/0oLvGaIyZMTfVRT/
 SrjbF1EeLeUEqGV1p431iWaZ34cjWglI5Bn60g63gO6PYHuP9SqX6wPG6T88GDg/lrwU
 QlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747512719; x=1748117519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIMMYJUwbBBktOXZV3ZqZIlfvVDKWD/JTEdHmGS7mkE=;
 b=ti1lmN7CNBqZHyDNk9HHxJ1JO2BdYft1UhNi2w24S/jD5Ad6KLU7MEwuolXr78A0pJ
 OTYTdPehEJ4VNVFE00QMkWP12EDqVX5lw97T60fBwAVkzzoObkjpI9IrNNvRhUIxXbub
 ce56ZSou+BjvG2OC0yBgpLY85LR9Zf/rggaxG5MmxiZlhf0LdeavhGXLm0coDwwdIgyu
 P+oqdKF7rvn/+P6lC5xqc4I6xVtlfQoZNSLxCQGqNJYYq38XaCR3KwJO997dl1PpQpTm
 /B2kbMJiccVAxS6fOM4t5PX8SP/vBa1tP+xtyj2ZxXQNhRdtdXLcmovCmtPEcR7Bjf/R
 ZXcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFnDi8+njNOKSljwh3U7PwT6UMXZrANrgR+/NTOCUdNUlAXOwSuyIonkpTs8PIDQAuiPZw1Y0RHgzu@nongnu.org
X-Gm-Message-State: AOJu0Yy6w1UYrjagALIWGBgQN0kZKDXpO3sKg52iMrAR/rJGdEvvDTX6
 yn5xJyJ9b0+kMXy2yrKNzTi1jEfFm7DLv+GBWFC9P9Utsk14crxV/EHXaLqSXSIdt+4=
X-Gm-Gg: ASbGncuFF1tEjLi39UVg7kpHNS0s7V/sro0Ppd+cNvDEGcsfygql7qWZnPMUrQkqEtg
 m2B8Ik3QeU6UFfrNgPulxl6Ii+BQmm7NGtjFIgta/EIsSn4PXhVOxUbbdohYcS4mdPaKNIKmncS
 8QT1tkcurAgJwleo7/PLb1IMwo5kp+Ah0IxcqVYW80RKoLhuMOJ5Yv6pD79reynjSI5AGL6kktL
 TjR9qDipM/KvyiEUpz7omgJ/NDg7jgX2sMhooocK3+k4+O74bXnHT+Cx8lb71BJCSWKUx3Vgb6P
 6fAOLQrUHvYbFolrZIrfQ0S7ky8klkreqP9CkwmRESeN0YHyKq56tlCsOjg33+nN0YXnzz0gn0T
 tUKvVwAiNTAdlVAUa4hQuFxdDQkWLG8obVA==
X-Google-Smtp-Source: AGHT+IHFyJ8Qtd2yQNi5HwXukWollkAroIv0NU+b7U3QR90czgquq+UVaHbKLlANjwjeI9Jk+eC1rQ==
X-Received: by 2002:a05:600c:528b:b0:43d:4e9:27f3 with SMTP id
 5b1f17b1804b1-442fefee1b8mr65824795e9.9.1747512718495; 
 Sat, 17 May 2025 13:11:58 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59ab21sm78714715e9.38.2025.05.17.13.11.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 May 2025 13:11:58 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Richard Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v4 1/3] io: Add helper for setting socket send buffer size
Date: Sat, 17 May 2025 23:11:52 +0300
Message-Id: <20250517201154.88456-2-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250517201154.88456-1-nirsof@gmail.com>
References: <20250517201154.88456-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x32b.google.com
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

Testings reading and writing from qemu-nbd using a unix domain socket
shows that the platform default send buffer size is too low, leading to
poor performance and hight cpu usage.

Add a helper for setting socket send buffer size to be used in NBD code.
It can also be used in other context.

We don't need a helper for receive buffer size since it is not used with
unix domain sockets. This is documented for Linux, and not documented
for macOS.

Failing to set the socket buffer size is not a fatal error, but the
caller may want to warn about the failure.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 include/io/channel-socket.h | 13 +++++++++++++
 io/channel-socket.c         | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index ab15577d38..a88cf8b3a9 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -261,5 +261,18 @@ QIOChannelSocket *
 qio_channel_socket_accept(QIOChannelSocket *ioc,
                           Error **errp);
 
+/**
+ * qio_channel_socket_set_send_buffer:
+ * @ioc: the socket channel object
+ * @size: buffer size
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Set the underlying socket send buffer size.
+ *
+ * Retruns: 0 on success, or -1 on error.
+ */
+int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
+                                       size_t size,
+                                       Error **errp);
 
 #endif /* QIO_CHANNEL_SOCKET_H */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..a776cd45f5 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -78,6 +78,17 @@ qio_channel_socket_new(void)
     return sioc;
 }
 
+int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
+                                       size_t size,
+                                       Error **errp)
+{
+    if (setsockopt(ioc->fd, SOL_SOCKET, SO_SNDBUF, &size, sizeof(size)) < 0) {
+        error_setg_errno(errp, errno, "Unable to set socket send buffer size");
+        return -1;
+    }
+
+    return 0;
+}
 
 static int
 qio_channel_socket_set_fd(QIOChannelSocket *sioc,
-- 
2.39.5 (Apple Git-154)


