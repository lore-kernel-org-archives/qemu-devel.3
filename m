Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308D2C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVP9-0004TM-IO; Wed, 22 Jul 2026 07:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong.lzr@alibaba-inc.com>)
 id 1wmMBc-00051n-RN
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:55:52 -0400
Received: from [140.205.0.204] (helo=out0-204.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong.lzr@alibaba-inc.com>)
 id 1wmMBX-0001zI-6y
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alibaba-inc.com; s=default;
 t=1784685281; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=+u2oer4DmXodby6+49ERUiXbSIEaxJzPbTIPwrrlTKw=;
 b=s4KICt8y0q1uE8x56zMtYUgKX+q0OqlUNv89jH9EHi0kdx/ZhvlT89xAXUid7OCrcmHiUzglXkyJCaHNZHh4FywOBE8mqEp8kJDMfqYVqVdhPboYKIqaRiwTQhqRSdoPKqhH9TgjiHGjbkc58SuuvlWoeyaQ+7cYOhp7d6dQlJA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R441e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033040074035;
 MF=zhengrong.lzr@alibaba-inc.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---.iRHeHY5_1784684963; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong.lzr@alibaba-inc.com
 fp:SMTPD_---.iRHeHY5_1784684963 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 22 Jul 2026 09:49:28 +0800
From: "=?UTF-8?B?5p2O5bOl5bWYKOadkeWPlCk=?=" <zhengrong.lzr@alibaba-inc.com>
To: qemu-devel@nongnu.org
Cc: <pbonzini@redhat.com>, <viktor.prutyanov@phystech.edu>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <zhao1.liu@intel.com>,
 "=?UTF-8?B?5p2O5bOl5bWYKOadkeWPlCk=?=" <zhengrong.lzr@alibaba-inc.com>
Subject: [PATCH 2/3] dump: add crash_occurred flag to QEMUCPUState
Date: Wed, 22 Jul 2026 09:48:38 +0800
Message-ID: <20260722014840.36671-2-zhengrong.lzr@alibaba-inc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722014840.36671-1-zhengrong.lzr@alibaba-inc.com>
References: <20260722014840.36671-1-zhengrong.lzr@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 140.205.0.204 (deferred)
Received-SPF: pass client-ip=140.205.0.204;
 envelope-from=zhengrong.lzr@alibaba-inc.com; helo=out0-204.mail.aliyun.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Jul 2026 07:46:12 -0400
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
 target/i386/arch_dump.c    | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

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
 
 int is_system(QEMUCPUState *s);
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 16e47c4747..f1c31984c5 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -237,7 +237,7 @@ int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
  * please count up QEMUCPUSTATE_VERSION if you have changed definition of
  * QEMUCPUState, and modify the tools using this information accordingly.
  */
-#define QEMUCPUSTATE_VERSION (1)
+#define QEMUCPUSTATE_VERSION (2)
 
 struct QEMUCPUSegment {
     uint32_t selector;
@@ -264,6 +264,8 @@ struct QEMUCPUState {
      * by checking 'size' field.
      */
     uint64_t kernel_gs_base;
+    uint8_t  is_crash_occurred_cpu;
+    uint8_t  pad[7];
 };
 
 typedef struct QEMUCPUState QEMUCPUState;
@@ -279,6 +281,7 @@ static void copy_segment(QEMUCPUSegment *d, SegmentCache *s)
 
 static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
 {
+    CPUState *cs = env_cpu(env);
     memset(s, 0, sizeof(QEMUCPUState));
 
     s->version = QEMUCPUSTATE_VERSION;
@@ -324,6 +327,9 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
 
 #ifdef TARGET_X86_64
     s->kernel_gs_base = env->kernelgsbase;
+    if (cs->crash_occurred) {
+        s->is_crash_occurred_cpu = 1;
+    }
 #endif
 }
 
-- 
2.43.0


