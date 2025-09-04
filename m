Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBB0CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5Af-0000GQ-OH; Thu, 04 Sep 2025 04:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu55e-000728-AY
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:13:06 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54y-0004Kj-35
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:13:04 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b042cc3954fso129341366b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973533; x=1757578333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EbVn5eJ4TWHIldxY30gfc+9eY3s2xC+za4HvKYilBo=;
 b=gl0mOPL07G2HE3NCvmWd+aGklYmuARNHb3+uHuQXZ7QjHrq0oPBgo8q9I0eR2QXRVA
 /9r3Md7QbkOsOXL2/ApZ3jhivD9E8Su0LpZbyPpEfxzdfqCegRsWkO6hukZQsUya07jI
 2Yja6NrB4XVM2ISHD8OyIKbnOgj8efr4UJFEWCI+6dHGYDWw/j5Pf880yHTvsZH/Xirl
 OUP3wm9gcUtTfp59cgX64xOaRkay/DU58W7Bf9L/ZMOmhMg5e1N8tLcQuq6h05EwkiRP
 f4fZvelbMWnlaqS41SCkH2nS4zW6w691LAwgkQxAStBwf7ubvaAK+Lin1UvPCCQvRMeR
 IS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973533; x=1757578333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EbVn5eJ4TWHIldxY30gfc+9eY3s2xC+za4HvKYilBo=;
 b=bsJTcewQtjSiF5AvOBMhPozOM/uJvfDqVee9x/VtH1dg7WorzWNXkSQUhv365d7+8X
 WthCeECuhlmT2U3UCfLMZ0xW933lKeO9ukFYyY4qakBecdCul6hImp+HPmU/N+HT80nL
 ZfQ0yvpQcMzPxKdnn0Oht5H7TDDnmIcPq9raN4Yc7TXtMlW07pZtNa2YbV4Ku17ibxar
 /lgSPm8xhsYhni18kJbfeyZzlG/mitnaz5W4yroJidVqLJfAUM9MAKDVp2n4v+MMjZ7/
 Vo3epIQdahGMAwTwJ95ezJIZQqpTHc75y/ZLxW6uCjffgXp87jmZLwPWPr8VKmt65wdH
 PlcA==
X-Gm-Message-State: AOJu0YyhXyae5bbOdPJ5srlf9bWCEKXeJOfUtFOOLJ5JP2q0/KUaLbHv
 axMyPqWKmUvtR2x9TXgUanQxpZCOJsVeQPJ5lsm9yZA0+TMMNkaNZjTlQ5EyrpzZv4t2zJoHRz8
 rVoe2KdvvXw==
X-Gm-Gg: ASbGncv94IuhW1qRUI1urk8lyqax0V2JiYlgjadQFhJ9b5/BZiv4XIajz/nd1Po/vGN
 r4mFUFO2USCdUjqFbqIM2ywJii/ibNQrfQVRyPeQa/u0SWYSPZafyOnn4R/vaJnHpF8dBcPEzJ0
 slTRMALXuM9GJCNIh3IbmHsKr83FmAgYhTsvT8ZlLmXi24LaCqAddDHQuGZMKoRYX2YXN+0RBkd
 J8TxOenLjCSiSIOM5XafN+Pkv4ljTEzau770Kl8rD6SGhDCojT7o7QyYAS1bQaVNm+A95LY6ha1
 fucxfRdXcYZqiwvTNgs9yOmqgM0se4CBxFLkTct+viSGpqlgwu9D4vC3TBkVbw8cjdPi/Opeuxa
 35g4LNdY/mQ2I/xyMQRA4Mcg=
X-Google-Smtp-Source: AGHT+IGE72xujCzrpuvniQ2ueJZ4x/ss9sVMxOq4r/64b7nh3Vp6WuzYsL8MWp7c3HyS0dLplsfeZA==
X-Received: by 2002:a17:907:7253:b0:af9:8438:de48 with SMTP id
 a640c23a62f3a-b01d978f785mr1865512266b.48.1756973533095; 
 Thu, 04 Sep 2025 01:12:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04190700a4sm1095117366b.63.2025.09.04.01.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:12:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F184860AED;
 Thu, 04 Sep 2025 09:11:38 +0100 (BST)
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
Subject: [PATCH v2 084/281] linux-user/m68k: Create init_main_thread
Date: Thu,  4 Sep 2025 09:07:58 +0100
Message-ID: <20250904081128.1942269-85-alex.bennee@linaro.org>
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
 linux-user/elfload.c       | 11 +----------
 linux-user/m68k/cpu_loop.c | 25 ++++++-------------------
 2 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8604308a310..46150586aff 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -746,16 +746,7 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-/* ??? Does this need to do anything?
-   #define ELF_PLAT_INIT(_r) */
-
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->usp = infop->start_stack;
-    regs->sr = 0;
-    regs->pc = infop->entry;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG 20
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 23693f33582..aca0bf23dc6 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -92,24 +92,11 @@ void cpu_loop(CPUM68KState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    env->pc = regs->pc;
-    env->dregs[0] = regs->d0;
-    env->dregs[1] = regs->d1;
-    env->dregs[2] = regs->d2;
-    env->dregs[3] = regs->d3;
-    env->dregs[4] = regs->d4;
-    env->dregs[5] = regs->d5;
-    env->dregs[6] = regs->d6;
-    env->dregs[7] = regs->d7;
-    env->aregs[0] = regs->a0;
-    env->aregs[1] = regs->a1;
-    env->aregs[2] = regs->a2;
-    env->aregs[3] = regs->a3;
-    env->aregs[4] = regs->a4;
-    env->aregs[5] = regs->a5;
-    env->aregs[6] = regs->a6;
-    env->aregs[7] = regs->usp;
-    env->sr = regs->sr;
+    CPUArchState *env = cpu_env(cs);
+
+    env->pc = info->entry;
+    env->aregs[7] = info->start_stack;
+    env->sr = 0;
 }
-- 
2.47.2


