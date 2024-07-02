Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D274EC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZhe-00015k-Uz; Tue, 02 Jul 2024 05:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhR-00014Q-GR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:21 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhP-0006PP-PQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:21 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52e8cdc6a89so1784596e87.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912077; x=1720516877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQfrPXIVuGN0oE79GXpdgy4bI5RsbRBBNBkn9X4U1bk=;
 b=FNKx9hpylo872ESTWUhp+xvNhIA53R05exbCosIliovQ3FRqVF4MCkjOoxSV9zHjlH
 60gd2er+5KuilRgvYxAAtHB3JC2Wgp+RgkKWK2pYVtLI7pARleawAEoiaKgUPRI1y1v1
 LAwv30CBFBdZi5K4DWUIzzGXPEWP7XO4SSvGsTA2BEoyhdBRxPQPp/DwjLWwHi6s12YO
 rSxqSQB7IkQngiRzISFbcQB9U5btQhsUhl1qXd5wm4n8DY3/n1JRPx3f2nFYNvSJL86e
 zmLqKL4Kf6x9fMvbR6t9MCVq04GxSCf8fDWSatFFPdvUy2du/lDPHCwShqU9TMA7BRbr
 rFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912077; x=1720516877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQfrPXIVuGN0oE79GXpdgy4bI5RsbRBBNBkn9X4U1bk=;
 b=T66nwAErTHEZ3gCEaJbLIIrqsJzJEyNtDd7ZgsPG7CmZjFhQoA+Cc6yomjJW3HN7cm
 bbJ+m5yBzfOHhSwMSg7s51zcpcggE0pqJQnRRWGxI773NuOfsB3xyTxa16nyza0BOluD
 IqhyTbYkjuKJnzDebz6JodWtDLgV7YqcvhK0cA52JywYTCZuK7N1u5MJt1J7W7e3lgqQ
 Iax0JX7LIMHccEr6QsrJnyCFCKM2KSePzUCZCi4pAZ3EJqwyHlFLaGntKlg6Aru0dpaT
 Vt2gRZytqT9UH1jm3hZESh/gp/d2iWBmwvPK0vX6ClUsDAb/4+NO5DPYeKos6iLWxVhH
 DpgA==
X-Gm-Message-State: AOJu0YyEMMoahrOIs0fK13FH02CfCqWEt91S2SNvPC+c2M4I9mVJMfq5
 M/NloFrStegPOi9h3DCUl3Cx9+8WK7uWi0jqdT95zxlNcqM5CJ5oF72OoqDoYfBi5aJUgoF9RYt
 y
X-Google-Smtp-Source: AGHT+IGOxIw7ouZ79tIYf9ewE5M1amNlwXiC6EHNhyETStwMt9tPgTM3Q64Bm56JtxyOkAa4BBikrg==
X-Received: by 2002:a05:6512:3d1d:b0:52e:767a:ada3 with SMTP id
 2adb3069b0e04-52e8270ea83mr6302268e87.47.1719912077534; 
 Tue, 02 Jul 2024 02:21:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b065316sm186926295e9.26.2024.07.02.02.21.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Luc Michel <luc.michel@amd.com>
Subject: [PULL 04/67] hw/sd/sdcard: Trace requested address computed by
 sd_req_get_address()
Date: Tue,  2 Jul 2024 11:19:47 +0200
Message-ID: <20240702092051.45754-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-6-philmd@linaro.org>
---
 hw/sd/sd.c         | 9 +++++++--
 hw/sd/trace-events | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bed5966ea7..396185f240 100644
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


