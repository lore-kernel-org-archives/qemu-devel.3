Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14984CF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st55r-0006Z6-Sr; Tue, 24 Sep 2024 08:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1st55Y-0005YQ-P1; Tue, 24 Sep 2024 08:56:23 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1st55V-0007Yj-83; Tue, 24 Sep 2024 08:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=tpLXs/X3dkLCvuJc0G9fwwV2L2T0iqxITW/TDrmt2gA=; b=fXuNBRrAC927
 qTq4PhfVKEIzwRK1zNkxsKUIeEb1b0WwnJYMQ8p/axlxF8RxUNLPMW6Bdl/D/PhSbPV4kmcB8H1mY
 WDQTxglTqJEDYl9/eX2ReiOelltS1siSrnWzp1MS9tCA/GPybPVpeaCi92QLkKf6nD6Iyj5MWGPrN
 /GSCHR8zJIHcYdmhTbPfBidG9RdRi4r6vdhrpIlAHMQpeTfepjHMLSvKVSXQVWCLss0HKL3avzbgz
 XF5RnQzXheoNAeoQcOC36yPYNFPR9hSAq5LFX5JpZhAshp24lN5X3KTGmOEjGKX1eh/IqJhJ/7fbM
 5YPOqNMLh8gj76EqHsdr1g==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1st52L-004Gjl-1n;
 Tue, 24 Sep 2024 14:56:00 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eesposit@redhat.com, vsementsov@yandex-team.ru,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [Bug Report][RFC PATCH 0/1] block: fix failing assert on paused VM
 migration
Date: Tue, 24 Sep 2024 15:56:10 +0300
Message-Id: <20240924125611.664315-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There's a bug (failing assert) which is reproduced during migration of
a paused VM.  I am able to reproduce it on a stand with 2 nodes and a common
NFS share, with VM's disk on that share.

root@fedora40-1-vm:~# virsh domblklist alma8-vm
 Target   Source
------------------------------------------
 sda      /mnt/shared/images/alma8.qcow2

root@fedora40-1-vm:~# df -Th /mnt/shared
Filesystem          Type  Size  Used Avail Use% Mounted on
127.0.0.1:/srv/nfsd nfs4   63G   16G   48G  25% /mnt/shared

On the 1st node:

root@fedora40-1-vm:~# virsh start alma8-vm ; virsh suspend alma8-vm
root@fedora40-1-vm:~# virsh migrate --compressed --p2p --persistent --undefinesource --live alma8-vm qemu+ssh://fedora40-2-vm/system

Then on the 2nd node:

root@fedora40-2-vm:~# virsh migrate --compressed --p2p --persistent --undefinesource --live alma8-vm qemu+ssh://fedora40-1-vm/system
error: operation failed: domain is not running

root@fedora40-2-vm:~# tail -3 /var/log/libvirt/qemu/alma8-vm.log
2024-09-19 13:53:33.336+0000: initiating migration
qemu-system-x86_64: ../block.c:6976: int bdrv_inactivate_recurse(BlockDriverState *): Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
2024-09-19 13:53:42.991+0000: shutting down, reason=crashed

Backtrace:

(gdb) bt
#0  0x00007f7eaa2f1664 in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x00007f7eaa298c4e in raise () at /lib64/libc.so.6
#2  0x00007f7eaa280902 in abort () at /lib64/libc.so.6
#3  0x00007f7eaa28081e in __assert_fail_base.cold () at /lib64/libc.so.6
#4  0x00007f7eaa290d87 in __assert_fail () at /lib64/libc.so.6
#5  0x0000563c38b95eb8 in bdrv_inactivate_recurse (bs=0x563c3b6c60c0) at ../block.c:6976
#6  0x0000563c38b95aeb in bdrv_inactivate_all () at ../block.c:7038
#7  0x0000563c3884d354 in qemu_savevm_state_complete_precopy_non_iterable (f=0x563c3b700c20, in_postcopy=false, inactivate_disks=true)
    at ../migration/savevm.c:1571
#8  0x0000563c3884dc1a in qemu_savevm_state_complete_precopy (f=0x563c3b700c20, iterable_only=false, inactivate_disks=true) at ../migration/savevm.c:1631
#9  0x0000563c3883a340 in migration_completion_precopy (s=0x563c3b4d51f0, current_active_state=<optimized out>) at ../migration/migration.c:2780
#10 migration_completion (s=0x563c3b4d51f0) at ../migration/migration.c:2844
#11 migration_iteration_run (s=0x563c3b4d51f0) at ../migration/migration.c:3270
#12 migration_thread (opaque=0x563c3b4d51f0) at ../migration/migration.c:3536
#13 0x0000563c38dbcf14 in qemu_thread_start (args=0x563c3c2d5bf0) at ../util/qemu-thread-posix.c:541
#14 0x00007f7eaa2ef6d7 in start_thread () at /lib64/libc.so.6
#15 0x00007f7eaa373414 in clone () at /lib64/libc.so.6

What happens here is that after 1st migration BDS related to HDD remains
inactive as VM is still paused.  Then when we initiate 2nd migration,
bdrv_inactivate_all() leads to the attempt to set BDRV_O_INACTIVE flag
on that node which is already set, thus assert fails.

Attached patch which simply skips setting flag if it's already set is more
of a kludge than a clean solution.  Should we use more sophisticated logic
which allows some of the nodes be in inactive state prior to the migration,
and takes them into account during bdrv_inactivate_all()?  Comments would
be appreciated.

Andrey

Andrey Drobyshev (1):
  block: do not fail when inactivating node which is inactive

 block.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.39.3


