Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D7CC61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 22:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP7Xd-0002PW-8n; Tue, 10 Jun 2025 18:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP7Xb-0002PO-Bv
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 18:33:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uP7XU-0007r3-RC
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 18:33:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AHXi4W011109;
 Tue, 10 Jun 2025 22:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=B04UPESuvxMBZcJTV5GdBJNYpEL67z82u1KNWLI0M
 xY=; b=WBXj4jHxQ37bL9i1AfYQ2hwlVbnvx4fsySgXfcIhGMPl6hBKR5/7XbGvY
 h2tBoHEqbDcGJmAOhnG/TCE3ZwKqxvRpWPBvVxwPPprAFvD9bMI8gPS0REomqPpB
 zIT2T3TOtfJ+jyZ430VTUHT1aZtt/rZZLLkev2xu4tl95T1MtFA94ap0XL95ItR8
 Vp/D3VkuOP7Dff3g9yeQpplDqNcu7QmUG6P7DGQbHsAFLj4NQ7hxUEiVuIhxw+Yh
 q2VBeKO+jmyIowQT9y9nDh+LUavR/8JUEdssHiTKrzVJnHtNVq1nLLtR2Bk0MwUj
 iO9iT0QGtlzyCDwmFxb5+VGRP3ZXw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7h289-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 22:33:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55ALvrfj019586;
 Tue, 10 Jun 2025 22:33:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4752f2cdbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 22:33:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55AMXi0724773292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 22:33:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 518C25806D;
 Tue, 10 Jun 2025 22:33:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C117858068;
 Tue, 10 Jun 2025 22:33:43 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.254.209])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Jun 2025 22:33:43 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v3 1/2] tests/migration: Setup pre-listened cpr.sock to remove
 race-condition.
Date: Tue, 10 Jun 2025 17:33:41 -0500
Message-ID: <20250610223342.553744-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QF3xdD0kr_zPm_u-evd68nKAtYBq3Sod
X-Proofpoint-GUID: QF3xdD0kr_zPm_u-evd68nKAtYBq3Sod
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE4NCBTYWx0ZWRfX8bkP8KyGLzMl
 agUQYoLBRwbT4n+gm+UwVhnqhsqW7EvYnzdQG2lX/im60ehhJaIfqhWIkgZhTRQwS8lpYmRxRC/
 L9XV9OmCo4mGm3Sj6ejJ88WegxEbhTdkmNDMoqIBO/zHJ8R6EQG4dX0ZppOiBFWy+lv2k4O+SPZ
 N4Cq4ColzI/qpWicvjPHSrTSFiVQrFW61+RIi5PEaicozmeOJwm10MSDx71wH7UPseeEh4xD7M2
 W26sh2UYp/6Ou3r74hm3eO5z0LReARftEeBkZZHjI9eXX0xll15eTa7uJYx2aPeCxvHa9+v4l+d
 ZnMUU6/99zNQ8wJ2/yHjfoGRvgyFTpMpCT6L4wFvCy9CbAJd8+PeEjuLCexcDO+juHWJYnImj8c
 QS+4vZFX8nmRYajJ4j+5w8BMO0JRPpPX9yXVaKLO1ryo9rPJa82XOS+byQMXnhMMMN77c6+A
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=6848b2cb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=1FARfR5wGGNNaKhV8jsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100184
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When the source VM attempts to connect to the destination VM's Unix
domain socket (cpr.sock) during a cpr-transfer test, race conditions can
occur if the socket file isn't ready. This can lead to connection
failures when running tests.

This patch creates and listens on the socket in advance, and passes the
pre-listened FD directly. This avoids timing issues and improves the
reliability of CPR tests.

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 tests/qtest/migration/cpr-tests.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 5536e14610..145860c24c 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -60,13 +60,12 @@ static void test_mode_transfer_common(bool incoming_defer)
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
     g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
+    g_autofree char *opts_target;
 
     const char *opts = "-machine aux-ram-share=on -nodefaults";
     g_autofree const char *cpr_channel = g_strdup_printf(
         "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
         cpr_path);
-    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
-                                                   cpr_channel, opts);
 
     g_autofree char *connect_channels = g_strdup_printf(
         "[ { 'channel-type': 'main',"
@@ -75,6 +74,17 @@ static void test_mode_transfer_common(bool incoming_defer)
         "              'path': '%s' } } ]",
         mig_path);
 
+    /*
+     * Set up a UNIX domain socket for the CPR channel before
+     * launching the destination VM, to avoid timing issues
+     * during connection setup.
+     */
+    int cpr_sockfd = qtest_socket_server(cpr_path);
+    g_assert(cpr_sockfd >= 0);
+
+    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
+                                  "addr.type=fd,addr.str=%s %s",
+                                  g_strdup_printf("%d", cpr_sockfd), opts);
     MigrateCommon args = {
         .start.opts_source = opts,
         .start.opts_target = opts_target,
-- 
2.49.0


