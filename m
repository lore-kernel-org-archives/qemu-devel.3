Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DBACCF2E6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoFt-00051x-2n; Mon, 19 Oct 2026 10:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDI-0002CO-1Y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDF-0005YD-6c
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJ1eLIGnHKy+gXlXf2CnMi8O+od4difFXQmYs9GMxFI=;
 b=JucssrHnK6ajpNkpKZYnDGXm3oieeAPwYVCcgqMNIoApeWp1D5DKzKjtdrQiDp0LBBPzGW
 dYvQwvWMrUVvCO6L07seeffgPPqhJxHzUpoEPtJAvHdJKS81EW89vUpxB0l397gF0BGpbw
 20YAdyBEMu1h7P/BJxpn+RNeulHd1X0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-yS_nUGjQP5uqkehz1_lxIw-1; Mon,
 19 Oct 2026 14:19:37 +0000
X-MC-Unique: yS_nUGjQP5uqkehz1_lxIw-1
X-Mimecast-MFC-AGG-ID: yS_nUGjQP5uqkehz1_lxIw_1792419575
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 675721955EAB; Mon, 19 Oct 2026 14:19:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E92A51956049; Mon, 19 Oct 2026 14:19:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 95BB721E688A; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 10/65] meson: add qapi-type-infos-*.c/h to build
Date: Mon, 19 Oct 2026 16:18:34 +0200
Message-ID: <20261019141929.1594337-11-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add the per-module type-infos output files so they are compiled into
the build.

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/meson.build              | 4 ++++
 qga/meson.build               | 2 ++
 tests/include/meson.build     | 2 ++
 tests/meson.build             | 6 ++++++
 tests/qapi-schema/meson.build | 1 +
 5 files changed, 15 insertions(+)

diff --git a/qapi/meson.build b/qapi/meson.build
index a46269b5a0..7477953492 100644
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
index cfa2157efb..79163b7d8e 100644
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
index 8e8d1ec4e6..026480d968 100644
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
index 5877d2f60b..6769a1e781 100644
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
index debff633ac..392b59d8dc 100644
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
2.55.0


