Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E7C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmz0G-0003MY-K2; Wed, 20 Mar 2024 12:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmz0E-0003L1-Bj
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:41:22 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmz06-0008RQ-Kw
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:41:22 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513e10a4083so86550e87.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710952872; x=1711557672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MGzMRq8+oQNHPDVeF5CNwlMfCJsHa78ZS0ftBV8+1s=;
 b=gfRAEVYkeMTqL3YEGlzNlTGYXSkLeHDKHwTx61+Q5TTtUQrMf5BlPuLCco9OXWAD+r
 uUC96TE2HowH902/0AdA/BhyV7Jul61MIp5AB2mMKROsxBRZbJGSVPLYC6EqTCO529Il
 tDfOQEwxWtlgxRNFNzJdVhVG34T5ElawQLrQ8NyapJVkkXXALwZLo2tGAiDbVUbw0DbA
 GwEfApFIzXS895tkXyx7OJ2w8HY+9Ixxc1qVgueGYQX1uTmFfL2TgF2xeiWNFzVoRWDC
 RR2IY+9MYZRNd5Kil+cgAwEzk6jmFYdt+0bStECm3dZkwpbvKccErIqstQR5CTUg5eW0
 JO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710952872; x=1711557672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MGzMRq8+oQNHPDVeF5CNwlMfCJsHa78ZS0ftBV8+1s=;
 b=fYBCAYUb6Zof+yVQdiDkQSqYfehEXua/9xcnAHVcTkMymzKMZvWrz37pURic5hvoKu
 3iMx7Wvtn+xd8xyOmSABRSenv2vvDcA2bL+5CNust0rVjds5rkm0fXOZJbjezq6BTf+m
 Ggynpuo+EBWbG1lRt/amkyoEbbrOp5MNNX9kQDtuLuXrIm7vPqMz0hl1QcdOM8NGZqzJ
 zHSXb0L0pbnSiL6rglFdW8qXnjpGpS6Ojl47gn+Z1CjCcOeCmdVwmKVeKIKhwv7il17m
 Jdaqf2QwE7++A9A63w+XWkk9kpN5Gh0lO+RiQnnr0TTmqRqIldFwx/XSacVRMxiauQOz
 8Osg==
X-Gm-Message-State: AOJu0YwUQTBGoQ9xJYEjezxZHq2rgAJuSPbmkyVmj5Rm2LKfuluc/7C+
 JESWz5E33YppEWacTvCuSjcMWh2JpsuRl6hKWIyjW9hw+AY7ZHRxLA5GpCA2sYcZnQG8oGGh2O/
 j
X-Google-Smtp-Source: AGHT+IGyIcGj6kJEYwSOFV207y3u8LtBd+6FQA7rHX4T0Ccn2tiB/M1/bssgAa0PLO1UIhpWj86oAw==
X-Received: by 2002:a05:6512:3687:b0:513:b1d7:6d07 with SMTP id
 d7-20020a056512368700b00513b1d76d07mr11689233lfs.58.1710952872399; 
 Wed, 20 Mar 2024 09:41:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.156.105])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a5d60cb000000b0033eca2cee1asm15131511wrt.92.2024.03.20.09.41.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Mar 2024 09:41:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH-for-9.0 2/2] target/monitor: Deprecate 'info tlb' and 'info
 mem' commands
Date: Wed, 20 Mar 2024 17:40:55 +0100
Message-ID: <20240320164055.60319-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240320164055.60319-1-philmd@linaro.org>
References: <20240320164055.60319-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

'info tlb' has been replaced by 'info mmu -t', and
'info mem' by 'info mmu -m'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst    | 10 ++++++++++
 include/monitor/hmp-target.h |  2 ++
 monitor/hmp-cmds-target.c    | 20 ++++++++++++++++----
 target/i386/monitor.c        |  4 ++--
 target/m68k/monitor.c        |  2 +-
 target/nios2/monitor.c       |  2 +-
 target/ppc/ppc-qmp-cmds.c    |  2 +-
 target/riscv/monitor.c       |  2 +-
 target/sh4/monitor.c         |  2 +-
 target/sparc/monitor.c       |  2 +-
 target/xtensa/monitor.c      |  2 +-
 hmp-commands-info.hx         |  8 ++++----
 12 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b548519b5..4f5f4becbe 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -158,6 +158,16 @@ points was removed in 7.0. However QMP still exposed the vcpu
 parameter. This argument has now been deprecated and the remaining
 remaining trace points that used it are selected just by name.
 
