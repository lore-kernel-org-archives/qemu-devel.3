Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D3CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUzY-00014B-Jw; Wed, 08 Jul 2026 12:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzW-00012x-FE
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzU-0006yB-Ry
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:18 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ccdb73f0e1so8890915ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783527555; x=1784132355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xxHnlMV1JLQeffQVz+3d7Qr7bAg99XcAJ/gdYyuVnYk=;
 b=f4HmxCy9f8Cmb4R53cXaCxLxtqZgJPDpwDxpnQvjzDybF7Q0l91VjGuVz5d7utF2U7
 +te/9Edvd12YPPm6b0nGwgJFVWUZUVXMIyHLM2kzbQpbGPjLfQKxuqO6COOteCcgHP8e
 E6j1U8IZ5Eb89j/urzCxWPO14jG5MF7hVnfEeWeMKfdwlOlaacUlGEz30Ucl2sAlSdo1
 o2H5iTq0J3ovSJXl3SH+HUAL5YgL3pzEgRtxRSpOPdtJQCYOvptjpbteeAtPjd2G6ZIu
 vIAaeaj3EJbBXSngfvlTvWe95owiURMtX2QtmweWP3u+G62zQLZWspEc6csKPH/DbL9x
 dGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527555; x=1784132355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xxHnlMV1JLQeffQVz+3d7Qr7bAg99XcAJ/gdYyuVnYk=;
 b=YF3L4RGstt31Nxcp/ipjNoyzJRjf8GOc35fvCvRbUJs451LqrU3Slmw6RAVoZLXOgo
 nXYO7FU+zdvRisXOjE93wHud1SV7wzo2NeUfBHk+mTeHDb7ghjLcN8+uWu6HZUNlFzMs
 JY58fDN7IoYD4ZfcVbmYTumZcnZs/XKbBk0EAep4d9D53TxJ1xasp+xly8hW9Cm+4D7Q
 1xxy3G74LyDJaZ13dT7pB5UxlRT1kowoKFaT0iKpoNtmkXJ3yPGrWFS7LunRg4J2Kp6x
 G3+ePxVhyvJ8eOqLHu52iPkdLGdXbmqhv1GP34GxqQ2zvQ9vA2my2UEuAJNdNBxXRFUD
 wLwQ==
X-Gm-Message-State: AOJu0YyoBmQTWPMs09hsFgTJAwhUBT42oBIheu7BVMzRbV6RiZyhjS1+
 LxN4t7gt67YX/ZmlHTgN7dTeFBRyj81XAEc7GLfNAlTnwV0kQ6FWtXV7ZHl0zsq3JknPXKYJCIN
 qDNkenIs5RxiV+RqnL+h3iwwYxtBJmniBTvm/iwIMhJ1uaWws2Dt6LpTXWnPozig4vPPcgoRhUS
 ggl4rWQBQbUC6Bgof7IH8nNXGeuDQnFKO5xJCOpRM=
X-Gm-Gg: AfdE7clTk6csjgI37l0DklMZfpsyEvpiN4apMNZ6x02LJqSp1/EWCimvfMYkwyaQSJu
 soSCY5SHTp/gr+TKAhDH+LgpTHuNEP6ssqHqPXsDVGumpjDhG3pDqr3i6+t/QbSufn2wLxa4GKt
 LL7MEmXV78MxtReY8d+V/V7Vg0zohz/3mNoI6yk/plUKlUnSxHQiUZ2nMfIASPUqqbFTVXPwgdV
 KFF8/d1mZ4i4H3yndz5lLZk5HVt5vwTsI6QcubAwew1BSPAdLOlTCCFnXf66aXa7PMwSXYgS21A
 71r7MwATHSWOYjLnqSB7FtociBW2MOTvFgEfZCh7nrUhB0Mfk1AqXSgM51u/I+b8AoHpifOz233
 RTlxxaVo8l3ZUvY5oB+PHyEm2FvkyLwa60kE0/0NbHeaQH+oLpurKJQj4EIhqh2FREvBtFhkyn6
 PA9V8PpAdqWukLSQrkTDTG737VoOf4TAo9vzaP72h/4px3FUsnczUrC7obxcz6GF2T8vDY0PSTT
 muFt0G5Pqq/1lgV
X-Received: by 2002:a17:903:3250:b0:2ca:2079:91cc with SMTP id
 d9443c01a7336-2ccea371b35mr31671735ad.5.1783527555365; 
 Wed, 08 Jul 2026 09:19:15 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb56fsm30789265ad.15.2026.07.08.09.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:19:15 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 3/9] target/riscv: Add cfg property for Zvfofp8min extension
Date: Thu,  9 Jul 2026 00:18:53 +0800
Message-ID: <20260708161859.1124848-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708161859.1124848-1-max.chou@sifive.com>
References: <20260708161859.1124848-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62e.google.com
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

According to the ISA spec of Zvfofp8min extension,

"The Zvfofp8min extension requires on the Zve32f extension."

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/tcg/vector_helper.c  | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563b..38c580a22a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -231,6 +231,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 9eb47af0a7..af78c19a9d 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -105,6 +105,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4af5cd9c73..5c3f79fbd5 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -639,6 +639,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp8min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp8min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 944f176b74..6b736948ff 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -38,7 +38,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     int xlen = riscv_cpu_xlen(env);
     target_ulong reserved = 0;
 
-    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvfofp8min) {
         reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     } else {
-- 
2.55.0


