Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D45ACA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrko-0007HW-FV; Wed, 30 Sep 2026 06:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj1-0001ck-DL
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0006pw-BB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibmpWAvO/KJXUafppUWT0tuctCAs0SR+qLSV8sHGXWw=;
 b=BcvA+CJykZuMjHlRBxTbH4AKCND7cWVkGTqFyCBtr1SblSnlRmg416MX7U9tz7vvPxhS8A
 LrF71hfABpXJvBfpeqg96ZkX7rOu47faPdcakTRdfwk9qdqqsnRPnBSTaknSBPL/uwveD2
 fJQ9QZZpG5oqH+St6+gyUbrUBaZnlPw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-GD8ZlogwPDeAUPaeDfRczg-1; Wed,
 30 Sep 2026 06:39:28 -0400
X-MC-Unique: GD8ZlogwPDeAUPaeDfRczg-1
X-Mimecast-MFC-AGG-ID: GD8ZlogwPDeAUPaeDfRczg_1790764767
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8281819560AE; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41DCE18004D2; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D91B621E683C; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 079/105] qapi: convert simple data struct intros for
 block-core.json
Date: Wed, 30 Sep 2026 12:38:44 +0200
Message-ID: <20260930103910.3934848-80-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260910203856.99003-10-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index a1ba4fa05b..da7b5c7fe3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -440,10 +440,9 @@
 
 ##
 # @BlockGraphInfo:
-#
-# Information about all nodes in a block (sub)graph in the form of
-# `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains the
-# information for the (sub)graph's root node.
+#     Information about all nodes in a block (sub)graph in the form of
+#     `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains
+#     the information for the (sub)graph's root node.
 #
 # @children: Array of links to this node's child nodes' information
 #
@@ -808,9 +807,8 @@
 
 ##
 # @BlockInfo:
-#
-# Block device information.  This structure describes a virtual device
-# and the backing device associated with it.
+#     Block device information.  This structure describes a virtual
+#     device and the backing device associated with it.
 #
 # @device: The device name associated with the virtual device.
 #
@@ -1647,9 +1645,8 @@
 
 ##
 # @BackupPerf:
-#
-# Optional parameters for backup.  These parameters don't affect
-# functionality, but may significantly affect performance.
+#     Optional parameters for backup.  These parameters don't affect
+#     functionality, but may significantly affect performance.
 #
 # @use-copy-range: Use copy offloading.  Default false.
 #
@@ -2745,11 +2742,10 @@
 
 ##
 # @ThrottleLimits:
-#
-# Limit parameters for throttling.  Since some limit combinations are
-# illegal, limits should always be set in one transaction.  All fields
-# are optional.  When setting limits, if a field is missing the
-# current value is not changed.
+#     Limit parameters for throttling.  Since some limit combinations
+#     are illegal, limits should always be set in one transaction.
+#     All fields are optional.  When setting limits, if a field is
+#     missing the current value is not changed.
 #
 # @iops-total: limit total I/O operations per second
 #
@@ -3532,12 +3528,11 @@
 
 ##
 # @Qcow2OverlapCheckFlags:
-#
-# Structure of flags for each metadata structure.  Setting a field to
-# 'true' makes QEMU guard that Qcow2 format structure against
-# unintended overwriting.  See Qcow2 format specification for detailed
-# information on these structures.  The default value is chosen
-# according to the template given.
+#     Structure of flags for each metadata structure.  Setting a field
+#     to 'true' makes QEMU guard that Qcow2 format structure against
+#     unintended overwriting.  See Qcow2 format specification for
+#     detailed information on these structures.  The default value is
+#     chosen according to the template given.
 #
 # @template: Specifies a template mode which can be adjusted using the
 #     other flags, defaults to 'cached'
-- 
2.55.0


