Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081FBC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZIi-0006e6-9m; Fri, 21 Jun 2024 04:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIg-0006Tf-8D
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:14 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZIe-0008S9-Dr
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:13 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eaa89464a3so20467061fa.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957230; x=1719562030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zv2IPBSQdIdPeLuMZrnQwKNaEJe3N40sLNBQgal52uY=;
 b=R3X2IGN+vUWZo4IiSlxJ9vtqLqn+buTVbx6KbrZJhoaGB03TXPuz2s9lvJW8Gb8h3I
 Uqev++PRyB+epOnnvDVubILnRWCNf656O/U9/RjTSnQ2mEYawjVvk09cc2SapPKNnMIJ
 AtPezlXs+JeK4bvlXfY0HRNSdhfTlPIE00eE7mnG36X6QyfPU/vngWeVCAW0qFbnAJ60
 TbVTCRBru1UB3ilcM7lw1ZYfSiswfv0TQgufZNYJ59DMRkOJRBFx5DReaF45CjIf+raC
 SWIIsSAR3oLGuA8JkwfSuq+OMz8CIFqIjkMIGPxvdWDqvL5T6BWQM+0gx4A/k6Ni17un
 lIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957230; x=1719562030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zv2IPBSQdIdPeLuMZrnQwKNaEJe3N40sLNBQgal52uY=;
 b=VhlOvJCrmgjniUOAhSFbtvkAklkWgUEF2Cg6oPiIRuV/+EmeI6xNhAtDI5LzIpDvon
 4GuxiOAJGR73uZ/TKZzEqcQ4sDgHor4hk9qEsZPFqKtlcnRyiXop9ZFirkab4+WRTryp
 MUOSrg58UgGupzoKzq7YgSV9NMsHOx+PrDnDSClF4FXPhoqazAUFBwTUGy8CSdpLnKeH
 z0vnSWQksdmdbrNzULNYNdCLGwLyZ1ahsxm+nnkWobmVWpz77sLKOojThIwo1NeivLXW
 oJ37f/iBcOUaqBP3uNxV9Qlk1WHENRvKiEU8w9LRaD2wvNyH+D9gwngNVP6OxzfPU86z
 mmnQ==
X-Gm-Message-State: AOJu0YyJ8Wez5stMtQqAezkR+VA1tEUQ11IAXhKZj9dU6EVYlalozZp/
 7UoJx/mARBRnHCys7a8c7xUkjqRhOsQshlyrQkx1tX2FGZkgMcwrklN1sn5TkQL5T9q5IvXvTsd
 C
X-Google-Smtp-Source: AGHT+IFDDcOs6k8d34TgpM+nJdOdBuYqjwNunGoL5RFaLeRSkNaiT+FuCvPj04Z0+Hv8kd4muYtDjg==
X-Received: by 2002:a2e:9acd:0:b0:2ec:4aac:8fd8 with SMTP id
 38308e7fff4ca-2ec4aac9280mr16514161fa.1.1718957229703; 
 Fri, 21 Jun 2024 01:07:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c8e51sm961432f8f.93.2024.06.21.01.07.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 12/23] hw/sd/sdcard: Trace block offset in READ/WRITE data
 accesses
Date: Fri, 21 Jun 2024 10:05:43 +0200
Message-ID: <20240621080554.18986-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Useful to detect out of bound accesses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c         | 4 ++--
 hw/sd/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2586d15cbd..c6cc1bab11 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1868,7 +1868,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
 
     trace_sdcard_write_data(sd_proto(sd)->name,
                             sd->last_cmd_name,
-                            sd->current_cmd, value);
+                            sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -2024,7 +2024,7 @@ uint8_t sd_read_byte(SDState *sd)
 
     trace_sdcard_read_data(sd_proto(sd)->name,
                            sd->last_cmd_name,
-                           sd->current_cmd, io_len);
+                           sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
         ret = sd->data[sd->data_offset ++];
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 724365efc3..0eee98a646 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -52,8 +52,8 @@ sdcard_lock(void) ""
 sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
-sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t length) "%s %20s/ CMD%02d len %" PRIu32
+sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint32_t length) "%s %20s/ CMD%02d ofs %"PRIu32" len %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # pxa2xx_mmci.c
-- 
2.41.0


