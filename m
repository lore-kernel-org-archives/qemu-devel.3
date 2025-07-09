Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C88DC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 08:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZQH6-0005vy-Gc; Wed, 09 Jul 2025 04:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZQGn-0005pQ-C6
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZQGl-0007zG-6r
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752050110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+n9JYmYoRgilnipY97YZlMvRWhtybWXmB9u6fjf7OJo=;
 b=F0Ash2gC8PeCNYGc2dVfOb+GmOkEsLic6c+PDzClIHOX217bzxH2HwbGXjepfrmyK3pk9D
 cFq5ewKxi8ZEXhA9LVZpj4kJnqqJ4cLyNIR7ockO+jv9nC6F4jC+R5QGFPfyCzap941D/g
 yl+vaH8gpO/ILoJqpMHQDhen+2nSspY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-Pexp8JUANVmghorvwhpcYg-1; Wed,
 09 Jul 2025 04:35:07 -0400
X-MC-Unique: Pexp8JUANVmghorvwhpcYg-1
X-Mimecast-MFC-AGG-ID: Pexp8JUANVmghorvwhpcYg_1752050105
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B47821956096; Wed,  9 Jul 2025 08:35:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.92])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C827A1800285; Wed,  9 Jul 2025 08:35:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 4/5] pc-bios/s390-ccw: Add a boot menu for booting via
 pxelinux.cfg
Date: Wed,  9 Jul 2025 10:34:42 +0200
Message-ID: <20250709083443.41574-5-thuth@redhat.com>
In-Reply-To: <20250709083443.41574-1-thuth@redhat.com>
References: <20250709083443.41574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Show a simple boot menu for pxelinux.cfg, too, if the user requested it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 6f64323cd84..a9521dff416 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -332,6 +332,28 @@ static int load_kernel_with_initrd(filename_ip_t *fn_ip,
     return rc;
 }
 
+static int net_boot_menu(int num_ent, int def_ent,
+                         struct pl_cfg_entry *entries)
+{
+    bool valid_entries[MAX_BOOT_ENTRIES] = { false };
+    int idx;
+
+    puts("\ns390-ccw pxelinux.cfg boot menu:\n");
+    printf(" [0] default (%d)\n", def_ent + 1);
+    valid_entries[0] = true;
+
+    for (idx = 1; idx <= num_ent; idx++) {
+        printf(" [%d] %s\n", idx, entries[idx - 1].label);
+        valid_entries[idx] = true;
+    }
+    putchar('\n');
+
+    idx = menu_get_boot_index(valid_entries);
+    putchar('\n');
+
+    return idx;
+}
+
 static int net_select_and_load_kernel(filename_ip_t *fn_ip,
                                       int num_ent, int selected,
                                       struct pl_cfg_entry *entries)
@@ -342,6 +364,10 @@ static int net_select_and_load_kernel(filename_ip_t *fn_ip,
         return -1;
     }
 
+    if (menu_is_enabled_enum() && num_ent > 1) {
+        loadparm = net_boot_menu(num_ent, selected, entries);
+    }
+
     IPL_assert(loadparm <= num_ent,
                "loadparm is set to an entry that is not available in the "
                "pxelinux.cfg file!");
-- 
2.50.0


