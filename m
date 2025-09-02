Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60343CA100C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQor-0006Ad-Cw; Tue, 02 Sep 2025 09:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQob-0005ZW-7L
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoW-0004fV-UM
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b7ebe667cso34871755e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818761; x=1757423561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ydrW5bZ2XLFJIZV0r30kceaHkdWCHYqtutYU/gk76cY=;
 b=QYZjemtocAUCcE9M0lHCwJ9M7u+kcqgQW3tWLNSXfYnbiGq6/u+Eauq4h0vPOv7Oqo
 DThQLx0leIUCjB6IvB+uxR4KX6sBMtVNM72lfJad9y9YA9VGnMUZmdK6dImPup1xn9Tx
 Bs3kElBARr1ZQBk9iBxsnMY896+QZPAWQjIdl90M8hF3cjxQuz6qXgN2xjUZoEv8LRpX
 YRYRpEO7mnBAs/WBb8IfDtoYw1wz+lK9DaSvGBAbck65Cxl5hw/NBfxklqgGj3MT82tJ
 rrAwVMiy1jTDntpPeORgHm9LCx6Onl+84P/0EUsfeSSAxYwx4kr6UxByVxN4dlkmc4jc
 mCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818761; x=1757423561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydrW5bZ2XLFJIZV0r30kceaHkdWCHYqtutYU/gk76cY=;
 b=JTdgCWMpE6Ix8DIDewvuPfo336+K9i2lCBqp7b5bm5V4WbjoQUezGkTuRdZf7oCxwX
 RNec5s4/WVpAq1JMigLBQB3gxta9xpAwNjbT+QJG//hfPJ+iTtumkF56HYtjPEr3Fut1
 uhDTqj0AV0lQFl/jkqvuafUwOt71E8wMFoSHXkZUdmOyyZEX03yRsOKrp6CWjozuWRYA
 HfE+DfPiy8yBz+SNGbxrfxvQpBeqQJ/HZ9fIUiCSOftEHcHowpakjGoF9In8tuKxbbRB
 748m+a1h5ibsjn//RrICT9kaCC7WXrQ26lqC/HnqixR6RaBz5MwiLRxEvJpFRKP2bbsL
 j8lQ==
X-Gm-Message-State: AOJu0YwBd9Gm4jCMuMJUcjmCYmC73YjuPEfAsGeBSswwSgp4mU/w/w+s
 3bgv2eXGx6kyFKoVYXKequDWQuhXlFMy/NVvGyrP4V89mkcRZm7K5mytkc16TcXtlducTBjJJKx
 bLPjo
X-Gm-Gg: ASbGncum0Fku+98UFUBsBk7YzumkW9qYmJkAcdNLUEJyXVq8sdzj4mtedExzTyf/IAG
 E7LeOK4uXVqCoXOvS6aniO8AOl5hbuDkDJgZg/RABQ941VmykoQFSQCzHB/Dc+V9/iM4ZJJv7Cb
 8XJL0fW8kytEaEUKx44U6h/Yt+EytHu4fGAqSUldwtGWY6r6ZhTjgG27+nWlntcQgxS9vSxPUWW
 /+TNeyKjBeYynkuHaJ3cpFg5XHPpbC8lEdfzyaxm6CRqhoz9BjcbPqIr9GZ0+PdE/8gqJLrEj8W
 bfVzvvkIDA8oCUwQAUcYwlkjmBpHZ9E/zdAIn+4Jw/GrmiDwAoRsyJyfslWtdOXaBfx3SeHiCdL
 7kU0Ub/T+Uqlu3ErWlQWut4vxecLrFs4+yu4ZpCk7b5Q1ch2TDKt96T3YvmKCPRHW9ddYmoEG
X-Google-Smtp-Source: AGHT+IFAkFuUCQUquUqLOOGC44BcVdPda73TtvpFPYQRdbMBa2YjF4JG6eH2Y9cW9uTW8dc7DKXF2Q==
X-Received: by 2002:a05:600c:a47:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-45b8557ca38mr81715915e9.29.1756818761280; 
 Tue, 02 Sep 2025 06:12:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d23b7sm197333265e9.1.2025.09.02.06.12.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/39] hw/sd/sdcard: Refactor sd_bootpart_offset
Date: Tue,  2 Sep 2025 15:10:08 +0200
Message-ID: <20250902131016.84968-32-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This function provides the offset for any partition in the block image,
not only the boot partitions, therefore rename it. Align the constant
names with the numbering scheme in the standard and use constants for
both boot partitions for consistency reasons. There is also no reason to
return early if boot_part_size is zero because the existing code will
provide the right value in that case as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <66e9b07476aad61820c4f42f4f984cc90752ba5e.1756706188.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdmmc-internal.h |  3 ++-
 hw/sd/sd.c             | 16 ++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index 91eb5b6b2fc..ce6bc4e6ec4 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -116,7 +116,8 @@ DECLARE_OBJ_CHECKERS(SDState, SDCardClass, SDMMC_COMMON, TYPE_SDMMC_COMMON)
 
 #define EXT_CSD_PART_CONFIG_ACC_MASK            (0x7)
 #define EXT_CSD_PART_CONFIG_ACC_DEFAULT         (0x0)
-#define EXT_CSD_PART_CONFIG_ACC_BOOT0           (0x1)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT1           (0x1)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT2           (0x2)
 
 #define EXT_CSD_PART_CONFIG_EN_MASK             (0x7 << 3)
 #define EXT_CSD_PART_CONFIG_EN_BOOT0            (0x1 << 3)
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 94ec58a83e1..2d34781fe47 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -833,14 +833,14 @@ static uint32_t sd_blk_len(SDState *sd)
 
 /*
  * This requires a disk image that has two boot partitions inserted at the
- * beginning of it. The size of the boot partitions is the "boot-size"
- * property.
+ * beginning of it, followed by an RPMB partition. The size of the boot
+ * partitions is the "boot-partition-size" property.
  */
-static uint32_t sd_bootpart_offset(SDState *sd)
+static uint32_t sd_part_offset(SDState *sd)
 {
     unsigned partition_access;
 
-    if (!sd->boot_part_size || !sd_is_emmc(sd)) {
+    if (!sd_is_emmc(sd)) {
         return 0;
     }
 
@@ -849,9 +849,9 @@ static uint32_t sd_bootpart_offset(SDState *sd)
     switch (partition_access) {
     case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
         return sd->boot_part_size * 2;
-    case EXT_CSD_PART_CONFIG_ACC_BOOT0:
+    case EXT_CSD_PART_CONFIG_ACC_BOOT1:
         return 0;
-    case EXT_CSD_PART_CONFIG_ACC_BOOT0 + 1:
+    case EXT_CSD_PART_CONFIG_ACC_BOOT2:
         return sd->boot_part_size * 1;
     default:
          g_assert_not_reached();
@@ -1052,7 +1052,7 @@ static const VMStateDescription sd_vmstate = {
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
-    addr += sd_bootpart_offset(sd);
+    addr += sd_part_offset(sd);
     if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
@@ -1061,7 +1061,7 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_write_block(addr, len);
-    addr += sd_bootpart_offset(sd);
+    addr += sd_part_offset(sd);
     if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
         fprintf(stderr, "sd_blk_write: write error on host side\n");
     }
-- 
2.51.0


