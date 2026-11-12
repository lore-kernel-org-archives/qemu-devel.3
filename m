Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D660A2606
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCu7mxmH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUvK-0007KL-Gs; Thu, 12 Nov 2026 08:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuB-00069i-PO
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuA-0003rJ-BU
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zxtn0zpu3tKIn4V283i3Ousdpz8gAol3ebvt83Mh9s=;
 b=fCu7mxmH4fBjgSdnBDYLuM5pEknbogIb1y6k+KnXnptiWr8SoV+yI39LGaPt5eoKgBjaRk
 xKWVtXe//tRcI4VPFk6voKpymXSVrghJ4cikWjFQMKAGb/djD5JMKrWW4brPJhApPqNpg6
 PLUqDL8HADDVVTeRc2YMGJz89CAwhRQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-k6vVnDrHO3eh6xX1-Mjb6w-1; Thu,
 12 Nov 2026 08:31:51 -0500
X-MC-Unique: k6vVnDrHO3eh6xX1-Mjb6w-1
X-Mimecast-MFC-AGG-ID: k6vVnDrHO3eh6xX1-Mjb6w_1794490310
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A70CC1800540; Thu, 12 Nov 2026 13:31:50 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C4BE1956089; Thu, 12 Nov 2026 13:31:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 29/48] system: stop sorting machine names based on 'family'
Date: Thu, 12 Nov 2026 13:30:35 +0000
Message-ID: <20261112133054.1977618-30-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Only the x86 'nitro-enclave', 'microvm', 'q35' and 'i440fx' machine
classes set a non-NULL 'family' field. This results in a fairly
strange looking sort order in the '-machine help' output, such that
from a user POV is appears largely unsorted. No other targets bother
to set 'family', even though they have far larger lists of machines.

It is sufficient to sort exclusively based on the machine type name
to get a purely alphabetical sorting.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index fb5d55f3d68..a187d10ad9c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1536,33 +1536,7 @@ static bool debugcon_parse(const char *devname, Error **errp)
 static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     const MachineClass *mc1 = a, *mc2 = b;
-    int res;
 
-    if (mc1->family == NULL) {
-        if (mc2->family == NULL) {
-            /* Compare standalone machine types against each other; they sort
-             * in increasing order.
-             */
-            return strcmp(object_class_get_name(OBJECT_CLASS(mc1)),
-                          object_class_get_name(OBJECT_CLASS(mc2)));
-        }
-
-        /* Standalone machine types sort after families. */
-        return 1;
-    }
-
-    if (mc2->family == NULL) {
-        /* Families sort before standalone machine types. */
-        return -1;
-    }
-
-    /* Families sort between each other alphabetically increasingly. */
-    res = strcmp(mc1->family, mc2->family);
-    if (res != 0) {
-        return res;
-    }
-
-    /* Within the same family, machine types sort in decreasing order. */
     return strcmp(object_class_get_name(OBJECT_CLASS(mc2)),
                   object_class_get_name(OBJECT_CLASS(mc1)));
 }
-- 
2.56.1


