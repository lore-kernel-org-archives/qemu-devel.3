Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BB7C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkUL-0005m0-CE; Mon, 08 Apr 2024 04:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkUJ-0005lg-UZ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:36:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkUH-0002lB-Tb
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:36:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e48d0a632so2309919a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712565380; x=1713170180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lxlzp3IlPActhEyj4Nxu8uqxhWQDk/wL/7CgsYIL7w=;
 b=PiM4tKI7wJalGJ3b6ykWrrhCOyOHGphuvgyDhM9aDitp9eA5WlZgVE2QCfcTXQIGN7
 Klc1Zytv9o7LFIpFwgg4tZVbVcfHY4YeJ3dOWGO71t5FAb4yJyc+nDqe0fHdCPU4lUvQ
 GSlNriDPu3VRveI4+kgjQ9xtg9mBWUj86vxw45ES8lOvNWm/caRi+PpBJuj84vuLKL8o
 VN/9RPmGGAC7J8IPDnAZfpGmaz/GM3oLdv/rqwprJVLitt8TNlm4AcqPNaXDy+2xA6PG
 NwyIas0rt9FVaPSTEacXLvUVye0ivQmChDy7kG28dp9LabJ5UDJlSeyRoQcbJQWAmF3C
 olFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712565380; x=1713170180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lxlzp3IlPActhEyj4Nxu8uqxhWQDk/wL/7CgsYIL7w=;
 b=p1WnDbub0sZtXTlyFsydLiupv0Mg0C06nBq5N8HDViTPBqNRxjuANMHf/Gmq6ZzunS
 SU8Xk1gBefQw3259GxzwGFdFK6+8sZ4gTZ+w3fv6kF1n0OfezQnKXPSiszZTmh8IzZLY
 NfUsUKuhBMZ6ZyCbZK2+VTml/fKvwBiS0ZZ86tRGedBNG5Q9oxaqqHK+Rt2Ydk8y+zvC
 nSiDZE4fYjFV+/goUtfStW8mgElXx8FLu4NIooY/y7v2wRqGykHGcgvKEW1Q3S4J3ISz
 QBvBn1bBOXKBKmFloR3v1Wj8EtO5dyVI+xfNjsd5VwGg/uP9tXi2wY+O/Fl3Gb3d5scY
 fxkw==
X-Gm-Message-State: AOJu0YxYO+hUpdpNf10D6q1GtDsUiDbH/sKFDzJj0eHfKcwRyGSDb/yL
 L0TFDJacj4MVeXBN2EYN49F6wFjYmjnmY+5WIxns0TajaqaAGzysvAed+g46aAgKC3OEdQ9x4ox
 0
X-Google-Smtp-Source: AGHT+IF5SSa4t5CZPDFTEYngdcUo5zdrT63q+f6E2IQ+acTieHYFXmFr4IDhgirj+i2GE2GNV/zVjw==
X-Received: by 2002:a17:907:94c7:b0:a51:d3da:99a9 with SMTP id
 dn7-20020a17090794c700b00a51d3da99a9mr2004574ejc.51.1712565380294; 
 Mon, 08 Apr 2024 01:36:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 js23-20020a170906ca9700b00a51c6d98777sm2125981ejb.58.2024.04.08.01.36.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 01:36:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 2/3] hw/block/nand: Have blk_load() return boolean
 indicating success
Date: Mon,  8 Apr 2024 10:36:04 +0200
Message-ID: <20240408083605.55238-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408083605.55238-1-philmd@linaro.org>
References: <20240408083605.55238-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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
 hw/block/nand.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index 6fa9038bb5..3627c799b5 100644
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
+    bool (*blk_load)(NANDFlashState *s, uint64_t addr, int offset);
 
     uint32_t ioaddr_vmstate;
 };
@@ -769,11 +773,11 @@ static void glue(nand_blk_erase_, NAND_PAGE_SIZE)(NANDFlashState *s)
     }
 }
 
-static void glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
+static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
                 uint64_t addr, int offset)
 {
     if (PAGE(addr) >= s->pages) {
-        return;
+        return false;
     }
 
     if (s->blk) {
@@ -801,6 +805,8 @@ static void glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
                         offset, NAND_PAGE_SIZE + OOB_SIZE - offset);
         s->ioaddr = s->io;
     }
+
+    return true;
 }
 
 static void glue(nand_init_, NAND_PAGE_SIZE)(NANDFlashState *s)
-- 
2.41.0


