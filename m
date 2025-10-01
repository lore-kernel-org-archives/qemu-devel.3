Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8549CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yqu-0004T7-3X; Wed, 01 Oct 2025 11:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqg-0004Gs-EM
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqW-0006PY-Kt
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:33 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMwrN011417;
 Wed, 1 Oct 2025 15:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=DxkTeoAV2z6LUlTe
 15ZwnapqhTK33LHJztv5AZwLLMk=; b=TqQ0Hxetl/2uz5cKrj0ljuLWhivcheUg
 OAJH7hLiDysFl/OWhwhDEOEuIBirVowdgjedFb9UzfSRM3p7R/JyJFB1eSAIu4Rn
 vbMmyoQ0Qifuzq1sFxQgWbO1yHeEo16Nw99HlJ3OiQ19vb6TSFby+G7LewJzmICX
 yVYPepZTbjkjqT6ce+WixYA1i2dOzPBzeloJGiP/hTIqxAPBR9kLy3s17zHnGycU
 8RfK1HGMQl0xEhv5q2f0n0UolqWxlYgQSxId0NoY4RVRJBveWPhuKcOeg60YYw3q
 yF6zp7NoeO8h/O81G6ZATcdCYc1IyewQdWAKXnl1/M2Ph43n/IPdsQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmacspw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EjTV0023180; Wed, 1 Oct 2025 15:34:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCqc014790;
 Wed, 1 Oct 2025 15:34:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-1; Wed, 01 Oct 2025 15:34:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 00/19] Live update: cpr-exec
Date: Wed,  1 Oct 2025 08:33:52 -0700
Message-Id: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68dd49f6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=O4Y87kIHdoLMIBELOv4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WHigNE8GhTc6nSZIFEGC7sFqN97hxCNO
X-Proofpoint-GUID: WHigNE8GhTc6nSZIFEGC7sFqN97hxCNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX8tQsZD4j7RFv
 LMaiJDPpXPwulNy/9++lKhGViOcjgjBBT9gRrxS/04Y+i6RBGNarU2jBq2bDr9lQpHbSwJtMxkh
 ZAW7fm1uURrVBEF8crCJQ4xl/asCY3LpwZ6s59FQ3MJXA2bPtdZ1al+cyXTF0bm92DQKx9OxmSK
 At8tn1ssj0YBMTugpUie9ZoC3IUY1lvYf6hj1uI3+Hc1rFecF6Lawg9T5E5XvL+ScZxG28sulG8
 AfyjnJirMuFF0cP2sqUSVDhF4byNd9ZdSxQJHe1xcVqpqEJFrow4XEkwaoPKjr0N2WbFrRxeezU
 uUXmUhAxuaHuEbiCvv1yN3pgR5BmC8vHnLZK/ziWZb3sz86enPYTMgZoWVS1hIqyB5wuaAxM1cZ
 zGvAMB72OtUh/fBennQoFg0F5FJBKQ==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This patch series adds the live migration cpr-exec mode.

The new user-visible interfaces are:
  * cpr-exec (MigMode migration parameter)
  * cpr-exec-command (migration parameter)

cpr-exec mode is similar in most respects to cpr-transfer mode, with the
primary difference being that old QEMU directly exec's new QEMU.  The user
specifies the command to exec new QEMU in the migration parameter
cpr-exec-command.

Why?

In a containerized QEMU environment, cpr-exec reuses an existing QEMU
container and its assigned resources.  By contrast, cpr-transfer mode
requires a new container to be created on the same host as the target of
the CPR operation.  Resources must be reserved for the new container, while
the old container still reserves resources until the operation completes.
Avoiding over commitment requires extra work in the management layer.
This is one reason why a cloud provider may prefer cpr-exec.  A second reason
is that the container may include agents with their own connections to the
outside world, and such connections remain intact if the container is reused.

How?

cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
and by sending the unique name and value of each descriptor to new QEMU
via CPR state.

CPR state cannot be sent over the normal migration channel, because devices
and backends are created prior to reading the channel, so this mode sends
CPR state over a second migration channel that is not visible to the user.
New QEMU reads the second channel prior to creating devices or backends.

