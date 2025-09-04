Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037CBCA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5Aj-0000Oc-3R; Thu, 04 Sep 2025 04:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu55b-0006yP-3J
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:13:04 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54y-0004Lb-0c
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:13:02 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61ce4c32a36so1286322a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973534; x=1757578334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5Zye4y6NxJaSczxcVcmt24avvGWMTOUTr/+SGRum6M=;
 b=oZhNqbatmZbF5XPkK5klFuGhvaJvT6KVFz3fRH5XG27CwSAMYzsM9qP3Z66ez/2krB
 5CqKOiqSTDkzYL8UacVOA4M0qqv84l8ThZl82hpeftWyN8flWAMGoNPv+1PjHx13Hi2s
 ibd/bBmPAoWBHnyY5EoHa3mqel3RxePPgW/5d4UPDMopgAYqvY9+1BNM92n3AwXSoSg/
 /e/81SCMDBKmctQZKsiRKSfg3B7KIfSddVQn5+F2jXs+M4s+vsOHLjxxixd0NoEkx1GE
 j3IWQ1zF1RvTvW8vuXuO9TP1Frx2TBlXbpEm911qCY4hkqhue9i/eeZ0J42pAa7569Mi
 yOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973534; x=1757578334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5Zye4y6NxJaSczxcVcmt24avvGWMTOUTr/+SGRum6M=;
 b=Kr+vg1Y1/NX5UXZ+NmjiHez1H5m1zE9QS+jt887rq0k9JZaojveetF2sh+VkNMEXRE
 TdkhKC88fgr/TfeIK+NSJEC7aZgHrzFbYeE58tJTrg4XX5V8tAmGDjA4x1kFn2nBUtAZ
 5BTf8WxMwa7BAUG9owITWrB1vb/obugoM0d6xC6or5lKgx6/cbJ50hc8/OCTui70booi
 Gh04lRSsuLKkWErVLN/ADbSIKzVGIkiVkdoM7V3g9/M9JqQwrOfRbqLkLbKbrgrBfcb6
 kZGmcZBGtc6Z7EPtvZhRjTRv1Ri+JPzpQR7oLpHHQwwgilLG/fzcpHfBRF/z419z58Hn
 fIGg==
X-Gm-Message-State: AOJu0Yy8giDXe8RvlhJmDkT2AsaVdHhHMqA2j02Zt79Hon6LRvGDPSSN
 45+lAFjGi2vGE56IKS43hhl6MKCBtfnemFJ+L8aMP5UkO/Xi5HIMo8hjcFM+gQWRBjhu92lQajG
 IF9/xGHvEmg==
X-Gm-Gg: ASbGncuZOCwAUmr8KK5Eiz7CNU1o5h32hgrFP3YuTzG24XAc+oreeTQeuPsW+vBJJlt
 Q1ALSWpiDhI3ZbnGwfF/45pawmUBiAD/XK6oRIqxmZle5PZuMGu1MTvH+9vgsCWqeHj6kv5QaeK
 q/SlUwJz+SB6x9HpOOn4kVyS/hMGnivmxQSYQqjvHkLfJSgXeZHhPT5CqW8VaJLBKrtiBvrz/j6
 dzd4rZbUsNpsFfE7urzdQzV9LnfjZLFeQ0rSeaWe9fA2BMiUO0IWa+RvI14NvsVhEmRBVpQg1v3
 41GAEfQSrt0Dft7a+5Od7XqTlleaoPou9mHem/8fiTKCmRMW/taW9MIIfKz+oysPICuHIRuGK2z
 NF+Tanlo4FUStgn2EUdjf2qyY/ar59EhREQ==
X-Google-Smtp-Source: AGHT+IGvhyi3Ob8FQTO0E+SlWXz70PknUDYB759PnOR+EDDgh33qtQBCOSrVgpXzaEOgq2NGLcCnnA==
X-Received: by 2002:a05:6402:2549:b0:618:afa:70b1 with SMTP id
 4fb4d7f45d1cf-61d26c32e70mr15695243a12.20.1756973533908; 
 Thu, 04 Sep 2025 01:12:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4bbc6bsm13985707a12.29.2025.09.04.01.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:12:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA7BD5F93B;
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
Subject: [PATCH v2 082/281] linux-user/openrisc: Create init_main_thread
Date: Thu,  4 Sep 2025 09:07:56 +0100
Message-ID: <20250904081128.1942269-83-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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
 linux-user/elfload.c           |  7 +------
 linux-user/openrisc/cpu_loop.c | 11 ++++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3f9ec493595..03c95397744 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -673,12 +673,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->pc = infop->entry;
-    regs->gpr[1] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 306b4f8eb43..8c72347a99a 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -83,13 +83,10 @@ void cpu_loop(CPUOpenRISCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
-    for (i = 0; i < 32; i++) {
-        cpu_set_gpr(env, i, regs->gpr[i]);
-    }
-    env->pc = regs->pc;
-    cpu_set_sr(env, regs->sr);
+    env->pc = info->entry;
+    cpu_set_gpr(env, 1, info->start_stack);
 }
-- 
2.47.2


