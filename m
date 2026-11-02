Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F360703B5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NpyJhV+l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDc-0003QL-Gf; Mon, 02 Nov 2026 09:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD5-0003Bu-9l
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD3-0008Q7-FW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GV5CZqebP/VpiQ6tYNOvrerKYMSDFf96jRCYs+9ffFQ=;
 b=NpyJhV+lxPq1Vg9o0yZAfjzM/hJVGNcngd8rHCzQ5ReNbJGWUvkD5FGiejiqY63RJzkEeo
 H65BnwqfBwpGTPD0iCx8VN8z5kUaWg5sdJGJ1PXUwZlmuiopyQ5kPDifWRehawg+S9PsTE
 eRxuBMyWc30w3UE5DwfgjdY+4Y3+1TQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-afUM_U4qOeSdR6PCM3bcSw-1; Mon,
 02 Nov 2026 09:40:25 -0500
X-MC-Unique: afUM_U4qOeSdR6PCM3bcSw-1
X-Mimecast-MFC-AGG-ID: afUM_U4qOeSdR6PCM3bcSw_1793630424
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F431180A8FC; Mon,  2 Nov 2026 14:40:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E5975BC; Mon,  2 Nov 2026 14:40:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1025D21E6888; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 09/74] rng: Remove deprecated "rng-backend" property "opened"
Date: Mon,  2 Nov 2026 15:39:13 +0100
Message-ID: <20261102144018.3212223-10-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This property was deprecated in commit 6815bc1d03c (qapi/qom: Add
ObjectOptions for rng-*, deprecate 'opened') in v6.0.0.  Commit
6e577937485 (rng: make opened property read-only) in v7.1.0 made it
read-only, and also moved the its entry from docs/about/deprecated.rst
to docs/about/removed-features.rst.  I have no idea why it made the
property read-only instead of dropping it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261028152612.953491-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 qapi/qom.json  | 22 ----------------------
 backends/rng.c | 11 -----------
 2 files changed, 33 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 4810d53e58..2a98b1de5f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -925,25 +925,6 @@
   'data': { 'pci-bus': 'str',
             'node': 'uint32' } }
 
-##
-# @RngProperties:
-#     Properties for objects of classes derived from rng.
-#
-# @opened: if true, the device is opened immediately when applying
-#     this option and will probably fail when processing the next
-#     option.  Don't use; only provided for compatibility.
-#     (default: false)
-#
-# Features:
-#
-# @deprecated: Member @opened is deprecated.  Setting true doesn't
-#     make sense, and false is already the default.
-#
-# Since: 1.3
-##
-{ 'struct': 'RngProperties',
-  'data': { '*opened': { 'type': 'bool', 'features': ['deprecated'] } } }
-
 ##
 # @RngEgdProperties:
 #     Properties for rng-egd objects.
@@ -954,7 +935,6 @@
 # Since: 1.3
 ##
 { 'struct': 'RngEgdProperties',
-  'base': 'RngProperties',
   'data': { 'chardev': 'str' } }
 
 ##
@@ -967,7 +947,6 @@
 # Since: 1.3
 ##
 { 'struct': 'RngRandomProperties',
-  'base': 'RngProperties',
   'data': { '*filename': 'str' },
   'if': 'CONFIG_POSIX' }
 
@@ -1372,7 +1351,6 @@
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
-      'rng-builtin':                'RngProperties',
       'rng-egd':                    'RngEgdProperties',
       'rng-random':                 { 'type': 'RngRandomProperties',
                                       'if': 'CONFIG_POSIX' },
diff --git a/backends/rng.c b/backends/rng.c
index bc9c7a5ab3..08d57e47ab 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -41,13 +41,6 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
     }
 }
 
-static bool rng_backend_prop_get_opened(Object *obj, Error **errp)
-{
-    RngBackend *s = RNG_BACKEND(obj);
-
-    return s->opened;
-}
-
 static void rng_backend_complete(UserCreatable *uc, Error **errp)
 {
     RngBackend *s = RNG_BACKEND(uc);
@@ -123,10 +116,6 @@ static void rng_backend_class_init(ObjectClass *oc, const void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = rng_backend_complete;
-
-    object_class_property_add_bool(oc, "opened",
-                                   rng_backend_prop_get_opened,
-                                   NULL);
 }
 
 static const TypeInfo rng_backend_info = {
-- 
2.55.0


