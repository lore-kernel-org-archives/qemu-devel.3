Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825DFCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usvXz-0002Tm-1E; Sun, 31 Aug 2025 23:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvXw-0002So-4A; Sun, 31 Aug 2025 23:49:32 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvXu-0005gM-B4; Sun, 31 Aug 2025 23:49:31 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4df220483fso1316539a12.2; 
 Sun, 31 Aug 2025 20:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756698568; x=1757303368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNY4ncpuDcOsXQxB2Rg/MklRq+L9/xqLJrUQZb5aHUA=;
 b=lcjPcMmXuD7JP+zEQfpmea8LnDmHxF3Y4y64nm/44M7hISKSkAHJacNCnAo8KYPA2a
 x9W3Ihu5Sl8LmAdh29xtK/ihMId5fjWeA9NUuoYMKZhlhJjyu0JVg33lGq2Q73s4P2m4
 d+xd0ukZO/x02tbW1ZevMpOrOOTmhlDWXr0O6JiyjRKyaADfJZnmX4TBf1VhPm8gcSqG
 Qr9lNWTtt7cFSR2bphRowq4B2k5QjfjStF3K4aI0pDYGvXWrlWNvM7Dm8SqggkEUSZ9O
 mhxcf64LdYrJZ+Pwe2psvYlE+dIyfKaGoWG/zZTo48nH+lyHNkAnj9GqmVHJxbrjWdk5
 OUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756698568; x=1757303368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNY4ncpuDcOsXQxB2Rg/MklRq+L9/xqLJrUQZb5aHUA=;
 b=xCI+mRCI9eJnNuTZTt3+Yv1Zm90j+Mv0wWFfh3vrwmscW2VWp0kC4lhXLI9Q95hmbl
 a2wSB3Hd9uSriNAro0q01pneM7OCWUSwlsJd77IRmUQA/ic6jc9YYRYQNChMY7LlAsVB
 p04ikC54e4vBNNhyo2Jm8z6igEHTXoad9DFQzvBax7MwoG/W+3xu479ot3brNAeu1biU
 PxR6nRiXymR20Pd0TBb05M5NBjGrrIrbdOlEBx3SZopaHltRpKJ5iUgiSzLgGakJykny
 SP7R/6FB3TGfuzN7ohnUuxZyNF6uFon1Qk7/noz6t0ar7etpGT8ltX+A3lGjJaLJx+Lh
 Wd7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO8aD6ZFy19ER2wqqOo9M0TaaU6S/O/tAO9cmHxtwGKq11T9kIcwiDf4yPMGnlwnOvxakUdJpZf6MG4Q==@nongnu.org,
 AJvYcCXRqSXERZPOEfeDI0Ve6xoiJq3nME1jNvHwtVvA+Q7DI8jShXg7ZliJ2a7PgpegJ502YR2EL2k3pnXY@nongnu.org
X-Gm-Message-State: AOJu0Yxx6lf3VApqRCQ6F1ce5MJSbpikqXJFd85Fyy4K2I+ekS1y4DOM
 igbeFjxJ2LafbfJta5aIO+MLV04fVcXRP8Ob/9YXuy6+qDn0krawqiP/
X-Gm-Gg: ASbGncuDlV49FC8DE/yPEbEp0YFjfblSpOW6TRM43R6/Mmyh+ooU09CrVsyQEnt3Cil
 /dUf7ZYZHBuF9vvEVBtSL1HvtTm8avL7g1jBNvimHppDHQszEXBOKF5P7Y7J3MHmorhWxaD0Rco
 tbf72u/yIMX9cKvziOt3Ul4sGUPMWLLhx+lNtIEXgzqg1T+IbIXoo8T+f/w7+b4AodrcW9cTjvK
 ADESv731SGAlMFgnfovROyXsuxuXzZUKvUXQpaOC1GXZPXUygcY/A7Jb7x0q+L/oqyTxes45LHP
 KTIyqfullco9sZCk0g4HsA5h1Ecbcj9rBV7JBSgg9HO32sNBqS2CdoR9xIJlg4WEjGUamMUfOPb
 F24AUvotSlSbKQ5kKr3wn81ykvvGdb1g/bEEHuveq6lZ0nUg=
X-Google-Smtp-Source: AGHT+IFdJ5o0e4vpogbIibYDZzS1T+vxIUUqJG5aB1sZ09iJ0ZPWAeVQ+28343dyKevGZ/FgNWMwNQ==
X-Received: by 2002:a17:902:e54b:b0:248:b716:c49c with SMTP id
 d9443c01a7336-2494485bb85mr77442085ad.9.1756698568148; 
 Sun, 31 Aug 2025 20:49:28 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da26b9sm89802815ad.93.2025.08.31.20.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 20:49:27 -0700 (PDT)
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
Subject: [PATCH v3 2/5] spdm: add spdm storage transport virtual header
Date: Mon,  1 Sep 2025 13:47:57 +1000
Message-ID: <20250901034759.85042-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901034759.85042-2-wilfred.opensource@gmail.com>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pg1-x530.google.com
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


