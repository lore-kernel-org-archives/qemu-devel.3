Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29141C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrul-0004Sf-11; Thu, 27 Jun 2024 12:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMruc-000491-MP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:23:55 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMruX-0007mp-Ua
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:23:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-362f62ae4c5so1240577f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505427; x=1720110227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IVH6b/MHuau58htKVq2uNBSYst/d06FDWZAuadlm1c=;
 b=GFOnLwS/ZJHMwEohwVxs98qQPyqcQwstszY1tpzNUowY7VfzvmsO/JyUu1mPIk7x3W
 daSxS19Cq383cpTAijFiyaq4EuhWov66QPt0umJ21rhtd+N3o4QkJOac76KRsmMwOSqf
 lsu9Sm37znWURt0g1TMletrSb0VTl/TkSHBvxY/91QZ9V+kG66cGQP4L19n8BZVmWV0O
 dQEKbPPyFGp8ONfr6JN63TDbat9r0RJHZLqKLqXVtTRcC7xw+1FV8IvfaM+9KVnnbbUo
 /JNh+r4tXGlCDURO/F/t2c6ddFo9MJSiBRNYU15nsFK2ocXTavWMFX/2DyRG9yCzOqzb
 IE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505427; x=1720110227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IVH6b/MHuau58htKVq2uNBSYst/d06FDWZAuadlm1c=;
 b=ujba82oXaWvUP7f1JpAc5eAR92euc3/zpF4gGli8MZc8MrpKUn9E1MxJUDqADQFdJ6
 NZwrrfkWBcBwlwA6fstBxXBgotWjyZrCCF0/h0zyRSaZUqIT48PvHxgfb/hwjqXOCR7M
 tRh5V4fi4PZoeWIoDaAp+QQ2YYvZ7mbwGfAPWMrm21rFuKdVGtMUkm6OcjLsw/1DrzNS
 Uc4F7PHb7J/js1n5gtex5RS0C4NF2e+ZcbDXoXybb2FkO9fRW+PvihJUi1cTivTGzHIb
 USYnknAGAbroTV+5LAD33Ff6vEe18gSOKvTM4osRwx5QYW8yqx5SFbHf+ZcW1tmt7ZD6
 cpLA==
X-Gm-Message-State: AOJu0YwMM5fouyG+UDUeQCkOpOnl5Mr200ImGLHsAEwZONq9PAu8btCy
 wFt88joXnq/RMCl0++aCl8IspKAiG89ObokGYC3NjGlG5rw2rgNCQ8BqEbtJosG1sfpmHSYo8Tj
 gTJo=
X-Google-Smtp-Source: AGHT+IHPf33j7/MJk6Oe0qdp1T4UWowEpBvgcsNTSMEDSV+0bQnQOVrymIgqw/L8L0dGjrgwh++HAw==
X-Received: by 2002:adf:e54d:0:b0:366:e09c:56be with SMTP id
 ffacd0b85a97d-3674176ccbcmr2419507f8f.6.1719505427253; 
 Thu, 27 Jun 2024 09:23:47 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436997a8sm2371409f8f.81.2024.06.27.09.23.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:23:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>
Subject: [PATCH v3 05/17] hw/sd/sdcard: Trace requested address computed by
 sd_req_get_address()
Date: Thu, 27 Jun 2024 18:22:20 +0200
Message-ID: <20240627162232.80428-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c         | 9 +++++++--
 hw/sd/trace-events | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 090a6fdcdb..464576751a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -608,10 +608,15 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
 
 static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
 {
+    uint64_t addr;
+
     if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
-        return (uint64_t) req.arg << HWBLOCK_SHIFT;
+        addr = (uint64_t) req.arg << HWBLOCK_SHIFT;
+    } else {
+        addr = req.arg;
     }
-    return req.arg;
+    trace_sdcard_req_addr(req.arg, addr);
+    return addr;
 }
 
 static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 0eee98a646..43eaeba149 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -50,6 +50,7 @@ sdcard_ejected(void) ""
 sdcard_erase(uint32_t first, uint32_t last) "addr first 0x%" PRIx32" last 0x%" PRIx32
 sdcard_lock(void) ""
 sdcard_unlock(void) ""
+sdcard_req_addr(uint32_t req_arg, uint64_t addr) "req 0x%" PRIx32 " addr 0x%" PRIx64
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
-- 
2.41.0


