Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13ABC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKqr-0007XG-6t; Mon, 14 Jul 2025 11:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUf-0000Le-Vo
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUW-0003cZ-7f
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C4EnNqpxmjZHjCprtZH/3E9zA12ofyL6jDFc0SRnEUw=;
 b=jHUuNqnYqCdrVNLqGjXiqKDw5rhxUVmckJIOEet3yzuaLZT8jP5mz6Isa9iNkI3j+G/hyM
 9iJLJ5b4KVhMa2bWlQJd2/+/9RmCRP6tVZC+7HVAMU1rZvRbsVufiE/aW1V08WPy7jfGKn
 xdT+6+VJ+ro6oKcusvLuaAaJ3GQLF/A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-QHmzOL9nO4ada76-RKB6Iw-1; Mon,
 14 Jul 2025 09:45:09 -0400
X-MC-Unique: QHmzOL9nO4ada76-RKB6Iw-1
X-Mimecast-MFC-AGG-ID: QHmzOL9nO4ada76-RKB6Iw_1752500708
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5DC019560AB
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2989E197702C
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21C5121E65D4; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 24/32] qapi: add cross-references to run-state.json
Date: Mon, 14 Jul 2025 15:44:50 +0200
Message-ID: <20250714134458.2991097-25-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711054005.60969-14-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/run-state.json | 46 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 76f14569ff..54ba5c9a3f 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -70,9 +70,9 @@
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
@@ -108,7 +108,7 @@
 #
 # @running: true if all VCPUs are runnable, false if not runnable
 #
-# @status: the virtual machine @RunState
+# @status: the virtual machine `RunState`
 #
 # Since: 0.14
 ##
@@ -143,12 +143,12 @@
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
@@ -183,9 +183,9 @@
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
@@ -247,7 +247,7 @@
 # saved on disk, for example, S4 state, which is sometimes called
 # hibernate state
 #
-# .. note:: QEMU shuts down (similar to event @SHUTDOWN) when entering
+# .. note:: QEMU shuts down (similar to event `SHUTDOWN`) when entering
 #    this state.
 #
 # Since: 1.2
@@ -281,8 +281,8 @@
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
@@ -378,7 +378,7 @@
 #
 # Set watchdog action.
 #
-# @action: @WatchdogAction action taken when watchdog timer expires.
+# @action: `WatchdogAction` action taken when watchdog timer expires.
 #
 # Since: 2.11
 #
@@ -396,13 +396,13 @@
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
@@ -529,20 +529,20 @@
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
@@ -630,11 +630,11 @@
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
2.49.0


