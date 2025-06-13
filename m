Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C921C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 20:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQBAN-000466-4y; Fri, 13 Jun 2025 16:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQBAA-0003tf-8D
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQBA7-0005Dk-1P
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749847086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76iyyado/uvyqBCNM7R0Z24ucUbX3ISueunVKQljCRQ=;
 b=fUL3Dj6tSXSCx6qL3Z5s9D5gSUzGL4uzGtjyArzUJD3G69IqePhJZgXT8scJ6YsCSzKKxe
 g+QHBU9B17+ag4XIy3tN0Vjex/6ouk8yTJcOK5N8ZaN3hJnRpOg83fW2UNgRKJWm7M0zpL
 Hmm5gMy1pyAlCg/VgjETBS1Yyna/ZeM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-h0U22dqkOqi2OT_mvKphlQ-1; Fri,
 13 Jun 2025 16:38:00 -0400
X-MC-Unique: h0U22dqkOqi2OT_mvKphlQ-1
X-Mimecast-MFC-AGG-ID: h0U22dqkOqi2OT_mvKphlQ_1749847078
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2BB4195608E; Fri, 13 Jun 2025 20:37:58 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.203])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AA2530044CC; Fri, 13 Jun 2025 20:37:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 12/18] qapi: add cross-references to replay.json
Date: Fri, 13 Jun 2025 16:36:14 -0400
Message-ID: <20250613203620.1283814-13-jsnow@redhat.com>
In-Reply-To: <20250613203620.1283814-1-jsnow@redhat.com>
References: <20250613203620.1283814-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/replay.json | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index 35e0c4a6926..78244a9d0bf 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -47,8 +47,8 @@
 # @query-replay:
 #
 # Retrieve the record/replay information.  It includes current
-# instruction count which may be used for @replay-break and
-# @replay-seek commands.
+# instruction count which may be used for `replay-break` and
+# `replay-seek` commands.
 #
 # Returns: record/replay information.
 #
@@ -70,7 +70,7 @@
 # breakpoint.  When breakpoint is set, any prior one is removed.  The
 # breakpoint may be set only in replay mode and only "in the future",
 # i.e. at instruction counts greater than the current one.  The
-# current instruction count can be observed with @query-replay.
+# current instruction count can be observed with `query-replay`.
 #
 # @icount: instruction count to stop at
 #
@@ -86,7 +86,7 @@
 ##
 # @replay-delete-break:
 #
-# Remove replay breakpoint which was set with @replay-break.  The
+# Remove replay breakpoint which was set with `replay-break`.  The
 # command is ignored when there are no replay breakpoints.
 #
 # Since: 5.2
@@ -106,7 +106,7 @@
 # snapshot and replays the execution to find the desired instruction.
 # When there is no preceding snapshot or the execution is not
 # replayed, then the command fails.  Instruction count can be obtained
-# with the @query-replay command.
+# with the `query-replay` command.
 #
 # @icount: target instruction count
 #
-- 
2.48.1


