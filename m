Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A1C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5g6-0007B4-PG; Fri, 28 Jun 2024 03:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fp-0006Dd-UY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:37 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fo-0002Dv-A5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:33 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-36279cf6414so167714f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558330; x=1720163130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5jx92qB67I10buO/mjgytlSWd5fIkq6vABNEGHlhvFk=;
 b=cJ6ZYU1Cs8pgNrvoNujsuuNvnM0Ru4dSbVtEw2voQXkHti6+BnuV870e4J84eYRnzf
 xkOrMkdfXLWlXjP4Z362oTbjhT06607da43IFdk07cx1Z8+eCCFUWbDs0aHtLCYgmoqG
 82y4gQxMGQmovjGbr87ziWkaR/DDXsSy1MWvyNhgPKy668qRB4yqRGvItTEEzH1nm/ou
 ucMvrpt8pc4K2MdtQAoS100K9G3tTTrYHt6Kcxvndc5TdTMOuJbpOGniqcb0hj34Zi//
 S+pkffnD9vkKjCsGvS7kNQhOKNtbrSvMlLodBkGp0NkW7wxJ7l8Iigy1nYTqPsXLJhHa
 VZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558330; x=1720163130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jx92qB67I10buO/mjgytlSWd5fIkq6vABNEGHlhvFk=;
 b=eUdX9Fcu3Anz/c41HlrJMQ0Sq5UzN4qYE1veFZk2Cx3AZgge3UxQdl/fNxC4bo3bHZ
 srvXh0DDbS4UjDPe/y2k7SJa7SnbG5rKkmktj0Jjom6RR02JfTgbD9P75M6jZMgAkMmE
 bqJdo0zea2OFs+PvkoIRJAAgEF6BPt6fqv4/LRoIwwYuxLl6HhR/d0mlitb/wl6ZqmD+
 +jvXT8hzsCk24TfEwx/OKBYxEjNp4SWaQDe5jO4fuONOptJj+CN8uur/e9OnL+gXeavs
 MJDv+UlnSPVYcClIGXxmCH8bFb2NBHJdoJ8ZlPYHIO2z0m4nYn5n3JnNy3YwG3t10/W4
 B4pw==
X-Gm-Message-State: AOJu0YzsrN2GXPSUCgwi+sfwN7agHwFY5A40nmMuamfLlblvJfyETLF7
 emGYSRfmfhzOL9GFUAiiN6yBlHz5S45Jokxn2+JAmU8c6w4KVzC2qJtqcW60ApMi9mzWnwOb6WS
 dea4=
X-Google-Smtp-Source: AGHT+IHwtxWz05UNH5Efx179dXj+4St8tGotJJuuFqNM7LQA0PwvxF5QMpFkUpXkzBTSKvsEqIWJ8w==
X-Received: by 2002:a05:6000:4020:b0:366:e991:b9ac with SMTP id
 ffacd0b85a97d-366e991ba88mr11685612f8f.14.1719558330539; 
 Fri, 28 Jun 2024 00:05:30 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc4c9sm1322270f8f.86.2024.06.28.00.05.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 31/98] hw/sd/sdcard: Convert WRITE_SINGLE_BLOCK to
 generic_write_byte (CMD24)
Date: Fri, 28 Jun 2024 09:01:07 +0200
Message-ID: <20240628070216.92609-32-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5dbfc8000b..4a03f41086 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1101,7 +1101,6 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 }
 
 /* Configure fields for following sd_generic_write_byte() calls */
-__attribute__((unused))
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
 {
@@ -1470,10 +1469,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                 return sd_r1;
             }
 
-            sd->state = sd_receivingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
-
             if (sd->size <= SDSC_MAX_CAPACITY) {
                 if (sd_wp_addr(sd, sd->data_start)) {
                     sd->card_status |= WP_VIOLATION;
@@ -1483,7 +1478,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                 sd->card_status |= WP_VIOLATION;
             }
             sd->blk_written = 0;
-            return sd_r1;
+            return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 
         default:
             break;
@@ -1999,7 +1994,6 @@ send_response:
 }
 
 /* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
-__attribute__((unused))
 static bool sd_generic_write_byte(SDState *sd, uint8_t value)
 {
     sd->data[sd->data_offset] = value;
@@ -2045,8 +2039,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
                             sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_blk_write(sd, sd->data_start, sd->data_offset);
-- 
2.41.0


