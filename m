Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D81CCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEzy-0004Rq-4m; Tue, 21 Oct 2025 12:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEzw-0004Qx-SO
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:14:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEzt-0001eG-E3
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:14:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-781251eec51so4581861b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761063243; x=1761668043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCgTD8dkwQgMMt8MeCyjtFh4SBtoRLRCufrZusreNxI=;
 b=QyymTXe8LhyLGvK6G/cxpvema7MvmvTxU+GU6CrI43STQ8do+0pcOrZ3tyjfPKKNBJ
 PQU240p6Cn4prBx2graLPEp8MhLHZGBIlnbMqup9NMZ2OKqTfZ2t9C7rCPVOmN6zOtPf
 iKdVmL8tUiZ2dte706HbITUr0Wl8jqndFKPFLNKq10jdLSBzAyh6FUE8MazV9Z7ikYta
 +qQkY4Qk47KFvccxjtiH13mVmAoEuA3sEQpO+C7tU0HihQl1k8TMFHPviqEJQJcx7DRU
 ozd7C9ohZn4gf+C6mGXdOyRMSis7l/8u5JVUoLNqEwJ+1sET84QspePqF0SJUPR8o+0n
 F1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063243; x=1761668043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCgTD8dkwQgMMt8MeCyjtFh4SBtoRLRCufrZusreNxI=;
 b=o9UgHqIIfPZX65VQxPxOppD9X/qSYoG6UL4++BjfMA+L+8KPRPybko7f1W4KuOVxsp
 ntjVEpU/2olno08hYrTIoK8uq7LHkQVNIKkcr3X/MBLw38V+hKeAue9mSsa3UK8Q+Iyk
 Sst1SSM2haHHrO2mVRy0+pe2uzOuBE9u2BdwKm6EdSvJ5aQCzqxVoCj/1tuLqtJgAXia
 e8JXXf+jmfL+uIpzS1u8JBFggicR1IInv6KisWvRgqXSXhdLHmJMPf0EIKDAOl4FQPIT
 0d6Zxz8xJ7wCpY1578YASZvHOai+o8wDWAW3QQlQ+2LfWF/wqW7Dd1YsF4u+RKUJd97T
 LWOw==
X-Gm-Message-State: AOJu0YzK1+gECZOLqfLxaJgiNGc0WasjWsrHaoMMIxobCiei3yglMjTV
 wQ0YhI7zougHstDurNCPXnYuYinwpcijKYsGCDnTzqPixY42H0rcyTmQ2/6ZVGiTYVyOvSaAu2B
 qAdymBC5JMzeZEHnafU200p5v5oIQtRP2Z/3mN2s9e9FnpkKOw1VQRLFWIkd8Pdt61zzXliAl5Z
 ytJ4DbVIw3cR9xMQRZ0FyNBGzW67xZZH8pYaDwnw==
X-Gm-Gg: ASbGnct5qH6gj+0663t7kIDf5GEtFOVeEzUi+/gyVJLLXkg5E4iy9kSHKM+zD+Nbe5Q
 N6a/kJYr5Mhn4fyLsbG7ampVBwmBTT3GhqOXR1n2wFWkuzKpprWwV/0RKjGW2GlA1XSbQO4i8qM
 vP5XQVJ1Zpqp7ILoTRJ3AqhG7uOlYavpvCueJfYmjjetSIk/XDUpC2OToYx2octI3zQGo/9ujhI
 cQl8tRCrw9xIcYNFFJUiKKtMYiRokRb++q/j68a7MM4xFDVrVXjRbqsBoy1SRxx39moU9UtRiPn
 O29qJYtPWWWpf10BbkTqzJjICu0T79in/J3DVZiGd3T2PP2jazzH3hyhEnToHqsm9SYaWreHuke
 OLavlA7GJ6rkhcRJxUdoXlsk7kMUCZ4GI2ExkolpLgTw4s8cgmn7Jpl/IuOzx5T3HpoarRez/Cc
 KYoSVbn40pl9xdrHJtsxe40w==
X-Google-Smtp-Source: AGHT+IG1N5YhVFO62QR4+4v3Tn9KmpHp9epP+wwMroJLP+wisiu2TQIWQ3DE49usvcvmEENmH6dXDw==
X-Received: by 2002:a05:6a00:b8c:b0:77f:4641:e5ac with SMTP id
 d2e1a72fcca58-7a220a59afcmr20764351b3a.6.1761063243025; 
 Tue, 21 Oct 2025 09:14:03 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23010f7c7sm11731157b3a.54.2025.10.21.09.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:14:02 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 13/18] hw/misc: riscv_worldguard: Add API to enable WG
 extension of CPU
