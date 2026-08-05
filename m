Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF722C55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrXaT-0008QY-Jf; Wed, 05 Aug 2026 05:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrXaQ-0008Io-6Q
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:06:55 -0400
Received: from [115.124.30.113] (helo=out30-113.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrXaM-000817-GY
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 05:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785920800; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 bh=EaGp4W9RKlGFYKTpx8qq8KToNffaBaFnv14evpAAG4A=;
 b=nGznCX1vLVrM+lhSdfmUsIErthKxi0/RJXHbeKwqr1/iMXiZcaBwv3f/ww9QQJqdbB5gvT8iteqRwtgVSzeExTUY6Wk+pFye41xokEkpilHFo5sq9ATlYzIbDHTSOm+hx+olKqySuHe9g82yOXTrEyXnU56Vofo1f5bQdKo6lxQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X8QltRq_1785920794; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8QltRq_1785920794 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 05 Aug 2026 17:06:39 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com, viktor.prutyanov@phystech.edu,
 zhengrong_li@linux.alibaba.com
Subject: [PATCH v2 3/3] elf2dmp: fill ContextBuffer with faulting CPU context
Date: Wed, 05 Aug 2026 17:05:58 +0800
Message-ID: <178592075881.15274.12721897603002325817@linux.alibaba.com>
In-Reply-To: <178592075881.15274.7510279315190894277@linux.alibaba.com>
References: <178592075881.15274.7510279315190894277@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.113 (deferred)
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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

When is_crash_occurred_cpu is set in QEMUCPUState, copy that CPU's
context into WinDumpHeader64 ContextBuffer so WinDbg opens on the
faulting CPU instead of CPU 0.

Also extract KiBugCheckData from the guest kernel to populate
BugcheckCode and BugcheckParameters in the dump header.

Changes since v1:
  - Add size-based field detection in init_states() for forward compatibility
  - Use has_is_crash_occurred_cpu flag instead of version check
  - Set header context before best-effort guest memory operations to avoid
    losing faulting CPU context on partial dump failures
  - Use LIVE_SYSTEM_DUMP when BugcheckCode is zero
  - Use PRIx32 for BugcheckCode format specifier
  - Use linux.alibaba.com identity

Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
---
 contrib/elf2dmp/kdbg.h     |  9 +++++++
 contrib/elf2dmp/main.c     | 50 ++++++++++++++++++++++++++++++++++++--
 contrib/elf2dmp/qemu_elf.c | 20 +++++++++------
 contrib/elf2dmp/qemu_elf.h |  1 +
 4 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/contrib/elf2dmp/kdbg.h b/contrib/elf2dmp/kdbg.h
index 002e3d0cd5..15e4fb1140 100644
--- a/contrib/elf2dmp/kdbg.h
+++ b/contrib/elf2dmp/kdbg.h
@@ -195,4 +195,13 @@ typedef struct KDDEBUGGER_DATA64 {
     uint16_t OffsetPrcbContext;
 } KDDEBUGGER_DATA64;
=20
+typedef struct KIBUGCHECK_INFO {
+    uint32_t BugcheckCode;
+    uint32_t unused0;
+    uint64_t BugcheckParameter1;
+    uint64_t BugcheckParameter2;
+    uint64_t BugcheckParameter3;
+    uint64_t BugcheckParameter4;
+} KIBUGCHECK_INFO;
+
 #endif /* KDBG_H */
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index a62abadcc0..59ffc0f2e8 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -338,11 +338,26 @@ static bool fill_header(WinDumpHeader64 *hdr, struct pa=
_space *ps,
  * A dump may still contain valuable information even if it lacks contexts of
  * some CPUs due to dump corruption or a failure before starting CPUs.
  */
-static void fill_context(KDDEBUGGER_DATA64 *kdbg,
+static void fill_context(WinDumpHeader64 *hdr, KDDEBUGGER_DATA64 *kdbg,
                          struct va_space *vs, QEMU_Elf *qe)
 {
     int i;
+    int fault_cpu =3D -1;
=20
+    /* First pass: identify faulting CPU and set header context early */
+    for (i =3D 0; i < qe->state_nr; i++) {
+        QEMUCPUState *s =3D qe->state[i];
+        if (qe->has_is_crash_occurred_cpu && s->is_crash_occurred_cpu) {
+            WinContext64 ctx;
+            win_context_init_from_qemu_cpu_state(&ctx, s);
+            memcpy(hdr->ContextBuffer, &ctx, sizeof(ctx));
+            fault_cpu =3D i;
+            printf("Faulting CPU identified: #%d\n", i);
+            break;
+        }
+    }
+
+    /* Second pass: fill context for all CPUs (best-effort) */
     for (i =3D 0; i < qe->state_nr; i++) {
         uint64_t Prcb;
         uint64_t Context;
@@ -512,6 +527,7 @@ int main(int argc, char *argv[])
     uint64_t KdVersionBlock;
     bool kernel_found =3D false;
     OMFSignatureRSDS rsds;
+    uint64_t KiBugCheckData;
=20
     if (argc !=3D 3) {
         eprintf("usage:\n\t%s elf_file dmp_file\n", argv[0]);
@@ -611,7 +627,37 @@ int main(int argc, char *argv[])
         goto out_kdbg;
     }
=20
-    fill_context(kdbg, &vs, &qemu_elf);
+    if (!SYM_RESOLVE(KernBase, &pdb, KiBugCheckData)) {
+        eprintf("Failed to get KiBugCheckData.\n");
+    } else {
+        KIBUGCHECK_INFO data =3D { 0 };
+        if (va_space_rw(&vs, KiBugCheckData, &data, sizeof(data), 0)) {
+            header.BugcheckCode =3D data.BugcheckCode;
+            header.BugcheckParameter1 =3D data.BugcheckParameter1;
+            header.BugcheckParameter2 =3D data.BugcheckParameter2;
+            header.BugcheckParameter3 =3D data.BugcheckParameter3;
+            header.BugcheckParameter4 =3D data.BugcheckParameter4;
+
+            /*
+             * If BugcheckCode wasn't saved, we consider guest OS as alive.
+             */
+            if (!header.BugcheckCode) {
+                header.BugcheckCode =3D LIVE_SYSTEM_DUMP;
+            }
+
+            printf("KiBugCheckData: 0x%016" PRIx64
+                   ", BugcheckCode: 0x%08" PRIx32 ", Args:"
+                   " 0x%016" PRIx64 " 0x%016" PRIx64
+                   " 0x%016" PRIx64 " 0x%016" PRIx64 "\n",
+                    KiBugCheckData, header.BugcheckCode,
+                    data.BugcheckParameter1, data.BugcheckParameter2,
+                    data.BugcheckParameter3, data.BugcheckParameter4);
+        } else {
+            eprintf("Failed to va_space_rw KiBugCheckData.\n");
+        }
+    }
+
+    fill_context(&header, kdbg, &vs, &qemu_elf);
=20
     if (!write_dump(&ps, &header, argv[2])) {
         eprintf("Failed to save dump\n");
diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index c9bad6e82c..8eb2654356 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -71,7 +71,8 @@ static bool init_states(QEMU_Elf *qe)
         return false;
     }
=20
-    qe->has_kernel_gs_base =3D 1;
+    qe->has_kernel_gs_base =3D 0;
+    qe->has_is_crash_occurred_cpu =3D 0;
     offset =3D phdr[0].p_offset;
     states =3D g_ptr_array_new();
=20
@@ -103,14 +104,19 @@ static bool init_states(QEMU_Elf *qe)
             nhdr->n_descsz >=3D offsetof(QEMUCPUState, kernel_gs_base)) {
             state_size =3D MIN(state->size, nhdr->n_descsz);
=20
-            if (state_size < sizeof(*state)) {
+            if (state_size >=3D offsetof(QEMUCPUState, kernel_gs_base) +
+                              sizeof(state->kernel_gs_base)) {
+                qe->has_kernel_gs_base =3D 1;
+            }
+
+            if (state_size >=3D offsetof(QEMUCPUState, is_crash_occurred_cpu=
) +
+                              sizeof(state->is_crash_occurred_cpu)) {
+                qe->has_is_crash_occurred_cpu =3D 1;
+            }
+
+            if (state_size !=3D sizeof(*state)) {
                 eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
                         states->len, state_size);
-                /*
-                 * We assume either every QEMU CPU state has KERNEL_GS_BASE =
or
-                 * no one has.
-                 */
-                qe->has_kernel_gs_base =3D 0;
             }
             g_ptr_array_add(states, state);
         }
diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index 3b28332e67..120de4a2f4 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -42,6 +42,7 @@ typedef struct QEMU_Elf {
     QEMUCPUState **state;
     size_t state_nr;
     int has_kernel_gs_base;
+    int has_is_crash_occurred_cpu;
 } QEMU_Elf;
=20
 bool QEMU_Elf_init(QEMU_Elf *qe, const char *filename);
--=20
2.43.0


