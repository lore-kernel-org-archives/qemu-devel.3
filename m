Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805F8C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 00:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjpqj-00074O-AX; Mon, 11 Mar 2024 20:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rjpqf-00073o-5P
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 20:18:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rjpqc-0001vN-Pn
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 20:18:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BNxWlI018456; Tue, 12 Mar 2024 00:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vxdbzfcNSt40KxQz2rg72yT7GwphQHC5CQghqLpWof4=;
 b=nVhWxCX2D3GdqzAotZTcjd0x4+tFcOML1Aq6SPfi62nsznAsNUlhm+xxkfGOqq4Rt5/j
 b/bcRDHw8iFhCARxNXv5k935w/HDm5TH+sxBuANEYBrSfjG4N/usTipUHaNOUsKQ2JjL
 z6KzbxbQt51Vps3HNhZnXqqgp8DrUWrkCk6o8b9ESalNpc3DuNtAwGZn6Egd5WPalP2s
 dZljU0s8cG8qQpxnhlmCeDw1MZdjzZ+tDoNmo84t7J6YA5ukFfbE7P7HrDkZNWY0HGQc
 zv2EuuU23+dkyLByAu420LYu67Oe4WtczQVtjPkNgStSmfzcSfloVv63QghbAzsOoHsK kw== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtb960ngh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 00:18:21 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BLK6R1018155; Tue, 12 Mar 2024 00:18:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23t41vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 00:18:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42C0IGAG41353488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Mar 2024 00:18:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65FF52004B;
 Tue, 12 Mar 2024 00:18:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B1B820040;
 Tue, 12 Mar 2024 00:18:16 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.72.107])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Mar 2024 00:18:16 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] gdbstub: Fix double close() of the follow-fork-mode socket
Date: Tue, 12 Mar 2024 01:07:01 +0100
Message-ID: <20240312001813.13720-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lI2Cm5BKsgiIk9VNP1JBKr8sjvrMUmzj
X-Proofpoint-GUID: lI2Cm5BKsgiIk9VNP1JBKr8sjvrMUmzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_12,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=995 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120000
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When the terminal GDB_FORK_ENABLED state is reached, the coordination
socket is not needed anymore and is therefore closed. However, if there
is a communication error between QEMU gdbstub and GDB, the generic
error handling code attempts to close it again.

Fix by closing it later - before returning - instead.

Fixes: Coverity CID 1539966
Fixes: d547e711a8a5 ("gdbstub: Implement follow-fork-mode child")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 7f9f19a1249..08aed022e26 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -502,6 +502,7 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
         switch (gdbserver_user_state.fork_state) {
         case GDB_FORK_ENABLED:
             if (gdbserver_user_state.running_state) {
+                close(fd);
                 return;
             }
             QEMU_FALLTHROUGH;
@@ -527,7 +528,6 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
                 gdbserver_user_state.fork_state = GDB_FORK_ACTIVE;
                 break;
             case GDB_FORK_ENABLE:
-                close(fd);
                 gdbserver_user_state.fork_state = GDB_FORK_ENABLED;
                 break;
             case GDB_FORK_DISABLE:
@@ -542,7 +542,6 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
             if (write(fd, &b, 1) != 1) {
                 goto fail;
             }
-            close(fd);
             gdbserver_user_state.fork_state = GDB_FORK_ENABLED;
             break;
         case GDB_FORK_DISABLING:
-- 
2.44.0