Date: Wed, 22 Oct 2025 00:13:19 +0800
Message-ID: <20251021161325.585278-6-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x436.google.com
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

riscv_worldguard_apply_cpu() could enable WG CPU extension and set WG
callback to CPUs. It is used by machine code after realizing global WG
device.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/misc/riscv_worldguard.c         | 92 ++++++++++++++++++++++++++++++
 include/hw/misc/riscv_worldguard.h |  1 +
 2 files changed, 93 insertions(+)

diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
index 588c16ae9a..73fa8190cd 100644
--- a/hw/misc/riscv_worldguard.c
+++ b/hw/misc/riscv_worldguard.c
@@ -92,6 +92,98 @@ uint32_t mem_attrs_to_wid(MemTxAttrs attrs)
     }
 }
 
+static void riscv_cpu_wg_reset(CPURISCVState *env)
+{
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint32_t mlwid, slwid, mwiddeleg;
+    uint32_t trustedwid;
+
+    if (!riscv_cpu_cfg(env)->ext_smwg) {
+        return;
+    }
+
+    if (worldguard_config == NULL) {
+        /*
+         * Note: This reset is dummy now and WG CSRs will be reset again
+         * after worldguard_config is realized.
+         */
+        return;
+    }
+
+    trustedwid = worldguard_config->trustedwid;
+    if (trustedwid == NO_TRUSTEDWID) {
+        trustedwid = worldguard_config->nworlds - 1;
+    }
+
+    /* Reset mlwid, slwid, mwiddeleg CSRs */
+    if (worldguard_config->hw_bypass) {
+        /* HW bypass mode */
+        mlwid = trustedwid;
+    } else {
+        mlwid = 0;
+    }
+    slwid = 0;
+    mwiddeleg = 0;
+
+    env->mlwid = mlwid;
+    if (riscv_cpu_cfg(env)->ext_sswg) {
+        env->slwid = slwid;
+        env->mwiddeleg = mwiddeleg;
+    }
+
+    /* Check mwid, mwidlist config */
+    if (worldguard_config != NULL) {
+        uint32_t valid_widlist = MAKE_64BIT_MASK(0, worldguard_config->nworlds);
+
+        /* CPU use default mwid / mwidlist config if not set */
+        if (cpu->cfg.mwidlist == UINT32_MAX) {
+            /* mwidlist contains all WIDs */
+            cpu->cfg.mwidlist = valid_widlist;
+        }
+        if (cpu->cfg.mwid == UINT32_MAX) {
+            cpu->cfg.mwid = trustedwid;
+        }
+
+        /* Check if mwid/mwidlist HW config is valid in NWorld. */
+        g_assert((cpu->cfg.mwidlist & ~valid_widlist) == 0);
+        g_assert(cpu->cfg.mwid < worldguard_config->nworlds);
+    }
+}
+
+/*
+ * riscv_worldguard_apply_cpu - Enable WG extension of CPU
+ *
+ * Note: This API should be used after global WG device is created
+ * (riscv_worldguard_realize()).
+ */
+void riscv_worldguard_apply_cpu(uint32_t hartid)
+{
+    CPUState *cpu = cpu_by_arch_id(hartid);
+    RISCVCPU *rcpu = RISCV_CPU(cpu);
+    CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
+
+    /* WG global config should exist */
+    g_assert(worldguard_config);
+
+    /* If the CPU with this hartid doesn't exist */
+    if (env == NULL) {
+        return;
+    }
+
+    rcpu->cfg.ext_smwg = true;
+    if (riscv_has_ext(env, RVS) && riscv_has_ext(env, RVU)) {
+        rcpu->cfg.ext_sswg = true;
+    }
+
+    /* Set machine specific WorldGuard callback */
+    env->wg_reset = riscv_cpu_wg_reset;
+    env->wid_to_mem_attrs = wid_to_mem_attrs;
+
+    /* Reset WG CSRs in CPU */
+    env->wg_reset(env);
+}
+
 bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock)
 {
     uint32_t wid = mem_attrs_to_wid(attrs);
diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
index bb276e59b8..fb08c92f46 100644
--- a/include/hw/misc/riscv_worldguard.h
+++ b/include/hw/misc/riscv_worldguard.h
@@ -48,6 +48,7 @@ extern struct RISCVWorldGuardState *worldguard_config;
 
 DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
                                      bool hw_bypass, bool tz_compat);
+void riscv_worldguard_apply_cpu(uint32_t hartid);
 
 void wid_to_mem_attrs(MemTxAttrs *attrs, uint32_t wid);
 uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
-- 
2.43.0


