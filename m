Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D236FC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kS-00012b-AC; Fri, 28 Jun 2024 03:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kJ-0000s6-4t
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:11 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kG-0004lW-5o
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:10 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52e7693c369so357328e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558604; x=1720163404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G214GiZ6GoHQbuSVeY1gM0sNgUJBhdD0Klfne+Cmhik=;
 b=s5ob1wo1rcjBVUI+MwK8M7IDrplaaVmMsWErNK49mdlw4BVqLz+uD53JlcNEhTes2J
 H2H7xKhWNl0B9kaJsfBix4TIJWCHrOHef8EMAyzNv3q4GRDGZqTwoUeL0sJReW14GaOr
 5VnEwmSm/iAEEWIlRn9DRAtI4iTZDkE6MGY5kaMe9vjAiENEaWisYnO83E5whlsOqFGn
 RWLz/o+2EaYmcEEKiBmz+wEhmny1FiHVFRPjl/bcW+Sz+Uj2CgARyMBWukf5JaDL1QUV
 Eu3UGUf+jqv8z5tzekvYTLg03/B+ADGDioLrvxRxEt7l9vYQawujgtKM/HGkrvjiC6N1
 Q/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558604; x=1720163404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G214GiZ6GoHQbuSVeY1gM0sNgUJBhdD0Klfne+Cmhik=;
 b=dLZHB4c/5GdfgsS3kzIBG9++ma1pQXYVxEqBA3xn844A2YYA/RF7srMuKBIop8jOxm
 3+lH515/3a72cfxn71guH45sfa48AX0hHMLd/fHvvdMYuJyVBErT4Bh06HJ0WSQEDcUu
 QxZNTEN7qTtDl1cwss47+SgNqtRvkPvu5aP+YtaU0lTC7R9CNKef3wAI2NeXvHDPWLON
 Qb90oc40nJAXNhPdyUTBgc7M7+ueg2r4M0sx+ENbW219lRiKVnyzYGll5Hl9vZNngRF7
 DlpU6rAi3ZX65Fg4mA11xmPGl5eRe3KZF0AErUIgcLtu0Qp7gm94d1DnMeNMMvp3vJIQ
 dEIQ==
X-Gm-Message-State: AOJu0Yx7hcna7PV45zusciM1II2VNjWvDJl0OZEC59kZhm+qzaa6DpOj
 btizCzIAtOwOWlEFmCjE8abHnzVAx2KT5W4uM44NvLuQBtfkXLUgiJyT2KgR1a/jj15+tVFWM/m
 QlNU=
X-Google-Smtp-Source: AGHT+IFwMh3Y9vVnw4tEoVwUezJePpnwa0FkmfY9CtjcRgmialmQ64NG8WraIC4tutT9nh9/oGryRw==
X-Received: by 2002:ac2:44da:0:b0:52c:dc6f:75a3 with SMTP id
 2adb3069b0e04-52ce062007bmr11514448e87.40.1719558604560; 
 Fri, 28 Jun 2024 00:10:04 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd5fcsm1344377f8f.11.2024.06.28.00.10.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 79/98] hw/sd/sdcard: Trace length of data read on DAT lines
Date: Fri, 28 Jun 2024 09:01:55 +0200
Message-ID: <20240628070216.92609-80-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Some commands expect less than BLOCK_LENGTH.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c         | 4 ++--
 hw/sd/trace-events | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 64621d4340..a0da06e017 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2197,8 +2197,8 @@ uint8_t sd_read_byte(SDState *sd)
     io_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
-                           sd->last_cmd_name,
-                           sd->current_cmd, sd->data_offset, io_len);
+                           sd->last_cmd_name, sd->current_cmd,
+                           sd->data_offset, sd->data_size, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 6a51b0e906..5dfe6be7b7 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -55,7 +55,7 @@ sdcard_req_addr(uint32_t req_arg, uint64_t addr) "req 0x%" PRIx32 " addr 0x%" PR
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
-sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint32_t length) "%s %20s/ CMD%02d ofs %"PRIu32" len %" PRIu32
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint64_t size, uint32_t blklen) "%s %20s/ CMD%02d ofs %"PRIu32" size %"PRIu64" blklen %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # pxa2xx_mmci.c
-- 
2.41.0


