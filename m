Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54AACA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 07:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urX26-0004e2-VL; Thu, 28 Aug 2025 03:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1urX1c-0004QZ-Qm; Thu, 28 Aug 2025 03:26:27 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1urX1Y-0005OW-Po; Thu, 28 Aug 2025 03:26:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2460757107bso6141665ad.2; 
 Thu, 28 Aug 2025 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756365979; x=1756970779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/kmaiKLLPI0PyePeUcLux7CKbpjWHsslnSzk4jw9sA=;
 b=Aw51a69AcHWlzYv4cfrG/qT2fM5hVBplJodW3yO3m/mc+JrXUtS1eWzmZRA1qFLeab
 KV0XcZTeQOgB5nxgm1Q80bjeRULtcE2Ehp3ZDGXshXqV8NJhHh6M5usSmJBjHwZO7m+y
 0oQE4dyOxVnK6FO0ka/qDTc2UKFiz747hs4T0iX52GjQKJSJWN/scb/56R8q5eWIUgAf
 F9akJ3zK5ankyAEErt1jWrzpMQXrKS+EXcsDpYoCHZAUhaVmBCYQ6HPvQ/KUtjIyd/ll
 IPNY5ys/0n6TPiHfKAIfI6BoDbBFGUG18RZPLPnyxCc0ZsG4zze/NAOFI+A9am9r2uFr
 ClMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756365979; x=1756970779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/kmaiKLLPI0PyePeUcLux7CKbpjWHsslnSzk4jw9sA=;
 b=lB7svPLlPmkAOKgTxP/2b5dCxAngmg3nW+8gLUTNvgFaC57yFZN9goGQq+IXvomEN9
 72goZmixEXtljMcAaiJHb0B7a0QhzGBtRLpldMEn3ThyFTegPUOtpXia1OWFFjuYlzma
 pUyrVktienVeQgUeBQgaq56Ml4yVMqiD3dU8o8DfijaKpmuhrd/EcdhUm0G/K4AWlQ5h
 9dCMf9w0csN8mH8QAjyGSgLv6pkcpog7SV2eO+SuMxOhTKuhrG6MlEmu4ZOScv6CVNqr
 H6nFXbGfYy2yjoUfma476/wK+YeLL9sf/wodC8GdgJK4hWESnFQB7W2MRVrFaUY1nTpZ
 fozA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsPJH2cG4ZjKhFOVTCRa2bZ/N5DuuPiX+m5Ipdeb39S98238IypvLyt7aoVBo9RzMrqd+34c1j3wC2hQ==@nongnu.org,
 AJvYcCXFzoiEDduX1LOAh1E0geaYXGKRza9jtP0WHXnifnAB9dY5Tk68F+LxHprtoF9ptTZolstCqYIHEeGD@nongnu.org
X-Gm-Message-State: AOJu0YzQv1AzWGxAjJ8fNcxCTxKo8hLw9VsmKRPb1MvrqGfoQM+mTjE8
 rlLpy2LriY5J4LCjhwvqCCUxJB1RPGIMzByJy+hjUmYFSP83kLAlfVdQ
X-Gm-Gg: ASbGncufENbhOZn55tOEvrXizmmeLLNNmykh0kxXsaZzfEIQSkLJnHuwSQWfEXZ2fW9
 kE/zEXnoGwmA1f3gab2W6/TwOjZsYPnN5eyBE8CFxnJjCLRSwpWdcWzibEseNVSgyuXzQoF7zQL
 Q8NZ2UZMU6IOvrWKEigUE6DC6kwf22fIj4e3c1YSzeW16K5eyio0A9f/vvrE9ePKL2FXc1+92TS
 o2XyCVvpqSNhU14AyKkHV5O/ha23V9z6X/dybxd+fjbQurVu2sf6rj4BJaaPsdFwZz3UhACiXC9
 zBbBuvttcYpck8g6DzzpuVLCRl+nWhd2+0xt8Igq7bWDmjvUBcH8UUbQ5q7c8m0GCikyjc3+7VA
 OZNewP6H7gYzFUDNO+8fRIcK2Qg==
X-Google-Smtp-Source: AGHT+IGxSHqw+FbOa+3w0I51+hhI3jQTmm91AWUdluW5U2ZbLl5zA91oWqpRV3uX7ZaMxe/vTLAYdQ==
X-Received: by 2002:a17:903:2281:b0:246:571:4b24 with SMTP id
 d9443c01a7336-2462ef6392emr260710255ad.61.1756365978824; 
 Thu, 28 Aug 2025 00:26:18 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24884a629fcsm51009775ad.19.2025.08.28.00.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 00:26:18 -0700 (PDT)
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
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v2 4/5] spdm: define SPDM transport enum types
Date: Thu, 28 Aug 2025 17:25:32 +1000
Message-ID: <20250828072532.425592-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828072532.425592-2-wilfred.opensource@gmail.com>
References: <20250828072532.425592-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x636.google.com
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


