Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA8DC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 22:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMb3H-00073y-Ta; Wed, 26 Jun 2024 18:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb36-0006aP-59
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb34-0002Tu-8v
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719440609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1OfYnU6CZnlx7UmPCiwBj3nIOb2UT+CP9LyZtFc3Eg=;
 b=LbQ/bPrLF6e5NyGjYqmYD+yiqCyLCegcoK1oHZJJvRXerjyc6UI/ZkY1/Vw66ujtjWZ6Lw
 hGgYXNLuLk7Pu1ptz6NE3t4/KVPTkjWCWvYvCqVQauKlDB7cGrOddRx+lrvHieW7D5aZSi
 mkCdGDo9gSegjACV1UcA11WZmjhipG8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-Wq6GaFSUNTuS1O_D08Qx2Q-1; Wed,
 26 Jun 2024 18:23:25 -0400
X-MC-Unique: Wq6GaFSUNTuS1O_D08Qx2Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74261195609E; Wed, 26 Jun 2024 22:23:23 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 709F219560BF; Wed, 26 Jun 2024 22:23:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 12/21] qapi: add markup to note blocks
Date: Wed, 26 Jun 2024 18:21:18 -0400
Message-ID: <20240626222128.406106-13-jsnow@redhat.com>
In-Reply-To: <20240626222128.406106-1-jsnow@redhat.com>
References: <20240626222128.406106-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
index 3970118bf4e..4d78d2ccb77 100644
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
2.45.0


