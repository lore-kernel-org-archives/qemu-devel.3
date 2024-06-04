Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91E6C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENZK-00078p-5Y; Tue, 04 Jun 2024 02:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZI-00078K-Jq
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:48 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sENZH-0006ff-22
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:22:48 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6c57fa82fdbso2692068a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717482165; x=1718086965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjKQ0LWyXOz4Tysm+g4djnQkCrSs2pDGW5FYItNP6eQ=;
 b=fXhJ586OUTWEBCE0m/W9XbspIENJsJh0widzZIumdMw21SkeZTwGZ5rEFbx/t9J4hL
 cMeYbnP0xFA50YuXiMlZN2x4SmtEJ2n8XKr+fKJmptx5eVf0/zltv+nly9gGIeIdGC9L
 +xMjZ6Jx0J9fuTH0cCW7vmQYtSH2hXIm5PxuVhvMgXatKhSmVxhaBBNRzLykFKYGjO+e
 1O88I8XrHuf45DxEUYXKqHd+RCq4V65yISJ+efogJEq/6ksELHzZY7PL732ezv3LFx/W
 NaCgWJjbqA6+Bwgw6Z8C36wbHIz8jeAuFm0ydtJ0NkVyF2VytA9VWWbSDmwz+P5SwbkV
 ot2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717482165; x=1718086965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjKQ0LWyXOz4Tysm+g4djnQkCrSs2pDGW5FYItNP6eQ=;
 b=Gdae2OVN+bjqi4Hy6LqCD6R3UyeDjCxTWCyF/EINxbyx4ab5RvK2IujmJKJvgPhAW1
 N5aoynthSf/sWTJBn2M4B9M6OMNntTqKuUJWkZo88KZEAihyzcUpOwNL+w5hKaQxumnD
 LSwJC1UsSqw3IFoe5hF3hY/GyoWQHWB3PMkr0mPcb0B8grXl9JCzUblLsQUCPlObJ5Pk
 6V7htMkRJ6Nx0o2D8+MRbzsALfWwFeg7pfeY9MdE+vjOoDCx2DZ88LFOD3aTeM66rx7Z
 qGPBhW0eXEPvVzE+hjUSqMlTHv7CnJ7rNbsxyaBaI+p6D7tkOI1FSUuUgq4kxhv6K8PD
 +GeA==
X-Gm-Message-State: AOJu0YyQ2XBVahSWM9WLytJtr6dSXfzv/eYfQ1+HIRCuQMxRHa56PV/c
 TxkmZhseMGTdKlO6FXEOG14tpHz51+sAtpE8CyuMeVZOt6OY7fVXfWoTn6OcJEBZQMYP7dLAwQF
 z3vgWMO7IfME//wk0eO15AYiBidZrR4w7JpwAXQ7ZNSlJG+ltKi3LcDmSe1qyctTghEogP0cu1M
 QNnWL46h5DZTBBlyb8xOWjhRep28kc3GkEMeM=
X-Google-Smtp-Source: AGHT+IHHAJKRxccxZtv6lpzGVAq926PYUz5xfEIERiwKNo8BQ64488GLahE8q1+Uf/TAYrZtRXBukA==
X-Received: by 2002:a05:6a20:3d86:b0:1af:fff9:30e6 with SMTP id
 adf61e73a8af0-1b26f1b9abcmr12117069637.15.1717482165081; 
 Mon, 03 Jun 2024 23:22:45 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1dcb56014sm7115617a91.25.2024.06.03.23.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:22:44 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 4/6] target/riscv: Add 'P1P13' bit in SMSTATEEN0
Date: Tue,  4 Jun 2024 14:27:45 +0800
Message-Id: <20240604062747.9212-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604062747.9212-1-fea.wang@sifive.com>
References: <20240604062747.9212-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
mstateen0 that controls access to the hedeleg.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 74318a925c..28bd3fb0b4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -315,6 +315,7 @@
 #define SMSTATEEN0_CS       (1ULL << 0)
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
+#define SMSTATEEN0_P1P13    (1ULL << 56)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
 #define SMSTATEEN0_IMSIC    (1ULL << 58)
 #define SMSTATEEN0_AIA      (1ULL << 59)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58ef7079dc..3dcfb343fe 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2245,6 +2245,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -2280,6 +2284,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
-- 
2.34.1


