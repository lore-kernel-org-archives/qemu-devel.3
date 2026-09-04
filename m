Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E5FC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3o-00067E-7c; Fri, 04 Sep 2026 15:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3b-0005eU-As
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3Z-0007rg-6h
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpvgvOGWVo9OxK8Ei1cqCyXxJf4Q/kyOC4bgNsQxy+M=;
 b=Mc/TOoW0GxQCVDYw5B7vLbwnxfzvpyiOiWgDy4FvsnTYCcp8+5hV/T3xLvAUBLYmz7R5x0
 8G7KznIo/D5JdyH8GMhnydjdsNZo0iQcimIK6q5ROBvehA6YXAVkdJXpCsmXquQ7raR11l
 frEqg3OdZWqcxYjA12LHGSnOPrOT4sU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-nYZ3eszoOPafbUYov-321Q-1; Fri,
 04 Sep 2026 15:58:31 -0400
X-MC-Unique: nYZ3eszoOPafbUYov-321Q-1
X-Mimecast-MFC-AGG-ID: nYZ3eszoOPafbUYov-321Q_1788551910
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5611E188699A; Fri,  4 Sep 2026 19:58:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 784391800641; Fri,  4 Sep 2026 19:58:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:49 +0400
Subject: [PATCH v4 06/75] meson: add qapi-type-infos-*.c/h to build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-6-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3972;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OQFWobNHBlEQPo20iMGdvqBz5u3E9h6m3axk+nNGjfM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLIg8b6JICpWOLx8ovqDK0g9vzSjl+4X54AO
 tiZ1Iqt23KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyAAKCRDa6OEJdZac
 5c7JD/9xF/O9+PteGv7paNx+bX96G1qJaVeHchxndbb07A2WXZRainTzFtAHoteR3d+1B2XkPJN
 +EJDRk+dSinWxWnQalvH5laV7zZQ76p24whOOjrUUjUkFHWJhpowkLo30NFcFqYNvi0vl5db0Zi
 mrGfBXhrfto4J+p70MoV+OD83XqsYIk2J8EfYF8h1AOc/e27tmZr+5mt8Anv+n552AitiutAKVw
 /RSKW+Nv4L+GocBk9rDNQMJG2xkE/ZzuDoDu1Zt7nlwqew49+arObsZJCyIpwx/ImMK4vgf6Zg4
 bDYSiXFB7Co0gt/poLVyMrAZTQRlHMqWTwbLA/EuIk4xCNIeJhOk1BDCo4EEJCf+d1HyllWaNTE
 hkbysYB1LK2Z86VTXoWzODLl7DaMa3YgxwmMpd3FuUdReg1eQIFeV7+RvvHE9yancs+3KfDqF4g
 U3k9Nbtbc0RNiSnx1ClqVVnacmyPfNiryWrhoOToGQ5HOT+imKyq5zJVzNuOdQphT5Hph7YQ+Wz
 wS1NXvYRu1GaLVX3YWXeKgKqzPM97KoG+2EJY6EMpzufDYllbwcvapnHYVRekgpIwp+rg9riil8
 LGhyPZpjnQEjsOzLdFAQCNcIUeHHCEwMZgrYQTgHuRAY4rUPYSvWnG4QZuDcqsmRxonFSCILnwW
 nCu25X97RsHr79w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
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


