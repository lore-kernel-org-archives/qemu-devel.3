Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD0CCA1014
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu0Om-00077R-J4; Wed, 03 Sep 2025 23:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0Ok-00076d-W9; Wed, 03 Sep 2025 23:12:31 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0Oj-00019Q-FN; Wed, 03 Sep 2025 23:12:30 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b4c72e4f1b6so368631a12.1; 
 Wed, 03 Sep 2025 20:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756955547; x=1757560347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/kmaiKLLPI0PyePeUcLux7CKbpjWHsslnSzk4jw9sA=;
 b=cK2fe54koGoP5ecb2TE2+mYPk7rYF/RCs5AAubUzP6eXNRI0sD7oqnkPP+urkk+hOw
 PTNXRZbpAUBg/7JAFHAYlE9JK3CpfeGHPoZ/EY/1aKfuPjwID3/50KNp5PoXy9g7qeqs
 g7tJY35C4UBCnf6VOFBExRAAU09KpmLUs6MYaZ1zS1ZLyFqntzc4r0wLZI4lfmdojtj1
 u7WD//JWoMibreRzAt9cioU3EvGpH5g9bn3JyFACduz0DF1cJsLc7L2TLrZormWB57kL
 qSue7Np/WpJBQOarri6jwz9k8XgajAHyheC7DhliowQxdQr143KtGM6t8SvbsWK4rDeN
 i9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756955547; x=1757560347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/kmaiKLLPI0PyePeUcLux7CKbpjWHsslnSzk4jw9sA=;
 b=p4PNMSS8SchWhF1hERg4FhExOftNe+HX/dESZvLjWkMaC2EGUBnE3wa3a9vvom/+aT
 d11uFSxtx7K8PbJkg/OZnG4RAVAmTdMxdKByN7PzdHSWmCYnGxVL1PzHqwWNmfDkKVEz
 WfCpdC85kuBrBEW69/Tx9GaR1JEldyEGvddebeVhhaJikgfj07HCdDD+1Bh9/kOziRZ+
 sy5PJq3AcQuemDsnNqW07IS2wzhubTqoypVgUINK3HvTChpQfbBPcuQ4Ojui5gEa7Aqp
 G/ryHtIlaf1z4cAUV9YXc4hsZDNoBBNdj47RBZti/TRqKRBYksCbDwVOWp7PP+acV2aP
 9N8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQS6n7vKGuPO0/gsQHzgQ6mpGAAuwzCHYWnvCgs3l0Y9E0LEONs+I3RyrShvFHhKs5uzfYrKw2WDAi@nongnu.org,
 AJvYcCVtdfAQKG8rLob35POdGw26E+bjZM5NJwOMGo/tHc5elembC+/+JmUuaUD4lNeIBP/AV7JdtoRYFsziVg==@nongnu.org
X-Gm-Message-State: AOJu0YyJhL/SI7wf0oyOrWVeyc0XitSzi23QTtTUr22NrTHHtt++o8L/
 Z6TSpUHqCbshaftuNfRrU3oqjZ2UMjnLvEOP1fchluoV8DiyDeG2kZ2f
X-Gm-Gg: ASbGnctkHsPy5nDPLP3soaGyMpRU9VtMcwg3GlxoRTFU0s+JMKz0HbVlcAwneUbH/+/
 T+k3XYpleavjrBzxe9OQOnJEMweSK+P/mWg8FLA0ykmiNfbPN7+gSVKneuUxuXXWN6R7S0a7rMX
 jkLisKO6k6fqPiTLRmTvYBr5ZFPmL7ciKCgxitzuq75jJjqp6RUzHRIutbNlMEDp6i1sTHmHlut
 O4xe9/PXK0XWliRXm1XXVzZMj0Jq53px7snEiFxKNK3fjFHRXGqM+YUTWdEM1c9mcxJtQW75Ykx
 hKqvJFlJHemJVVrlkjM3tZNJPR/jBc3TPI5MasSaAkBptCcUJq5/sLN3hgmSpyCyBQiutJ0Vxr3
 AT8nJybtptXPTdzFn9QJNnfhNv/xgg0AjHV7s
X-Google-Smtp-Source: AGHT+IHPiKh2xbPG2vaJ1UUowgGaASX5EGlpd+FM5EGZnNK5xJQjJ29hinKWG9SSbcHBgTjDdT4RNA==
X-Received: by 2002:a17:902:ecc3:b0:24b:eef:643c with SMTP id
 d9443c01a7336-24b0eef6874mr128839735ad.5.1756955547477; 
 Wed, 03 Sep 2025 20:12:27 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490375a9ccsm176497715ad.63.2025.09.03.20.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 20:12:26 -0700 (PDT)
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
Subject: [PATCH v4 4/5] spdm: define SPDM transport enum types
Date: Thu,  4 Sep 2025 13:10:58 +1000
Message-ID: <20250904031058.367667-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904031058.367667-2-wilfred.opensource@gmail.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pg1-x536.google.com
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

SPDM maybe used over different transports, such as PCIe Data Object
Exchange (DoE) or Storage amongst others. This patch
specifies such types as an enum with a qdev property definition such that
a user input transport type (string) can be mapped directly into the
respective SPDM transport enum for internal use.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 backends/spdm-socket.c       | 23 +++++++++++++++++++++++
 include/system/spdm-socket.h | 23 ++++++++++++++++++-----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 3d264814df..6943246372 100644
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
@@ -248,3 +251,23 @@ void spdm_socket_close(const int socket, uint32_t transport_type)
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
index 6c2cb7b926..8fb5f7cf40 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -110,12 +110,25 @@ typedef struct {
 #define SPDM_SOCKET_COMMAND_UNKOWN                0xFFFF
 #define SPDM_SOCKET_COMMAND_TEST                  0xDEAD
 
-#define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
-#define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
-#define SPDM_SOCKET_TRANSPORT_TYPE_SCSI           0x03
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
+    SPDM_SOCKET_TRANSPORT_TYPE_MAX,
+} SpdmTransportType;
+
+extern const PropertyInfo qdev_prop_spdm_trans;
+
+#define DEFINE_PROP_SPDM_TRANS(_name, _state, _field, _default) \
+    DEFINE_PROP_UNSIGNED(_name, _state, _field, _default, \
+                         qdev_prop_spdm_trans, SpdmTransportType)
+#define DEFINE_PROP_SPDM_TRANS_NODEFAULT(_name, _state, _field) \
+    DEFINE_PROP_SPDM_TRANS(_name, _state, _field, \
+                           SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC)
+
 #endif
-- 
2.51.0


