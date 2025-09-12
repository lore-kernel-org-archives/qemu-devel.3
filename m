Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04BCCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 02:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwtHC-0002bO-4C; Thu, 11 Sep 2025 22:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtHA-0002Zq-1z
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:36 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtH7-00058X-FW
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:35 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-251ace3e7caso18283565ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 19:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757643152; x=1758247952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WELA+m2bPvDObkEGkJ7spvguGqQJeJhqpe8T4T8datk=;
 b=DguLEdhC7Y6sQU+QdVbW8qCRVJTov8VIY0IzRtnvQSEmQNKgaZ1h3keggjEtlHMO7y
 ZaJ5GA6lWuyXs+LF0juwOLUdKuitBiTj06f+gCIkyLXR6FVNJyPTebEh4m/040VsU9Ba
 bYD240HGLkqeQcLbzs38asTBT/q6N2uO23tXCRB8yIByct8WwKNQfmhjToL+cA9GHog1
 cSp51PeJT7AMtrdISeUcn9IE/bHm5d0xen+DAzKA/atWHp/cFczDX9RK8GTI8nXO1+nu
 KMYW2BmkyZCzLAM6d3jM6nsW+LISGWrp+zKmJKccUcSofgL/tj0ZLuSXk21juYJ6e0o3
 bHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757643152; x=1758247952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WELA+m2bPvDObkEGkJ7spvguGqQJeJhqpe8T4T8datk=;
 b=Fh10cRmvZLhM9XsGUqPvs63Ec/27Wa0pZeKroh73pkWn4G2nT8h6w4TMGc5fgMANs0
 u43jXLl8R9tBDcYEwelPjzWUb+kcyNc7vLVykxWrZwi2AmHcbGU3awVW3zq/re+MjTpb
 mmcq0x8WMMqgb/BVBle5mUZbqH2fdeIpnxyJ/rPPTCAugA6GCZM+O8Uut4CDtpaAyRs5
 CBs6JGyJFAv4rHIOQt5ktUiaQBgiRG1Blnfq3VMH6AJ+AJXWfo5os98YNyCv116fuUn0
 cA461V0+U2VUllzC30KrY86iuKIsAmx49khFnwlHgIPhGIsRBIfWOtxLg2/SAV2HUMAF
 MzHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi2YhcxiT4ZNn59kBcFHsbXTDvHY2BfIvftRpLbrbhnoZHCoMP4l9oay1YAoecnJv8EnmQooHKZfbo@nongnu.org
X-Gm-Message-State: AOJu0YyaDX7nRHJJVoAYodIqJA9F922Wx879Id+WuPNSPYoyjmnNw0F0
 /wsByFr5vsWpWIXwdr4hCFVmn1KBWFhpsFx80xpkyoxnYf/BEDyqmh/t
X-Gm-Gg: ASbGncscJdwYIyXit1S0M1uh8NNqr6e9e7qplGvhDbyXXUdkitLcfWxcn7nFyQaO4oC
 gXqVc4OhBJU8c9Nbj3VLhFL6Cl8P4ia/gcssVxUHpAHQiHh3d4z6+vayj1JgturRKkrbjN//hoW
 +xH5Phtvb8SFPmbtar+2NtgwivOMf8MmgBkHkiAr30Mp/iuaVp/Se/DwjTZeZ5TaObjsKoKLM73
 ixgnv3iUOOjDfad916pKVjsakaeVrgYZO8shQ5I5BVdPB1HHU+xRFCpUUUZnHFZdDMgRVjrwh2a
 XgppTJvmtC9zIldy/9PF7Frcmt62ARiDCgkThvpeo5sBjkE4psMuIesVC1Pbf1mJ1p0B09LosbV
 RxwiXv1Iy91mlNchzt018njHG22KSGxCRIJIKyw==
X-Google-Smtp-Source: AGHT+IGdAoBZnz3y5oVldI7Mk0YGR2rkj7QUxivHCh0EjRD0ixSuQH1nVXv/GI68GhZk+vMPFMN+kw==
X-Received: by 2002:a17:903:246:b0:24c:d6f7:2788 with SMTP id
 d9443c01a7336-25d2792963fmr17208155ad.57.1757643151734; 
 Thu, 11 Sep 2025 19:12:31 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25c3ad3349fsm32853205ad.104.2025.09.11.19.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 19:12:31 -0700 (PDT)
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
Subject: [PATCH v7 4/5] spdm: define SPDM transport enum types
Date: Fri, 12 Sep 2025 12:11:51 +1000
Message-ID: <20250912021152.46556-5-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912021152.46556-1-wilfred.opensource@gmail.com>
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x635.google.com
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


