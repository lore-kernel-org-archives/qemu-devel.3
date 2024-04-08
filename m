Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE73CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkUI-0005ks-M4; Mon, 08 Apr 2024 04:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkUG-0005kV-4q
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:36:20 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkUC-0002kX-D6
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:36:17 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a51c6e91793so189029766b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712565374; x=1713170174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6BQV7fTkLyG6qLOnaR99Tjx9wX3tBZOaYxcFxZPlB4=;
 b=kMKPzEyUD/F0sbYq/nQ82zPTsTn7vQ81d+XVIqLKRNOVuEG6Q6cCJcGasr/rARUQcs
 VDySXTWgEtPxeBAHb2Sci16CH/x2yjEcK1kCUBeJhMwZY3cL2JVdrZMutsu+D1s3aoth
 Igi49chemjMhA2glyL52lho4KhvrfjdDnDHOLs+HLaDyt1XSnOz5NU7rUNNe9k9Rh8iH
 1xYL2BAO8v1Xz8y0+Fu2NVaR6MNMfFg0nVRsRvfZG19BmmLevMRlibts2ZeJeBuPWDCW
 enyBcUc//EAaj8IqZxYbajadKFAAa9wxscG9dSI57SPN622NkN0Z+EhSruzjgyXejduH
 qGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712565374; x=1713170174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6BQV7fTkLyG6qLOnaR99Tjx9wX3tBZOaYxcFxZPlB4=;
 b=gSBTT++mvBNP1a8T63otJ/HpXo7Ad7NvMd6xHtF3eWv/j6KwfKsgv7zBkhfBuYgyVB
 07QPn7u/VkGLwyPl4HLgofJxsNxjU5zlZf6pLEXqf6RhPbjE56m+3KRXYTtc4Y5oA6Z5
 mdFAeQ0KkWdSnAqtdBjnbCYk+iKNEAheda+hVfqIzlAsJWv8hHCOYmu/bfdiRJHumy9s
 lT2rbb3xogfwPw4J2jO7DH7L/J7W1cBZZXGWLTFdlcjEx4EK2qBvLtCpg6pCg4kNScDS
 d4ArFjoxkSwoS2qDPMFpJrkKVRsS+VlOgmk+J+PgS0I4Hd5j4fZAMK60Z1BsDR0S6gRV
 9FdQ==
X-Gm-Message-State: AOJu0YycEkxeF+Fl9l6GKwBTSyLATRMLwqTyiXSVY8V8CyTSSnbm5qBn
 ukJ1Lqw0CUEAeGoSFItobgsMG4UanC11Mll5xSCd/MBmhB2vM6aEKhencLjxYjSuclBmsAYCfF4
 v
X-Google-Smtp-Source: AGHT+IFZzJWTVKKw/ve7ikXpCJDTHP9hLp5EDKt5VVZPoTGhoKqAbeb5rS/mFN+gmXTTTD2AtZOoYQ==
X-Received: by 2002:a17:906:bc46:b0:a51:9e23:dc44 with SMTP id
 s6-20020a170906bc4600b00a519e23dc44mr7328386ejv.31.1712565374465; 
 Mon, 08 Apr 2024 01:36:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 md16-20020a170906ae9000b00a51e004de4asm256150ejb.11.2024.04.08.01.36.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 01:36:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 1/3] hw/block/nand: Factor nand_load_iolen() method
 out
Date: Mon,  8 Apr 2024 10:36:03 +0200
Message-ID: <20240408083605.55238-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408083605.55238-1-philmd@linaro.org>
References: <20240408083605.55238-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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
 hw/block/nand.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index d1435f2207..6fa9038bb5 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -243,9 +243,25 @@ static inline void nand_pushio_byte(NANDFlashState *s, uint8_t value)
     }
 }
 
+/*
+ * nand_load_block: Load block containing (s->addr + @offset).
+ * Returns length of data available at @offset in this block.
+ */
+static int nand_load_block(NANDFlashState *s, int offset)
+{
+    int iolen;
+
+    s->blk_load(s, s->addr, offset);
+
+    iolen = (1 << s->page_shift) - offset;
+    if (s->gnd) {
+        iolen += 1 << s->oob_shift;
+    }
+    return iolen;
+}
+
 static void nand_command(NANDFlashState *s)
 {
-    unsigned int offset;
     switch (s->cmd) {
     case NAND_CMD_READ0:
         s->iolen = 0;
@@ -271,12 +287,7 @@ static void nand_command(NANDFlashState *s)
     case NAND_CMD_NOSERIALREAD2:
         if (!(nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP))
             break;
-        offset = s->addr & ((1 << s->addr_shift) - 1);
-        s->blk_load(s, s->addr, offset);
-        if (s->gnd)
-            s->iolen = (1 << s->page_shift) - offset;
-        else
-            s->iolen = (1 << s->page_shift) + (1 << s->oob_shift) - offset;
+        s->iolen = nand_load_block(s, s->addr & ((1 << s->addr_shift) - 1));
         break;
 
     case NAND_CMD_RESET:
@@ -597,12 +608,7 @@ uint32_t nand_getio(DeviceState *dev)
     if (!s->iolen && s->cmd == NAND_CMD_READ0) {
         offset = (int) (s->addr & ((1 << s->addr_shift) - 1)) + s->offset;
         s->offset = 0;
-
-        s->blk_load(s, s->addr, offset);
-        if (s->gnd)
-            s->iolen = (1 << s->page_shift) - offset;
-        else
-            s->iolen = (1 << s->page_shift) + (1 << s->oob_shift) - offset;
+        s->iolen = nand_load_block(s, offset);
     }
 
     if (s->ce || s->iolen <= 0) {
-- 
2.41.0


