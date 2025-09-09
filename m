Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D409CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 04:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvq3p-0006JR-2Q; Tue, 09 Sep 2025 00:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uvq3n-0006IY-Fx; Tue, 09 Sep 2025 00:34:27 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uvq3k-0003GI-Io; Tue, 09 Sep 2025 00:34:27 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b4c72885c8bso4232149a12.0; 
 Mon, 08 Sep 2025 21:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757392460; x=1757997260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WzDwa5raG8Sm10+4ENnYqbcNfW3OS0HNvh0la9YBPno=;
 b=M8ciZTl3UwF9C8XaGsDXQZfiRCVBv3rcCJ3OfluOwe9/ZWkwWBovTJNpCe9xh1QLX1
 tM/VNZaBv337W5Pjo7gj0rAP3QC0BhWOA7952g3Hvmqc4TRcHk9Ijrz/Rieb7CMZFgpN
 zBtXs3qZIMZ+EqNk4JitM1RSezGOWGSWL2mNfWwozrRq70RcOrkt3qs+UbAe5xTa2n/X
 hMc695CqHxjXp+uRdOpLB39JIWCIeriJXb7wYLogK6zgNFKcUacRqyC1yIG3UW+F2Bj9
 g5hLVTrhmVFiDt2OxpydkQU2p/iG8pCDBwAZIj4X3ihwKBD7hztPCl9ZPSjZ6asGDb4k
 D/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757392460; x=1757997260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WzDwa5raG8Sm10+4ENnYqbcNfW3OS0HNvh0la9YBPno=;
 b=Z2Dd1ad2YiOetNryKAGhWx86tl8BGEKXwFYIk5b5Y2IB8YDnhDE9470gryNSL126ln
 puheklu3NBI3q5Elb6qGxymvOR2uEs94IQpc49Jb6CUiPGNzTx8f0Rt98U9MTNdTADjZ
 3JkesvN1VbBe0AtCujJwOLrBq8NxuSnWz7vcqFiDN/IUzlBQjgCMc89/lDogWTYlB3RI
 97EP7v8D4bVky4KsjejM/Pb2o9nR6eadKvrfWvVR6u7ICNVM7wbA2ivYJ8kfXAStVGqf
 xh2NQ+TSYWt25LGiXgWFFkJ4leaf30pbGyvzjuemWfkSqgToz0ZvhAT/mYHw7U/siXnk
 JIEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDdNesXtTIzWincctT44cqmD441c017M7c2FmDCC7vpVzu9c98PEB7/7e12lu2iL4CS+POEWsDqFvd@nongnu.org
X-Gm-Message-State: AOJu0YwL6INpoDpvgnlCPKBRZrbW6/0wak6Eff2sZRxGqaDAZY88NVv4
 J4UUy5RV5W6KzdhyUsx09W6kjNXvOLiuCS0CqzXElZGeThJ6zQi5Y/PW
X-Gm-Gg: ASbGncssHyIbJPwv6DM6Yp8xklZveBgUhx39mr8ohs98lylbUyGIPer80tyuYSbnMpS
 jNQXVvW7is/LnHqo2eiMXvQ61rJf8JevzEfNJNAIRBnQn6tm7JJevAlJIWJZixK7mK5BfcPHN0F
 xNlOTbzTDX85yBEZMqXwBVL1WCklA4gDg4YYhpNr9fK9dJhEPTVjMeNJz9ud4pMP7NnJdfrnxhi
 FOy/ycx3aXBRkFAdZkWBcTVlxqsbIbzKMKJMxWFquVXAulg0jfB0hCqv3xbLXQSYrx3mYVg9f8X
 bOiwu4w1sBJyNPK7j9gJaDyLw/7B4jno2wmNL0x1kwJm4ky3AjpUM1jm/43AQFf91cclUw/mD0h
 HcwkMSm5ne5PuD7NKvR1lhwxlNr+dgNxszsdreQ==
X-Google-Smtp-Source: AGHT+IHFSBwyK2utun2TNC4gGtAzdCXBgUG0lg2FqmBo8o2awc7edJTWsyKuaOKzLXOGjvs6Jgvwog==
X-Received: by 2002:a17:903:46cb:b0:24d:f9f:de8f with SMTP id
 d9443c01a7336-2516fbdcc8amr155936605ad.17.1757392460026; 
 Mon, 08 Sep 2025 21:34:20 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-774661247cdsm606534b3a.33.2025.09.08.21.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 21:34:19 -0700 (PDT)
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
Subject: [PATCH v5 4/5] spdm: define SPDM transport enum types
Date: Tue,  9 Sep 2025 14:32:59 +1000
Message-ID: <20250909043259.93140-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909043259.93140-2-wilfred.opensource@gmail.com>
References: <20250909043259.93140-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pg1-x52b.google.com
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
---
 backends/spdm-socket.c       | 23 +++++++++++++++++++++++
 include/system/spdm-socket.h | 19 +++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 845ea87b72..2321ab72d5 100644
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
@@ -247,3 +250,23 @@ void spdm_socket_close(const int socket, uint32_t transport_type)
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
index 3d27cc366f..6edbf5185b 100644
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


