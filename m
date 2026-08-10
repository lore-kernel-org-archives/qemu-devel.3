Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC95C5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtLSe-0001ca-OD; Mon, 10 Aug 2026 04:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wtLRl-0001QI-6Y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:33:33 -0400
Received: from [115.124.28.51] (helo=out28-51.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wtLRh-0005C2-4t
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:33:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08302353|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.195864-0.0147222-0.789414;
 FP=3152376357097244031|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033045220102;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=8; RT=8; SR=0;
 TI=SMTPD_---.iiL7hML_1786350661; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iiL7hML_1786350661 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 10 Aug 2026 16:31:01 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanjing Zhou <zhouyanjing@hygon.cn>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 4/9] target/i386/kvm: Use AMD MCE status encoding for Hygon
Date: Mon, 10 Aug 2026 16:29:51 +0800
Message-ID: <20260810082956.1768042-5-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.51 (deferred)
Received-SPF: pass client-ip=115.124.28.51;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-51.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

QEMU's KVM memory-failure injection path builds synthetic MCI_STATUS
records for the guest CPU.  The status encoding is vendor-specific:
Intel-style records use bits such as MCI_STATUS_S and MCI_STATUS_AR for
action-required events, while the AMD path uses the AMD memory-failure
encoding.

Today QEMU selects the AMD status encoding only for AuthenticAMD guests.
Hygon guests should use the AMD status encoding as well, but currently
get Intel-style injected status bits, including MCI_STATUS_S and
MCI_STATUS_AR for action-required events, and a non-deferred
action-optional record.  That can prevent a guest OS running on the Hygon
CPU model from handling the injected MCE correctly.

Use the AMD injected-memory-failure MCE status encoding for Hygon guests
as well.  This does not depend on Hygon exposing CPUID 0x80000007.EBX
recovery features such as SUCCOR, and it does not advertise any new
recovery capability.  The change is limited to QEMU's synthetic KVM
memory-failure MCE status; it does not change CPUID, MCE bank state, or
migrated CPU state.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4272b6770c..aa32b74f10 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -707,7 +707,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
     uint64_t mcg_status = MCG_STATUS_MCIP | MCG_STATUS_RIPV;
     int flags = 0;
 
-    if (!IS_AMD_CPU(env)) {
+    if (!IS_AMD_CPU(env) && !IS_HYGON_CPU(env)) {
         status |= MCI_STATUS_S | MCI_STATUS_UC;
         if (code == BUS_MCEERR_AR) {
             status |= MCI_STATUS_AR | 0x134;
-- 
2.43.7


