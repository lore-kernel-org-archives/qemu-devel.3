Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4555CC02188
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJud-0003HD-96; Sat, 18 Jan 2025 20:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuQ-00030f-2Q
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:27 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuO-0003jJ-C3
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:25 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso4368938a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249323; x=1737854123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmPrgsWPoZAq3tKJn0DJkbpcaPgkeDGdVdz1ucTeExc=;
 b=E9XDxDGr4NrGOdouSKyVns8CkR4layudU+qjWwwDsIlYrB3xqwdhoaHSpAC+HWwuHY
 hmMCfAJ79Y4nkzSkfCzgMYVdEd7UFxMVLsaMJFvpB1r5Q6oqiRa7bmja0COLjVAAotLh
 PDLzmZrerV+2tU+sY3z5vYaA2s3aPtwoWUgMyYNMLUj7MS7Nssd7ACDKKDJstMVCsrTd
 KvcJsX4uBGe9p8yFuWhB752IINIwmYDMzMVnY2dgLtogyl7viJymnyoUJQBGkIDikTaJ
 WvAxlZ4uITJipaqaLXuGakHqiugAeZ2FKWFiPnk5L8Leb2G9ZMGvd63yHKO3rfUdWBJw
 WoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249323; x=1737854123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmPrgsWPoZAq3tKJn0DJkbpcaPgkeDGdVdz1ucTeExc=;
 b=oy8UDO95hdGAS1hEck0k5OXiY+vw4HKyWoH4RyDyAKLBfw0mUKVbEWjOmPf7g0gf77
 xuAn59hU222aX6Oms1JBATNTe3g7btdN67Hfrx1Rmo5Mz37heWrfIS6N0xSCSKUsLrZ+
 e698rYCDHHjB1BY2kXNlTwopJABuOc4PnsMfMKRJ8Dzk+prTR0FqQDTs75yW79BlDNLj
 sWHewiPjXdcyUwxxWlmoU4UeLKS7OEstS2si3b46Z3s1Q060Vu6jh6Pu2VIKFOosBngs
 KkmVnz04a1WNd2w1eWM1kLhk6hUTsV4h1GDxPYz0SEX2J3ulUICmpIkpXmemh8NzHLUI
 Te0g==
X-Gm-Message-State: AOJu0Yyx5ybZhqflB5DBwGh9f6Xixr50lav4HYRSc6mgrSCJqcxjrbcf
 3l2Ncr2wERA2jWT3dRLKnQsL4tAcfo6DX8Ky6nVnVZB3DyChsq9otSSG2/HW
X-Gm-Gg: ASbGncu0UZhJkj6UQOzSGMZdzAAzPUg06XbV6iUNzo7/aN9o5h1zm01hgzDB9pW1kOC
 WQd0SWUzOrxtiwA8MdpaHJ5KDUu8Ab9OxcggRtlRpRUOnUlTfNFQL80/ewlkWbSR+HvoGcDFri9
 cso9D4U9ZKAaMq8jBcBQaGZeSnyWa5DUmSqQZymKGyFKn8F2SOLbT8NcIMX0yhFQkD4EBl5hic9
 XH5Cf9QG9ra4+5rwZBiFibzSZKU8qgZNtngO+SIKZwzahJzulAEacpGl1LEEcCwNw+SqqAEIG/5
 g9tN8fKWbLnYq+Is1H40DVroyCA4QbppqP2n7dhCc9zrFgEZ+7RkpMQzkH0iPQATfHNLDmVF5Q=
 =
X-Google-Smtp-Source: AGHT+IGegqk0lJ7b3/R8dVMxLMDHdULpD+ODiA8wNJ7K4itIvjTtDKvI+RKmrsMl+dGdDKleJei42w==
X-Received: by 2002:a17:90b:3a08:b0:2ee:dcf6:1c77 with SMTP id
 98e67ed59e1d1-2f782c9cb1emr12583990a91.16.1737249322787; 
 Sat, 18 Jan 2025 17:15:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:15:22 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 47/50] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Sun, 19 Jan 2025 11:12:22 +1000
Message-ID: <20250119011225.11452-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

Add the switch to enable the Smdbltrp ISA extension and disable it for
the max cpu. Indeed, OpenSBI when Smdbltrp is present, M-mode double
trap is enabled by default and MSTATUS.MDT needs to be cleared to avoid
taking a double trap. OpenSBI does not currently support it so disable
it for the max cpu to avoid breaking regression tests.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250116131539.2475785-1-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         |  2 ++
 target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e3ed11b0fd..bddf1ba75e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
@@ -1626,6 +1627,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 48be24bbbe..0a137281de 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1439,6 +1439,16 @@ static void riscv_init_max_cpu_extensions(Object *obj)
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
         qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
     }
+
+    /*
+     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup to
+     * avoid generating a double trap. OpenSBI does not currently support it,
+     * disable it for now.
+     */
+    if (cpu->cfg.ext_smdbltrp) {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
+        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
+    }
 }
 
 static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-- 
2.48.1


