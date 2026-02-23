Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90432EA4FBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWII-0008W1-7N; Mon, 23 Feb 2026 08:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWHy-0008P5-A7
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWHw-0006y7-LD
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukYPq8MtY8MhpchonEYSa7OftrFfRLjZUE2yTfR+prM=;
 b=XpYQCUQTHqX6TBlyNlWtEOTIrvCQkyDDf4BTF6ef9KA+MNPLc3NoQ3ak2JcUyu3arENY4G
 PKW1EqHk3XKiFZSYqNMgN1qmZin/0eWtbK2uzUGniyDO+VIWOy9TYAZUhrGb/28P43l6+6
 +Dly1LDukM1sa4m/R6fVZIuCswpe2GQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-krQtQECUMGeAa97qxQfOKQ-1; Mon,
 23 Feb 2026 08:47:49 -0500
X-MC-Unique: krQtQECUMGeAa97qxQfOKQ-1
X-Mimecast-MFC-AGG-ID: krQtQECUMGeAa97qxQfOKQ_1771854468
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4A7A18002FF; Mon, 23 Feb 2026 13:47:48 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30FE219560A2; Mon, 23 Feb 2026 13:47:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v3 05/85] qemu-options.hx: clarify default audio backend
 selection
Date: Mon, 23 Feb 2026 14:46:06 +0100
Message-ID: <20260223134731.2377432-6-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qemu-options.hx | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 33fcfe7ce66..15a6f82043a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -896,11 +896,16 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     QEMU_ARCH_ALL)
 SRST
 ``-audiodev [driver=]driver,id=id[,prop[=value][,...]]``
-    Adds a new audio backend driver identified by id. There are global
-    and driver specific properties. Some values can be set differently
-    for input and output, they're marked with ``in|out.``. You can set
-    the input's property with ``in.prop`` and the output's property with
-    ``out.prop``. For example:
+    Adds a new audio backend driver identified by id.
+
+    If no audio backend is specified, QEMU will attempt to select a
+    default one. The ``-display`` option may influence which backend is
+    selected.
+
+    There are global and driver specific properties. Some values can be
+    set differently for input and output, they're marked with ``in|out.``.
+    You can set the input's property with ``in.prop`` and the output's
+    property with ``out.prop``. For example:
 
     ::
 
@@ -2198,8 +2203,11 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
     , QEMU_ARCH_ALL)
 SRST
 ``-display type``
-    Select type of display to use. Use ``-display help`` to list the available
-    display types. Valid values for type are
+    Select type of display to use. This may also influence the default
+    audio backend selection.
+
+    Use ``-display help`` to list the available display types. Valid values
+    for type are
 
     ``spice-app[,gl=on|off]``
         Start QEMU as a Spice server and launch the default Spice client
@@ -2209,6 +2217,9 @@ SRST
     ``dbus``
         Export the display over D-Bus interfaces. (Since 7.0)
 
+        If no audio backend is specified and the dbus display backend is
+        specified, the dbus audio backend is used by default.
+
         The connection is registered with the "org.qemu" name (and queued when
         already owned).
 
-- 
2.53.0


