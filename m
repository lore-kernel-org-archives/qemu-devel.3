Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E6ECA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 06:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwaNZ-0001Bw-Pt; Thu, 11 Sep 2025 02:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNX-0001Ar-Nq
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:01:55 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNV-0000a7-LV
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:01:55 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7725de6b57dso435505b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757570512; x=1758175312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRpME3fEReq6A+HV+JEVsuZoSxZ+EergPyPzTNo/lsw=;
 b=MJ/EDMcIH0LPimadQR05lu2q/4pYljE+JMxcJ/TLsyYtRvbYf7cOE/sPEsiA93TYGH
 i7N4gOpbQiXTmCo5f0f0c59OyIH67b550TB2GZBOS9J5xDzQbQBu4Vq8hZpSpnWPUG6o
 YsnojIp2dtpc747VCe43k0+Mm34dxwmAflvTABa/v3y3Telmmk/JeQvqf2srF8LNjaik
 gtlIkRrhHlam3l3EIxAKXWJrgu80YLdql5x1ntP9mSe9coodev5YAwimq7BdpTqEVv4c
 M6J2yHTvSUljars8uKz33uTSZIcyT2pU4AV7LcmZ5n3BGt5iUPyWA+JIVezXySVk3aI8
 Zquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757570512; x=1758175312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oRpME3fEReq6A+HV+JEVsuZoSxZ+EergPyPzTNo/lsw=;
 b=MVTyFSMbtoenRYUeZ16h8+kvynpySwsw5bdrqkcCDR+9jq3ptpLmdP9PKLnSpE5ImF
 7R5MoBXCScCsM/GxKWhpAcYmtUnktvjhYqvjaTO10fyAF3Wc92QbiemEn45ApR0vRTWL
 z3f0hmO87Ga1wW6gGv/TJ9qZkDrgEXUbTZt1865zs5iThnZ6WbqgwB0+HNFmNT9IDYG6
 W8dpgY2ou6mTirGO6SIPgb63E13VRiVJkt+JXyJwVvu9o5FhX4hVIqpzi4qLiMTo8SmJ
 AKU2bvPZcPkTzwOhKpF48O6d8QAqBpIdCnba7RAmFYomM3e9pLkX2fuYwc0UP4UgRsdU
 loiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0mID0A6IRKsdimO7DFcwIgfFmjB9J6OTd+5+1tGdKYFYVAfRy9g9lPihsG+5dylbUO305cqIxw0uc@nongnu.org
X-Gm-Message-State: AOJu0YynZKHHj8vFyd6WVWedt25sD7xb8o21Y1VHpdh6E+ZdQnzkOjVW
 fBGE0Zx85Cdz5FEQ8vcuGAwQ5jsK80KDYjmYpZKu4vug8aecMxXeRMGT
X-Gm-Gg: ASbGncuPbf9n2jVp7B2Te5VttAgxhRhu50YXbqZIqHUADvQo64SW1iEZe33ufI/r8Xc
 CTrD4z5uzyO432PBDrZquebD0DKkj3hzNxoBwUe0HuAPs22h6SXQRrQVlDjhkMmc44DdokskfQb
 Zqh1W6wFgG0AUseMmGntpQ2qjBJ7boOHB729SIzEtrUeP/edYZ9iGAFyr/833yVm8f/JVavnpVL
 5yroiH7mM6GF6nDfTMMCJnqcqNo3mEShcjh+SPeclHOVp6V+/T64DRxvShF1Mf51jLbWBtPDRkQ
 8kPhNqvlicNHgtS8snQA8JkecXHsiKnctceLBZiv0v89UQcwhMVcGGTSJ+wTyiUBz3jtqmWiES/
 BJxzJiUt21avs7oZnUXmmeXLRigw703I=
X-Google-Smtp-Source: AGHT+IFQKXPYbSJGr+MYQtaNagRLgtGREumXIm3/Ryh0XibIxls9djF5wLF4LQgJj/anX8qA3jp5FA==
X-Received: by 2002:a05:6a20:914c:b0:246:9192:2778 with SMTP id
 adf61e73a8af0-2534557a7b3mr25569206637.45.1757570512098; 
 Wed, 10 Sep 2025 23:01:52 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607c54a71sm795381b3a.102.2025.09.10.23.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 23:01:51 -0700 (PDT)
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
Subject: [PATCH v6 2/5] spdm: add spdm storage transport virtual header
Date: Thu, 11 Sep 2025 16:00:28 +1000
Message-ID: <20250911060031.124683-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911060031.124683-1-wilfred.opensource@gmail.com>
References: <20250911060031.124683-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x42b.google.com
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
index 29aa04fd52..80cd7021c1 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -88,6 +88,18 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
  */
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
+/*
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


