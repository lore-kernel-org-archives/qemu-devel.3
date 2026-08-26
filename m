Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4423DC61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJVN-0000fo-CT; Wed, 26 Aug 2026 15:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJVL-0000cA-RL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJVJ-0006JI-4G
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rrr0aq5qW3Bpm6ENGOJu7B6TQXjJHrQBrFBPuknWGuk=;
 b=dOPGV6dkd+GG/Nv+xlsB8aaTqFHDKXkJRW8EqrxWtldFyvat51t6yTKxhoAGZ+qaavF60R
 PZXRzI1mXYZ1JDvhCsubxhPcy6BbM63iJ0oYgLw5d2NmiKbUP86kEPEQC/YI7fQa9DNcuZ
 Lii509a9XMr3QGHrZY6f5M3MJ456D7s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-LipqZqKiOHekskGN0UbJ3w-1; Wed,
 26 Aug 2026 15:41:40 -0400
X-MC-Unique: LipqZqKiOHekskGN0UbJ3w-1
X-Mimecast-MFC-AGG-ID: LipqZqKiOHekskGN0UbJ3w_1787773294
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EB3019540D6; Wed, 26 Aug 2026 19:41:34 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3DA21800577; Wed, 26 Aug 2026 19:41:26 +0000 (UTC)
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
Subject: [PATCH v3 18/43] qapi: convert trivial intro sections for control.json
Date: Wed, 26 Aug 2026 15:38:15 -0400
Message-ID: <20260826193840.2152000-19-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
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
 qapi/control.json | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 9a5302193d6..0fc465936d8 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -10,8 +10,7 @@
 
 ##
 # @qmp_capabilities:
-#
-# Enable QMP capabilities.
+#     Enable QMP capabilities.
 #
 # @enable: An optional list of `QMPCapability` values to enable.  The
 #     client must not enable any capability that is not mentioned in
@@ -41,9 +40,9 @@
 
 ##
 # @QMPCapability:
-#
-# Enumeration of capabilities to be advertised during initial client
-# connection, used for agreeing on particular QMP extension behaviors.
+#     Enumeration of capabilities to be advertised during initial
+#     client connection, used for agreeing on particular QMP extension
+#     behaviors.
 #
 # @oob: QMP ability to support out-of-band requests.  (Please refer to
 #     qmp-spec.rst for more information on OOB)
@@ -55,8 +54,7 @@
 
 ##
 # @VersionTriple:
-#
-# A three-part version number.
+#     A three-part version number.
 #
 # @major: The major version number.
 #
@@ -71,8 +69,7 @@
 
 ##
 # @VersionInfo:
-#
-# A description of QEMU's version.
+#     A description of QEMU's version.
 #
 # @qemu: The version of QEMU.  By current convention, a micro version
 #     of 50 signifies a development branch.  A micro version greater
@@ -92,8 +89,7 @@
 
 ##
 # @query-version:
-#
-# Return the current version of QEMU.
+#     Return the current version of QEMU.
 #
 # Returns: An object describing the current version of QEMU.
 #
@@ -118,8 +114,7 @@
 
 ##
 # @CommandInfo:
-#
-# Information about a QMP command
+#     Information about a QMP command
 #
 # @name: The command name
 #
@@ -129,8 +124,7 @@
 
 ##
 # @query-commands:
-#
-# Return a list of supported QMP commands by this server
+#     Return a list of supported QMP commands by this server
 #
 # Returns: A list of all supported commands
 #
@@ -177,8 +171,7 @@
 
 ##
 # @MonitorMode:
-#
-# An enumeration of monitor modes.
+#     An enumeration of monitor modes.
 #
 # @readline: HMP monitor (human-oriented command line interface)
 #
@@ -190,8 +183,7 @@
 
 ##
 # @MonitorOptions:
-#
-# Options to be used for adding a new monitor.
+#     Options to be used for adding a new monitor.
 #
 # @id: Name of the monitor
 #
-- 
2.55.0


