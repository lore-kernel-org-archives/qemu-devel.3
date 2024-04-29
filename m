Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689FAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMG-0004XD-HO; Mon, 29 Apr 2024 11:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM6-0004TT-62
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM0-0005D4-EY
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmn2A023135; Mon, 29 Apr 2024 15:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=2Rd8r3yWz42QxscMfkPfYPowQLLKy2ise7H7MzCvjUk=;
 b=R8giyRi3pMZcffahRwvU8O9M8tVvokE+2+WvKufNEOLYO+mBa1jlAJrSmFVTB2dcQG+X
 tE3zirFskMJKIUMqqtt5nZVhLe+hdlT0/e1kNPvhZ9tLHiuUFNC+73cd8heRa04tGsrr
 z+Rsv0MqJLp0qXAxnIlFYwaOZz5836d90Tx/X+np9Ua/LmWJUR0ZB/as1xYAvp5BD9Tg
 3hrFnn54OMATRpGWDSMqC91tr89o3siAT2i3lCNLKSTNFLiO6HxUMe++R1BvswXrAova
 Gkh09jc3XsLlmkdvm4Lgb51yr8FaljpBfaGHkPRygDvrDdYZbADZN73J5+IOVTqQBbt0 OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv2wb1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:37 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEgDmG011440; Mon, 29 Apr 2024 15:55:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j60f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGS034442;
 Mon, 29 Apr 2024 15:55:36 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-1; Mon, 29 Apr 2024 15:55:36 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 00/26] Live update: cpr-exec
Date: Mon, 29 Apr 2024 08:55:09 -0700
Message-Id: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290101
X-Proofpoint-GUID: 45ZVd1Ql1KcSN6rllZNC6Mcpv1j-dkxL
X-Proofpoint-ORIG-GUID: 45ZVd1Ql1KcSN6rllZNC6Mcpv1j-dkxL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch series adds the live migration cpr-exec mode.  In this mode, QEMU
stops the VM, writes VM state to the migration URI, and directly exec's a
new version of QEMU on the same host, replacing the original process while
retaining its PID.  Guest RAM is preserved in place, albeit with new virtual
addresses.  The user completes the migration by specifying the -incoming
option, and by issuing the migrate-incoming command if necessary.  This
saves and restores VM state, with minimal guest pause time, so that QEMU may
be updated to a new version in between.

The new interfaces are:
  * cpr-exec (MigMode migration parameter)
  * cpr-exec-args (migration parameter)
  * memfd-alloc=on (command-line option for -machine)
  * only-migratable-modes (command-line argument)

The caller sets the mode parameter before invoking the migrate command.

Arguments for the new QEMU process are taken from the cpr-exec-args parameter.
The first argument should be the path of a new QEMU binary, or a prefix
command that exec's the new QEMU binary, and the arguments should include
the -incoming option.

Memory backend objects must have the share=on attribute, and must be mmap'able
in the new QEMU process.  For example, memory-backend-file is acceptable,
but memory-backend-ram is not.

QEMU must be started with the '-machine memfd-alloc=on' option.  This causes
implicit RAM blocks (those not explicitly described by a memory-backend
object) to be allocated by mmap'ing a memfd.  Examples include VGA, ROM,
and even guest RAM when it is specified without without reference to a
memory-backend object.   The memfds are kept open across exec, their values
are saved in vmstate which is retrieved after exec, and they are re-mmap'd.

The '-only-migratable-modes cpr-exec' option guarantees that the
configuration supports cpr-exec.  QEMU will exit at start time if not.

Example:

