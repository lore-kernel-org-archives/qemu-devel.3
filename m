Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB879CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2925-000677-4Z; Fri, 26 Sep 2025 10:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2920-00065p-Ac
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v291r-0004dM-6R
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKzFFvyHLWYmqldd383NxM2/sd6JX0++BsSoQsWwnYw=;
 b=DezQ4A/tUN5EO5Kyx6YKL90pGCkkEmIW7LT0VqoxVYvMpK73Z3uEq6zbummUCtSvuW0xxz
 nA0Xnz13XsB5+grRTio7nEWO1a2EWfKl/1K17uLRxmJNDRgxhvAJvl/PaVJXJwsQyyfVcX
 2BccdMYC3KA3LL1d+V0I6fCamz4K/TM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-Y2t4IU_-MGSfdhQajVC_hg-1; Fri,
 26 Sep 2025 10:02:19 -0400
X-MC-Unique: Y2t4IU_-MGSfdhQajVC_hg-1
X-Mimecast-MFC-AGG-ID: Y2t4IU_-MGSfdhQajVC_hg_1758895338
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E2CD195608A; Fri, 26 Sep 2025 14:02:18 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F78B1956095; Fri, 26 Sep 2025 14:02:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 06/32] system: check security for machine types
Date: Fri, 26 Sep 2025 15:01:17 +0100
Message-ID: <20250926140144.1998694-7-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This wires up the machine creation code to apply the compat policy
security check.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 38c6caf524..716bf6d490 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2182,10 +2182,19 @@ static void qemu_create_machine_containers(Object *machine)
     }
 }
 
-static void qemu_create_machine(QDict *qdict)
+static int qemu_create_machine(QDict *qdict)
 {
     MachineClass *machine_class = select_machine(qdict, &error_fatal);
     object_set_machine_compat_props(machine_class->compat_props);
+    Error *local_err;
+
+    if (!compat_policy_check_security(&compat_policy,
+                                      object_class_get_name(OBJECT_CLASS(machine_class)),
+                                      object_class_is_secure(OBJECT_CLASS(machine_class)),
+                                      &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
 
     current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
     object_property_add_child(object_get_root(), "machine",
@@ -2222,6 +2231,8 @@ static void qemu_create_machine(QDict *qdict)
                                           false, &error_abort);
         qobject_unref(default_opts);
     }
+
+    return 0;
 }
 
 static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
@@ -3763,7 +3774,9 @@ void qemu_init(int argc, char **argv)
     /* Transfer QemuOpts options into machine options */
     parse_memory_options();
 
-    qemu_create_machine(machine_opts_dict);
+    if (qemu_create_machine(machine_opts_dict) < 0) {
+        exit(1);
+    }
 
     /*
      * Load incoming CPR state before any devices are created, because it
-- 
2.50.1


