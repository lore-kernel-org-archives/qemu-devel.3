Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D60CC02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJsW-0001Uo-Vw; Sat, 18 Jan 2025 20:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsP-0001Ek-RR
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:22 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsN-0003CH-Oe
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:21 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2efded08c79so4644221a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249198; x=1737853998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4My+zKcVghrae68nYPFfh2ojjfFKAvrVhOKdHJ2McFU=;
 b=WGW9hxfPbCT5ufbQiwVVhZXdK6sxVNc/4s1i6B0YZYXtg+rJo/a/O4qj5syuVqAbYy
 9apU+iUuUjbSuZ7zSE/jR1rpeDcaAtzyXYF3ju497iNKVaCnaeAQTIXDVprV8mjSIfYh
 LsF6f/yniRx7MINQ9+yaw+oZnS3r04oqrwrqLKWLk3vDpvLrVZuBhIXmIE93JHXIo56E
 U+loCXhBvXTupxXSLaeKnIRgym5tggQbetRcP9bbruL+flXhYuThyvTpJ3KMyAtjLFfC
 EJ1slWybaZo9FlNDUbA1unALEb0bhdEXUIYCDbcRjeT1pSwY9euBTWOdNfgCbewGusOz
 h77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249198; x=1737853998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4My+zKcVghrae68nYPFfh2ojjfFKAvrVhOKdHJ2McFU=;
 b=Iclt+8426UxrtLPVSeWHGqgxwmCC4RyIpdv8ID8o0GN7k9hA0TTiC9bMjPa8WVUx1T
 ODEWHRWv3UEifGM3ExiunAxZYKjPh+qQYVeIwAhMtraguEnq3bqrFapCM4LX2/CDCTiV
 rwi5pDXh6eszDQJcp4f0OdacCZc2ppgX2N4vBQjbjQUS7t2rN4ccND98pWT3OnuUefUk
 Z8owTnwSNMc7IKwo2XiN5CinkrueNoieJPzeN45jTGKOv0H6uA3kwoR6owNzF7QAaoG7
 X8Ooo4iGbEOk2teVxWeTgaSsWAmaO/sgwv/oBxYK8zn/yiJj7zrTMeH/fBz+O8SxpaeN
 aZGg==
X-Gm-Message-State: AOJu0YyE+VvoPjd0K+fcEc2OWeNl0w+s4FSXq7Dpmch2DstU7mW0ji6Q
 VVD2XuDA/olKc7i4H1oGYgGwl+yr3WEZYaSH73jxuvzOACFEK6alOnjxftLE
X-Gm-Gg: ASbGncvWPFC2vdAaBIUbQqdeKPCv9JgVSkUlOep1KTcKLvC2rGO79AhKSXeqIYONzBd
 tntXWdBSbmmMQMolBw+weAZ6jCDtvWSNlfkZl5L1eWbJTBf/Gq9AK6bVfNVv/Ha7Nix3A2gH9D8
 ZSjHARtIdJPjmbyPVYYoglFDhrgPCBLR7qquOpdrsIYeWokNSSdWiQ73p9HmPg5Sz+AwcFywMYN
 raUZR2hCHZef4Wk4IjnfRbi5aacapk2iqOQXep/mbNmwJaNuGZHcUs6NPpYdX4amqQFfIxO3Rju
 OggWIjnk4rW+n8kNF5ieNJg9475W9kMUV/Y7r1P5Uazd6P8w9c2JmnhCmtsVSop8B/fES52cmA=
 =
X-Google-Smtp-Source: AGHT+IEHu8E5PreteMYGVqkR6fQLuEoGx/QR0QDPt2Ae09B5QvgsNXtbLIkg5721ysVT9Rz1ZG7Ybg==
X-Received: by 2002:a17:90a:d887:b0:2ea:3f34:f194 with SMTP id
 98e67ed59e1d1-2f782c90219mr12766318a91.10.1737249198152; 
 Sat, 18 Jan 2025 17:13:18 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:17 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 12/50] target/riscv: add trace in riscv_raise_exception()
Date: Sun, 19 Jan 2025 11:11:47 +1000
Message-ID: <20250119011225.11452-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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
2.48.1


