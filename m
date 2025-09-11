Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA68CAC583
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 06:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwaNn-0001Fn-P2; Thu, 11 Sep 2025 02:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNl-0001FF-T5; Thu, 11 Sep 2025 02:02:09 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNk-0000bN-5P; Thu, 11 Sep 2025 02:02:09 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so294415b3a.0; 
 Wed, 10 Sep 2025 23:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757570526; x=1758175326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WELA+m2bPvDObkEGkJ7spvguGqQJeJhqpe8T4T8datk=;
 b=BQ05M6zT4YRtfNEiQEaWw7Ql60PQ8/kZYMqEqiL1F2muAPcP3SCEhL/SLQOK/vC44D
 qatUEKR5q+LcnEaoGnEbv21aHkifls79HHdAVznZgfxpIveeskD0kj4JDBIJxx0UepsJ
 UsdGskzmC0a5lxBW2IzXwB67pvhoSH5kPiLTEh4xXncR1jrHqGj11EKKw/q+ysjZCkNN
 P43Y9UnFh7Erkr8OTu3GS9xYRg9VHo/EGkUeI2jwyo07L6llHR3UKGDvp7Djj5rTajz6
 QRqydSOoOflR9O9psa6shHQkY2q6/HY8MsRcB8y7x1Nja5LXa+6arp2X6r5EpIJIoEq9
 IBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757570526; x=1758175326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WELA+m2bPvDObkEGkJ7spvguGqQJeJhqpe8T4T8datk=;
 b=ehZJ6e0yMcaCHFo8oFY61VbD01LYkktHh6anyE0Rshrfqfm/1RRj/Cmb8tB7wkwAbq
 dWYgSyO+9w+4d7JmC9anc6OBsxQvN6+r/whKnLuJwHT1pt+KGHYdXAZfiGqKDkGIsFX3
 TNeIbR2K5uDmuSliL+skgh7J0YedOSZbjwx91FQh4CxEJf9GGpoTb8g427a9m+i0vM1Q
 7OA7CFDe/ZfkN4txKTtIwWHQFcE4RB8A4XgTFQHBfOq/FQ/BtIIaIalu9bPWKkklEiDB
 aLz9GlnoRg6tlbw6mduEZ06qile8jmBo79mvvinL3yQyUvAKZ9sCg2rR/1nPnB5UvlD3
 tRsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+3GVW27JLnbsegAAy1JMQ1VF215quf1Tw8OCZF52p5+wndRROsEiDg4wbMP2E/KF3JCkdNwdaYxyK@nongnu.org,
 AJvYcCVE1Td1aTTe238u2mq+XibHS2gLole/F1POsxovXPHuHUQZ4k4lqkMhU0jdy7+KuiwkujaVhN9KF3kEkw==@nongnu.org
X-Gm-Message-State: AOJu0Yya9JBKwaDjCLeekGky/8Hzi0WrFD5AlUgM8t8HkxSRprZVnoyr
 Me88Ljs/6ElYR5UlI5TFIEP/APTxwUldICWk9oFY3rqe9ESo9ZyWPtKm
X-Gm-Gg: ASbGncvteCc21FHJz6NGCpesfdqTS9CDqZJ7IFGiLc5CPbFSanVUtmiK98WypnM7T0s
 rXVrFRRc+mipQ7GRPvWVKQ2S5VbajO7IULwFRfpIGOJl2G2+Je2bFH8Ur9CupjRnVKbPLFZqxcy
 L3V04GbVri7WkTx9cL3b3iy1ak22KE5/obJ4/mAAOuoK8Kq4ToTXdrAx3H7K/9rop/Bznn1CHM+
 ryUUwIZ/0wurPTiifQqLvQ/Nd+4P/GoHmqz+1XDY4BxRaFezNgHAr/AXW0Agrvhp3A8s7j5W6B5
 Z4gLU5NL2JoddGmKDcS3tH3k87U0tbQj1CD7s6WeF7ZDA2vLZpew3uPfWPcycs7baTIjJsAIJtd
 cgY0WEyw15hiW/vUERFl/C4IjBVuq3wH6KNKeWuj/JQ==
