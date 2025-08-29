Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41512CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNk1-00085s-I1; Sat, 30 Aug 2025 11:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7WS-0002bf-H1
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:40 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7WQ-0002Te-Jm
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-771fa8e4190so1831382b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506276; x=1757111076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9j/Bp+Ofsaajc1QH9mZ+L5jNL3buNCRIVJFSBOGhwRM=;
 b=fm5+FLuhVhgHKpvQkef1V0Qg11O2VyrninPeD3CPKsNiwbOP7BkLrA7GtFRhD9+YzX
 hMGAZggYb39wI8EM77aVymc5J2ORicTL1HxMnThDzBuB35L7Sf/QAYePG1SjMzRUZ3YW
 8gSvlW7cp+AuilGyNneJiwxOwByAwg9elj1/CjD5PSoiwIxTMIQpVqUw5ydd7sS01MUd
 4/yXyE2LSeIzwUoVAa+KlU26YFEejVcFUJmx6xOGW1b7rIdNYNIZWygXw2/w47Gio2z2
 G9Kr19t37yYoBhfYUwJlvnsd5pvLWD/fER/z5G0ZNesLLtBHWG710Er7Y1Arcjbuvwwf
 aVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506276; x=1757111076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9j/Bp+Ofsaajc1QH9mZ+L5jNL3buNCRIVJFSBOGhwRM=;
 b=ErlBWv35Arrwik9YGqgnseWnU362n11oY6GaKRx0ZjIJMArxgSQ7N4u3vZG+FprFof
 2S/KPAeTzfeHTUcZtgVSy9rucSNGIA1MUd6SZwNnLssSq/M7hF9tGAzJIsVH7BXNs5gK
 zt/yLbk0U0kq/cI9RiVW5uemrGZuGt09koV46EVCohg9J2/nIVbj762JmH5CAKg/bzHi
 oj+qyhS2QS/YW+GmOdQaV4lUJORlMVflbctWuYl56wFNN/Vo9PGnvXKVnOAikMyfUdci
 Ioo+ccaivzziuXrWDd6JWwPaufE1BUkb0rsyfyzY96ijUPui/jlxoKu78kIXU4mn2eZj
 K3PA==
X-Gm-Message-State: AOJu0YxGy81QFdYE7uq1EFN+6QGjX2gvdL3eFwOHtWzYRM0Lre4XOPg3
 4WZIBdF1lBaD+JqJnDfiPvyNAftYOYPe3n6Ti5y46pQ3SJfsyK2aGpK+jhHpSBB4NzmKC4hCqnm
 G6zlk4uA=
X-Gm-Gg: ASbGncuEMCCreG3YHcj+DR0yyvfEf6jqN41uaNIO0JY7I4Fl/X9VGvov9WqRtC0TEel
 oG/5z7unnzT/DYQpzOCP/TqvFr1vKJtGJLwETpUx0/Y+38+Q98GSgJ3LqalW0eypTWTQXM20tMy
 0iVP7tKc+30RmTWoIh8Lqre/D/abPAz5JJWzeoogn91X9D6xSpSHbim67t+XQK1hbR4ZuA2lIis
 POkrYYT1M6G5uaVx/MJ2JauJZbOP7/iXuCO2MXeaH5Xs4Qggx3Ns8hQ+GGoqqHlzzTni3EFU9OV
 2dSh66S9RdzqB6ihOLcK+f1avn8E/jK73vxjtuiCJVIkXPKZSVj9GPRzQIqS8kDzQXRXDaZNZTT
 Ezix7QuF8pWFw6bMQWkbIoP/ZtSTSx6ktn8XvBVJj04BuKG2qYLCM+atnF6MI9+gy8tdUatQ=
X-Google-Smtp-Source: AGHT+IGCdRpiAhMCHrjl69TC11Slb+COrriaZNgW0wF5wecI+MQTw1M9Q70VNHRL+B7zAWLfovR6Mg==
X-Received: by 2002:a05:6a00:4616:b0:770:343b:5457 with SMTP id
 d2e1a72fcca58-7723e308528mr242100b3a.16.1756506275764; 
 Fri, 29 Aug 2025 15:24:35 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Henk van der Laak <henk@laaksoft.nl>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/91] hw/core: Dump cpu_reset in the reset.exit phase
Date: Sat, 30 Aug 2025 08:22:57 +1000
Message-ID: <20250829222427.289668-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

During reset.hold, the cpu is in an inconsistent state,
where the leaf class has not had a chance to initialize
state at all.

This is visible as a SIGSEGV in "qemu-system-sparc64 -d cpu_reset".

Move the dump to the exit phase, where all initialization
is certain to be complete.

Reported-by: Henk van der Laak <henk@laaksoft.nl>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/cpu-common.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 39e674aca2..26321be785 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -119,11 +119,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cpu = CPU(obj);
 
-    if (qemu_loglevel_mask(CPU_LOG_RESET)) {
-        qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
-        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
-    }
-
     cpu->interrupt_request = 0;
     cpu->halted = cpu->start_powered_off;
     cpu->mem_io_pc = 0;
@@ -137,6 +132,16 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu_exec_reset_hold(cpu);
 }
 
+static void cpu_common_reset_exit(Object *obj, ResetType type)
+{
+    if (qemu_loglevel_mask(CPU_LOG_RESET)) {
+        CPUState *cpu = CPU(obj);
+
+        qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
+        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
+    }
+}
+
 ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
 {
     ObjectClass *oc;
@@ -380,6 +385,7 @@ static void cpu_common_class_init(ObjectClass *klass, const void *data)
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
     rc->phases.hold = cpu_common_reset_hold;
+    rc->phases.exit = cpu_common_reset_exit;
     cpu_class_init_props(dc);
     /*
      * Reason: CPUs still need special care by board code: wiring up
-- 
2.43.0


