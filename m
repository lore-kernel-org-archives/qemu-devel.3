Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04509C44507
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilcL-0001ap-8I; Sun, 12 Jul 2026 00:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcI-0001ZR-Au; Sun, 12 Jul 2026 00:16:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcG-0006EK-Pc; Sun, 12 Jul 2026 00:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=GZZXjdQ7qK8evYR70ND7UaRLPa6dfHqrQe3CEWX6Glk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RHexoCaLfrdkNhGbhp/a9rUbLhay1fzgfWxfYYbZUjYPngsDdyPmO/7MQYcEjaZsg
 LDn6+9C66OF6NZODscGn/61l366Tv7AN27p27wyPv22mKrBUWueukmBY5QPf811owM
 LF7UDy+uFTaNt0/Rw6nYHTMmkdrYIjmg1hWVzDirx8+Lnko8wVOTXzLhZsiUExwmBE
 TKE+s5qzedzbyA+5O/F7Ru3gu5vs/LTuB9QqTLkW+OiocB4M9UopAd6OA/Gsi8fRkK
 YilOOioQqsXL6Tof8N1bRJ53zgQPsSmQ9P7blsh87AB1lDBB44pjN55PhO12BE+zdx
 HpoV3xw7dWG0g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9CEAB1C0BDD;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CC7B03EB93D;
 Sun, 12 Jul 2026 07:16:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 19B5D133BD; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 02/75] s390x/kvm: clamp stsi 3.2.2 size
Date: Sun, 12 Jul 2026 07:14:20 +0300
Message-ID: <20260712041539.108341-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
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
index 4d56e653ddf..81b8282939c 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1792,6 +1792,15 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
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


