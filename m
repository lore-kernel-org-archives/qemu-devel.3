Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3F606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XXedvyib
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIr-0008Jy-8x; Thu, 26 Nov 2026 05:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIc-00089B-IX
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIa-0006hw-4E
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8ZfPsTzlEywQxBFFKzUXoUyMAcXG+LYbi1mqOz0UqU=;
 b=XXedvyibFocEiOpXAKTM6rGalPw8ca73m6fl0rTo7ZLjfd0QLs8xRC90rS2Kco1esZtom1
 ToTZ/TOpMYYKFhhNe8452umPRwvUoS68ME8CIS/AjsJkrGsqxj77VxVVHFMetcLIPj20JA
 trFJwSSeHY/0nKC1feJV8fXPdDMq4nQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-EykYhh2ePDqnOxsS9YR2yg-1; Thu,
 26 Nov 2026 10:01:46 +0000
X-MC-Unique: EykYhh2ePDqnOxsS9YR2yg-1
X-Mimecast-MFC-AGG-ID: EykYhh2ePDqnOxsS9YR2yg_1795687305
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7582F1955EBF; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C2A018011D9; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D090C21E6885; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 06/16] qom: Simplify object_resolve_link()
Date: Thu, 26 Nov 2026 11:01:29 +0100
Message-ID: <20261126100139.3557890-7-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

object_resolve_link() finds the property, then extracts the QOM type
from its member @type.  @type must be like "link<T>", or else the
extraction produces crap, and may read beyond the buffer.  This is
actually ensured by the users of object_set_link_property().

Simpler: use new member @qom_type instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 47e5979aa06..14fd2f3d17e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2010,14 +2010,10 @@ Object *object_resolve_and_typecheck(const char *path, const char *name,
 static Object *object_resolve_link(Object *obj, const char *name,
                                    const char *path, Error **errp)
 {
-    const char *type;
-    g_autofree char *target_type = NULL;
+    ObjectProperty *prop = object_property_find(obj, name);
 
-    /* Go from link<FOO> to FOO.  */
-    ObjectProperty *prop = object_property_find_err(obj, name, NULL);
-    type = prop ? prop->type : NULL;
-    target_type = g_strndup(&type[5], strlen(type) - 6);
-    return object_resolve_and_typecheck(path, name, target_type, errp);
+    assert(prop->qom_type);
+    return object_resolve_and_typecheck(path, name, prop->qom_type, errp);
 }
 
 static void object_set_link_property(Object *obj, Visitor *v,
-- 
2.55.0


