Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB7DC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3dN-0000ki-5z; Fri, 28 Jun 2024 00:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3dF-0000Lg-F1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3d7-00016e-14
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-362bc731810so153381f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550474; x=1720155274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G214GiZ6GoHQbuSVeY1gM0sNgUJBhdD0Klfne+Cmhik=;
 b=RnU/JVJeMCLHmjCZE4W6ZnLLOqT4Dq9HEqJ8Oym3k87zOF+JF50Djm82F2DP8WTCjJ
 NyBfoICtIbf6LYAwKSNFDUahlhhMu4glmj2s+XjL7VHXGSMoEmMUbHdniUd3eEeIVmqC
 eLMgr8JxGw3GunIYUdGpdK4G/D0Oeuy08dNdNVueyEn3kPPKylf8kGU7xWz/zzZmAk6b
 a9uoIAVm0ztcBeTTMBBT/RTWpNIIKXZ+Pji9mAs52O6w4FzimyFzIpHcZdFmimyu2lm3
 jcUHGEu1sm259k7jyATJhUUg/s0XykLQgL47Crl67YXhmgbzvr24QqJvLLrScuhUf12S
 ZRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550474; x=1720155274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G214GiZ6GoHQbuSVeY1gM0sNgUJBhdD0Klfne+Cmhik=;
 b=MSIMkAK9Hvl0tDcFWOyGy2/XLRhopVrZyXJHgGCAIeE6np7NwX238t/WfydJKsCZff
 ctdQRhUHM0NplWCOH3TWFVVPHuDy7Zgmjm10EXK5AmEpOS1x5Xr9Kn7fZ6NAdU00xTg8
 +7bWCwL4TW3iWOLLJv5qdnt2Ud/O6asmQnPCc1ZenxnGkAgaLCMTfMOr22bz4jOZkQsw
 opAioRKQ71E794U5Wv3/RPI84yHumdjvbV5LtdgaMDU8ajLZ9TkhM5IVuylZ8H/lcByz
 B1IfNEArNA7nTIOixjgZYZUbWPvhfA8YKaBttbwR3rrr1RLrvuH2YwyR6ylQAZo7VSvX
 TxOA==
X-Gm-Message-State: AOJu0Yxs1ezdpj8Gadwxy680uFEyvlVYfJ/Fx7EoMHtoAN9DjRlINc2J
 rqItny/tb4yZQvE+LWvfQgKfOif72BySedK1IMM7+QuN6L2tMRulV3zRmBu2glTgkn2NkBybUve
 P/LuoAA==
X-Google-Smtp-Source: AGHT+IHYkBpse5piUiPKertkIwuXZHCuOiVZeo8C1GO8glaK8B15ageFzCHi+Jilc+35UZ4eZi0y5w==
X-Received: by 2002:a5d:4b87:0:b0:366:f04d:676f with SMTP id
 ffacd0b85a97d-366f04d68f9mr11382349f8f.12.1719550473957; 
 Thu, 27 Jun 2024 21:54:33 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0ce6c9sm1077729f8f.22.2024.06.27.21.54.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:54:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/12] hw/sd/sdcard: Trace length of data read on DAT lines
Date: Fri, 28 Jun 2024 06:53:23 +0200
Message-ID: <20240628045323.86308-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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


