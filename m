Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A50CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umba4-0005SY-W8; Thu, 14 Aug 2025 13:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba3-0005SJ-EP
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba0-0002p1-DL
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECg1Oh020035;
 Thu, 14 Aug 2025 17:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=LBGK4jyfgmo63h1o
 Wx80IV0SJODHC3KV8pAWV90RkRU=; b=UItmhpJ3eZOZ/ITCOyg6tkIm3eJVnRJF
 885P7vNb6pGuBfm7m79PJZTD/88nQFkVsU1CK7NASKMEe5htqgs0unA/QzgFhXD0
 lG4tYHcY8r7wpZ+nEOUBvqMyUiYbCl44qVZVLnoxwCoAdDsjxXqPlqOWx/ISrxJH
 Tz3ckzZrV9vNRa4eVPVc3S+QXtn1WKcaN72hvwzExJal5Wla6uIJ2jHFlrEQWx5z
 NNJtv8eegqQmxM83Jd2wScqOMnvuuKVzh36y23+vJZo36c7gzg3assBit0wtOvi8
 GIN6aPwOVFX2lbxJQWc8hiLCEza3y1G1FHZck97M5dcF0jYDSjPo4A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4jha9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EGK7MM010478; Thu, 14 Aug 2025 17:17:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvskbrxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57EHGwu6038225;
 Thu, 14 Aug 2025 17:17:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvskbrx5-1; Thu, 14 Aug 2025 17:17:25 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 0/9] Live update: cpr-exec
Date: Thu, 14 Aug 2025 10:17:14 -0700
Message-Id: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0OCBTYWx0ZWRfX1VoOYUqO9thz
 FVsGhF1EDLmlNR8Rt6C2twbsxmmWnOUHmckK0Fvg34PC+klMmVStoCBbhQG9JRR6bSh6tLbKl9r
 z3jMDD2d6dpDIiI6cScIpt90ijf4kD3WPdRVfkwRefoubsSeACPNT4QexiNtnOgWgpCwiwhLy/h
 gXzAgni3LECDz/oWCwUPbdvZ2hqDT1DYWKaKm1TIf22AJmEWqLalI24ig8CzsIn6+5FDc0kx4dO
 gpUmOojyPnLTzfNKlzAVjNM9vPdzSpEkZW1Pa/SZfsLEvh3c8YMwJm3xKL9dK6z6hJ8ub0hKoO+
 G4uf37RgdAyyp8Gw/FYgUFiHCetkacZXQYiXpy/p1axAFMvs/yQkXKMv95d0ChvYqNO9DP6SUp8
 cnUNlLRS6QholVBm6j8+wsNJ1lt9tibA34vPNwwlmBKWUquNHGt7loa5p8gFTYjvcOyK07fO
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689e1a27 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=kcL-enJz2Ef4lsWIegwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: D0uLu19foeJZSLgSvd6pl9eRcitYhPMO
X-Proofpoint-ORIG-GUID: D0uLu19foeJZSLgSvd6pl9eRcitYhPMO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Steve Sistare (9):
  migration: multi-mode notifier
  migration: add cpr_walk_fd
  oslib: qemu_clear_cloexec
  vl: helper to request exec
  migration: cpr-exec-command parameter
  migration: cpr-exec save and load
  migration: cpr-exec mode
  migration: cpr-exec docs
  vfio: cpr-exec mode

 docs/devel/migration/CPR.rst   | 103 ++++++++++++++++++++++++-
 qapi/migration.json            |  46 ++++++++++-
 include/migration/cpr.h        |   9 +++
 include/migration/misc.h       |  12 +++
 include/qemu/osdep.h           |   9 +++
 include/system/runstate.h      |   3 +
 hw/vfio/container.c            |   3 +-
 hw/vfio/cpr-iommufd.c          |   3 +-
 hw/vfio/cpr-legacy.c           |   9 ++-
 hw/vfio/cpr.c                  |  13 ++--
 migration/cpr-exec.c           | 168 +++++++++++++++++++++++++++++++++++++++++
 migration/cpr.c                |  39 +++++++++-
 migration/migration-hmp-cmds.c |  25 ++++++
 migration/migration.c          |  70 +++++++++++++----
 migration/options.c            |  14 ++++
 migration/ram.c                |   1 +
 migration/vmstate-types.c      |   8 ++
 system/runstate.c              |  29 +++++++
 util/oslib-posix.c             |   9 +++
 util/oslib-win32.c             |   4 +
 hmp-commands.hx                |   2 +-
 migration/meson.build          |   1 +
 migration/trace-events         |   1 +
 23 files changed, 548 insertions(+), 33 deletions(-)
 create mode 100644 migration/cpr-exec.c

-- 
1.8.3.1


