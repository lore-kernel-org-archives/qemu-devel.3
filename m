Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7666C5AC82
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 03:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsXaa-0006O1-TU; Fri, 07 Aug 2026 23:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1wsXaY-0006NU-HZ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 23:19:11 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1wsXaW-00061O-U3
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 23:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786159135; x=1786418335;
 bh=mh0FEJqUhB0Yyu+ZUdTjjWJkbEYz7wuDd+G8Ynm31rs=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=MwiRb8o46f2Ymj9l7ZCqhp6yLwH8SmCfhHFZZyB2nOFdT8DPDJdb7p6q293vLGK7R
 4b69I3I803geaOwU3kChh66DsfZZ9k1+zQi7Mc0QmlFzIQTw1LgqQeIHAIjtLZ5Xm7
 f7C4JBoEz8SU4ENHtyi81AqfPYF8Tn2Hvb0959CxGbfP676JdLbBQgl0TvAkCsE0ed
 oL8Ev8ZJ25elTG7CdZd1tETdNqYntqJWq2ceBfeCDO1hRtBS3zi5dqxNQZbI7BS+SH
 YFd1okreF0keckIomNp09Y/6L5KPSajqtU8VxMivLeADqVB3bptVFiGbajzJJjD6jI
 E9zAi0EuNiUKw==
Date: Sat, 08 Aug 2026 03:18:54 +0000
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH] target/riscv/tcg: sret in virtual user mode raises virtual
 instruction exception
Message-ID: <20260808031849.59726-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: 359855980948a443100c992382e2d1edafb5efdf
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249;
 envelope-from=christianslima@proton.me; helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Currently, when a `sret` is executed in virtual user mode, qemu
raise an `illegal instruction exception`, but in this case the correct
behavior is to raise a `virtual instruction exception` and the code
already contains a check to it, but it's not enough to catch. This
patch is useful to improve the correctness of the virtualization of
the risc v architecture.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3622

Signed-off-by: Christian S. Lima <christianslima@proton.me>
---
 target/riscv/tcg/op_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index ba3c7da375..429a6186a7 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -293,6 +293,10 @@ target_ulong helper_sret(CPURISCVState *env)
     const privilege_mode_t src_priv =3D env->priv;
     const bool src_virt =3D env->virt_enabled;
=20
+    if ((env->virt_enabled && env->priv < PRV_S) || (env->virt_enabled && =
get_field(env->hstatus, HSTATUS_VTSR))) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETP=
C());
+    }
+
     if (!(env->priv >=3D PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
@@ -308,10 +312,6 @@ target_ulong helper_sret(CPURISCVState *env)
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
=20
-    if (env->virt_enabled && get_field(env->hstatus, HSTATUS_VTSR)) {
-        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETP=
C());
-    }
-
     mstatus =3D env->mstatus;
     prev_priv =3D get_field(mstatus, MSTATUS_SPP);
     mstatus =3D set_field(mstatus, MSTATUS_SIE,
--=20
2.53.0



