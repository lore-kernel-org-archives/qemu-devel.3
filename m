Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D115E9D80D
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 20:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Tl8-0005eg-8x; Sun, 05 Apr 2026 16:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w9Tl7-0005dq-22; Sun, 05 Apr 2026 16:07:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w9Tl4-00036V-So; Sun, 05 Apr 2026 16:07:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6351t9nL1439413; Sun, 5 Apr 2026 20:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NEywkYVaDUsxcrPTH
 Fev8EFSNbDutRhyN0hAgTeSJSc=; b=EcEkgQjyNvg6vTyHjJcZlrZ7mKdN8UBIP
 t6zbLjMOConN5agOjehQZpfziNoaL3ypq4iOlBWAQELgYI3mOVw/SAw8BfkY13FC
 Q2vOBst9KTK3gkZEQo+vVUPsv3fchjtfuZ6PLfYiRdcGP4x7TwyYkiSNyCbVk0wI
 g1jB8l4QTjIlkzwQa5csytZIkhidmh5Xagy4MjBz3jnVQdUgaPh8zCupgghzKGhg
 kgpQfL/BwnDwwHEvlWXnJv3o3oi3wGUkOcuigp3Cilsw8FKwLG1I832Idr9TaIdW
 IaI+S9phHg5EB66Mg/+Dhv+KVRc0AFh1bxcHTLy2bpRpVdtVQaYIg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2m7pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 Apr 2026 20:07:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635EmiBZ018534;
 Sun, 5 Apr 2026 20:07:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcyste0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 05 Apr 2026 20:07:41 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 635K7eEU12976680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 5 Apr 2026 20:07:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B9CF5805A;
 Sun,  5 Apr 2026 20:07:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A81B58051;
 Sun,  5 Apr 2026 20:07:40 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.243.136])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  5 Apr 2026 20:07:40 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 mjrosato@linux.ibm.com, farman@linux.ibm.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v3 1/3] aio-poll: avoid unnecessary polling time computation
Date: Sun,  5 Apr 2026 15:07:32 -0500
Message-ID: <20260405200735.3075407-2-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405200735.3075407-1-jhkim@linux.ibm.com>
References: <20260405200735.3075407-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDIwNiBTYWx0ZWRfXzJM4GxVp3AhJ
 +Lx6hBWjRWY4w3xjrtVj6oXOIWrzXPrTVVtM4mggYNkb452bvE6NEZDwucYjXmExqlpnWRCXo+U
 dDH9qCWXKbHBSprmifKAb7JvSTzM+nurqKM6tMxh+uHpO4zv6rGRQsFMdWGBZiiyXgMw/3zHS+k
 tesBm5/YuHQW6NYSSe1uXpVHNyLI0fK6R7/KGDKJiVNWEQg+8BjUW/46eDqNc+7fZmPESnCWrDN
 PJBHL5e8s3/+E1wf4k4qwLIKCO0m7e/J7nLMcnEV38fq4mdehM/ePMK1T9m/uHe8ar9k0RWhegN
 SdZHe1j1UqPy/wQrhZHZj8Xa+szxQUwEpQM0faHbbrIJDAskJjVv1p2Uhd86fYvGehs7g+Jcvvz
 WbnLus5u49EdiL508G9SwoxibXvFB0ZsTObYbcmT40RE97qRayZb2jl2x9+nc1AhWVROsTKY9fj
 CiitMPXZM2CsNL/xGGw==
X-Proofpoint-GUID: cpMl8QlInP2aQPbccIFolPUZe-Dp6EnV
X-Proofpoint-ORIG-GUID: cpMl8QlInP2aQPbccIFolPUZe-Dp6EnV
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d2c10e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=6MqEkq6nHlEWUoCmaegA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050206
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
disabled, preventing unnecessary try_poll_mode() calls. This avoids
iterating over all nodes to compute max_ns unnecessarily when polling
is disabled.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 488d964611..351847c6fb 100644
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
+    if (ctx->poll_max_ns != 0) {
+        progress = try_poll_mode(ctx, &ready_list, &timeout);
+    }
     assert(!(timeout && progress));
 
     /*
-- 
2.43.0


