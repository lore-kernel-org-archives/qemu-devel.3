Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC6AC44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifjp-0001Ve-A5; Sat, 11 Jul 2026 17:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjo-0001Uu-0c; Sat, 11 Jul 2026 17:59:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjm-0007sB-Ca; Sat, 11 Jul 2026 17:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=E+6M2++zhHXz9evVcOLfdVYmxUtwqBWe2V3SJ0PWycQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xhwBAErkMZM2ePz3YL/m5Jt3MGo46R94Vp2cnZb3t1pGZnkD8GIwAUPv/X+hWeP3z
 hAYvLrMi8jph7/B00x1ZxYge/nM/CUjSotETr9/ut5DAq78XHA3X1G+lKyD9cWtXkf
 WzDORCKI3JhV0XbzOskJGdV8gt9TmMhm6r5PtEe3ZS1we+/GNA2X27MZ1e6cRTYpFg
 B1P5gLeIT0ygqUGfNWsBPGy2gIkhxX1knQX99/eJ/fF7EqnJqr9bh/4xjexjYNIJoI
 5jYe5kgV4TihfVtPovBKoXl6lsr0PsO8o+3gNI08z79zyNnwAQuU6z89yJz6OyfIpc
 23vlUbZSlnJ8w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 181241C0A8E;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C38163EAF19;
 Sun, 12 Jul 2026 00:59:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3DCF9132E9; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 03/81] s390x/kvm: clamp stsi 3.2.2 size
Date: Sun, 12 Jul 2026 00:57:41 +0300
Message-ID: <20260711215904.3757-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

The stsi 3.2.2 page is being prepared by the kvm module and the size is
clamped by the kernel. As the memory is mapped in the guest, another
guest VCPU could race and overwrite the count and messing up the move
operation. For any out of bound count, fall back to the kernel buffer.

Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20260622092035.400959-1-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit a57e4612b61da20ddab196502c76b4dc05da1de8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 54d28e37d4d..6b6700f759c 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1791,6 +1791,15 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
     } else if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib))) {
         return;
     }
+
+    /*
+     * The memory was filled by the kernel but mapped into the guest.
+     * If something is fishy, do not touch the buffer.
+     */
+    if (sysib.count == 0 || sysib.count > ARRAY_SIZE(sysib.ext_names)) {
+        return;
+    }
+
     /* Shift the stack of Extended Names to prepare for our own data */
     memmove(&sysib.ext_names[1], &sysib.ext_names[0],
             sizeof(sysib.ext_names[0]) * (sysib.count - 1));
-- 
2.47.3


