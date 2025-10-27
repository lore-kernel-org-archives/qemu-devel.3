Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0946DCCF9F1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL2A-0001HU-WC; Mon, 27 Oct 2025 07:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1h-0000ld-77
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:38 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1Q-0005hC-41
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:36 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b6d6984a5baso684418566b.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563039; x=1762167839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGDtkgFr/GHLtEa0jhJz7Y8ig7qb2phfciaJVqoCnCs=;
 b=hnKY54IH9fXypyNJXpQ9FpSySGdP9h7lEeAPh3pC5vJHTrbI3EnVs5IhzLccDkhs15
 mE8vnD1wgK1fdbBSewbzDKfVkQ+NzA+9sj35Tf48I9e4McjGWvhkxa4SJgFq57tQZGAL
 nTxXRk4DN9mg025DBYI35/48yP7PiklW99oMIe8/Lz8pV5r0/w2EhVEWfZKk5TXPSNOv
 yRSa57w/CePdayDHVMkK4DNLLB/RWwnqVAxYV8+W1CfLZhub4sO3WtQfTEt0SRdhLtBS
 WzGw15OHVWfptb3sDgkDSDbpDgyI2gYpGTV8uBfI9MYeXw2cxf12XI6VgEFjnOk34Tka
 cMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563039; x=1762167839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGDtkgFr/GHLtEa0jhJz7Y8ig7qb2phfciaJVqoCnCs=;
 b=rNc/Obyxt7KwMPXJVE+3zquUkZoTMjYBPCCbsCiR5yOWBwVcq9QKb3URQXlfIJVmH7
 1VR8Egw9jUyng69+ojwKz3Qv2UA7CQWxhr3C8gigv5kip4STTWDVH+v856AFw1nNFQW0
 7vyNEMEOKabw2mS6QqxaXlEyYN5UdnZ4sIhZSv5jWGe0bhFlRDeba+gY+evpfs1XwmNh
 YGNN9Y0+COtAmvJWmNkZmoksGaMwjvHjFEtySDT8I4siPhtsgLXRSr3c6bpfkxgxzllQ
 NHjDT1rGObt2Hx2Hm2+uSDigVv+iTlUv0fCKNspjvlTV9ThRsqQJisZa6yk0IVFHQY1H
 WBSQ==
X-Gm-Message-State: AOJu0Yy+6Bemnrga9wbtMTsj7X9A+yQgxHutFLxjqQyKeJaMLfbGFHe+
 Yb9eiIJE820XnfkppW39N0b6rYkQegxo+rwnhTH3AXtCVfcU11yBlofocQLx98gbcng=
X-Gm-Gg: ASbGnct+2AorT+RbmfZT5/8qqJ42JYkMAoNGouSc2y4C9YKAQLWTh4G1mr8SU3wUJjO
 99mnQ+4IcfoLDcOemdE96VBTpZj1kfG9f91wmhYnCqSuUG9mUwi6YoMyc+Fsodt4fdn4mjaz56G
 pH75ByC/7I+V59fXW9YT5p8npepNkW4cXqxsOUioQPdHNbK3Gqdw+P8+mJUlYMFIG5YyAwHVDUc
 61MAQuPBPIs80AjxCfB/B/IZ5PI0f1qLiHM2VUOI6xo2av4T4fIT09xfpJUCvjWfDj1pz+V3WPZ
 wxU4SnHKyYTLMuiQDL5sFJJRKKPmmpI1qHDeL8WiqXwSvmSY/PqHp+LGyI066/yfBD9wNA67hd+
 PfgeIVrr2/p+Pu7zkTnsq41VRzRtz6TMUvQoliLFaYzRgKqQaW8xzFrkw98NEpR4OQdjWPH8NeG
 /T2AteypyAIF0=
X-Google-Smtp-Source: AGHT+IGQty3nqHvOvQICE9Rlly5V3h17LXnXWbLrIdqb1N8ODcrMwUJQb0dJNUF1TXud8Qjaz914fQ==
X-Received: by 2002:a17:907:c11:b0:b46:897b:d759 with SMTP id
 a640c23a62f3a-b647443b9c2mr4453853166b.40.1761563038954; 
 Mon, 27 Oct 2025 04:03:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548ed8fsm735153366b.73.2025.10.27.04.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E0B860B4E;
 Mon, 27 Oct 2025 11:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 16/35] target/loongarch: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:23 +0000
Message-ID: <20251027110344.2289945-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for loongarch targets. This architecture
has one special "exception" for interrupts and no host calls.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/loongarch/tcg/tcg_cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 82b54e6dc3c..9d077c56d9d 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -8,6 +8,7 @@
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/plugin.h"
 #include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
@@ -80,6 +81,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     int cause = -1;
     bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
     uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
+    uint64_t last_pc = env->pc;
 
     if (cs->exception_index != EXCCODE_INT) {
         qemu_log_mask(CPU_LOG_INT,
@@ -190,6 +192,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
                       __func__, env->pc, env->CSR_ERA,
                       cause, env->CSR_BADV, env->CSR_DERA, vector,
                       env->CSR_ECFG, env->CSR_ESTAT);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
     } else {
         if (tlbfill) {
             set_pc(env, env->CSR_TLBRENTRY);
@@ -208,6 +211,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
                       tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
                       env->CSR_BADI, env->gpr[11], cs->cpu_index,
                       env->CSR_ASID);
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
     }
     cs->exception_index = -1;
 }
-- 
2.47.3


