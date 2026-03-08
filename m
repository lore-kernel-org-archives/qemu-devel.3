Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFE3F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8QV-0007v1-E0; Sun, 08 Mar 2026 03:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8QI-0007Su-0q
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:37 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8QF-0001oC-DS
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:33 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-128d2e3074fso356232c88.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954369; x=1773559169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwES2RO/KEYppoyZt0FJTIF1i34Igg6OFEnsCwkhiD4=;
 b=RYAP6W6mifDjeOnxer3IQzTpMwGmgnEXSYniSekQwEAl9uGQMjiDOueJWsEkTSKaGv
 TjfouSsl7zOwC/Caflj85Hzk8maNXKeRd38oyKmNH+Euyiddn+APB/WBwpyfWhdoVvRp
 1DyqrZj8dt8zq5bdxTwIv03/Pfk8FEDODvLCqWn5SmaeZ0Fwgy1Th43iivGpm5KU6TSP
 cgtDmDg2Cn6f+RyCHAaYE8RBDPgRe/qZIHbzdKcB683J9EYp633eTMb3abWQ7au4fRaH
 SBCIK9iztbiKOpUigAYwKnFNinlU+faQtmD23Dg/88ZSZXcSRgg1FXSjhUwaYOpufoHr
 //GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954369; x=1773559169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zwES2RO/KEYppoyZt0FJTIF1i34Igg6OFEnsCwkhiD4=;
 b=IXyA9Vuvgs0vLvzUQPCbhxjW+OUlx8rPdPkYh7J2g/FeTm+U0j8u6dtoOASTYRwoIh
 HO6Bh114astk9UaNYN05Ryxy6FA43XFfR7ZRb1LzwZ+1THSelotFwjKAUquVWdi3fDa5
 6z4dZALvAugERp9pzdvJoOWD2vAfUUO2YMd6WFFZQ0L+aX8joufv5mV4T5CRGFVQrbiJ
 YTED0fZ7/muqoeUQjg0SJmFBc3Tp5ENwaOdsZ64d1CM+/cdxAnUwpm1EVe0ZtEMjkE1v
 EEDUE9T7Xv+PSxZPzLSuURofNf3tDUCmsy1BwqDLx3r/YKiArorbZjB9PHHBcjDCQ11L
 3LDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOzCgUuI8HzxBC7i7/d0P+iMlBXIH7bn8bk+nIiwwRBV6ASKs4VzZXaF2I2VTwdCE47ekTubPPCkKf@nongnu.org
X-Gm-Message-State: AOJu0Yx6dYCuHfrQgFsHIr78+g8ZFbb9ydW50Zn2lYE4MuGHM3+T1aK+
 6kVFLp87ZMX/R9KoP3ciuSgSJ1oPuF5x/UX/hrA6TLUZRx3ME5xabcz5
X-Gm-Gg: ATEYQzxHJsXXK5UgJ1gddvVNH3GPYM2H3emayGpPG1703nI246uDBesBcZy4fjONltl
 1JxJmEa1HVTQC2wsL4LyhwiXygE5XXR4TzyVNnA/c/yJljWsk3uU2yH6Wk0HvYm0ULVdJfAdkTc
 cdEryoLAlR56BLEPI+oFOgBWwiEMAWacNARV4rLX+GSz1bfyFOel7oWoYTvAEQI2xvVyLqpd6Iw
 8ae4x3nKafgH56Y647SYV3wn0Xg0oN5D+sS6HkAjRa0c3rPt4UqZsZgY4kCtLSJ0GHc1wOhzfy2
 Qb4hOfsKrY6t0xF7Zd2Ifdq5h3l1GU/c4OsXNPnfIuya+GRCZWUZHdudyCqHW9Zfp+vRJFHjhLA
 vfqkzJ75ovMIM01MlMjtEprzj7kTSh2dFYUkP0DaNFZx3alJQQdyi/gWOrPSnXuCGD9C0yAVZv/
 O52o/AkVYhZmZowWyQjXfm+FtYFEUPzl6A3umWI8eiWuYS/yHSauxzdrfrFUw4dx6CFt7gXQnxu
 QK9xfjuohYq5QWteKKgx7mc0So=
X-Received: by 2002:a05:7022:239e:b0:128:d084:e921 with SMTP id
 a92af1059eb24-128d084ea53mr1045105c88.14.1772954369400; 
 Sat, 07 Mar 2026 23:19:29 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:29 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 10/28] target/riscv: send trigger debug-mode actions to the
 DM ROM
Date: Sun,  8 Mar 2026 15:17:13 +0800
Message-ID: <786eda45594a916e59d100c8edbeb141c5e8d79c.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When a trigger configured for debug-mode action fires on a hart
with a Debug Module ROM, redirect execution to the ROM entry and
suppress the legacy EXCP_DEBUG stop notification.

This lets breakpoint, load, and store trigger actions feed the
same ROM park loop that handles the other Debug Module entry
causes.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/debug.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index eb03f306b1..00fd75f15f 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -298,9 +298,20 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
             riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
         }
         riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_TRIGGER);
+        if (env->dm_rom_present) {
+            /*
+             * DM ROM present: redirect to ROM entry and restart the exec
+             * loop. Clear exception_index so EXCP_DEBUG does not propagate
+             * to the MTTCG layer as a spurious GDB stop event.
+             */
+            env->pc = env->dm_halt_addr;
+            cs->exception_index = -1;
+            cpu_loop_exit(cs);
+        }
         /*
-         * If this came from the Trigger Module's CPU breakpoint/watchpoint,
-         * we're already returning via EXCP_DEBUG. Otherwise, stop now.
+         * No DM ROM (gdbstub path): let EXCP_DEBUG propagate so the gdb
+         * stub stops the CPU. riscv_cpu_exec_enter leaves debug mode via
+         * the legacy shortcut on next exec entry.
          */
         if (cs->exception_index != EXCP_DEBUG) {
             cs->exception_index = EXCP_DEBUG;
-- 
2.53.0


