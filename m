Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E2CA101C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5D0-0004hU-45; Thu, 04 Sep 2025 04:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu5BQ-0001ed-Qg
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:19:05 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu5B5-0008FY-If
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:19:03 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b02c719a117so133998266b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973920; x=1757578720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+88w9AQZ9cLJwlirAZW/BDB9U/6ab+UNG3qEc9GZaw4=;
 b=SotsXNhvubW40QhTGxC3eT01ZIqLeraaEIRNr3ZqKiHMMOPWaw6yQuQ15+T/xz6qQ2
 NH3vAhzKpa0EwBs5eVp2wd85V6zCcOerHt/zc4EC9BZ6ohE+GLizEfIczBqBlqwArTfm
 tMexoLBTHkYAU12E9bEHnjmMh2Xmu1q6qwL+/eoowngMi5X1MVE3rP/bgAqF10gcnYLP
 lEMhiGljmxY0E5qlK63ZaFsD+UNQq6QRYmJcHQXlSuifwiMNk8NbwXMuU+uPK8ij0mR0
 CtZaXOeAtLocDc3eY6N5rKcPh4MzFKvHp8GbJ2j1CX3tzEMsSznwfVMzibdic7xN3GaR
 v2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973920; x=1757578720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+88w9AQZ9cLJwlirAZW/BDB9U/6ab+UNG3qEc9GZaw4=;
 b=XXNNis0435L4eVyCb3Pc/M9XEAdJkvSjZ12T109mjQKStsDsnyFjuY22s9wF9NmQbP
 tiJtohpU4lgMRJDHnhnLDZ9n68iGFiiFgz+xWp9PtaeWYk1YHQir7KFVYjOX5v0JQ9LP
 hWKiigPg3fSocKaqiESDuxW+iELri0Qsfxu0DWzK+TK/bSLrIQ4ZXlxZivjFElWKYbG7
 NHMR4PRqK6YiiM5SO+rCamLOIWQps3EcRyJokATfWFe7RN+PAoIkAoR4phmeoCoyYALV
 tDPFoK3cJxhxHWsJnVddqmavoFosQ4NdCZIpOkARZNiURkJrnGI3Cs20zthHk1FdG4xs
 v07g==
X-Gm-Message-State: AOJu0Yw2MeNwHVzpCgyKYqpHYCmOj+u1oTaCFcz1uazyD9OGmoJ3dQYg
 r81rLpXyTjhBRFI5Ji6efVbcrndbKCk1qlewlSaY8CpP5IBS2HelEG36/ylRYtVTAuohyiNZCH4
 YwRbpA9Ax7A==
X-Gm-Gg: ASbGncsRo8LlMHFGTxT3ca8A814xHHdsaaRdbDx9rUuhZgpy6GjpFWYXr53z440ICV2
 oqG/2Nd6CY1Sp8w3ZWAq6r7myArQJHw5U/952mZzCMlcll1Yu1YQgEZRsSgpf4E5xT4RcMcSfpm
 1zQO7RWGKPDQxzsZH9Sr7+I/LjOnz79o8s1dEVultHbJRSWJpeK/zS39GfKi4FXlrHRngQp0wZc
 hUZRDXXzjc6IFEyFwd1GbO4IUnXHmyC6eMk3+UA+tYmvlakGqFUp76Bj9t4xsLvtAhc5sx3D+Yr
 9iV6WVl/fv3c0fe9q3lht6K3IwBEOdDwDH64/JVZaMnqSInu5O+2/rw8CDIfRpZZQ/eqVVolGjc
 i5iomYS5OTiOMPCq0ztTYujk=
X-Google-Smtp-Source: AGHT+IGxjVBN0FQryOFHW7NPMAzsYYrdCtTTvqWBsGarhpRXGfdwEbKrpxErVnpLvup6bLCipLULiA==
X-Received: by 2002:a17:906:4fca:b0:b04:6546:347e with SMTP id
 a640c23a62f3a-b0465463a5bmr592167766b.51.1756973919569; 
 Thu, 04 Sep 2025 01:18:39 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0425ce98f1sm977746666b.67.2025.09.04.01.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:18:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5504A60AF7;
 Thu, 04 Sep 2025 09:11:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Laurent Vivier <lvivier@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org,
 Mads Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 087/281] linux-user/riscv: Create init_main_thread
Date: Thu,  4 Sep 2025 09:08:01 +0100
Message-ID: <20250904081128.1942269-88-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c        |  7 +------
 linux-user/riscv/cpu_loop.c | 10 ++++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 16aa09214e8..556f11d720d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -849,12 +849,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->sepc = infop->entry;
-    regs->sp = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_EXEC_PAGESIZE 4096
 
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 2dd30c7b288..b3162815320 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -94,14 +94,12 @@ void cpu_loop(CPURISCVState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
+    CPUArchState *env = cpu_env(cs);
 
-    env->pc = regs->sepc;
-    env->gpr[xSP] = regs->sp;
+    env->pc = info->entry;
+    env->gpr[xSP] = info->start_stack;
     env->elf_flags = info->elf_flags;
 
     if ((env->misa_ext & RVE) && !(env->elf_flags & EF_RISCV_RVE)) {
-- 
2.47.2