In this example, we simply restart the same version of QEMU, but in
a real scenario one would set a new QEMU binary path in cpr-exec-args.

  # qemu-kvm -monitor stdio -object
  memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
  -m 4G -machine memfd-alloc=on ...

  QEMU 9.1.50 monitor - type 'help' for more information
  (qemu) info status
  VM status: running
  (qemu) migrate_set_parameter mode cpr-exec
  (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming file:vm.state
  (qemu) migrate -d file:vm.state
  (qemu) QEMU 9.1.50 monitor - type 'help' for more information
  (qemu) info status
  VM status: running

cpr-exec mode preserves attributes of outgoing devices that must be known
before the device is created on the incoming side, such as the memfd descriptor
number, but currently the migration stream is read after all devices are
created.  To solve this problem, I add two VMStateDescription options:
precreate and factory.  precreate objects are saved to their own migration
stream, distinct from the main stream, and are read early by incoming QEMU,
before devices are created.  Factory objects are allocated on demand, without
relying on a pre-registered object's opaque address, which is necessary
because the devices to which the state will apply have not been created yet
and hence have not registered an opaque address to receive the state.

This patch series implements a minimal version of cpr-exec.  Future series
will add support for:
  * vfio
  * chardev's without loss of connectivity
  * vhost
  * fine-grained seccomp controls
  * hostmem-memfd
  * cpr-exec migration test


Steve Sistare (26):
  oslib: qemu_clear_cloexec
  vl: helper to request re-exec
  migration: SAVEVM_FOREACH
  migration: delete unused parameter mis
  migration: precreate vmstate
  migration: precreate vmstate for exec
  migration: VMStateId
  migration: vmstate_info_void_ptr
  migration: vmstate_register_named
  migration: vmstate_unregister_named
  migration: vmstate_register at init time
  migration: vmstate factory object
  physmem: ram_block_create
  physmem: hoist guest_memfd creation
  physmem: hoist host memory allocation
  physmem: set ram block idstr earlier
  machine: memfd-alloc option
  migration: cpr-exec-args parameter
  physmem: preserve ram blocks for cpr
  migration: cpr-exec mode
  migration: migrate_add_blocker_mode
  migration: ram block cpr-exec blockers
  migration: misc cpr-exec blockers
  seccomp: cpr-exec blocker
  migration: fix mismatched GPAs during cpr-exec
  migration: only-migratable-modes

 accel/xen/xen-all.c            |   5 +
 backends/hostmem-epc.c         |  12 +-
 hmp-commands.hx                |   2 +-
 hw/core/machine.c              |  22 +++
 hw/core/qdev.c                 |   1 +
 hw/intc/apic_common.c          |   2 +-
 hw/vfio/migration.c            |   3 +-
 include/exec/cpu-common.h      |   3 +-
 include/exec/memory.h          |  15 ++
 include/exec/ramblock.h        |  10 +-
 include/hw/boards.h            |   1 +
 include/migration/blocker.h    |   7 +
 include/migration/cpr.h        |  14 ++
 include/migration/misc.h       |  11 ++
 include/migration/vmstate.h    | 133 +++++++++++++++-
 include/qemu/osdep.h           |   9 ++
 include/sysemu/runstate.h      |   3 +
 include/sysemu/seccomp.h       |   1 +
 include/sysemu/sysemu.h        |   1 -
 migration/cpr.c                | 131 ++++++++++++++++
 migration/meson.build          |   3 +
 migration/migration-hmp-cmds.c |  50 +++++-
 migration/migration.c          |  48 +++++-
 migration/migration.h          |   5 +-
 migration/options.c            |  13 ++
 migration/precreate.c          | 139 +++++++++++++++++
 migration/ram.c                |  16 +-
 migration/savevm.c             | 306 +++++++++++++++++++++++++++++-------
 migration/savevm.h             |   3 +
 migration/trace-events         |   7 +
 migration/vmstate-factory.c    |  78 ++++++++++
 migration/vmstate-types.c      |  24 +++
 migration/vmstate.c            |   3 +-
 qapi/migration.json            |  48 +++++-
 qemu-options.hx                |  22 ++-
 replay/replay.c                |   6 +
 stubs/migr-blocker.c           |   5 +
 stubs/vmstate.c                |  13 ++
 system/globals.c               |   1 -
 system/memory.c                |  19 ++-
 system/physmem.c               | 346 +++++++++++++++++++++++++++--------------
 system/qemu-seccomp.c          |  10 +-
 system/runstate.c              |  29 ++++
 system/trace-events            |   4 +
 system/vl.c                    |  26 +++-
 target/s390x/cpu_models.c      |   4 +-
 util/oslib-posix.c             |   9 ++
 util/oslib-win32.c             |   4 +
 48 files changed, 1417 insertions(+), 210 deletions(-)
 create mode 100644 include/migration/cpr.h
 create mode 100644 migration/cpr.c
 create mode 100644 migration/precreate.c
 create mode 100644 migration/vmstate-factory.c

-- 
1.8.3.1


