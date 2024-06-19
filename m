Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6EAC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 00:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJjF9-0001aK-4q; Tue, 18 Jun 2024 20:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjF8-0001Oz-0S
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjF6-0001T2-7U
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718757123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6AnbYZO/P56oES7EE5cq3UJCGzylUH7FETDvELDxTI=;
 b=K+jj4oso4FVdcHF7CwOv+P9+aPpJN/vT8uTjC0axwo0E7Zc2amlk6DPlQ8mFSFnTKziFDN
 +EZZXTIUA9xS+mgzB8sydOU2wPwOwtdLs3KDdhq+cvKdqGS+O4Sm1fMBn4v9zA9ec2P7kl
 jiEvUwlCLzREFxEc2GqWvioyNWBiCr8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-EK4KF4UvNm2wymuHGYDrEw-1; Tue,
 18 Jun 2024 20:32:00 -0400
X-MC-Unique: EK4KF4UvNm2wymuHGYDrEw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8356119560B2; Wed, 19 Jun 2024 00:31:58 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.16.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E0BC1955E80; Wed, 19 Jun 2024 00:31:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Jiri Pirko <jiri@resnulli.us>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 11/13] qapi: add markup to note blocks
Date: Tue, 18 Jun 2024 20:30:10 -0400
Message-ID: <20240619003012.1753577-12-jsnow@redhat.com>
In-Reply-To: <20240619003012.1753577-1-jsnow@redhat.com>
References: <20240619003012.1753577-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Generally, surround command-line options with ``literal`` markup to help
it stand out from prose in rendered HTML, and add cross-references to
replace "see also" messages.

References to types, values, and other QAPI definitions are not yet
adjusted here; they will be converted en masse in a subsequent patch
after the new QAPI doc generator is merged.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/control.json   | 4 ++--
 qapi/misc.json      | 8 ++++----
 qapi/qdev.json      | 2 +-
 qapi/run-state.json | 2 +-
 qapi/sockets.json   | 2 +-
 qapi/ui.json        | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 59d5e00c151..fe2af45120b 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -24,8 +24,8 @@
 #
 # .. note:: This command is valid exactly when first connecting: it must
 #    be issued before any other command will be accepted, and will fail
-#    once the monitor is accepting other commands.  (see qemu
-#    docs/interop/qmp-spec.rst)
+#    once the monitor is accepting other commands.
+#    (see :doc:`/interop/qmp-spec`)
 #
 # .. note:: The QMP client needs to explicitly enable QMP capabilities,
 #    otherwise all the QMP capabilities will be turned off by default.
diff --git a/qapi/misc.json b/qapi/misc.json
index 13ea82f5254..b04efbadec6 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -104,7 +104,7 @@
 # Returns a list of information about each iothread.
 #
 # .. note:: This list excludes the QEMU main loop thread, which is not
-#    declared using the -object iothread command-line option.  It is
+#    declared using the ``-object iothread`` command-line option.  It is
 #    always the main thread of the process.
 #
 # Returns: a list of @IOThreadInfo for each iothread
@@ -138,8 +138,8 @@
 #
 # .. note:: This function will succeed even if the guest is already in
 #    the stopped state.  In "inmigrate" state, it will ensure that the
-#    guest remains paused once migration finishes, as if the -S option
-#    was passed on the command line.
+#    guest remains paused once migration finishes, as if the ``-S``
+#    option was passed on the command line.
 #
 #    In the "suspended" state, it will completely stop the VM and cause
 #    a transition to the "paused" state.  (Since 9.0)
@@ -161,7 +161,7 @@
 # .. note:: This command will succeed if the guest is currently running.
 #    It will also succeed if the guest is in the "inmigrate" state; in
 #    this case, the effect of the command is to make sure the guest
-#    starts once migration finishes, removing the effect of the -S
+#    starts once migration finishes, removing the effect of the ``-S``
 #    command line option if it was passed.
 #
 #    If the VM was previously suspended, and not been reset or woken,
diff --git a/qapi/qdev.json b/qapi/qdev.json
index f5b35a814fe..d031fc3590d 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -59,7 +59,7 @@
 #        the 'docs/qdev-device-use.txt' file.
 #
 #     3. It's possible to list device properties by running QEMU with
-#        the "-device DEVICE,help" command-line argument, where DEVICE
+#        the ``-device DEVICE,help`` command-line argument, where DEVICE
 #        is the device's name.
 #
 # Example:
diff --git a/qapi/run-state.json b/qapi/run-state.json
index dc524234ace..252d7d6afa7 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -146,7 +146,7 @@
 # @reason: The @ShutdownCause which resulted in the SHUTDOWN.
 #     (since 4.0)
 #
-# .. note:: If the command-line option "-no-shutdown" has been
+# .. note:: If the command-line option ``-no-shutdown`` has been
 #    specified, qemu will not exit, and a STOP event will eventually
 #    follow the SHUTDOWN event.
 #
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 20e05ca7ac2..f46113ab1b8 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -181,7 +181,7 @@
 #
 # .. note:: This type is deprecated in favor of SocketAddress.  The
 #    difference between SocketAddressLegacy and SocketAddress is that
-#    the latter has fewer {} on the wire.
+#    the latter has fewer ``{}`` on the wire.
 #
 # Since: 1.3
 ##
diff --git a/qapi/ui.json b/qapi/ui.json
index a1999965e44..5bcccbfc930 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1268,7 +1268,7 @@
 # Since: 2.6
 #
 # .. note:: The consoles are visible in the qom tree, under
-#    /backend/console[$index]. They have a device link and head
+#    ``/backend/console[$index]``. They have a device link and head
 #    property, so it is possible to map which console belongs to which
 #    device and display.
 #
-- 
2.44.0


