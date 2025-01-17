Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DEFC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNh-0001gZ-CP; Fri, 17 Jan 2025 00:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfN3-0008IT-RL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:22 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfN2-00069X-A5
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:17 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso30673175ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093495; x=1737698295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYMVpnYp7nv+x/zvlFZXRRFuTwuHsjFXahf0Mqp/AOI=;
 b=PT/PNbce3TsgpjQQ4+3mGisokYqmGAUL9l2dRhx1jUsXu2Z2yJfBd9ErLRh1wRU1qV
 Gsdumr5EiQljpV9w28yRAffgteoMZsJaVBu+AQJhH2Rp2mvQEhmV3hA+bD9/yEKQlY9p
 6C8kGCkyCeueUmjfrB7w5ELxsrz6t7SFSqgZmPOBvviSJuWI/E3tkOsxthYoXKuPjQ2E
 0EIm7OFI0XOsDuZxmld9XV9qxe7ecWP6BYCSSgFp3xsFyYrS1BM8JIFsIS6VvZWMAzXl
 HfVxUa0eBAM5dI16S0npIYsaVxRIHUriwyh9rMdQQ1jJ7eUOWsetxLLGNHehX1M0j/cP
 K5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093495; x=1737698295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYMVpnYp7nv+x/zvlFZXRRFuTwuHsjFXahf0Mqp/AOI=;
 b=sCnVEff3cXf7dZGxgk+cWgpRBzDyQAVlkbtmM0uJQ7UUC8mnT6gVBVogLqKEpfzS+2
 QzAHHtkWd8lzq8XMkUq3yhfoA3NCxZdqIRqUpUpPpymIfIGzLcKsSnu0mdpCXhgUYcrU
 J82V3ypCEKK4vx2lRXbscBt+WD0tpSGMVG+D9EXeHrzEXcjq6f+7GReo46UD3SIyR4JE
 upZjPPA1t6Wylw8tGbYKDyHMVWi/ZUE1nFdjZvp4ex69/8DSw9yUro7pr+lZ1GxcDvXJ
 /+YXvqJWVY8qq1EjEIjCor7Clnbhg1kq8UiUiewPCKDPXPCxDRGh/MbEhxn4e7Fdfi5L
 jtwQ==
X-Gm-Message-State: AOJu0YyGIC0Uyme8T3aztSc0ozVWwOPc2WtDmbNCOu0zgB/q6akP3aaV
 R8Bg34zyyRbE/EzVTy1K7LGGR0WegGK1p3cOBB93T4NZtYwntBHd4JKOhA==
X-Gm-Gg: ASbGncv0oNGcSt0HnVYKHWOkj9IPJ0jzi8+9aIDN5rnXfA9l63Epic0JJIKSvCedswB
 L1BBXdg6kpMX43U6J9xQHrtd0AZnBFZeqqByvipWKnB22/y662u0kN+k7j0OsP33SpnQ7pLmsbJ
 MyIGPnz7gFmaxd3IjoJhpeEndErjBusCISUMUv3589GiKZ0PO4UUvaNNlLu9Q8zcc+SZnYRozT2
 uhkQCNsiGjzbmtmWZldnfznlKAqnpZHxJ9K9rMkrQOyEnS3BdRcuEuyF01zsyA/AR4GJjRmhckD
 9En6SL2B9fDcJv2Tg8opUO8fE6eYFiWfeK0Jv4NoXC7laDgd+kTkCqd+Z5NP
X-Google-Smtp-Source: AGHT+IHxiFrarFbYW2Ur2oI46tG/2hV9nL5YD1GIJUEtDXPq6hYxeywvxMYhvTpP7vPGVbdp9wGW+w==
X-Received: by 2002:a17:902:ef11:b0:216:3dc5:1240 with SMTP id
 d9443c01a7336-21c355ef44bmr23048165ad.45.1737093494677; 
 Thu, 16 Jan 2025 21:58:14 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/50] target/riscv: Fix henvcfg potentially containing stale
 bits
Date: Fri, 17 Jan 2025 15:55:41 +1000
Message-ID: <20250117055552.108376-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Clément Léger <cleger@rivosinc.com>

With the current implementation, if we had the following scenario:
- Set bit x in menvcfg
- Set bit x in henvcfg
- Clear bit x in menvcfg
then, the internal variable env->henvcfg would still contain bit x due
to both a wrong menvcfg mask used in write_henvcfg() as well as a
missing update of henvcfg upon menvcfg update.
This can lead to some wrong interpretation of the context. In order to
update henvcfg upon menvcfg writing, call write_henvcfg() after writing
menvcfg. Clearing henvcfg upon writing the new value is also needed in
write_henvcfg() as well as clearing henvcfg upper part when writing it
with write_henvcfgh().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-2-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index eddcf5a5d0..279293b86d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2946,6 +2946,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
@@ -2974,6 +2976,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
+    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
 
     return RISCV_EXCP_NONE;
 }
@@ -2985,6 +2988,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
@@ -2996,6 +3001,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
+    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
 
     return RISCV_EXCP_NONE;
 }
@@ -3101,7 +3107,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         }
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
+    env->henvcfg = val & mask;
 
     return RISCV_EXCP_NONE;
 }
@@ -3134,7 +3140,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (valh & mask);
+    env->henvcfg = (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.47.1


