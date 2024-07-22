Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3152AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvZX-0004TD-5w; Mon, 22 Jul 2024 12:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZU-0004NG-QC
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZS-0007dX-7d
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:32 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fd66cddd07so19099805ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664448; x=1722269248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HH/Iif5XGZPsL0y5HvI5Hw16FlAAdRPFjEx2Qt4acao=;
 b=Z7KTSJL9kYpFgVOdXl7bzFu4ACmaIpnH55FfoOjoM6/eOhqI6heBFmve5jacZS5AuK
 ygjBRN0rGCfBhDbdSQJvxuvQKtSvuXTO/rAXlkU+rac5uTAEavf3DSeOtpe6qAemJaG9
 a0FrHa4Gc/Xwf+88rd5KgH6nDOylwmGDgJ04RyWrg5yGGetfjVuwH1xQ+xhc84wlgnPa
 GK7HfUeuBjSoXMOycfBlvXjOYAYmCTCcPvMoT+imyvDZf3NJrdtBnHFYTqcvNQ2+es3L
 jksB7SgxEdCrAcxITUfU3MLMu5areWDBVDgrx0C5B6eb0KUbpkdIm+31end2kJ86zbG4
 OH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664448; x=1722269248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HH/Iif5XGZPsL0y5HvI5Hw16FlAAdRPFjEx2Qt4acao=;
 b=AJqm6Gsk1B2f9QPc7t+x1xGEditK/Ly9btOUfDeIfed3VDF7fENRTxzub2epbqtZMb
 ersNUBC8ZUnukn8711WqfHX1gsLhT3vyCf+hnqhra9sEZqU+z4JzD1aml6t7ybRs5UYm
 Ik0z+hLewHfp/AC3B/F5f1My8UaX0qgMmiG0tVguqZ3LPw3c+gAoq9geNkm08TlEv56F
 eNHpEb+t0pjJpU+mmQSn9PHNblAEJENyPoATLsrTFriyrY0LO/2HtoPrXD0sciiAwSi7
 sYHJXH/obdsjTKx5EzqAyr1fy6iXh6iXKZnknd0Qixm1LHqXSSXTZK51vf4Se5I7ea6g
 7K7A==
X-Gm-Message-State: AOJu0Yw2rHR9ngAlII60Ovd/FLSS82xS/QUyxOgmDPLtg+PU3RK8pptm
 bZ2VC7dv80cs/jDvzUtJ7rRXArrlLV+RH89268hUxcw8OCjvsHPF9eHEyxkifsLFL4fBldh+VO3
 A
X-Google-Smtp-Source: AGHT+IFwXHnJgVgoXYJ00q8+bfLFO/DQBwt09l1MasMSEmc83sAwwzyp7E0yexvFF3TiloInbFKBMA==
X-Received: by 2002:a17:903:2442:b0:1fd:64ef:da17 with SMTP id
 d9443c01a7336-1fdb5f6b603mr2205255ad.41.1721664448181; 
 Mon, 22 Jul 2024 09:07:28 -0700 (PDT)
Received: from amd.. ([2804:7f0:b402:9243:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f2ac8eesm56533165ad.118.2024.07.22.09.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 09:07:27 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 1/4] gdbstub: Use specific MMU index when probing MTE addresses
Date: Mon, 22 Jul 2024 16:07:06 +0000
Message-Id: <20240722160709.1677430-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722160709.1677430-1-gustavo.romero@linaro.org>
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use arm_mmu_idx() to determine the specific translation regime (MMU
index) before probing addresses using allocation_tag_mem_probe().

Currently, the MMU index is hardcoded to 0 and only works for user mode.
By obtaining the specific MMU index according to the translation regime,
future use of the stubs relying on allocation_tag_mem_probe in other
regimes will be possible, like in EL1.

This commit also changes the ptr_size value passed to
allocation_tag_mem_probe() from 8 to 1. The ptr_size parameter actually
represents the number of bytes in the memory access (which can be as
small as 1 byte), rather than the number of bits used in the address
space pointed to by ptr.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/gdbstub64.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 2e2bc2700b..d59272fdbb 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -431,6 +431,7 @@ static void handle_q_memtag(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
     CPUARMState *env = &cpu->env;
+    uint32_t mmu_index;
 
     uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
     uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
@@ -454,8 +455,10 @@ static void handle_q_memtag(GArray *params, void *user_ctx)
         gdb_put_packet("E03");
     }
 
+    /* Find out the current translation regime for probe. */
+    mmu_index = arm_mmu_idx(env) & ARM_MMU_IDX_COREIDX_MASK;
     /* Note that tags are packed here (2 tags packed in one byte). */
-    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
                                     MMU_DATA_LOAD, true, 0);
     if (!tags) {
         /* Address is not in a tagged region. */
@@ -474,13 +477,16 @@ static void handle_q_isaddresstagged(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
     CPUARMState *env = &cpu->env;
+    uint32_t mmu_index;
 
     uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
 
     uint8_t *tags;
     const char *reply;
 
-    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+    /* Find out the current translation regime for probe. */
+    mmu_index = arm_mmu_idx(env) & ARM_MMU_IDX_COREIDX_MASK;
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
                                     MMU_DATA_LOAD, true, 0);
     reply = tags ? "01" : "00";
 
@@ -491,6 +497,7 @@ static void handle_Q_memtag(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
     CPUARMState *env = &cpu->env;
+    uint32_t mmu_index;
 
     uint64_t start_addr = gdb_get_cmd_param(params, 0)->val_ull;
     uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
@@ -523,8 +530,10 @@ static void handle_Q_memtag(GArray *params, void *user_ctx)
      * Get all tags in the page starting from the tag of the start address.
      * Note that there are two tags packed into a single byte here.
      */
-    tags = allocation_tag_mem_probe(env, 0, start_addr, MMU_DATA_STORE,
-                                    8 /* 64-bit */, MMU_DATA_STORE, true, 0);
+    /* Find out the current translation regime for probe. */
+    mmu_index = arm_mmu_idx(env) & ARM_MMU_IDX_COREIDX_MASK;
+    tags = allocation_tag_mem_probe(env, mmu_index, start_addr, MMU_DATA_STORE,
+                                    1, MMU_DATA_STORE, true, 0);
     if (!tags) {
         /* Address is not in a tagged region. */
         gdb_put_packet("E04");
-- 
2.34.1


