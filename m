Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B5BC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFCx-00017U-2f; Tue, 08 Jul 2025 16:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZDmT-0003jN-Fs
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZDmO-0006xW-W0
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752002097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jw5d25sXHGdf0M9sXiuyl0RF1wEk9KuB131pPHMmIJI=;
 b=RWXX6UG/XNykcOTMp5vtyX73t1pe3bjVONsHDnHOimtjbnegGxhM/ENgSPJVg7JUf6H364
 GyLy0NVkWjkKpkCh5ksqXSCpq6duH6EZL0idwujJv9fELIhYV4ZbKuHKfTcMzpLp2qG3T2
 dEr7PCHgIQeCaRphuErHzb3H5iw8kSE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-uRV5I-iUM3KcH39b6ZDGjA-1; Tue,
 08 Jul 2025 08:56:41 -0400
X-MC-Unique: uRV5I-iUM3KcH39b6ZDGjA-1
X-Mimecast-MFC-AGG-ID: uRV5I-iUM3KcH39b6ZDGjA_1751979400
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEFD21800287; Tue,  8 Jul 2025 12:56:39 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-196.str.redhat.com
 [10.33.192.196])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C422219560AB; Tue,  8 Jul 2025 12:56:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 2/5] pc-bios/s390-ccw: Allow up to 31 entries for pxelinux.cfg
Date: Tue,  8 Jul 2025 14:56:27 +0200
Message-ID: <20250708125630.58676-3-thuth@redhat.com>
In-Reply-To: <20250708125630.58676-1-thuth@redhat.com>
References: <20250708125630.58676-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

We're going to support a menu for the pxelinux.cfg code, and to be able
to reuse some functionality from menu.c, we should align the maximum
amount of possible entries with the MAX_BOOT_ENTRIES constant that is
used there. Thus replace MAX_PXELINUX_ENTRIES with MAX_BOOT_ENTRIES.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 024b4419ef6..4f77635fb86 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -354,17 +354,15 @@ static int net_select_and_load_kernel(filename_ip_t *fn_ip,
     return load_kernel_with_initrd(fn_ip, &entries[selected]);
 }
 
-#define MAX_PXELINUX_ENTRIES 16
-
 static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
 {
-    struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
+    struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
     int num_ent, def_ent = 0;
 
     num_ent = pxelinux_load_parse_cfg(fn_ip, mac, get_uuid(),
                                       DEFAULT_TFTP_RETRIES,
                                       cfgbuf, sizeof(cfgbuf),
-                                      entries, MAX_PXELINUX_ENTRIES, &def_ent);
+                                      entries, MAX_BOOT_ENTRIES, &def_ent);
 
     return net_select_and_load_kernel(fn_ip, num_ent, def_ent, entries);
 }
@@ -447,11 +445,11 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
          * a magic comment string.
          */
         if (!strncasecmp("# pxelinux", cfgbuf, 10)) {
-            struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
+            struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
             int num_ent, def_ent = 0;
 
             num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
-                                         MAX_PXELINUX_ENTRIES, &def_ent);
+                                         MAX_BOOT_ENTRIES, &def_ent);
             return net_select_and_load_kernel(fn_ip, num_ent, def_ent,
                                               entries);
         }
-- 
2.50.0


