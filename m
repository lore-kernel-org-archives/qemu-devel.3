Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDFFC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrweF-0000dH-Tk; Thu, 06 Aug 2026 07:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrweD-0000cc-PC
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:52:29 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrwe7-00083m-4P
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1786017129; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 bh=UqgHlXWWzFX4kz1w5/WkDBFGvm9Y+RSWkY9vjwcblnw=;
 b=axWXrUc34lWw4mNjsg9wp+7yJxAKvJ1r9ZnGK9NgUcJLteaHtANRL5v4562HzFqJSuwh7Tv9z/ew40FNSDYML2WYnyV+VwjxVtadQbPKgRqOewO1CoUXnlHQnbgS7GHt8/KVsYE/qweIQ62t3ZeBP+UHv/7B7S/mZ6NMDYp0Z+Q=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X8TvDSq_1786017123; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8TvDSq_1786017123 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 06 Aug 2026 19:52:08 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, philmd@qualcomm.com, pbonzini@redhat.com,
 viktor.prutyanov@phystech.edu, zhengrong_li@linux.alibaba.com
Subject: [PATCH v3 2/3] dump: add crash_occurred flag to QEMUCPUState
Date: Thu, 06 Aug 2026 19:51:34 +0800
Message-ID: <178601709478.48495.1330561530288193332@linux.alibaba.com>
In-Reply-To: <178601709477.48495.9850518471453430873@linux.alibaba.com>
References: <178601709477.48495.9850518471453430873@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

Add is_crash_occurred_cpu field to the local QEMUCPUState in
arch_dump.c so that dump-guest-memory can record which CPU
triggered the guest panic.

The new field is appended after kernel_gs_base, so older tools
safely ignore the extra bytes in newer dumps, and newer tools
detect its absence in older dumps by checking the 'size' field.

Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
---
 target/i386/arch_dump.c | 6 ++++++
 1 file changed, 6 insertions(+)

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


