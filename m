Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA7BF46119
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fke-0004Ir-1M; Mon, 23 Mar 2026 09:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w4fkQ-0004H2-NG; Mon, 23 Mar 2026 09:55:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w4fkO-0006QS-HW; Mon, 23 Mar 2026 09:55:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NCmnUU4107185; Mon, 23 Mar 2026 13:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=6eSESP8HQCOegaSd6Ev8jjcaDkYWcN15N4IH0Fpiq
 gw=; b=HfONfbABP8AG1oh1RzQxSU4HZ6tefSHgmVmdasGqvAiYdqCrSpiGcGj+u
 +UgeVkm67EEpArRjKPr7/AsiFTq5H4D/vB6sO9B6C4aMBhHltA5w2drb+P+6YBdh
 Qa/s5HvWpIVuzyUVPwt7wbud/6lEHIh41KFD4eKC4tHHRs2Er0dm6uLY/JpvAisH
 NqP8/T86Hiuz4mzl/H+ihEgsH89OHSbv3z93rhEWgehTUOpTQIJv6dPdtbwJxTgy
 hwbbj1IthHaCAVyXoCFjEbl7IbfZpzWnhH/Tr6hUPTs04UHP78G8Zg0dI6SaZdDM
 6l+P1/C0rVW3s7Qw8XZbAfbYCtybA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxyxs40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 13:55:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NCVhrX026864;
 Mon, 23 Mar 2026 13:55:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kngqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 13:55:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62NDt4Or23134780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 13:55:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC2EB58065;
 Mon, 23 Mar 2026 13:55:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F252F58055;
 Mon, 23 Mar 2026 13:55:03 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.250.54])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 13:55:03 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, pbonzini@redhat.com,
 stefanha@redhat.com, fam@euphon.net, armbru@redhat.com,
 eblake@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 dave@treblig.org, sw@weilnetz.de, Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH RFC v2 0/3] improve aio-polling efficiency 
Date: Mon, 23 Mar 2026 08:54:48 -0500
Message-ID: <20260323135451.579655-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwNyBTYWx0ZWRfX8GYkC544ELrK
 erGhEck6fOKZ9QTlXD4twoHmw5on95JTIdUiXoQNOyDwKfU5Zg+GrUa3HsJlsRDcZDGfAy5Tpqk
 tsMARJkWgYBbUeGDL7h0cuvz8akDrtj6oHnneiHa84XqXt5V8vAmSnyiCNEyec/2vQTv5ojJKtv
 1Nsp3Q2Uz0a0sCz8eeDC9nJMIjlORX9NNGwV79clQ2iZiaUYahW9aVOMm9eLVN54Dkm1MAEyAtH
 PCfJ4MOzbhGC850gEYTC5Wis3kpFd9/Eo6sokxj9cjy+xYeAzlEZUc6e2Lg++iTeT3D7VFbm6mw
 obDBfxy2MbdXFiXkJ0OcYq7PsmsIhoUMkVZYhmItYG7tC38iAwdf6pGAkX7hGf0S5l447LbAJzx
 x8/F++Ii+UAXf7AzEp4F6vPgQYILUeosZ0RxRDhmncvzwA/HwI7moDcQsjOrGDjNHMYf75Vbiby
 lnjU67YQKzrqaaAYmlw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c1463b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mJJ971aroQlbiHs1jOcA:9
X-Proofpoint-ORIG-GUID: PVAEq10ahvc0WCKRvdatt8XkGVlkr7k-
X-Proofpoint-GUID: PVAEq10ahvc0WCKRvdatt8XkGVlkr7k-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230107
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

This is v2 of the RFC patch series to refine aio_poll adaptive
polling logic for better CPU efficiency.

v1: 
https://lore.kernel.org/qemu-devel/20260113174824.464720-1-jhkim@linux.ibm.com/

Changes in v2:
- Patch 2/3: Changed default POLL_WEIGHT_SHIFT from 2 to 3
  based on extensive testing. Updated commit message with
  detailed performance comparison showing weight=3 provides
  better balance between throughput and CPU savings

- Patch 3/3: Added proper initialization of poll-weight,
  poll-grow, and poll-shrink defaults in iothread.c

This patch series refines the aio_poll adaptive polling logic to
reduce unnecessary busy-waiting and improve CPU efficiency.

The first patch prevents redundant polling time calculation when
polling is disabled. The second patch enhances the adaptive polling
mechanism by dynamically adjusting the iothread's polling duration
based on event intervals measured by individual AioHandlers. The
third patch introduces a new 'poll-weight' parameter for runtime
control over how much the current interval influences the next
polling duration.

We evaluated the patches on s390x hosts with different configurations:

Initial testing (Fedora 42):
Using a single guest with 16 virtio block devices backed by FCP
multipath devices, I/O scheduler set to 'none'. Across four FIO
workload patterns (sequential R/W, random R/W), averaged over
numjobs 1, 4, 8, and 16:

 - Throughput: -3% to -8% (one iothread), -2% to -5% (two iothreads)
 - CPU usage: -10% to -25% (one iothread), -7% to -12% (two iothreads)

Additional validation (RHEL 10.1 GA + QEMU 10.0.0):
Comparing baseline vs poll-weight=2/3 with FCP and FICON storage,
using 1 and 8 iothreads, averaged over numjobs 1, 4, and 8:

Summary of results (% change vs baseline):

 - Throughput avg: -2.2% (weight=3), -2.4% (weight=2)
 - CPU consumption avg: -9.4% (weight=3), -10.9% (weight=2)

Weight=3 was selected as default for providing slightly better
throughput (-2.2% vs -2.4%) while maintaining substantial CPU
savings (-9.4%).

Best regards,
Jaehoon Kim

Jaehoon Kim (3):
  aio-poll: avoid unnecessary polling time computation
  aio-poll: refine iothread polling using weighted handler intervals
  qapi/iothread: introduce poll-weight parameter for aio-poll

 include/qemu/aio.h                |   8 +-
 include/system/iothread.h         |   1 +
 iothread.c                        |  34 ++++++-
 monitor/hmp-cmds.c                |   1 +
 qapi/misc.json                    |   7 ++
 qapi/qom.json                     |   8 +-
 qemu-options.hx                   |   7 +-
 tests/unit/test-nested-aio-poll.c |   2 +-
 util/aio-posix.c                  | 141 ++++++++++++++++++++----------
 util/aio-win32.c                  |   3 +-
 util/async.c                      |   2 +
 11 files changed, 161 insertions(+), 53 deletions(-)

-- 
2.50.1


