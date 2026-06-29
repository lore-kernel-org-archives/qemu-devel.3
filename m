Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62734C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weJg4-0001JD-9m; Mon, 29 Jun 2026 17:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfw-0000no-Vy
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfv-0004Kf-CS
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782769074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9s+IkMlBhanf+Pn0duVGNoPMUPvY2espT9FCcXlZ7w=;
 b=K+Gn8XQ/SkeQu8PeIoQFHU7+cws25m/SqWuzTbJpqFr1/1udFjbmjwzCmkCz8fGr2GGpT1
 7BvubrRy+AZ0JgbXbHPf/D7EWMo0T3VW+DRyHAKv8n8oUmeoLKxeF2/5qcp2bqRyE0ih/9
 LhAzOlRJ8zNWw6fACm7IddYqK+dXd7E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-L96HUKv0Pp6Gw2HxSaGsSQ-1; Mon,
 29 Jun 2026 17:37:51 -0400
X-MC-Unique: L96HUKv0Pp6Gw2HxSaGsSQ-1
X-Mimecast-MFC-AGG-ID: L96HUKv0Pp6Gw2HxSaGsSQ_1782769069
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 712A518C0FBA; Mon, 29 Jun 2026 21:37:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52F501956096; Mon, 29 Jun 2026 21:37:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 linux-edac@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 14/14] qapi: convert intro sections for replay.json
Date: Mon, 29 Jun 2026 17:36:24 -0400
Message-ID: <20260629213624.936258-15-jsnow@redhat.com>
In-Reply-To: <20260629213624.936258-1-jsnow@redhat.com>
References: <20260629213624.936258-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/replay.json | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index ccf84da68ef..db1440c09a6 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -12,8 +12,7 @@
 
 ##
 # @ReplayMode:
-#
-# Mode of the replay subsystem.
+#     Mode of the replay subsystem.
 #
 # @none: normal execution mode.  Replay or record are not enabled.
 #
@@ -30,8 +29,7 @@
 
 ##
 # @ReplayInfo:
-#
-# Record/replay information.
+#     Record/replay information.
 #
 # @mode: current mode.
 #
@@ -47,10 +45,9 @@
 
 ##
 # @query-replay:
-#
-# Retrieve the record/replay information.  It includes current
-# instruction count which may be used for `replay-break` and
-# `replay-seek` commands.
+#     Retrieve the record/replay information.  It includes current
+#     instruction count which may be used for `replay-break` and
+#     `replay-seek` commands.
 #
 # Returns: record/replay information.
 #
@@ -66,13 +63,13 @@
 
 ##
 # @replay-break:
-#
-# Set replay breakpoint at instruction count @icount.  Execution stops
-# when the specified instruction is reached.  There can be at most one
-# breakpoint.  When breakpoint is set, any prior one is removed.  The
-# breakpoint may be set only in replay mode and only "in the future",
-# i.e. at instruction counts greater than the current one.  The
-# current instruction count can be observed with `query-replay`.
+#     Set replay breakpoint at instruction count @icount.  Execution
+#     stops when the specified instruction is reached.  There can be
+#     at most one breakpoint.  When breakpoint is set, any prior one
+#     is removed.  The breakpoint may be set only in replay mode and
+#     only "in the future", i.e. at instruction counts greater than
+#     the current one.  The current instruction count can be observed
+#     with `query-replay`.
 #
 # @icount: instruction count to stop at
 #
@@ -87,9 +84,8 @@
 
 ##
 # @replay-delete-break:
-#
-# Remove replay breakpoint which was set with `replay-break`.  The
-# command is ignored when there are no replay breakpoints.
+#     Remove replay breakpoint which was set with `replay-break`.  The
+#     command is ignored when there are no replay breakpoints.
 #
 # Since: 5.2
 #
@@ -102,13 +98,12 @@
 
 ##
 # @replay-seek:
-#
-# Automatically proceed to the instruction count @icount, when
-# replaying the execution.  The command automatically loads nearest
-# snapshot and replays the execution to find the desired instruction.
-# When there is no preceding snapshot or the execution is not
-# replayed, then the command fails.  Instruction count can be obtained
-# with the `query-replay` command.
+#     Automatically proceed to the instruction count @icount, when
+#     replaying the execution.  The command automatically loads
+#     nearest snapshot and replays the execution to find the desired
+#     instruction.  When there is no preceding snapshot or the
+#     execution is not replayed, then the command fails.  Instruction
+#     count can be obtained with the `query-replay` command.
 #
 # @icount: target instruction count
 #
-- 
2.54.0


