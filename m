Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30112EF586B
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUau-0000KX-Np; Sun, 15 Feb 2026 00:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUao-0000Hd-9H
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:51 -0500
Received: from p-west2-cluster2-host2-snip4-10.eps.apple.com ([57.103.68.203]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUam-0004rM-IC
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:50 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 65B131800190; Sun, 15 Feb 2026 05:22:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132967; x=1773724967;
 bh=tOIg27vUU88mwrgezr591bqoq+9r1MOdy71woXavApE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=gJTsQ55M1l+aj8n3//qPrwomS7V21x+k7hD5OupiZjgL8qm8RkvWs4lDOgos0WyfyXhnJ/uCOcVPONVnwt7MIwSW78YPziNCpGsomR7XxbnClTyJi2Fs2RSSOj3GBk8nDBGZWy/mutyoNbg6jk3RYh0yMP1I+qebQySMojju7lOYcBmjLm/+hK0vxp6R8M+0/0n/dn4p35yukYG992aVZOrwBo1Ot8hZlu7NKxVOCO7vLX7TABPzjsKHMCZK10r04Bbdvl8s/ndlM2vt3EH8XWIxKVTxDsWNwc21hlBy4DZFWzNFAPKokWcLry9p3hrTtxIjo5E4I71jrv+jm34OxA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 E8C501800094; Sun, 15 Feb 2026 05:22:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 04/14] target/i386: emulate,
 hvf: move x86_mmu to common code
Date: Sun, 15 Feb 2026 06:22:15 +0100
Message-ID: <20260215052225.22513-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tMoW4fO6zFhPXsQ3F-TVpJQMXCZASCm8
X-Proofpoint-ORIG-GUID: tMoW4fO6zFhPXsQ3F-TVpJQMXCZASCm8
X-Authority-Info-Out: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=69915827
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=NAek0MM3JjVz2OpMgrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX36lvfWghgENo
 DkezWIsnEIMAWFcFDAQ6xnVxud/+H7HXfYHUEJbzJneJY0hQRNRN2WYk7shA6ipFSaIixujlSqm
 2J8sEk3pu6UazJ68uT5fgqTY8Sqpicb84lbbAXZq/j27meQooMNqr9Slk7+88TSpMzmpDJHhcKc
 XTzpE9SNkwPyruelpYNAkgUXgopZheKGCzkYT+3oxgNP+69n6/Xc2p6IDFJYfGY1tzYmNWDGoKX
 2chpRfPM7RsoKPQbZFIzIuZ+jr1SZcS7KQa8AJlyxK40+N03wfJo03/HzziHE6+Cf4b3KvPBhwu
 BqMnAIfYI+KUWMQAsAYbgX/J1NoNN4JB2p9Tm/FvTepVBSkenFPFc9eBBorpKs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 clxscore=1030 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABpvwjwoCnagoaj3z6vZgzbZ+2YbYjyromENN5RqOf9/pLNqbtErUmfbFJkGJn/853pTvpT3PpnMoVWewgMVDUSpUE90O5PsFaxcXa3L4ImBLxXIdVHf4dvW9XT9B/0QZT+gcWh5zjeKko5YN8aEg7U7Svjsl2pfIJQXbEegJJZ71rM8wgoSLL2HbxXmKBAe9N0hQxiwd8OIZis+MQxvrBqJ4QtIjTINu6umIGkmuzEAkcx/1y7Ku7y9gt6kuj+KJ7nfjZD0TGLXLYN1wBC7Oke4JIxdK006bZjx1Trq0GJ4cQC85Psw3Hm6dVib/3hfPz9FC3jYznPyrdCdAA9AJWGmWWNsmg4ph9QYLvhybd641E4IdN24NN6elDHf4z5Vjam45wz5fOiankW7H1Wc4up7j2EZ52pX4YfUcevGI9cgMDPqUnGEOhik+QCOEM+VVGXR2lHXexMbgfnOxJQKiE9S+gvU1sSQP6Tnjm+MN4im0w3N4WOkhmrTdzrcEDBd+/deEIJTdcauvUIKtQZge3fyHg2o/xxgqDQaX5lcuOjm73o7lMePvCoWkuRbrrBam9VV5SJpQdqqjPvOXaq0cl25pNuP4Ot0pvu00eR/0ckQFpofF235I68InkaS/lFk+lwRUL5Zyxi0uxN5NrE7Ra3E/Xzk7aKBPDrTgi8Dk5mV4SKzKooPzazw9eY1+VBPeKXQecHhb76jwRIhgF8sddZLuiAiWYsiHNB+79lXt+A5Ac/l7DKNYKsadJQmWdv/XSH0Eix/mR0AuPeBKcRHfyWusYGjOY/mi8x3x7
Received-SPF: pass client-ip=57.103.68.203;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/emulate/meson.build        |  1 +
 target/i386/{hvf => emulate}/x86_mmu.c | 14 +++++++++-----
 target/i386/{hvf => emulate}/x86_mmu.h |  0
 target/i386/hvf/hvf.c                  | 10 +++++++++-
 target/i386/hvf/meson.build            |  1 -
 target/i386/hvf/x86.c                  |  2 +-
 target/i386/hvf/x86_task.c             |  2 +-
 7 files changed, 21 insertions(+), 9 deletions(-)
 rename target/i386/{hvf => emulate}/x86_mmu.c (95%)
 rename target/i386/{hvf => emulate}/x86_mmu.h (100%)

diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index b6dafb6a5b..dd047c424a 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -2,6 +2,7 @@ emulator_files = files(
   'x86_decode.c',
   'x86_emu.c',
   'x86_flags.c',
+  'x86_mmu.c'
 )
 
 i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/emulate/x86_mmu.c
similarity index 95%
rename from target/i386/hvf/x86_mmu.c
rename to target/i386/emulate/x86_mmu.c
index fe44d2edf4..b82a55a3da 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -19,10 +19,10 @@
 #include "qemu/osdep.h"
 #include "panic.h"
 #include "cpu.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
 #include "emulate/x86.h"
-#include "x86_mmu.h"
-#include "vmcs.h"
-#include "vmx.h"
+#include "emulate/x86_mmu.h"
 
 #define pte_present(pte) (pte & PT_PRESENT)
 #define pte_write_access(pte) (pte & PT_WRITE)
@@ -99,6 +99,8 @@ static bool get_pt_entry(CPUState *cpu, struct gpt_translation *pt,
 static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
                           int level, int *largeness, bool pae)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     uint64_t pte = pt->pte[level];
 
     if (pt->write_access) {
@@ -127,7 +129,7 @@ static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
         pt->err_code |= MMU_PAGE_PT;
     }
 
-    uint32_t cr0 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    uint32_t cr0 = env->cr[0];
     /* check protection */
     if (cr0 & CR0_WP_MASK) {
         if (pt->write_access && !pte_write_access(pte)) {
@@ -179,9 +181,11 @@ static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae,
 static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
                      struct gpt_translation *pt, bool pae)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     int top_level, level;
     int largeness = 0;
-    target_ulong cr3 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
+    target_ulong cr3 = env->cr[3];
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
     
     memset(pt, 0, sizeof(*pt));
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/emulate/x86_mmu.h
similarity index 100%
rename from target/i386/hvf/x86_mmu.h
rename to target/i386/emulate/x86_mmu.h
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index ce54020f00..0b3674ad33 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -62,7 +62,7 @@
 #include "emulate/x86.h"
 #include "x86_descr.h"
 #include "emulate/x86_flags.h"
-#include "x86_mmu.h"
+#include "emulate/x86_mmu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "x86_task.h"
@@ -254,11 +254,19 @@ static void hvf_read_segment_descriptor(CPUState *s, struct x86_segment_descript
 
 static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
     vmx_read_mem(cpu, data, gva, bytes);
 }
 
 static void hvf_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
     vmx_write_mem(cpu, gva, data, bytes);
 }
 
diff --git a/target/i386/hvf/meson.build b/target/i386/hvf/meson.build
index 519d190f0e..22bf886978 100644
--- a/target/i386/hvf/meson.build
+++ b/target/i386/hvf/meson.build
@@ -3,7 +3,6 @@ i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'x86.c',
   'x86_cpuid.c',
   'x86_descr.c',
-  'x86_mmu.c',
   'x86_task.c',
   'x86hvf.c',
   'hvf-cpu.c',
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 5c75ec9a00..2fa210ff60 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -23,7 +23,7 @@
 #include "emulate/x86_emu.h"
 #include "vmcs.h"
 #include "vmx.h"
-#include "x86_mmu.h"
+#include "emulate/x86_mmu.h"
 #include "x86_descr.h"
 
 /* static uint32_t x86_segment_access_rights(struct x86_segment_descriptor *var)
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index bdf8b51ae6..b1e541a642 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -16,7 +16,7 @@
 #include "vmx.h"
 #include "emulate/x86.h"
 #include "x86_descr.h"
-#include "x86_mmu.h"
+#include "emulate/x86_mmu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "x86_task.h"
-- 
2.50.1 (Apple Git-155)


