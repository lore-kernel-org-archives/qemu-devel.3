Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8894FCA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5Aj-0000Ok-6l; Thu, 04 Sep 2025 04:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu55e-00072A-C1
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:13:06 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54y-0004M9-28
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:13:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61e3b74672cso1629433a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973534; x=1757578334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2o641iW9Eoei/+yvUIKi4qJ7pGzfbvmdWyUoyzoyuTo=;
 b=kLS9wcHTZ98o9sIon35e/AtjzIRP+tFVU9jCCVr7lX2+dcAxgs7rdrqLurw6V78Nks
 rngpBWIkmkrckBjLvTUxdvUMZGXGhhZi5cXUOfjMfs4NVNqdj+rtz3lGiGM7vhPGeMQw
 aoAqgvVrMMXxlT9D4vYZrkcEwVQhI75VZp05rRfiiHbfmbn5C1kh+UWy7BCYABVz7Fex
 t/rI+SrrEuG4LGOwHns1vwmvvG7gxMT6AiMoao9puOABjjPBSGrQxgbnpUjCpAb0lsjx
 HRDaaTib8D3oFwwfVjSDDZfASHvgyEYQzoS9VzSNF8dtLs7rk5H/7pcGHIGYUSDT5Q/X
 mUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973534; x=1757578334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2o641iW9Eoei/+yvUIKi4qJ7pGzfbvmdWyUoyzoyuTo=;
 b=IEWTVoauwByjR+W4jsVf0DCBLy25rXB+01N3SrNASi1YVLejHhjCjJd3InrXSphnZB
 5i+twofXE9tQ36/wB0Mpzet+msYz9Jq5J9bvaug+5J20K6bI3TFhv96LoXDggLPDcJtV
 yJInF2ibw3+JmiMPyVLlBrbWCwz9M+sT5N8tC0kZuCww+M3iQUVzXhNlRvwqKyCsM4da
 s4hGFCiku1vdabl3k+4L2+Koy9FBpc5a+kLbw3hof4zu2uXn40Zyvz3VQmt5bXIstFO6
 PyQ58gptZbYRicAcZnafaTQoeeEngKmNaqPzlsvh0Qt76VnH/HN7necnc+JRMOt2BwyR
 PNyg==
X-Gm-Message-State: AOJu0YxryCsYquriPXYEoDIzTzxF28zEC5Q5ZCg0CELl2kBiQjoBbThk
 FjSFWQCzk0KvtNBdyYGpKnfKJGrHGFKe/laVaTFSAs6HuZV0um8xONYkhNbhNjXDWG2XHuwwsM0
 G1koJEEdR4g==
X-Gm-Gg: ASbGncuvJF0S1yt3V217jUixDjGImjDQYNQSbd3Y6VTw9aKW3B96Sy9JKoda9gyvO/4
 C8GERSq50tuylYA5FqZ1cCKS9ms4CoQLHb0UW9C1DHEpdAlNhdz6GVAwyhEcbab2Ie+6XxKSPbU
 uQtv7+twD8vDscNcMSIef3uWHR/SsVsxZT7MswryiRHGYRCJHuLewTniY4eN47zeJaK7D5O7BD5
 9PWmnCSZNoEW8yLxwArOlCCkcU+vJJJqBShDNJMsHtFq4HzKKTXbVeYSRdW4S0FVK/3hOInPHHa
 cfdeAYlI5U0lROnpN6lhmjRf8inhtgLEYmiGIt9XwMUzMsYsRJszsxc+eHeqAhLDLEzd0WDsMVB
 mJP+Hpz57B1NDDso3lcMbE6E=
X-Google-Smtp-Source: AGHT+IGLKV6kj/wdkKv1zH+QlHElinS7UZypfjzlhnOqgFK2g8smAfI2YLmWX9/F3AuN9VCXaBC4yQ==
X-Received: by 2002:a05:6402:35d3:b0:61c:7ee2:f41a with SMTP id
 4fb4d7f45d1cf-61d26d93883mr16733782a12.15.1756973534355; 
 Thu, 04 Sep 2025 01:12:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc1c7a10sm14089854a12.5.2025.09.04.01.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:12:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4EB660AE4;
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
Subject: [PATCH v2 083/281] linux-user/sh4: Create init_main_thread
Date: Thu,  4 Sep 2025 09:07:57 +0100
Message-ID: <20250904081128.1942269-84-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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
 linux-user/elfload.c      |  8 +-------
 linux-user/sh4/cpu_loop.c | 10 ++++------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 03c95397744..8604308a310 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -701,13 +701,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    /* Check other registers XXXXX */
-    regs->pc = infop->entry;
-    regs->regs[15] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index ee9eff3428a..259ea1cc8bb 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -81,12 +81,10 @@ void cpu_loop(CPUSH4State *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
-    for(i = 0; i < 16; i++) {
-        env->gregs[i] = regs->regs[i];
-    }
-    env->pc = regs->pc;
+    env->pc = info->entry;
+    env->gregs[15] = info->start_stack;
 }
-- 
2.47.2


