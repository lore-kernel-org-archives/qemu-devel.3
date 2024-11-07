Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55982D29FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rFd-0006BU-80; Wed, 06 Nov 2024 20:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFR-0005xB-Jc
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:45 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFP-0003CX-Cy
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so3897475e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942622; x=1731547422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DIqtFDNKbWcFtV6kDPh5+cEk8GapRiCMoHMQdui5B4=;
 b=UD+kb1jFo2rYPBChAU716C1OJSU1iCMbZn4AxJF7S8p9pHZ+PWBcHJGyUK5RcqN7Jn
 zBSkOEf+4JsGgaP39lcG/Gsq4+8ZqTbee4SVM0WsBi7YD6GEC6C3NGNWfQ+TeuBiHKJr
 qfIAOQZquyXPeJNzpx4DPvWOn9FOG/EBcZuGFaNVV5j7R4dU7BcoqOFm9y1b4qyvHIng
 TJXd9C8QjEPVs8ZJXjIUUw0vl4XwbnrHGn6RX5vA2Oj7dPFN8n7ReerdshJQa2UVY69Q
 4sArj90fK9vJ+nZ478OKHcizZGV9RifjfCsJJpNjFMxcsXBVhNefFY3Evf9ra7UQg4RO
 aCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942622; x=1731547422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DIqtFDNKbWcFtV6kDPh5+cEk8GapRiCMoHMQdui5B4=;
 b=PyEjXCCdee8dqjrv9i6i4DBBTyC3SZuyr1Vqc7990lK3ODOe715Zlj7Ui5yk3uReRh
 N1YBp0vjyXrWWK0KzsoC3oZkMNTLvHUIfAYBcCcJWplXI2xlQwsuVnoCnZDkF8Cye9bj
 h8X4E1nyiTP9hSnXFVyB8BT6cc2YI7pwgdtQyBOZzE94x2TAAuBVCVOCqkGCb3SsDoat
 2fND7lRCGz3P0Wtjr6KnZpCao12yGJ4nh8CnDTj6iQnrVE3n6iRunxAGhdn3cHb65amH
 oCdpR/CkK3vMVS9LqyI5HZEfwCfOTtotsaOSiR7505rrcz7NkabZEQulUdHslrA7ALIB
 gJBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOUldQivcCuJbh6my+UmZXlHCwPf79G/s3bYuYIB/G4oIXQUFDUtaVge/zGEYqGv0IoeYbig2B8kV7@nongnu.org
X-Gm-Message-State: AOJu0Yw47VOxYNO1iHhkCdvI7Wa5W7ZOOhyqoDoZMV4LcxovcBZ07lYV
 EZgCtNyMWcSoCFOEq6c1fWgLFBHsj2ceKPGiL3S/89PUaIFowhUr5he3luhKAnE=
X-Google-Smtp-Source: AGHT+IFqQVOX0QXQUtvAo/aPSZVwGuGf/R1rAanN2Va4/kYCr+X5vqws/Aoae1EFTO8R/lryuU+4ZQ==
X-Received: by 2002:a05:600c:4e90:b0:431:7c78:b885 with SMTP id
 5b1f17b1804b1-432b14b8c40mr1462805e9.4.1730942621980; 
 Wed, 06 Nov 2024 17:23:41 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6c1205sm43977185e9.26.2024.11.06.17.23.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:23:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/16] target/microblaze: Introduce mo_endian() helper
Date: Thu,  7 Nov 2024 01:22:18 +0000
Message-ID: <20241107012223.94337-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

mo_endian() returns the target endianness, currently static.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 86f3c19618..0b466db694 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -707,12 +707,17 @@ static void record_unaligned_ess(DisasContext *dc, int rd,
 }
 #endif
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return MO_TE;
+}
+
 static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
                     int mem_index, bool rev)
 {
     MemOp size = mop & MO_SIZE;
 
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
 
     /*
      * When doing reverse accesses we need to do two things.
@@ -847,7 +852,8 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     /* lwx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_tl(addr, addr, ~3);
 
-    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TE | MO_UL);
+    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
+                        mo_endian(dc) | MO_UL);
     tcg_gen_mov_tl(cpu_res_addr, addr);
 
     if (arg->rd) {
@@ -864,7 +870,7 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 {
     MemOp size = mop & MO_SIZE;
 
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
 
     /*
      * When doing reverse accesses we need to do two things.
@@ -1018,7 +1024,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
 
     tcg_gen_atomic_cmpxchg_i32(tval, cpu_res_addr, cpu_res_val,
                                reg_for_write(dc, arg->rd),
-                               dc->mem_index, MO_TE | MO_UL);
+                               dc->mem_index, mo_endian(dc) | MO_UL);
 
     tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_fail);
 
-- 
2.45.2


