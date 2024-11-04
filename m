Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58752D11199
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krM-0006X6-SO; Sun, 03 Nov 2024 19:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqt-0005JN-0F; Sun, 03 Nov 2024 19:21:53 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqr-0002j2-EH; Sun, 03 Nov 2024 19:21:50 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e8235f0b6so3172058b3a.3; 
 Sun, 03 Nov 2024 16:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679707; x=1731284507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvmgHv54ktpg3v0jpm0c0B4J0dywq59PujDGLDVe7UA=;
 b=X7bpXP5v3QTH8MzEyKTlkwNvNvdduzE5Yny3DcT+cz5skVi3uqazUUM5Z3R2zim5L6
 BnVMNcNodgdvCqKVx5sbN9TZr74TolFuoXQYwxakmZ4MoUwDVcWaJlEIx3iPjMwXJN7q
 JlSYeZ0M6f0J4hm8wxC+HNE8ZMjEqzmcZFxvLCGVIRF82pj8CZiazoM/BX9WfaE9eTMM
 502AiuBfl+UkLz9mKrpmSdYZZAR5Sb+5K25n9m6cPbVfW2jZXOL1hHm9AcvKbQz9GY8p
 ecNWov5wHnrlrJhwhjjsbVFon5P7U03lS+433s8zigQ61dZdB9jLrcOVOCZPdifwb4jF
 9g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679707; x=1731284507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvmgHv54ktpg3v0jpm0c0B4J0dywq59PujDGLDVe7UA=;
 b=VeCeyfn2eP6sEo/gjfoV6rD6ZTZF60bOFjz0dXHoEnC8XGaZZJotunGjGRDvSvj9EW
 Mh1QexiNSNPS30f5gg+Dsc0DvWrdM5yh1xCq4iT+2vFBA6Tue5ZjHzYE3Zq9xPu9CG8u
 bSWwU6EHFxG9lJmKGN+0+59xJTLBkwwB1CE3IWwmEymT5Sq2L0SyhJkbTWTdDTPl8rfr
 3tPaA7V5D+3mJSp5rsXhERTv98YjYdVrZvur3lYL95e6YObNtBS/scdqIb7SkSrEQsKb
 pxSv+kh/hsbpV6NBd9zsEMVUYlSrro3360VjvFbfrrtOqhtdVXcV9F/QrWqP5p9nESS6
 JkRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQLF+XKwc9KGfIwY3zyLjyYZ2GEibKS8h5paPUKmoo5/xEE/ArLEGPDuvbulF/vYGhSm2DX1ZWeQ==@nongnu.org
X-Gm-Message-State: AOJu0YwCqUq6SLsGSBhSgJ36/kS71TzArhfBCzLi+MPh0n7SFiH6+R4j
 6vezwWGJZMnpTHshJJozM4NJQTJ3wp1TCADStb6lSO4xqCRbUQ06Wn0xJw==
X-Google-Smtp-Source: AGHT+IHf2k2rFyKx/oYDd7VKNMJgZb18H0K+eAXGkNorltp9PjXmDXj8nAOqVPEQXFt64Av2EZYsww==
X-Received: by 2002:a05:6a00:10cd:b0:71e:634e:fe0d with SMTP id
 d2e1a72fcca58-720b9c05526mr21510104b3a.12.1730679706971; 
 Sun, 03 Nov 2024 16:21:46 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Harsh Prateek Bora <harshb@linux.ibm.com>
Subject: [PULL 43/67] target/ppc: reduce duplicate code between
 init_proc_POWER{9, 10}
Date: Mon,  4 Nov 2024 10:18:32 +1000
Message-ID: <20241104001900.682660-44-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Historically, the registration of sprs have been inherited alongwith
every new Power arch support being added leading to a lot of code
duplication. It's time to do necessary cleanups now to avoid further
duplication with newer arch support being added.

Signed-off-by: Harsh Prateek Bora <harshb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 58 +++++++++----------------------------------
 1 file changed, 12 insertions(+), 46 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c26e5b269c..6f352550db 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6410,7 +6410,7 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
 #endif /* CONFIG_USER_ONLY */
 
 #define POWER9_BHRB_ENTRIES_LOG2 5
-static void init_proc_POWER9(CPUPPCState *env)
+static void register_power9_common_sprs(CPUPPCState *env)
 {
     /* Common Registers */
     init_proc_book3s_common(env);
@@ -6429,7 +6429,6 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power5p_ear_sprs(env);
     register_power5p_tb_sprs(env);
     register_power6_common_sprs(env);
-    register_HEIR32_spr(env);
     register_power6_dbg_sprs(env);
     register_power7_common_sprs(env);
     register_power8_tce_address_control_sprs(env);
@@ -6447,16 +6446,21 @@ static void init_proc_POWER9(CPUPPCState *env)
     register_power8_rpr_sprs(env);
     register_power9_mmu_sprs(env);
 
-    /* POWER9 Specific registers */
-    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
-                     spr_read_generic, spr_write_generic,
-                     KVM_REG_PPC_TIDR, 0);
-
     /* FIXME: Filter fields properly based on privilege level */
     spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
                         spr_read_generic, spr_write_generic,
                         KVM_REG_PPC_PSSCR, 0);
 
+}
+
+static void init_proc_POWER9(CPUPPCState *env)
+{
+    register_power9_common_sprs(env);
+    register_HEIR32_spr(env);
+    /* POWER9 Specific registers */
+    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
+                     spr_read_generic, spr_write_generic,
+                     KVM_REG_PPC_TIDR, 0);
     /* env variables */
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
@@ -6562,50 +6566,12 @@ static struct ppc_radix_page_info POWER10_radix_page_info = {
 #define POWER10_BHRB_ENTRIES_LOG2 5
 static void init_proc_POWER10(CPUPPCState *env)
 {
-    /* Common Registers */
-    init_proc_book3s_common(env);
-    register_book3s_207_dbg_sprs(env);
-
-    /* Common TCG PMU */
-    init_tcg_pmu_power8(env);
-
-    /* POWER8 Specific Registers */
-    register_book3s_ids_sprs(env);
-    register_amr_sprs(env);
-    register_iamr_sprs(env);
-    register_book3s_purr_sprs(env);
-    register_power5p_common_sprs(env);
-    register_power5p_lpar_sprs(env);
-    register_power5p_ear_sprs(env);
-    register_power5p_tb_sprs(env);
-    register_power6_common_sprs(env);
+    register_power9_common_sprs(env);
     register_HEIR64_spr(env);
-    register_power6_dbg_sprs(env);
-    register_power7_common_sprs(env);
-    register_power8_tce_address_control_sprs(env);
-    register_power8_ids_sprs(env);
-    register_power8_ebb_sprs(env);
-    register_power8_fscr_sprs(env);
-    register_power8_pmu_sup_sprs(env);
-    register_power8_pmu_user_sprs(env);
-    register_power8_tm_sprs(env);
-    register_power8_pspb_sprs(env);
-    register_power8_dpdes_sprs(env);
-    register_vtb_sprs(env);
-    register_power8_ic_sprs(env);
-    register_power9_book4_sprs(env);
-    register_power8_rpr_sprs(env);
-    register_power9_mmu_sprs(env);
     register_power10_hash_sprs(env);
     register_power10_dexcr_sprs(env);
     register_power10_pmu_sup_sprs(env);
     register_power10_pmu_user_sprs(env);
-
-    /* FIXME: Filter fields properly based on privilege level */
-    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
-                        spr_read_generic, spr_write_generic,
-                        KVM_REG_PPC_PSSCR, 0);
-
     /* env variables */
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
-- 
2.45.2


