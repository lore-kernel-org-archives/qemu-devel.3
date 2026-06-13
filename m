Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A5ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUfH-0001Wz-Ds; Sat, 13 Jun 2026 16:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfF-0001QQ-T1; Sat, 13 Jun 2026 16:09:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfE-0002k0-1S; Sat, 13 Jun 2026 16:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381070; bh=/yCG3jEExQpedxSgTR2/aw27BcSv2Xz3e8r7g1a46fI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wEIeufgZZsHODNGgA16tMmv9yppioxxAHLz7mh4g99X8fD9kzvpaxBeUrk2IWxjk4
 tcD6BHaMZYqPhjyur5W2baUOeCMdjQRR5FrZpwafyjGpkkR7tVcURv5sbpp3DSRRGl
 OEH229SIxJ2mpMxoYOHrnOmB7UgyeN/vcpL6F1Fboik6hVpMs2Y6J9AHM420WX8NQ/
 pbtX79J6JFGXxPmMMLfR3ouRoYYV3EYpeqni1CAaadijVL6uIDRqK5OWvXtXgVFUyi
 H1J7bW0wInpxts6RLHpt5M50e3UJ/jyZiLebyGiDpoLLMHI9Zo7GyXZSjM/DtKVIm9
 L/L4a/oWIG9zg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3DA521B6EA0;
 Sat, 13 Jun 2026 23:04:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9650E3CE8FB;
 Sat, 13 Jun 2026 23:04:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexandra Winter <wintera@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Gautam Gala <ggala@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 49/61] target/s390x: Make container ids in SysIB_15x
 1-based
Date: Sat, 13 Jun 2026 23:03:32 +0300
Message-ID: <20260613200411.1808021-49-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexandra Winter <wintera@linux.ibm.com>

The Container Id in a container-type TLE of SysIB_15x is defined as 8-bit
unsigned nonzero integer. Make stsi fc 15 emulation architecture compliant,
by starting the container ids at 1 for the lowest numbered container.

The qemu misbehaviour without this patch becomes obvious due to a recently
proposed kernel fix. Older linux kernels pass the container ids from stsi
fc15 unchanged to sysfs, i.e. starting at 1 on s390 hardware. This resulted
in off-by-one values when compared to the values from HMC. A Linux kernel
fix is being proposed to correct the sysfs topology ids by -1, so they
start at 0, e.g. when displayed by 'lscpu -ye'. In case a KVM guest with a
fixed kernel runs on a host with a qemu without this fix, this can result
in container ids erroneously being shown as 255.
Example (Fixed guest on unfixed qemu):
$ lscpu -ye
CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
  0    0    255  255    255    0 0:0:0         yes yes        vert-medium  0
  1    0    255  255      0    1 1:1:1         yes yes        vert-medium  1
After this fix:
$ lscpu -ye
CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
  0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
  1    0      0    0      1    1 1:1:1         yes yes        vert-medium  1

Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Gautam Gala <ggala@linux.ibm.com>
Message-ID: <20260511134909.43802-1-wintera@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 1f1ccb6f3c48a2cd80e874d66afeef2dc28a65f3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
index c8d6389cd8..af3fd8ad1b 100644
--- a/target/s390x/kvm/stsi-topology.c
+++ b/target/s390x/kvm/stsi-topology.c
@@ -90,9 +90,9 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
     int last_drawer = -1;
     int last_book = -1;
     int last_socket = -1;
-    int drawer_id = 0;
-    int book_id = 0;
-    int socket_id = 0;
+    int drawer_id = 1;
+    int book_id = 1;
+    int socket_id = 1;
     int n = sizeof(SysIB_151x);
 
     QTAILQ_FOREACH(entry, topology_list, next) {
@@ -103,12 +103,12 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
         if (level > 3 && drawer_change) {
             SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
             p = fill_container(p, 3, drawer_id++);
-            book_id = 0;
+            book_id = 1;
         }
         if (level > 2 && book_change) {
             SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
             p = fill_container(p, 2, book_id++);
-            socket_id = 0;
+            socket_id = 1;
         }
         if (socket_change) {
             SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
-- 
2.47.3


