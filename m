Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C977C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEi-00017o-69; Fri, 10 Jul 2026 16:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEf-00015l-JA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEZ-0000ba-FI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8478fe07f0fso1455558b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716846; x=1784321646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NCYrAVPYzdovZO0+mJzi1+ftzAz885Lyc3ZdMCVw2Io=;
 b=IKMJpf2fH/2vq6PvheUOQvIvlD1mpLE69m9GA2Nx4R99Z2VytosV6EcP0USP89/7vR
 Wyx7mOpBI620l3Ecc5zu1gm9e/5WT/mgoVjLlwO3yA6JwAffgSRrUIbOYBoccoRmCMyB
 kKOoEV8EStb1wlC+heeudxrzhmv0ZSr6BxABdwzccs0DsJEjx9mCi8O8nN5Ri7tr3R3D
 TK0BG0mRXdC+MzvpOCeMn84iiyOhZbJYpxciyGnsEONNbQk6Qsfal9ZgkOSFjF/5a5lQ
 5SdDOyYetThICPxxUhzXt2V6BU4HihVTq4CMh7biUPHP+ky1ivZvSmd3+m73/8L1Foh7
 Tq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716846; x=1784321646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NCYrAVPYzdovZO0+mJzi1+ftzAz885Lyc3ZdMCVw2Io=;
 b=cFoHNs+Jb9NrRtTTLRYagBghAIPKsd7DUtzoSen1CI36tXu9wU+sWHkfJ+T/I4Jdoq
 NFPaI/EyP95Eo8MXslrLhYdkTSduwxoKoxivUSrVuYfDVUPTlPruOKzepYklM/Pg0PQ4
 PXT9qAHA6+ibqFh3SoYlA2MRGYJ+q6/SaQXmOU9M4c88OV/q6n3O9YAp+Yk5Z8Iewcnz
 TBa+UUm522sF3ZMC22mym7DIs/rTItrAmfYg/BRr91PPPakd9eXeanRIkWd0FziDSeOa
 heJ/iVVvSUJoC7cKVKaFS/v0IRiKLKpDJNGJ6pCe4GK1ypkCHJcIPOhjzBNlp35WxFfj
 VsZg==
X-Gm-Message-State: AOJu0Yyc++kudjy6A4G0OlEPtZmyrsTsn0a8DWNpzV0pt6UMO37rQ0S1
 SPPUtfZMFHYK6lkIiqmXBmnFElXWdIqgORFl9GnVjKTxFrwvdYTsuOZxJhBQN7tREfPXN2yi7E7
 oBPsq
X-Gm-Gg: AfdE7ck1V4htQ9R/0llX0zrQnrsIJp0VjCh1zo+8t8nmFkr1eI6CV3uI6gfto3LdwgQ
 tyyfc38XNuXcdIWLO4315+xtkbBv9SO+i/cQQV1S4SNM0MRuCvM0IoLrtyoSlG5ERIAimRg+OyU
 RVd9GJ3KJxXnwND8BPlv15uETi6FzHgUrSL+nvypF5jUSIDoNMXMePvVTONPGgHA4ZFkUOxxbY6
 b8f9lnu4EVtOTp/JZuTBpjgnIJ0HLIpDl5bO2FxOSw3me7sFiz+bWit0yN/DHH5eoo4y4fN1B5Z
 AEd0pfZHujDds278tBErRpNl5L4epFgO3wE2WiiRmMM1IHN0v09Dtg58E4OoFqhOirNkhapYuyu
 KIhPQHs736hiYMpXCljdN2+/T2SBa0Y4LB6rJoCuBYfmld83G9wO8fH19w76EsmO+hIjze5KswM
 QueBj81i2a3CkUfNjderSsyT7eBawk
X-Received: by 2002:a05:6a00:1d09:b0:848:51b3:f3c2 with SMTP id
 d2e1a72fcca58-848897ebf6fmr461615b3a.33.1783716845907; 
 Fri, 10 Jul 2026 13:54:05 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 02/51] exec/breakpoint: Move BP declarations from
 hw/core/cpu.h
Date: Fri, 10 Jul 2026 13:53:12 -0700
Message-ID: <20260710205401.836304-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Move cpu_breakpoint_* declarations to exec/breakpoint.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h | 7 +++++++
 include/hw/core/cpu.h     | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index df772dfc70..e6aa630d17 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -43,4 +43,11 @@ typedef struct CPUWatchpoint {
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 } CPUWatchpoint;
 
+int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
+                          CPUBreakpoint **breakpoint);
+int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags);
+void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
+void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask);
+
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 82b5136088..786e9b8aad 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1149,13 +1149,6 @@ static inline bool cpu_single_stepping(const CPUState *cpu)
     return cpu->singlestep_flags & SSTEP_ENABLE;
 }
 
-int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
-                          CPUBreakpoint **breakpoint);
-int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags);
-void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
-void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
-bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask);
-
 /**
  * cpu_get_address_space:
  * @cpu: CPU to get address space from
-- 
2.43.0


