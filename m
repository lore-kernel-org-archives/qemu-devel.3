Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99501C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgio0-0001Bj-Ht; Mon, 06 Jul 2026 08:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQU-0002ro-C8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:30 -0400
Received: from [115.124.28.5] (helo=out28-5.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQR-0005Rr-6P
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07472231|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00900542-0.00101272-0.989982;
 FP=2852828158138205695|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033045220102;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.iEEStqt_1783317365; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iEEStqt_1783317365 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 06 Jul 2026 13:56:05 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 4/9] target/i386/kvm: Use AMD MCE status encoding for Hygon
Date: Mon,  6 Jul 2026 13:55:25 +0800
Message-ID: <20260706055530.1752094-5-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.5 (deferred)
Received-SPF: pass client-ip=115.124.28.5;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-5.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2026 08:51:19 -0400
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

From: Tina Zhang <zhang_wei@open-hieco.net>

QEMU's KVM memory-failure injection path builds synthetic MCI_STATUS
records for the guest CPU.  The status encoding is vendor-specific:
Intel-style records use bits such as MCI_STATUS_S and MCI_STATUS_AR for
action-required events, while the AMD path uses the AMD memory-failure
encoding.

Today QEMU selects the AMD status encoding only for AuthenticAMD guests.
Hygon guests therefore get Intel-style injected status bits, including
MCI_STATUS_S and MCI_STATUS_AR for action-required events, and a
non-deferred action-optional record.

Use the AMD injected-memory-failure MCE status encoding for Hygon guests
as well.  This does not depend on Hygon exposing CPUID 0x80000007.EBX
recovery features such as SUCCOR, and it does not advertise any new
recovery capability.  The change is limited to QEMU's synthetic KVM
memory-failure MCE status; it does not change CPUID, MCE bank state, or
migrated CPU state.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/kvm/kvm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 64cc421abe..8e2bfbbe1d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -698,6 +698,15 @@ static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
     return kvm_ioctl(s, KVM_X86_GET_MCE_CAP_SUPPORTED, mce_cap);
 }
 
+/*
+ * Use AMD-style MCE status records for QEMU-injected memory failures on
+ * AMD and Hygon CPUs.
+ */
+static bool kvm_mce_inject_uses_amd_status(const CPUX86State *env)
+{
+    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
+}
+
 static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
 {
     CPUState *cs = CPU(cpu);
@@ -707,7 +716,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
     uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
     int flags = 0;
 
-    if (!IS_AMD_CPU(env)) {
+    if (!kvm_mce_inject_uses_amd_status(env)) {
         status |= MCI_STATUS_S | MCI_STATUS_UC;
         if (code == BUS_MCEERR_AR) {
             status |= MCI_STATUS_AR | 0x134;
-- 
2.43.7


