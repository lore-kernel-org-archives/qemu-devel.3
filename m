Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9611CD5C0FC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f8y-0004Ey-Iq; Sat, 09 Nov 2024 01:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8e-0003kN-Cp; Sat, 09 Nov 2024 01:40:09 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8b-000255-T7; Sat, 09 Nov 2024 01:40:04 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FD3EA12F3;
 Sat,  9 Nov 2024 09:38:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 99B7E167DD7;
 Sat,  9 Nov 2024 09:39:04 +0300 (MSK)
Received: (nullmailer pid 3272528 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tom Dohrmann <erbse.13@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 12/33] accel/kvm: check for KVM_CAP_READONLY_MEM on VM
Date: Sat,  9 Nov 2024 09:38:38 +0300
Message-Id: <20241109063903.3272404-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Tom Dohrmann <erbse.13@gmx.de>

KVM_CAP_READONLY_MEM used to be a global capability, but with the
introduction of AMD SEV-SNP confidential VMs, this extension is not
always available on all VM types [1,2].

Query the extension on the VM level instead of on the KVM level.

[1] https://patchwork.kernel.org/project/kvm/patch/20240809190319.1710470-2-seanjc@google.com/
[2] https://patchwork.kernel.org/project/kvm/patch/20240902144219.3716974-1-erbse.13@gmx.de/

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
Link: https://lore.kernel.org/r/20240903062953.3926498-1-erbse.13@gmx.de
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 64e0e63ea16aa0122dc0c41a0679da0ae4616208)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 370ecab785..d8e831bcf9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2578,7 +2578,7 @@ static int kvm_init(MachineState *ms)
     }
 
     kvm_readonly_mem_allowed =
-        (kvm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
+        (kvm_vm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
 
     kvm_eventfds_allowed =
         (kvm_check_extension(s, KVM_CAP_IOEVENTFD) > 0);
-- 
2.39.5


