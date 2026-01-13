Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D8CD2F350
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 17:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfiWj-0005ws-1K; Tue, 13 Jan 2026 12:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vfiVR-0005U4-5r; Tue, 13 Jan 2026 12:48:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vfiVP-0004Tg-8O; Tue, 13 Jan 2026 12:48:36 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60DFQgLw020192;
 Tue, 13 Jan 2026 17:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=EKHVYs4STPD+B5oR3
 DI+FA67YcWUqiZJ/koTjBwtxpE=; b=g/5147WMnZnEiw2qlg5PD5zldoMQsvw6A
 vXWr6rI/ZxgV5Q5GG8ZITK/G5caBZxDy8BRUSKOuCKVpeZ8mDwlXD7RWCIdmxYS1
 iLJUwKvnrYGdYVW3wwtYeCdeZos1ePefYwTtVQNSKi1cUQIt792+YXE4oYVQ2gKT
 Let7rVZcjBz0qObaV4QrRhOQDVVUkUgHFyLkvqzLnULDZt7+ssLZCnnlUFy4Xbxm
 K2BD81vuNUEWzRMfuodpgY3hts/6MTwvhOc1AebuyIAIoYoVOFzi3A5pWmGolH7b
 cptqleDWOaisiqHAWC3c5qQVgf29QyYdntx+wHhOjjwmubpqh04pw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4drms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Jan 2026 17:48:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60DFursf014261;
 Tue, 13 Jan 2026 17:48:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fy5t03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Jan 2026 17:48:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60DHmSFY23593558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jan 2026 17:48:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E49B45805D;
 Tue, 13 Jan 2026 17:48:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5602658059;
 Tue, 13 Jan 2026 17:48:27 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.252.253])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Jan 2026 17:48:27 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH RFC v1 1/3] aio-poll: avoid unnecessary polling time
 computation
Date: Tue, 13 Jan 2026 11:48:22 -0600
Message-ID: <20260113174824.464720-2-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113174824.464720-1-jhkim@linux.ibm.com>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE0OCBTYWx0ZWRfXyXHjMhQRCTXz
 Q6UTdIoNStZMGzNnyo7BsCLvPKWi5dN0ZT4cthPaZadcw2kw33Bl7Yu4tTYCqOT9bFHC1V4/D5g
 NOtgk+TpHyP/DzHyPGqYh++ruyM0I8gEAHXua1fhaGHFM+1pWziBjaOvifu6gGnj/oOC4ZpiQwk
 OPuH+CxQsUHaoEjyh9FK08hBNlrhFeNX0USirQU0pZT/5lbLxliolgbKe2cCyaF3xaPekdfzwWV
 DZC7GoY3Cu9Fu2DB6UIcn5ITZ7H0aoY/YqXIvZZq/vyI8/glXtZrzfL6HLQtU1NCuRTJbpWuF9D
 yg4gNhZpM9rOvHmAOVq0nDzKyqMVUJco4oXyiOQxCKgMTQ1DPssCy6c+c1TZR9sE7x/52zXr3tU
 YbQdnM5etqUqw409YQE0FX3P3WzkI+gfxUMSbPRlT8BU6dNp6hfj6Kn/WJDF39Jq5hazAW6SBSL
 WzMY19PJF95zPmaRjXA==
X-Proofpoint-ORIG-GUID: NxY_8byycvms8k5jhTIJdCaMchh309T9
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=6966856e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=6MqEkq6nHlEWUoCmaegA:9
X-Proofpoint-GUID: NxY_8byycvms8k5jhTIJdCaMchh309T9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601130148
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
index e24b955fd9..7ddf92a25f 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -306,9 +306,8 @@ static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
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
@@ -630,7 +629,7 @@ static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
 bool aio_poll(AioContext *ctx, bool blocking)
 {
     AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
-    bool progress;
+    bool progress = false;
     bool use_notify_me;
     int64_t timeout;
     int64_t start = 0;
@@ -655,7 +654,9 @@ bool aio_poll(AioContext *ctx, bool blocking)
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


