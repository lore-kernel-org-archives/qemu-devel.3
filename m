Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DF9C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZhY-00015L-BC; Tue, 02 Jul 2024 05:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhN-00013k-3x
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:18 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhK-0006NH-HQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:16 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6fe81a5838so373974966b.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912072; x=1720516872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tcC9Y5NWB8z03lpw+6038sronrJ1UL/8sqiqucfx+g=;
 b=Ud2BNiOFIdpDOAG4pBHaguQ199Wx4x7NgK1eREkyW1oBVCtNJHvx4400Q/3S9KrYR1
 b+EQWh9+IlVQOZZSuQnefXCQ3o0utRHAZKhz1uEJDZQsnrjDQehThqZFbpwHOMarnFHo
 Q2U+zV9s0JhRKiSHPkA+qx6EeSYzpyf/whJrYcGFHU4jcwGPFG6f7nMpjy/kYskJMJL9
 q927LBelfEOnm3ENx2DzDMwUXBf0osXPyDiW2fqKFiECjYA9ibNMtUMmdJEoJh6VBfYw
 Y+IO8+4pgVSyruFqsEhnIwm9Li06nxbNjspo/C0GgY//pH9fDX0awYRPfnat5ieSfgAE
 44yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912072; x=1720516872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1tcC9Y5NWB8z03lpw+6038sronrJ1UL/8sqiqucfx+g=;
 b=xLuATznzid2rR4/wnhvVVsfW0drMC+ik8TFxFVHD9vmtlL15ozc1c963wvUhuIfMEF
 mDQCahWqIX+V6I30AP4jUbseuS6vSHFcryPKLBUgXCAppDGACI3LVg6m8ohUIqCBa3KL
 UMO4Tz0bEOo+T3vtLcdQvZk6Z3AXm5WEAPhDvjMG9GQOhwsURX8lNUhaoWyPsSxqnvmr
 Gir8xERsdrYrVqhZuS8Roo8AGuymgzOBFCwIUgrTcrTzvPAUiHqG71gsooG2g66taCyY
 8oszY7O+Cd/Y5zuhUM8g21TRHCfgNnc4BiY56f9gcd8A6D/jyi4jXWWFEz5MDiB+4s6h
 z54g==
X-Gm-Message-State: AOJu0YzTnAXjRWV4lAykM0VJ7PS3+sb2pHh48UqNTY6pA+XtmB95bmuk
 yp3D1fou+Idad/V2gf9JnVOzsNHtWBMFSnZhLzLDj8miZPYQUZauJ3k2Ubk40ddX10USC3BNTx4
 4
X-Google-Smtp-Source: AGHT+IGU/aJ6GrLp7nonzauh+bQHgQa5y5ziOOSJJVSf/Tjb/X8OrbFvDLhJ/fskfLFB8GTFJ3RhMA==
X-Received: by 2002:a17:906:a02:b0:a72:840d:9ecd with SMTP id
 a640c23a62f3a-a75145120ffmr465071966b.64.1719912071705; 
 Tue, 02 Jul 2024 02:21:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e16b3sm12563292f8f.61.2024.07.02.02.21.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/67] hw/sd/sdcard: Trace block offset in READ/WRITE data
 accesses
Date: Tue,  2 Jul 2024 11:19:46 +0200
Message-ID: <20240702092051.45754-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Useful to detect out of bound accesses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-5-philmd@linaro.org>
---
 hw/sd/sd.c         | 4 ++--
 hw/sd/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aa011fc892..bed5966ea7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1917,7 +1917,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
 
     trace_sdcard_write_data(sd_proto(sd)->name,
                             sd->last_cmd_name,
-                            sd->current_cmd, value);
+                            sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -2073,7 +2073,7 @@ uint8_t sd_read_byte(SDState *sd)
 
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


