Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB876E93804
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 21:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC2hL-0002Bg-EF; Sun, 12 Apr 2026 17:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wC2hI-0002An-Hm; Sun, 12 Apr 2026 17:50:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wC2hE-00057K-VY; Sun, 12 Apr 2026 17:50:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CLVILI3436650; Sun, 12 Apr 2026 21:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=spRkDCBfOC7IaO5PzYSbyRVYXQjEqq/aU0nWQvqBi
 TI=; b=qHTdyPuOQFRAFXBbnliZcQ88zzuSrMnEJH+0F4zTljSB93b7c/D9juPDQ
 /WaasqY/dfeoWHaqbL55rashpA1zGQcnhKrfRinqppQUMANW0YTaRczmibHQdaqz
 kzY/X2IFNVQ7y6KncWKtM8pmQo4Cwu04SpC4CUESpN9LTVJtpBcggOPZUicAzdEe
 Fa3LPCk03M5eDoZh7nQ6prdLgaQ9qAnqpBa+ZicSjdG8QJELKSPGijFuEk3imEsg
 yRJS2IAlwa4hhJ8lfTBrRUhEywA+wI6oCcl7+ea4mdWnygnZqNiyGK2AUI2JUhi7
 hHVZlAcQJfylKlfPSZM/61fd4iosw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3n4w0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 21:50:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63CGg09h025803;
 Sun, 12 Apr 2026 21:50:17 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1ag4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 21:50:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63CLoFBs29033126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 12 Apr 2026 21:50:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE67D58052;
 Sun, 12 Apr 2026 21:50:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B08D58045;
 Sun, 12 Apr 2026 21:50:15 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.240.32])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 12 Apr 2026 21:50:15 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 mjrosato@linux.ibm.com, farman@linux.ibm.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v4 0/3] improve aio-polling efficiency
Date: Sun, 12 Apr 2026 16:50:08 -0500
Message-ID: <20260412215011.326196-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B28Jx6yaotJXEcStxM9LcLK7w804wZPm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDIxNCBTYWx0ZWRfX2fUG0XBqN14J
 fUEBWHmbg+XX06NbCP8KRO0MruNy8GCEJ3oBfyogS/nRcl2GhUA2EuvDwsW39UQWN4Qrj+oy38k
 AN3mJmFeNWqg77/SJIQvrKpiGZAtHKa6hQNujtFsXlAULsHXKJhjT9xF08zvL093uicbv3+3xE2
 23N39c2Snl4fJm8grO0uy68CQ1qpzS4ccEH4sAXfKK9IW/iNUbrFwyVR+T35Bs3FL3uYv7twdeJ
 i0M+5HCLiwooS8Wr7LFZYPKobHV2e43lT5xTfWBb5S2nnpLtXfjWx3FrEcoM7NHjpRwA/0CmRcm
 RBCpHZCW7IRlVJdlXkUFhGcuLvAmKdHGQWUxJS6dNVNKwUxMpASXsocuVmOKPEQqZlqRWO8kpx8
 89zlB2DfdZVw8Hr+TefZxdL2w9gKUbbQVjeIz6Ao/MREOvaTeWQ3BqDnz+LUBT5l66k2ei1SON3
 S47F4TbP7sLkk1mvs4Q==
X-Proofpoint-GUID: B28Jx6yaotJXEcStxM9LcLK7w804wZPm
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69dc139a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-wZDFzhax2tZ4RQJR_4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120214
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Dear all,

This is v4 of the patch series to refine aio_poll adaptive polling
logic for better CPU efficiency.

v1: https://lore.kernel.org/qemu-devel/20260113174824.464720-1-jhkim@linux.ibm.com/
v2: https://lore.kernel.org/qemu-devel/20260323135451.579655-1-jhkim@linux.ibm.com/
v3: https://lore.kernel.org/qemu-devel/20260405200735.3075407-1-jhkim@linux.ibm.com/

Changes in v4:
- Patch 2/3: Added detailed validation tables showing poll.ns statistics
  across different poll_weight values (1-5) for SSD randread/randwrite
  workloads to demonstrate algorithm behavior and justify poll_weight=3
  as the optimal default.

- Patch 3/3: Fixed commit message to correctly reference
  adjust_polling_time() instead of the removed grow_polling_time()
  and shrink_polling_time() functions from v2.

Changes in v3:
- Patch 1/3: Removed timeout check in aio_poll() as suggested by
  Stefan Hajnoczi.

- Patch 2/3: Major refactoring based on review feedback:
  * Removed has_event and renamed poll_idle_timeout to
    last_dispatch_timestamp from AioHandler structure to identify
    active handlers.
  * Merged grow_polling_time() and shrink_polling_time() into single
    adjust_polling_time() function to simplify code review, with no
    functional changes.
  * Renamed adjust_block_ns() to update_handler_poll_times()
  * Modified remove_idle_poll_handlers() to use last_dispatch_timestamp
    directly instead of checking poll_idle_timeout
  * Updated commit message

- Patch 3/3: Enhanced parameter handling:
  * Moved IOTHREAD_POLL_*_DEFAULT constants to iothread.h header
  * Added validation for poll-weight range [0, 63] in iothread.c
  * Added the divide-by-0 protection in aio_context_set_poll_params()
  * Updated QAPI version from 10.2 to 11.1
  * Enhanced qom.json documentation for poll-weight values

This series reduces CPU usage in aio_poll adaptive polling by ~10%
with minimal throughput impact (~2%). Tested on s390x with various
workloads.

Testing details:

Initial testing (Fedora 42, 16 virtio-blk devices, FCP multipath):
 - Throughput: -3% to -8% (1 iothread), -2% to -5% (2 iothreads)
 - CPU usage: -10% to -25% (1 iothread), -7% to -12% (2 iothreads)

Additional validation (RHEL 10.1 + QEMU 10.0.0, FCP/FICON, 1-8 iothreads):
 - Throughput: -2.2% (weight=3), -2.4% (weight=2)
 - CPU usage: -9.4% (weight=3), -10.9% (weight=2)

Weight=3 selected for slightly better throughput while maintaining
substantial CPU savings.

Best regards,
Jaehoon Kim

Jaehoon Kim (3):
  aio-poll: avoid unnecessary polling time computation
  aio-poll: refine iothread polling using weighted handler intervals
  qapi/iothread: introduce poll-weight parameter for aio-poll

 include/qemu/aio.h                |   7 +-
 include/system/iothread.h         |  18 ++++
 iothread.c                        |  47 +++++++---
 monitor/hmp-cmds.c                |   1 +
 qapi/misc.json                    |   7 ++
 qapi/qom.json                     |  10 +-
 qemu-options.hx                   |   7 +-
 tests/unit/test-nested-aio-poll.c |   2 +-
 util/aio-posix.c                  | 148 ++++++++++++++++++------------
 util/aio-posix.h                  |   2 +-
 util/aio-win32.c                  |   3 +-
 util/async.c                      |   2 +
 12 files changed, 176 insertions(+), 78 deletions(-)

-- 
2.50.1


