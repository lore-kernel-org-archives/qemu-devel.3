Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07151606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlN-00032T-Dq; Fri, 23 Oct 2026 15:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKl4-0002xp-3p
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:16:58 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKkz-00020w-E6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:16:50 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKkv-00000007BEq-0j2T; Fri, 23 Oct 2026 21:16:45 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 03/13] runstate: Add an intermediate VM change state
 handlers SYNC priority
Date: Fri, 23 Oct 2026 21:16:14 +0200
Message-ID: <2f8d2c6eccb373a2a6d19245386889b2ebaf5cba.1792758435.git.maciej.szmigiero@oracle.com>
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

VFIO code needs to register a VM change state handler between NORMAL and
HIGH priorities as a synchronization point/barrier between the first state
transition of its devices and their second state transition.

Add an intermediate SYNC priority of VM change state handlers for that.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/system/runstate.h | 2 +-
 system/runstate.c         | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index e28261ec4a20..c10d9dc8b751 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -16,6 +16,7 @@ typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState sta
 
 typedef enum VMChangeStateHandlerPri {
     VM_CHANGE_STATE_PRI_HIGH,
+    VM_CHANGE_STATE_PRI_SYNC,
     VM_CHANGE_STATE_PRI_NORMAL,
     VM_CHANGE_STATE_PRI_MAX,
 } VMChangeStateHandlerPri;
@@ -163,4 +164,3 @@ void qemu_system_guest_pvshutdown(void);
 bool qemu_system_dump_in_progress(void);
 
 #endif
-
diff --git a/system/runstate.c b/system/runstate.c
index 5f16f09507ed..6039bb81ecfd 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -313,6 +313,9 @@ static VMChangeStateHead vm_change_state_head[VM_CHANGE_STATE_PRI_MAX] = {
     [VM_CHANGE_STATE_PRI_HIGH] =
         QTAILQ_HEAD_INITIALIZER(
             vm_change_state_head[VM_CHANGE_STATE_PRI_HIGH]),
+    [VM_CHANGE_STATE_PRI_SYNC] =
+        QTAILQ_HEAD_INITIALIZER(
+            vm_change_state_head[VM_CHANGE_STATE_PRI_SYNC]),
     [VM_CHANGE_STATE_PRI_NORMAL] =
         QTAILQ_HEAD_INITIALIZER(
             vm_change_state_head[VM_CHANGE_STATE_PRI_NORMAL]),

