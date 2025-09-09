Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6577FCAC589
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1fk-0006QD-2p; Tue, 09 Sep 2025 12:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fN-0006GW-L6
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fK-0007bt-L8
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757437075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=reeHWg5i9UC3bmZs64SCWX3539n4gk5y3JvHWF0QkQk=;
 b=BWoU8pnbMrnWIuNUhytK0U+G0CaozxV8m0qlHiksfJPoDXnfk4+mzkDgxxNoat+E7hfvZc
 iEX55tLzJ5cGrJiBC/bdeVCzIEzD2m3uhHT22ii77pHuYVuc+Hx1nG+rxgdFWdZHGfki3I
 +DOb9R4DlWU2K+o176W5YtyPdQH103g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-etfenAe3MPe4JbSWIi66FQ-1; Tue,
 09 Sep 2025 12:57:54 -0400
X-MC-Unique: etfenAe3MPe4JbSWIi66FQ-1
X-Mimecast-MFC-AGG-ID: etfenAe3MPe4JbSWIi66FQ_1757437073
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D1AB180047F; Tue,  9 Sep 2025 16:57:53 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5D671800446; Tue,  9 Sep 2025 16:57:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/15] hw/core: report secure/insecure status in query-machines
Date: Tue,  9 Sep 2025 17:57:19 +0100
Message-ID: <20250909165726.3814465-9-berrange@redhat.com>
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/core/machine-qmp-cmds.c | 2 ++
 qapi/machine.json          | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 6aca1a626e..4ef2d06d32 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -100,6 +100,8 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         if (mc->default_ram_id) {
             info->default_ram_id = g_strdup(mc->default_ram_id);
         }
+        info->secure = object_class_is_secure(OBJECT_CLASS(mc));
+        info->insecure = object_class_is_insecure(OBJECT_CLASS(mc));
 
         if (compat_props && mc->compat_props) {
             int i;
diff --git a/qapi/machine.json b/qapi/machine.json
index 038eab281c..ff1f9bf076 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -194,6 +194,12 @@
 #     present when `query-machines` argument @compat-props is true.
 #     (since 9.1)
 #
+# @secure: If true, the machine is declared to provide a security
+#     boundary from the guest; if false the status is undefined.
+#
+# @insecure: If true, the machine is declared to NOT provide a security
+#     boundary from the guest; if false the status is undefined.
+#
 # Features:
 #
 # @unstable: Member @compat-props is experimental.
@@ -207,7 +213,8 @@
             'deprecated': 'bool', '*default-cpu-type': 'str',
             '*default-ram-id': 'str', 'acpi': 'bool',
             '*compat-props': { 'type': ['CompatProperty'],
-                               'features': ['unstable'] } } }
+                               'features': ['unstable'] },
+            'secure': 'bool', 'insecure': 'bool' } }
 
 ##
 # @query-machines:
-- 
2.50.1


