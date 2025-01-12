Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00992C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Hc-0007XB-Lk; Sun, 12 Jan 2025 17:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HZ-0007W3-Ue
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:09 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HW-0006Q2-QM
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:08 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3863494591bso1955405f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720284; x=1737325084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/k//ojvQ0ecXxbrd+D/WoEqwCLOQehsHZqlLpHp/lg=;
 b=Zdz+wGVwxISvBTJQNzEwORjSRl2ftl5rqBmwZq9tbdVaPGeRv5FGyB8Ybhzf4cBtWK
 CzVXvpuc9EdYt3hR2CDhG7OIacEkilvvyObCR0ujG5jlvFmImqoDV19W44EKtVS0KEyn
 1auMB7/xAXjnYlxC7pDm01gNoG49k5GLI//pPGxael6gbemK15Ym/fFz7JIQsOBLuFxj
 gL4MI27FzVpk+fVK39OIAoEzo7F2+BZrojPyyEFGnKpw0Hnk+uoPm2AlI6l34msbGAb9
 k59JJEx5orWHfmCYQ/iq3o7W9d8OyU9qRo/D25KJJHY14r/7ssL+q8GGrgQNIDJzDUtd
 1FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720284; x=1737325084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/k//ojvQ0ecXxbrd+D/WoEqwCLOQehsHZqlLpHp/lg=;
 b=FidFEcTUi+QRPxsJkeGxbLrNdxa0LsZfl4pRzSVKpGvDebQXoicl2cK/3p9rHHVEpw
 jzhIBOhDYt5OBJQOFruzVBZX6CZ7qYsV9jjPNRo8EdoOtCJRae86ENPjRA8PmbFR4MhH
 KEfcQ77XDH4ipQmU7m+C4f1oDbgRP02FN064pSaz57uCus5pYWji8KafihtLFelj9ih7
 dOruweNwAfcYMexyKLZR9VxuzR2qo3JVFdCZnpA6c7+cQwx0G1RGY/oMk7Udj9yJxJ4z
 3EaaUBjsHCnA5IEVSA6+bopmqkRpaD7Zyb6LeGj6dPsm+K2yq7BynNZc9+h5SQM52y61
 ae7w==
X-Gm-Message-State: AOJu0YwPjxMQCxUiS1ldAYSLD6s7lV3p4VaNbr7nJvgn3Wym165eNTu/
 UXPCvUq++rOvRF6/ZBr+CMmQfdmXhFs1czHhmsW9ZYEdiJOKMTCD+afnhg/9PiZf/FXHkPOYHfB
 zJ/4=
X-Gm-Gg: ASbGncsLXykSBGtuqLUGP6rZYhCvhivvqS1q+ryHq/k/Q3fY4Odafe3FbSZxoNTWw0A
 NLai8oBphmdYYwkKi3PVgvdGfiu3D6FryKMIFHCihg7kMqpu9DK207XdDD5D/m6+PBHJVYTOZXH
 gsMDAv35Q+bkXrhyjqfQgwxX4Wh5cw4/ueSj9fEZQXlXhCgguKa8V9oN2kek391QYunLocHXjDC
 ESozXiQ5cnXLgJ1vpAYVL77i6Z+yVbvtDIPFKjsyi3Nd1+HQaDEGklb5iBGlIc4CSE2Zik/gOov
 eGTMNOzvRGT4PysSJKjxDRspWev6gN4=
X-Google-Smtp-Source: AGHT+IHk9WgAti4NvE6crV1sv7LLEZ4vz9tmQPqkjW7q+Du7LdLCO3aBT5EqV9uOUA4XggaHP/ayPg==
X-Received: by 2002:adf:a411:0:b0:38a:87cc:fbee with SMTP id
 ffacd0b85a97d-38a87ccfd10mr12095295f8f.14.1736720284392; 
 Sun, 12 Jan 2025 14:18:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b7f86sm10605149f8f.67.2025.01.12.14.18.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 07/49] hw/microblaze: Restrict MemoryRegionOps are implemented
 as 32-bit
Date: Sun, 12 Jan 2025 23:16:43 +0100
Message-ID: <20250112221726.30206-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
 hw/intc/xilinx_intc.c   | 4 ++++
 hw/net/xilinx_ethlite.c | 4 ++++
 hw/timer/xilinx_timer.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index d99cf567aeb..6930f83907a 100644
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
index 4c0c7fcae3e..88ab331acce 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -166,6 +166,10 @@ static const MemoryRegionOps eth_ops = {
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
index 4955fe1b01b..6595cf5f517 100644
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
2.47.1


