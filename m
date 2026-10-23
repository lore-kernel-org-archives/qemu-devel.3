Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlW-00036K-32; Fri, 23 Oct 2026 15:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlU-00035z-Vt
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:21 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlT-00025s-Ca
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:20 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlP-00000007BFx-3iaA; Fri, 23 Oct 2026 21:17:15 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 09/13] audio: Make sure to stop audio before VFIO gets
 non-DMA-capable
Date: Fri, 23 Oct 2026 21:16:20 +0200
Message-ID: <dbb244a8c435b08742bb4eb3fd8e46c08f12bc26.1792758436.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792758435.git.maciej.szmigiero@oracle.com>
References: <cover.1792758435.git.maciej.szmigiero@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Although a VM state change normally happens under BQL some state change
handlers may internally temporarily drop BQL.

On the migration source, the VM state change happens in the migration
thread so this potentially allows main loop thread to acquire BQL and
dispatch audio backend handlers.
In turn, these audio backend handlers may call audio_run() which then may
call into emulated sound card to do DMA.

Since VFIO devices start their transition into a state where they no longer
can accept incoming DMA at VM_CHANGE_STATE_PRI_SYNC if audio is stopped
at VM_CHANGE_STATE_PRI_NORMAL in an unlikely but possible case that the
aforementioned sound card DMA targets a VFIO device BAR it may reach
a VFIO device that has already switched into a non-DMA-capable state.

Fix this by making sure that at VM stop audio is stopped at HIGH priority
level, so before VFIO devices start reaching states not capable of
accepting incoming DMA.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 audio/audio-mixeng-be.c   | 4 ++--
 tests/audio/audio-stubs.c | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 070c03c553e3..338e7fea560c 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1480,8 +1480,8 @@ static void audio_mixeng_backend_init(Object *obj)
     s->vmse_start = qemu_add_vm_change_state_handler(
         audio_vm_change_state_start, s);
     assert(s->vmse_start != NULL);
-    s->vmse_stop = qemu_add_vm_change_state_handler(
-        audio_vm_change_state_stop, s);
+    s->vmse_stop = qemu_add_vm_change_state_handler_prio(
+        audio_vm_change_state_stop, s, VM_CHANGE_STATE_PRI_HIGH);
     assert(s->vmse_stop != NULL);
 
     vmstate_register_any(NULL, &vmstate_audio, s);
diff --git a/tests/audio/audio-stubs.c b/tests/audio/audio-stubs.c
index 2c19dfa7d6bb..2cc1027c205d 100644
--- a/tests/audio/audio-stubs.c
+++ b/tests/audio/audio-stubs.c
@@ -59,6 +59,13 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
     return (VMChangeStateEntry *)&dummy_vmse;
 }
 
+VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
+    VMChangeStateHandler *cb, void *opaque,
+    VMChangeStateHandlerPri priority)
+{
+    return qemu_add_vm_change_state_handler(cb, opaque);
+}
+
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
 {
 }

