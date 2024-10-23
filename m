Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B7ACF538A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFR-0006Sk-Mq; Wed, 23 Oct 2024 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFF-0006Cm-2z
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFD-0002BV-98
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c2+dcvwTw8EOqSLkKmGvOUFCxwmSLHABvCXafJ4CH0=;
 b=dHF8Zo8IGRbpLCMkZ9BiFZDOrIPCM+xID54xbFY5i6czAE6yR0jPcWExwmCHFj3+C2mPuI
 3/quek7FK1pAu9TWWfQjyP9ZMgLoyvYLrj1fylDHWdGs4Et46mtEQ7zGYBF3Q1bKy8oYwP
 BmAfStW2ra7gkIG2VO38dhRMhqoHMHg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-QyX1nlqCPpeyPzXgIWkQsg-1; Wed,
 23 Oct 2024 09:17:42 -0400
X-MC-Unique: QyX1nlqCPpeyPzXgIWkQsg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67500195423D; Wed, 23 Oct 2024 13:17:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3D2719560AE; Wed, 23 Oct 2024 13:17:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 11/23] pc-bios/s390-ccw: Remove panics from Netboot IPL path
Date: Wed, 23 Oct 2024 15:16:58 +0200
Message-ID: <20241023131710.906748-12-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
References: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Remove panic-on-error from Netboot specific functions so that error recovery
may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241020012953.1380075-12-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h   |  2 +-
 pc-bios/s390-ccw/bootmap.c    |  1 +
 pc-bios/s390-ccw/netmain.c    | 17 +++++++++++------
 pc-bios/s390-ccw/virtio-net.c |  7 +++++--
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 3e844abd71..344ad15655 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -57,7 +57,7 @@ unsigned int get_loadparm_index(void);
 void main(void);
 
 /* netmain.c */
-void netmain(void);
+int netmain(void);
 
 /* sclp.c */
 void sclp_print(const char *string);
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 652807a16a..95ef9104d0 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -1072,6 +1072,7 @@ void zipl_load(void)
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
         netmain();
+        panic("\n! Cannot IPL from this network !\n");
     }
 
     if (ipl_scsi()) {
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index bc6ad8695f..d1a6c9a91c 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -464,7 +464,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
     return false;
 }
 
-static void virtio_setup(void)
+static bool virtio_setup(void)
 {
     Schib schib;
     int ssid;
@@ -495,10 +495,10 @@ static void virtio_setup(void)
         }
     }
 
-    IPL_assert(found, "No virtio net device found");
+    return found;
 }
 
-void netmain(void)
+int netmain(void)
 {
     filename_ip_t fn_ip;
     int rc, fnlen;
@@ -506,11 +506,15 @@ void netmain(void)
     sclp_setup();
     puts("Network boot starting...");
 
-    virtio_setup();
+    if (!virtio_setup()) {
+        puts("No virtio net device found.");
+        return -1;
+    }
 
     rc = net_init(&fn_ip);
     if (rc) {
-        panic("Network initialization failed. Halting.");
+        puts("Network initialization failed.");
+        return -1;
     }
 
     fnlen = strlen(fn_ip.filename);
@@ -528,5 +532,6 @@ void netmain(void)
         jump_to_low_kernel();
     }
 
-    panic("Failed to load OS from network.");
+    puts("Failed to load OS from network.");
+    return -1;
 }
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 2fcb0a58c5..f9854a22c3 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -54,8 +54,11 @@ int virtio_net_init(void *mac_addr)
     vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
     virtio_setup_ccw(vdev);
 
-    IPL_assert(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT,
-               "virtio-net device does not support the MAC address feature");
+    if (!(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT)) {
+        puts("virtio-net device does not support the MAC address feature");
+        return -1;
+    }
+
     memcpy(mac_addr, vdev->config.net.mac, ETH_ALEN);
 
     for (i = 0; i < 64; i++) {
-- 
2.47.0


