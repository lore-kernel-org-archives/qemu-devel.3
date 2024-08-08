Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D56C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 18:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc7qf-00075c-0v; Thu, 08 Aug 2024 14:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc7qb-0006vk-6r
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc7qX-0000zl-6d
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723141604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPzDwnV7bltr5P6E7tqUg1PVMwh8QxRkScJ+Mwg6V7Q=;
 b=ghUyPj/7oslU6oV6ybrLNG8mxSJxm75YvxokbM3t40rW95r8nnjdiRJV4c2UJ+yFa4ewGS
 suLj3DUejBUEzwTTb3DSeDkVDuT2assRASopIUKg7YSCjL5fpDPxGsUIhC4h2n2eqlxpmm
 yHYUktgxikaiRuRaHokAp3QYQhROOCI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-IxSSjyQGNAO3ePcIaay1pw-1; Thu,
 08 Aug 2024 14:26:41 -0400
X-MC-Unique: IxSSjyQGNAO3ePcIaay1pw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BAB71944AA8; Thu,  8 Aug 2024 18:26:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 774EB1956052; Thu,  8 Aug 2024 18:26:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 264C521E5A5E; Thu,  8 Aug 2024 20:26:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 jiri@resnulli.us, jsnow@redhat.com
Subject: [PATCH 1/6] qapi/char: Supply missing member documentation
Date: Thu,  8 Aug 2024 20:26:31 +0200
Message-ID: <20240808182636.3657537-2-armbru@redhat.com>
In-Reply-To: <20240808182636.3657537-1-armbru@redhat.com>
References: <20240808182636.3657537-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since we neglect to document several members of ChardevBackendKind,
their description in the QEMU QMP Reference manual is "Not
documented".  Fix that, and improve the existing member documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json   | 44 ++++++++++++++++++++++++++++----------------
 qapi/pragma.json |  1 -
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index ef58445cee..8a4a87c95c 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -434,37 +434,49 @@
 ##
 # @ChardevBackendKind:
 #
-# @pipe: Since 1.5
+# @file: regular files
 #
-# @udp: Since 1.5
+# @serial: serial host device
 #
-# @mux: Since 1.5
+# @parallel: parallel host device
 #
-# @msmouse: Since 1.5
+# @pipe: pipes (since 1.5)
 #
-# @wctablet: Since 2.9
+# @socket: stream socket
 #
-# @braille: Since 1.5
+# @udp: datagram socket (since 1.5)
 #
-# @testdev: Since 2.2
+# @pty: pseudo-terminal
 #
-# @stdio: Since 1.5
+# @null: provides no input, throws away output
 #
-# @console: Since 1.5
+# @mux: (since 1.5)
 #
-# @spicevmc: Since 1.5
+# @msmouse: emulated Microsoft serial mouse (since 1.5)
 #
-# @spiceport: Since 1.5
+# @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
 #
-# @qemu-vdagent: Since 6.1
+# @braille: Baum Braille device (since 1.5)
 #
-# @dbus: Since 7.0
+# @testdev: device for test-suite control (since 2.2)
 #
-# @vc: v1.5
+# @stdio: standard I/O (since 1.5)
 #
-# @ringbuf: Since 1.6
+# @console: Windows console (since 1.5)
 #
-# @memory: Since 1.5
+# @spicevmc: spice vm channel (since 1.5)
+#
+# @spiceport: Spice port channel (since 1.5)
+#
+# @qemu-vdagent: Spice vdagent (since 6.1)
+#
+# @dbus: D-Bus channel (since 7.0)
+#
+# @vc: virtual console (since v1.5)
+#
+# @ringbuf: memory ring buffer (since 1.6)
+#
+# @memory: synonym for @ringbuf (since 1.5)
 #
 # Features:
 #
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 59fbe74b8c..39a424303b 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -46,7 +46,6 @@
         'BlockdevSnapshotSyncWrapper',
         'BlockdevSnapshotWrapper',
         'BlockdevVmdkAdapterType',
-        'ChardevBackendKind',
         'CpuS390Entitlement',
         'CpuS390Polarization',
         'CpuS390State',
-- 
2.45.0


