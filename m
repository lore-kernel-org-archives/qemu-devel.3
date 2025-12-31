Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34751EE57D1
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 04:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaoA3-0001GL-US; Tue, 30 Dec 2025 23:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaoA1-0001Fg-W0
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 23:50:14 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaoA0-0004JV-GO
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 23:50:13 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b852bb31d9so12493118b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 20:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767156610; x=1767761410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V12W2O5nWe7i12e7QAmIABN3jxjhBqvfu0RJspjthKI=;
 b=CUd4nfGVN1QlBEMK7sCR3AbS0XgMjpT58DAHBd8guMCTrDL/+PwVASZPd9O1xgIcGL
 YMHbtUVSrOZnDo/FOBpynQkoEY3K2CM+GLU4A/LjqSAU09JVRsFI5gXirIzelI6a8PhS
 dMkQqiaxmK9PXkpg5V5dXxrLWPuvNXTyiuuq7BxGIT2AkMW5FZTPBok0XZbNOjzqp4BM
 XmgO52K998VO/8JFY1O1tZ0jmQA4htcvuU5YKPxxqpzL5htGDg+kYTwwqyORZn8dU/C9
 t3dXM/32OHjy9cxi8UyIvt6Nrby1NlwIG2mKz4cVmOJmso9dSfCSGkwvG7iAKurMX96R
 MGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767156610; x=1767761410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V12W2O5nWe7i12e7QAmIABN3jxjhBqvfu0RJspjthKI=;
 b=uuEqkrG+Dg00A+SWoN0n7Hj26VoAI9lj1PTwZi+/ZdW8FE5Kpyq3/zPHcIFsRJWjzp
 lJwIc2eOcZHpg31IPogghcKKdFaT8ukPnZQfxOuoz85TdXpCAqKXVuDN5qQfzjRqXUBu
 8ocT1aFO5xRZb1DwIBqljT4Qo6Eh3byMOoSZoUdplOCpu4kPy7Ym4qSsydcGT5Eo/OY0
 KEPZzbXlmQKybVZE2LL7LKivirxV7sCJLhyUKSuur6hHVImccfFKMvfhx/VCGC7IClXv
 hSrHQlBK6yBkuLedzdXYiclJNueN+gdJK0FtOHSuU3PgcCyFCx8ZOoFSvrYSZ6HaaD9n
 sHOw==
X-Gm-Message-State: AOJu0YzN3EAXtznD/uO50uaumX4CODWQNPsGedA87es8O1u+eSftkEdR
 klqCBESNh+A24NKvPXSJ2Sl5mIEPO0C3viaHsxsAxTFUXoG6Jq+oiaEGs+yvyjCKTwUgYXsDXfF
 EFSk3D2tl5uhhRVCE7SKO3INZHaO3C2eopenlpbLoTVdxG/G5sxWzuX7d5ibGEjVpv434Tb5/iC
 D8ck5swmihzIHHQ5T5zCeYg6rjB6dwGj71IRDtxH1yKjU=
X-Gm-Gg: AY/fxX4ymk4q90hRW7Qge44X3WEUbrFITAgS+zxfa72fpaibq26slphBoSXfBTR6Igb
 vquox1YZ9E91Me8M7iAg7AnBTmx8H7YgIn7RmbX5xRpmrMV6pEKa1fqYHoz4mgusULwk3b+lJKi
 ACWMNfquTRiI0uEz5rU001LwCOaBCXRsYHHIJNGagk0aazrmS/05NbimZOkP+47r++0xTR7YQTy
 2shUt83uBp3n9GTkb2Kv1hlk9CmpwnYKHAs44Uay0dtqdZMQ5fBF9H8LLVpJDXXnQgI7C+c7b1U
 LrQw0bUB6yAz7fQ3OvzQZddH7hz0bKO9qsz5Ystcyokqg4k5eg5vknmkccgViWFT/gnpoDEk4YE
 t6fjWXo35n0yeEa2WHVOMx6UTLrIS4Ckz9aeZHbM0sFZK+X79PVZaw5+sZUg5zPn06f1Ytc/vsR
 wQf5pR5wA/JPKJ7xqps8SRGIrlK3CpZJQqDelFJo0y2IfvRfyt4A==
X-Google-Smtp-Source: AGHT+IEZQjbKPuVCuyXdXz5fEB0Qe6Z7DhKdMvzEH46t+zi4COx9oOVilXhe9Gnz/P67FErnIXQWfQ==
X-Received: by 2002:a05:6a00:f96:b0:7f0:2d21:878e with SMTP id
 d2e1a72fcca58-7ff657a6a3dmr32493140b3a.25.1767156610303; 
 Tue, 30 Dec 2025 20:50:10 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7a8442edsm33981945b3a.12.2025.12.30.20.50.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 20:50:10 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v3 2/2] target/riscv: Use macros for PMP address alignment
Date: Wed, 31 Dec 2025 12:50:00 +0800
Message-ID: <20251231045000.30120-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251231045000.30120-1-jay.chang@sifive.com>
References: <20251231045000.30120-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x435.google.com
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

Replace manual bit manipulation with alignment macros for better
readability:

- TOR: Use ROUND_DOWN() to clear lower bits
- NAPOT: Use ROUND_UP() to set lower bits

The behavior remains unchanged.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/pmp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index c88e86cb11..119c448357 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -235,8 +235,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     case PMP_AMATCH_TOR:
         /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
         if (g >= 1) {
-            prev_addr &= ~((1ULL << g) - 1ULL);
-            this_addr &= ~((1ULL << g) - 1ULL);
+            target_ulong granule = 1ULL << g;
+            prev_addr = ROUND_DOWN(prev_addr, granule);
+            this_addr = ROUND_DOWN(this_addr, granule);
         }
         if (prev_addr >= this_addr) {
             sa = ea = 0u;
@@ -254,7 +255,8 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     case PMP_AMATCH_NAPOT:
         /* Bits [g-2:0] need to be all one to align pmp granularity */
         if (g >= 2) {
-            this_addr |= ((1ULL << (g - 1ULL)) - 1ULL);
+            target_ulong granule = 1ULL << (g - 1);
+            this_addr = ROUND_UP(this_addr + 1ULL, granule) - 1ULL;
         }
 
         pmp_decode_napot(this_addr, &sa, &ea);
@@ -625,13 +627,15 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
         case PMP_AMATCH_TOR:
             /* Bit [g-1:0] read all zero */
             if (g >= 1 && g < TARGET_LONG_BITS) {
-                val &= ~((1ULL << g) - 1ULL);
+                target_ulong granule = 1ULL << g;
+                val = ROUND_DOWN(val, granule);
             }
             break;
         case PMP_AMATCH_NAPOT:
             /* Bit [g-2:0] read all one */
             if (g >= 2 && g < TARGET_LONG_BITS) {
-                val |= ((1ULL << (g - 1)) - 1ULL);
+                target_ulong granule = 1ULL << (g - 1);
+                val = ROUND_UP(val + 1ULL, granule) - 1ULL;
             }
             break;
         default:
-- 
2.48.1


