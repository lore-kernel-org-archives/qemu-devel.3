Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98853CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 07:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urX1n-0004Tk-Co; Thu, 28 Aug 2025 03:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1urX1P-0004H6-Pc; Thu, 28 Aug 2025 03:26:13 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1urX1N-0005NM-Pd; Thu, 28 Aug 2025 03:26:11 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b49cf1d4f6fso505777a12.3; 
 Thu, 28 Aug 2025 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756365967; x=1756970767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNY4ncpuDcOsXQxB2Rg/MklRq+L9/xqLJrUQZb5aHUA=;
 b=Ijh5FLHNNwLJxAUuM4oIW9MU0qZWrKgnUkeKkro/zQa69flahtLAFmh2yl+OUb6o8G
 3xvNTC1+mB7BbDb7vfFgc/gGM81CE1sLgBgvNJsFF6QOddu/eerjLwyCqSltQX7nziow
 TAcufzYTFbhrRq1Idj39IUdE/Bg4Dk/TJlw6t+Sh3zTntrppJOIDpXKclEMvDAGh+Wc4
 skwAbza8FJPqSGleOyh/sXYyEiBYgSPXzVvO4SF66WM5aK6BnGaCAgIlAdf6fiYvYeUq
 hF+zv6OeYiWm0JTt5Ib0nBO5Up6coDgh2Oq2zm2tuthdENaipKEp0fDKUElzBtPoQnjZ
 4BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756365967; x=1756970767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNY4ncpuDcOsXQxB2Rg/MklRq+L9/xqLJrUQZb5aHUA=;
 b=ii+XGZihfqTnMfTucLBCgiaLOmSb+tWMjAAtBlBoOT4W1ybNgbAmExZ/tMQyxhvLUP
 TG5AGynpR7mMoVSJcqqy0IAQItNzEcmjYMHUQOW04l+O4YJESZlpFZnPqAbxL9B6nwTg
 w8Q4tH4qt5Nh5rC/Gc1lqauTfFk76DXmWaygovgNVKLJFQn7Dn6ZMKScZpttWKtbs83s
 YPJNAUfNRJfMDLE2dVGHLy09ggZUKLxBiSDr3rF64nl/4f34HR4XTtYqccOPHzb8N305
 MQ65aZdDtlpFv0hdhDUOxoyPr3BUdGUe6X7RWjZG9xGYqIVTTuNJJTuBZftvWh3Iux4Y
 tA/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlCH+U3CWxyg8u8wFwfVzxqva1rlyjPDUHvSFJcJzYRiHHRp//t9wUHe7CpXZT/fVamYTC7o0Cb+ceFQ==@nongnu.org,
 AJvYcCUwQvUXMl5NKv3mrSqjRr2i6LGkhE1MM1QhSkLr9uAuaAEuWMSIQAkrVmKshjPjXjAIE/13nS82e3Pa@nongnu.org
X-Gm-Message-State: AOJu0YzsiHoX3h7t/uP7D4EI1XA1c0Y5ZacdKbGG5mqiLMiTGWJf5gbf
 JAxNK101YD6HrsRgfQajrjQQZsCYI+2txD5ck4LIPscXhN6R8cXevgkA
X-Gm-Gg: ASbGnctVR+Yc/VW49TdtrOogfg4EiHkdRdD0yVtpVpe2eHjxVSqXbOQDK/G8+xhz0o9
 exxjZx1L+81v9JvC5J1P/140hV/HjfczCO+lZcTmoaCvfwif/381pAWnveozo+AlW5Z0TJAtjHB
 TMQNWgc4fK1w/CrWC4QVz9RgQ1ec89yXyzdBrT1iPulZmLqXJiII1dmejvfqxcxMcL8/6C/MrU6
 RoilUJGq8kbuG4V2QaQfpgoaAyCWLnb2xwnIH83rZqdKQ2HYAGzigULz1adKmkn6phaptP0fYs7
 5/X4lSXuNQIFEwnBhM6HJpUG7FMcTMmCBcHr2np91DPTW78iG4Iwx9gm9y8cu9yUFbQALEGLc/Z
 5m7MFtx2ARN8s4ZKjqje7dLZKi6CzSbpcNtOwLJdoFH0u0oY=
X-Google-Smtp-Source: AGHT+IHBYzMaGkOIL1ZjpUwqP29SLBrEi72rPjKWtHFnO0b0N9aYCtkoSbG6yWqlCKxdx0ngb7Dwqg==
X-Received: by 2002:a17:902:f70c:b0:246:a165:87c7 with SMTP id
 d9443c01a7336-246a1658a38mr223930275ad.42.1756365967215; 
 Thu, 28 Aug 2025 00:26:07 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24884a629fcsm51009775ad.19.2025.08.28.00.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 00:26:06 -0700 (PDT)
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
Subject: [PATCH v2 2/5] spdm: add spdm storage transport virtual header
Date: Thu, 28 Aug 2025 17:25:30 +1000
Message-ID: <20250828072532.425592-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828072532.425592-2-wilfred.opensource@gmail.com>
References: <20250828072532.425592-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pg1-x533.google.com
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


