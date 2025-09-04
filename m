Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D2ACA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu0Oa-00072z-2h; Wed, 03 Sep 2025 23:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0OY-00071o-O9; Wed, 03 Sep 2025 23:12:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0OW-00015e-Lo; Wed, 03 Sep 2025 23:12:18 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2445806e03cso8276245ad.1; 
 Wed, 03 Sep 2025 20:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756955535; x=1757560335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNY4ncpuDcOsXQxB2Rg/MklRq+L9/xqLJrUQZb5aHUA=;
 b=LHXGb9FM1MrlUbG2KTSOIcP3mTw4xnfSFXGpJuHPMJZ5Kr16AZ9VqW8ff86lZ2Eb20
 /L5DBo+ekayWClctrRn3kj6406w7Cug7dThjWFSo7dlFUZdHWjS7OVRbdILfuWtS8FtW
 ImzrK7ZMCpoaZeBPX/YoFBJn4fn6Znceqg6KjkSOBe+wMoUkqRlNJyn4UgJY9RoY1NiE
 rXFJKaPlBBLzH5nnC9IU5GV21FoTb35g+iXAjGP2bueygC3Fge2QW1+Tp3z2ImHki8xf
 1I5FidodaUL6ssgDXXjzQi5yUXr0pBM56HMuLIxG8+0RrcelnfVSP+RPvR+SG9+Yp7yM
 3AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756955535; x=1757560335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNY4ncpuDcOsXQxB2Rg/MklRq+L9/xqLJrUQZb5aHUA=;
 b=a+0NMLgGYfLAqzk+VI4+cr/KLmfEDeX2gdp2LdznKxg/F1BG2870h8p9MdiqXFDwSB
 +5eorYBKJUMBNoY2CZWStqvFaLFtJ8TWsStPRbtfNusX8qwJrHauRbYlkda71fOr0z1W
 pm3pe81zCGTPF/WRMI7ccUMDFrKopze4JrJBzvSUbL6OZums6+eIEt4XGft+oHw21t5n
 fWi1U3sMssO8EpHxaXXGJ8YCsysnUMBr5QQF73jAz+X8nrMal0rfcRKJknQiY/g628Sp
 S+iVcOtO/BA7lNHpXQ/hm0dhZGNGpaCQNY+Ba0nHMNRM+iwPFVAb2FsxhnTC3T/dOo3L
 0vVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAQNNZs5YKADHyPQMIYP9VdAm3SEp+ZilAT+lci9gJjETgqFmW0fn05+QKv9rSLQSds/jMaaFP5oFyuw==@nongnu.org,
 AJvYcCWamoi9DXacEPsS6dxAoDCOcZwCbVsdQZW0tDnvaZ/OFIWWcPIjjy6k+HAxYpgDVY0gG/UWPncD9kKh@nongnu.org
X-Gm-Message-State: AOJu0Ywzhi4kXl2cxY8WWp/Dqa2YvtR/2vy7HTlIhtlxg7oEAK9Bb3S+
 3VYec8MYML7IJFegpczxJHCAOH+gepjxMyzrcXJSoUsGxUS4Cq5r2mi+
X-Gm-Gg: ASbGnctEn8jW7VC2lXUVtRVqWcAcJo+5Ny79QKF5WU7rs2t0+euPKdiCBtqph5D1y6o
 TvQZWJaWTZ8AujFknNonlvSxum32LSJLbJOEiaHMShLERHfj0fZDzfSCEEO0GXS9/ZRNZI7af42
 jsfzcQao8Cs9zCoPRXsT6F65VdrEnAA6Af2AK4HDBstSnslmgZf9MmSq05G2tXG7yVXGmXYZuL9
 zIaw0klCzXYwu0iJBMoPDNw2ZqOj7lqnRt79k+OBNpIc10zEe4EITH0aMjh0gkIvz+6UVsCAwAQ
 eGCBrzkar+z+uTALDEmIu6H0gZyCW0JAB0qhudmWmBcfNfvi/SM6X8Q0RQjH/+f/KM6KcNgQOHj
 wjnvdKVIl6IxNvKo3Ug9a/LXJiw==
X-Google-Smtp-Source: AGHT+IG99vRIbhhGBX7dK8cjCy/FbB76ssG6mstpMmJlA5HJIHUQu6Iq/cqCJnfvHzwSQ9KcGLKWjQ==
X-Received: by 2002:a17:902:f787:b0:24b:1f34:a64c with SMTP id
 d9443c01a7336-24b1f34a8famr83675475ad.10.1756955534467; 
 Wed, 03 Sep 2025 20:12:14 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490375a9ccsm176497715ad.63.2025.09.03.20.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 20:12:13 -0700 (PDT)
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
Subject: [PATCH v4 2/5] spdm: add spdm storage transport virtual header
Date: Thu,  4 Sep 2025 13:10:56 +1000
Message-ID: <20250904031058.367667-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904031058.367667-2-wilfred.opensource@gmail.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x62e.google.com
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

This header contains the transport encoding for an SPDM message that
uses the SPDM over Storage transport as defined by the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/system/spdm-socket.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 2b7d03f82d..6c2cb7b926 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -88,6 +88,18 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
  */
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
+/**
+ * Defines the transport encoding for SPDM, this information shall be passed
+ * down to the SPDM server, when conforming to the SPDM over Storage standard
+ * as defined by DSP0286.
+ */
+typedef struct {
+    uint8_t security_protocol;              /* Must be 0xE8 for SPDM Commands */
+    uint16_t security_protocol_specific;    /* Bit[7:2] SPDM Operation
+                                               Bit[0:1] Connection ID */
+    uint32_t length;                        /* Length of the SPDM Message*/
+} QEMU_PACKED StorageSpdmTransportHeader;
+
 #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
 #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
 #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
-- 
2.51.0