The exec itself is trivial.  After writing to the migration channels, the
migration code calls a new main-loop hook to perform the exec.

Example:

In this example, we simply restart the same version of QEMU, but in
a real scenario one would use a new QEMU binary path in cpr-exec-command.

  # qemu-kvm -monitor stdio
  -object memory-backend-memfd,id=ram0,size=1G
  -machine memory-backend=ram0 -machine aux-ram-share=on ...

  QEMU 10.1.50 monitor - type 'help' for more information
  (qemu) info status
  VM status: running
  (qemu) migrate_set_parameter mode cpr-exec
  (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
  (qemu) migrate -d file:vm.state

  (qemu) QEMU 10.1.50 monitor - type 'help' for more information
  (qemu) info status
  VM status: running

Changes in V5:
  * included error-report.h, and used qemu_memfd_create to fix windows build
  * documented cpr-exec environment variable in CPR.rst
  * fixed err leak
  * defined cpr_exec_unpreserve_fds helper
  * misc cosmetic changes in cpr-exec.c
  * added patches from the series "migration-test: test cpr-exec", with
    comments addressed:
    - renamed qts parameter
    - fixed migrate_args bug
    - added code comments
    - re-privatized QEMU_ENV_DST
    - added RB's

Steve Sistare (19):
  migration: multi-mode notifier
  migration: add cpr_walk_fd
  oslib: qemu_clear_cloexec
  migration: cpr-exec-command parameter
  migration: cpr-exec save and load
  migration: cpr-exec mode
  migration: cpr-exec docs
  vfio: cpr-exec mode
  tests/qtest: export qtest_qemu_binary
  tests/qtest: qtest_qemu_args
  tests/qtest: qtest_create_test_state
  tests/qtest: qtest_qemu_spawn_func
  tests/qtest: qtest_init_after_exec
  migration-test: only_source option
  migration-test: shm path accessor
  migration-test: misc exports
  migration-test: migrate_args
  migration-test: strv parameter
  migration-test: test cpr-exec

 docs/devel/migration/CPR.rst          | 112 +++++++++++++++++++-
 qapi/migration.json                   |  46 ++++++++-
 include/migration/cpr.h               |  10 ++
 include/migration/misc.h              |  12 +++
 include/qemu/osdep.h                  |   9 ++
 tests/qtest/libqtest.h                |  25 +++++
 tests/qtest/migration/bootfile.h      |   1 +
 tests/qtest/migration/framework.h     |   5 +
 tests/qtest/migration/migration-qmp.h |   2 +
 hw/vfio/container.c                   |   3 +-
 hw/vfio/cpr-iommufd.c                 |   3 +-
 hw/vfio/cpr-legacy.c                  |   9 +-
 hw/vfio/cpr.c                         |  13 +--
 migration/cpr-exec.c                  | 188 ++++++++++++++++++++++++++++++++++
 migration/cpr.c                       |  36 ++++++-
 migration/migration-hmp-cmds.c        |  30 ++++++
 migration/migration.c                 |  70 ++++++++++---
 migration/options.c                   |  14 +++
 migration/ram.c                       |   1 +
 migration/vmstate-types.c             |   8 ++
 system/vl.c                           |   4 +-
 tests/qtest/libqtest.c                | 108 +++++++++++++------
 tests/qtest/migration/bootfile.c      |   5 +
 tests/qtest/migration/cpr-tests.c     | 133 ++++++++++++++++++++++++
 tests/qtest/migration/framework.c     | 101 ++++++++++++------
 tests/qtest/migration/migration-qmp.c |  16 +++
 util/oslib-posix.c                    |   9 ++
 util/oslib-win32.c                    |   4 +
 hmp-commands.hx                       |   2 +-
 migration/meson.build                 |   1 +
 migration/trace-events                |   1 +
 31 files changed, 879 insertions(+), 102 deletions(-)
 create mode 100644 migration/cpr-exec.c

-- 
1.8.3.1


