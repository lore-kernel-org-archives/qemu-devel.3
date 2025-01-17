Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D69C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLb-0004lT-64; Fri, 17 Jan 2025 00:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLY-0004kx-Md
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:44 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLX-0005xp-3b
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso26342355ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093401; x=1737698201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIrykECdcu491PoUvUYIaGzG6VL7JqV6pZ9zQGX7IOM=;
 b=cOgadeRf83dxTCL8zks8v83cLISVIa65EBPEuqyt6AapS9H/8Zi2uEJY2qZCTfFjL6
 eIXVfVFsf6hzKu5/2A3Lvy6tYHyTNNguA7NomimL5N9UoEpdqigHuFIXELIJe7clWEqj
 L4x7KzCnJAp0O58w/CuUk2iud79c07Id1x0bZae6KqGlSQGi4bgzbF/W5+DLw7iItfX7
 va+Wr5LsmRw5bLemQNvc8fUKCMYL5MhvNinLk9I2tEq3A8vkQ/knMX/QLkOhvf3qJRV5
 2ik2LHGFG2WXhF86V1lR1dt6ofqssD28JwZ1tBPeEeyyO2hvMU7KUV1snDDu5FXK8XIv
 MfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093401; x=1737698201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIrykECdcu491PoUvUYIaGzG6VL7JqV6pZ9zQGX7IOM=;
 b=UVhUqjycQJRLwAkgMCkoHPjPyQubrlVW/KhuLCzABMHcjKKLMo1OmckUE9jtMOBRzm
 Fpgz84An/FcmTdfGZH3gwCj9PaEMI3z09xMRvkpB8ap9bxt/+x7eEhDx7/yM3jdYh1cL
 ADdECopzXWLun7AXi4TfaEmAQOfZVNHaMpiK9hAMpzokfwncJxF3ZJvC+OyhbXfdlVPV
 BaEiDMmjTNNB9EpuLcfLPUMIOVcmzGpmKweM7oQ8F+zyrpPSw+57qSp37Wy6Q0AL2qgn
 EmxJNtDa6xXeXMLRQCoEd9KLZ3B+f6J5d1sKYzjvZYoCVu7Z4+FsQrd8xwbvm5ufy4ZR
 3ESg==
X-Gm-Message-State: AOJu0YwyK65uIxS16dbkteUsNM5NH9XjLWVXGaPup6L0lui2ficIcnJo
 Fy3hZk0qj872B/5keqIKQDSIYWmDXKuhIz19GMjz456YZhOgZkTd0hgG7w==
X-Gm-Gg: ASbGncuKNmtDe3G/g/kU/AQOK8zKx8+R7fsNmH6489B3kpvfAk/gKjtHhLzZa7TA9S2
 YIOi5vIiCw6wI+QwDuE8zn+OZSMFsEXO09GoNHqbCpD7vQ6o6U04ceKaFkGnHsiUvNBEOo6TrGg
 JqmoaJSUH6J+5KWNNJ+p32+/tN8lSjCXqZDXCdq+QthUFqiW2OWP/K6ohdc2JxkqjkU2ACHgE/X
 Xma3oggxgd2KoRpwleHf8QLK2Q3EsueWka/geIrorD04kkLF13qBhRUaK9vbr6X0mIqvScYxdA/
 3bMcG/TNkFkA47dk8qsmysDUKm/zRF6pOsmI8+0Tg7IiMohX/Yv9K04xbQp/
X-Google-Smtp-Source: AGHT+IGbajgklityauZSwYZVcsDNovtYVlruN+xRu6UOScSd6JDs86AZbvtBahIBtPo4F5k/XSVt4A==
X-Received: by 2002:a17:902:d4c3:b0:216:7ee9:2212 with SMTP id
 d9443c01a7336-21c3554fd20mr23763575ad.23.1737093401379; 
 Thu, 16 Jan 2025 21:56:41 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/50] target/riscv: add trace in riscv_raise_exception()
Date: Fri, 17 Jan 2025 15:55:14 +1000
Message-ID: <20250117055552.108376-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

When using system mode we can get the CPU traps being taken via the
'riscv_trap' trace or the "-d int" qemu log. User mode does not a way of
logging/showing exceptions to users.

Add a trace in riscv_raise_exception() to allow qemu-riscv(32/64) users
to check all exceptions being thrown. This is particularly useful to
help identifying insns that are throwing SIGILLs.

As it is today we need to debug their binaries to identify where the
illegal insns are:

$ ~/work/qemu/build/qemu-riscv64 -cpu rv64 ./foo.out
Illegal instruction (core dumped)

After this change users can capture the trace and use EPC to pinpoint
the insn:

$ ~/work/qemu/build/qemu-riscv64 -cpu rv64 -trace riscv_exception ./foo.out
riscv_exception 8 (user_ecall) on epc 0x17cd2
riscv_exception 8 (user_ecall) on epc 0x17cda
riscv_exception 8 (user_ecall) on epc 0x17622
(...)
riscv_exception 2 (illegal_instruction) on epc 0x1053a
Illegal instruction (core dumped)

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106173734.412353-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c  | 6 ++++++
 target/riscv/trace-events | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 29c104bc23..29de8eb43d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "trace.h"
 
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
@@ -31,6 +32,11 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       uintptr_t pc)
 {
     CPUState *cs = env_cpu(env);
+
+    trace_riscv_exception(exception,
+                          riscv_cpu_get_trap_name(exception, false),
+                          env->pc);
+
     cs->exception_index = exception;
     cpu_loop_exit_restore(cs, pc);
 }
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 49ec4d3b7d..93837f82a1 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -9,3 +9,6 @@ pmpaddr_csr_write(uint64_t mhartid, uint32_t addr_index, uint64_t val) "hart %"
 
 mseccfg_csr_read(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": read mseccfg, val: 0x%" PRIx64
 mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write mseccfg, val: 0x%" PRIx64
+
+# op_helper.c
+riscv_exception(uint32_t exception, const char *desc, uint64_t epc) "%u (%s) on epc 0x%"PRIx64""
-- 
2.47.1


