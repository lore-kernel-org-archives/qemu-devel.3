Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1413C7113E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 20:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPSUi-0000Pk-E4; Wed, 11 Jun 2025 16:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uPSUf-0000PK-SO
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:56:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uPSUe-0002VS-CO
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:56:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BFjZ0k003285;
 Wed, 11 Jun 2025 20:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Mswh5nueCy3LAz2LB
 vKivVe8OCxj8xvKFfxe/TzA+Fo=; b=gRd6ONOXrlOgLtamxTsz8HoPuMbjFhbqf
 6U5voPGF4TsuJ4otMtOjFLWV1A+GCIkv5hNDEFlo1kVUjWInHvscwq0E83Wd9Swm
 pRoZaHRGdgmLER6yKpbJid2KKgW5d7DS0oP0hQI93IxbefmCPVst26z10A6oy9tm
 IehAiO68BAs5V1QjrAO416Hpgjkk1djrPS6oM2RD3O+GiyK/Ki6qhMzQEJzgTdZK
 pmnuNvUuwnhacYmcuGPUjhTyDJNRBV3xnK6pxbPsTLNHTAOvG/lBK8jpy7DXwbZY
 DQyck16Dp3NY+WwfvFD/9hlEAG/YrkHjZWtmHsIzd8QIL7fXRIG3g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup6v88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 20:56:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BHEAsP015331;
 Wed, 11 Jun 2025 20:56:15 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp9gey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 20:56:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55BKuEep33686024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 20:56:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02F2458062;
 Wed, 11 Jun 2025 20:56:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4C3858052;
 Wed, 11 Jun 2025 20:56:13 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.250.224])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Jun 2025 20:56:13 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v4 1/2] tests/migration: Setup pre-listened cpr.sock to remove
 race-condition.
Date: Wed, 11 Jun 2025 15:56:09 -0500
Message-ID: <20250611205610.147008-2-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611205610.147008-1-jhkim@linux.ibm.com>
References: <20250611205610.147008-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=6849ed70 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=1FARfR5wGGNNaKhV8jsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE3NiBTYWx0ZWRfX2wxlWrkyPg4n
 W8KgWqP9rzNZOe95sAleey9UTj1uA32zYzizeUgvPx9NjQu25iu1TO9K8m7UIdAP27QdV5YZmRZ
 ho8S75YL0qACAoUvES4t3QguPiZ6yumA2IblBfyou2ct7HrNy/N9u7LemRm+3uHMALnF5ccZNX1
 mW+5PdAUWzTQ0hd//SQLnY9lHCD79UbDlcLTJv/+Rsf91ekuCLmdlH3VdkZuVYRE4SRriCLv9Ep
 TDvkwCngIXTHK3bn7cokB1+vFIS6uAYrlk5IcBdTiP1wgTTVqrfyJ9RETDVNW8+pJOy97aFfc/i
 6kMlONQ8lEYlwAeIPpolC8Cs+W6JPy2uEjU6BTkldrmPDv50OGnJwvQEVQW4Xe3UjJUI3pzY9CQ
 D7xHsRb36+qt1DUfGTW0SyaATvQ18MWt38P9XoavyOahpYwI2QMhJG1HA30tavVNTK9n+ptk
X-Proofpoint-GUID: 0ulpgCdD5wP1o5aLxcFrDZE7XvZkkHai
X-Proofpoint-ORIG-GUID: 0ulpgCdD5wP1o5aLxcFrDZE7XvZkkHai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110176
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
index 5536e14610..f7bd5c4666 100644
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
+                                  "addr.type=fd,addr.str=%d %s",
+                                  cpr_sockfd, opts);
     MigrateCommon args = {
         .start.opts_source = opts,
         .start.opts_target = opts_target,
-- 
2.49.0


