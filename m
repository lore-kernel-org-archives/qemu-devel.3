Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7861AC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZB-0002ih-Le; Mon, 26 Feb 2024 05:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYe-0002bU-EW
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYa-0003j7-9J
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17y74wMY6sd/vutpX5ZtIbIwKMPi0TNnU7HU+eQC1L0=;
 b=cwqjVHfe7xDjfU2UljI1DnDsXThafmBjVZ3CO++GrqBXzQSm0PlK76MA7tmltuddeD4gnz
 b0V6huuk6w+ZO42ujA6013UMt1+jdG5RvYtsMJbioBmb5IQih+FzW7q00UroMtwqCi+J3x
 NSqiO8t5wauyEoFdEWF1b8fEGQuSr3w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-LxDx6wmvO2G1y8_vlz4KTw-1; Mon,
 26 Feb 2024 05:49:56 -0500
X-MC-Unique: LxDx6wmvO2G1y8_vlz4KTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABF583814E8C;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F60310800;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 86E1221E66FB; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Het Gala <het.gala@nutanix.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/17] qapi: Misc cleanups to migrate QAPIs
Date: Mon, 26 Feb 2024 11:49:38 +0100
Message-ID: <20240226104954.3781985-2-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

From: Het Gala <het.gala@nutanix.com>

Signed-off-by: Het Gala <het.gala@nutanix.com>
Message-ID: <20240216195659.189091-1-het.gala@nutanix.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/migration.json | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5a565d9b8d..5756e650b0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1728,6 +1728,7 @@
 #
 # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
+#
 # -> { "execute": "migrate",
 #      "arguments": {
 #          "channels": [ { "channel-type": "main",
@@ -1796,19 +1797,19 @@
 #
 #     3. The uri format is the same as for -incoming
 #
-#     5. For now, number of migration streams is restricted to one,
+#     4. For now, number of migration streams is restricted to one,
 #        i.e number of items in 'channels' list is just 1.
 #
-#     4. The 'uri' and 'channels' arguments are mutually exclusive;
+#     5. The 'uri' and 'channels' arguments are mutually exclusive;
 #        exactly one of the two should be present.
 #
 # Example:
 #
 # -> { "execute": "migrate-incoming",
-#      "arguments": { "uri": "tcp::4446" } }
+#      "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
 #
-# -> { "execute": "migrate",
+# -> { "execute": "migrate-incoming",
 #      "arguments": {
 #          "channels": [ { "channel-type": "main",
 #                          "addr": { "transport": "socket",
@@ -1817,7 +1818,7 @@
 #                                    "port": "1050" } } ] } }
 # <- { "return": {} }
 #
-# -> { "execute": "migrate",
+# -> { "execute": "migrate-incoming",
 #      "arguments": {
 #          "channels": [ { "channel-type": "main",
 #                          "addr": { "transport": "exec",
@@ -1825,7 +1826,7 @@
 #                                              "/some/sock" ] } } ] } }
 # <- { "return": {} }
 #
-# -> { "execute": "migrate",
+# -> { "execute": "migrate-incoming",
 #      "arguments": {
 #          "channels": [ { "channel-type": "main",
 #                          "addr": { "transport": "rdma",
-- 
2.43.0