X-Google-Smtp-Source: AGHT+IFSBxf/vyjQTQwrXj+GLTupYyC0bSw2SrzqwHQ4EFsvXO5e/pbQPrIPnx41umyHUwNCxAaa2w==
X-Received: by 2002:a05:6a00:3694:b0:775:fadc:25f1 with SMTP id
 d2e1a72fcca58-775fadc2dfamr4232695b3a.12.1757570526503; 
 Wed, 10 Sep 2025 23:02:06 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607c54a71sm795381b3a.102.2025.09.10.23.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 23:02:03 -0700 (PDT)
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
Subject: [PATCH v6 4/5] spdm: define SPDM transport enum types
Date: Thu, 11 Sep 2025 16:00:30 +1000
Message-ID: <20250911060031.124683-5-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911060031.124683-1-wilfred.opensource@gmail.com>
References: <20250911060031.124683-1-wilfred.opensource@gmail.com>
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

SPDM maybe used over different transports. This patch specifies the
trasnport types as an enum with a qdev property definition such that
a user input transport type (string) can be mapped directly into the
respective SPDM transportenum for internal use.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 backends/spdm-socket.c       | 23 +++++++++++++++++++++++
 include/system/spdm-socket.h | 19 +++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index ab74a02d9c..6d8f02d3b9 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -13,6 +13,9 @@
 #include "qemu/osdep.h"
 #include "system/spdm-socket.h"
 #include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-prop-internal.h"
 
 static bool read_bytes(const int socket, uint8_t *buffer,
                        size_t number_of_bytes)
@@ -246,3 +249,23 @@ void spdm_socket_close(const int socket, uint32_t transport_type)
     send_platform_data(socket, transport_type,
                        SPDM_SOCKET_COMMAND_SHUTDOWN, NULL, 0);
 }
+
+const QEnumLookup SpdmTransport_lookup = {
+    .array = (const char *const[]) {
+        [SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC] = "unspecified",
+        [SPDM_SOCKET_TRANSPORT_TYPE_MCTP] = "mctp",
+        [SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE] = "doe",
+        [SPDM_SOCKET_TRANSPORT_TYPE_SCSI] = "scsi",
+        [SPDM_SOCKET_TRANSPORT_TYPE_NVME] = "nvme",
+    },
+    .size = SPDM_SOCKET_TRANSPORT_TYPE_MAX
+};
+
+const PropertyInfo qdev_prop_spdm_trans = {
+    .type = "SpdmTransportType",
+    .description = "Spdm Transport, doe/nvme/mctp/scsi/unspecified",
+    .enum_table = &SpdmTransport_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index f0c8b64d1b..9d0b85f8cc 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -110,11 +110,22 @@ typedef struct {
 #define SPDM_SOCKET_COMMAND_UNKOWN                0xFFFF
 #define SPDM_SOCKET_COMMAND_TEST                  0xDEAD
 
-#define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
-#define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
-#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
-
 #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
 #define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
 
+typedef enum SpdmTransportType {
+    SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC = 0,
+    SPDM_SOCKET_TRANSPORT_TYPE_MCTP,
+    SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
+    SPDM_SOCKET_TRANSPORT_TYPE_SCSI,
+    SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+    SPDM_SOCKET_TRANSPORT_TYPE_MAX
+} SpdmTransportType;
+
+extern const PropertyInfo qdev_prop_spdm_trans;
+
+#define DEFINE_PROP_SPDM_TRANS(_name, _state, _field, _default) \
+    DEFINE_PROP_UNSIGNED(_name, _state, _field, _default, \
+                         qdev_prop_spdm_trans, SpdmTransportType)
+
 #endif
-- 
2.51.0


