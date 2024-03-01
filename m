Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6C8C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 14:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg44V-000127-S1; Fri, 01 Mar 2024 09:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rg44Q-00011d-BT
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:41:08 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rg44L-00017z-T9
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:41:05 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29aa91e173dso1171754a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 06:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709304059; x=1709908859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gTgnCNejzdvoMz7ZgecInGgvDORxSraKGF/5Sf4sJH4=;
 b=cYhIrFldmMSSZwyJ1cK3KqeLLwi7xY6fetIL1xtCadLlwg9SD8sB7CTyPDI09qzwHr
 3jZry7NWMdvP5extbrjU9Xcu3E2TE2D6BDpi84rJmzi0GFAqqByOsY5THuujk0pt6gBX
 yn+N9xCA6HHRgl6+s/8vc+9FGJ7vNuKD5hxZNXqkEVXkziOrRQaWhRpJJb4gRl/+8lEV
 H5xic0FOrLZGGVrjmy8lEVZ5yrqCLTfc3aQskC3kgRg99BJHXvX5va3PilYnq5f44GBj
 Zf5XEU2FkunCLlDUEnwr5yiiTrqZ65km8louyqu/SKjmpYYngq3gyfxJSdWTXjSwnIj6
 4yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709304059; x=1709908859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gTgnCNejzdvoMz7ZgecInGgvDORxSraKGF/5Sf4sJH4=;
 b=Hywb1/Qj3yLyQp+7R7Uz+esX0SSZp+j8DnK8qGq6yy909n6IPv7qQu/3oqxveSz6mY
 pANn0ewSTd86qgvmwWYbnjkHy7fcu0xFtyU91ma4SbIszkmk7Y14fNAidbj7G3dNJCCI
 vKhsX6edHfsVC6IXviyQXdUotp4EHtQtSiRQkHxaRqdg7xPg12xXQwIQ/v1OyfZzZ/a+
 N0fhS9O60qobPE4wA41cbB+fywSlo5JGigqUo2de/b/G4DqKuzrHWIk2IYIHH8ErUn6y
 pieqtFxqsxQLnJah+q4N0hcce3nNwAmfCYTI5Af9WLyKlxv3CXW2Saa2JkSRuFUYTTdE
 UV9A==
X-Gm-Message-State: AOJu0YymYZqLCSrb1ozzVi7jgXfMSSG7q1yNRhASGAxNCf75C7O37Drt
 n1dGAPGfnswk3ts6PdAWmWXdr1luOr0o01tPnonCgRSvsbywF6lnW7t2rqpS1M230TUqM5cZ72C
 U
X-Google-Smtp-Source: AGHT+IEhcnCzU/nQ5V+wxVnlu+5j3NhvrdnJTUsmf5EkyHmbDQCxotXo0olrKCcPPRZVpL4lA7GrMw==
X-Received: by 2002:a17:90a:c3:b0:29a:ae40:9e10 with SMTP id
 v3-20020a17090a00c300b0029aae409e10mr1761117pjd.17.1709304059626; 
 Fri, 01 Mar 2024 06:40:59 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 sj5-20020a17090b2d8500b0029ad78306d8sm5565077pjb.3.2024.03.01.06.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 06:40:59 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv: move ratified/frozen exts to non-experimental
Date: Fri,  1 Mar 2024 11:40:53 -0300
Message-ID: <20240301144053.265964-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

smaia and ssaia were ratified in August 25th 2023 [1].

zvfh and zvfhmin were ratified in August 2nd 2023 [2].

zfbfmin and zvfbf(min|wma) are frozen and moved to public review since
Dec 16th 2023 [3].

zaamo and zalrsc are both marked as "Frozen" since January 24th 2024
[4].

[1] https://jira.riscv.org/browse/RVS-438
[2] https://jira.riscv.org/browse/RVS-871
[3] https://jira.riscv.org/browse/RVS-704
[4] https://jira.riscv.org/browse/RVS-1995

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fd0c7efdda..f5d30510ef 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1463,17 +1463,26 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
+    MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
+    MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
     MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
     MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
+    MULTI_EXT_CFG_BOOL("zfbfmin", ext_zfbfmin, false),
     MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
     MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
     MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
+    MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
+    MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
+    MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
+    MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
+    MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
+    MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
@@ -1561,19 +1570,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
-    MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
-    MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
-
-    MULTI_EXT_CFG_BOOL("x-zaamo", ext_zaamo, false),
-    MULTI_EXT_CFG_BOOL("x-zalrsc", ext_zalrsc, false),
-
-    MULTI_EXT_CFG_BOOL("x-zvfh", ext_zvfh, false),
-    MULTI_EXT_CFG_BOOL("x-zvfhmin", ext_zvfhmin, false),
-
-    MULTI_EXT_CFG_BOOL("x-zfbfmin", ext_zfbfmin, false),
-    MULTI_EXT_CFG_BOOL("x-zvfbfmin", ext_zvfbfmin, false),
-    MULTI_EXT_CFG_BOOL("x-zvfbfwma", ext_zvfbfwma, false),
-
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.2


