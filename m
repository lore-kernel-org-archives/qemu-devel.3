Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC3FD29FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rEM-0004eu-1u; Wed, 06 Nov 2024 20:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEJ-0004eV-I3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:22:35 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEI-00031o-19
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:22:35 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d447de11dso242447f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942552; x=1731547352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eC842Nuh9R0vJWP6nw94dy+XXPWkmXcFTwUalIOdql8=;
 b=UGShGxlXFTmsKM44kTZaLh7i8oPgFVUbTEQavJ17np7MHrdbOpSHhZqbzMHEK/K9Vd
 i4djpCR0sjINocoZMB+csS69mVUdJNy63t/tR50tfUNYybOx1kWFHcx0xjMcB+7MIZCw
 0FSXofBwWQpYOmTOkFYcwdF472oeQqCPK4HvgIDNwwEWLTLdUSJK/ZQhBj1L4omQ8mVL
 sYFqfOmsCaEd2lk++hepO54J2fp9ghkbb4GCOzdHuIM0V9SWat+Q9cVsMJVzXP99yk4v
 lXY4tbc77Aa2y4DsDFLagKRR+ZOwYVP3KeD86SKkRp3X5MknXpYqKiaStj710swFYgAy
 qFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942552; x=1731547352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eC842Nuh9R0vJWP6nw94dy+XXPWkmXcFTwUalIOdql8=;
 b=byXgRmGSSsvnDExBufU1U8c2riWDhSo8xbO3UaPeeqAb/vhv5yNUHWMbORMtciLGJO
 KK5nmAygPjyn0VPNDETG3+MmM77LAOPZVKEelLzjkEJNf1BEZE8Sfa1LR0qgRbQYEsRC
 frJ7dkjP8LNOkb3HnaR5XrOt7uGcS8zj3Z5p2opJzF1ss2Yr0dM6wYOKxScVi+6Gxkm2
 IGyVNkgihHHsRbTNmlgUe9gLqJbhdBnnPnXqrvN06L/WzlEdINiCFwfv4VoGqdMx6f3w
 65sTQzr6ZFyNJvkwEPSbQqujZvQTC46XYuZlYEp7AccuLFBdoC4nyhiVc+O3DPdjxRrC
 4FSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTnTRPkEgzqQWDPw0L8YTHeOOOoqEI1ru4Jlrq5d+BuvAbMfT3HN2uEMIZkdFn2Y9VcWue1NBvc3gc@nongnu.org
X-Gm-Message-State: AOJu0YyTY9+GWQ+kPOn+0oZ0qZ7apKTpZs49OjNXvHwUYdPXeV/fmDgS
 Nh3Lkq022sOIAgV67wJAxzxcHR7JoFbPM3RJV8ya61DAcdG6LuefbzaLniHMkyY=
X-Google-Smtp-Source: AGHT+IGIZ5avbx8t2N6NDs4WMt7DDYGh/Db/QFt5MqnGMW1VSWc7JyiDhNJllZv6UO8Jo+bctsJ4QQ==
X-Received: by 2002:a05:6000:1866:b0:37d:4ef1:1820 with SMTP id
 ffacd0b85a97d-381edb19266mr196398f8f.40.1730942552530; 
 Wed, 06 Nov 2024 17:22:32 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9a9193sm239773f8f.63.2024.11.06.17.22.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:22:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/16] hw/microblaze: Restrict MemoryRegionOps are
 implemented as 32-bit
Date: Thu,  7 Nov 2024 01:22:07 +0000
Message-ID: <20241107012223.94337-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

All these MemoryRegionOps read() and write() handlers are
implemented expecting 32-bit accesses. Clarify that setting
.impl.min/max_access_size fields.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20241105130431.22564-8-philmd@linaro.org>
---
 hw/char/xilinx_uartlite.c | 4 ++++
 hw/intc/xilinx_intc.c     | 4 ++++
 hw/net/xilinx_ethlite.c   | 4 ++++
 hw/timer/xilinx_timer.c   | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index f325084f8b..3022b3d8ef 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -170,6 +170,10 @@ static const MemoryRegionOps uart_ops = {
     .read = uart_read,
     .write = uart_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6e5012e66e..8fb6b4f1a5 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -144,6 +144,10 @@ static const MemoryRegionOps pic_ops = {
     .read = pic_read,
     .write = pic_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index bd81290808..e84b4cdd35 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -170,6 +170,10 @@ static const MemoryRegionOps eth_ops = {
     .read = eth_read,
     .write = eth_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 32a9df69e0..383fc8b3c8 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -193,6 +193,10 @@ static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
-- 
2.45.2


