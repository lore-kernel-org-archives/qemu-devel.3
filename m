Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0914DD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 09:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vStxy-0006kB-6E; Tue, 09 Dec 2025 04:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vStxw-0006jb-Kd
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:25:04 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vStxu-0002HN-SP
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:25:04 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so43791055e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765272301; x=1765877101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D32U9cx+cTFgXu76SMf/O5vqmn3V0bDLwJQvk6aC9NQ=;
 b=RreA443tCYB5aB6CwdjVcKTJKc7E9kUnRJNhgoLDob17/UXlwS6AdGGLQ+TkQwPf65
 hLvhXe1c75vR30R37gSvPmM9v4e7rYwri4++2EnSchqg4zLs1SVNTQ4gvstr3xjty2Pi
 Sl8s8OqNC7hw3pukbY384gwv8gDTw8fGioGA9cHThXyOTKm3+v8i2B7fnz7CX2oC1pzZ
 YezOmTkCut09fHDcs0J3x/QByd0UkaFB5CNLPA9tb58VX8ENyzVpRGE9oX1CTbWxbjXi
 jL/PRd6VZu/sg6m6f1A6uVL4gkjQdiUjYKD8o1b5ktqnFiNdfREDAzbMrrD2U1iO65I4
 mhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765272301; x=1765877101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D32U9cx+cTFgXu76SMf/O5vqmn3V0bDLwJQvk6aC9NQ=;
 b=Q4x3MPxZjmRfSKlXhf6BThZfRi8Y97oNXjtuW0wPs7qlvfvk4vxiArlgwaSH6+siN7
 t+bQn+MXaLj/dEkOOq5l2R+cJgKQZJLeg9ZyC2wmn80vsqhta+PdE9iflzk07WQEcY3H
 RzaCAYTjy7brO5OApXDNyz5BfeHbx4QVyi392bkP5mIT/b1bifhESY7U5RyPaSURgyz7
 rxOEDgFxZ9PhMkzFOxky8juX6BKBWE++4UeicT2yy8lfjON1Jg4yy94g67UbjHl57fvP
 BIu7TML98qFokezUdI1NrcIO02CFnOnLZ7EYnBcMxr+rFw7IzKDdujYUZGdUM4yNurBq
 /Oaw==
X-Gm-Message-State: AOJu0YzeSMyUjo1ZMR0jgRg5usue3cV1FeQ6ssC8SqXa385tpPThpWDo
 vMvSOXyLlZ7S7ZupLG2syWFDav7oBedzOLX+26lhLHWfgAB2qIZZICu/Ch0b/bag1eA=
X-Gm-Gg: ASbGncuYW4mWpejXPg6yGeUH/OAz7vzZVBaj/B0QWZo2hujRXYagb44is/LyWhj4xO+
 aUsxFIoHEMZkFuCFgcbhDCXEGvET5vmn1whQEMLSI3QghQX/Whd1AsPbmU8Sp2kULuMMIYwS7Ld
 LT5J2QQ1RfvONoiwSxZd5yNl7COJtj2Fv04Lt5dpPwc7PgTn2MVmxZfOpqIc40ImoRnZfWpRSTT
 qTbQuy/PX1UY8yoWPDex4JiyzFy9dI4BXgFdfq0EoPlpYV1NrD6YGwG9dTiqrBnz2cBTjsgu+uG
 zEvp5yLyGNAnen5G0bDTaEAX0FTgACQWTYbMuzxfrYAAPlDjP6z6QSyitmYfY2rS2VdMX48k1tU
 fDnDXTJPWTb2MqsLr2us5gSx+g4JU5zJprKayhV8czUSTtq8NWNAwUSCbeBemwIaOCsEZ6/6DCG
 gQavIV0ep6LcA=
X-Google-Smtp-Source: AGHT+IGakU9p5jhlouHTot85tqzwsJzhkEblpwepO6Jpag6s+Rayam5b/FLx5WaYeV0IqSaV+lNGjw==
X-Received: by 2002:a05:600c:458e:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47939e5dad4mr116714185e9.35.1765272301329; 
 Tue, 09 Dec 2025 01:25:01 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7da1dff5sm11913265e9.15.2025.12.09.01.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 01:25:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A3E035F87D;
 Tue, 09 Dec 2025 09:24:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Stussak <christian.stussak@imaginary.org>
Subject: [PATCH 2/4] target/arm: ensure PSCI register updates are flushed
Date: Tue,  9 Dec 2025 09:24:57 +0000
Message-ID: <20251209092459.1058313-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209092459.1058313-1-alex.bennee@linaro.org>
References: <20251209092459.1058313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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

When we handle a host call we report state back to the caller via
registers. Set vcpu_dirty to indicate QEMU is currently the reference
and hoist the flush_cpu_state() and make the call unconditional.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3228
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Christian Stussak <christian.stussak@imaginary.org>

---
v2
  - Fixes->Resolves
---
 target/arm/hvf/hvf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 70d34063df8..8e2940217a6 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1942,6 +1942,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
+            cpu->vcpu_dirty = true;
         } else {
             trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
@@ -1958,6 +1959,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
+            cpu->vcpu_dirty = true;
         } else {
             trace_hvf_unknown_smc(env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
@@ -1980,10 +1982,12 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         error_report("0x%llx: unhandled exception ec=0x%x", env->pc, ec);
     }
 
+    /* flush any changed cpu state back to HVF */
+    flush_cpu_state(cpu);
+
     if (advance_pc) {
         uint64_t pc;
 
-        flush_cpu_state(cpu);
 
         r = hv_vcpu_get_reg(cpu->accel->fd, HV_REG_PC, &pc);
         assert_hvf_ok(r);
-- 
2.47.3


