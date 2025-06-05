Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EDEC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN79N-0002me-Mj; Thu, 05 Jun 2025 05:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uN79K-0002mS-EX
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:44:38 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uN79H-0001jW-Fn
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:44:38 -0400
X-ASG-Debug-ID: 1749116660-086e2326981c040001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id CBxyUvbUTMPhyFEl (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 05 Jun 2025 17:44:20 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 5 Jun
 2025 17:44:20 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Thu, 5 Jun 2025
 17:44:20 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.lan (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 5 Jun
 2025 14:54:45 +0800
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <zhao1.liu@intel.com>
CC: <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>,
 EwanHai <ewanhai-oc@zhaoxin.com>
Subject: [PATCH v3 RESEND] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
Date: Thu, 5 Jun 2025 02:54:45 -0400
X-ASG-Orig-Subj: [PATCH v3 RESEND] target/i386/kvm: Refine VMX controls
 setting for backward compatibility
Message-ID: <20250605065445.30090-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 6/5/2025 5:44:18 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1749116660
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2924
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.142416
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: EwanHai <ewanhai-oc@zhaoxin.com>

Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
execution controls") implemented a workaround for hosts that have
specific CPUID features but do not support the corresponding VMX
controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.

In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
use KVM's settings, avoiding any modifications to this MSR.

However, this commit (4a910e1) didn't account for cases in older Linux
kernels(4.17~5.2) where `MSR_IA32_VMX_PROCBASED_CTLS2` is in
`kvm_feature_msrs`-obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
but not in `kvm_msr_list`-obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
on `kvm_msr_list` alone, even though KVM does maintain the value of
this MSR.

This patch supplements the above logic, ensuring that
`has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
lists, thus maintaining compatibility with older kernels.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
---
Changes in v3:
- Use a more precise version range in the comment, specifically "4.17~5.2"
instead of "<5.3".

Changes in v2:
- Adjusted some punctuation in the commit message as per suggestions.
- Added comments to the newly added code to indicate that it is a compatibi=
lity fix.

v1 link:
https://lore.kernel.org/all/20230925071453.14908-1-ewanhai-oc@zhaoxin.com/

v2 link:
https://lore.kernel.org/all/20231127034326.257596-1-ewanhai-oc@zhaoxin.com/

---
 target/i386/kvm/kvm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a6bc089d02..4ff9b5995c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2466,6 +2466,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
 static int kvm_get_supported_feature_msrs(KVMState *s)
 {
     int ret =3D 0;
+    int i;
=20
     if (kvm_feature_msrs !=3D NULL) {
         return 0;
@@ -2500,6 +2501,20 @@ static int kvm_get_supported_feature_msrs(KVMState *=
s)
         return ret;
     }
=20
+   /*
+    * Compatibility fix:
+    * Older Linux kernels (4.17~5.2) report MSR_IA32_VMX_PROCBASED_CTLS2
+    * in KVM_GET_MSR_FEATURE_INDEX_LIST but not in KVM_GET_MSR_INDEX_LIST.
+    * This leads to an issue in older kernel versions where QEMU,
+    * through the KVM_GET_MSR_INDEX_LIST check, assumes the kernel
+    * doesn't maintain MSR_IA32_VMX_PROCBASED_CTLS2, resulting in
+    * incorrect settings by QEMU for this MSR.
+    */
+    for (i =3D 0; i < kvm_feature_msrs->nmsrs; i++) {
+        if (kvm_feature_msrs->indices[i] =3D=3D MSR_IA32_VMX_PROCBASED_CTL=
S2) {
+            has_msr_vmx_procbased_ctls2 =3D true;
+        }
+    }
     return 0;
 }
=20
--=20
2.34.1


