Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E43AC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 22:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rakPU-0005mb-2P; Thu, 15 Feb 2024 17:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPR-0005lr-K6
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:49 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPP-0006Dz-N8
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:49 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-364efe11f6aso7218525ab.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 14:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708036845; x=1708641645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37fZ+kvSrgmRxrOauqN5Kq+ehbdNsQUKhRww2rKUEUs=;
 b=n+IdDF6Z39Fgup4nNU9ww+62L3PL8j4AGF3Mge6rSLTvB9Oq5gw4caQvJSSTBImDkA
 Y4Bbaot0kT/ZNJSyquwqqT3Avh+yQlt6fILU7mwnJNzXHpDM5zQGJqkJv5OSBbRmz5yD
 ZBJk7eqcn4MdMdJHJxU2uykNMYk5xEzg9nukSRSYdbCDvWX3neiGvVghOXoshSsJH5GR
 zsShQ4lzXa0OEskgbQRaeEFdVyROEMwYAa+mnc1WDCFb9DDPDv0ZuBrDe0r7Qoa1P1zP
 hxgtOhRFNXrCYMh0a0PhnhVf86ohpowNC6Wxb+tPK8FtKHH56taYRcyh4wZWtODkLCnZ
 MQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708036845; x=1708641645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37fZ+kvSrgmRxrOauqN5Kq+ehbdNsQUKhRww2rKUEUs=;
 b=hI265HjcgEYjE1KLRMpkxyJeRCg/PkentjjyTsFFRIIUJQtYUnRKbCWIKfcB3v2Jzg
 H6l6MxDIZFpgildGP93bJXYdBrm0NpPQgeWv7YWXWqVQBFlUHlijLAWrRvo+9pJ9FfrG
 abIWdARFIfu8MbOxVwLxzkyF3egSYT6UabB4IdYzOhucz30+wLorXv5FpjMTWdzUBg3u
 +SbHB0pvmBGCUupa8JGM2qIpTK/PS2FmEs04v32RxLxnEKyXU4XFu6edyDqAsG68z7sw
 1wjSJuAZbg+dnZPC9ekNsKZXBy/2pITksElzBzd10CCZmKU5t8VFUhKy0OUr1qk7hzzV
 /7Yw==
X-Gm-Message-State: AOJu0YyItpU69cX027lg7O/y/mKqWG/HRKY1llmCn34Ir9D0dWdueYJq
 FJlhfrzwL47LQG36aCH/DfOTcw9tIvSNSomb6OiqdZr5QXcdd4UmCM7GKO7SQwx8TeBuOUW/wg3
 I
X-Google-Smtp-Source: AGHT+IGD65iL4k1paZbPg2f7bi3JnC/azY7+Pr4To4vjojjsf39wf4dEYMizyQ8nOfwEfbD6c0W0WQ==
X-Received: by 2002:a92:c901:0:b0:363:dfc7:acc2 with SMTP id
 t1-20020a92c901000000b00363dfc7acc2mr3585472ilp.12.1708036845103; 
 Thu, 15 Feb 2024 14:40:45 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j2-20020a170902758200b001db40866e25sm1733679pll.308.2024.02.15.14.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 14:40:44 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 6/6] target/riscv: Promote svade to a normal extension
Date: Thu, 15 Feb 2024 19:39:55 -0300
Message-ID: <20240215223955.969568-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215223955.969568-1-dbarboza@ventanamicro.com>
References: <20240215223955.969568-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Andrew Jones <ajones@ventanamicro.com>

Named features are extensions which don't make sense for users to
control and are therefore not exposed on the command line. However,
svade is an extension which makes sense for users to control, so treat
it like a "normal" extension. The default is false, even for the max
cpu type, since QEMU has always implemented hardware A/D PTE bit
updating, so users must opt into svade (or get it from a CPU type
which enables it by default).

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 9 ++-------
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7598daa162..fd0c7efdda 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1474,6 +1474,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
+    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
@@ -1589,7 +1590,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
  * and priv_ver like regular extensions.
  */
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
-    MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
 
     /*
@@ -2237,8 +2237,6 @@ static RISCVCPUProfile RVA22U64 = {
  * Other named features that we already implement: Sstvecd, Sstvala,
  * Sscounterenw
  *
- * Named features that we need to enable: svade
- *
  * The remaining features/extensions comes from RVA22U64.
  */
 static RISCVCPUProfile RVA22S64 = {
@@ -2250,10 +2248,7 @@ static RISCVCPUProfile RVA22S64 = {
     .ext_offsets = {
         /* rva22s64 exts */
         CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svpbmt),
-        CPU_CFG_OFFSET(ext_svinval),
-
-        /* rva22s64 named features */
-        CPU_CFG_OFFSET(ext_svade),
+        CPU_CFG_OFFSET(ext_svinval), CPU_CFG_OFFSET(ext_svade),
 
         RISCV_PROFILE_EXT_LIST_END
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ccfb7b2dd3..ab6db817db 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1282,6 +1282,12 @@ static void riscv_init_max_cpu_extensions(Object *obj)
         isa_ext_update_enabled(cpu, prop->offset, true);
     }
 
+    /*
+     * Some extensions can't be added without backward compatibilty concerns.
+     * Disable those, the user can still opt in to them on the command line.
+     */
+    cpu->cfg.ext_svade = false;
+
     /* set vector version */
     env->vext_ver = VEXT_VERSION_1_00_0;
 
-- 
2.43.0


