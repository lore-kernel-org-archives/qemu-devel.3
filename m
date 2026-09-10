Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23967C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nlR-000631-KT; Thu, 10 Sep 2026 19:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWk-0006ao-63
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWQ-0004hb-1I
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KaGnA6790D1crogtaW20lAmdvIS1bCL1ahQfy0qBOJg=;
 b=DTMPOq6ad+rhXmgAOEMMdKokquHKUVokUjkLP+0mGUPSAwe/Kn9vZOnchK9FrFtzTQtGkQ
 7i/ciWYo3xBEpCC9BT7H6q5f4mEAbfdklgev679OIyKk1kqVNZlvyF7DesVKtLlzAPwBZs
 BjE6p6n+3t4KZpDFEGVFBE8khYdW/aQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-yAeET3HaMHSeuLFfDAoRaw-1; Thu, 10 Sep 2026 16:15:33 -0400
X-MC-Unique: yAeET3HaMHSeuLFfDAoRaw-1
X-Mimecast-MFC-AGG-ID: yAeET3HaMHSeuLFfDAoRaw_1789071333
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so1673145e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071332; x=1789676132; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KaGnA6790D1crogtaW20lAmdvIS1bCL1ahQfy0qBOJg=;
 b=k9tgZJ7+ufwarb3mlvWoOgTK1IyZrw2oB1qYk1LKyqfJMbWBSfvYe+jdR4ROEKsi64
 wkXDRI7ZOx6bJQ8N9peEsge+xN4hZB73CiiBNyWbdoakX7VA1Qre5SE/Os/7RC6Nenie
 bhy4dDiltG5zmuLm4FHVRIodMChcb1Kv5A8HsiZCGtlVTYcUGqRdgGycR6Y2N93tkLPT
 xjDRKqqYxvsgr32rm2dcsHIww21lYtBTkwOzwNgmt6M9lSdiRp0df4/8H8f45y60+wm1
 if8lhE+o5ygjhenNd5MFZvtvTFzOvGIkC3db2yJBVno+NKsmy76QHNJHJso+OOqyGXSI
 a91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071332; x=1789676132;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KaGnA6790D1crogtaW20lAmdvIS1bCL1ahQfy0qBOJg=;
 b=sC9AU/66hOiL1KqvWr8bpcV/YLWP2oe0PG1/iHygLeFHEuOlLIpWh41MsOSxea0mCj
 EGSbGVsYF4T9mr9OnI3gLveSbJ9adWL0hKE2DWjxSUA/7gqrXJC5IWEeXXP1alQ7TKY7
 Td0gf8aFYbhGW1PQQWHVVk58YbjCKORerjq2+ct1BEXGiXqDq3YjiwQFpG54km8g/pK0
 eAZeiP24WGrE92ZlUDoaTEImaJZr7h06mtKWxwuqwwNJ+KBvlfQ2TZXz9ar7wN4o7hqX
 Y/sXj2rzz/vx/LJ5USviqWUGoFH8ADrm4xfXSUhlqF2qb9kDKNa1q0uJNserBabH9ueq
 H2mg==
X-Gm-Message-State: AFuF++lNTO6dqLHEJB8ALALDe3JXIRqh3yIeafBKksLoKHo2Pf2lKGY1
 69g07Rnvl7gQ1fhqMOK7YVGBmnoHpIW3Ud2iwwqvzRMNCk4rNOrbPGMxPymo6B9o8RzA3Cubwfx
 3lRtUaA4XdfsDceqRhQFqPpHdBpodrnS8McseWgYEe3OeWfmXtB1U+2WHuYkfEBTh9Q0lDcEPtn
 FNdgJuq5JHj9kEfhchCQHUvcxzcZZ0UfQmDw==
