Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09633CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SO-0004Yi-UV; Wed, 29 Oct 2025 11:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SG-0004LG-AF
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:21 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S0-0002tn-W0
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:19 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-63c09ff13aeso12914624a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753058; x=1762357858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mvGSXD8bq+JsCFwOFVuxwpiCx0oCJyPaBH3O6zMDgo=;
 b=BRU7IlRwCv94jkwSdvkhzofLiKoO9TUbgetUMKO0Zi308XQ+vWw5oX1vCBLzLw9Dcv
 lft5z6MhnAV8+LftYmnpE2pHeUBN77Y9+4Ht+pfuBrSZWNffWd2u7y1I40pPAV0ETWti
 RXkmbw0IsBrbk/LxIO3L/to5dOavtyQVyUJ0s9ARM7DYVMNHJ4kHQr66kvNEyeVLNwFt
 SELAJ0YGawFVmLRUb05ruqbUMRVC2MgTFQpDwpkNMUGLmRJpW5gZW0pzpt7HSvv8+vC6
 1t7UI1tBKKjmvFNjtPfvDj8aam+JNYkIaPu8E34UXRCmUlB15yDp00rq4sS0TUEim8cs
 Jlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753058; x=1762357858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4mvGSXD8bq+JsCFwOFVuxwpiCx0oCJyPaBH3O6zMDgo=;
 b=stWnKX+d3foD9ZZeyaHIiomE9z4n3r+9F1dQVS57hRjQ6iOv9ZsUGqbLbqPOLJvBBM
 yoy9N5UozfbmZbuSPsqDXX2K5aAckhqXlIx3S7Tp6Iyq9dyX0MBSCX82+QxPUbhp2AaB
 8aXsd8xhQuaqJlRuN3ifZNFp4gsFZXcqq9cKgBekPy/nGbFIJ7WkS/i1ij39i3iw0Ymo
 eVV6YJCJ43MqZER5oAeB6/S6VlTbKe1mUP3WBlA7y8NpQlH1Ow0/HCCfUSFRRSwHCSOQ
 hi0wwaIhiaDspWNPMysGeHfdE0AZr+i7VxwInNCjhkVEx93/PfgiglBv1ubs28WvQwOY
 msQg==
X-Gm-Message-State: AOJu0YyZri15wgtBif+SaFORkVtt7TlY4X7DKvVboKvyK56fVQCsVVSe
 XKvt+DONqKZVjgF/yfKjb3lYHI2hcp05jI1LEUGBrSGaAJTzFKCoAKKOuw9LOxhbzFo=
X-Gm-Gg: ASbGncv2/eIE+DzedrLSaAJqWBs9U3QAM2oKECFu4X6519yjwRiF9bB+VSAN0h1JTMo
 youYIRxQ9WbCN55s4tdixZlrvZErwuMSpMoKD6omprOGI4OLG5aoxqWLGieWYH0cxscPbUgEPJE
 Kxb+obKA3S6Nso/dAc1iZWMoyAYm4FuNxqyqKcMWMzMXFPqMnmlUCBpyT0SuNV9kkHWMyZ/10hm
 2ydL6R+ymCAklcYFIzH7khh8BerXPUvy+XYxLBomzUXAk2uFT0upCZXejVDoJk6GhPh89m6E8FZ
 f+r8JbwN2f1NMO+tsOZouEm43v/QAm4PkM0U3CmUIi9m2hmqVILPL2K+YUnTAsmqc6r8M1UU324
 8KfdbbKvHoWi1HGKJDCoqRZ7/qYAoqfO94sLqMbkLrnnlXvhSChW7EgOdapAIPOFhbW/hn8l/uN
 Qr
X-Google-Smtp-Source: AGHT+IEVJ5MdooYOp5TOvHPq+ldR6VCsJqEyAY5pUcrR0/U7mZSSZuKPkBn8vTOO3Lp2bmhDwMu/Fg==
X-Received: by 2002:a17:907:6d1f:b0:b44:fb0c:5c43 with SMTP id
 a640c23a62f3a-b703d57201dmr347158166b.57.1761753057830; 
 Wed, 29 Oct 2025 08:50:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d854430dbsm1454545066b.63.2025.10.29.08.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6EE5560A94;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 16/35] target/loongarch: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:25 +0000
Message-ID: <20251029155045.257802-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-ID: <20251027110344.2289945-17-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


