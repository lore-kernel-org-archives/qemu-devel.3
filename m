Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CE9CAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v292R-0006KX-5n; Fri, 26 Sep 2025 10:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292O-0006J9-Ij
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292F-0004hF-71
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KMHWRKFJ6zmbhfubCkVeb8qUpp4lSkS0Mu0MDS+kspM=;
 b=aITfaZJCDok1Oj2L8g4mkivKkakWNcp54V4/pgQf4PfPduzkbgwVpZq+x/JVvy/hl64/Qu
 T10UmF5KXlml4CG7DK1+sufTDpisIIHxZC4CvbdZo4A9Rlvf4ES4DclkEsFkFtdXlHfL2E
 FpaqUsTcGCX7VodNs3YYxEdtSvt2Eis=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-k5YBVxpBNRuUng6Uawxs4Q-1; Fri,
 26 Sep 2025 10:02:44 -0400
X-MC-Unique: k5YBVxpBNRuUng6Uawxs4Q-1
X-Mimecast-MFC-AGG-ID: k5YBVxpBNRuUng6Uawxs4Q_1758895363
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 098C6180066F; Fri, 26 Sep 2025 14:02:41 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 476C119540EB; Fri, 26 Sep 2025 14:02:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 10/32] hw/core: report security status in query-machines
Date: Fri, 26 Sep 2025 15:01:21 +0100
Message-ID: <20250926140144.1998694-11-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/machine-qmp-cmds.c | 1 +
 qapi/machine.json          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 6aca1a626e..4d9906f64a 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -100,6 +100,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         if (mc->default_ram_id) {
             info->default_ram_id = g_strdup(mc->default_ram_id);
         }
+        info->secure = object_class_is_secure(OBJECT_CLASS(mc));
 
         if (compat_props && mc->compat_props) {
             int i;
diff --git a/qapi/machine.json b/qapi/machine.json
index 038eab281c..bb2b308ccd 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -194,6 +194,11 @@
 #     present when `query-machines` argument @compat-props is true.
 #     (since 9.1)
 #
+# @secure: If true, the machine is declared to provide a security
+#     boundary from the guest; if false the machine is either
+#     not providing a security boundary, or its status is undefined.
+#     (since 10.2)
+#
 # Features:
 #
 # @unstable: Member @compat-props is experimental.
@@ -207,7 +212,8 @@
             'deprecated': 'bool', '*default-cpu-type': 'str',
             '*default-ram-id': 'str', 'acpi': 'bool',
             '*compat-props': { 'type': ['CompatProperty'],
-                               'features': ['unstable'] } } }
+                               'features': ['unstable'] },
+            'secure': 'bool' } }
 
 ##
 # @query-machines:
-- 
2.50.1


