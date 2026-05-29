Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34DDCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3EP-00076P-P7; Fri, 29 May 2026 15:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3EO-00071X-Iu
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3EM-0004qX-JL
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:50:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45ef76f0d06so41652f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084253; x=1780689053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8R24Vi/05knbM4BrOIv7zp9N+sUYsxpoHxdxBqTbhc=;
 b=xtKkmHP/IXnUNV1D9gYOkD3dBnoLWp717L9DdAUCRBxfTR7siG6xTQBe2RoXj/6CaD
 Q6PFzo30r+vrrOYBdhVvqbKML4lfbBby02zDV7aiXxfY31wy5BCkaeNsS9m5rVJr+2ha
 50UgOcQn+MVQq3lNPOgVrvhmchN5r7bJ+kbeArTqfSZ4KBTRQsCvgz413jRP+CD0Wpur
 LmHM+TZqdRJ8MOK4cxp1WiujpMJ8g7Dj+5/e1PO5JyD8USlDM/SmrI9Yy3hMc3+XNwKT
 rvDf9nSgZJjPcFNETIKy3Z54a5eY35PriHHHDo9tVlLZak/vKYhrUlVmmzSw0H1Jr821
 +dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084253; x=1780689053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a8R24Vi/05knbM4BrOIv7zp9N+sUYsxpoHxdxBqTbhc=;
 b=VTLJ8rt6Vs4mW3KUxdTMwfOfTAA1y2Rvpy+ty6ubtDkK/iK9PpbjtoqvgvBw7kKEFe
 x7wMfukwq186UO+CZdX6crIaBeNYKNbFEOFnct9aHFXvu1mDD3V4g8hwPr+baSOhgx82
 TrsK5o53UxnDM3oX/eClkFpbI5jtbATWm63I/LsvQrL68FnauZaPJCj1HzuECAZgZyXE
 f55RHX5RRQo6f47w/EJE/WBTs4+r/1DIh3t0SVAVocGOBP6/Qzp1smA3zn70CXZ6VtHz
 +xhbAYaSTiwazh+/fLty75AnPSuhUy7D9XhtzN5eZAs1o5Y9Ux7wBQzgK5JrLNEGM59w
 FxQQ==
X-Gm-Message-State: AOJu0YzPOeNaV6vcFu/WthbOzYKa+1O4L4IoL3EEOn0mMKZjeaoxINa9
 UPuiQEjLk1Dd6PT/eklJEmupZ5Nb1vgBJG+dl5aeHe2oI0TyKOl+qOQRQtV0W8ZKc9tW32sOhV2
 lFSr/t2kkxA==
X-Gm-Gg: Acq92OEmzHCSQb3afM3JQkhvKOG/85XK2wMlDhP0JcPL3TXCsmdZluT2mm9JRHYdjZM
 si6DyzdxuqgdkNfpm2vnQjuNLR4SeJyCe1ilygEhfgICP7r1rYjK6St77sJgZyRdkwd5Dl/qIiH
 wFijLmvmaDgN9wE9N9UvazNp+9WhEqNZpgnFDqt9TNd4Eu9yZhh5a7Vtdh8X8iIyHKUpgjiBJ7X
 2xjam4JzMMKPhRkrgKkOjyDxDsq+nkMsyJ2gboGJCOimGorrMplu7Fqb0q2eXbbgpLCovQG4MzP
 Yk5sqS/gl5Ck2zfcZdC4k9SzvTgYHJDbZOmnddCXwXknJaydMjeFodZSsnPwbK+h/xopseepxtT
 xLUrFnoU/ylLqJVLAKnrbNgyvlcRASADAoC41XW/lfiyn2GM4BNllhAPRjtnKavIEEtYpsXp1Eg
 FDcFI80a7Ijf7cG5Bf3vVP7CV6sN2l3K3DDwqKwBRfno9xPF9a4VUT2ybxZeq6X1gT3w==
X-Received: by 2002:a05:6000:4388:b0:449:9aee:4581 with SMTP id
 ffacd0b85a97d-45ef6b2a726mr1711046f8f.12.1780084253181; 
 Fri, 29 May 2026 12:50:53 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3559645sm5427442f8f.26.2026.05.29.12.50.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:50:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/17] accel/nvmm: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 21:49:30 +0200
Message-ID: <20260529194940.97143-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Register the new AccelOpsClass::cpu_instance_init hook.

ACCEL_CPU_NAME("nvmm") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/i386/nvmm/nvmm-accel-ops.h |  2 ++
 target/i386/nvmm/nvmm-accel-ops.c |  2 ++
 target/i386/nvmm/nvmm-all.c       | 19 +------------------
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/i386/nvmm/nvmm-accel-ops.h b/target/i386/nvmm/nvmm-accel-ops.h
index 931bb5ca243..f2a78c12110 100644
--- a/target/i386/nvmm/nvmm-accel-ops.h
+++ b/target/i386/nvmm/nvmm-accel-ops.h
@@ -16,6 +16,8 @@ int nvmm_init_vcpu(CPUState *cpu);
 int nvmm_vcpu_exec(CPUState *cpu);
 void nvmm_destroy_vcpu(CPUState *cpu);
 
+void nvmm_arch_cpu_instance_init(CPUState *cpu);
+
 void nvmm_cpu_synchronize_state(CPUState *cpu);
 void nvmm_cpu_synchronize_post_reset(CPUState *cpu);
 void nvmm_cpu_synchronize_post_init(CPUState *cpu);
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index dd5d5428b1c..60044b83527 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -87,6 +87,8 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
     ops->handle_interrupt = generic_handle_interrupt;
 
+    ops->cpu_instance_init = nvmm_arch_cpu_instance_init;
+
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = nvmm_cpu_synchronize_post_init;
     ops->synchronize_state = nvmm_cpu_synchronize_state;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 8a1af35ed32..2973e28122a 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -22,7 +22,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
-#include "accel/accel-cpu-target.h"
 #include "host-cpu.h"
 #include "migration/blocker.h"
 #include "strings.h"
@@ -1212,33 +1211,17 @@ static const TypeInfo nvmm_accel_type = {
     .class_init = nvmm_accel_class_init,
 };
 
-static void nvmm_cpu_instance_init(CPUState *cs)
+void nvmm_arch_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
 }
 
-static void nvmm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = nvmm_cpu_instance_init;
-}
-
-static const TypeInfo nvmm_cpu_accel_type = {
-    .name = ACCEL_CPU_NAME("nvmm"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = nvmm_cpu_accel_class_init,
-    .abstract = true,
-};
-
 static void
 nvmm_type_init(void)
 {
     type_register_static(&nvmm_accel_type);
-    type_register_static(&nvmm_cpu_accel_type);
 }
 
 type_init(nvmm_type_init);
-- 
2.53.0


