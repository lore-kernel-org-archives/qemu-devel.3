Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E85BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSy9I-0003ZB-IJ; Fri, 29 May 2026 10:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy8w-0003Rb-4o
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:25:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy8t-0002JJ-17
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:24:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so6257275e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064693; x=1780669493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFEMIJ2KJOaWjwhyxDKINz2zmIup5qa01FGrlMeKBW4=;
 b=TMIOQDfjIwR9CiLgenITha2FEEhEduOsWN4A/UIoU5aLCwpI5fiuwfKJb6km+Hz8FR
 1Ws4gP/ZsXCn46yYPaa5X0aIF3K+iNPia+4THCmMCEjnbJHimdr9AYHtnZNnC747Js/Q
 AwV3wIXzRiizDI4OFifpB+etQu2e35ksBEoSSTv+tK4bmPjhAdz3rRGwkWI/OlPZEid4
 28GRC+XoM8mf/sImff28Q4lcKpflHW+t12qWqxcpUGkfx2O6NSWQbzl3h4IuPIq4vc9x
 E8ZGzhv+nDlOYSAIOij16W1BdQbjfjaTUPaTT8PZQjs/NjlMph6s1pT68kqlCANazeus
 SN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064693; x=1780669493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nFEMIJ2KJOaWjwhyxDKINz2zmIup5qa01FGrlMeKBW4=;
 b=hwB3PIMTr2ekevF/+s4EcnYu9inyw/kPgjtGSnNGPMT3sKJXtsCwV2Pe7R5NXdth6v
 cWUsf3fFoZY6E7ZcQqI3gXarD5tDHGG7KcRbbqU+XP/uagsQlUXiWevoY928hf4Ytm/k
 XCCEjkkz0MCTLnNjm5QLNd/20c1IphRQAV2yNOjZ9zpwm1SW/fLLbhzgyNc2QPUH7mlo
 Fb5RJb2SgQi+ZdomrqKJ26sDUNk+3QI0FyuPhbES6aY2+bXM8x6glujgsbX6PFOURgMd
 kufKiNX6BL31AexzD0/1HLEHOd80zXtXQy2SoP1lUwFq8YXOvhMXH9gWfBdnwL26a4Qd
 Oljg==
X-Gm-Message-State: AOJu0YxUkmeFyuvdN1xYKkZd746QK4s/sOZx1Hg8JqB/GsdTtSRjqnrG
 imlGf3qZXJ7fvw5ir0l0ogUmokPmWYCfs1X7FoiNnKz5L+XIHZyKXXyTBxBZduOvqk6XSeoTvLQ
 doC2F7cAb+Q==
X-Gm-Gg: Acq92OEbtriV5KGm//nxem9Vwz0evHrLNethhfsNm5lT9S9Eu4yBSIc1Gp6hcVioWWE
 URDDMbLAvux7xWU5WAVkgS+g3+0r4hkZeKU/+Tl/L1d3Gga8T6REI5+hRtyTksPqESepFFpcLO+
 2X7+Tpo4Q3ci9I0TTsyPNMJaw/AqiaRDjYEsMNWhlCHErGg9Wik6F5JC5do9HwHXrIc3ZwhKQbw
 BCxb4mKN0P71RrRI7CcqAlwbpcQLlRuXElErnqPBsJxHU2+MTNJpNITIh3iWzM56moApS38RcOB
 bSN6OMVu0qyr4JfhYwH7WL7F8V/VrUMXctFbHE6YeKr5H9t4H/z/8DT9Q4cy2qwOheG3Sw74lCv
 eO8AJtaphI0U3U5SV3/gMidu2qVogISopAkl1PQ9Y4YIHQR7SOwiwE7uhWglVPnGrRV+mVs2Gxr
 RrY0SOrSBDjRRRRNWHLsnFPrHroBwdvS1MJOzZJJFxLeM5P9NoTpCO8sX8s8qvg0konQ==
X-Received: by 2002:a05:600c:1d18:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-4909c0c7ad7mr56817125e9.27.1780064693487; 
 Fri, 29 May 2026 07:24:53 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909ca6e124sm47683785e9.7.2026.05.29.07.24.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:24:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/17] accel: Remove AccelCPUClass::cpu_class_init()
Date: Fri, 29 May 2026 16:24:18 +0200
Message-ID: <20260529142434.87880-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Last implementation were removed in commits f50d0f335a6 and
a522b04bb9c ("Remove AccelCPUClass::cpu_class_init need").
Remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu.h |  1 -
 accel/accel-common.c      | 33 ---------------------------------
 2 files changed, 34 deletions(-)

diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 9e7eede7c3c..88c0815e2d8 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -15,7 +15,6 @@
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
 
-    void (*cpu_class_init)(CPUClass *cc);
     void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 62590a7d9a6..ebc103053dc 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -32,42 +32,9 @@ const char *current_accel_name(void)
     return ac->name;
 }
 
-static void accel_init_cpu_int_aux(ObjectClass *klass, void *opaque)
-{
-    CPUClass *cc = CPU_CLASS(klass);
-    AccelCPUClass *accel_cpu = opaque;
-
-    cc->accel_cpu = accel_cpu;
-    if (accel_cpu->cpu_class_init) {
-        accel_cpu->cpu_class_init(cc);
-    }
-}
-
-/* initialize the arch-specific accel CpuClass interfaces */
-static void accel_init_cpu_interfaces(AccelClass *ac)
-{
-    const char *ac_name; /* AccelClass name */
-    char *acc_name;      /* AccelCPUClass name */
-    ObjectClass *acc;    /* AccelCPUClass */
-    const char *cpu_resolving_type = target_cpu_type();
-
-    ac_name = object_class_get_name(OBJECT_CLASS(ac));
-    g_assert(ac_name != NULL);
-
-    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
-    acc = object_class_by_name(acc_name);
-    g_free(acc_name);
-
-    if (acc) {
-        object_class_foreach(accel_init_cpu_int_aux,
-                             cpu_resolving_type, false, acc);
-    }
-}
-
 void accel_init_interfaces(AccelClass *ac)
 {
     accel_init_ops_interfaces(ac);
-    accel_init_cpu_interfaces(ac);
 }
 
 void accel_cpu_instance_init(CPUState *cpu)
-- 
2.53.0


