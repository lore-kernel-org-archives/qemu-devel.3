Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E9FE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCWr-0005N4-6S; Tue, 07 Jan 2025 11:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tVCWq-0005K2-HM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:34:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tVCWo-0003x1-6H
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736267641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgJ21ZMa9nqS4ql2OaI1/AlduvKHGINBG4bHCB/ONbs=;
 b=eZCvZ00QsIpnLwGUo6xrRZOxLmAUrPJ0dw+vFQr5ctW6w94fpBQ6zPaVtxFxq2FAIcU7Zj
 NKa3Whqh+Qj5kJ2l942o/xC8/rLPSxz8vU/V4r2+ile0hm6p/hOAS5YFWC2RaUzR4ARfvk
 BkfXQp1IOO0N+QwuvOWHvKv/uKdl680=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-rliyqgLYObmfqHQNHSvt-A-1; Tue,
 07 Jan 2025 11:32:34 -0500
X-MC-Unique: rliyqgLYObmfqHQNHSvt-A-1
X-Mimecast-MFC-AGG-ID: rliyqgLYObmfqHQNHSvt-A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F9C81955EA6; Tue,  7 Jan 2025 16:32:33 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.45.226.131])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A54B195606B; Tue,  7 Jan 2025 16:32:30 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/2] tests/qtest: Introduce
 qtest_init_with_env_and_capabilities()
Date: Tue,  7 Jan 2025 17:31:53 +0100
Message-ID: <20250107163156.310226-2-jmarcin@redhat.com>
In-Reply-To: <20250107163156.310226-1-jmarcin@redhat.com>
References: <20250107163156.310226-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This patch adds a new version of qtest_init_with_env() that allows
specifying QMP capabilities that should be enabled during handshake.
This is useful for example if a test needs out-of-band execution of QMP
commands, it can initialize with the oob capability.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 tests/qtest/libqtest.c | 18 ++++++++++++++++--
 tests/qtest/libqtest.h | 17 +++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 8de5f1fde3..00dc01a851 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -543,7 +543,9 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
 }
 
-QTestState *qtest_init_with_env(const char *var, const char *extra_args)
+QTestState *qtest_init_with_env_and_capabilities(const char *var,
+                                                 const char *extra_args,
+                                                 QList *capabilities)
 {
     QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
     QDict *greeting;
@@ -551,11 +553,23 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args)
     /* Read the QMP greeting and then do the handshake */
     greeting = qtest_qmp_receive(s);
     qobject_unref(greeting);
-    qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
+    if (capabilities) {
+        qtest_qmp_assert_success(s,
+                                 "{ 'execute': 'qmp_capabilities', "
+                                 "'arguments': { 'enable': %p } }",
+                                 qobject_ref(capabilities));
+    } else {
+        qtest_qmp_assert_success(s, "{ 'execute': 'qmp_capabilities' }");
+    }
 
     return s;
 }
 
+QTestState *qtest_init_with_env(const char *var, const char *extra_args)
+{
+    return qtest_init_with_env_and_capabilities(var, extra_args, NULL);
+}
+
 QTestState *qtest_init(const char *extra_args)
 {
     return qtest_init_with_env(NULL, extra_args);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f23d80e9e5..1d0d5e7c29 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -19,6 +19,7 @@
 
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 #include "libqmp.h"
 
 typedef struct QTestState QTestState;
@@ -68,6 +69,22 @@ QTestState *qtest_init(const char *extra_args);
  */
 QTestState *qtest_init_with_env(const char *var, const char *extra_args);
 
+/**
+ * qtest_init_with_env_and_capabilities:
+ * @var: Environment variable from where to take the QEMU binary
+ * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
+ * arguments are subject to word splitting and shell evaluation.
+ * @capabilities: list of QMP capabilities (strings) to enable
+ *
+ * Like qtest_init_with_env(), but enable specified capabilities during
+ * hadshake.
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_init_with_env_and_capabilities(const char *var,
+                                                 const char *extra_args,
+                                                 QList *capabilities);
+
 /**
  * qtest_init_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
-- 
2.47.1


