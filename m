Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C4BE77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 03:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSSul-00009t-2j; Mon, 30 Dec 2024 22:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSub-00007w-UM
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:17 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSua-0006Ds-DF
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:17 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166f1e589cso154397705ad.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 19:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1735615634; x=1736220434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/JCscUb6LpSq6h+YM7wzNWK6nRW/6g/0UD+3B8iKF5c=;
 b=bsT1CNnvC6ovLm2XR2hQxSKipBdrQTmazjcjOHD/Hs1pttiSIgjWzdBjn3n8CXqis0
 v2dQt+70ofxF60BwLz6/1ZvlzxjCdxE3J7SDpxXWhJFxJjpsntXMiUu0E31u9HiSz2kY
 F9leIgSehAMG24sYWu4wIac46KIlw5bDg1iJKly/PDJnjBVCGsm/X6jFm64+Vc5nQEZF
 Ncbd3BE2aIHOQ7fK50JePM0E8UwpaFF0mtFDDb8Pui8ULeZb6iAsu1DP7Pq1cw/2tfZ3
 lwq69IAthnPRIDttyIx1+kQ72iJJmuKqkDG0aYnqC+z3poLyvwM0G2vO91C/RKt5wkcp
 S7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735615634; x=1736220434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JCscUb6LpSq6h+YM7wzNWK6nRW/6g/0UD+3B8iKF5c=;
 b=ttpfSZCuGR3zOwzsG3X7wo2QmMJB0Jfw5HkCSEDTASIJi2NJVf6NRMbOGx69FlhbQ2
 eFp8xAr0dGfvqyDEbOqcHdgPE6rccbdzCse7OjJR+QrS4QpNlLhmUWllBCdplyuDU8bh
 UfhsUvJDF36UvWLtY91d4xWu1GJIQff1Tv20GmHF+Xe3eCIjl9FsBaSXnTynReTUduEF
 G9CvO98IiNEbhRebpjuwVCkWUGKCgS8LOEZEn6W3F57+jeYmDPyyIeWEgdGpfWxEA7fX
 qbqdCKccsXr4kuUQKh0yhO+c470pwTlp/GfsPTAYjjnDG5o2Air8b79xeD2Oi2aKGktB
 Dvuw==
X-Gm-Message-State: AOJu0Yyn2PTX7ihapaT3JKkxaP7nWSXEKM8wIViJ24hh1+gCF0HtntVp
 s3btkb0IVAPV5BmSrGn8vuioKzJ+dx3zGrVx6hgnbHlMRCt30wdmHX/Ia0gh94OyAFUon50Yyir
 dyD5wD4/8cyxFaVpvFY+4UKUZd91lT0mioOcsx+xKh23Ry7R21eGhDOLBCsUrGP3v98csAY9qJ4
 xNv8ppqYAGHqPHNT6hm1Ndj0V8ZzbOl9+/uScxEoerr0Vb
X-Gm-Gg: ASbGnctfmAPQK2m+0BCt3Tk4W5EcbKYK6k2PFEcbFKwNPoZpQDoMl2H41UP6HLro9be
 Iejo7SAKvJo2SxO65oQNGm3a6EJjboMc4JZglICj/Xv+GrP/875kS98vqZzfZm3ehr29FDeQzoj
 2taXjzVnRu8OpOwqgUaWGShByAqz3j0gxKRTBYDjIROUFC0SfSYfnpIik+GVb0/kTMq7PiknAQq
 //Up/6pYZw1n2L7/sfArYza9c1lKvjSRjgeucAC0JH77z0q+YJh1WjtwykPY6EY7KEj8pZbczhB
 42qKFAi3jBRrH+/ts2IO
X-Google-Smtp-Source: AGHT+IHItrClcBwI1b6N+9oiyfRneW9aI/sRmcEqHDTZsn2iSn6/ln26Tild6QZEf/O13mkHIiGtCA==
X-Received: by 2002:a17:903:2cc:b0:216:4b1f:499 with SMTP id
 d9443c01a7336-219e6ec0052mr580208605ad.31.1735615633665; 
 Mon, 30 Dec 2024 19:27:13 -0800 (PST)
Received: from fchang-1826.. (1-169-235-48.dynamic-ip.hinet.net.
 [1.169.235.48]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-92587c62eacsm291797a12.21.2024.12.30.19.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 19:27:13 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v11 5/6] target/riscv: Add Smrnmi cpu extension
Date: Tue, 31 Dec 2024 11:26:53 +0800
Message-Id: <20241231032654.133039-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231032654.133039-1-frank.chang@sifive.com>
References: <20241231032654.133039-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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
---
 target/riscv/cpu.c         | 2 ++
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6c46a2f076..b0d9e93170 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -186,6 +186,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
@@ -1614,6 +1615,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index cbf2cf1963..c4070c948e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1421,6 +1421,12 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     if (env->misa_mxl != MXL_RV32) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
     }
+
+    /*
+     * ext_smrnmi requires OpenSBI changes that our current
+     * image does not have. Disable it for now.
+     */
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
 }
 
 static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-- 
2.34.1


