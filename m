Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2729D2F349
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 17:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfiWj-0005xD-OE; Tue, 13 Jan 2026 12:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vfiVR-0005U5-5q; Tue, 13 Jan 2026 12:48:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vfiVP-0004Tc-8N; Tue, 13 Jan 2026 12:48:36 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60DAwTDJ024688;
 Tue, 13 Jan 2026 17:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=928uTXPGM3sgRnIQ8Qz0o55KyRX9f/7mIXX7OyRYs
 BU=; b=JVBLt87gf8ZE7nGx1oBrYaq+PAAhPjeXCxXBmSo7pX5M1PBPPbjyX5UIB
 ANRZHILfIZ9EVwl8YFWQu421bhYU3lAs9yXX0/XjSARCGFhUijHzyRRmvI5PvsC1
 2FYgoKp+CXNz89UNx1gMbC96YhlcbTYuORLiOQobzyetllGFUZHrNPlta3OIFvdM
 76n1Qrxuz6yBMtisYM1jrXFtMuUOhunfOBdjMs41Eg6rga4CXW54AyJZHiNc1J7I
 P7aVqkeIeHnxk+6K3WrlZra8YkLVaw/FNETYitXjc4hp1vbKDCP2W+9v8h+qNyPn
 WrKdXnZzLHgQ9dQwokec3OYt1Mt9Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeepwsw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Jan 2026 17:48:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60DFPuXF002565;
 Tue, 13 Jan 2026 17:48:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13snv6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Jan 2026 17:48:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60DHmQGe45285702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jan 2026 17:48:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F7915805F;
 Tue, 13 Jan 2026 17:48:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C657958059;
 Tue, 13 Jan 2026 17:48:25 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.252.253])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Jan 2026 17:48:25 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
Date: Tue, 13 Jan 2026 11:48:21 -0600
Message-ID: <20260113174824.464720-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=6966856c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t3WgsMIyXrlp8r_LuEUA:9
X-Proofpoint-GUID: 7DuvsQv7YWuHWeRnyu5K6flXX4muI_Zk
X-Proofpoint-ORIG-GUID: 7DuvsQv7YWuHWeRnyu5K6flXX4muI_Zk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE0OCBTYWx0ZWRfX/Z2/s1gQOPiO
 4B9b5hQHIRPcfKA+JR0QRONIHZkhF8u/nsw2vifkhUNeTy+48Fwl7OTYFeFVVG42pemmhuzIVR5
 8iZPY5JVrqFhMphHuugLufen8GFueAptpo47uXvsI5OHz6tHMRY1BTroh+m2nVCWmHbAHM2+vB+
 zJHtTNdAGh5BWlt61EnOhFlwGR/uetay/whpvS454/jJ1Z/+IAT+F6xeFLUhlfGqwIomTvwTaMu
 ncnUahJ16VMGJLu3DjcIdxLeVD0yONIVyLlc2VVmy82vpW2WA9Zmt+nyVOrd04L9e4pmVSsE9o+
 b00PrrMbjody+FQJ/Trdaf5f6k7PIqgEi9pXMQ2hy+ysfiCGuJ9sPNV8Z9wcbqchjneM24fgMZn
 gcj9zr1DDrmQhSr5FFH6sFrusbyAWLjTdi6oSbV/n9O+SbNiWbuMrVsJ5QWpqpYEYF2cjiUcQcB
 it1s16GfovWFBI8qzCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130148
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

I'm submitting this patch series for review under the RFC tag.

This patch series refines the aio_poll adaptive polling logic to reduce
unnecessary busy-waiting and improve CPU efficiency.

The first patch prevents redundant polling time calculation when polling
is disabled. The second patch enhances the adaptive polling mechanism by
dynamically adjusting the iothread's polling duration based on event
intervals measured by individual AioHandlers. The third patch introduces
a new 'poll-weight' parameter to adjust how much the current interval
influences the next polling duration.

We evaluated the patches on an s390x host with a single guest using 16
virtio block devices backed by FCP multipath devices in a separate-disk
setup, with the I/O scheduler set to 'none' in both host and guest.

The fio workload included sequential and random read/write with varying
numbers of jobs (1,4,8,16) and io_depth of 8. The tests were conducted
with single and dual iothreads, using the newly introduced poll-weight
parameter to measure their impact on CPU cost and throughput.

Compared to the baseline, across four FIO workload patterns (sequential
R/W, random R/W), and averaged over FIO job counts of 1, 4, 8, and 16,
throughput decreased slightly (-3% to -8% for one iothread, -2% to -5%
for two iothreads), while CPU usage on the s390x host dropped
significantly (-10% to -25% and -7% to -12%, respectively).

Best regards,
Jaehoon Kim

Jaehoon Kim (3):
  aio-poll: avoid unnecessary polling time computation
  aio-poll: refine iothread polling using weighted handler intervals
  qapi/iothread: introduce poll-weight parameter for aio-poll

 include/qemu/aio.h                |   8 +-
 include/system/iothread.h         |   1 +
 iothread.c                        |  10 ++
 monitor/hmp-cmds.c                |   1 +
 qapi/misc.json                    |   6 ++
 qapi/qom.json                     |   8 +-
 qemu-options.hx                   |   7 +-
 tests/unit/test-nested-aio-poll.c |   2 +-
 util/aio-posix.c                  | 151 +++++++++++++++++++++---------
 util/aio-win32.c                  |   3 +-
 util/async.c                      |   2 +
 11 files changed, 147 insertions(+), 52 deletions(-)

-- 
2.50.1


