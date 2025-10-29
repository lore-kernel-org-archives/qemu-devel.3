Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD5BCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8ST-0004c5-7E; Wed, 29 Oct 2025 11:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SR-0004al-OT
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S3-0002u5-N9
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:31 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b626a4cd9d6so2224066b.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753059; x=1762357859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uP6UFPzOs5VzsipNmOA4LajH4groxk/LhsikWmtW740=;
 b=u8jtZiHVsWGPcH1trNEQeXvRiJbVqKwSLN7QpEXUFfr7gL5OR1Fpud24Qv/FNVkv7z
 9SWxGISTTPxFdNy1gRdrRE+5kejASnjk5UWuTlRB4qqb7hze2BGGheBVKXVC6/Mp1d2M
 QzGlBhdIrH5kWIb8GKyxmqX+1oS8iuremEh/WMPXAcFl9U9norFnXQJdAzSomRMDBZSA
 vkPBwHDoCUO5e2SBpSPE17wBE51d1Nug2dZm/hk6hpcRNxN1odi8yM7RjFpk5vjD+F5N
 yIUFjHKoeVHYMYOSGsHnBmgDnnXuJwFHAKouS0tp5lVgKndwiBWbdHVvyZhdN6GRK1TW
 bBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753059; x=1762357859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uP6UFPzOs5VzsipNmOA4LajH4groxk/LhsikWmtW740=;
 b=R5Af8pT2oNCw0mKreL7BGYdr7VhF1BuFYjodGbLUy4rIHhB4Z5M49baXagg7S6zS7p
 I68oLSUL+U1W5Jjb75lOMTmx6SK3XqPeRflVboGGU2M2zXJXhGD7ePkSQrB/x+M+aQ6g
 v2Rp/+CL1paz1xLpQuGUJhDP/99RUkY9fm+kchIfvLE8BPAf9u5m4+9kpMn8wwUr/iDU
 cCGyrkCaFG3KiM4dvUKwBId3cpFwPFCFw+OEL8EG87hmhNF8fhgHh73AZBH7S3YGCqfH
 0lp9u147L4mfPz4Gn0HNVA+OX7PujfRK8sq0hdSekRjuddrXWBE4VT5eGlGfr8AEdpwK
 5VTA==
X-Gm-Message-State: AOJu0YxmstzTKKFSXaTDVvsK0UfN8AcTayNoA+ES8QKofvaX2XDL6BO5
 MpHqXYHaE5y/BZ9We5O4AwDfnbQ8Z5i0vs7/e6x7mnplFBOR9y9ot6jH2u/vG3rHQao=
X-Gm-Gg: ASbGncvRVUFmInRJI2InHR2q9L0fO4rqP+BVeR385qwBlKl0cw1kb2qF1ue4C1Ao6O/
 sGqgcJ3+KzqBoxyJEU1EePKPYGPqzG8+IikYn0YM7JY2Um5kkyYrHOh+3l5T303gangu/2GYGue
 H5m9vX3YzM3htxV/xn7yAKiRfeqa/b7Lt6vUVNcZZaHVm2dhIrY+3CKjiYEQSBl1fIldrd0GD5d
 S1gL772ez9y0Pbs37aau3o2GRPq4V/CVsNa9Nv1EVSMk00Lp/jDsOo11+bExu5yQaLZw11CQA8h
 x/beZnGcYg/01vv+XGbw1+lMvFaaHRA7JX9x8Dj83km7A31A91xYbFQOwSvuVMLqw317edRrF3l
 TVlGxLE0+NQzmg91rms4gpw+e2+jDfm0gN9augbugbnFmaYYlUYN6XBI/oPf/bvE8GUXToXt5zD
 p2
X-Google-Smtp-Source: AGHT+IGpjByL7vfdJDTEqRI0K/9K+lVbmHa8nHBQ4Twl3mkC0fc2tNzdooDZxTPPUFY3SRwdcDN76g==
X-Received: by 2002:a17:906:c108:b0:b6d:6a4d:d922 with SMTP id
 a640c23a62f3a-b703d4932cfmr304593966b.42.1761753059029; 
 Wed, 29 Oct 2025 08:50:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6da1e2226fsm1058044766b.20.2025.10.29.08.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B879E60C1B;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 19/35] target/mips: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:28 +0000
Message-ID: <20251029155045.257802-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This change places hooks for MIPS targets. We consider the exceptions
NMI and EXT_INTERRUPT to be asynchronous interrupts rather than
exceptions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-20-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 1e8901556d6..566924b079e 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/plugin.h"
 
 #include "cpu.h"
 #include "internal.h"
@@ -1034,6 +1035,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
     bool update_badinstr = 0;
     target_ulong offset;
     int cause = -1;
+    uint64_t last_pc = env->active_tc.PC;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && cs->exception_index != EXCP_EXT_INTERRUPT) {
@@ -1052,6 +1054,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
         cs->exception_index = EXCP_NONE;
         mips_semihosting(env);
         env->active_tc.PC += env->error_code;
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     case EXCP_DSS:
         env->CP0_Debug |= 1 << CP0DB_DSS;
@@ -1336,6 +1339,14 @@ void mips_cpu_do_interrupt(CPUState *cs)
                  env->CP0_Status, env->CP0_Cause, env->CP0_BadVAddr,
                  env->CP0_DEPC);
     }
+    switch (cs->exception_index) {
+    case EXCP_NMI:
+    case EXCP_EXT_INTERRUPT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+    }
     cs->exception_index = EXCP_NONE;
 }
 
-- 
2.47.3


