Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603516087A36
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EdjS1b2K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtEC-00044I-Ol; Mon, 02 Nov 2026 09:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDA-0003Cx-Gf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD6-0008S1-DG
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ok4YTAFMKrXKggBO/aC5h4edgAB8BP+176APe+RvX2U=;
 b=EdjS1b2KZRgOSxToxVGpkMzZszbPgFJIJNfKzNHA6ljJYJja8MPg4on6Srtyi2ikspGVhb
 w39BoLHwaEANVpnFl9KqWDEqFMBBLdGIB4BRQxmhwuLiNavd3YoNx/U6ZSc0lDrYZ8jR8c
 sQn4WSluZhD1MckG049HWUrY8uyHgk0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-zfJ8Ul6RN6q9Jj2fR0R9Jw-1; Mon,
 02 Nov 2026 09:40:28 -0500
X-MC-Unique: zfJ8Ul6RN6q9Jj2fR0R9Jw-1
X-Mimecast-MFC-AGG-ID: zfJ8Ul6RN6q9Jj2fR0R9Jw_1793630427
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48EC2180A9DA; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09C695BC; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A4A421E6893; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 15/74] qapi: reverse arg order in compat_policy_security_ok
Date: Mon,  2 Nov 2026 15:39:19 +0100
Message-ID: <20261102144018.3212223-16-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Daniel P. Berrangé <berrange@redhat.com>

Match the compat_policy_input_ok design more closely by having
the "relevant facts" being checked as the 2nd argument.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20261030141713.2841710-7-berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/compat-policy.h | 2 +-
 qapi/qapi-util.c             | 2 +-
 qom/object.c                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
index b7b543ffe7..53c96ce1a2 100644
--- a/include/qapi/compat-policy.h
+++ b/include/qapi/compat-policy.h
@@ -25,8 +25,8 @@ bool compat_policy_input_ok(const CompatPolicy *policy,
                             Error **errp);
 
 bool compat_policy_security_ok(const CompatPolicy *policy,
-                               const char *typename,
                                bool is_secure,
+                               const char *typename,
                                Error **errp);
 
 /*
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 806533c7b3..29d01653e7 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -65,8 +65,8 @@ bool compat_policy_input_ok(const CompatPolicy *policy,
 }
 
 bool compat_policy_security_ok(const CompatPolicy *policy,
-                               const char *typename,
                                bool is_secure,
+                               const char *typename,
                                Error **errp)
 {
     ERRP_GUARD();
diff --git a/qom/object.c b/qom/object.c
index ceb8e9eebe..30699f9127 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3277,8 +3277,8 @@ void object_class_property_set_description(ObjectClass *klass,
 bool object_class_check_security(ObjectClass *klass, Error **errp)
 {
     return compat_policy_security_ok(&compat_policy,
-                                     object_class_get_name(klass),
                                      object_class_is_secure(klass),
+                                     object_class_get_name(klass),
                                      errp);
 }
 
-- 
2.55.0


