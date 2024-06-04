Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DA2C27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9i-0006ex-0l; Tue, 04 Jun 2024 11:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9f-0006bz-Db
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9d-0001Hs-Qt
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhJGSDZ4EPSyDcTb/UIgC5oAmgl4HhjH70MRGxKNRxY=;
 b=M8uRtmoBPhspYrNVuSCsbwmekBibtWC3h49nzkPy76D44zsfoebvI7gqtfsD+hlDR7cXX6
 aDbyAMYvolnllKBX9ofKjQKfMP93vqll5BBgdlmRIs7aVyHhiZ8jzwT8+tw0GW6QMkSi0Q
 GXggpx1SuQECYe72URlpi2ye+lgafkU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-sWAXfsigPTayNG6KmBO86Q-1; Tue,
 04 Jun 2024 11:32:51 -0400
X-MC-Unique: sWAXfsigPTayNG6KmBO86Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1186A3801F4A;
 Tue,  4 Jun 2024 15:32:51 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40A00492BD6;
 Tue,  4 Jun 2024 15:32:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 06/14] qapi: define enum for custom special features on
 commands
Date: Tue,  4 Jun 2024 16:32:34 +0100
Message-ID: <20240604153242.251334-7-berrange@redhat.com>
In-Reply-To: <20240604153242.251334-1-berrange@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to register custom special features against a command,
they have to have enum constants defined. The defined constant
values start where the last built-in special feature stops.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qapi/util.h      |  2 ++
 scripts/qapi/commands.py | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index 7698e789a9..3c3c9e401c 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -14,6 +14,8 @@
 typedef enum {
     QAPI_FEATURE_DEPRECATED,
     QAPI_FEATURE_UNSTABLE,
+
+    QAPI_FEATURE_BUILT_IN_LAST,
 } QapiSpecialFeature;
 
 typedef struct QEnumLookup {
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 79951a841f..50a60968d4 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -347,7 +347,27 @@ def visit_begin(self, schema: QAPISchema) -> None:
         self._add_module('./init', ' * QAPI Commands initialization')
         self._genh.add(mcgen('''
 #include "qapi/qmp/dispatch.h"
+'''))
+
+        features = schema._custom_special_features['command']
+        if len(features) > 0:
+            self._genh.add(mcgen('''
+
+typedef enum {
+'''))
+            suffix = " = QAPI_FEATURE_BUILT_IN_LAST"
+            for f in features:
+                self._genh.add(mcgen('''
+    QAPI_FEATURE_%(name)s%(suffix)s,
+''', suffix=suffix, name=f.upper().replace('-', '_')))
+                suffix = ""
 
+            self._genh.add(mcgen('''
+} QapiSpecialFeatureCustom;
+
+'''))
+
+        self._genh.add(mcgen('''
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
                              c_prefix=c_name(self._prefix, protect=False)))
-- 
2.45.1


