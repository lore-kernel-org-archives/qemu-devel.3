Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CB4C30653
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0TC-0007Uo-NH; Sun, 30 Jun 2024 15:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0T9-0007To-Gt
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0T5-0006Ou-TO
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:44:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJW3BW026542;
 Sun, 30 Jun 2024 19:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=be49iT
 RTz7JjUHbkbXHhonhfU2QiIhmR7fj7j+Mqe/0=; b=ezPYVZ9mv1UpqJfMNiYTMa
 Iwkv2XKp0UXT2k6iBhZoFVa9HBmttPbU+QS3buK7HuuYDKAfDGjbrhiAxvJcf50j
 gf7QpzoH6YALism8OtPTB9jkcdBR+hI1HTePfsclOWR4P1mqPNlSgBLSOhljxzhb
 u8Iyf/m6IFUEDsLRhAthYtD/P4qLiFW0KBfbmYppaOpeGwXmw838GBc5goYzCsPU
 i5SZbSSTxJi4dW9syD3KdpBTo1cPYx+LOMK51CNjQPl7SKISNIwgos9ztNeqTU+3
 vt7RJdZkUyk1GjPEG04OLKBgvk821jPY+jM4EZFJcdBB/WLDT2fzreM22OQp2/4Q
 ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0hgm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UFXWUl022941; Sun, 30 Jun 2024 19:44:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4028q5gg4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:44:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJg4f0039161;
 Sun, 30 Jun 2024 19:44:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 4028q5gg4e-1; Sun, 30 Jun 2024 19:44:08 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 0/6] Live update: cpr-transfer
Date: Sun, 30 Jun 2024 12:44:02 -0700
Message-Id: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0
 mlxlogscore=836 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406300157
X-Proofpoint-ORIG-GUID: xWB15QlPyv7YLqGWAXfExslhJOO0LCy5
X-Proofpoint-GUID: xWB15QlPyv7YLqGWAXfExslhJOO0LCy5
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

This patch series adds the live migration cpr-transfer mode, which
allows the user to transfer a guest to a new QEMU instance on the same
host.  It is identical to cpr-exec in most respects, except as described
below. 

The new user-visible interfaces are:
  * cpr-transfer (MigMode migration parameter)
  * cpr-uri (migration parameter)
  * cpr-uri (command-line argument)

In this mode, the user starts new QEMU on the same host as old QEMU, with
the same arguments as old QEMU, plus the -incoming and the -cpr-uri options.
The user issues the migrate command to old QEMU, which stops the VM, saves
state to the migration channels, and enters the postmigrate state.  Execution
resumes in new QEMU.

This mode requires a second migration channel, specified by the cpr-uri
migration property on the outgoing side, and by the cpr-uri QEMU command-line
option on the incoming side.  The channel must be a type, such as unix socket,
that supports SCM_RIGHTS.

This series depends on the series "Live update: cpr-exec mode".

Why?

cpr-transfer offers the same benefits as cpr-exec mode, but with a model
for launching new QEMU that may be more natural for some management packages.

How?

The file descriptors are kept open by sending them to new QEMU via the
cpr-uri, which must support SCM_RIGHTS.

Example:

In this example, we simply restart the same version of QEMU, but in
a real scenario one would use a new QEMU binary path in terminal 2.

  Terminal 1: start old QEMU
  # qemu-kvm -monitor stdio -object
  memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
  -m 4G -machine anon-alloc=memfd ...

  Terminal 2: start new QEMU
  # qemu-kvm ... -incoming unix:vm.sock -cpr-uri unix:cpr.sock

  Terminal 1:
  QEMU 9.1.50 monitor - type 'help' for more information
  (qemu) info status
  VM status: running
  (qemu) migrate_set_parameter mode cpr-transfer
  (qemu) migrate_set_parameter cpr-uri unix:cpr.sock
  (qemu) migrate -d unix:vm.sock
  (qemu) info status
  VM status: paused (postmigrate)

  Terminal 2:
  QEMU 9.1.50 monitor - type 'help' for more information
  (qemu) info status
  VM status: running

Steve Sistare (6):
  migration: SCM_RIGHTS for QEMUFile
  migration: VMSTATE_FD
  migration: cpr-transfer save and load
  migration: cpr-uri parameter
  migration: cpr-uri option
  migration: cpr-transfer mode

 include/migration/cpr.h        |  4 ++
 include/migration/vmstate.h    |  9 +++++
 migration/cpr-transfer.c       | 81 +++++++++++++++++++++++++++++++++++++++++
 migration/cpr.c                | 16 +++++++-
 migration/meson.build          |  1 +
 migration/migration-hmp-cmds.c | 10 +++++
 migration/migration.c          | 37 +++++++++++++++++++
 migration/options.c            | 29 +++++++++++++++
 migration/options.h            |  1 +
 migration/qemu-file.c          | 83 ++++++++++++++++++++++++++++++++++++++++--
 migration/qemu-file.h          |  2 +
 migration/ram.c                |  1 +
 migration/trace-events         |  2 +
 migration/vmstate-types.c      | 33 +++++++++++++++++
 qapi/migration.json            | 38 ++++++++++++++++++-
 qemu-options.hx                |  8 ++++
 stubs/vmstate.c                |  7 ++++
 system/vl.c                    |  3 ++
 18 files changed, 359 insertions(+), 6 deletions(-)
 create mode 100644 migration/cpr-transfer.c

-- 
1.8.3.1


