Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693E4C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJWY-0004gr-Jd; Wed, 26 Aug 2026 15:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWX-0004W3-4T
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWU-0006ZT-AU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8wW2V1gmq4U2oGifMr03OEbp6q8ZFZvEQ5q6kHXpZc=;
 b=Infvl1lps2Vi3Uojarj7ApQZUrMIOToGlgmwJIi3q+5sGh3miLYrmHx9fmEpUKt0Hhinme
 jurZythsl1cFV6RaXRj8c6b7bx6Oxht0/w6zFA3wXaVBojSG65VXaGGN0Iyy5/LYfWvm25
 +NSsnWNW/n+u+j1w+sUQRY8FwshehZw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-DrxEYY6pOaGJXFAtcdIs2A-1; Wed,
 26 Aug 2026 15:42:52 -0400
X-MC-Unique: DrxEYY6pOaGJXFAtcdIs2A-1
X-Mimecast-MFC-AGG-ID: DrxEYY6pOaGJXFAtcdIs2A_1787773369
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0974D1855127; Wed, 26 Aug 2026 19:42:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 382B91800598; Wed, 26 Aug 2026 19:42:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, linux-cxl@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 27/43] qapi: convert trivial intro sections for rocker.json
Date: Wed, 26 Aug 2026 15:38:24 -0400
Message-ID: <20260826193840.2152000-28-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qapi/rocker.json | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/qapi/rocker.json b/qapi/rocker.json
index 5d2dbd26034..7eb0a88dafd 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -9,8 +9,7 @@
 
 ##
 # @RockerSwitch:
-#
-# Rocker switch information.
+#     Rocker switch information.
 #
 # @name: switch name
 #
@@ -25,8 +24,7 @@
 
 ##
 # @query-rocker:
-#
-# Return rocker switch information.
+#     Return rocker switch information.
 #
 # @name: switch name
 #
@@ -43,8 +41,7 @@
 
 ##
 # @RockerPortDuplex:
-#
-# An enumeration of port duplex states.
+#     An enumeration of port duplex states.
 #
 # @half: half duplex
 #
@@ -56,8 +53,7 @@
 
 ##
 # @RockerPortAutoneg:
-#
-# An enumeration of port autoneg states.
+#     An enumeration of port autoneg states.
 #
 # @off: autoneg is off
 #
@@ -69,8 +65,7 @@
 
 ##
 # @RockerPort:
-#
-# Rocker switch port information.
+#     Rocker switch port information.
 #
 # @name: port name
 #
@@ -93,8 +88,7 @@
 
 ##
 # @query-rocker-ports:
-#
-# Return rocker switch port information.
+#     Return rocker switch port information.
 #
 # @name: port name
 #
@@ -115,8 +109,7 @@
 
 ##
 # @RockerOfDpaFlowKey:
-#
-# Rocker switch OF-DPA flow key
+#     Rocker switch OF-DPA flow key
 #
 # @priority: key priority, 0 being lowest priority
 #
@@ -153,8 +146,7 @@
 
 ##
 # @RockerOfDpaFlowMask:
-#
-# Rocker switch OF-DPA flow mask
+#     Rocker switch OF-DPA flow mask
 #
 # @in-pport: physical input port
 #
@@ -182,8 +174,7 @@
 
 ##
 # @RockerOfDpaFlowAction:
-#
-# Rocker switch OF-DPA flow action
+#     Rocker switch OF-DPA flow action
 #
 # @goto-tbl: next table ID
 #
@@ -209,8 +200,7 @@
 
 ##
 # @RockerOfDpaFlow:
-#
-# Rocker switch OF-DPA flow
+#     Rocker switch OF-DPA flow
 #
 # @cookie: flow unique cookie ID
 #
@@ -230,8 +220,7 @@
 
 ##
 # @query-rocker-of-dpa-flows:
-#
-# Return rocker OF-DPA flow information.
+#     Return rocker OF-DPA flow information.
 #
 # @name: switch name
 #
@@ -261,8 +250,7 @@
 
 ##
 # @RockerOfDpaGroup:
-#
-# Rocker switch OF-DPA group
+#     Rocker switch OF-DPA group
 #
 # @id: group unique ID
 #
@@ -305,8 +293,7 @@
 
 ##
 # @query-rocker-of-dpa-groups:
-#
-# Return rocker OF-DPA group information.
+#     Return rocker OF-DPA group information.
 #
 # @name: switch name
 #
-- 
2.55.0


