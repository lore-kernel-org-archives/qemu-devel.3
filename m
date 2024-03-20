Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B56C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsJI-0002kj-Np; Wed, 20 Mar 2024 05:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rmsJF-0002ip-QG
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:32:33 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rmsJC-0003Lj-JU
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:32:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6cb0f782bso5609551b3a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710927147; x=1711531947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1lBTSpYR2dXwEYHy3omOeOtfSocMS/pLnUSSLI1d0RI=;
 b=UXYWoMkjXoRDOvQMyv4yTCjXf6Nj1kAItuJ3hRm3Q+g3EmVp/6rPbeq2g5eV2Os+68
 LUrAtMqUY84Vi7lrY1bREhQHKSJV91moXyerUs97G+1vu4NRZ4QRlF1+WiOvXLLnvMfO
 lTyRcZIRY/vrL0ZRv5KOYelUz2etNmLYMXrf6RYF7hqRzBgGahRo0PqmK5zt65waTc7f
 ylDSBRWOd/mSyMO9TJuQqWkn+UvTnfHuFlP9gfZxg1fU/y7n0ZrzVGzM+joFQ+eFJpTc
 CxRzVGpp2L+u0bWL8Mknh5bHqB4UqudNr+DsyIB43axLflchqPERb1v3mUVnMQqUO0Eq
 g7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710927147; x=1711531947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1lBTSpYR2dXwEYHy3omOeOtfSocMS/pLnUSSLI1d0RI=;
 b=KvpFmx6SomUVAItYgs7rVBdYlZC516razbeBpqBfS/ZFndiirI/aFlzfcFXC9B0h8P
 zOtQ7hnEDRnlA0hszkhvxBU/ti0eSGT7a35Mv510wuSp2vKzGPm1QBW8DsQi5vlcG/WG
 tUDUkJWioCc1wMrDeNYiOSwvTfO2HwihYT4Q9J+fYv96itSncxLbU7M9fpFm5Qa1PyeX
 s7dbfka1BrEExYpYNeYILybid8IWFzsicQCgbYT/sIfVylFfAhEfeo3B0ODXHrHCjtf/
 x3SjFxggJeIdmG8dQVHOnK6OZRtY01/JrE1jVJqR4RonESCUMDJ9FLwi4JMjESTocx+b
 MP5Q==
X-Gm-Message-State: AOJu0Yy/LZrZQdzzAsOBy3TkjCIHcnd3JV7laY3N/hFVIYolRpRuaZoq
 4RgRZWXrcLn28vc7Z2syHT1V3JmmXV21CB9I3cm+AnGIiz09AEmnqGhvjGfJ4me/yqFLPZ5ike9
 r
X-Google-Smtp-Source: AGHT+IGc2LdAhvuKEVF4ZnAkIxgELD5v8Cw4iirGDv9ag0eVnuY0YIh7Y3P9eFzjLgHGz1JliMqZWA==
X-Received: by 2002:a05:6a20:9c8f:b0:1a3:4469:769b with SMTP id
 mj15-20020a056a209c8f00b001a34469769bmr1307374pzb.44.1710927147406; 
 Wed, 20 Mar 2024 02:32:27 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 jj18-20020a170903049200b001dffa017c5esm8707613plb.22.2024.03.20.02.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 02:32:27 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joseph Chan <jchan@ventanamicro.com>
Subject: [PATCH for-9.0] target/riscv/debug: set tval=pc in breakpoint
 exceptions
Date: Wed, 20 Mar 2024 06:32:21 -0300
Message-ID: <20240320093221.220854-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We're not setting (s/m)tval when triggering breakpoints of type 2
(mcontrol) and 6 (mcontrol6). According to the debug spec section
5.7.12, "Match Control Type 6":

"The Privileged Spec says that breakpoint exceptions that occur on
instruction fetches, loads, or stores update the tval CSR with either
zero or the faulting virtual address. The faulting virtual address for
an mcontrol6 trigger with action = 0 is the address being accessed and
which caused that trigger to fire."

A similar text is also found in the Debug spec section 5.7.11 w.r.t.
mcontrol.

Given that we always use action = 0, save the faulting address for the
mcontrol and mcontrol6 trigger breakpoints into env->badaddr, which is
used as as scratch area for traps with address information. 'tval' is
then set during riscv_cpu_do_interrupt().

Reported-by: Joseph Chan <jchan@ventanamicro.com>
Fixes: b5f6379d13 ("target/riscv: debug: Implement debug related TCGCPUOps")
Fixes: c472c142a7 ("target/riscv: debug: Add initial support of type 6 trigger")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 1 +
 target/riscv/debug.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ce7322011d..492ca63b1a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1717,6 +1717,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             tval = env->bins;
             break;
         case RISCV_EXCP_BREAKPOINT:
+            tval = env->badaddr;
             if (cs->watchpoint_hit) {
                 tval = cs->watchpoint_hit->hitaddr;
                 cs->watchpoint_hit = NULL;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index e30d99cc2f..b110370ea6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -798,6 +798,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
                     /* check U/S/M bit against current privilege level */
                     if ((ctrl >> 3) & BIT(env->priv)) {
+                        env->badaddr = pc;
                         return true;
                     }
                 }
@@ -810,11 +811,13 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                     if (env->virt_enabled) {
                         /* check VU/VS bit against current privilege level */
                         if ((ctrl >> 23) & BIT(env->priv)) {
+                            env->badaddr = pc;
                             return true;
                         }
                     } else {
                         /* check U/S/M bit against current privilege level */
                         if ((ctrl >> 3) & BIT(env->priv)) {
+                            env->badaddr = pc;
                             return true;
                         }
                     }
-- 
2.44.0