+Human Monitor Protocol (HMP) commands
+-------------------------------------
+
+``info tlb`` and ``info mem`` (since 9.0)
+'''''''''''''''''''''''''''''''''''''''''
+
+The ``info tlb`` and ``info mem`` commands have been replaced by
+the ``info mmu`` command, which has the same behaviour but a less
+misleading name.
+
 Host Architectures
 ------------------
 
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 2af84b1915..057f7c6841 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -46,7 +46,9 @@ CPUState *mon_get_cpu(Monitor *mon);
 
 void hmp_info_mmu(Monitor *mon, const QDict *qdict);
 void hmp_info_mem(Monitor *mon, const QDict *qdict);
+void hmp_info_mem_deprecated(Monitor *mon, const QDict *qdict);
 void hmp_info_tlb(Monitor *mon, const QDict *qdict);
+void hmp_info_tlb_deprecated(Monitor *mon, const QDict *qdict);
 void hmp_mce(Monitor *mon, const QDict *qdict);
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 71bce4870a..086b58b8d6 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -382,19 +382,31 @@ void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
 #endif
 
 __attribute__((weak))
-void hmp_info_mem(Monitor *mon, const QDict *qdict)
+void hmp_info_mem_deprecated(Monitor *mon, const QDict *qdict)
 {
     monitor_puts(mon,
                  "No per-CPU mapping information available on this target\n");
 }
 
 __attribute__((weak))
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb_deprecated(Monitor *mon, const QDict *qdict)
 {
     monitor_puts(mon,
                  "No per-CPU TLB information available on this target\n");
 }
 
+void hmp_info_mem(Monitor *mon, const QDict *qdict)
+{
+    monitor_puts(mon, "This command is deprecated, please use 'info mmu -m'\n");
+    hmp_info_mem_deprecated(mon, qdict);
+}
+
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    monitor_puts(mon, "This command is deprecated, please use 'info mmu -t'\n");
+    hmp_info_tlb_deprecated(mon, qdict);
+}
+
 void hmp_info_mmu(Monitor *mon, const QDict *qdict)
 {
     bool tlb = qdict_get_try_bool(qdict, "tlb", false);
@@ -410,9 +422,9 @@ void hmp_info_mmu(Monitor *mon, const QDict *qdict)
     }
 
     if (mem) {
-        hmp_info_mem(mon, qdict);
+        hmp_info_mem_deprecated(mon, qdict);
     }
     if (tlb) {
-        hmp_info_tlb(mon, qdict);
+        hmp_info_tlb_deprecated(mon, qdict);
     }
 }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 3a281dab02..5da77b6b22 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -217,7 +217,7 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env)
 }
 #endif /* TARGET_X86_64 */
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb_deprecated(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env;
 
@@ -545,7 +545,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 }
 #endif /* TARGET_X86_64 */
 
-void hmp_info_mem(Monitor *mon, const QDict *qdict)
+void hmp_info_mem_deprecated(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env;
 
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 2bdf6acae0..ea303805c4 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -10,7 +10,7 @@
 #include "monitor/hmp-target.h"
 #include "monitor/monitor.h"
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb_deprecated(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
diff --git a/target/nios2/monitor.c b/target/nios2/monitor.c
index 0152dec3fa..2e4efee1aa 100644
--- a/target/nios2/monitor.c
+++ b/target/nios2/monitor.c
@@ -27,7 +27,7 @@
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb_deprecated(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index a25d86a8d1..891fdc44ef 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -80,7 +80,7 @@ static target_long monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
     return cpu_ppc_load_tbl(env);
 }
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb_deprecated(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index f5b1ffe6c3..00f2a22f11 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -208,7 +208,7 @@ static void mem_info_svxx(Monitor *mon, CPUArchState *env)
               last_paddr + last_size - pbase, last_attr);
 }
 
-void hmp_info_mem(Monitor *mon, const QDict *qdict)
+void hmp_info_mem_deprecated(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env;
 
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 2da6a5426e..ad6f21defe 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -39,7 +39,7 @@ static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
                    tlb->d, tlb->wt);
 }
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb_deprecated(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     int i;
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 73f15aa272..95e6217568 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -28,7 +28,7 @@
 #include "monitor/hmp.h"
 
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb_deprecated(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index fbf60d5553..92bfad8129 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -27,7 +27,7 @@
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb_deprecated(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index e31f2467fb..0066b49ceb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -228,14 +228,14 @@ ERST
         .name       = "tlb",
         .args_type  = "",
         .params     = "",
-        .help       = "show virtual to physical memory mappings",
+        .help       = "deprecated synonym for 'info mmu -t'",
         .cmd        = hmp_info_tlb,
     },
 #endif
 
 SRST
   ``info tlb``
-    Show virtual to physical memory mappings.
+    This is a deprecated synonym for the mmu command.
 ERST
 
 #if defined(TARGET_I386) || defined(TARGET_RISCV)
@@ -243,14 +243,14 @@ ERST
         .name       = "mem",
         .args_type  = "",
         .params     = "",
-        .help       = "show the active virtual memory mappings",
+        .help       = "deprecated synonym for 'info mmu -m'",
         .cmd        = hmp_info_mem,
     },
 #endif
 
 SRST
   ``info mem``
-    Show the active virtual memory mappings.
+    This is a deprecated synonym for the mmu command.
 ERST
 
     {
-- 
2.41.0


