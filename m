Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA290606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K0+rZksV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnQi-0002rI-Fr; Fri, 30 Oct 2026 10:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQH-0002Um-71
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQF-0002pW-ID
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793369854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOD6cDuPP+RwplStS1DMh0CA8/74tl5e5XAEVILvuHI=;
 b=K0+rZksVddDo5Wtm2xFqkcIRZekfoW9M27cx0mEntTxtrPUHeRPwBJJ8FjaIN6ufglBJOU
 jBQAjJggf1LIRSRJVd7QAxG6hyfHgEhbqNtsVcg38La/PcPfXxBNgDik9/1UsiVZx/i5hL
 oK7MnD7cOxgm95za+FKuc12XsM2Il7I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-idIDAu8cORe2MEbJGZt9pg-1; Fri,
 30 Oct 2026 10:17:30 -0400
X-MC-Unique: idIDAu8cORe2MEbJGZt9pg-1
X-Mimecast-MFC-AGG-ID: idIDAu8cORe2MEbJGZt9pg_1793369849
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 407821955EBA; Fri, 30 Oct 2026 14:17:29 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A00301800347; Fri, 30 Oct 2026 14:17:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 6/8] qapi: reverse arg order in compat_policy_security_ok
Date: Fri, 30 Oct 2026 14:17:11 +0000
Message-ID: <20261030141713.2841710-7-berrange@redhat.com>
In-Reply-To: <20261030141713.2841710-1-berrange@redhat.com>
References: <20261030141713.2841710-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Match the compat_policy_input_ok design more closely by having
the "relevant facts" being checked as the 2nd argument.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qapi/compat-policy.h | 2 +-
 qapi/qapi-util.c             | 2 +-
 qom/object.c                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
index b7b543ffe74..53c96ce1a26 100644
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
index 806533c7b3d..29d01653e77 100644
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
index ceb8e9eebec..30699f91279 100644
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
2.56.0


