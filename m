Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB15AC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcY-0002Za-Cd; Mon, 24 Aug 2026 01:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcV-0002FO-Th
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:19 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcT-0003Jj-E0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:19 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so3272079a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550796; x=1788155596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPNgUHd+lJe4a9U4qvFdC9kJEshhAclF3rpUjR0wmls=;
 b=q3OulLLQi2R+u383hJ6Pp2J6tX96gJvNdcQsOOeIMiAcKj8MLVoW3cy4Xp+q7q/XnK
 AwPmyuVResbqxlZoISooLStuGTCfS+CAZ/lwYUrovEi9pvWUMRUvnqFM5hwGjMDvT7C4
 naj69IFrBoOoyjkVpsch0e91HCTn1hAM+uf+FL010IDzJW3MWJsjljfhnTY1cCbrigS2
 HPThShYON+JLIZk94yFnkqsnVrjqhUP1PkemAGsobJClBV2eed90W7jezlhOcgmZ67gr
 sTzSZGa9RCyr28ZbDGThJvpguq90CC/PkncNcTT/zyXxOpF09J3TChLB5+Za8x4z7Waa
 +lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550796; x=1788155596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PPNgUHd+lJe4a9U4qvFdC9kJEshhAclF3rpUjR0wmls=;
 b=PHqLHBONxh6JjuoRmkjzWdOjCH80kVylURDaACVKYh11OS/ltzwVBoSO6jnpdLhpSa
 9QQRDPtj3FM5Y6IIeB0hSiDsBFpHr7sQI01Mt1iOEfONkmC1yCpXMtyyljOau430YKpD
 qXTu5blg2PZcGwUUzl19HmtY6qMpWxm8L7vppNvoVzMSafr5Rkwqgcvbsj5KhAyBaQS4
 fQU56eIPZB6ceZ5t6eMEU8EGLKGs2je3rdI2up5I+clI9AizQW59+K+kUXIVaHeyL7aQ
 t9hTH3OJa5IYOESd/lXcdENqavcWG+chPrvQ9HhG2YYGlFDj/WuPzd8d6eK84VUiVmx1
 kaDA==
X-Gm-Message-State: AFuF++lM3RSZRahFuc61hjRh/V46qF+TCtiB5xPtLUoQP7eINEslt+R8
 VUU07NbaPY4krtkqDQSHg/ufF/NwEULgwC02Oksb3iPHqXkdS7jeyQKKjKERig==
X-Gm-Gg: AR+sD11b2PDxvW2nEEyANgHi9DeX7l8UJ2stNuI9Ru9y22roxxW0qWjd9WOcfAA5iLO
 rIWy+w+8Kv+etvnayt+dSBfOeGDeG9NBPXAeSBKdPpnOqDgO5sQMf+fkCK4GCI9Fdaqs2PqyNuN
 AXHSGa/pbOBuZB5xpDCU8BILNdtYNrLzG6yVDxyahXynCXm9Dq0QH1mFJtEVfmXynIGrNgK5ejw
 Dwp5YjjjaRaTtfGRpFSW2FuTPlDvsym4VLe7HLhrYlBZuUuADLPN12g9j8n4jd1ItMY2kwIL10Y
 ts1+VG6Muq8eMpRF5s5wjjs701yLbP89kdP0+kuO16eb8itnP0kJ0OwFuzbE5qb5Ivbv6kF6cCj
 x1eBWWElZ/3Bo0WAyYFy4VUrVgi72FsLM+9ANaymcZ25ebB+LDeSWWBCMdogIrGqXn75ud0psyy
 e9Js/ZCmqyjmyP2RVyI7cLujnaQuB1TkAnTgyJYfeLkbgEkf5IF1fbFYtFWggQ6dDjigMgFy51w
 H4BYw==
X-Received: by 2002:a17:90b:164a:b0:390:b41a:b92a with SMTP id
 98e67ed59e1d1-395deeaa2dfmr26778907a91.4.1787550796056; 
 Sun, 23 Aug 2026 22:53:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:53:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: "Christian S. Lima" <christianslima@proton.me>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 96/96] target/riscv/tcg: sret in virtual user mode raises
 virtual instruction exception
Date: Mon, 24 Aug 2026 15:48:06 +1000
Message-ID: <20260824054806.2790041-97-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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

From: "Christian S. Lima" <christianslima@proton.me>

Currently, when a `sret` is executed in virtual user mode, qemu
raise an `illegal instruction exception`, but in this case the correct
behavior is to raise a `virtual instruction exception` and the code
already contains a check to it, but it's not enough to catch. This
patch is useful to improve the correctness of the virtualization of
the risc v architecture.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3622

Signed-off-by: Christian S. Lima <christianslima@proton.me>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260808031849.59726-1-christianslima@proton.me>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/op_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index a7bd42d2c6..3e94005d2b 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -308,6 +308,11 @@ target_ulong helper_sret(CPURISCVState *env)
     const privilege_mode_t src_priv = env->priv;
     const bool src_virt = env->virt_enabled;
 
+    if ((env->virt_enabled && env->priv < PRV_S) ||
+        (env->virt_enabled && get_field(env->hstatus, HSTATUS_VTSR))) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    }
+
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
@@ -323,10 +328,6 @@ target_ulong helper_sret(CPURISCVState *env)
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    if (env->virt_enabled && get_field(env->hstatus, HSTATUS_VTSR)) {
-        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
-    }
-
     mstatus = env->mstatus;
     prev_priv = get_field(mstatus, MSTATUS_SPP);
     mstatus = set_field(mstatus, MSTATUS_SIE,
-- 
2.54.0


