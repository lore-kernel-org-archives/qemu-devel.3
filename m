Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5011C55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXaS-0008IG-2a; Wed, 05 Aug 2026 05:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrXaO-0008Dc-4m
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:06:52 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrXaJ-0007zx-7f
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785920794; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 bh=sygwba2kjAC5Ez7zrabINvDmdl0Q24z0iBwvz7PqhoI=;
 b=QAu048KZbswb/VVahFfTjxvxGgegr8uPAUNGQlc3+0oGM4zmZywKLr7U3XESZZ2/cI0I+YpIy+61ongzwOp1AU3dK1/0W5BmVUK4L3dnfqRwmpUtUNEZ/7DV5qwPpT3WJBbDGuzD3oAH+Z/usHUoYdgEVDUTf2gD8mXirk7xyRY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X8Qnhnk_1785920788; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8Qnhnk_1785920788 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 05 Aug 2026 17:06:33 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com, viktor.prutyanov@phystech.edu,
 zhengrong_li@linux.alibaba.com
Subject: [PATCH v2 2/3] dump: add crash_occurred flag to QEMUCPUState
Date: Wed, 05 Aug 2026 17:05:58 +0800
Message-ID: <178592075881.15274.5708870107372539268@linux.alibaba.com>
In-Reply-To: <178592075881.15274.7510279315190894277@linux.alibaba.com>
References: <178592075881.15274.7510279315190894277@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Add is_crash_occurred_cpu field to QEMUCPUState so that
dump-guest-memory can record which CPU triggered the guest
panic.

The new field is appended after kernel_gs_base, so existing
tools that check the 'size' field can safely ignore it when
reading older dumps.

Changes since v1:
  - Revert QEMUCPUSTATE_VERSION bump (not needed, tools check size)
  - Move crash_occurred check outside #ifdef TARGET_X86_64 to fix
    -Werror=3Dunused-variable on i386 builds (reported by Akihiko Odaki)
  - Use linux.alibaba.com identity

Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
---
 contrib/elf2dmp/qemu_elf.h | 2 ++
 target/i386/arch_dump.c    | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index adc50238b4..3b28332e67 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -27,6 +27,8 @@ typedef struct QEMUCPUState {
     QEMUCPUSegment ldt, tr, gdt, idt;
     uint64_t cr[5];
     uint64_t kernel_gs_base;
+    uint8_t  is_crash_occurred_cpu;
+    uint8_t  pad[7];
 } QEMUCPUState;
=20
 int is_system(QEMUCPUState *s);
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 16e47c4747..8ce2c7e9bb 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -264,6 +264,8 @@ struct QEMUCPUState {
      * by checking 'size' field.
      */
     uint64_t kernel_gs_base;
+    uint8_t  is_crash_occurred_cpu;
+    uint8_t  pad[7];
 };
=20
 typedef struct QEMUCPUState QEMUCPUState;
@@ -279,6 +281,7 @@ static void copy_segment(QEMUCPUSegment *d, SegmentCache =
*s)
=20
 static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
 {
+    CPUState *cs =3D env_cpu(env);
     memset(s, 0, sizeof(QEMUCPUState));
=20
     s->version =3D QEMUCPUSTATE_VERSION;
@@ -325,6 +328,9 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX86Stat=
e *env)
 #ifdef TARGET_X86_64
     s->kernel_gs_base =3D env->kernelgsbase;
 #endif
+    if (cs->crash_occurred) {
+        s->is_crash_occurred_cpu =3D 1;
+    }
 }
=20
 static inline int cpu_write_qemu_note(WriteCoreDumpFunction f,
--=20
2.43.0


