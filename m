Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72643C4452B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmlNo-0002Uz-Me; Thu, 23 Jul 2026 00:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlNm-0002O4-Kg
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlNk-0004Il-VV
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784782204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUM+22WxDywCXikFEUBWpOnNWjGENT0mgqCEYZkslcs=;
 b=iYK/JzQI++N/8DpIG7h54ARsy2v6tFO7DW504WYTyzB2yc8yGC3dfxr5SZWspx2zghHKTk
 wF8Nn2nfmCaOr60enE0gJdHcxDEpePRMXrJ4lj5J8iStoZ6p5OoI0oauR/nQreEL9JUkYz
 vPEq1LAsLTMdnai6yYGt7wPgYQ4qLS0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-RSTknKbGMyOtFjgmvGgSGw-1; Thu,
 23 Jul 2026 00:49:59 -0400
X-MC-Unique: RSTknKbGMyOtFjgmvGgSGw-1
X-Mimecast-MFC-AGG-ID: RSTknKbGMyOtFjgmvGgSGw_1784782196
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AAAB195FE1B; Thu, 23 Jul 2026 04:49:56 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF08318002B5; Thu, 23 Jul 2026 04:49:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 10/44] qapi: convert intro sections for machine-common.json
Date: Thu, 23 Jul 2026 00:47:31 -0400
Message-ID: <20260723044805.527643-11-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=jsnow@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine-common.json | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index aca98e994af..0b07811df07 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -12,9 +12,8 @@
 
 ##
 # @S390CpuEntitlement:
-#
-# An enumeration of CPU entitlements that can be assumed by a virtual
-# S390 CPU
+#     An enumeration of CPU entitlements that can be assumed by a
+#     virtual S390 CPU
 #
 # Since: 8.2
 ##
@@ -23,8 +22,7 @@
 
 ##
 # @CpuTopologyLevel:
-#
-# An enumeration of CPU topology levels.
+#     An enumeration of CPU topology levels.
 #
 # @thread: thread level, which would also be called SMT level or
 #     logical processor level.  The @threads option in
@@ -65,9 +63,8 @@
 
 ##
 # @CacheLevelAndType:
-#
-# Caches a system may have.  The enumeration value here is the
-# combination of cache level and cache type.
+#     Caches a system may have.  The enumeration value here is the
+#     combination of cache level and cache type.
 #
 # @l1d: L1 data cache.
 #
@@ -84,8 +81,7 @@
 
 ##
 # @SmpCacheProperties:
-#
-# Cache information for SMP system.
+#     Cache information for SMP system.
 #
 # @cache: Cache name, which is the combination of cache level and
 #     cache type.
@@ -103,8 +99,7 @@
 
 ##
 # @SmpCachePropertiesWrapper:
-#
-# List wrapper of `SmpCacheProperties`.
+#     List wrapper of `SmpCacheProperties`.
 #
 # @caches: the list of `SmpCacheProperties`.
 #
-- 
2.55.0


