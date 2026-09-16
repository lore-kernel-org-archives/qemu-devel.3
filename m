Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE373C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6oVp-0007sm-1U; Wed, 16 Sep 2026 08:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <efastermann@ruth.proxmox.com>)
 id 1x6mlf-0000yY-Ns; Wed, 16 Sep 2026 06:21:32 -0400
Received: from [94.136.29.99] (helo=ruth.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <efastermann@ruth.proxmox.com>)
 id 1x6mld-0007NJ-UZ; Wed, 16 Sep 2026 06:21:31 -0400
Received: by ruth.proxmox.com (Postfix, from userid 1000)
 id 4F96822D572; Wed, 16 Sep 2026 12:12:15 +0200 (CEST)
From: Erik Fastermann <e.fastermann@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Erik Fastermann <e.fastermann@proxmox.com>
Subject: [PATCH] runstate: do not force prelaunch on reset during save-vm
Date: Wed, 16 Sep 2026 12:12:15 +0200
Message-ID: <20260916101215.98436-1-e.fastermann@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=efastermann@ruth.proxmox.com; helo=ruth.proxmox.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_SBL_CSS=3.335, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Sep 2026 08:13:14 -0400
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

A reset processed while the VM sits in 'save-vm' aborts QEMU:

    invalid runstate transition: 'save-vm' -> 'prelaunch'

The window is reachable over QMP. dump-guest-memory with detach=true
stops the VM with vm_stop(RUN_STATE_SAVE_VM) in dump_init() and then
returns once dump_thread has been spawned, so the main loop keeps
running with the VM in 'save-vm' for the whole duration of the dump.
A system_reset in that window kills the guest, as
main_loop_should_exit() forces the run state to 'prelaunch'.

'save-vm' needs the same treatment as 'finish-migrate' in commit
1bd71dce4b ("runstate: ignore exit request in finish migrate state").
The reset cannot be applied to a run state whose only exits are back to
'running' or 'suspended', so leave it alone: dump_cleanup() ends it
with vm_start() once the dump thread is done.

Signed-off-by: Erik Fastermann <e.fastermann@proxmox.com>
---
 system/runstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index d3e64d2b62..1d65a4d444 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -1075,7 +1075,8 @@ static bool main_loop_should_exit(int *status)
          */
         if (!runstate_check(RUN_STATE_RUNNING) &&
                 !runstate_check(RUN_STATE_INMIGRATE) &&
-                !runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+                !runstate_check(RUN_STATE_FINISH_MIGRATE) &&
+                !runstate_check(RUN_STATE_SAVE_VM)) {
             runstate_set(RUN_STATE_PRELAUNCH);
         }
     }
-- 
2.47.3


