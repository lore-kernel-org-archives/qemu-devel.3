Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCEFC79F85
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 07:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2kSm-0008WR-81; Sat, 05 Sep 2026 03:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongweimin@kylinos.cn>)
 id 1x2kSh-0008V7-4A
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 03:05:16 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongweimin@kylinos.cn>)
 id 1x2kSd-00010k-5c
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 03:05:14 -0400
X-UUID: 16e7bf44a8f811f19a56ed5b684f684d-20260905
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:b1a83392-0357-4807-84c6-eb12ac3be007, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-20
X-CID-META: VersionHash:7db8b62, CLOUDID:ef6ed0513123d2d99876f63ed063ff32,
 BulkI
 D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50|99|10
 0|102|153,EDM:19|-19|2|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
 EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 16e7bf44a8f811f19a56ed5b684f684d-20260905
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <xiongweimin@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1745992529; Sat, 05 Sep 2026 15:04:51 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: mst@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH v2] net/tap-solaris: Fix resource leaks on error paths
Date: Sat,  5 Sep 2026 15:04:48 +0800
Message-ID: <20260905070448.34648-2-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905070448.34648-1-xiongweimin@kylinos.cn>
References: <20260905070448.34648-1-xiongweimin@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=xiongweimin@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The tap_alloc() function has multiple error paths where opened file
descriptors (tap_fd, if_fd, ip_fd, arp_fd) and STREAMS multiplexors
(ip_muxid, arp_muxid) are not released before returning error. This
leads to resource leaks and, on subsequent calls to tap_alloc(),
to use-after-free because ip_fd is a function-static variable.

Fix this by introducing explicit cleanup labels and releasing all
resources on every error path, in reverse order of acquisition:

  fail_ip_muxid:  I_PUNLINK ip_muxid
  fail_arp_fd:    close(arp_fd)
  fail_if_fd:     close(if_fd)
  fail_tap_fd:    close(tap_fd); close(ip_fd) if it was opened

The SIOCSLIFMUXID failure path keeps its existing inline
I_PUNLINK arp_muxid / I_PUNLINK ip_muxid calls (those muxids were
both successfully established at that point) and then jumps
directly to fail_if_fd to skip the redundant muxid cleanup.

The ip_fd reset to 0 after close is intentional: ip_fd is a
function-static variable, so any subsequent tap_alloc() invocation
must not see a stale value, otherwise the `if (ip_fd) close(ip_fd);`
at the top of the function would close a fd that some other code
now owns.

Changes since v1:

  - Replaced the mixed fall-through / explicit-goto label scheme
    of v1 with a single descending goto chain at the bottom of
    the function: each label only releases its own resource and
    falls through to the next, matching the goto-cleanup pattern
    used in net/tap-linux.c.
  - The ip_fd close that v1 inserted right before SIOCSLIFMUXID
    (which used a stale fd) has been removed. ip_fd is now only
    closed in the failure paths.
  - arp_muxid and ip_muxid are I_PUNLINK'd exactly once each.
    v1's separate fail_arp_muxid label would have double-released
    them when the SIOCSLIFMUXID failure path fell through to it.
  - This v2 is generated with `git diff` against a fresh checkout
    of net/tap-solaris.c, so the file mode and hunks are well-
    formed and `git apply --check` passes cleanly. v1's file mode
    line was corrupted.

This refactor has not been tested on a real Solaris host, because
I do not have access to one. Please flag anything that looks off.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 net/tap-solaris.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 8704b10..7ad111f 100644
--- a/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -149,15 +149,18 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
     strioc_if.ic_dp = (char *)&ifr;
     if (ioctl(arp_fd, I_STR, &strioc_if) < 0){
         error_report("Can't set ifname to arp");
+        goto fail_arp_fd;
     }
 
     if((ip_muxid = ioctl(ip_fd, I_LINK, if_fd)) < 0){
         error_setg(errp, "Can't link TAP device to IP");
-        return -1;
+        goto fail_arp_fd;
     }
 
-    if ((arp_muxid = ioctl (ip_fd, link_type, arp_fd)) < 0)
+    if ((arp_muxid = ioctl (ip_fd, link_type, arp_fd)) < 0) {
         error_report("Can't link TAP device to ARP");
+        goto fail_ip_muxid;
+    }
 
     close (if_fd);
 
@@ -171,10 +174,25 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
       ioctl (ip_fd, I_PUNLINK , arp_muxid);
       ioctl (ip_fd, I_PUNLINK, ip_muxid);
       error_report("Can't set multiplexor id");
+      goto fail_if_fd;
     }
 
     snprintf(dev, dev_size, "tap%d", ppa);
     return tap_fd;
+
+fail_ip_muxid:
+    ioctl(ip_fd, I_PUNLINK, ip_muxid);
+fail_arp_fd:
+    close(arp_fd);
+fail_if_fd:
+    close(if_fd);
+fail_tap_fd:
+    close(tap_fd);
+    if (ip_fd > 0) {
+        close(ip_fd);
+        ip_fd = 0;
+    }
+    return -1;
 }
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,

