Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABFAC83F2E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKoW-0007qC-2Q; Mon, 14 Jul 2025 11:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUn-0000PY-LI
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUX-0003cy-TI
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQany7602cwLKYa/ySwmxe9NmT2lIVHLTjR92nw3ndQ=;
 b=Et9YVTbsapcwEBD2VffAE3Ukln4LGHO8rina25nc8N51kjTiit7+RTiOEdkJ18ngxXnYdY
 RjcluWYZiO+qKGrW1zjtC8RLUP/byO6+7nViy0iysgJilM6elcfE/7dejYY3w9Gh7WqJA0
 xupjOb+vckkGkbA9Cd1+m0JQGlsibyw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-JdFhb3PQMAutUKbxfmM7pw-1; Mon,
 14 Jul 2025 09:45:09 -0400
X-MC-Unique: JdFhb3PQMAutUKbxfmM7pw-1
X-Mimecast-MFC-AGG-ID: JdFhb3PQMAutUKbxfmM7pw_1752500708
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E99D1955F42
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40E19180045C
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DEEC21E65D0; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 23/32] qapi: add cross-references to replay.json
Date: Mon, 14 Jul 2025 15:44:49 +0200
Message-ID: <20250714134458.2991097-24-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711054005.60969-13-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/replay.json | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index e46c5c1d3f..ccf84da68e 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -49,8 +49,8 @@
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
@@ -72,7 +72,7 @@
 # breakpoint.  When breakpoint is set, any prior one is removed.  The
 # breakpoint may be set only in replay mode and only "in the future",
 # i.e. at instruction counts greater than the current one.  The
-# current instruction count can be observed with @query-replay.
+# current instruction count can be observed with `query-replay`.
 #
 # @icount: instruction count to stop at
 #
@@ -88,7 +88,7 @@
 ##
 # @replay-delete-break:
 #
-# Remove replay breakpoint which was set with @replay-break.  The
+# Remove replay breakpoint which was set with `replay-break`.  The
 # command is ignored when there are no replay breakpoints.
 #
 # Since: 5.2
@@ -108,7 +108,7 @@
 # snapshot and replays the execution to find the desired instruction.
 # When there is no preceding snapshot or the execution is not
 # replayed, then the command fails.  Instruction count can be obtained
-# with the @query-replay command.
+# with the `query-replay` command.
 #
 # @icount: target instruction count
 #
-- 
2.49.0


