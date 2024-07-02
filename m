Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040CDC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZiT-0001nf-6j; Tue, 02 Jul 2024 05:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiR-0001mR-Cf
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:23 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiN-0006W7-JC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:23 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ec6635aa43so39465971fa.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912136; x=1720516936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcI1AN4c5MSHGXZPNCWGySksYQ9YOF7GAxwDscUWZ8U=;
 b=MwFvQXNqENgQtAsJnCbQWRX6M6uHlffU+hI0YWLUvupAKqSdDcJBPPo6v1sa6+Hb6F
 w7cMCedlgleuexUB9mCXT5Ep/+GBi7YDaJMhBIXBHsxsbCZegul5c6xf5b3ynSCA+aSQ
 rlbqfzAJQBqL6376WTnuX4theKN1mDBBOKQz2vvVDoXO8nRdDEvj/ZeAqQ7+3+n3l5Ws
 F0KVTiWcDwrpeuLx0hbaf4MZkq10luCIX9hQHD5y6ty70VzNvbU0+uzOgcVjWcWPE/nK
 YL/wnYd1TL8Q85X9OCT5k4r4WpJT2sLCt+TSEHCPJgQq9bbG3h85x/SEjfEZQcnjN8oX
 vwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912136; x=1720516936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcI1AN4c5MSHGXZPNCWGySksYQ9YOF7GAxwDscUWZ8U=;
 b=jMU1nGQ+2Osrs6svH6YCqFFCjUKnnVhx3z1wGLEsWHxvhqHBwFi1w27S3tCHA3DU7S
 UedxUyAqXlJQrLCshVKLmQlnYcDSMnTVbeawWFqpm5bjT5WHxV3BNt3kAo1jvUfBHORT
 eRbRLNA1wHkHMAKqdauwFEr6GPOIgX97iu/cCSvk998eiNpgFiLNwbq0eeyqsBJ8iJ75
 525tTey5hCY8EB+AHQfXJpGWMy5AhfWNZFi/l5IFVSlvzmLJi5OxgB0fYSkexZdm2+VH
 Lj2Fmv0yd74mgxYjHuIxJhVRhAzdJeLs4x0g18Gje7IV2JzAazMKv9XLB8KgPqOvNJbr
 8yMA==
X-Gm-Message-State: AOJu0YzIbLEIj+xfrcKpiG05l9rZNu0SBD7PB7asUapTCo40jMnZtvyO
 06cQ5E71R5bkzuNV+3TJ//Y/E2+IYMWLhmZN0Nhdai5hFW2Bnhvgw4gH8tBxM2hU5ijPCAjqzVj
 w
X-Google-Smtp-Source: AGHT+IGiO4CUlDHbuLXJ+NRX6B61NabAteRlq+FZUzCAfH3LrRJEZNrQ9AoDOIjHut3HR1HxhniLlw==
X-Received: by 2002:a05:651c:244:b0:2ee:7255:5047 with SMTP id
 38308e7fff4ca-2ee7255541cmr20237461fa.50.1719912136338; 
 Tue, 02 Jul 2024 02:22:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b061006sm187723585e9.22.2024.07.02.02.22.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/67] hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and
 sd_generic_read_byte
Date: Tue,  2 Jul 2024 11:19:57 +0200
Message-ID: <20240702092051.45754-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

All commands switching from TRANSFER state to (sending)DATA
do the same: send stream of data on the DAT lines. Instead
of duplicating the same code many times, introduce 2 helpers:
- sd_cmd_to_sendingdata() on the I/O line setup the data to
  be transferred,
- sd_generic_read_byte() on the DAT lines to fetch the data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <4c9f7f51-83ee-421a-8690-9af2e80b134b@linaro.org>
---
 hw/sd/sd.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 18bb2f9fd8..60235d3898 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -141,8 +141,10 @@ struct SDState {
      */
     bool expecting_acmd;
     uint32_t blk_written;
+
     uint64_t data_start;
     uint32_t data_offset;
+    size_t data_size;
     uint8_t data[512];
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
@@ -1078,6 +1080,29 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+/* Configure fields for following sd_generic_read_byte() calls */
+__attribute__((unused))
+static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
+                                           uint64_t start,
+                                           const void *data, size_t size)
+{
+    if (sd->state != sd_transfer_state) {
+        sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd->state = sd_sendingdata_state;
+    sd->data_start = start;
+    sd->data_offset = 0;
+    if (data) {
+        assert(size > 0 && size <= sizeof(sd->data));
+        memcpy(sd->data, data, size);
+    }
+    if (size) {
+        sd->data_size = size;
+    }
+    return sd_r1;
+}
+
 /* CMD0 */
 static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
 {
@@ -1912,6 +1937,20 @@ send_response:
     return rsplen;
 }
 
+/* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
+__attribute__((unused))
+static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
+{
+    *value = sd->data[sd->data_offset];
+
+    if (++sd->data_offset >= sd->data_size) {
+        sd->state = sd_transfer_state;
+        return true;
+    }
+
+    return false;
+}
+
 void sd_write_byte(SDState *sd, uint8_t value)
 {
     int i;
-- 
2.41.0


