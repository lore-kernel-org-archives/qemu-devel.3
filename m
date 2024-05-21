Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3A4C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 16:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9SHb-00061R-JL; Tue, 21 May 2024 12:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1s9SHX-000610-Fo
 for qemu-devel@nongnu.org; Tue, 21 May 2024 12:24:07 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1s9SHU-0005kU-Aq
 for qemu-devel@nongnu.org; Tue, 21 May 2024 12:24:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9F30960D98;
 Tue, 21 May 2024 19:23:56 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:b738::1:8])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lNMBDR0IZqM0-iRaZq5ub; Tue, 21 May 2024 19:23:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1716308636;
 bh=8dmXIG071P4jqpkop1qyTQRp9nX2PPjwWXGr8cvbSk8=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=0q9uMo3VXP17D04KK+iYnSwsCzOlG1aqtMf9KZL/+PZ9ohqaG94DjjMz4lJA7/i63
 XoTxC8YWT2F4N+be1LVD8ezbGtol+klSwmUNUqYazdKzO9IjjzIIqHQtAjv/u/6GVY
 rRekeGbrmg0KbK6r9aBlEIoPy9ytdV6bghghOBSU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru,
	babu.moger@amd.com,
	pbonzini@redhat.com
Subject: [PATCH] target/i386: Add x-amd-ccx-size property
Date: Tue, 21 May 2024 19:23:47 +0300
Message-Id: <20240521162347.9149-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to AMD64 Architecture Programmer's Manual volume 3, information
about the cache topology is exposed by 0x8000001D CPUID leaf, and
0x8000001E CPUID leaf is exposing information about the topology of the
entire processor. For example, CPUID on the real EPYC Milan 7713 shows:

* 0x8000001D_EAX_3 = 0x0003c163
* 0x8000001E_ECX   = 0x00000001

This means that 16 logical processors share one L3 cache, which gives
8 CCXs per processor, but only 1 node per processor. Thus, on real
processor models, nodes and CCX are different things. What is more, Zen2,
for example, has 2 CCX per die. It is also worth considering that for some
desktop processors the number of cores is not a power of two, so the CCX
size may vary within single family. Therefore, I suggest making it possible
to set the CCX size as a property of the CPU. In this case, one will be
able to set the CCX size if needed, but for others the default value will
remain.

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 target/i386/cpu.c | 19 +++++++++++++------
 target/i386/cpu.h |  3 +++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cfe7c92d6b..bbf8fb137c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -328,10 +328,10 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
 /* Encode cache info for CPUID[8000001D] */
 static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
                                        X86CPUTopoInfo *topo_info,
+                                       uint32_t l3_threads,
                                        uint32_t *eax, uint32_t *ebx,
                                        uint32_t *ecx, uint32_t *edx)
 {
-    uint32_t l3_threads;
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
@@ -340,7 +340,8 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
 
     /* L3 is shared among multiple cores */
     if (cache->level == 3) {
-        l3_threads = topo_info->cores_per_die * topo_info->threads_per_core;
+        l3_threads = (l3_threads ? l3_threads :
+                      topo_info->cores_per_die * topo_info->threads_per_core);
         *eax |= (l3_threads - 1) << 14;
     } else {
         *eax |= ((topo_info->threads_per_core - 1) << 14);
@@ -6757,19 +6758,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         switch (count) {
         case 0: /* L1 dcache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       &topo_info, cpu->amd_ccx_size,
+                                       eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       &topo_info, cpu->amd_ccx_size,
+                                       eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       &topo_info, cpu->amd_ccx_size,
+                                       eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       &topo_info, cpu->amd_ccx_size,
+                                       eax, ebx, ecx, edx);
             break;
         default: /* end of info */
             *eax = *ebx = *ecx = *edx = 0;
@@ -8105,6 +8110,8 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
+    DEFINE_PROP_UINT32("x-amd-ccx-size", X86CPU, amd_ccx_size, 0),
+
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ccccb62fc3..01104847a1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2036,6 +2036,9 @@ struct ArchCPU {
      */
     uint32_t guest_phys_bits;
 
+    /* Number of logical processors that shares L3 cache */
+    uint32_t amd_ccx_size;
+
     /* in order to simplify APIC support, we leave this pointer to the
        user */
     struct DeviceState *apic_state;
-- 
2.34.1


