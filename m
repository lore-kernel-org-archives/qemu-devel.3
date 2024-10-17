Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFB9D374A9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SCr-00075U-7V; Thu, 17 Oct 2024 11:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCp-00074r-GM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCn-00013I-KS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBdpI000302;
 Thu, 17 Oct 2024 15:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2023-11-20; bh=n2jyMnxa
 ZtbkIgyEE0HE4pfchrWhkrfJNQvpORfedj0=; b=bKCRutFu6AHW9RBVec0jyKvO
 MIkpdJri98HFDEPOkFE4TA5hg73SRIMG/j+ysU2L/vwQorrnYGkqqBOMQwK06a3y
 J1Y4NzseUKUlUpSH4X17cclk24qt3HZEa/GtsixB2wZpyrgbRXiXI+0Ekxuu4cPa
 k6NQgTYEsZkPhlBs7ZdFqSPCJf1nL6WqOKrIFdzlpT9f8/wo1xTMPU+tKaccO9Cj
 5M5TcxUbiZB8+OMSfTO358IQABnRVIxJWU49RRusSkMVZr9UAlOfEKqSatoSPI7L
 WFVRwiR9Hx4cOTt3KpUbqhqXVFGBFcSvfSRs0ONoJwMoAYNTcqpZWTwziitKxA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09p4hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HEfFFl027182; Thu, 17 Oct 2024 15:14:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy63c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:17 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgR017147;
 Thu, 17 Oct 2024 15:14:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-1; Thu, 17 Oct 2024 15:14:17 +0000
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
Subject: [RFC V1 00/14] precreate phase
Date: Thu, 17 Oct 2024 08:14:01 -0700
Message-Id: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170105
X-Proofpoint-GUID: tFdCHiLWBFP7EF8Aj4pB2_VBKPaFdZzn
X-Proofpoint-ORIG-GUID: tFdCHiLWBFP7EF8Aj4pB2_VBKPaFdZzn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define a new qemu initialization phase called 'precreate' which occurs
before most backends or devices have been created.  The only exception
is monitor and qtest devices and their associated chardevs.

QEMU runs in the main loop during this phase.  Monitor connections are
active and can receive migration configuration commands.  QEMU starts
listening on the normal migration URI during this phase, which can come
from either the QEMU command line or from a migrate_incoming command.
Thus the user can issue query-migrate to get the socket-address for
dynamically allocated port numbers during precreate.

In this series QEMU passes through and does not linger in the precreate
phase, and the user sees no change in behavior.  The cpr-transfer series
will linger in the phase for an incoming CPR operation, and exit the phase
when the migrate command is send to source QEMU and causes destination QEMU
to read CPR state.

A future series may wish to add a command-line argument and monitor
command that enters and exits the precreate phase for general purpose use.
That would enable the user to issue monitor commands that specify backend
creation parameters.

Now that both the monitor and migration are initialized early, one could
implement a future scheme in which very few parameters are passed on the
command line, and all backend and device creation parameters are passed
in the migration stream.

Patches 1-5 untangle dependencies between accelerator and migration
initialization, allowing the latter to be called earlier.  Currently
configure_accelerators chooses the accelerator, defines compatability
properties needed to initialize migration, and creates the machine in
accel_init_machine.  The patches split configure_accelerators into a first
part which probes for accelerators and defines properties, and a second
part which creates the machine.  The second part is called after the
precreate phase.  The patches also set machine options earlier, so they
are known when migration is initialized.

Patch 6 defines the boundaries of the precreate phase.

Patches 7-12 define and use helper functions to extract monitor and qtest
options from the command line, find their associated chardevs, and initialize
the monitor and qtest devices early, prior to qemu_create_early_backends.

Patches 13-14 contain miscellany.

Steve Sistare (14):
  accel: encapsulate search state
  accel: accel preinit function
  accel: split configure_accelerators
  accel: set accelerator and machine props earlier
  migration: init and listen during precreate
  vl: precreate phase
  monitor: chardev name
  qom: get properties
  qemu-option: filtered foreach
  qemu-options: pass object to filter
  monitor: connect in precreate
  qtest: connect in precreate
  net: cleanup for precreate phase
  migration: allow commands during precreate and preconfig

 accel/accel-system.c            |   2 -
 accel/kvm/kvm-all.c             |  58 +++++----
 accel/xen/xen-all.c             |  11 +-
 hmp-commands.hx                 |   2 +
 include/monitor/monitor.h       |   1 +
 include/qapi/visitor.h          |   1 +
 include/qemu/accel.h            |   1 +
 include/qemu/option.h           |   5 +
 include/qom/object_interfaces.h |   8 ++
 monitor/monitor.c               |  21 ++++
 net/net.c                       |   4 +-
 qapi/migration.json             |  16 ++-
 qapi/misc.json                  |   3 +-
 qom/object_interfaces.c         |  27 ++--
 system/vl.c                     | 270 ++++++++++++++++++++++++++++++----------
 target/i386/nvmm/nvmm-all.c     |  10 +-
 target/i386/whpx/whpx-all.c     |  14 ++-
 util/qemu-option.c              |  25 ++++
 18 files changed, 358 insertions(+), 121 deletions(-)

-- 
1.8.3.1


