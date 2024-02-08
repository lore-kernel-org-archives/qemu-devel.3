Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A6EC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYAbT-0008W4-Ih; Thu, 08 Feb 2024 15:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rYAbR-0008Tl-Oi
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:02:33 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rYAbQ-0001Wg-4v
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1707422548; bh=4DspYvGcedbZAyyXHFoUQRfkUa0jnSBjsecnaCtoxI4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DD+d9V8akalFAKsERe5QJl04ZwUDvgS9RoXgKsWx1KJVltd7Fho0u3gxoZmJpmzjX
 0n89qA+32sSWPpuQYP31b8nZagr8Tst9f7o3zbDyfrmL+22f1JO4fN3AGOc9U0nfem
 GfL0KkPWWDqiIZXv4RJscFtk1Omuxjifu3/SJNjU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Thu, 08 Feb 2024 21:02:23 +0100
Subject: [PATCH v6 4/6] hw/misc/pvpanic: add support for normal shutdowns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240208-pvpanic-shutdown-v6-4-965580ac057b@t-8ch.de>
References: <20240208-pvpanic-shutdown-v6-0-965580ac057b@t-8ch.de>
In-Reply-To: <20240208-pvpanic-shutdown-v6-0-965580ac057b@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707422542; l=3037;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=4DspYvGcedbZAyyXHFoUQRfkUa0jnSBjsecnaCtoxI4=;
 b=L8gQPtWSd+oMyxXIXF3F3iZw19dVxQCQUdgDW9VWx+/Jxzy/BOqxyKXpqFKbYLgNAZ3LCvIGN
 913tZcLiM77AeG4u148sioAnKFrpO81oXSNiV84qlN2i9qP8X0oqoW/
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

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 docs/specs/pvpanic.rst    | 2 ++
 hw/misc/pvpanic.c         | 5 +++++
 include/hw/misc/pvpanic.h | 3 ++-
 include/sysemu/runstate.h | 1 +
 system/runstate.c         | 5 +++++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index f894bc19555f..796cc0348a38 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,6 +29,8 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
+bit 2
+  a guest shutdown has happened and should be processed by the host
 
 PCI Interface
 -------------
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index a4982cc5928e..0e9505451a7a 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -40,6 +40,11 @@ static void handle_event(int event)
         qemu_system_guest_crashloaded(NULL);
         return;
     }
+
+    if (event & PVPANIC_SHUTDOWN) {
+        qemu_system_guest_pvshutdown();
+        return;
+    }
 }
 
 /* return supported events on read */
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 48f2ec4c86a1..9e36a02d5a4f 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -20,7 +20,8 @@
 
 #define PVPANIC_PANICKED	(1 << 0)
 #define PVPANIC_CRASH_LOADED	(1 << 1)
-#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
+#define PVPANIC_SHUTDOWN	(1 << 2)
+#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED | PVPANIC_SHUTDOWN)
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0117d243c4ed..e210a37abf0f 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -104,6 +104,7 @@ void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
 void qemu_system_guest_crashloaded(GuestPanicInformation *info);
+void qemu_system_guest_pvshutdown(void);
 bool qemu_system_dump_in_progress(void);
 
 #endif
diff --git a/system/runstate.c b/system/runstate.c
index d6ab860ecaa7..572499513034 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -572,6 +572,11 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
     qapi_free_GuestPanicInformation(info);
 }
 
+void qemu_system_guest_pvshutdown(void)
+{
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+}
+
 void qemu_system_reset_request(ShutdownCause reason)
 {
     if (reboot_action == REBOOT_ACTION_SHUTDOWN &&

-- 
2.43.0


