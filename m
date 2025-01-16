Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06116C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYOWb-00027s-Lm; Thu, 16 Jan 2025 06:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYOWP-00025f-GA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYOWN-0002k8-Vk
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737028727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8pQPj2Ng8bQVFSZHI5iNBkf3E2JGfm4YEr4KvyBvRY=;
 b=Vy3iHXsN1+ORA0iOKObWu/M2ZJ5dFHwjVDgUcclVGweX9amk01kP3BucBfVqNkth4OdzFN
 w+VTJzC7RCFdu5KHS2KnCBntN7l63rFN9NBxa9CsjXuHxdUfiSdVjU230kS2E6V8884jfd
 q1WYfHRto1Hh/N1ipd0Urr2Bp0So5Vk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-Co7NB7yMPE2NPkjNk9VP6A-1; Thu,
 16 Jan 2025 06:58:42 -0500
X-MC-Unique: Co7NB7yMPE2NPkjNk9VP6A-1
X-Mimecast-MFC-AGG-ID: Co7NB7yMPE2NPkjNk9VP6A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5218719560AA; Thu, 16 Jan 2025 11:58:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.129])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC3FE30001BE; Thu, 16 Jan 2025 11:58:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 2/3] pc-bios/s390-ccw: Fix boot problem with virtio-net devices
Date: Thu, 16 Jan 2025 12:58:25 +0100
Message-ID: <20250116115826.192047-3-thuth@redhat.com>
In-Reply-To: <20250116115826.192047-1-thuth@redhat.com>
References: <20250116115826.192047-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When we are trying to boot from virtio-net devices, the
s390-ccw bios currently leaves the virtio-net device enabled
after using it. That means that the receiving virt queues will
continue to happily write incoming network packets into memory.
This can corrupt data of the following boot process. For example,
if you set up a second guest on a virtual network and create a
lot of broadcast traffic there, e.g. with:

 ping -i 0.02 -s 1400  -b 192.168.1.255

and then you try to boot a guest with two boot devices, a network
device first (which should not be bootable) and e.g. a bootable SCSI
CD second, then this guest will fail to load the kernel from the CD
image:

 $ qemu-system-s390x -m 2G -nographic -device virtio-scsi-ccw \
    -netdev tap,id=net0 -device virtio-net-ccw,netdev=net0,bootindex=1 \
    -drive if=none,file=test.iso,format=raw,id=cd1 \
    -device scsi-cd,drive=cd1,bootindex=2
 LOADPARM=[        ]

 Network boot device detected
 Network boot starting...
   Using MAC address: 52:54:00:12:34:56
   Requesting information via DHCP: done
   Using IPv4 address: 192.168.1.76
   Using TFTP server: 192.168.1.1
 Trying pxelinux.cfg files...
   TFTP error: ICMP ERROR "port unreachable"
   Receiving data:  0 KBytes
 Repeating TFTP read request...
   TFTP error: ICMP ERROR "port unreachable"
 Failed to load OS from network.
 Failed to IPL from this network!
 LOADPARM=[        ]

 Using virtio-scsi.

 ! virtio-scsi:setup:inquiry: response VS RESP=ff !
 ERROR: No suitable device for IPL. Halting...

We really have to shut up the virtio-net devices after we're not
using it anymore. The easiest way to do this is to simply reset
the device, so let's do that now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/virtio.h     |  1 +
 pc-bios/s390-ccw/netmain.c    | 33 +++++++++++++++++++++++----------
 pc-bios/s390-ccw/virtio-net.c |  5 +++++
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index f13fa6f5fe..5c5e808a50 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -278,5 +278,6 @@ int virtio_reset(VDev *vdev);
 int virtio_setup_ccw(VDev *vdev);
 
 int virtio_net_init(void *mac_addr);
+void virtio_net_deinit(void);
 
 #endif /* VIRTIO_H */
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index e46e470db4..335ea9b63e 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -153,19 +153,10 @@ static int tftp_load(filename_ip_t *fnip, void *buffer, int len)
     return rc;
 }
 
-static int net_init(filename_ip_t *fn_ip)
+static int net_init_ip(filename_ip_t *fn_ip)
 {
     int rc;
 
-    memset(fn_ip, 0, sizeof(filename_ip_t));
-
-    rc = virtio_net_init(mac);
-    if (rc < 0) {
-        puts("Could not initialize network device");
-        return -101;
-    }
-    fn_ip->fd = rc;
-
     printf("  Using MAC address: %02x:%02x:%02x:%02x:%02x:%02x\n",
            mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 
@@ -221,11 +212,33 @@ static int net_init(filename_ip_t *fn_ip)
     return rc;
 }
 
+static int net_init(filename_ip_t *fn_ip)
+{
+    int rc;
+
+    memset(fn_ip, 0, sizeof(filename_ip_t));
+
+    rc = virtio_net_init(mac);
+    if (rc < 0) {
+        puts("Could not initialize network device");
+        return -101;
+    }
+    fn_ip->fd = rc;
+
+    rc = net_init_ip(fn_ip);
+    if (rc < 0) {
+        virtio_net_deinit();
+    }
+
+    return rc;
+}
+
 static void net_release(filename_ip_t *fn_ip)
 {
     if (fn_ip->ip_version == 4) {
         dhcp_send_release(fn_ip->fd);
     }
+    virtio_net_deinit();
 }
 
 /**
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 578c89d0c5..301445bf97 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -140,3 +140,8 @@ int recv(int fd, void *buf, int maxlen, int flags)
 
     return len;
 }
+
+void virtio_net_deinit(void)
+{
+    virtio_reset(virtio_get_device());
+}
-- 
2.47.1


