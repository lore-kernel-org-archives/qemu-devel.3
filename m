Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5B3E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEY4-0004TV-8L; Fri, 10 Jan 2025 07:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXT-00049C-M2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:55:00 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXP-0000ya-LD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:54:58 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so1193914f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736513693; x=1737118493;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgHUvqU6GWN9Ix2AskIh91fh+T6XRSITDIwDhxfjXYg=;
 b=VOqmPBkglQr1XEKj/eW/kiHuHobzNyJ+3vGnWFiu0peHzuiwaQdlyk8xivQK761IlO
 /7Swzj5epKRHrgx/T8ZcCeZUNymaEAg/xubjZ1CVnyuBzLmiYJ6AXMkxDTC79mh19rhX
 9ijEO0KIVBpRCRLC2xHT+/gLkk2tKQCqjrtgyasdz7nDRxyqnzdrFKrBtKFCo53BYQHF
 zSq61Ze0iofb89YwolSR78f65KeWTo+rM3/dHYNZ+Q3KbVbvIRHfZ89D4tP6+D67HHUy
 bmFqj69Hin9pYUMURNv0gdMQ46RT02LZ7LfTHMKZLWThyXZxOUO4K6Wv8u2Dr7WqCsQW
 31JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513693; x=1737118493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgHUvqU6GWN9Ix2AskIh91fh+T6XRSITDIwDhxfjXYg=;
 b=qaXCuTKQPQ6f79Rxk0X4Xm+NFXjazsuQvglZxR9XpwuYhru07/cvfUANZxPb8Z2ArO
 2Cpd6JqjBOn+ezasXIphLzc+YpM3V20maK8BN/738MpXbGIJtNiXRyi5TrgfPN6IFJZr
 MCZBdL2iUBBo2w3yKUHlHLcJTDuQbK0x6ZqkcVJA4ABgzHrF4ZIOmEkv9E6MNqDNVWfM
 HT1frRprChzSsrHYPs4rG2xRaP8zm7nIzNwMre0SRIcNEkur3yBPWcioZn+yXHET/eU7
 QGIHQj5ZrLhDKRmO+Ke7nprPBsTe15gGliuWH9euXvfqQPgWfp6WP15JoiTKlTdPogIk
 E5lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOtGl1NevI5xizXT6ow+0SgaakoZB8T5qVyA+MP1mLqzJix+c3xyJPEsTEIQUveqG3b9Es1LMEA8n9@nongnu.org
X-Gm-Message-State: AOJu0YzCndngoAGW3h3tPm3b3QwH5c+PfIapEGmDqgG22/yUfVu5nPEt
 n2w9SlrCR6/cwFw0FTKQWXGhCztBzCtgqgtrOouZX926zTGDn7CzSzvC8QulgQw=
X-Gm-Gg: ASbGnctmWBu4qeYyy7qqh9fbdhyPJxkHJBAo3cN+zrmzHQOYx6Sc+z9UGTAlymXgLh7
 uSrIpFJQwbpAjjx5fN6q6qx5TeX6BiOu5jgEwyTxV10URJDKzx/CXJm8auZzyE9HzJxynANeMCR
 NT2obCIGwbaGZK80AzvlFA0pbSAX/LLAF4F/ConhRTNOLAC5Nt0eexvNghusyKE1l67G6y15gcd
 GNZPpQMe2KWCee2VndWQizNMbweSjnwb2JQpSlFfAoWWtYUVZD3tPT8Bg==
X-Google-Smtp-Source: AGHT+IF6lmoR05kEtXtgFW+twu5IayZgr8/uJKQtjy9TD0gZYw2Y+6+vhmzzf9xyxnfzLYQiMPS4Pg==
X-Received: by 2002:a05:6000:490e:b0:386:32cb:4aa with SMTP id
 ffacd0b85a97d-38a8730ef59mr10362844f8f.45.1736513692954; 
 Fri, 10 Jan 2025 04:54:52 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm4548921f8f.97.2025.01.10.04.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 04:54:51 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 1/9] target/riscv: Fix henvcfg potentially containing stale
 bits
Date: Fri, 10 Jan 2025 13:54:32 +0100
Message-ID: <20250110125441.3208676-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110125441.3208676-1-cleger@rivosinc.com>
References: <20250110125441.3208676-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


