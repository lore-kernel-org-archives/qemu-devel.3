Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A789C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOftU-0005K2-DT; Tue, 02 Jul 2024 11:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOftS-0005IM-Af; Tue, 02 Jul 2024 11:58:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOftQ-0004Y1-Ju; Tue, 02 Jul 2024 11:58:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4257a390a4eso22316825e9.0; 
 Tue, 02 Jul 2024 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719935886; x=1720540686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2kKFopujEfbCs6sAOrXHjFuHM3SCJpZnLQdAZV/N9oM=;
 b=B2mxbzlnkoznr4pxKA2ju+HnzydviWn5rf9fGkLfNcYU49DQDJRhTRJPjt5sbMN9Cf
 oFW/s3KiVx+AgG3qZh9r7fGkZYU1+FYFqYc4t0meXjfSJ4cQXDg4gN4QAf6G9DO7sZgI
 35OUyUf9TnFGXGS/Of/bi1aIdM4lwq7Fwv8JgC7mOnlbZQ9crWnZ3p4ZrmJ2vanupz52
 kRHEAwWQgHH0TiFuWecRprgomaTbuXjfqVhgiyRLbgkh04t4iR/Q3TbqrBinpzXqGl08
 lOAk6KYK915kvxLajyz+JB+PAoA/JrzfYiydRTnMpljt82jJXThfLyHQUzu197s8B4WK
 Ajig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935886; x=1720540686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2kKFopujEfbCs6sAOrXHjFuHM3SCJpZnLQdAZV/N9oM=;
 b=ll6GL6oXkSSrxLCKyMBCviKQm1KjcxFO047vp7Rxdv9/Mn3yaihjmUXvNNJ+zwDwzg
 P8Qhnb550S5yfy45iwhzsVbQ9ixSgJ7XWpD13mZ7fRrW/y8SsolYfFJhtA3w5CHY4RfG
 2GEfI7PmtLlNQZIv+Q6k5hSHnUYTjSTHcqg9+ZjhMXknNPhU6oYFXp86yvXSGLNBIcPB
 wRIpttXP0CWj8WRneyIqQmgfbEhb2cJDxKUqKcKUX0eS8aFqRE3uYBcxNv/XgzxUY/WC
 h1t0jXn6oePbhLucPZL9oyTM8qgrhEVeualojI9kITEdfhSzbrMZsy3Dueawg2V07HYA
 6ykA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCDsXy6Aaki/T5FEANLcJJI/GPa4Lk/lpx3CppnIm3Y7EoBQBxvXBdgvFp+Md3IQ/JPShAZhOze42IDns7p2j4qQL3UVn40p3lcXmolJddpoyj5ilYS50Rh8s=
X-Gm-Message-State: AOJu0YzdI4eIJSrC19kIx9icVZ4jfglIyFGe+RBphvyqJzTkhDvyS7rm
 4ceK52KH51gBBmKv7olg2+rWJSlbl0bDC7rMqUYregLWsm+Yz7YHvcV21AY=
X-Google-Smtp-Source: AGHT+IHmJyMY88vhwwhPb9nj+wesO6g0B+nDOS3dLPhsHZoTB9CJl+zNpdGfeOUn6YtChT0GoJpyyQ==
X-Received: by 2002:a05:600c:5486:b0:425:5f86:41bf with SMTP id
 5b1f17b1804b1-4257a02118bmr52827425e9.30.1719935886464; 
 Tue, 02 Jul 2024 08:58:06 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257c4e1112sm131868035e9.3.2024.07.02.08.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 08:58:06 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3] hw/char/pl011: Avoid division-by-zero in
 pl011_get_baudrate()
Date: Tue,  2 Jul 2024 17:57:52 +0200
Message-Id: <20240702155752.3022007-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=zheyuma97@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

In pl011_get_baudrate(), when we calculate the baudrate we can
accidentally divide by zero. This happens because although (as the
specification requires) we treat UARTIBRD = 0 as invalid, we aren't
correctly limiting UARTIBRD and UARTFBRD values to the 16-bit and 6-bit
ranges the hardware allows, and so some non-zero values of UARTIBRD can
result in a zero divisor.

Enforce the correct register field widths on guest writes and on inbound
migration to avoid the division by zero.

ASAN log:
==2973125==ERROR: AddressSanitizer: FPE on unknown address 0x55f72629b348
(pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)
     #0 0x55f72629b348 in pl011_get_baudrate hw/char/pl011.c:255:17
     #1 0x55f726298d94 in pl011_trace_baudrate_change hw/char/pl011.c:260:33
     #2 0x55f726296fc8 in pl011_write hw/char/pl011.c:378:9

Reproducer:
cat << EOF | qemu-system-aarch64 -display \
none -machine accel=qtest, -m 512M -machine realview-pb-a8 -qtest stdio
writeq 0x1000b024 0xf8000000
EOF

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v3:
- Defined masks for UARTIBRD and UARTFBRD to avoid magic numbers.
Changes in v2:
- Enforce the correct register field widths on writes to both UARTIBRD
   and UARTFBRD registers.
- Mask UARTIBRD to 16 bits and UARTFBRD to 6 bits in the pl011_post_load
   function to prevent division by zero during inbound migration.
---
 hw/char/pl011.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 8753b84a84..f8078aa216 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -87,6 +87,12 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_DTR      (1 << 10)
 #define CR_LBE      (1 << 7)
 
+/* Integer Baud Rate Divider, UARTIBRD */
+#define IBRD_MASK 0x3f
+
+/* Fractional Baud Rate Divider, UARTFBRD */
+#define FBRD_MASK 0xffff
+
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 static const unsigned char pl011_id_luminary[8] =
@@ -374,11 +380,11 @@ static void pl011_write(void *opaque, hwaddr offset,
         s->ilpr = value;
         break;
     case 9: /* UARTIBRD */
-        s->ibrd = value;
+        s->ibrd = value & IBRD_MASK;
         pl011_trace_baudrate_change(s);
         break;
     case 10: /* UARTFBRD */
-        s->fbrd = value;
+        s->fbrd = value & FBRD_MASK;
         pl011_trace_baudrate_change(s);
         break;
     case 11: /* UARTLCR_H */
@@ -531,6 +537,9 @@ static int pl011_post_load(void *opaque, int version_id)
         s->read_pos = 0;
     }
 
+    s->ibrd &= IBRD_MASK;
+    s->fbrd &= FBRD_MASK;
+
     return 0;
 }
 
-- 
2.34.1


