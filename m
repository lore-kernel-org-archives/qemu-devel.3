Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0F9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYj3M-0008Ug-4i; Tue, 30 Jul 2024 05:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3L-0008Tk-1y
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:21:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3J-0005jE-Ip
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:21:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42808071810so24871735e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722331311; x=1722936111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfhmWzmqXV6T/58ejZO+cBX3Heov2WpdbfnG9/jIhv0=;
 b=nd1IN17c5Q+jk12PJtBiKJWLm4w56bTH+wCRPTl7UzRfOye6+pw/hCt/5ubHCNJp90
 fU5Jwbxh26oQe0vu8GIShd0zkm6fVhcPhoMHJ/Ufd+XUAzkKU5YP4D2Ac5DqqhjvMQNt
 tWdormQguZm5x3PyzSeS1YQKo21TVXraS/pFkiZVv1vLb+9gelkFmZTTIpO9CBuYIpCz
 RTN6Q3DSsg+I2N6B5fKI4z2LnoqgpACnc0W/WyTu56oIoTylaeDeNilw0D/JIEsl86vv
 RvMR5RI25hjtjn4OQROkE4DkBJAPG/5y7v48HBbubsvLbRRb48xI7rN+SeOaKCoVc+JP
 aFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722331311; x=1722936111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfhmWzmqXV6T/58ejZO+cBX3Heov2WpdbfnG9/jIhv0=;
 b=bTz0sHfM+/R5rY6JjOmaE++pjoSUXAYNdnP0XjwnmPTrvZ+Z8GRJfX1WWTMfV61Bfl
 j/HCPsgfkicYJny5fdvzsCPdJ63W6RogPsr8nXZXH7CzuEEeuIj/rf52YnlCI5pPTA5n
 nJAHkosXli1R+SUH2MgNk+hoSf/bk4bfEPacQD7Ej7zBZQudfgyYIyQ9WqnAKj9IfA2k
 PtDkqH0ZT9+9ie9p3Ui4aBINlWUhMIAbQ6fFLa+pYFrDUMfSqetNynli9K0hMMHfa5li
 9F6NYwhIsi3wYZ2jGMXQdxgBzW289fMDgo14N8KDLExvQ7LzG/3h67eZRHpFNM8ANJqt
 iYzw==
X-Gm-Message-State: AOJu0YxSOmX7jOTKWU/OuqJ/+zhIWbJooj/BlP6YmEJ0v76gTWoPx1GB
 58tksf3ARXUShzFG9/DRj9VTKSzA/jMTogezmgqy/ijtifx819Qr99qSAWpMLMy3QrZiyrnn3II
 ZL6E=
X-Google-Smtp-Source: AGHT+IGjKKfDh4t9jPa4CukWpmYdpzjTLES5UaV1T2AjVuMXtGcMhD6HOfANwHv+6N2+a3GD1PQDPg==
X-Received: by 2002:a5d:6188:0:b0:364:d2b6:4520 with SMTP id
 ffacd0b85a97d-36b5cdca638mr7523428f8f.0.1722331311572; 
 Tue, 30 Jul 2024 02:21:51 -0700 (PDT)
Received: from localhost.localdomain (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fc7c3sm14119489f8f.49.2024.07.30.02.21.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 02:21:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 1/5] hw/sd/sdcard: Explicit dummy byte value
Date: Tue, 30 Jul 2024 11:21:34 +0200
Message-ID: <20240730092138.32443-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730092138.32443-1-philmd@linaro.org>
References: <20240730092138.32443-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On error the DAT lines are left unmodified to their
previous states. QEMU returns 0x00 for convenience.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 07cb97d88c..c02f04f1ea 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2478,20 +2478,22 @@ void sd_write_byte(SDState *sd, uint8_t value)
 uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
+    static const uint8_t dummy_byte = 0x00;
     uint8_t ret;
     uint32_t io_len;
 
     if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
-        return 0x00;
+        return dummy_byte;
 
     if (sd->state != sd_sendingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: not in Sending-Data state\n", __func__);
-        return 0x00;
+        return dummy_byte;
     }
 
-    if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
-        return 0x00;
+    if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION)) {
+        return dummy_byte;
+    }
 
     io_len = sd_blk_len(sd);
 
@@ -2517,7 +2519,7 @@ uint8_t sd_read_byte(SDState *sd)
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
                                   sd->data_start, io_len)) {
-                return 0x00;
+                return dummy_byte;
             }
             sd_blk_read(sd, sd->data_start, io_len);
         }
-- 
2.45.2


