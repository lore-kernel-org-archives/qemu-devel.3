Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46012C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJt9-0004d7-4c; Sat, 18 Jan 2025 20:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJt7-0004Ky-30
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:05 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJt5-0003IU-9N
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:04 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so5841709a91.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249242; x=1737854042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObjOg1jNkCKQgckMwlEXeZthhx4HB8cGtwe97jDNC3w=;
 b=WF6/EUjvvO+kbeNWHLvwC9SsWVNKXbtXVKod4wBEpkC/KQfrTpdzjVP8ahaOfSvcpo
 O9LOLi1jgaGwgU3tOfG034sdll2MeDAbjoIIdn88H7/SiAaYlhWCZtxm7BwpsWvxUWUb
 sK+peLwRoGau1848bgh7TSu/8xkeLppv+bYrFkVMVMH1Lyn2YdZiyc2xbFb8gFl6vLkQ
 P3sQddker6A/rHnKkSbUL4jDSR1R3WXH3PgZABCKJjMOedeMFZKz037UYTkihjpAxcTr
 Xh0Y67xy3MXDu0iJTk06BItZbTbWO9CRZCscINVV+jCJA2/Az1fzY7/6Q2Qmw+G2p0uY
 iG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249242; x=1737854042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObjOg1jNkCKQgckMwlEXeZthhx4HB8cGtwe97jDNC3w=;
 b=RnDF3ItLLIkNXn1vaEzJlOgWxl1PJ81Y/h+Zizqcmx4mg7VGZ02nZKeVZOg75vcEOF
 tozw8ttk6me8JGbvDPHjh765pMq910XoCl8m3beZKHCCZ+c3xPIZmLYDNUwcVk+lZfk0
 F/BhaLtFkDiHfiIvXFyahlkAZ8BB7MpycCY71h2fIqNQXeWj1oy50aVFwQfJT47/QXd9
 GydsiEXhJ/hkWsViOBu4KR84cN/wVOfmCAPt37Tdu05Oc4srkUafn8FJIlXyKoWNuuFi
 lCprHWi03VsQKPEPC7JgJ1dvtTGLUgZ922jTOKCCTy0l63jKTlHYs9QZKhy2hxZUZ+9o
 hvjA==
X-Gm-Message-State: AOJu0YwIOiDwoR+aEDC2YBFAbVkt1lW0yY6/VQ6NJYzqRb0UGXyOQl0D
 bnSzdYbrmOw+3g/zOd5o7J66sJSSNyAHfUT3pn4KZnflXpXEhXJKAw746jyV
X-Gm-Gg: ASbGncvlnBt+2lwcJ1ZAyzzH53/XMYf3WWeLe7Uh8Nv0vqOM8BEAAzEq6+j3qqvY5r5
 B7d5zjJTAJUJEoLfednpIVoqS8tWks13or8Ez7HOQjHjcaiyhBaQ6RgBw7nj3vFNqRS4QE+lvcW
 JMPTmYdoutPXnCmxsG/auLZ6L5LJwKV95CQhlYAIoPGch9isQU5+AwERVQCJSEzcB5D6glOrqaX
 /QQ2Yh0YU7E7K1c8c9Juf/S/H47OjmhYSDfwZ77EMuiybnFP5uyIO9urX7zhK6kmH7kzMx3mBm+
 y3iwBP3pg1CZ6eKriUW553YusH4qLAvqeQO8SqbZxbXuEh5ZKwVXiLERGxnjAgaVsSt6NwRp3w=
 =
X-Google-Smtp-Source: AGHT+IGPq4jJF/fdsUOx7ScQ4yHlTcmnMlTIz+6TGYHPqNPWi2G5koVVSXIaeCDXXDrEUowsRjkVug==
X-Received: by 2002:a17:90b:4a48:b0:2ee:863e:9fff with SMTP id
 98e67ed59e1d1-2f782c701cfmr12562301a91.10.1737249241684; 
 Sat, 18 Jan 2025 17:14:01 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:01 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 24/50] target/riscv: Add Smrnmi cpu extension
Date: Sun, 19 Jan 2025 11:11:59 +1000
Message-ID: <20250119011225.11452-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

This adds the properties for ISA extension Smrnmi.

Also, when Smrnmi is present, the firmware (e.g., OpenSBI) must set
mnstatus.NMIE to 1 before enabling any interrupts. Otherwise, all
interrupts will be disabled. Since our current OpenSBI does not
support Smrnmi yet, let's disable Smrnmi for the 'max' type CPU for
now. We can re-enable it once OpenSBI includes proper support for it.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106054336.1878291-6-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/tcg/tcg-cpu.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb06d06628..dace670e5e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -193,6 +193,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1614,6 +1615,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
     MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7f7283d52a..f94aa9f29e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1430,6 +1430,15 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     if (env->misa_mxl != MXL_RV32) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
     }
+
+    /*
+     * ext_smrnmi requires OpenSBI changes that our current
+     * image does not have. Disable it for now.
+     */
+    if (cpu->cfg.ext_smrnmi) {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
+        qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
+    }
 }
 
 static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-- 
2.48.1


