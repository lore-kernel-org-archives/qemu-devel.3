Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BFFE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTY1-0008LL-35; Tue, 17 Dec 2024 04:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTXw-0008JI-8e
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTXu-0001Vl-1m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361c705434so36123935e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 01:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734426432; x=1735031232;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgz1qgb+0ot7sJafH3qy8LBWlENij8x++GlYvln+yRU=;
 b=0DoswRhmwAr5djGzSblm6Rwmn78VSDyr+sAUQ1FY7nwJkgFg3j6hfRauEhJzHoia/o
 BVSBRC6bnr8gsExfGz+5Dmm0iwYF++M5qnhF5cALS7PWE0Su9wj9WpWxURjwrCXT0PTE
 9aAGaDPhnYHaLVLZZqILkcZ2meHj9c6FhLK4Okhw2a+PWb0iP1yDWFg+wir4NLlsM5na
 w7pbzMjL1sV2jL0AF8v8NulCyoO9jcerW8OcfZSPIiM0nSD6fIZKNKHaWVwwiXCfgdVu
 k3a+B7DZBPt+Rx2JT404S3eb+GxwpMMgVWuxoypgqBZhzf0PLKOgBr9Ie2PE81VRcfl3
 vN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734426432; x=1735031232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgz1qgb+0ot7sJafH3qy8LBWlENij8x++GlYvln+yRU=;
 b=lCniLTVmkJlsQqPpdp1+ciMes7+0iDlaqwlR4sGUHMvZZ+u4lRPRbVrHiIgnvBmFEz
 pOeNGu+pRZh9mdeq6WC2o+WABGgypU64K+r7d1amRW5+ej2+/j0oyS3gRK8vkli6uTSp
 sSGlVzOe1GikIL5ex0d8UWgvR9OoTvA5TeTod0GKisy8meujkrC3dd7r1SsWOnAAY11A
 +5ffWKgu9LEw3XfwyDLWuKJGXFkDcD1Zk9P7LFtX6WoC071OwOapL5VgyX6MPMCqKUnW
 DK2KdWv3mnAdWHptITiaqJ59JjTxkYCtz+ABkXBaGaYZkv1xxLPfzPDJ0QhWke7+v89t
 F6wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9bRhn1VzPkNajUj3jQcrjB5LLh4c5d2QpUlxGN4MmOesVbu3+cRYXU+ukfG4U18qFjfiw0IywMPtY@nongnu.org
X-Gm-Message-State: AOJu0Ywo3WIFlxEM3UKmSruu+FK2+tBgoDwfQ2qjTEFbq+tjIXr7ANEL
 meWpHTP9odfnSMUNNbGgF/sbAmOEUdwiz65apBg/k9dRJJ2Yjb0klUu5Ej0Wf9Q=
X-Gm-Gg: ASbGncubbRjy2yJ+ch6sYCLEmpN0rPMJ4SvOGCs1uAZGbVVGb7gwehoODRZv9H/1gBA
 xhV5e9kyC8pWtIlilL81V1n7WLqZyQR5KDMO2YyG7+wldrmK5h1SjWedfNofd/qGdTrUUAXdyum
 aFV34L1K1OiZqkuMxwBnQpNhWtXuWj3ycLz99cBRnMnQ18MHjXXO7Y5pocOqq0mwSFbkXZ2oRet
 cW+j7z8kU11EvAE/5iwi0A+nyoyV6Hv8BgZ34ygrlPao9Ctcx+wRQ494w==
X-Google-Smtp-Source: AGHT+IFcfllM/MahhBjwEhe/vXbZOJOxgb4LjTTZlryaT5dvept5E+oQTucXy96ROzc17/BzOnkS2A==
X-Received: by 2002:a05:600c:5247:b0:431:5044:e388 with SMTP id
 5b1f17b1804b1-436476cd413mr19812255e9.22.1734426431816; 
 Tue, 17 Dec 2024 01:07:11 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046c46sm10704122f8f.71.2024.12.17.01.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 01:07:11 -0800 (PST)
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
Subject: [PATCH v7 1/9] target/riscv: Fix henvcfg potentially containing stale
 bits
Date: Tue, 17 Dec 2024 10:06:57 +0100
Message-ID: <20241217090707.3511160-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217090707.3511160-1-cleger@rivosinc.com>
References: <20241217090707.3511160-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32a.google.com
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
index 65daf6d138..c2cec37d28 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2383,6 +2383,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
@@ -2403,6 +2405,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
+    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
 
     return RISCV_EXCP_NONE;
 }
@@ -2414,6 +2417,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
@@ -2424,6 +2429,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
+    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
 
     return RISCV_EXCP_NONE;
 }
@@ -2517,7 +2523,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         }
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
+    env->henvcfg = val & mask;
 
     return RISCV_EXCP_NONE;
 }
@@ -2550,7 +2556,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (valh & mask);
+    env->henvcfg = (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.45.2


