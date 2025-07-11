Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0BAC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 05:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua6WT-0006zc-D3; Fri, 11 Jul 2025 01:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6WL-0006Gn-VG
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ua6WJ-0000ej-PK
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 01:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752212523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWXV2aM1hA5zWGiL7uBRoHMkQf+6yPEnIkQxyEmOsUY=;
 b=XbOkaJAs9qz756tYG4nBycK/N1Gbgn0vH6ibZG1XcrhZEZm/3ln8zfpJje/eq1mq5blr1n
 E69TTaXiawja8zUZoWztWWHMMj3R20zYtbs2rMavrRAcM1lFeDiJwEMnNfU1HKOWqcBHba
 gFnpHo3FIZ5AMDfcjUa7PojBmboXh8w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-LwsOEPa2P-6WpFx19B3mYg-1; Fri,
 11 Jul 2025 01:41:59 -0400
X-MC-Unique: LwsOEPa2P-6WpFx19B3mYg-1
X-Mimecast-MFC-AGG-ID: LwsOEPa2P-6WpFx19B3mYg_1752212517
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5ADE51956089; Fri, 11 Jul 2025 05:41:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 866C21800285; Fri, 11 Jul 2025 05:41:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 13/18] qapi: add cross-references to run-state.json
Date: Fri, 11 Jul 2025 01:40:00 -0400
Message-ID: <20250711054005.60969-14-jsnow@redhat.com>
In-Reply-To: <20250711054005.60969-1-jsnow@redhat.com>
References: <20250711054005.60969-1-jsnow@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/run-state.json | 46 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 759f8730059..bafbbf695b2 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -68,9 +68,9 @@
 #
 # @host-error: An error prevents further use of guest
 #
-# @host-qmp-quit: Reaction to the QMP command 'quit'
+# @host-qmp-quit: Reaction to the QMP command `quit`
 #
-# @host-qmp-system-reset: Reaction to the QMP command 'system_reset'
+# @host-qmp-system-reset: Reaction to the QMP command `system_reset`
 #
 # @host-signal: Reaction to a signal, such as SIGINT
 #
@@ -106,7 +106,7 @@
 #
 # @running: true if all VCPUs are runnable, false if not runnable
 #
-# @status: the virtual machine @RunState
+# @status: the virtual machine `RunState`
 #
 # Since: 0.14
 ##
@@ -141,12 +141,12 @@
 #     hardware-specific action) rather than a host request (such as
 #     sending QEMU a SIGINT).  (since 2.10)
 #
-# @reason: The @ShutdownCause which resulted in the SHUTDOWN.
+# @reason: The `ShutdownCause` which resulted in the `SHUTDOWN`.
 #     (since 4.0)
 #
 # .. note:: If the command-line option ``-no-shutdown`` has been
-#    specified, QEMU will not exit, and a STOP event will eventually
-#    follow the SHUTDOWN event.
+#    specified, QEMU will not exit, and a `STOP` event will eventually
+#    follow the `SHUTDOWN` event.
 #
 # Since: 0.12
 #
@@ -181,9 +181,9 @@
 # @guest: If true, the reset was triggered by a guest request (such as
 #     a guest-initiated ACPI reboot request or other hardware-specific
 #     action) rather than a host request (such as the QMP command
-#     system_reset).  (since 2.10)
+#     `system_reset`).  (since 2.10)
 #
-# @reason: The @ShutdownCause of the RESET.  (since 4.0)
+# @reason: The `ShutdownCause` of the `RESET`.  (since 4.0)
 #
 # Since: 0.12
 #
@@ -245,7 +245,7 @@
 # saved on disk, for example, S4 state, which is sometimes called
 # hibernate state
 #
-# .. note:: QEMU shuts down (similar to event @SHUTDOWN) when entering
+# .. note:: QEMU shuts down (similar to event `SHUTDOWN`) when entering
 #    this state.
 #
 # Since: 1.2
@@ -279,8 +279,8 @@
 #
 # @action: action that has been taken
 #
-# .. note:: If action is "reset", "shutdown", or "pause" the WATCHDOG
-#    event is followed respectively by the RESET, SHUTDOWN, or STOP
+# .. note:: If action is "reset", "shutdown", or "pause" the `WATCHDOG`
+#    event is followed respectively by the `RESET`, `SHUTDOWN`, or `STOP`
 #    events.
 #
 # .. note:: This event is rate-limited.
@@ -376,7 +376,7 @@
 #
 # Set watchdog action.
 #
-# @action: @WatchdogAction action taken when watchdog timer expires.
+# @action: `WatchdogAction` action taken when watchdog timer expires.
 #
 # Since: 2.11
 #
@@ -394,13 +394,13 @@
 # Set the actions that will be taken by the emulator in response to
 # guest events.
 #
-# @reboot: @RebootAction action taken on guest reboot.
+# @reboot: `RebootAction` action taken on guest reboot.
 #
-# @shutdown: @ShutdownAction action taken on guest shutdown.
+# @shutdown: `ShutdownAction` action taken on guest shutdown.
 #
-# @panic: @PanicAction action taken on guest panic.
+# @panic: `PanicAction` action taken on guest panic.
 #
-# @watchdog: @WatchdogAction action taken when watchdog timer expires.
+# @watchdog: `WatchdogAction` action taken when watchdog timer expires.
 #
 # Since: 6.0
 #
@@ -527,20 +527,20 @@
 #
 # Hyper-V specific guest panic information (HV crash MSRs)
 #
-# @arg1: for Windows, STOP code for the guest crash.  For Linux,
+# @arg1: for Windows, `STOP` code for the guest crash.  For Linux,
 #     an error code.
 #
-# @arg2: for Windows, first argument of the STOP.  For Linux, the
+# @arg2: for Windows, first argument of the `STOP`.  For Linux, the
 #     guest OS ID, which has the kernel version in bits 16-47 and
 #     0x8100 in bits 48-63.
 #
-# @arg3: for Windows, second argument of the STOP.  For Linux, the
+# @arg3: for Windows, second argument of the `STOP`.  For Linux, the
 #     program counter of the guest.
 #
-# @arg4: for Windows, third argument of the STOP.  For Linux, the
+# @arg4: for Windows, third argument of the `STOP`.  For Linux, the
 #     RAX register (x86) or the stack pointer (aarch64) of the guest.
 #
-# @arg5: for Windows, fourth argument of the STOP.  For x86 Linux, the
+# @arg5: for Windows, fourth argument of the `STOP`.  For x86 Linux, the
 #     stack pointer of the guest.
 #
 # Since: 2.9
@@ -628,11 +628,11 @@
 #
 # Emitted when a memory failure occurs on host side.
 #
-# @recipient: recipient is defined as @MemoryFailureRecipient.
+# @recipient: recipient is defined as `MemoryFailureRecipient`.
 #
 # @action: action that has been taken.
 #
-# @flags: flags for MemoryFailureAction.
+# @flags: flags for `MemoryFailureAction`.
 #
 # Since: 5.2
 #
-- 
2.50.0