X-Gm-Gg: AYBFou2BriTFf0mDZW//UOSOTBNXcGPymmvRiUOxrs4Zht30yqNuLScQb8JauT5ZP0+
 57nWb1yu20l4eItdGEhnNYrxczaMW8zwHIltoKwtDLWNXC8obL6WLIygim88IDmqriBEiTNtLm7
 2lIPDZX21ZbUAReDmW8SFrSV+dnz0G1iy4A6+O5oBxyC48b9m8dRMePl7Qz6oz2rwL9l5+PAvGv
 Wp8vS3lQolv8ZfvEQqAXcI5akU9RWQbAOa0kpMW57Z98bBJvAtgAAxSwEQRG4oiROetM1qoehQ7
 rGr1WmAmmRm6XPyJ+YKYxW4P2hQ2z5h4LXHu+tur0/A+v9kRQf6AneuhutYnYenVY7s0WIMcXLg
 MuUOj3yBUJdeJFllyaa2T+VM=
X-Received: by 2002:a05:600c:c48f:b0:49c:cee2:a508 with SMTP id
 5b1f17b1804b1-49e619c18edmr8760225e9.16.1789071332448; 
 Thu, 10 Sep 2026 13:15:32 -0700 (PDT)
X-Received: by 2002:a05:600c:c48f:b0:49c:cee2:a508 with SMTP id
 5b1f17b1804b1-49e619c18edmr8759605e9.16.1789071331953; 
 Thu, 10 Sep 2026 13:15:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb3602eesm685482f8f.34.2026.09.10.13.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:31 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Weimin Xiong <xiongwm2026@163.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL 81/90] net/tap-solaris: Fix resource leaks on error paths
Message-ID: <63436f0c382d7e514711c6853d6bbac469097a9f.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/tap-solaris.c | 69 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 8704b1084b..2c6c7af15e 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -60,8 +60,6 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
  */
 static int tap_alloc(char *dev, size_t dev_size, Error **errp)
 {
-    /* FIXME leaks like a sieve on error paths */
-    /* FIXME suspicious: many errors are reported, then ignored */
     int tap_fd, if_fd, ppa = -1;
     static int ip_fd = 0;
     char *ptr;
@@ -102,45 +100,61 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
     strioc_ppa.ic_timout = 0;
     strioc_ppa.ic_len = sizeof(ppa);
     strioc_ppa.ic_dp = (char *)&ppa;
-    if ((ppa = ioctl (tap_fd, I_STR, &strioc_ppa)) < 0)
+    if ((ppa = ioctl (tap_fd, I_STR, &strioc_ppa)) < 0) {
         error_report("Can't assign new interface");
+        goto fail_tap_fd;
+    }
 
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
     }
 
-    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
+    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0) {
         error_report("Can't get flags");
+        goto fail_if_fd;
+    }
 
-    snprintf (actual_name, 32, "tap%d", ppa);
+    snprintf(actual_name, 32, "tap%d", ppa);
     pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
 
     ifr.lifr_ppa = ppa;
-    /* Assign ppa according to the unit number returned by tun device */
-
-    if (ioctl (if_fd, SIOCSLIFNAME, &ifr) < 0)
+    if (ioctl(if_fd, SIOCSLIFNAME, &ifr) < 0) {
         error_report("Can't set PPA %d", ppa);
-    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) <0)
+        goto fail_if_fd;
+    }
+
+    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0) {
         error_report("Can't get flags");
+        goto fail_if_fd;
+    }
+
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
@@ -149,32 +163,45 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
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
 
-    close (if_fd);
+    close(if_fd);
 
     memset(&ifr, 0x0, sizeof(ifr));
     pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
     ifr.lifr_ip_muxid  = ip_muxid;
     ifr.lifr_arp_muxid = arp_muxid;
 
-    if (ioctl (ip_fd, SIOCSLIFMUXID, &ifr) < 0)
+    if (ioctl(ip_fd, SIOCSLIFMUXID, &ifr) < 0)
     {
-      ioctl (ip_fd, I_PUNLINK , arp_muxid);
-      ioctl (ip_fd, I_PUNLINK, ip_muxid);
+      ioctl(ip_fd, I_PUNLINK, arp_muxid);
+      ioctl(ip_fd, I_PUNLINK, ip_muxid);
       error_report("Can't set multiplexor id");
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
+    return -1;
 }
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
-- 
MST


