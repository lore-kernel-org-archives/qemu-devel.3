Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835DAC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrpI-0000DC-Ik; Mon, 19 May 2025 00:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGro8-000749-Nv
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:08:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGro6-0004HV-Uq
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:08:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23198fcdeb0so34432445ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627733; x=1748232533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bla8g+U6Fu/GyWaUtIRMYDNw5MNMh+RuvFK1htVI4VU=;
 b=D9bToCUHS+Vi3Z/Hr0gfKPQ0BLvdSL8F9Jp3ONKNjJSSl14QXJEVmk/RTBuM8JY5ND
 G+q9fOhGCQNy0jKXhf4FS0/P4PAO87cce8wHVd5/1nDHeXSOhRhCJPU7wljKptqImd9R
 r71dVT21X9HEAkcjI4xUMD4cU7VfvrbBCS27LuN1km+kCTsMJEzQgKf608v87+uXXiQm
 1y0Air0ckoRmx+Xf0PG80jYgz5j5hVopZgm6ivomsxyyky+iea1rGOtB/+wESBEmy0uv
 5NviKhytqxVDWtLcRIqN4KuR3o/l8+VDyDAuIOTNrvW+ya7zNLArsM/a36D7MV++rHyq
 YNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627733; x=1748232533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bla8g+U6Fu/GyWaUtIRMYDNw5MNMh+RuvFK1htVI4VU=;
 b=w1yFgAYLlKG/A0zRn72y/mftTxwZdwqFqpB+3y9xIyhMG1o1hfC09mHQimuLRepSMQ
 k1xYm7PATKAswhnSfh3e/XF91ZCknpX6R5PTBnH2b4FXe9prtLubBBqJClGvZq9NcOc1
 rjiPuFEoDT0+G+UkvAGMO0HmKY7pJBP2lupDwsesotmxZ4TaZxvVrHe9MzLnGX3GTr2T
 hnnSmfR+g0sJWgU/4juGHZ/aYLBhBws6F03Uu+XC22D2ehKm87P5ZaggaldkISQJlbIV
 sv0AL7kI89lIYYX2U6bGdY3g0jk8uqJBXt0ZewKchnOEgb4YLLFo0mWA+Afic1mn+QKL
 umjA==
X-Gm-Message-State: AOJu0Yw2eXFGOiTtlalkpbD+AF4RkOgaEAXZRKLBxpYMEywA79XUVWRk
 UgSAuS9O8Yqdmxax5az+u8Gk0SjAa0S3R7lxIJkLzkfZW+8s3IK0ogYe5TbBKg==
X-Gm-Gg: ASbGncvX1IiKBSlefn1UOJaBfqpnLWoQ/67CSrk4G6o1Spk9T5zOCQubXFDMjW2YEmq
 vXW7HYFBfCvRzafLitiv4jiUbuzH5zxs2s6VDd3aCJ1mP5GzX6am50tZ7bnC/4CDXbhkZOmb6E3
 Jr3Ig+UvPi+4eKLl3YWzrie17f7iINtzedMkhHtk89qBXcTeQNVknmm9DtaSPEQ+7bMXsuYPcwy
 unvai2kuhx2kiZvtoi5PCK8I2IzLLLDlBnDO/IBPbXERkAGBtE6AcctNc2VZ74xiFrf5k5S3Emp
 HPpZSy1fkCTdv8DpQkAZ6NprIsYyXL0bpZDVXyaccfdfqHjN8qEYhSLXiH7ZvTkTAI3d4r8YOCu
 pV80jPUz+kSZYqAZXwrd+XSdkS/UaJMak5pDBLzB6l5bdmGrRr6ajDYYI
X-Google-Smtp-Source: AGHT+IHYWinVZezvoeuoHrzQOiXRhCm2dBjnDTmR+xNUKTK59dQYdr5tiUrFzOE6NLTxvC+E52AejQ==
X-Received: by 2002:a17:903:2bcb:b0:215:b75f:a1cb with SMTP id
 d9443c01a7336-231d43d99bamr161657375ad.9.1747627733211; 
 Sun, 18 May 2025 21:08:53 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/56] target/riscv: Pass ra to riscv_csrrw_do64
Date: Mon, 19 May 2025 14:05:30 +1000
Message-ID: <20250519040555.3797167-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250425152311.804338-3-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ba7620ef3d..22149bd3fc 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5516,7 +5516,8 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
 static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
                                        target_ulong *ret_value,
                                        target_ulong new_value,
-                                       target_ulong write_mask)
+                                       target_ulong write_mask,
+                                       uintptr_t ra)
 {
     RISCVException ret;
     target_ulong old_value = 0;
@@ -5546,7 +5547,7 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
     if (write_mask) {
         new_value = (old_value & ~write_mask) | (new_value & write_mask);
         if (csr_ops[csrno].write) {
-            ret = csr_ops[csrno].write(env, csrno, new_value, 0);
+            ret = csr_ops[csrno].write(env, csrno, new_value, ra);
             if (ret != RISCV_EXCP_NONE) {
                 return ret;
             }
@@ -5569,7 +5570,7 @@ RISCVException riscv_csrr(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0);
+    return riscv_csrrw_do64(env, csrno, ret_value, 0, 0, 0);
 }
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
@@ -5581,7 +5582,7 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask);
+    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask, 0);
 }
 
 static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
@@ -5647,9 +5648,7 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
      * accesses
      */
     target_ulong old_value;
-    ret = riscv_csrrw_do64(env, csrno, &old_value,
-                           (target_ulong)0,
-                           (target_ulong)0);
+    ret = riscv_csrrw_do64(env, csrno, &old_value, 0, 0, 0);
     if (ret == RISCV_EXCP_NONE && ret_value) {
         *ret_value = int128_make64(old_value);
     }
@@ -5681,7 +5680,7 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
     target_ulong old_value;
     ret = riscv_csrrw_do64(env, csrno, &old_value,
                            int128_getlo(new_value),
-                           int128_getlo(write_mask));
+                           int128_getlo(write_mask), 0);
     if (ret == RISCV_EXCP_NONE && ret_value) {
         *ret_value = int128_make64(old_value);
     }
-- 
2.49.0


