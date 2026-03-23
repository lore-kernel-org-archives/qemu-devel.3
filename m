Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032F4F4611B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fkl-0004Pw-OP; Mon, 23 Mar 2026 09:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w4fkT-0004I4-Ik; Mon, 23 Mar 2026 09:55:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w4fkR-0006Qx-SO; Mon, 23 Mar 2026 09:55:17 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MNPEcj666646; Mon, 23 Mar 2026 13:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=leRhdWaBWAl6vsaaM
 yYddgrMqxbeuMfq5lKtc1bFpqU=; b=OoG6BtX/jMm8C+uGV+W45Osm2I5KIpaFp
 ytxqIlf2OV97dzc7Iwcma1DuSVt07VxqpPi5MLLbg07Z0SWqgTK7f0O48E761E9i
 0mI0551Q3DyzbyZL2E0iB6n3tmEzHMG6xfElVnt+1SKDgk7RJFlpiSyzDuelRMq3
 J4f84JK3wPAI7dugySvf1RQBWQqOvY/mlAjGPwiZLDHEd/HGaf5qqtzEjwotsje2
 XIks5NgDXPJR5NoKjTLV9IjjmymQ7eVrxeu95TSeKD1lr7JhNP66vp0bpemZE1cQ
 Yvi+1wfUNEA0dXje8UCacIbp28tVlyCWtgNtDjo/V2WpELnvHLfvg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxq3qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 13:55:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NBr9VS005972;
 Mon, 23 Mar 2026 13:55:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ydped-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 13:55:08 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62NDt6F023724566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 13:55:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB5CE58063;
 Mon, 23 Mar 2026 13:55:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23E5958055;
 Mon, 23 Mar 2026 13:55:06 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.250.54])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 13:55:06 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, pbonzini@redhat.com,
 stefanha@redhat.com, fam@euphon.net, armbru@redhat.com,
 eblake@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 dave@treblig.org, sw@weilnetz.de, Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH RFC v2 1/3] aio-poll: avoid unnecessary polling time
 computation
Date: Mon, 23 Mar 2026 08:54:49 -0500
Message-ID: <20260323135451.579655-2-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323135451.579655-1-jhkim@linux.ibm.com>
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c1463d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6MqEkq6nHlEWUoCmaegA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwNyBTYWx0ZWRfXziuOAgUl3hB7
 OtLnhbouMa8jhDF5327cUIuDQDA1ijWncoewirWOFsUM8CxDLKiDr47ySiwgzODQuAd/GHPjCak
 IxD7oQr1w27eQhYN/GhfZvZfRYf1txFsnFJZzJmWQbCakhg7h4vqUqqWulfN/IsEf1bsjrIqDmO
 63UOKjQYHgpIn/xxkhM0OAQt6jj/jeYE22rCi9R1Av3Y5A/59a6a+Dd5yb9zdO61ZhiWl7UG1jF
 N27L20GcWlmNVkxPQP6iwOiXt8sTQFlRB3dluJ3nDDemlDifObQqDY0hQwvtwH4oY4ULRpFiq7e
 2qVZumbL0h+AN22hwctFCAjDwUp4CTUlhovsPn2VLnwXBuEzHGkVT6kChgn/ZpdSOeq9+nrdB7m
 vNuQck3B4mthbzXL2HcJ5IZe970gbdNpaRSzCBUxoBX8/8mZRH+h9oLyIH2wSFDidvzX6s0n4CA
 SRQQmKBs/iRVvPQV6Uw==
X-Proofpoint-GUID: geWwTWbnqISl1V1gTeSR21NNT2Zi7G9N
X-Proofpoint-ORIG-GUID: geWwTWbnqISl1V1gTeSR21NNT2Zi7G9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230107
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

Nodes are no longer added to poll_aio_handlers when adaptive polling is
disabled, preventing unnecessary try_poll_mode() calls. Additionally,
aio_poll() skips try_poll_mode() when timeout is 0.

This avoids iterating over all nodes to compute max_ns unnecessarily
when polling is disabled or timeout is 0.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 util/aio-posix.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 488d964611..b02beb0505 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -307,9 +307,8 @@ static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
      * fdmon_supports_polling(), but only until the fd fires for the first
      * time.
      */
-    if (!QLIST_IS_INSERTED(node, node_deleted) &&
-        !QLIST_IS_INSERTED(node, node_poll) &&
-        node->io_poll) {
+    if (ctx->poll_max_ns && !QLIST_IS_INSERTED(node, node_deleted) &&
+        !QLIST_IS_INSERTED(node, node_poll) && node->io_poll) {
         trace_poll_add(ctx, node, node->pfd.fd, revents);
         if (ctx->poll_started && node->io_poll_begin) {
             node->io_poll_begin(node->opaque);
@@ -631,7 +630,7 @@ static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
 bool aio_poll(AioContext *ctx, bool blocking)
 {
     AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
-    bool progress;
+    bool progress = false;
     bool use_notify_me;
     int64_t timeout;
     int64_t start = 0;
@@ -656,7 +655,9 @@ bool aio_poll(AioContext *ctx, bool blocking)
     }
 
     timeout = blocking ? aio_compute_timeout(ctx) : 0;
-    progress = try_poll_mode(ctx, &ready_list, &timeout);
+    if ((ctx->poll_max_ns != 0) && (timeout != 0)) {
+        progress = try_poll_mode(ctx, &ready_list, &timeout);
+    }
     assert(!(timeout && progress));
 
     /*
-- 
2.50.1


