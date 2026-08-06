Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC18C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrrU8-0005FX-DA; Thu, 06 Aug 2026 02:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrrU6-0005Ev-Ge
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 02:21:42 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrrU3-00008u-LM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 02:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785997287; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 bh=386a66FsBwzQIFv2juxm9COckIHSiZZFZ+5xqyObths=;
 b=Ur1jtcktZKrGaT+q14yoSYO1GMO5T4J3TU8YacFxWmMBQeWRp5ExNdwoElkNdxPoBKTu2vHFs3gYYM8cl/eyFu7D4UaA/Z73MSEeMqlEhgq1lyi7elL699GfuB3DCuPFBs47XrSmk5zPFpfp8C8iLifx/TPY94bs1L2IuYChhpg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X8T274Y_1785997281; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8T274Y_1785997281 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 06 Aug 2026 14:21:27 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com, philmd@qualcomm.com, pbonzini@redhat.com,
 viktor.prutyanov@phystech.edu, zhengrong_li@linux.alibaba.com
Subject: [PATCH v3 2/3] dump: add crash_occurred flag to QEMUCPUState
Date: Thu, 06 Aug 2026 14:20:59 +0800
Message-ID: <178599725914.10029.14279751262185488168@linux.alibaba.com>
In-Reply-To: <178599725914.10029.4441302124415593392@linux.alibaba.com>
References: <178599725914.10029.4441302124415593392@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
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
panic. Bump QEMUCPUSTATE_VERSION to 2.

The new field is appended after kernel_gs_base, so existing
tools that check the 'size' field can safely ignore it when
reading older dumps.

Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
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


