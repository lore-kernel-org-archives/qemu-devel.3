Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEA6C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthF-0001ds-BZ; Thu, 11 Jul 2024 09:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthA-0001Lo-Ce
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00063a-3O
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so6646585e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703910; x=1721308710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0oHQIPs0GoYkvLkiU1uUeK4MNvDVeEKdzAv+RB+FavI=;
 b=Ien7Zo6S8sm9u7Su35IAt/O21haHiyEKY60UnuFLuwJybJxlFIJpF+LpF2XBQlzIe7
 T5ST+qt6RkQlr5PjJL7tCWwQyiwHeH95xf/VGkohxFdb6UA4lAWaKcQlQVdGBezSJpVM
 n2q46xqaFMq8iwYolC8eW4JkgolYpHB0dFxJ3qKOoH1fZJDMroESd5cG+VUNYZzJ2iA8
 WFDI9fUXVokU2idgvGYAhN8RCh/3SfTHsWpqJ2V4EGQcevzxnifkASZFDIyciXqPRp7Z
 BnAEmTGvEVq+/bSmepxxiSFAwdIR3aGmzVboun4Qb4EZGcksZuKjYmc39sc3z6rQecVO
 0o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703910; x=1721308710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oHQIPs0GoYkvLkiU1uUeK4MNvDVeEKdzAv+RB+FavI=;
 b=NBNBVLcOBOpVlGFZs56WWpR4yz0hAsINSRZ6FEXVQHBXi3QO1YbplqS4dJOSFuK8uN
 cD5hPii6xUrr8VHOBqQz+IqOhzbkgcYDoNb2RwSd7fXWWJN8yqEdVrIPWtImNYAjhc+1
 Kr2aQpfQcxmLD1Mh6qtRT6KgoU9EV37dXms+TdDmzbwAVd+1nXErEPkV49mgWG0/PH0/
 FaGSmJuMR1E6Rjru1Rskti5w4JXX0dHh5o5eCsjLc/1smwZJxZ4w6izZFdQh9nY6AOrm
 hrKXHGCQjl13/TEAfbEaRd40edD5CsclPXeXXuegRd2eAMGnEbaWH1KovFBAzVIHWdGy
 irHA==
X-Gm-Message-State: AOJu0YzJDWMPMTl1caTRu0FkoZ9KiTXgIJ6iyDGTGuJkQo6Lv8Ea+Z7C
 QZptdg6NDmtB7ud6CEGc/ockhRKsnzThEfHRsLPJvzSjAlK1z0htBbSQxn7qWVUdN87Zm3iIv9V
 Taz8=
X-Google-Smtp-Source: AGHT+IGfEfphXPc3TFG1Bko+XSYlMwECv4zyRp0JKqLxopDBAsLMnIPaHpsSRP8rT1vE0WOZI3YiQQ==
X-Received: by 2002:a05:600c:48a5:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-426707f83d7mr66077115e9.26.1720703909834; 
 Thu, 11 Jul 2024 06:18:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/24] hw/char/pl011: Avoid division-by-zero in
 pl011_get_baudrate()
Date: Thu, 11 Jul 2024 14:18:08 +0100
Message-Id: <20240711131822.3909903-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Zheyu Ma <zheyuma97@gmail.com>

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

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240702155752.3022007-1-zheyuma97@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/pl011.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 8753b84a842..f8078aa216d 100644
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


