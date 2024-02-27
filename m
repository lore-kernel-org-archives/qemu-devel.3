Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2E4C54E51
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 11:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revoA-00006h-Th; Tue, 27 Feb 2024 06:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revo8-000064-TT
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1revo0-0005Ud-3x
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 06:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709033967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yP+4dHnTw39PPS2vNQeNibBeQst0CddquIapG5UlmEc=;
 b=FV/PwWWOuVwCCyiV09/BLuUH4ngJY524+iTvOFPA8q8RKSNPlRgNw/+SzCVpLdI3lZmaiS
 YQvQw9byXcJuy0TpY/qrv6zOyl+AKZu02jskMLX/YKt361xJnb9dmtcBm0m6FNtbFx0Ofe
 w50xNovtD4IXhMta+XFwex/cnOj5N+I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-qTiXllKVM8KF1jzPaStIGQ-1; Tue,
 27 Feb 2024 06:39:23 -0500
X-MC-Unique: qTiXllKVM8KF1jzPaStIGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FE021C05AAB;
 Tue, 27 Feb 2024 11:39:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D46C40166A5;
 Tue, 27 Feb 2024 11:39:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40AF421E60F5; Tue, 27 Feb 2024 12:39:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 kkostiuk@redhat.com
Subject: [PATCH 08/13] qga/qapi-schema: Move error documentation to new
 "Errors" sections
Date: Tue, 27 Feb 2024 12:39:16 +0100
Message-ID: <20240227113921.236097-9-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-1-armbru@redhat.com>
References: <20240227113921.236097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b8efe31897..c5f2ac8f59 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -561,9 +561,8 @@
 # could also exit (or set its status to "shutdown") due to other
 # reasons.
 #
-# The following errors may be returned:
-#
-# - If suspend to disk is not supported, Unsupported
+# Errors:
+#     - If suspend to disk is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command
 #     before sending commands when the guest resumes
@@ -598,9 +597,8 @@
 # 2. Issue the query-status QMP command to confirm the VM status is
 #    "suspended"
 #
-# The following errors may be returned:
-#
-# - If suspend to ram is not supported, Unsupported
+# Errors:
+#     - If suspend to ram is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command
 #     before sending commands when the guest resumes
@@ -634,9 +632,8 @@
 # 2. Issue the query-status QMP command to confirm the VM status is
 #    "suspended"
 #
-# The following errors may be returned:
-#
-# - If hybrid suspend is not supported, Unsupported
+# Errors:
+#     - If hybrid suspend is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command
 #     before sending commands when the guest resumes
@@ -796,9 +793,6 @@
 #     - 0:
 #       if the @vcpus list was empty on input.  Guest state has not
 #       been changed.  Otherwise,
-#     - Error:
-#       processing the first node of @vcpus failed for the reason
-#       returned.  Guest state has not been changed.  Otherwise,
 #     - < length(@vcpus):
 #       more than zero initial nodes have been processed, but not the
 #       entire @vcpus list.  Guest state has changed accordingly.  To
@@ -808,6 +802,10 @@
 #     - length(@vcpus):
 #       call successful.
 #
+# Errors:
+#     - If the reconfiguration of the first node in @vcpus failed.
+#       Guest state has not been changed.
+#
 # Since: 1.5
 ##
 { 'command': 'guest-set-vcpus',
-- 
2.43.0


