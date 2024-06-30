Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A4FC30653
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0Py-0008VZ-AD; Sun, 30 Jun 2024 15:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pp-0008R2-SR
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pn-0004Nv-Jk
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJecEg030630;
 Sun, 30 Jun 2024 19:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=corp-2023-11-20; bh=2tpyLTAebinn+o
 njq2RWmyvXCR7OKwgCjRq62rWDVbs=; b=XNCBUJVldb31YktsqMtyhnxGdYgbGz
 FW8mD0lhTO0Nrr6OWny06QtySQt8BkBFrm4NfGTjxQyfJ3I5nRx8GafZmw3lVBTn
 /l8uvruhEHUqo8SbaujfYor9aQVzKhZqk/5Hd3Fq8ex60/Q1tAx1Ne4iWM06rNM7
 7XPUY144G/qCuLGnN2h4Vcd59Nltj4/SiQRHIxTPjMVW7CKZskoUscF2vhpFoOoL
 z0CNvz7waelrvT0xsWd7h5MmTS1mheQm1PNyvb++LBo81tE9xkj+kFOWCpYxNSSq
 DaREkmw4VSISUYGH7ZUBhWlHt0zIXhhXv43yeUxLzkKBJnjvIwC9ctzA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a591era-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:38 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UE60vx018396; Sun, 30 Jun 2024 19:40:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qc16cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:36 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJeaSO014044;
 Sun, 30 Jun 2024 19:40:36 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4028qc16cc-1; Sun, 30 Jun 2024 19:40:36 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 00/11] Live update: cpr-exec
Date: Sun, 30 Jun 2024 12:40:23 -0700
Message-Id: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406300157
X-Proofpoint-GUID: TLFcZrcx6DS6DsczQaJF9xhHYPtksruH
X-Proofpoint-ORIG-GUID: TLFcZrcx6DS6DsczQaJF9xhHYPtksruH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

What?

This patch series adds the live migration cpr-exec mode, which allows
the user to update QEMU with minimal guest pause time, by preserving
guest RAM in place, albeit with new virtual addresses in new QEMU, and
by preserving device file descriptors.

The new user-visible interfaces are:
  * cpr-exec (MigMode migration parameter)
  * cpr-exec-command (migration parameter)
  * anon-alloc (command-line option for -machine)

The user sets the mode parameter before invoking the migrate command.
In this mode, the user issues the migrate command to old QEMU, which
stops the VM and saves state to the migration channels.  Old QEMU then
exec's new QEMU, replacing the original process while retaining its PID.
The user specifies the command to exec new QEMU in the migration parameter
cpr-exec-command.  The command must pass all old QEMU arguments to new
QEMU, plus the -incoming option.  Execution resumes in new QEMU.

Memory-backend objects must have the share=on attribute, but
memory-backend-epc is not supported.  The VM must be started
with the '-machine anon-alloc=memfd' option, which allows anonymous
memory to be transferred in place to the new process.

Why?

This mode has less impact on the guest than any other method of updating
in place.  The pause time is much lower, because devices need not be torn
down and recreated, DMA does not need to be drained and quiesced, and minimal
state is copied to new QEMU.  Further, there are no constraints on the guest.
By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
and suspending plus resuming vfio devices adds multiple seconds to the
guest pause time.  Lastly, there is no loss of connectivity to the guest,
because chardev descriptors remain open and connected.

These benefits all derive from the core design principle of this mode,
which is preserving open descriptors.  This approach is very general and
can be used to support a wide variety of devices that do not have hardware
support for live migration, including but not limited to: vfio, chardev,
vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
to allow a descriptor to be used in a process that did not originally open it.

In a containerized QEMU environment, cpr-exec reuses an existing QEMU
container and its assigned resources.  By contrast, consider a design in
which a new container is created on the same host as the target of the
CPR operation.  Resources must be reserved for the new container, while
the old container still reserves resources until the operation completes.
Avoiding over commitment requires extra work in the management layer.
This is one reason why a cloud provider may prefer cpr-exec.  A second reason
is that the container may include agents with their own connections to the
outside world, and such connections remain intact if the container is reused.

How?

All memory that is mapped by the guest is preserved in place.  Indeed,
it must be, because it may be the target of DMA requests, which are not
quiesced during cpr-exec.  All such memory must be mmap'able in new QEMU.
This is easy for named memory-backend objects, as long as they are mapped
shared, because they are visible in the file system in both old and new QEMU.
Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
so the memfd's can be sent to new QEMU.  Pages that were locked in memory
for DMA in old QEMU remain locked in new QEMU, because the descriptor of
the device that locked them remains open.

cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
and by sending the unique name and value of each descriptor to new QEMU
via CPR state.

For device descriptors, new QEMU reuses the descriptor when creating the
device, rather than opening it again.  The same holds for chardevs.  For
memfd descriptors, new QEMU mmap's the preserved memfd when a ramblock
is created.

CPR state cannot be sent over the normal migration channel, because devices
and backends are created prior to reading the channel, so this mode sends
CPR state over a second migration channel that is not visible to the user.
New QEMU reads the second channel prior to creating devices or backends.

The exec itself is trivial.  After writing to the migration channels, the
migration code calls a new main-loop hook to perform the exec.

Example:

In this example, we simply restart the same version of QEMU, but in
a real scenario one would use a new QEMU binary path in cpr-exec-command.

  # qemu-kvm -monitor stdio -object
  memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
  -m 4G -machine anon-alloc=memfd ...

  QEMU 9.1.50 monitor - type 'help' for more information
  (qemu) info status
  VM status: running
  (qemu) migrate_set_parameter mode cpr-exec
  (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
  (qemu) migrate -d file:vm.state
  (qemu) QEMU 9.1.50 monitor - type 'help' for more information
  (qemu) info status
  VM status: running

This patch series implements a minimal version of cpr-exec.  Additional
series are ready to be posted to deliver the complete vision described
above, including
  * vfio
  * chardev
  * vhost
  * blockers
  * hostmem-memfd
  * migration-test cases

Works in progress include:
  * vdpa
  * iommufd
  * cpr-transfer mode

Changes since V1:
  * Dropped precreate and factory patches.  Added CPR state instead.
  * Dropped patches that refactor ramblock allocation
  * Dropped vmstate_info_void patch (peter)
  * Dropped patch "seccomp: cpr-exec blocker" (Daniel)
  * Redefined memfd-alloc option as anon-alloc
  * No longer preserve ramblock fields, except for fd (peter)
  * Added fd preservation functions in CPR state
  * Hoisted cpr code out of migrate_fd_cleanup (fabiano)
  * Revised migration.json docs (markus)
  * Fixed qtest failures (fabiano)
  * Renamed SAVEVM_FOREACH macros (fabiano)
  * Renamed cpr-exec-args as cpr-exec-command (markus)

The first 6 patches below are foundational and are needed for both cpr-exec
mode and cpr-transfer mode.  The last 5 patches are specific to cpr-exec
and implement the mechanisms for sharing state across exec.

Steve Sistare (11):
  machine: alloc-anon option
  migration: cpr-state
  migration: save cpr mode
  migration: stop vm earlier for cpr
  physmem: preserve ram blocks for cpr
  migration: fix mismatched GPAs during cpr
  oslib: qemu_clear_cloexec
  vl: helper to request exec
  migration: cpr-exec-command parameter
  migration: cpr-exec save and load
  migration: cpr-exec mode

 hmp-commands.hx                |   2 +-
 hw/core/machine.c              |  24 +++++
 include/exec/memory.h          |  12 +++
 include/hw/boards.h            |   1 +
 include/migration/cpr.h        |  35 ++++++
 include/qemu/osdep.h           |   9 ++
 include/sysemu/runstate.h      |   3 +
 migration/cpr-exec.c           | 180 +++++++++++++++++++++++++++++++
 migration/cpr.c                | 238 +++++++++++++++++++++++++++++++++++++++++
 migration/meson.build          |   2 +
 migration/migration-hmp-cmds.c |  25 +++++
 migration/migration.c          |  43 ++++++--
 migration/options.c            |  23 +++-
 migration/ram.c                |  17 +--
 migration/trace-events         |   5 +
 qapi/machine.json              |  14 +++
 qapi/migration.json            |  45 +++++++-
 qemu-options.hx                |  13 +++
 system/memory.c                |  22 +++-
 system/physmem.c               |  61 ++++++++++-
 system/runstate.c              |  29 +++++
 system/trace-events            |   3 +
 system/vl.c                    |   3 +
 util/oslib-posix.c             |   9 ++
 util/oslib-win32.c             |   4 +
 25 files changed, 792 insertions(+), 30 deletions(-)
 create mode 100644 include/migration/cpr.h
 create mode 100644 migration/cpr-exec.c
 create mode 100644 migration/cpr.c

-- 
1.8.3.1


