Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA68C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruC18-0006pl-CE; Tue, 09 Apr 2024 10:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruC15-0006of-Ih
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:00:03 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruC13-0004MJ-LK
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:00:03 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a5200afe39eso50871366b.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712671200; x=1713276000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJFermYqSA0aosSWDCha0MrZRxQ2GyvzS1k30TW2krI=;
 b=RgfmlaE0NmZ+/7DfXO1l1cdRaDBeviPpgP928t11AF2jSVUksiljDr1UnDP3ArCliS
 NES0qIoeU5h8qG3ZlLCoM+O1lmqlmJ8cNzMF7F0SROV7uj/Y5ZYaXLPD66qn+juCNjLV
 Jc8EuOV9hizg4HaO/eMtgBwTbgX/SUGVfZ1WYxUfEvgh3MiL4ClRh5Qr8wnL77Xvk296
 d5RCq2egSK7TUntn+93NUd+TcBjTsBFAfiWpxLFT7n5yEAXpRZQ0X999R3YO2Frde1h8
 CZYn1nTQ+ML4AhvKC22X+rFbaDskBLF+Qshf0Nu8qQ3CggWh6Dstv7Cd4A9HGPuKcNzW
 nrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712671200; x=1713276000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJFermYqSA0aosSWDCha0MrZRxQ2GyvzS1k30TW2krI=;
 b=pU3HjZeOuhVQnDvaimVR2YH2uj9Aeefwg59z+v9n3K7Tpmt2LxgBBhSmoToVnt4Yvo
 Bi3XGALoZCDX1eG4227/QqvchFoYeSNRI+3LR0jy7DuE0U/k8CC47/qvtXkd7bnerl9G
 uCsXJlcRJpVRvFurOHpBIpBtHbl+rCSfn1zZ6k+1mvxC+tDgNg/KeehEfaDhZwjugW23
 4Nd5B/35Bef+fyCeMhEgX/NTsomqfaq3sHxpee0Lq4S0O4vR9SjM1/4GNX/6BMfLAp3d
 3pCtkd7sziO4qPaLbcwtHCy/P4fRZA5friw2T0twtsEAVWZRUMryzi+XwJ21Vqrv8HDL
 UO4Q==
X-Gm-Message-State: AOJu0YwtVzxq3WpyoypOSpSNJ4GlsaEHzyZL9ioRbeDES57/bOd3uFnn
 oafIyqWw3Q7ExlXb1Rm3I2EVjAm888CIOuPYDaLsaJ2HE0vJjWLVs51eEcQMUeXTS2o2Kg23FKT
 U
X-Google-Smtp-Source: AGHT+IHCnVDVQsbjoKm9ozcRsNiJrBgDe4cmSrL6ET3sUXNoR52MjEeHe6oGvNUFBL3iCA31kNDY2w==
X-Received: by 2002:a17:906:4a81:b0:a4a:3663:2f51 with SMTP id
 x1-20020a1709064a8100b00a4a36632f51mr9269938eju.2.1712671199712; 
 Tue, 09 Apr 2024 06:59:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a1709067cd600b00a4739efd7cesm5772517ejp.60.2024.04.09.06.59.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:59:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Cc: Qiang Liu <cyruscyliu@gmail.com>, qemu-block@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-9.0 v2 2/3] hw/block/nand: Have blk_load() take unsigned
 offset and return boolean
Date: Tue,  9 Apr 2024 15:59:42 +0200
Message-ID: <20240409135944.24997-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409135944.24997-1-philmd@linaro.org>
References: <20240409135944.24997-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Negative offset is meaningless, use unsigned type.
Return a boolean value indicating success.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/nand.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index f33eb2d552..5a31d78b6b 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -84,7 +84,11 @@ struct NANDFlashState {
 
     void (*blk_write)(NANDFlashState *s);
     void (*blk_erase)(NANDFlashState *s);
-    void (*blk_load)(NANDFlashState *s, uint64_t addr, int offset);
+    /*
+     * Returns %true when block containing (@addr + @offset) is
+     * successfully loaded, otherwise %false.
+     */
+    bool (*blk_load)(NANDFlashState *s, uint64_t addr, unsigned offset);
 
     uint32_t ioaddr_vmstate;
 };
@@ -772,11 +776,11 @@ static void glue(nand_blk_erase_, NAND_PAGE_SIZE)(NANDFlashState *s)
     }
 }
 
-static void glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
-                uint64_t addr, int offset)
+static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
+                                                 uint64_t addr, unsigned offset)
 {
     if (PAGE(addr) >= s->pages) {
-        return;
+        return false;
     }
 
     if (s->blk) {
@@ -804,6 +808,8 @@ static void glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
                         offset, NAND_PAGE_SIZE + OOB_SIZE - offset);
         s->ioaddr = s->io;
     }
+
+    return true;
 }
 
 static void glue(nand_init_, NAND_PAGE_SIZE)(NANDFlashState *s)
-- 
2.41.0


