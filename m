Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECF8CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4e9Z-000357-DP; Fri, 03 Oct 2025 07:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e9U-00033Y-U3
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:46 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e9I-0006jY-Ug
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:44 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-33067909400so1588389a91.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759491628; x=1760096428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zl5rMIU7K5lgnB8gd55Bcnotiih5dULebnpQ2M3dykQ=;
 b=Slcq8MhSr1DP6BVX1B31gQpyvDdCaxXjqBbazNcEvDb0GQjZqGprQAMn4rUZDoVtHF
 X4YoXXSr7wewQXvnwXwcjIEVvYXtQRaXCADmro5QhjkvGsqUy3AmXWLnH1dk1Kum3tib
 8/l1lqaeqp8J1DmiFlJ4Es6b1RtK4Xwp+Spvi5XCdH2Hz/QgVFRXvo7Xf/BqC7IU9598
 FpexoyFgHjSXVucrDgSmEyspdBJjslfuvcWLWjnOngdC/F0PSwnw4SCIDePJjx2fP6ux
 ws7y0cOIHu5TzRddep7MQ6KJ9t6oldk/TIHs58O5q2QjTDngnyaM0BL1Jcxhr/c1mtEI
 6L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759491628; x=1760096428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zl5rMIU7K5lgnB8gd55Bcnotiih5dULebnpQ2M3dykQ=;
 b=VA/OtHLBqtMyDiivPm+3mxOgTp3yCFdttRQpuPGPKBLi7YVn/Y7xQOw/WuN/he4WGH
 OWzn41weo/HvkMnV79YojPobYkwtpw90+hMxe1drEPhcv5WB9udjgWktNyLJW47IHvfM
 JNq1P/cCkn2nGgvUn1h3U9eOYcsMMw6E7PV6dipqcDqKW+VVvTdsUPf793gjzszs6NwC
 SKsfzEFdsoH/hXE4adKe6ZPBYI03wfwA2w9DhXwDqezywMHumC9fPju5IJQ2sJqFlg+S
 Hy7glnx8yRYlqNUKP0nDM4aUc8S+Ov5Q/WDikEisVn7fz28ZstxYgtGJK63XAaI4pULb
 egRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZiN8cDEE5+GMJf2rt7bd+LlJEtC3x0E0of5EQP9qLTwqkc6P8AKZQn0f03lHF2gCTqTLSl6HIeSP+@nongnu.org
X-Gm-Message-State: AOJu0YxWjYRtnb7mOt5seuz58bGYDoxJ53KsSvlRTZujIBnAVwAZDaNR
 /3sf2ByO0FO5J6akamFr/uoCSpmj9gzpOzW/hSwodhJkGH87aYxF9QRg
X-Gm-Gg: ASbGncvsNNomI+Mq1CqW0LiXDTjGV/lWIyYuRLEcFzODGDRO7nXC0691j5BahGb8JEs
 rdAg89swVF3yHUssUu0Og0d4R1gMnzsoaJvHAg3yXc6S/xb/IfjJruYe14kTanh9d6Lj3CH3pfu
 QUPGbxdJX06v8jvXJyAbaa8DrqXm8guelSAf8ygfzQ611nVZ0DS9pqoSFBp3a8IQyo9l2Ec1RKW
 i2tFWV4bQPw+JYQpAYI0G90s2pfuCfXhsuOJ+7tL9Tdu4DhzBsPaVTBSEqPtZgyVzJxwzPf8S80
 vK1rClHQSNL5DwIor2W4ZpFQT4y2CjpR0EY3yKP7YdP3VkvMO8XrkIUp93jImAGdxGIHqsND2Nf
 MFULBb77Ee6bojL79mnfk5mfZGlXosBsC9QyxWgaS53jL0u8uY54=
X-Google-Smtp-Source: AGHT+IG9rE5nzHU6fskQKOZM32zrWwDq1iX0yEzOuPfhEqNRlDg46M6RJCkrDngF1SFvYGlHkBb1HQ==
X-Received: by 2002:a17:90b:4b90:b0:32d:f352:f764 with SMTP id
 98e67ed59e1d1-339c2707f69mr3315251a91.2.1759491628236; 
 Fri, 03 Oct 2025 04:40:28 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ff26f8sm7804995a91.13.2025.10.03.04.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 04:40:27 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v8 4/5] spdm: define SPDM transport enum types
Date: Fri,  3 Oct 2025 21:39:45 +1000
Message-ID: <20251003113945.87962-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003113945.87962-2-wilfred.opensource@gmail.com>
References: <20251003113945.87962-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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
index e611633812..00cb0e97f3 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -112,11 +112,22 @@ typedef struct {
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


