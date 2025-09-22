Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D56CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gvi-0000Uf-Es; Mon, 22 Sep 2025 09:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gve-0000SB-AN
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvT-0001tU-5s
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:06 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NNjL029543;
 Mon, 22 Sep 2025 13:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=POhOhOxyD143gRYB
 obaNPqEEqO+F3uKC5lLMnhpfznc=; b=e+VIxY5YirPI6dsMD2fPSPMosUAHo+8w
 yQIib8BMeewf7nu+IIYyBbtFkM+f8opNBTcdb1Wiy81+UTIegXyIoct0YaNsd9mH
 nz3YPVPUA+UA5ceILR9S6qEuUwxIHZ0GiPZc0iAvNXpZEmjGSw7Uv3rUuL5E9Kda
 OZGAiAn0D4ujoV1ABb/WaOLPbR81jQgNiPOFZhGOjU/GPEt+hq7nBzDZsdcnLBoh
 ozplTLyl4Iwv66sFSmTCAPSo76VwOkb6qTC4bTsMQKdpq50CyLu5EOgxH7L0s+Lz
 ldBF5THGI1tcjY4vxCrld+Z2HSHAFsTMuj3s2gxelP+U128O34ng8g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k23agd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MCKUP8034410; Mon, 22 Sep 2025 13:49:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhan7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58MDnlWB004351;
 Mon, 22 Sep 2025 13:49:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49a6nhan6x-1; Mon, 22 Sep 2025 13:49:47 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 0/8] Live update: cpr-exec
Date: Mon, 22 Sep 2025 06:49:37 -0700
Message-Id: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220135
X-Authority-Analysis: v=2.4 cv=C5XpyRP+ c=1 sm=1 tr=0 ts=68d153fd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VsTg9rq-Wku7RHCzQ2gA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: wlMeApFBorKq6v5jKLEY9yh3gXeRlTiw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNiBTYWx0ZWRfX2LBewYj4AXlb
 Zhr8qjqiEfBms7iUBHljSAEAQgYyzPSoHbWInlKJV/ob/2Th7w7VxX9GV2xLmcMZ1pCDtEgqHyB
 9RiAVWC8IiKHJS8oM14y3tBqazsy7gcoWlc3a6l6G5aIgnbzdmPv8kLYtEY9oLgr6prrEUcHS8D
 BzVG1iM4VamuykP04lYkc76Oz3i+q7xGHuMV/8F2RUFJm0sf1Vq3kRCCH/FtSvGfQEmVt38CAv3
 iYhEdNQWyD5FTmhLlPrgXVbEcfnLwUc9YJiX2pkuFETbBP7dKmftJjjo33BRSF0kEM8nf8vKqR9
 tMk0EMlHSe/UmvXaKbPSLfUQZmaBMoHmcS1bVYoWDqWjMGYYHlsOpnm07357wC3ZPrRGwEHMqaE
 IFLSfraaSGTH/C9zbCj+x08qwKxtDg==
X-Proofpoint-ORIG-GUID: wlMeApFBorKq6v5jKLEY9yh3gXeRlTiw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Changes in V2:
  * dropped patch "helper to request exec" and use a BH to exec
  * used g_shell_parse_argv for cpr-exec-command parameter
  * fixed check for channel in cpr_state_load
  * tweaked QAPI docs, developer docs, and code comments
  * fixed doc: rename cpr-exec-args -> cpr-exec-command

Steve Sistare (8):
  migration: multi-mode notifier
  migration: add cpr_walk_fd
  oslib: qemu_clear_cloexec
  migration: cpr-exec-command parameter
  migration: cpr-exec save and load
  migration: cpr-exec mode
  migration: cpr-exec docs
  vfio: cpr-exec mode

 docs/devel/migration/CPR.rst   | 106 +++++++++++++++++++++++-
 qapi/migration.json            |  46 ++++++++++-
 include/migration/cpr.h        |   9 +++
 include/migration/misc.h       |  12 +++
 include/qemu/osdep.h           |   9 +++
 hw/vfio/container.c            |   3 +-
 hw/vfio/cpr-iommufd.c          |   3 +-
 hw/vfio/cpr-legacy.c           |   9 ++-
 hw/vfio/cpr.c                  |  13 +--
 migration/cpr-exec.c           | 178 +++++++++++++++++++++++++++++++++++++++++
 migration/cpr.c                |  41 +++++++++-
 migration/migration-hmp-cmds.c |  30 +++++++
 migration/migration.c          |  70 ++++++++++++----
 migration/options.c            |  14 ++++
 migration/ram.c                |   1 +
 migration/vmstate-types.c      |   8 ++
 system/vl.c                    |   4 +-
 util/oslib-posix.c             |   9 +++
 util/oslib-win32.c             |   4 +
 hmp-commands.hx                |   2 +-
 migration/meson.build          |   1 +
 migration/trace-events         |   1 +
 22 files changed, 538 insertions(+), 35 deletions(-)
 create mode 100644 migration/cpr-exec.c

base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
-- 
1.8.3.1


