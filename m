Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8CDC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDT-0002Fh-Ln; Tue, 08 Jul 2025 16:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZDn1-00043B-Ec
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZDmw-00076L-Cl
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752002130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlDhxjajiD0HswlEAArayWqXuDON4+6UkEhTcFzRuSs=;
 b=K1yAxC52PuyK3ThGziigRbdhC2f65krJ/N7Ah7dCNskYA5aCb18kbcMllIkNs++3wNWy7r
 Y8xof2zaGON8+/+IU0/Dkrif6cvF5iDdoJYfhBfjZaWZebEjOmUyhpUxHDtjo8noT1Ym0/
 IWoXigs1dOtFeLK1jjh3BJMXNIuhdrA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-EjOL4GHfM3en159cJABNAw-1; Tue,
 08 Jul 2025 08:56:43 -0400
X-MC-Unique: EjOL4GHfM3en159cJABNAw-1
X-Mimecast-MFC-AGG-ID: EjOL4GHfM3en159cJABNAw_1751979402
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89630193F058; Tue,  8 Jul 2025 12:56:42 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-196.str.redhat.com
 [10.33.192.196])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F64C19560AB; Tue,  8 Jul 2025 12:56:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 3/5] pc-bios/s390-ccw: Make get_boot_index() from menu.c global
Date: Tue,  8 Jul 2025 14:56:28 +0200
Message-ID: <20250708125630.58676-4-thuth@redhat.com>
In-Reply-To: <20250708125630.58676-1-thuth@redhat.com>
References: <20250708125630.58676-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

We are going to reuse this function for selecting an entry from
the pxelinux.cfg menu, so rename this function with a "menu_"
prefix and make it available globally.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h | 1 +
 pc-bios/s390-ccw/menu.c     | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 6cdce3e5e5b..b1dc35cdedf 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -87,6 +87,7 @@ int menu_get_zipl_boot_index(const char *menu_data);
 bool menu_is_enabled_zipl(void);
 int menu_get_enum_boot_index(bool *valid_entries);
 bool menu_is_enabled_enum(void);
+int menu_get_boot_index(bool *valid_entries);
 
 #define MAX_BOOT_ENTRIES  31
 
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 84062e94af4..eeaff78f870 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -159,7 +159,7 @@ static void boot_menu_prompt(bool retry)
     }
 }
 
-static int get_boot_index(bool *valid_entries)
+int menu_get_boot_index(bool *valid_entries)
 {
     int boot_index;
     bool retry = false;
@@ -224,7 +224,7 @@ int menu_get_zipl_boot_index(const char *menu_data)
     }
 
     printf("\n");
-    return get_boot_index(valid_entries);
+    return menu_get_boot_index(valid_entries);
 }
 
 int menu_get_enum_boot_index(bool *valid_entries)
@@ -247,7 +247,7 @@ int menu_get_enum_boot_index(bool *valid_entries)
     }
 
     printf("\n");
-    return get_boot_index(valid_entries);
+    return menu_get_boot_index(valid_entries);
 }
 
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
-- 
2.50.0


