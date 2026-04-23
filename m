Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB7FDEE47
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG0Cz-0001Ph-NC; Thu, 23 Apr 2026 15:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wG0Cx-0001OF-7G; Thu, 23 Apr 2026 15:59:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wG0Cv-0003GG-GV; Thu, 23 Apr 2026 15:59:30 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NIhErX3944376; Thu, 23 Apr 2026 19:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ahhCUDaFRHbPzr71XPzfQgNefJBpuP6TRTvpbqK1j
 yM=; b=bsfIcZf2Mk+l/JoFTyrsIDde1Q/L/mXsiJpoiIhHsZJuaGk5OY37X+wyr
 DUPwtKBNGwmf7obKc7iy5X4YrUcxXsAAooBUrZZisaY2TslgR+R4acNKvEH+TVOL
 2ogWaMY8n0veSMT+tGDQHlPxzv8FPhaaETg2lprCED+WsDxQj7VJrXeVpbC+xYce
 ms5DPLAv7Yx9CBcNn67AZBS2ggUjz4NUky2oGr6AD1tX07b5RKCL4mvp/bsDQHni
 ZTrFsRvTR9W92hqSKR3KaNYQ8Ms+RI4yP0slwPUulH0iXQhUA0ytjJt6i41L8MfD
 XKf0rSnXEMzGxt9oL4OZJFTTxaTmg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3sx71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 19:59:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NJohWT016868;
 Thu, 23 Apr 2026 19:59:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyg4ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 19:59:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NJxMAB22479464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 19:59:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B19245805E;
 Thu, 23 Apr 2026 19:59:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74B8658056;
 Thu, 23 Apr 2026 19:59:22 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.254.253])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 19:59:22 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 mjrosato@linux.ibm.com, farman@linux.ibm.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v5 0/3] improve aio-polling efficiency
Date: Thu, 23 Apr 2026 14:59:15 -0500
Message-ID: <20260423195918.661299-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oQKc6Stj115SwIsGZ-APviHRT3_heYpH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE5MyBTYWx0ZWRfX+oTYUIicrfeE
 OvHul+pML5aipCYweDI2/6imFPnIjtQY7AwuSX1LzJ4bsvjOtoxGne/bDyxHKxnmZpm+2IhgMI2
 OO00uAjppAv0v9+KE8nwjYQ1qoIyls96xO/6QJ7Tqyhz9SiXHIDm08o/zI9jqkCyiSwoXQHzcgQ
 s9/1CN+VC0T84PHWsxct1OQBi6C0IwnMiWFC8Rd0iG05iknTFoLvmJDcaNn/xP4Ri/jV8FtEbC8
 5QYSuKGXU2SVqDegKRqW2ylt90fPqiqHbmy+BwQEVs21v6sjxUL/6IgG+aB1/8dnGn67lAWZxLC
 LDpNGE/xqSmPErndaPrO7bd5TN952ZDXbX8++F7XQ1gLHR3Drmp3iiN7KgEXmqQWkv0InS2MjN2
 jlO4tsoxjz+V5Af62qpLc4qptQxhFrqOBAd4YQ93fo9HuoEstvBjXc9PA7DoxqzvFmiQAwytEGb
 Fal7KzUeHpYvob5J4Wg==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69ea7a1c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-wZDFzhax2tZ4RQJR_4A:9
X-Proofpoint-ORIG-GUID: oQKc6Stj115SwIsGZ-APviHRT3_heYpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230193
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is v5 of the patch series to refine aio_poll adaptive polling
logic for better CPU efficiency.

v1: https://lore.kernel.org/qemu-devel/20260113174824.464720-1-jhkim@linux.ibm.com/
v2: https://lore.kernel.org/qemu-devel/20260323135451.579655-1-jhkim@linux.ibm.com/
v3: https://lore.kernel.org/qemu-devel/20260405200735.3075407-1-jhkim@linux.ibm.com/
v4: https://lore.kernel.org/qemu-devel/20260412215011.326196-1-jhkim@linux.ibm.com/

Changes in v5:
- Patch 3/3: Fixed QAPI documentation based on review feedback:
  * qapi/misc.json: Removed the sentence about returning poll-weight=0
    since query-iothreads never returns 0 for this field.
  * qemu-options.hx: Enhanced poll-weight parameter documentation to
    match the detail level in qom.json, including information about
    default value and typical value examples.

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
 qapi/misc.json                    |   6 ++
 qapi/qom.json                     |  10 +-
 qemu-options.hx                   |   8 +-
 tests/unit/test-nested-aio-poll.c |   2 +-
 util/aio-posix.c                  | 148 ++++++++++++++++++------------
 util/aio-posix.h                  |   2 +-
 util/aio-win32.c                  |   3 +-
 util/async.c                      |   2 +
 12 files changed, 176 insertions(+), 78 deletions(-)

-- 
2.50.1


