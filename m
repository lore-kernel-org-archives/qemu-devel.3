Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C26ACCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8Zy-0006ZY-S1; Wed, 29 Oct 2025 11:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ys-0005nQ-3t
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:11 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003XF-Rf
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:58:02 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b6d3effe106so4301166b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753449; x=1762358249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcgRLJxKs/ujjrhiNpo+x+KjdrmWKBAZJK7rS+3Uwcc=;
 b=opo8LXugwHwsrZ44mSvbARE/a7kJloWmpZcp4MyZtDWNed04JmIafKA80YQdeMpIdp
 xEUqFHSTTywNosMmalppLoSreG1zKgJvx0ZtQZZJGCHE+wweZjVnPPwxsjUktmiR6yhi
 2xUlPHgIVxvvKElT1iqSymqI+IKJKk6pUaUyf0lDXOsZNknSFanPyYyvlsYXLslywPMY
 HZ19KWRHjHrh2x5UsSdu82ts7Me1dTZ7jHhwHc3SO2MsMv+My2CqkZU4ccGXGGv6VXHd
 H7IOIc/Q5KN0f45WL5q/2ugGV8b3lKCthXVvNb3ahxilZ7XFrwOmY4cqplYTqnPY5wWQ
 9h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753449; x=1762358249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcgRLJxKs/ujjrhiNpo+x+KjdrmWKBAZJK7rS+3Uwcc=;
 b=KOEoAx8Tjp0AppnWABu7ttjUOHucn93tEQX/TYlf4PHGDqHcGi24tLFsp7zDgPIXys
 2TgGkaGu+eC7plBRmZ12g25GHknc6+ibn+Sf5iDOecZs/LMwb0dR1slLDafUtCgADt2B
 kUE+Hc0ovQmYIxF6xxwhjseWxYimAi8fwJZDf8YBppsreEKh+Ao98wFA1dgAdlFr9rV2
 YhqssmQPoFjVUqLc2cFHyoAd/nTp8LcFndDIemuqHk14iNsPEvCJ7LyShSeG7doPLNnc
 ALiW3tME39b91ofr5mE0W8bzIFr+KChxD3Dp+NirxFlVUXqmjI1Cp8LVTjuwWkbxPv1d
 zDzQ==
X-Gm-Message-State: AOJu0Yyxznpb7OUy+rNrnbdDeFYIDBalRAvyZ2/A5gQwHeMJMpdm3EDT
 rA0D7oW5yAdwac74xqtjYwjJX72AYh8Lv0WoZCG+6cXBKwIkBy8L2pENRSjzjmNGIfI=
X-Gm-Gg: ASbGncvD7310DUCwLWFSaKAXJd2spyCLcEcD4FkFqkfPyL2GNs603cEujEasKBMBhjv
 TFI9ELVVrSNKJGjvSHKp6RZiLSZWuTaYZ/TrDVZNEF0eqqLZycbO+e4BjB06kBCo0yN1gEgba0R
 NMLl+6S2zowt9gJQ/dMkH3Q1QD/VBYcujjhMvtvTZzNUax7GXoKf7FMnFNATHKXhw5xq5B2BzES
 me6yVVuAAzBq9ao6+0BgQzJSBEsL6+ZpZKUolRpISsvA2HPEEgETh266i229D/ecp3KE3zWe3w0
 6TIU1rm5Hfw5ZWIlYE60s6VZLPg4Sel+vypEJO1e1iVgj9F1PshUq3rnz6QeDOtc92fKTFH/DKi
 0zEWVYSDD6wrQlHAaJqPkUZcYm2pxz+343PH7bSknpfqBiXtlRDCN2XqvjhGIzBj9Nh5RS8u66H
 st
X-Google-Smtp-Source: AGHT+IEzSEWOt12h8+WFH2Wbhn59o3crkLlzNu4Ru+A1nr2eo1RoJGj6eT1FBFQ/fFtNJQIkvFkCwg==
X-Received: by 2002:a17:907:944a:b0:b65:abf2:417a with SMTP id
 a640c23a62f3a-b703d6034d6mr339435966b.64.1761753449288; 
 Wed, 29 Oct 2025 08:57:29 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d854430dbsm1456111066b.63.2025.10.29.08.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B6DD60D8F;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 22/35] target/riscv: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:31 +0000
Message-ID: <20251029155045.257802-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

This change places hooks for RISC-V targets.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-23-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 360db133e21..c4fb68b5de8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -36,6 +36,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "pmp.h"
+#include "qemu/plugin.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -2175,6 +2176,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     const bool prev_virt = env->virt_enabled;
     const target_ulong prev_priv = env->priv;
+    uint64_t last_pc = env->pc;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -2197,6 +2199,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_SEMIHOST:
             do_common_semihosting(cs);
             env->pc += 4;
+            qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
             return;
 #endif
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
@@ -2466,6 +2469,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                         prev_priv, prev_virt);
     }
 
+    if (async) {
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+    }
+
     /*
      * Interrupt/exception/trap delivery is asynchronous event and as per
      * zicfilp spec CPU should clear up the ELP state. No harm in clearing
-- 
2.47.3


