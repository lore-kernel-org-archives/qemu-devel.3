Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC57C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHlA-0003wI-Bm; Tue, 18 Aug 2026 07:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHl9-0003se-2p
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHl7-0004vc-IJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNEk1n7QaEsB/EokKQrQ90XI1es9YIJRLBYftwaIuBg=;
 b=SZYH9ma/IQUiZs4YjwPWcQvx9ZQDZyuvOf3YyrnumB/I9g7YMbERK3yEjq3CfnfzPV7bEa
 +dIU4nxsMKFv8ciglS9t6QhXOBMxgbBW9vAelPwyrrF2JIh8jNP4TARSJFazbVdcuefNEe
 sGI3jvQNXpwM7t+9SsgilW9SAH8kH5Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-4ujubpflO2-_LaPadV0crg-1; Tue,
 18 Aug 2026 07:13:24 -0400
X-MC-Unique: 4ujubpflO2-_LaPadV0crg-1
X-Mimecast-MFC-AGG-ID: 4ujubpflO2-_LaPadV0crg_1787051603
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F61119560AA; Tue, 18 Aug 2026 11:13:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 348F71944DD5; Tue, 18 Aug 2026 11:13:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:33 +0400
Subject: [PATCH v3 06/74] meson: add qapi-type-infos-*.c/h to build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-6-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6uTNIwu4jC9miI8Tx4Z46QMi+uYbRrSCGCnWsQfZIEo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD23lP0Vc6DLb/RdleVCZg7bKIadVEWSJHn0e
 SEUhe6rhW+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9twAKCRDa6OEJdZac
 5b2gEACidNg0PnZl1UEnfftn/Oj5EFZ1hnztIVh8UMkZwXa8oGFCYdGd3A4a8ddgeqTdF4cfBQN
 ykRb+bhjXCA31GCC6jfa4ibM3Jk2gDmj5AZLtazqz/Z1eyZne6i1OQ6hbS60qCe88uAWdqCXC2G
 vRL83g8zaAYmVCjSIji9S1pmEhY7FWw2bbIRqxNL/fbRk5rsFdb+GalPFnyuAmgaRzyFRsTgx7/
 NhqGDKPnknIQvMNz88blxANuNGMYWXzMhGpR1641WLJ3wZCuc5fynJ+PT70EAZAntcqODW8QdZ9
 t4VRthmtVOmqHC7gAAXQj0coaiuN6C8YjZwuPAmHu6MyTMtCg6N1j6/0hHjQVqCpWUcskGORgls
 usT+muEZbSjS4kpXnUYTUpIflLquBIJEk622qd8mNAGCqS4sAZtHtXKg8GaCtVP1M/CgOL4gu24
 ta8iJAudiMn2VlVGvV7LV9y+9TW4zkjY3COrsd62bDZbsXPxi7vyrM2Djw/VxeAFduu37mN2X6d
 C56imC2OBXSqVlBvljElGeYJi6GDdZ2i7CvoSBFpsQ9Eyc/IZXlom3vpnnnwUt/7mHl8YqoqHs9
 eTlp17ZmL9fvOqxDTXpqsP3iGW9/j4n3Z1Za0PKcB7f5TFs4GSbb0L7Op4gnSSeR0/8NuA4LGb6
 Gch2hMqZUTIW/BA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the per-module type-infos output files so they are compiled into
the build.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/meson.build              | 4 ++++
 qga/meson.build               | 2 ++
 tests/include/meson.build     | 2 ++
 tests/meson.build             | 6 ++++++
 tests/qapi-schema/meson.build | 1 +
 5 files changed, 15 insertions(+)

