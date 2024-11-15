Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B7AD68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC052-0004OM-M9; Fri, 15 Nov 2024 12:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04m-0004CP-UB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04l-0001XA-EN
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84cmAwRbFYPTBLNlP3GH4So0+a6lDgsXUfrxy8UhKvE=;
 b=IX5WGuXaQ1LdzT0/k6k+R6wc582PZwEindHpwbnXtiKRRvx4GUA2kF2fPhK/Wopzdg+WMZ
 lIBJl3GBjb+XJJ6SLhrEGiHAmqqH27xFHUzq+tAoZDd9o9AYRpDhsnK8mzR7GMhdU8q9Dk
 Ux1f5Blw1KKJnuIiTFE4/oSWXrvLbek=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-F1av6H7BPSG7P0Lc0s6N-w-1; Fri,
 15 Nov 2024 12:25:41 -0500
X-MC-Unique: F1av6H7BPSG7P0Lc0s6N-w-1
X-Mimecast-MFC-AGG-ID: F1av6H7BPSG7P0Lc0s6N-w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52E2A1953944
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:25:40 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 416C93003B76; Fri, 15 Nov 2024 17:25:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 6/9] qom: enforce use of static,
 const string with object_new()
Date: Fri, 15 Nov 2024 17:25:18 +0000
Message-ID: <20241115172521.504102-7-berrange@redhat.com>
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
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

Since object_new() will assert(), it should only be used in scenarios
where the caller knows exactly what type it is asking to be created,
and can thus be confident in avoiding abstract types.

Enforce this by using a macro wrapper which types to paste "" to the
type name. This will generate a compile error if not passed a static
const string, forcing callers to use object_new_dynamic() instead.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 12 +++++++++++-
 qom/object.c         |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 4fc01336c4..2d5a0d84b5 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -637,7 +637,17 @@ Object *object_new_with_class(ObjectClass *klass, Error **errp);
  *
  * Returns: The newly allocated and instantiated object.
  */
-Object *object_new(const char *typename);
+
+/*
+ * NB, object_new_internal is just an internal helper, wrapped by
+ * the object_new() macro which prevents invokation unless given
+ * a static, const string.
+ *
+ * Code should call object_new(), or object_new_dynamic(), not
+ * object_new_internal().
+ */
+Object *object_new_internal(const char *typename);
+#define object_new(typename) object_new_internal(typename "")
 
 /**
  * object_new_dynamic:
diff --git a/qom/object.c b/qom/object.c
index 42ef40a1fd..ee56710348 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -799,7 +799,8 @@ Object *object_new_with_class(ObjectClass *klass, Error **errp)
     return object_new_with_type(klass->type, errp);
 }
 
-Object *object_new(const char *typename)
+/* Only to be called via the 'object_new' macro */
+Object *object_new_internal(const char *typename)
 {
     TypeImpl *ti = type_get_or_load_by_name(typename, &error_fatal);
 
-- 
2.46.0


