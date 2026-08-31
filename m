Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B22C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x18YO-0006EX-Fp; Mon, 31 Aug 2026 16:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18YC-0005b3-Jz
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18YA-0008Hl-Sn
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788207854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8wW2V1gmq4U2oGifMr03OEbp6q8ZFZvEQ5q6kHXpZc=;
 b=OxNdgEoEZ2T7vCPQ+DZ6THvXFXPCaZooBIg2tQdEjMy3LBBvDhxFYGxXigpDeye34Jk8vM
 WC1AVWxXQChc5UO7kdXphkmSJIofFhBhkD9MZNullJktzPm5uJIq7Mb9zSV6kqf0CBPb81
 sbQ/a0xFSl4ODNN5Sa0hoRpC44BEb3U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-g8KQFvfPNuKhBNzurCJSLA-1; Mon,
 31 Aug 2026 16:24:11 -0400
X-MC-Unique: g8KQFvfPNuKhBNzurCJSLA-1
X-Mimecast-MFC-AGG-ID: g8KQFvfPNuKhBNzurCJSLA_1788207848
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 794B8195FE07; Mon, 31 Aug 2026 20:24:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CD0A1800347; Mon, 31 Aug 2026 20:24:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, linux-cxl@vger.kernel.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 linux-edac@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 27/43] qapi: convert trivial intro sections for rocker.json
Date: Mon, 31 Aug 2026 16:19:29 -0400
Message-ID: <20260831201945.287730-28-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


