Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F294E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEXr-0004OW-5O; Fri, 10 Jan 2025 07:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXa-0004G4-C0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:55:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXX-00010D-7P
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:55:06 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso15034675e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736513700; x=1737118500;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTCLjoP17doq2guAu37UKxNoduJWAXBrSqWmmRC0mqk=;
 b=l3XK4/uY2G8C748igqtBcc4h20cg1jv+2W1TtQSAM3AewEGTEDNsyZGycbfkOy2siw
 mpEmJYF15cuFC++/R3bLrP9/v+UjgHsszDISfCb/YIokBiql7MF5NzbeXyemZcgzaSeR
 a+L+LEvzyCu27/dQK9BQN0FJzwxMEIjGcLihZJjurZ9yRUXWv7+xU9vFHWPX3RbSZ3iN
 8UyaehGNt+cfXBmD0FF4H1pHd7qYZNqv94mylZT4x6MR3CsofFQPL2TS7whZ2ElmahKo
 /9qFlndgRdZd6OdxMVzse4R5fqu+kjsovQzcyFrMo0z5oj9xX8/hxInCZ6NmxI6jhGal
 1Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513700; x=1737118500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTCLjoP17doq2guAu37UKxNoduJWAXBrSqWmmRC0mqk=;
 b=ccfo9/nP3AXBwhXlKazPhWmaD4ugis2B8fk+mDuAuKayK0WlOVg4sfZyUiFWCTW6oI
 YBZRDVnZeEwCjOxt0rcEVskVHWxTMb1OWfou2s6bjXb6EoTJSg5bA81oCFPfgVSC2Y5z
 7r0QF6LNIy9YxKFfRp9f8ukAvVr/EXsYnNPDzVgn7QRCQ/6t5gBRpb76KZrOEZjfGMkP
 qpnzzr3/wlSvXzPLfDvEGAAeKzWgUkXAXISx8QJrpAyGgbXRZBVsRziyPSqinSRu63FY
 nq7jdtkJGcSGj+iGBVk4buGQeq2+G4lF+4ClrzdTz6cEKlGHJ8Kgzpu/fp5qLoWITIx+
 P2UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5EIgBxLUufKs0gEH0GQsnltpscSAUBHGSdmW8NsFiMQPzCjV6WN/q8H8Tk5XyB3Sp7JhAC/Bi3tm8@nongnu.org
X-Gm-Message-State: AOJu0YzPPvrYz6gI/A+mFaNm74xKw/jBY5JWQegUqCnueYGVlPtAX7iR
 BWCnH5OSlo7ehYnUFMYrSnEwnjCB4U6NvOH4dC1LYKtOzrvRQ+IXxLncRx6KWpo=
X-Gm-Gg: ASbGncsWRXBxNZuIavQE2eDXPaJZQux6yXrDaYabZq4p4nGfs0dUC6cqDVO3Pm9DC7m
 vrOELP7gvE5XWrQES5AKYKG82fheQLxz26dc4xzSz9r6KDFMC7ETmpZM1Yj8QH3C7SeUEA5JqQf
 0X2bueQbZGKXIbzY98v9LtiviYe26XW3WWK0hg21gIFPbFYrB+LUVLz0ZZy7PIjfOBk7aVEJe9Q
 wtLGe1EgJ4jn8/cUlVJzkd4GF72pTMgJGobFByScsvZw1UFD5+6YrS2rg==
X-Google-Smtp-Source: AGHT+IE7HxD7hddsRMal6BijxL6C/PEH9dSmU2FsowmzZjQQI84T5f/r/I/X/JKdwUgHs7X+XT89XA==
X-Received: by 2002:a05:600c:3c97:b0:436:840b:261c with SMTP id
 5b1f17b1804b1-436e26ab54fmr92383685e9.19.1736513699770; 
 Fri, 10 Jan 2025 04:54:59 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm4548921f8f.97.2025.01.10.04.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 04:54:59 -0800 (PST)
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
Subject: [PATCH v8 7/9] target/riscv: Implement Smdbltrp sret,
 mret and mnret behavior
Date: Fri, 10 Jan 2025 13:54:38 +0100
Message-ID: <20250110125441.3208676-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110125441.3208676-1-cleger@rivosinc.com>
References: <20250110125441.3208676-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x334.google.com
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

When the Ssdbltrp extension is enabled, SSTATUS.MDT field is cleared
when executing sret if executed in M-mode. When executing mret/mnret,
SSTATUS.MDT is cleared.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 59c4bf28ed..ce1256f439 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -306,6 +306,9 @@ target_ulong helper_sret(CPURISCVState *env)
         }
         mstatus = set_field(mstatus, MSTATUS_SDT, 0);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp && env->priv >= PRV_M) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -391,6 +394,9 @@ target_ulong helper_mret(CPURISCVState *env)
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
     }
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mstatus = set_field(mstatus, MSTATUS_MDT, 0);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -436,6 +442,12 @@ target_ulong helper_mnret(CPURISCVState *env)
         env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        if (prev_priv < PRV_M) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 0);
+        }
+    }
+
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
     }
-- 
2.47.1


