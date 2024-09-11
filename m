Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5010EE49B8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOLZ-000706-2U; Wed, 11 Sep 2024 10:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soOLT-0006dw-Pc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soOLR-0003ji-U1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726064961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWqhNUxKNuGKSWjcQvj0wVltCiBkhO0mamxyGZql5nY=;
 b=i3iR8U12JKNQqBb6AlYNTLTw6Mz8F2+iFPd4Bp8Zxr2NVsN3Pq3NsWKUsGHYcLkKaCMW40
 qlgSzi1wlX2bnE1+pTgMOgnnfYxq+Z/0vyf1kqs4PuspF0ft3SVExHIf1DKYv8v16PEGWs
 2bWVAlpRXEISw0vqErUQKQBKwiFIgMU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-gd4NsPC0O3eslrhjYJb64g-1; Wed,
 11 Sep 2024 09:12:10 -0400
X-MC-Unique: gd4NsPC0O3eslrhjYJb64g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B1AD1944D24; Wed, 11 Sep 2024 13:12:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 893C219560AD; Wed, 11 Sep 2024 13:12:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F49221E692E; Wed, 11 Sep 2024 15:12:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com, eblake@redhat.com,
 philmd@linaro.org
Subject: [PATCH 2/2] qga: Improve error for guest-set-user-password parameter
 @crypted
Date: Wed, 11 Sep 2024 15:12:06 +0200
Message-ID: <20240911131206.2503035-3-armbru@redhat.com>
In-Reply-To: <20240911131206.2503035-1-armbru@redhat.com>
References: <20240911131206.2503035-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The Windows version of guest-set-user-password rejects argument
"crypted": true with the rather useless "this feature or command is
not currently supported".  Improve to "'crypted' must be off on this
host".

QERR_UNSUPPORTED is now unused.  Drop.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 qga/commands-win32.c      | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 38e89762b3..101c1141b9 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -26,7 +26,4 @@
 #define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
     "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 ", maximum: %" PRId64 ")"
 
-#define QERR_UNSUPPORTED \
-    "this feature or command is not currently supported"
-
 #endif /* QERROR_H */
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 61b36da469..038beb8cfa 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1914,7 +1914,7 @@ void qmp_guest_set_user_password(const char *username,
     GError *gerr = NULL;
 
     if (crypted) {
-        error_setg(errp, QERR_UNSUPPORTED);
+        error_setg(errp, "'crypted' must be off on this host");
         return;
     }
 
-- 
2.46.0


