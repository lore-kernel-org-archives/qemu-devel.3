Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFE3C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkm-0004Vl-Vp; Wed, 19 Aug 2026 23:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkL-0003mo-1E
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkJ-00049q-K9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso2283704b3a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197634; x=1787802434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y3jYg6CN2EN6XbjmWcdyGyDrijaVSsDsBzbN2Vh61c0=;
 b=hUF4bjYQaSVExfloYQKQt7jfNHhQD6EC4G4N60Xz4kMsRJ9I3FfCVk3iFTY8J4AbBv
 4OgzDGjN011q79sHMcQEySWMXoPWR1/nDxe2cOJGGECkQWwovbNWu6F5pSY3ML3c9+L9
 TvbUNwKIOOkVHwVqlflE9/oac0AJm/0WqwqRhd2mMBddFstv9OA72ZXWyLLK+Rm+TGvN
 D7h7Tjjb9j+VtHViSnaU+sNzQt2c3fDHXF0xswAz8Q19mr53VLsf2JDn2xg27sxc1kyw
 fTyBE1Y2mBwKMc/OVuQ+aFUxM4duZEVAC5ic8dtoT3xEjtGWpL1sr/nMs2G3i638E/Mk
 uiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197634; x=1787802434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y3jYg6CN2EN6XbjmWcdyGyDrijaVSsDsBzbN2Vh61c0=;
 b=iculV+uoSpqSXREL37nbpKfq8uxCWp7i+e0amMwnK6ZhJtBPiLlq53xWPl0tOMAEK7
 jUUvF4G255L9jcHqUjngcJ2/myWyYYePM2xWOEjkIXhGD6CEuJyKE9ATrgiwF69xG/Rw
 HiPL5326X7JzfiEMcuUnYMJjF8bQ/3zFpbBxqN0jq0zCebTNBHYIdbU40rkK7EZpClxE
 rP9M1sftCAjSdQ1hzaUM99jt99GXAkqPOhZOD/92JF9F9qOPK4ooIYIbjp/31k3/VscP
 lh8U6sqzhK7LFCv/O9MDiLj/X61ImgozZdMBbmRWD0iAAkrhKP8kjoekG5jgKHHlLhEq
 7Keg==
X-Gm-Message-State: AOJu0YzaYTCo9BBMXjBxaSTsZBmwjchFIeOz+c0QW2ZlLaoX/KN9ephn
 KmnAKAwrP7mkNWm9gWJYPUezr20EuHvzGT8eGGU4UGZ/EFfS6djqik5tEBSnow==
X-Gm-Gg: AR+sD12fJ06v/wRgNnPKLR45f+2M2Ll8hBUUL+U/WyKWaoQVboNKsCb2+JXqmbK4DK9
 ZNxntWr/RFWXoESuD0OFXsWr8q6AWr22sBzRZBcTcJy5V3JCea5wJi1IRtbcqu47fcamqklloZm
 Q5oHtxn9TAwJxA00uYNzMo3StGpymww/t02d1EMssHLL1gD3DyiSs7fnv7c8yrVT9YT36ojTfHD
 pNGIj4sKUSLdMesT3DHXi/z5N0opt1Ih2yiN10kcoTP3HQWooNUOZ9r0JQ1pYrl7KGdea5e/ezX
 GvwJR/dBaN74oCwF02kYQKIjxVJie7EFN7XSsY7S8DD7HgyvLR3nV7Ef2CuMi6m9oVeFd7/QCNn
 hxDkRDO03jhUbzsX2fHi8CYp/z17yz8jcxfwquJlm8LyVb59yvacukGv5m0drqWtI+RU3VQcP7h
 BMmMovNVYKUSfxXDIG11rfqmXSUolPETDX4/XHSYruzHZ4i+zsV6AWugV7NgaV51jfqu/UXXb/a
 cjKVA==
X-Received: by 2002:a05:6a20:9c12:b0:3cb:96dd:2477 with SMTP id
 adf61e73a8af0-3cd010879a0mr19187661637.8.1787197634116; 
 Wed, 19 Aug 2026 20:47:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 51/93] disas/riscv: Handle c.lui imm != 0 during decode
Date: Thu, 20 Aug 2026 13:43:48 +1000
Message-ID: <20260820034430.1186695-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-16-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7978ffb378..d6fbb3bca6 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1902,9 +1902,9 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
       rv_op_addi },
     { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
-      rv_op_addi, rv_op_addi, rvcd_imm_nz },
+      rv_op_addi, rv_op_addi },
     { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_op_lui, rv_op_lui,
-      rv_op_lui, rvcd_imm_nz },
+      rv_op_lui },
     { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli,
       rv_op_srli, rv_op_srli, rvcd_imm_nz },
     { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai,
@@ -3032,9 +3032,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     break;
                 }
             }
-            switch ((inst >> 7) & 0b11111) {
-            case 2: op = rv_op_c_addi16sp; break;
-            default: op = rv_op_c_lui; break;
+            if (inst & ((1 << 12) | (0x1f << 2))) {
+                switch ((inst >> 7) & 0b11111) {
+                case 2: op = rv_op_c_addi16sp; break;
+                default: op = rv_op_c_lui; break;
+                }
             }
             break;
         case 4:
-- 
2.54.0


