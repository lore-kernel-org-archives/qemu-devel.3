Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE6AE9D819
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 20:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Tl7-0005dp-3f; Sun, 05 Apr 2026 16:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w9Tl5-0005de-OH; Sun, 05 Apr 2026 16:07:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w9Tl4-00036Q-51; Sun, 05 Apr 2026 16:07:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6359qCDN2307737; Sun, 5 Apr 2026 20:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=MUtclOe3kKJf2/41pfZixUNYP6lmJcGZUZiD+Rcfy
 0k=; b=Mlate4L1YiWc0gQPg7IvvGp2YgiyABrXb3EwzdMonM9iIPzZI5h2yF0x5
 8r2JYqThVv2R7mBLH+3ZOg7VwDvIeXaVatB8x5b1TZq3PPEshjffjwyTbAooYEtb
 Rj9MGHPqaNaR80oTW8GcaVf+hipWIKpQ52nM5AeqeAJm3REzG2AoEAS9BH83sSLC
 6hO8My/fBBT13TgAmlCdDRuh8k2/navKk9Iqkt2RcSA2J4v6rqCZ/34IzgBl6rOH
 dqdnKhKB8UjpM4Dd5OFU+9ZA71b4Q0IJmv/q+xj39a4pMBf2fyyvX/6xmJ4ukfA4
 0I+LCcrzZ3LctXjnmH0UmtGRVXVfw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat9rbw27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 Apr 2026 20:07:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635GZvpQ022945;
 Sun, 5 Apr 2026 20:07:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbefka763-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 Apr 2026 20:07:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 635K7dGc32768600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 5 Apr 2026 20:07:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53F9A5805A;
 Sun,  5 Apr 2026 20:07:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D95E58051;
 Sun,  5 Apr 2026 20:07:39 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.243.136])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  5 Apr 2026 20:07:38 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 mjrosato@linux.ibm.com, farman@linux.ibm.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v3 0/3] improve aio-polling efficiency
Date: Sun,  5 Apr 2026 15:07:31 -0500
Message-ID: <20260405200735.3075407-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k-pIEU_5TZO3w7ffQLwm5aPgDsLWjbeS
X-Proofpoint-ORIG-GUID: k-pIEU_5TZO3w7ffQLwm5aPgDsLWjbeS
X-Authority-Analysis: v=2.4 cv=bLYb4f+Z c=1 sm=1 tr=0 ts=69d2c10d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=LaYcTpCPktSTTGNkxp8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDIwNiBTYWx0ZWRfX+I6Fe1VZXnp4
 7dLnCk9HTOC51gB4NKPhmTBhKMlRbaM699hKhCxzBfBAJYfkjaoFeKtn73XZu77Eble9OGT6woM
 nm/GDi0kn3H1mhw30XHxc43GuZD1qgpQLr1j6wVXbmOAj74N2epqiCDg6cHHPoHYZ95CtXna2lm
 AZ1bkVOh+RlmeDVsh/DzhQyBi9nLivFiT6l1+d7F0B5eEKVSdlRJ0PmZ54k2BhQFPCAicrCiIlG
 D594U2NT5s8nD5KfDZ0SiCjx8xGgB+weRXNDHUS2D3T3MtlLltCBkYigmi0ugHlAEYJ9QUBRv7v
 BYr1V7YO8rm0AEQP0DUn6LFd6hZwmqXbAdi95WDfTXsMyOg6H8bm7372DCV4txKB9z2RtnIiSFO
 c+w30FY8s6CshyTqY1p9SDX0wntKvZ+QQYNHHaAWv1b+H/0373Re6JfoqxsMW5S9jZ1jYZGCXJI
 IaT5h64Ti49RwZxD93w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604050206
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

This is v3 of the patch series to refine aio_poll adaptive polling
logic for better CPU efficiency.

v1: https://lore.kernel.org/qemu-devel/20260113174824.464720-1-jhkim@linux.ibm.com/
v2: https://lore.kernel.org/qemu-devel/20260323135451.579655-1-jhkim@linux.ibm.com/

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
2.43.0


