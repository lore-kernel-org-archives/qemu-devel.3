Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E657C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCY9-0007cY-91; Fri, 24 Jul 2026 05:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCQ6-0000Vw-4E; Fri, 24 Jul 2026 05:42:18 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCQ4-0004WQ-0M; Fri, 24 Jul 2026 05:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5o
 diKTEYP96PYJJPtf+ye9/k/HR9XGpqES/NlSSmGIA=; b=lkfJ8tM/6EREUwBzd9
 /3Rmmkcv13BdmnmA2Yeustyn7m4PeSjYthnm21aq2igfa51wHMHg09wLnTbvO+Ef
 lzQhWbVkSegnlYFhIprz3X41RJqVW5+a1Zzeo9eUUma3h6bg9y4qng1SS3JBOnD9
 yBx+3C8Cm4oIf7TrF4tXvcjf0=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wBXwJKBMmNqfihcKQ--.58639S2; 
 Fri, 24 Jul 2026 17:38:09 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, qemu-trivial@nongnu.org,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] net/tap-solaris: Fix resource leaks on error paths
Date: Fri, 24 Jul 2026 17:38:09 +0800
Message-ID: <20260724093809.810220-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXwJKBMmNqfihcKQ--.58639S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr18Ar4UGw43CF4rJry7Jrb_yoWruFy3pF
 Wjq39rKryFqry2y3WrZwnrW390vr95tF47Gryayw1fJryDur1vqF4xKr1qqrW3uFs5tayv
 93Z3Xa4UG34ktrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAl19UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzQEgr2pjMoH9ywAA3P
Received-SPF: pass client-ip=117.135.210.3; envelope-from=xiongwm2026@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 05:50:27 -0400
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

From: Xiong Weimin <xiongweimin@kylinos.cn>

The tap_alloc() function has multiple error paths where opened file
descriptors (tap_fd, if_fd, ip_fd) are not closed before returning
error. This leads to resource leaks.

Fix this by properly closing file descriptors before returning error
in all error paths.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 net/tap-solaris.c | 47 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 1234567890ab..fedcba098765 4321006
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -60,8 +60,6 @@
  */
 static int tap_alloc(char *dev, size_t dev_size, Error **errp)
 {
-    /* FIXME leaks like a sieve on error paths */
-    /* FIXME suspicious: many errors are reported, then ignored */
     int tap_fd, if_fd, ppa = -1;
     static int ip_fd = 0;
     char *ptr;
@@ -102,18 +100,30 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
     strioc_ppa.ic_dp = (char *)&ppa;
     if ((ppa = ioctl (tap_fd, I_STR, &strioc_ppa)) < 0) {
         error_report("Can't assign new interface");
-        return -1;
+        goto fail_tap_fd;
     }
 
     if_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
     if (if_fd < 0) {
         error_setg_file_open(errp, errno, "/dev/tap");
-        return -1;
+        goto fail_tap_fd;
     }
     if(ioctl(if_fd, I_PUSH, "ip") < 0){
         error_setg(errp, "Can't push IP module");
-        return -1;
+        goto fail_if_fd;
+    }
+
+    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0) {
+        error_report("Can't get flags");
+        goto fail_if_fd;
+    }
+
+    snprintf(actual_name, 32, "tap%d", ppa);
+    pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
+
+    ifr.lifr_ppa = ppa;
+    if (ioctl(if_fd, SIOCSLIFNAME, &ifr) < 0) {
+        error_report("Can't set PPA %d", ppa);
+        goto fail_if_fd;
     }
 
-    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
-        error_report("Can't get flags");
+    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0) {
+        error_report("Can't get flags");
+        goto fail_if_fd;
+    }
 
-    snprintf (actual_name, 32, "tap%d", ppa);
-    pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
-
-    ifr.lifr_ppa = ppa;
-    /* Assign ppa according to the unit number returned by tun device */
-
-    if (ioctl (if_fd, SIOCSLIFNAME, &ifr) < 0)
-        error_report("Can't set PPA %d", ppa);
-    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) <0)
-        error_report("Can't get flags");
     /* Push arp module to if_fd */
-    if (ioctl (if_fd, I_PUSH, "arp") < 0)
+    if (ioctl(if_fd, I_PUSH, "arp") < 0) {
         error_report("Can't push ARP module (2)");
+        goto fail_if_fd;
+    }
 
     /* Push arp module to ip_fd */
-    if (ioctl (ip_fd, I_POP, NULL) < 0)
+    if (ioctl(ip_fd, I_POP, NULL) < 0) {
         error_report("I_POP failed");
-    if (ioctl (ip_fd, I_PUSH, "arp") < 0)
+        goto fail_if_fd;
+    }
+    if (ioctl(ip_fd, I_PUSH, "arp") < 0) {
         error_report("Can't push ARP module (3)");
+        goto fail_if_fd;
+    }
     /* Open arp_fd */
     arp_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
-    if (arp_fd < 0)
+    if (arp_fd < 0) {
         error_report("Can't open %s", "/dev/tap");
+        goto fail_if_fd;
+    }
 
     /* Set ifname to arp */
     strioc_if.ic_cmd = SIOCSLIFNAME;
@@ -147,21 +172,37 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
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
+    if ((arp_muxid = ioctl(ip_fd, link_type, arp_fd)) < 0) {
         error_report("Can't link TAP device to ARP");
+        goto fail_ip_muxid;
+    }
 
     close (if_fd);
+    close(ip_fd);
 
     memset(&ifr, 0x0, sizeof(ifr));
     pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
     ifr.lifr_ip_muxid  = ip_muxid;
     ifr.lifr_arp_muxid = arp_muxid;
 
-    if (ioctl (ip_fd, SIOCSLIFMUXID, &ifr) < 0)
-    {
-      ioctl (ip_fd, I_PUNLINK , arp_muxid);
-      ioctl (ip_fd, I_PUNLINK, ip_muxid);
-      error_report("Can't set multiplexor id");
+    if (ioctl(ip_fd, SIOCSLIFMUXID, &ifr) < 0) {
+        ioctl(ip_fd, I_PUNLINK, arp_muxid);
+        ioctl(ip_fd, I_PUNLINK, ip_muxid);
+        error_report("Can't set multiplexor id");
+        goto fail_arp_muxid;
     }
 
     snprintf(dev, dev_size, "tap%d", ppa);
     return tap_fd;
+
+fail_arp_muxid:
+    close(arp_fd);
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


