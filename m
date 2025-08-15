Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8CFCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 17:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umxn3-00079T-Ib; Fri, 15 Aug 2025 13:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umxn1-000795-BN
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:00:27 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umxmv-00017T-QY
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:00:27 -0400
DKIM-Signature: a=rsa-sha256; bh=zDPqldTnfSbcDiXc33QPJwBpwqkxMBuyVd45rzAlBZg=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1755277216; v=1;
 b=RIfXYZ/EFF2liIy2HZ8bpebsQcY4pItEia2mz0sNNSXXwMt2czkQTqhteBgAFOTksrx0tx+3
 1xw/EpdD4h9mGvuk8+B+1WVAuJ8AykriN1NOOdjshuuyD9FB8FoavrZclXx5wAL7gdUvY+CKwfP
 WX6299ClXBA9JROB/C9Fsz/+EFvx8J9ANgmJCaBwvwbwN1KkLEefQpldHJD5tmi/oqW3GrEOzbJ
 ZUZQVR9CsAQV93oSj7cwWny28EWfTg26YRD9ML0iNaBqfUj6Fnad//zGsrUahuD0ZtP+UVABJ3j
 mgRETV3GRHnAe77+PWXdxRYs4q85QOtCtondk6jSrtsuA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id CF50522F01;
 Fri, 15 Aug 2025 17:00:16 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Fri, 15 Aug 2025 16:53:09 +0000
Subject: [PATCH qemu v4 1/1] Default disable ignore guest PAT quirk
Message-ID: <175527721636.15451.4393515241478547957-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <175527721636.15451.4393515241478547957-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~myrslint <myrskylintu@proton.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: myrslint <qemu.haziness801@passinbox.com>

Most Intel CPUs in current use have self-snoop. The few added lines of
code also check for availability of the quirk disablement option so if
some CPU does not have this feature no change of behavior will occur.

Signed-off-by: Myrsky Lintu <qemu.haziness801@passinbox.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2943
---
 target/i386/kvm/kvm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8..1102866a89 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -16,6 +16,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include <asm-x86/kvm.h>
 #include <math.h>
 #include <sys/ioctl.h>
 #include <sys/utsname.h>
@@ -3367,6 +3368,21 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
=20
+    /* rationale: most x86 cpus in current use have self-snoop so honoring
+     * guest pat is preferrable. as well, the bochs video driver bug which
+     * motivated making this a default enabled quirk in kvm was fixed long a=
go
+     * */
+    /* check if disabling this quirk is feasible and allowed */
+    ret =3D kvm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
+    if (ret & KVM_X86_QUIRK_IGNORE_GUEST_PAT) {
+        ret =3D kvm_vm_enable_cap(s, KVM_CAP_DISABLE_QUIRKS2, 0, \
+                                KVM_X86_QUIRK_IGNORE_GUEST_PAT);
+        if (ret < 0) {
+            error_report("KVM_X86_QUIRK_IGNORE_GUEST_PAT available and "
+                         "modifiable but we failed to disable it\n");
+        }
+    }
+
     return 0;
 }
=20
--=20
2.49.1

