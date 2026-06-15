Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7222CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4d-00033K-0F; Mon, 15 Jun 2026 16:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4c-00032x-5e
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4a-0002GO-N3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvHRxFe3/9M3A6EjGylUHZk1jWRUsW9eQVfc9KOscS0=;
 b=haqI7wyK28I2Yu27OswLAE7tkbLb1crP2Fd8Az3yhuqYG21FDUjPIG49g6DPzRmo/qaAtQ
 D9TQt+ZbtjZu6pvoaJJVlcWZSP9GynG+Fw5JoPyyhii3Jbr1Mia9R4E7fhHkuLEc//l/pT
 OPqgj7H+109soiMgtxYvxAVWDR7Zi/4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-LX-IQhroM7uun9Kor_yr_A-1; Mon,
 15 Jun 2026 16:38:16 -0400
X-MC-Unique: LX-IQhroM7uun9Kor_yr_A-1
X-Mimecast-MFC-AGG-ID: LX-IQhroM7uun9Kor_yr_A_1781555895
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A43701955D71; Mon, 15 Jun 2026 20:38:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98A6030A8; Mon, 15 Jun 2026 20:38:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:32 +0400
Subject: [PATCH v2 06/53] meson: add qapi-type-infos-*.c/h to build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-6-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3553;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cS7ulu1ICbMh1wDUayERuLbRYYPk58SNz3mbLGycoZU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKNU/tOECvlixGbrSwe7WcE4rh5j0LgvMUK0
 esd+jyslSCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijQAKCRDa6OEJdZac
 5UGBD/99xNBurF/5VshodU2JJAtIp02GK/btP3837Db070LTFPg/fDLj3DVRlAzmr2l1LLb0JZx
 eX8+GGMj3lUPPodab2TqsKZpynPSbnTJ2V9UO86TfYM4luLPIRPNbcDNWa6ihfof9ylfdTz9IOQ
 IEdbdXSIOGHJoPW/3M5ZdW7n+UGVj575dvXBMaJ7tfeIVGz9CPvMxAddy951jqFUQYr5rZ/cnRV
 rvF7XxFp8ZD/L/LCFpJxYWUL98CXSBA2elzJTzMq1tvVBX9ZTAPG+590umRNs1Xrv9djhQhwfE9
 FVY2w8Q8HLzLzcsLXyEOMW7tn5F+92bVkDCPJzE6PYYEzVDZyaBY2TLU85tvmRSaZoI6Jmo75lD
 h5Pjf/OP5LQKoAVV2geq4A/iFCmMV8zqGNIASES6c/ls1jMxX/VkjQsUGZRi6e0TMSsr7b5kgg+
 rGvo3vlqXLSA3QHjcF2Ip4AGlN/D6s9bHEorPj5uofi7TWwiPizslrGK/jY/yvxukzh/m8Oauiv
 FAP2HuD7OpGdEPPVqbqeiF4Xpq7wne9+uDkb7TqWkzA1DEC6oCn9iajc152ZVhYz8H1rCkFbYxZ
 b84aLt+t3mUmvH0ha1wSfOCZNbyy3LQWeOLcs75nR3c0a2sSIfuKbgYG1BmuglhYV2ZT5xlMHbD
 eMX43t8+SH0IEcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Register the new per-module type-infos output files so they are
generated during the QAPI code generation step and compiled into
the build.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/meson.build              | 4 ++++
 tests/include/meson.build     | 2 ++
 tests/meson.build             | 6 ++++++
 tests/qapi-schema/meson.build | 1 +
 4 files changed, 13 insertions(+)

diff --git a/qapi/meson.build b/qapi/meson.build
index a46269b5a0c..7ae3843de6e 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -80,6 +80,7 @@ endif
 qapi_nonmodule_outputs = [
   'qapi-introspect.c', 'qapi-introspect.h',
   'qapi-types.c', 'qapi-types.h',
+  'qapi-type-infos.c', 'qapi-type-infos.h',
   'qapi-visit.h', 'qapi-visit.c',
   'qapi-commands.h', 'qapi-commands.c',
   'qapi-init-commands.h', 'qapi-init-commands.c',
@@ -90,6 +91,7 @@ qapi_nonmodule_outputs = [
 qapi_outputs = qapi_nonmodule_outputs + [
   'qapi-builtin-types.c', 'qapi-builtin-visit.c',
   'qapi-builtin-types.h', 'qapi-builtin-visit.h',
+  'qapi-builtin-type-infos.c', 'qapi-builtin-type-infos.h',
 ]
 
 qapi_inputs = []
@@ -100,6 +102,8 @@ foreach module : qapi_all_modules
     'qapi-types-@0@.h'.format(module),
     'qapi-visit-@0@.c'.format(module),
     'qapi-visit-@0@.h'.format(module),
+    'qapi-type-infos-@0@.c'.format(module),
+    'qapi-type-infos-@0@.h'.format(module),
   ]
   if have_system or have_tools
     qapi_module_outputs += [
diff --git a/tests/include/meson.build b/tests/include/meson.build
index 8e8d1ec4e69..026480d9685 100644
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
index 9ba04bbedd3..71dc4ac8bf9 100644
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
index debff633ac1..b10f081554d 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -232,6 +232,7 @@ custom_target('QAPI doc',
                        'doc-good-qapi-init-commands.c', 'doc-good-qapi-init-commands.h',
                        'doc-good-qapi-introspect.c', 'doc-good-qapi-introspect.h',
                        'doc-good-qapi-types.c', 'doc-good-qapi-types.h',
+                       'doc-good-qapi-type-infos.c', 'doc-good-qapi-type-infos.h',
                        'doc-good-qapi-visit.c', 'doc-good-qapi-visit.h' ],
               input: files('doc-good.json'),
               command: [ qapi_gen, '-o', meson.current_build_dir(),

-- 
2.54.0


