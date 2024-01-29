Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38634C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXJM-0003oH-GJ; Mon, 29 Jan 2024 14:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rUXJE-0003j8-UF
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:28:46 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rUXIz-0003PL-3x
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1706556501; bh=pLDGQUmcOkurLoPLQFej1T/V3Bo/OA3pqVp4oxQAW5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=C83ILLLz/ECOHmmN5YZrdw9YNgRC3kiU0Oyz2Ve0vAZd97LM36G8QXLuvr4pwvlhi
 QXBlG/VtA+Ee07ZNm8jftk9MsxhRXZOiiukB0Bb0XQMsOthKMviQXKJiw6Bndgt2mp
 wiQYb7kSGfXcFNlB9L+uttU34zbFpajwHNyENax8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Mon, 29 Jan 2024 20:28:13 +0100
Subject: [PATCH v5 5/6] pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic
 shutdown signal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-pvpanic-shutdown-v5-5-f5a060b87c74@t-8ch.de>
References: <20240129-pvpanic-shutdown-v5-0-f5a060b87c74@t-8ch.de>
In-Reply-To: <20240129-pvpanic-shutdown-v5-0-f5a060b87c74@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706556500; l=1642;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=jDQrzFDng3hs6cePBwRlPLgJKcbRtWnG6BeDN4GONAU=;
 b=kDpOnDpPDOPQBOfwzincEAxk3mdcPgq+sM3blw+1qW3wmGZ98Uv0Zib6brEm7jLdxkMlQXfvh
 Snb3IdJNTMWDlhCsJ5ZzDxeXQhFWaSrSZn+rmLk1+iGBiaOTwkbEJ72
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Emit a QMP event on receiving a PVPANIC_SHUTDOWN event. Even though a typical
SHUTDOWN event will be sent, it will be indistinguishable from a shutdown
originating from other cases (e.g. KVM exit due to KVM_SYSTEM_EVENT_SHUTDOWN)
that also issue the guest-shutdown cause.
A management layer application can detect the new GUEST_PVSHUTDOWN event to
determine if the guest is using the pvpanic interface to request shutdowns.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 qapi/run-state.json | 14 ++++++++++++++
 system/runstate.c   |  1 +
 2 files changed, 15 insertions(+)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 08bc99cb8561..d5a63e14ba7e 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -460,6 +460,20 @@
 { 'event': 'GUEST_CRASHLOADED',
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
 
+##
+# @GUEST_PVSHUTDOWN:
+#
+# Emitted when guest submits a shutdown request via pvpanic interface
+#
+# Since: 8.3
+#
+# Example:
+#
+# <- { "event": "GUEST_PVSHUTDOWN",
+#      "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+##
+{ 'event': 'GUEST_PVSHUTDOWN' }
+
 ##
 # @GuestPanicAction:
 #
diff --git a/system/runstate.c b/system/runstate.c
index 572499513034..02b0a1f8b9d0 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -574,6 +574,7 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 
 void qemu_system_guest_pvshutdown(void)
 {
+    qapi_event_send_guest_pvshutdown();
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }
 

-- 
2.43.0


