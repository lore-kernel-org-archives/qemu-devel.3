Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F590C79FB5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49kV-0004dO-AO; Wed, 09 Sep 2026 00:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x49kT-0004cH-71
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x49kR-0006GQ-Kn
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788927442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jejtr3gY5u2jkllDzpEBmv62g3OyMsBGD9D9SzjMFW0=;
 b=fvTIVWx8axKJCeavblIxw8TMaB275lwhNxjWLa8/cdcjX4GwU2AjTDwTL6Ryppz76jqNb0
 eECOog0mWL1xfdsY7DjcdRH0mfxPYi+mg5ePWxu3Y7CBjqIy0qgFHt8zsLufHi8JhJblsc
 /AGYLpmIhfVn3sayM5Z2Hax2BeMCPFE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517--T184KdeOjGooTp3o61M8A-1; Wed,
 09 Sep 2026 00:17:19 -0400
X-MC-Unique: -T184KdeOjGooTp3o61M8A-1
X-Mimecast-MFC-AGG-ID: -T184KdeOjGooTp3o61M8A_1788927437
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5931B1944B03; Wed,  9 Sep 2026 04:17:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 860E81800473; Wed,  9 Sep 2026 04:17:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 linux-cxl@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 08/10] qapi: convert simple enum intros for migration.json
Date: Wed,  9 Sep 2026 00:16:38 -0400
Message-ID: <20260909041640.69080-9-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/migration.json | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5fbd604f995..8096ef64682 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -788,9 +788,8 @@
 
 ##
 # @MigrationParameter:
-#
-# Migration parameters enumeration.  The enumeration values mirror the
-# members of @MigrationParameters.
+#     Migration parameters enumeration.  The enumeration values mirror
+#     the members of @MigrationParameters.
 #
 # Features:
 #
@@ -1756,9 +1755,8 @@
 
 ##
 # @DirtyRateMeasureMode:
-#
-# Method used to measure dirty page rate.  Differences between
-# available methods are explained in `calc-dirty-rate`.
+#     Method used to measure dirty page rate.  Differences between
+#     available methods are explained in `calc-dirty-rate`.
 #
 # @page-sampling: use page sampling
 #
-- 
2.55.0


