Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19174C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA9e-0001QL-Kk; Fri, 11 Jul 2025 05:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA90-0000m6-UZ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA8y-00075y-LC
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752226450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZga9uASmHzbgixzJYxcOZcdjUjgsWPg2RepoUamHWw=;
 b=I0g9jvV+oZbzX5DQXtl/ScksyxZhBZd/zcMvR3HgkfFxhKWQOciKb96+C0B05v072JmcY4
 HjSwEm070mFVJ6wcKSBZVfoyI7MATtD+GsJ0hNtHoT/2blkcp98Alc43rqOZbv11YAmzyf
 bbh1At1csZHCTkOcB+HhnT6gdGJMlqg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-108_WaRQPIC8qXxwXa1f5Q-1; Fri,
 11 Jul 2025 05:34:07 -0400
X-MC-Unique: 108_WaRQPIC8qXxwXa1f5Q-1
X-Mimecast-MFC-AGG-ID: 108_WaRQPIC8qXxwXa1f5Q_1752226446
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D10A3180ACEF; Fri, 11 Jul 2025 09:34:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EC15195607A; Fri, 11 Jul 2025 09:33:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 06/15] pc-bios/s390-ccw: Make get_boot_index() from menu.c
 global
Date: Fri, 11 Jul 2025 11:33:31 +0200
Message-ID: <20250711093340.608485-7-thuth@redhat.com>
In-Reply-To: <20250711093340.608485-1-thuth@redhat.com>
References: <20250711093340.608485-1-thuth@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250709083443.41574-4-thuth@redhat.com>
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


