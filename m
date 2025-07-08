Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2681EC83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAf-0003t6-Oa; Tue, 08 Jul 2025 16:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZDmI-0003fz-1W
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZDmB-0006sL-E5
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752002082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+E8EuG07i1RQYRr0EUKQV3w7LL62EeDa6k1vmzGubEM=;
 b=QzQ8mMpf7I0CxA1MEuqHTQLH5HZ1gIIKOc6SlK880MVhon3ojePJOj7A8en5NNOoeuUZ4N
 MkM1EhyyWCk0FUMQAPxxaAiUsGEJaRekjrGKunBkrdkGQa/wgWCFZeLTNjxwU9J9n0ednv
 tBAgQgQmjp+OWAs6LoS6yTbEXGyxSrk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-vJBqEgZ4OlmPQnu8XnS1nw-1; Tue,
 08 Jul 2025 08:56:39 -0400
X-MC-Unique: vJBqEgZ4OlmPQnu8XnS1nw-1
X-Mimecast-MFC-AGG-ID: vJBqEgZ4OlmPQnu8XnS1nw_1751979397
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 444421809C8F; Tue,  8 Jul 2025 12:56:37 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-196.str.redhat.com
 [10.33.192.196])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19FB719560AB; Tue,  8 Jul 2025 12:56:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 1/5] pc-bios/s390-ccw: Allow to select a different
 pxelinux.cfg entry via loadparm
Date: Tue,  8 Jul 2025 14:56:26 +0200
Message-ID: <20250708125630.58676-2-thuth@redhat.com>
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

Since we're linking the network booting code into the main firmware
binary nowadays, we can support the "loadparm" parameter now quite
easily for pxelinux.cfg config files that contain multiple entries.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 719a547ada0..024b4419ef6 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -332,6 +332,28 @@ static int load_kernel_with_initrd(filename_ip_t *fn_ip,
     return rc;
 }
 
+static int net_select_and_load_kernel(filename_ip_t *fn_ip,
+                                      int num_ent, int selected,
+                                      struct pl_cfg_entry *entries)
+{
+    unsigned int loadparm = get_loadparm_index();
+
+    if (num_ent <= 0) {
+        return -1;
+    }
+
+    if (loadparm > num_ent) {
+        printf("Error: loadparm is set to entry #%d, but there are only "
+               "%d entries in the pxelinux.cfg file!\n"
+               "Using default entry now instead.\n",
+               loadparm, num_ent);
+    } else if (loadparm > 0) {
+        selected = loadparm - 1;
+    }
+
+    return load_kernel_with_initrd(fn_ip, &entries[selected]);
+}
+
 #define MAX_PXELINUX_ENTRIES 16
 
 static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
@@ -343,11 +365,8 @@ static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
                                       DEFAULT_TFTP_RETRIES,
                                       cfgbuf, sizeof(cfgbuf),
                                       entries, MAX_PXELINUX_ENTRIES, &def_ent);
-    if (num_ent > 0) {
-        return load_kernel_with_initrd(fn_ip, &entries[def_ent]);
-    }
 
-    return -1;
+    return net_select_and_load_kernel(fn_ip, num_ent, def_ent, entries);
 }
 
 /**
@@ -433,10 +452,8 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
 
             num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
                                          MAX_PXELINUX_ENTRIES, &def_ent);
-            if (num_ent <= 0) {
-                return -1;
-            }
-            return load_kernel_with_initrd(fn_ip, &entries[def_ent]);
+            return net_select_and_load_kernel(fn_ip, num_ent, def_ent,
+                                              entries);
         }
     }
 
-- 
2.50.0


