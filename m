Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA357606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=lB2f7jIE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJmoL-00030G-Sf; Thu, 22 Oct 2026 03:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJmnh-0002o3-DT
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:01:22 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJmne-0005uq-Pu
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:01:20 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792652469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8S1gE9waKIsyA2TaGvT3mUme7EtsXYWFdPJ9syqTFY=;
 b=lB2f7jIEfedI60t/x0LMwbYxoCxCFNcXYy+4JLeJjlZaakVu7WBAqKQwDFf5UggibFcezj
 t+jYeJpdwOSbLgPMB+qODaC9HU0MOprpreeOSomTS0oRxUVJ5QPLiefEDBmuF2D/H2QOtL
 Z+0tbNqCLkB7hR2hSZ3PXJdi/5ifh6c=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Stian Halseth <stian@itx.no>
Subject: [PATCH v3 1/8] target/sparc: Add crypto feature
Date: Thu, 22 Oct 2026 09:00:52 +0200
Message-ID: <20261022070059.3861291-2-stian@itx.no>
In-Reply-To: <20261022070059.3861291-1-stian@itx.no>
References: <20261022070059.3861291-1-stian@itx.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a "crypto" feature bit gating the OSA 2011 cryptographic
instructions (AES, SHA-1/256/512, CRC32C, CFR in ASR 26).
Off by default; no CPU model enables it yet; can be set
explicitly with "-cpu ...,+crypto". SPARC64 only.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Stian Halseth <stian@itx.no>
---
 target/sparc/cpu-feature.h.inc | 1 +
 target/sparc/cpu.c             | 3 +++
 target/sparc/translate.c       | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index be81005237..4a32f49de4 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -16,3 +16,4 @@ FEATURE(FMAF)
 FEATURE(VIS3)
 FEATURE(IMA)
 FEATURE(VIS4)
+FEATURE(CRYPTO)
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df..528a9d2bd8 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -560,6 +560,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_VIS3] = "vis3",
     [CPU_FEATURE_BIT_IMA] = "ima",
     [CPU_FEATURE_BIT_VIS4] = "vis4",
+    [CPU_FEATURE_BIT_CRYPTO] = "crypto",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -977,6 +978,8 @@ static const Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_IMA, false),
     DEFINE_PROP_BIT("vis4",     SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_VIS4, false),
+    DEFINE_PROP_BIT("crypto",   SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_CRYPTO, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3156be6a94..b93feb074b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2507,6 +2507,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
 # define avail_VIS3B(C)   avail_VIS3(C)
 # define avail_VIS4(C)    ((C)->def->features & CPU_FEATURE_VIS4)
+# define avail_CRYPTO(C)  ((C)->def->features & CPU_FEATURE_CRYPTO)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
@@ -2524,6 +2525,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS3(C)    false
 # define avail_VIS3B(C)   false
 # define avail_VIS4(C)    false
+# define avail_CRYPTO(C)  false
 #endif
 
 /*
-- 
2.43.0


