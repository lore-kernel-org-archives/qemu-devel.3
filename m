Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A915CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usvY9-0002Wd-BZ; Sun, 31 Aug 2025 23:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvY7-0002Vk-Hs; Sun, 31 Aug 2025 23:49:43 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvY5-0005hV-OX; Sun, 31 Aug 2025 23:49:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-248ff5cabe0so18377665ad.0; 
 Sun, 31 Aug 2025 20:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756698580; x=1757303380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/kmaiKLLPI0PyePeUcLux7CKbpjWHsslnSzk4jw9sA=;
 b=iaV9b9zc3S3RXPcMkG6awgggFjmf9KI8fu4xtgKIZW1+U7I0ctWxJbc5r8TTad/YKD
 EgeIL8vl8bUGXua6j79IIr2CCTp3RbL5ZLWLbCls1NKfy2HxCxJ2L62DvsbuKUrQh62X
 9nK5ToVMpeYB8dHu1RBIP7go3XBQWU2l2mY7rNu3TAfzwJMF1sqIaNGhPflM93vojv0D
 capU+hJ7jIa8/a0/P11+Qgsbw0cePNf4s4Bwkjl6XrkjG3ivwlMGzEyxfffLc++g1w1y
 q99N4zz4hQWoREsksv0+Av4sHFKXVE8/L4MBZ+rnBqqWWl9Bfl3VzNk3Wt6sSVV6ThOB
 6VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756698580; x=1757303380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/kmaiKLLPI0PyePeUcLux7CKbpjWHsslnSzk4jw9sA=;
 b=oL7NUdMIsqwYDPHNnzo8dwdkYtmHjl2yWDJabbLOgUTqWl2GLJQ4HX3KM2nmtdBDs5
 lKQXYhG21sDX6sEYTbsI/VEq0oYYGt0TlxM2djL6BjyV5I8wuhx4c9okRdXm3I+Ay7MC
 jNdxMitqkT3hvmpljes6fWkHr/NH2JTnxSwbCsAmFSFRJOoONSG1RHFqGrWPOgoMyVmu
 GBbldp3q4IwPO45OG8PWxzTPIaq6PC0Xi3DsvTcKess3Qrre6q+NeMoid9os5GS2XM1Q
 Ij2BSnC424mqVV/i0bGZvXwqHTDMmt3DQI5xRsqV8ckReGuwr8PbbcHnZ+wMVftwexd4
 jkMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURvUpQAWJ9uGSQB4Eg2HtccFTb9Eiv82C2+n9T5JQ1XaRzpmgIEO0D2aFPqtWPpIr1E4iv3LTjqkaMcQ==@nongnu.org,
 AJvYcCUbPeXxbt0DMGivLWhp9HyCZKkCTPoJ2cxOP0V57Uf1/3vtmmTzmPV1BpSqMl7ec5fb9SdFQc+YGGaz@nongnu.org
X-Gm-Message-State: AOJu0Yy4NySUJZKScgpxzB7k+7nSoeTNzuiZEqiOrqSWtCxqWzcjbYu7
 MDiH9b/rZm+U8JovYNAeFnic2BxvFEnxfLgRA8Jml/qn2nsqLQPEy2is
X-Gm-Gg: ASbGnctaoTXt1HLicrQ4m2/WPSBYlw8mt455TV0xPEr1WW7t6XJEnsI+P2b6lCUpEwU
 eyZsARAbg4+FrE1b/PajFL2DttE2Gvjsf0C/pGEL/MLQsVs7BIuiEylYAKjQOZTe3XL7lK8vPjq
 3uwSKMJ29/2NhFJyK2ljgfl5sjHEnxabOstKJugV+FfUq48+FOBsY2BK9DTNOOic56OFR0cS4Yh
 2AOQjrlNP0iCLZsx1eziP+t/J2Na5bJ1nwajBcB9F0A6BZXEIOzrEVzH8pGoKlv/hvsxWybkpX8
 Qgi3a1A/Iy4eZQiFy064q99SvioWck+Q5PPZ4rwB82gtV2bA9lKBW0ra8v/4gdKRxPc//A+8cO3
 AQuHXRQmUMBLQ5MLTLB5Ibtc3pg==
X-Google-Smtp-Source: AGHT+IH9pvnNr92ZMW+Q/drxjlaM9jEgtFVvTMffzS3hSgSpsZIWpsjQod3o/nT5GWp5/AZhFCrnZA==
X-Received: by 2002:a17:903:1aa5:b0:249:17d1:f1d5 with SMTP id
 d9443c01a7336-24944b29de0mr86359355ad.60.1756698579630; 
 Sun, 31 Aug 2025 20:49:39 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da26b9sm89802815ad.93.2025.08.31.20.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 20:49:38 -0700 (PDT)
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
Subject: [PATCH v3 4/5] spdm: define SPDM transport enum types
Date: Mon,  1 Sep 2025 13:47:59 +1000
Message-ID: <20250901034759.85042-6-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901034759.85042-2-wilfred.opensource@gmail.com>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x62b.google.com
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


