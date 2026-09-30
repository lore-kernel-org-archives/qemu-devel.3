Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA52CA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkH-0004y5-GQ; Wed, 30 Sep 2026 06:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj2-0001dY-Pr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrio-0006rX-Tq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWCc5z+ALGV00hMEz/GF7XGNGVxOEBOQDqVumkWmjy8=;
 b=BIasGTg9Fv8hL0T4/0mBYBaHlrZP9+u6fxr8CU1MFvfXSfp8wpNGyfnsmue1Cn0WgT9U1g
 zKPy2hB6gAr6j3TxqlA7aQQbsqzg0Ba532xDCiX4z82yBStD00yPX+VD0RnFSnOVl7Ob8S
 ldyMJFSLKdWj5jdNSvKN4NLgU5ivo1o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-mCEVwEt8PHagDSbbx6riYQ-1; Wed,
 30 Sep 2026 06:39:28 -0400
X-MC-Unique: mCEVwEt8PHagDSbbx6riYQ-1
X-Mimecast-MFC-AGG-ID: mCEVwEt8PHagDSbbx6riYQ_1790764767
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 809A9188304C; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36D3F1800473; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D52AB21E65F2; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 078/105] qapi: convert simple data struct intros for
 machine.json
Date: Wed, 30 Sep 2026 12:38:43 +0200
Message-ID: <20260930103910.3934848-79-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260910203856.99003-9-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 52a688cfbe..4fc4cf92ea 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -474,8 +474,7 @@
 
 ##
 # @NumaNodeOptions:
-#
-# Create a guest NUMA node.  (for OptsVisitor)
+#     Create a guest NUMA node.  (for OptsVisitor)
 #
 # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
 #
@@ -630,11 +629,10 @@
 
 ##
 # @NumaCpuOptions:
-#
-# Option "-numa cpu" overrides default cpu to node mapping.  It
-# accepts the same set of cpu properties as returned by
-# `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`, where
-# node-id could be used to override default node mapping.
+#     Option "-numa cpu" overrides default cpu to node mapping.  It
+#     accepts the same set of cpu properties as returned by
+#     `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`,
+#     where node-id could be used to override default node mapping.
 #
 # Since: 2.10
 ##
-- 
2.55.0


