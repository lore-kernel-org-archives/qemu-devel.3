Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4D0CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrk3-0003rV-Vv; Wed, 30 Sep 2026 06:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriw-0001XE-7j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBril-0006or-8D
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z04CNg1zfGzIZzT0/ahu3CKw6otg7/2Cedr8OIDOE7U=;
 b=SSQYlMbJiKMBX5s7IyvIKDJc8OmgsS19fUSznYUYFl6/JHGxXFLRcBUi0H2bntpO3q9+6p
 6EK3JiUbW3BqGk7IiuypknIQSq1G039uSgLtCnsuvaGdqxFuhLcGJsune3PRgAdAGQNcSq
 8F0UVMr5g3LVgKLcs6HDXYg1M+/iqhw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-kq-HCSn8OyGz7jJ0f8qhkQ-1; Wed,
 30 Sep 2026 06:39:28 -0400
X-MC-Unique: kq-HCSn8OyGz7jJ0f8qhkQ-1
X-Mimecast-MFC-AGG-ID: kq-HCSn8OyGz7jJ0f8qhkQ_1790764768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14C92195DE60; Wed, 30 Sep 2026 10:39:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C39D61800592; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1967921E6573; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 092/105] qapi: split intros at natural cutoff points for
 qga/qapi-schema.json
Date: Wed, 30 Sep 2026 12:38:57 +0200
Message-ID: <20260930103910.3934848-93-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Note that these intro conversions introduce a new intro/details split
point. This new split point may or may not change the rendered output
depending on if any documentation is auto-generated and inserted for
this definition.

How @guest-fsfreeze-status documentation is rendered improves
slightly: "Note:" moves from above "Return" to below. The other
conversions don't change rendered documentation.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260922205605.501602-6-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b592b14a01..19b0958b84 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -401,8 +401,7 @@
 
 ##
 # @guest-fsfreeze-status:
-#
-# Get guest fsfreeze state.
+#     Get guest fsfreeze state.
 #
 # .. note:: This may fail to properly report the current state as a
 #    result of some other guest processes having issued an fs
@@ -925,9 +924,8 @@
 
 ##
 # @GuestNVMeSmart:
-#
-# NVMe smart information, based on NVMe specification, section
-# <SMART / Health Information (Log Identifier 02h)>
+#     NVMe smart information, based on NVMe specification, section
+#     <SMART / Health Information (Log Identifier 02h)>
 #
 # TODO: document members briefly
 #
@@ -1816,8 +1814,7 @@
 
 ##
 # @guest-get-load:
-#
-# Retrieve CPU process load information
+#     Retrieve CPU process load information
 #
 # .. note:: Windows does not have load average API, so QGA emulates it
 #    by calculating the average CPU usage in the last 1, 5, 15 minutes
-- 
2.55.0


