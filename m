Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B8EC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6pvP-0000c4-0z; Tue, 14 May 2024 07:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1s6pvN-0000bQ-6Z
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:02:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1s6pvK-0005RJ-Il
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:02:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34d7a32bdd3so3155394f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715684540; x=1716289340;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W5IISP9VKEhffdZOvaJw/sFaIYXZNJzultqJyXlY/1Y=;
 b=a9d42NGv4o6EXR/JT1+HKT+7Pc22z4WYw8myD2yMh5eaHuv/zcdDf8JTZQMaXnfwcl
 Lsv4+3qL7Uj4M+yAiN3I6a4eBiO01fymbYzhx1YHWz09pIEPyzNmI1+1FsPDIk7me8yH
 UQVThQM8Z+zQJxPPFCluj2P4faBiYm4cYB1fGL3uxdcCaBZ95s62CQiM6ZSIyWA9nCf6
 2foQwnXoFgC0zBcsqgyZWriYW/6svu8mRzbkccB/ekScG3AM52hL/NLRvA3ZAhOVFIBv
 wLMu//+SqdP20Af+p4BoGiRrOSmqmPE53I4YDRwISVsGAED3/RB1ZtJwWoyu4xA9nRC0
 vCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715684540; x=1716289340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W5IISP9VKEhffdZOvaJw/sFaIYXZNJzultqJyXlY/1Y=;
 b=BV6iSmkPyb8EsEaQmZenQMPV2FN+LBxdoYHhtrfzS9d53ZamijgjH/pmJoho+qrIyf
 y4hN6+iedFk9YMmAjiztb8UxaXN29S7k/8QfkQteJF2L0bDBCEcQb/sArgoD0JMaQxe1
 XWYAKLc7LB6B+91oBQubZ+j7RQyMUPhr6vLU2x8qEdkY79PCc35e4V2fk/2qNnOANp0Q
 44Kvx4GPMVUvrwefIXtyO1bCWardksPQNhWqlbtBA5TguwlJiXrqf5w5ruD/YB0UmcEH
 BckU//6+rhJUaIGO+PsqQYm35fD49sxhAHUTXxlmayV9Mh2uMLDZyfjDZXhAv84q4a24
 wEMw==
X-Gm-Message-State: AOJu0YzCIzfe37EKXoxX4IFvvjr4mw6hO8RC3YkoKPdpsTG1CzOg2wgT
 +MGCHmSaCx59vWySCwjL1kkiAvRRswZHpjFGSexq/2QBzvxoPm5SoC472OdqtF8yjNV1uqM0t4a
 zY8E=
X-Google-Smtp-Source: AGHT+IHufCbEE/Cmtn9+2hxNINh5XFZ+V9QohbW2N3hHOMkSlJC/I8njbobFA1BskrhSaKQMNH2iyw==
X-Received: by 2002:a05:6000:c6:b0:34c:f989:e4a5 with SMTP id
 ffacd0b85a97d-3504a96d562mr7863336f8f.66.1715684539985; 
 Tue, 14 May 2024 04:02:19 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896ab0sm13489490f8f.41.2024.05.14.04.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 04:02:19 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Rob Bradford <rbradford@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2] target/riscv: Remove experimental prefix from "B" extension
Date: Tue, 14 May 2024 12:02:17 +0100
Message-ID: <20240514110217.22516-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This extension has now been ratified:
https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
removed.

Since this is now a ratified extension add it to the list of extensions
included in the "max" CPU variant.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c         | 2 +-
 target/riscv/tcg/tcg-cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d..861d9f4350 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
     MISA_EXT_INFO(RVV, "v", "Vector operations"),
     MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
-    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
+    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
 };
 
 static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 40054a391a..164a13ad0f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1281,7 +1281,7 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     const RISCVCPUMultiExtConfig *prop;
 
     /* Enable RVG, RVJ and RVV that are disabled by default */
-    riscv_cpu_set_misa_ext(env, env->misa_ext | RVG | RVJ | RVV);
+    riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVJ | RVV);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
         isa_ext_update_enabled(cpu, prop->offset, true);
-- 
2.44.0


