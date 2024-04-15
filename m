Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA2DC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 11:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwKJL-00049K-33; Mon, 15 Apr 2024 07:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rwKJG-00045A-FK
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 07:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rwKJD-0000Rd-7Y
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 07:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713179733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oGN80y/NYg6+61c3CmljsuoAsD/BXBOInAqtcGNCyKc=;
 b=hhwm4C/jKvxTANrvulIX97BD3k495rBjwnGlU8gYQgGjbDHQ1y/Hfki+uflQlCp0q58fRt
 2/cdDpei0f9t36oTyiLvC9bJwL7b4WEeAkJg5ZrkksrBFiaiGgTcLqrGAA0dZUyv8Axwp0
 HTtStjNCNR7wS0ldeUEIBPaKK8QV2dE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-7M_ww1QAPKOQXIKldTTzkg-1; Mon,
 15 Apr 2024 07:15:31 -0400
X-MC-Unique: 7M_ww1QAPKOQXIKldTTzkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DBEC1C2CBE2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 11:15:31 +0000 (UTC)
Received: from localhost (unknown [10.39.208.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED5FB2026962;
 Mon, 15 Apr 2024 11:15:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] vl: fix "type is NULL" in -vga help
Date: Mon, 15 Apr 2024 15:15:23 +0400
Message-ID: <20240415111523.2732691-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Don't pass NULL to module_object_class_by_name().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index c644222982..23e1cb016f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -992,9 +992,16 @@ static bool vga_interface_available(VGAInterfaceType t)
     const VGAInterfaceInfo *ti = &vga_interfaces[t];
 
     assert(t < VGA_TYPE_MAX);
-    return !ti->class_names[0] ||
-           module_object_class_by_name(ti->class_names[0]) ||
-           module_object_class_by_name(ti->class_names[1]);
+
+    if (!ti->class_names[0] || module_object_class_by_name(ti->class_names[0])) {
+        return true;
+    }
+
+    if (ti->class_names[1] && module_object_class_by_name(ti->class_names[1])) {
+        return true;
+    }
+
+    return false;
 }
 
 static const char *
-- 
2.41.0.28.gd7d8841f67


