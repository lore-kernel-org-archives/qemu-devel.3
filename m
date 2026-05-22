Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC42CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQQ-0005oY-Af; Thu, 21 May 2026 20:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOZ-00031Q-QY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:47 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOU-0004lU-QH
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:41 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c82de129a40so2968004a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408334; x=1780013134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdRCTKqwYjAfoCGZfOYovk2SgjN3/GdS8UdccC2w3yQ=;
 b=Y67NNsT57fp6oFVEnTmeytgOZq6QtFqFyMI16OdRIwpuBEnNsatAJEFqLIzYXiAbeW
 Xz9idmyENphg42CNOgH3AxUbbYPl4Lw6W88lECoRHWlDrSlHM8McrriavZIL4XnD7kEv
 deCHz+bfz8/fimseKfHTUPJReGenFsu2IkQofPLjzt/kTOiDJsbBCnBna9g3/XCea9TW
 gZJ7DNWgT/Y7LrK91lzNCyYaXUQbad/uv7+43rrmBDRwNUbHGFzgfzP+zzcuV9pJHQYU
 A9c7QP1UCq3GjVcwQsYrSo6WHXKtLU6e5b5KuCIV3JFbPJHGJvSuonYwDVdHLsW/0yKH
 5saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408334; x=1780013134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AdRCTKqwYjAfoCGZfOYovk2SgjN3/GdS8UdccC2w3yQ=;
 b=sauQczkIbKgzik0gX+ZHvhHCi3NfqTOMS6GrKTCH3YYwBOzHpWrxzt+DNCzf3G5mAv
 7rS4xn8e7730XoxB5mU2JjFv7CngJorzjTbksp5hnJdS2ltLK/mx3ppxLYsnhk5vM0Ni
 MtTSvUqU5/TEtjmYWatkurIfn2WHP7uj1zSAfod/uwytChIeLfglP1i7Srbd7lb+6sXn
 13raXhEXu/ADzeNi8Ed4pGG56ak8UNJtkTkFLU0LYZpvAS7q2dtjjtyUf9kK9o+ahlcR
 fAvA5Pg9j0TzZCfMP0zMz/kJZ1phW0lc6ejlYaSa22V35HRF7U5Lu5lg/FC7WCLXg5lc
 9iug==
X-Gm-Message-State: AOJu0YyQLmqA/FPnzAQbvmB3yOO0KsOSeNP3FXFczTywTodrzXj7pANQ
 TdGnlkE8K+fyBr6O/yTalRJtVEijAYjls3mT2ZC+CulE+8qlL4YsmJos8s7Sdj76
X-Gm-Gg: Acq92OGgedcVPPEldeDJjOqir8WeZdm/gRoSJJR3HsupAtfNki8jIJrl+C3SgA198xO
 0/c8BEkU1U30Ls2WER25KZ3ODA7L/cnm+kWKi7qlK+IhQTa6fIq+ReRMRL75JBLJTgFEPmiRtIQ
 //xVyL5acZ+oFtOQHm2ucmlgKy7gX9HTri7DcgrK8ppF65CykDocCXNvbdSl+CgrYk3ZtUeH8kt
 ilXky0bUVrUu5y4FfmNivGdF4ddHlt/RCuduldDdlgAX6odn+VGuyc45HfFk3Chh9t+xapDQ4UB
 6YFTeYg5358qxRQR5E+R4E0X0vmfVqoSf48zuZP53rPqrkMGZRFBZBOeLLyAdnN5e94dOoWqmWD
 obT+58KCT+XwXQOZL3f+fvFA7wH7USz/dvvUNt6METKHKXFGErYX9AvwtNwGbOsp+bhQKsNGisz
 4yj8ShXWfNRsYuJG9RG7dlFiWx8TAy3EoxJ5OPXwcHzmI/l2kS4T7v
X-Received: by 2002:a17:903:2b0c:b0:2ae:825b:49a5 with SMTP id
 d9443c01a7336-2beb0582ba0mr10821545ad.0.1779408333838; 
 Thu, 21 May 2026 17:05:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/48] target/riscv: do not set defaults in cpu prop callback
Date: Fri, 22 May 2026 10:03:13 +1000
Message-ID: <20260522000324.23255-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Do not rely on riscv_cpu_* arrays to set rv32/rv64 CPU defaults - add
them to the CPU definition like we do with all other CPUs (aside from
'max').

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-13-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 40 ++++++++++++++++++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c | 14 -------------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 64e3fa4ef0..5d3383f335 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3076,6 +3076,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV32,
         .misa_mxl_max = MXL_RV32,
+
+        /*  Default extensions as of QEMU 11.1.  */
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicbop = true,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintntl = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zawrs = true,
+        .cfg.ext_zfa = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svadu = true,
+        .cfg.ext_svvptc = true,
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
@@ -3128,6 +3148,26 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
         .misa_mxl_max = MXL_RV64,
+
+        /*  Default extensions as of QEMU 11.1.  */
+        .cfg.ext_zicbom = true,
+        .cfg.ext_zicbop = true,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_zicntr = true,
+        .cfg.ext_zicsr = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zihintntl = true,
+        .cfg.ext_zihintpause = true,
+        .cfg.ext_zihpm = true,
+        .cfg.ext_zawrs = true,
+        .cfg.ext_zfa = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svadu = true,
+        .cfg.ext_svvptc = true,
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 50d9218a75..7575884d7e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1553,24 +1553,10 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
 static void cpu_add_multi_ext_prop(Object *cpu_obj,
                                    const RISCVCPUMultiExtConfig *multi_cfg)
 {
-    bool generic_cpu = riscv_cpu_is_generic(cpu_obj);
-
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
                         cpu_set_multi_ext_cfg,
                         NULL, (void *)&multi_cfg->offset);
-
-    if (!generic_cpu) {
-        return;
-    }
-
-    /*
-     * Set def val directly instead of using
-     * object_property_set_bool() to save the set()
-     * callback hash for user inputs.
-     */
-    isa_ext_update_enabled(RISCV_CPU(cpu_obj), multi_cfg->offset,
-                           multi_cfg->enabled);
 }
 
 static void riscv_cpu_add_multiext_prop_array(Object *obj,
-- 
2.53.0


