Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7D8C54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRLf-0004h3-Dv; Fri, 06 Sep 2024 01:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRLC-0003x6-UO; Fri, 06 Sep 2024 01:17:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRLA-0007pm-Lx; Fri, 06 Sep 2024 01:17:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91FAD8C11B;
 Fri,  6 Sep 2024 08:15:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4365A133361;
 Fri,  6 Sep 2024 08:16:34 +0300 (MSK)
Received: (nullmailer pid 10405 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 07/40] target/i386: do not crash if microvm guest uses
 SGX CPUID leaves
Date: Fri,  6 Sep 2024 08:15:55 +0300
Message-Id: <20240906051633.10288-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

sgx_epc_get_section assumes a PC platform is in use:

bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
{
    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());

However, sgx_epc_get_section is called by CPUID regardless of whether
SGX state has been initialized or which platform is in use.  Check
whether the machine has the right QOM class and if not behave as if
there are no EPC sections.

Fixes: 1dec2e1f19f ("i386: Update SGX CPUID info according to hardware/KVM/user input", 2021-09-30)
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2142
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 13be929aff804581b21e69087a9caf3698fd5c3c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 09d9c7c73d..f64987c6dd 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -268,10 +268,12 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
 
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
-    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
+    PCMachineState *pcms =
+        (PCMachineState *)object_dynamic_cast(qdev_get_machine(),
+                                              TYPE_PC_MACHINE);
     SGXEPCDevice *epc;
 
-    if (pcms->sgx_epc.size == 0 || pcms->sgx_epc.nr_sections <= section_nr) {
+    if (!pcms || pcms->sgx_epc.size == 0 || pcms->sgx_epc.nr_sections <= section_nr) {
         return true;
     }
 
-- 
2.39.2


