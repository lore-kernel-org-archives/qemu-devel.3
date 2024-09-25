Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA013C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stQfL-0006PA-5Z; Wed, 25 Sep 2024 07:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQey-0004sW-El
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:20 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQew-0000gv-P7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:20 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37a33e55d01so5008256f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727265497; x=1727870297;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtVA3g+R+ZibrHbo8QSzjB1gIxGGYXP+xdSIzbQTjKc=;
 b=auiBYI846lBNK/W6hnYyKt8HDHtXnn8+0lhqLl4vBsw2V6aMdEByDR67ZYSqhc1VCS
 apY0hx8fTwx0AprKqc3NwM8Hg8II10refhyK1S7D1bzPrGQ7kVqnp1vwWkf7MYI9sY6d
 5hFTZB1tQY5xaJzhFmRSTtZp5y03yrXC1UhlT7FSoJvH2KSmHAAD7YG4Xt6c3dwJonH+
 OB1Fy9zh/LzVC/FwSakrZ9vYBKob45olON4d7xbozJ8rOwQYBsJYJNyA1+8qxX+BMz9x
 zsitoLcNT5lMCFeuuorX0SgYMitFQr+kh7XguN76Otby7qe7UL0UGig8eIeKsv0t9/kV
 dJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727265497; x=1727870297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtVA3g+R+ZibrHbo8QSzjB1gIxGGYXP+xdSIzbQTjKc=;
 b=pisZuZTGEYek8TBi6H3i3xDV9AxhsLXQ3euuthAKCyzVVKbeMwXkAKVarYOxabgXdl
 /OAzoqSgdfnhbo2skCTC2sTAC/j2k7dx8+5pALb6+FOWtubGvH3xLt/CX4O1dt/TWBPj
 2igj8DBDNLnVWJlYMuTql6ghdy7Xtue14n13y6HScwa/fw93ZsnvyQ6WfItLqkDY1UYb
 +B96HIOtVnSA46q6efGvXXnqf6v0q+8+D/SxD+OIuWcPd6sf63Vt4BlzgxW2ywfAw+fh
 v6dnD6QHjitWvkAGIpL8DNPmBEVsI19G1EkXe88WRg5ru7/zwCeMs+ln2b5lye9GY+SD
 1/EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDar05zmjeW/5+Pczqd1JFeuedbFkeadsvg0cX+jVkLdIC5+LMPd6lskL8TDEDZIsH41r4A9xCC8sq@nongnu.org
X-Gm-Message-State: AOJu0YzjJu4vurH4xnyZKElhPTjuWjtIGFa0AvShXcxZPJ5sTh/Lanry
 M2ONTCFMb6qNAh1qOLkmSZKASSzCBdSZ9wi2EXieDzp3AEIS1DMvgT1B2Cx1H+w=
X-Google-Smtp-Source: AGHT+IGLDT7kNF3EypaCtw21v55/igBOJ3c598yBa3Lv1E9IgpjMQnhsNYsZMSWCg5GZjxTeWNkDUA==
X-Received: by 2002:a5d:5b8f:0:b0:37c:ccdd:41b3 with SMTP id
 ffacd0b85a97d-37cccdd4268mr109534f8f.8.1727265497142; 
 Wed, 25 Sep 2024 04:58:17 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2ab52fsm3770612f8f.13.2024.09.25.04.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 04:58:16 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] target/riscv: Add Smdbltrp CSRs handling
Date: Wed, 25 Sep 2024 13:58:03 +0200
Message-ID: <20240925115808.77874-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925115808.77874-1-cleger@rivosinc.com>
References: <20240925115808.77874-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Add `ext_smdbltrp`in RISCVCPUConfig and implement MSTATUS.MDT behavior.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu_bits.h |  1 +
 target/riscv/cpu_cfg.h  |  1 +
 target/riscv/csr.c      | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 5557a86348..62bab1bf55 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -561,6 +561,7 @@
 #define MSTATUS_SDT         0x01000000
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index dd804f95d4..4c4caa2b39 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,7 @@ struct RISCVCPUConfig {
     bool ext_sstc;
     bool ext_smcntrpmf;
     bool ext_ssdbltrp;
+    bool ext_smdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d8280ec956..cc1940447a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1617,6 +1617,14 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0) {
+            mstatus &= ~MSTATUS_MIE;
+            val &= ~MSTATUS_MIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -1655,6 +1663,13 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0) {
+            env->mstatus &= ~MSTATUS_MIE;
+            val &= ~MSTATUS_MIE;
+        }
+    }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
     return RISCV_EXCP_NONE;
-- 
2.45.2