diff --git a/qapi/meson.build b/qapi/meson.build
index a46269b5a0c9..7477953492ad 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -79,6 +79,7 @@ endif
 
 qapi_nonmodule_outputs = [
   'qapi-introspect.c', 'qapi-introspect.h',
+  'qapi-type-infos.c', 'qapi-type-infos.h',
   'qapi-types.c', 'qapi-types.h',
   'qapi-visit.h', 'qapi-visit.c',
   'qapi-commands.h', 'qapi-commands.c',
@@ -88,6 +89,7 @@ qapi_nonmodule_outputs = [
 ]
 
 qapi_outputs = qapi_nonmodule_outputs + [
+  'qapi-builtin-type-infos.c', 'qapi-builtin-type-infos.h',
   'qapi-builtin-types.c', 'qapi-builtin-visit.c',
   'qapi-builtin-types.h', 'qapi-builtin-visit.h',
 ]
@@ -96,6 +98,8 @@ qapi_inputs = []
 foreach module : qapi_all_modules
   qapi_inputs += [ files(module + '.json') ]
   qapi_module_outputs = [
+    'qapi-type-infos-@0@.c'.format(module),
+    'qapi-type-infos-@0@.h'.format(module),
     'qapi-types-@0@.c'.format(module),
     'qapi-types-@0@.h'.format(module),
     'qapi-visit-@0@.c'.format(module),
diff --git a/qga/meson.build b/qga/meson.build
index cfa2157efb23..79163b7d8e93 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -39,6 +39,8 @@ qga_qapi_outputs = [
   'qga-qapi-init-commands.h',
   'qga-qapi-introspect.c',
   'qga-qapi-introspect.h',
+  'qga-qapi-type-infos.c',
+  'qga-qapi-type-infos.h',
   'qga-qapi-types.c',
   'qga-qapi-types.h',
   'qga-qapi-visit.c',
diff --git a/tests/include/meson.build b/tests/include/meson.build
index 8e8d1ec4e692..026480d96851 100644
--- a/tests/include/meson.build
+++ b/tests/include/meson.build
@@ -4,6 +4,8 @@ test_qapi_outputs_extra = [
   'test-qapi-commands-sub-module.h',
   'test-qapi-events-sub-module.c',
   'test-qapi-events-sub-module.h',
+  'test-qapi-type-infos-sub-module.c',
+  'test-qapi-type-infos-sub-module.h',
   'test-qapi-types-sub-module.c',
   'test-qapi-types-sub-module.h',
   'test-qapi-visit-sub-module.c',
diff --git a/tests/meson.build b/tests/meson.build
index 9ba04bbedd30..71dc4ac8bf99 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -2,6 +2,8 @@ subdir('bench')
 subdir('qemu-iotests')
 
 test_qapi_outputs = [
+  'qapi-builtin-type-infos.c',
+  'qapi-builtin-type-infos.h',
   'qapi-builtin-types.c',
   'qapi-builtin-types.h',
   'qapi-builtin-visit.c',
@@ -22,6 +24,10 @@ test_qapi_outputs = [
   'test-qapi-init-commands.h',
   'test-qapi-introspect.c',
   'test-qapi-introspect.h',
+  'test-qapi-type-infos-sub-sub-module.c',
+  'test-qapi-type-infos-sub-sub-module.h',
+  'test-qapi-type-infos.c',
+  'test-qapi-type-infos.h',
   'test-qapi-types-sub-sub-module.c',
   'test-qapi-types-sub-sub-module.h',
   'test-qapi-types.c',
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index debff633ac17..392b59d8dccd 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -231,6 +231,7 @@ custom_target('QAPI doc',
                        'doc-good-qapi-events.c', 'doc-good-qapi-events.h',
                        'doc-good-qapi-init-commands.c', 'doc-good-qapi-init-commands.h',
                        'doc-good-qapi-introspect.c', 'doc-good-qapi-introspect.h',
+                       'doc-good-qapi-type-infos.c', 'doc-good-qapi-type-infos.h',
                        'doc-good-qapi-types.c', 'doc-good-qapi-types.h',
                        'doc-good-qapi-visit.c', 'doc-good-qapi-visit.h' ],
               input: files('doc-good.json'),

-- 
2.55.0.543.g5ebe2ebe4ea8


