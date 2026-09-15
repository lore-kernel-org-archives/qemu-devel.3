Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F013C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aV4-0001Dv-Go; Tue, 15 Sep 2026 17:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6aUg-0000yu-FY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6aUb-0002ap-OL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789506905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBhz2UZF8bOOsvlTvTMmJ20/Eqyxkh0IEGurbSrhuto=;
 b=BHDulZTnSyp806wDxNxscuzakTKVDxh4mL24BlmxVffHM9oBdtq2ln4Tdmsf5nYKPJQO3p
 aJ0xCgwKc8/iv6ZgqiT9WI64hAlul4v35Tm+59C/xf7n+KDb+s79K937+Gk3/YQDStquf5
 2BuEZyxDuc9zZ3NHHw/T05AdDFM1EkA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-8TXqaac9OUGBwGpMIUjstw-1; Tue,
 15 Sep 2026 17:15:01 -0400
X-MC-Unique: 8TXqaac9OUGBwGpMIUjstw-1
X-Mimecast-MFC-AGG-ID: 8TXqaac9OUGBwGpMIUjstw_1789506899
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B54CF19540C3; Tue, 15 Sep 2026 21:14:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EC551956042; Tue, 15 Sep 2026 21:14:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, linux-cxl@vger.kernel.org,
 Lukas Straub <lukasstraub2@web.de>, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Junjie Cao <junjie.cao@intel.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 6/7] qapi: convert intro sections with "TODO" markers
Date: Tue, 15 Sep 2026 17:14:33 -0400
Message-ID: <20260915211434.3511110-7-jsnow@redhat.com>
In-Reply-To: <20260915211434.3511110-1-jsnow@redhat.com>
References: <20260915211434.3511110-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This patch converts intro sections that are immediately followed by a
"TODO:" that was formerly used to demarcate the stub member insertion
point.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json   |  7 ++-----
 qapi/migration.json | 10 ++--------
 qapi/net.json       |  9 +++------
 qapi/yank.json      |  5 +----
 4 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a58e373dd70..84d95c8d87f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1244,11 +1244,8 @@
 
 ##
 # @query-memory-size-summary:
-#
-# Return the amount of initially allocated and present hotpluggable
-# (if enabled) memory in bytes.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Return the amount of initially allocated and present
+#     hotpluggable (if enabled) memory in bytes.
 #
 # .. qmp-example::
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 0428f777882..d571c06fc20 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1617,10 +1617,7 @@
 
 ##
 # @query-xen-replication-status:
-#
-# Query replication status while the vm is running.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Query replication status while the vm is running.
 #
 # .. qmp-example::
 #
@@ -1670,10 +1667,7 @@
 
 ##
 # @query-colo-status:
-#
-# Query COLO status while the vm is running.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Query COLO status while the vm is running.
 #
 # .. qmp-example::
 #
diff --git a/qapi/net.json b/qapi/net.json
index 526108ca0bb..d0bacb4dcfe 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1159,12 +1159,9 @@
 
 ##
 # @announce-self:
-#
-# Trigger generation of broadcast RARP frames to update network
-# switches.  This can be useful when network bonds fail-over the
-# active slave.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Trigger generation of broadcast RARP frames to update network
+#     switches.  This can be useful when network bonds fail-over the
+#     active slave.
 #
 # .. qmp-example::
 #
diff --git a/qapi/yank.json b/qapi/yank.json
index 8ac4b773653..187a0952e66 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -96,10 +96,7 @@
 
 ##
 # @query-yank:
-#
-# Query yank instances.  See `YankInstance` for more information.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Query yank instances.  See `YankInstance` for more information.
 #
 # .. qmp-example::
 #
-- 
2.55.0


