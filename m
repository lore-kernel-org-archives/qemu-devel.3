Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8874E93807
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 21:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC2hL-0002Bc-3x; Sun, 12 Apr 2026 17:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wC2hI-0002Am-9J; Sun, 12 Apr 2026 17:50:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wC2hF-00057U-0a; Sun, 12 Apr 2026 17:50:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63C9k5FE1822902; Sun, 12 Apr 2026 21:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GOJ5PtGfRw9JuVE9Z
 GBFN43Vs8zqFtSfYXt6iC8HpHU=; b=X5oDLS9srTBoDWTv2dNd9rvqKVqWBlMOz
 Fkrbo/C8THxGqYtAo9MQU7o5fHkIrvgIkr81xDyXAWO2PZEs2qnDUneJBYZ2Vt4t
 ik3vrrdn8rZSruOgdpda7R0vn2tT7PvjwxJHz7m05ss7euu6TI16GW7kQinnkDVb
 Pkr65Y4y2yMybxrmPaW5kuRKh8wBLqZJVbiZrN34l32SEpNTq/V9bgqEKlrnmqDH
 o5JklFkyOURAiDkAx1ulyfTBbxMYiu4pkLxznz/saxPYdmGKgtVJhbx1EbZqlcQa
 aXWlUwnato9Ao2+YTVZJZ7FB63+BglPbs6rwZgqjECNBwsYNqTFgQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqn2yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 21:50:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63CG5msA025621;
 Sun, 12 Apr 2026 21:50:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujajep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 21:50:18 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63CLoHIJ15336168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 12 Apr 2026 21:50:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 624AE58052;
 Sun, 12 Apr 2026 21:50:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A483D58045;
 Sun, 12 Apr 2026 21:50:16 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.240.32])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 12 Apr 2026 21:50:16 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 mjrosato@linux.ibm.com, farman@linux.ibm.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v4 1/3] aio-poll: avoid unnecessary polling time computation
Date: Sun, 12 Apr 2026 16:50:09 -0500
Message-ID: <20260412215011.326196-2-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412215011.326196-1-jhkim@linux.ibm.com>
References: <20260412215011.326196-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dc139b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=6MqEkq6nHlEWUoCmaegA:9
X-Proofpoint-ORIG-GUID: ckaDrHO43XM1IhWOjedwLfu8PZCcxZVu
X-Proofpoint-GUID: ckaDrHO43XM1IhWOjedwLfu8PZCcxZVu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDIxNCBTYWx0ZWRfXxvJCevnPS8mC
 +jo02k9qahrwOsQkXs7bTJSnjuGjAXUxjEA6yDuAIMAu3/rtYVmQtxixrOdh/thytbOWVC6aS9A
 BJJiaERfpvUDAG41wyzr3/4F51TDTLQCY0K6Pfud/m9jSDJwUfqne3lp6MqbjLiFFcH+349q9zd
 vVwMvOACXUrp/3QwDhkXnhCJsrHwWG2hNVjMTqr56T639SVCjrK4PpGGpYRHSQ9ep32NK9/HFlD
 yQER977EyV9fsv6zpF7w9NE+Wx+ZdTVqTm4Ze3W7xlcbWq9/tFZv2Tum7wew7DdR2juwP5YLVeM
 BtiTyd6wQc+LlV1t/cMoPtCIFiGmz4jtr6CHgF7B0ABh+4B7+Co3i/kGuuiMR6h3FUGD9i15/rY
 LacwoGkM+1RBGqXfzmAULSCsVxiOuvBY+616+OID3JMxDn95RyQvPfG5tlbGyswVM7+QaZFgk9d
 /zWXg3uyxXeyPD1TsTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
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
2.50.1


