Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0671C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 18:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX3Tu-00060g-AE; Mon, 05 Feb 2024 13:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX3Tr-0005zj-GW
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:14:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX3Tq-0005vC-0w
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:14:07 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415HfKdY030782; Mon, 5 Feb 2024 18:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OjpwU5KDoZLOFP+X0NzCRTTWcd2Mc/m/SMvsZ+X6Cz4=;
 b=eVXSaxcxGEAvx0zLCorm3fGgWkbyZ920kOS/DMWIBo/jxuuSdjBfgLkBJUSAVXtQ6/aV
 gfK3fLt5D3VQtQM0bSa37aivupVrNJe1FPhhSmqXKxcuL29GQaSLZjHcRJ7zTs7ur1CB
 Dohr2cKNyPvorCgHFqeCtMGBTYNOdmRkl+lKhpfWQA50Fh9nY30kieLmImEkXxgwpk0c
 5spr89X/bfeihLdxO/5v+CQUrsj7juKRepn1Yb6Mqema4ix7pBOKzbqXPIjDP3QCFc2V
 Gg3ePnKg9Pa5RrTQXyuw3Wt8ojDrUPdQUxLAQb9eBSnoqXQGw6dnbCHt8ydjzqJU9D3W ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w341c17fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:14:02 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415HQ6au005911;
 Mon, 5 Feb 2024 18:14:01 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w341c17ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:14:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415I2jBP008478; Mon, 5 Feb 2024 18:14:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221jsrya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:14:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415IDwZ237814786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 18:13:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AD8A20040;
 Mon,  5 Feb 2024 18:13:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9C3E20043;
 Mon,  5 Feb 2024 18:13:57 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 18:13:57 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 3/4] tests/test-util-filemonitor: Adapt to FreeBSD inotify
 rename semantics
Date: Mon,  5 Feb 2024 19:11:34 +0100
Message-ID: <20240205181352.1567-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205181352.1567-1-iii@linux.ibm.com>
References: <20240205181352.1567-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TKvzF6rb8w3FB_1-6OVzMt_oO24HccLN
X-Proofpoint-GUID: i1yEtzIAmxO4G28gF1ajzyA9y5ZTgwvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050137
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Unlike on Linux, on FreeBSD renaming a file when the destination
already exists results in IN_DELETE event for that existing file:

    $ FILEMONITOR_DEBUG=1 build/tests/unit/test-util-filemonitor
    Rename /tmp/test-util-filemonitor-K13LI2/fish/one.txt -> /tmp/test-util-filemonitor-K13LI2/two.txt
    Event id=200000000 event=2 file=one.txt
    Queue event id 200000000 event 2 file one.txt
    Queue event id 100000000 event 2 file two.txt
    Queue event id 100000002 event 2 file two.txt
    Queue event id 100000000 event 0 file two.txt
    Queue event id 100000002 event 0 file two.txt
    Event id=100000000 event=0 file=two.txt
    Expected event 0 but got 2

This difference in behavior is not expected to break the real users, so
teach the test to accept it.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/unit/test-util-filemonitor.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-filemonitor.c
index a22de275955..02e67fc96ac 100644
--- a/tests/unit/test-util-filemonitor.c
+++ b/tests/unit/test-util-filemonitor.c
@@ -333,60 +333,68 @@ test_file_monitor_events(void)
 
 
         { .type = QFILE_MONITOR_TEST_OP_MKDIR,
           .filesrc = "fish", },
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "fish", .watchid = &watch0,
           .eventid = QFILE_MONITOR_EVENT_CREATED },
 
 
         { .type = QFILE_MONITOR_TEST_OP_ADD_WATCH,
           .filesrc = "fish/", .watchid = &watch4 },
         { .type = QFILE_MONITOR_TEST_OP_ADD_WATCH,
           .filesrc = "fish/one.txt", .watchid = &watch5 },
         { .type = QFILE_MONITOR_TEST_OP_CREATE,
           .filesrc = "fish/one.txt", },
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "one.txt", .watchid = &watch4,
           .eventid = QFILE_MONITOR_EVENT_CREATED },
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "one.txt", .watchid = &watch5,
           .eventid = QFILE_MONITOR_EVENT_CREATED },
 
 
         { .type = QFILE_MONITOR_TEST_OP_DEL_WATCH,
           .filesrc = "fish/one.txt", .watchid = &watch5 },
         { .type = QFILE_MONITOR_TEST_OP_RENAME,
           .filesrc = "fish/one.txt", .filedst = "two.txt", },
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "one.txt", .watchid = &watch4,
           .eventid = QFILE_MONITOR_EVENT_DELETED },
+#ifdef __FreeBSD__
+        { .type = QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc = "two.txt", .watchid = &watch0,
+          .eventid = QFILE_MONITOR_EVENT_DELETED },
+        { .type = QFILE_MONITOR_TEST_OP_EVENT,
+          .filesrc = "two.txt", .watchid = &watch2,
+          .eventid = QFILE_MONITOR_EVENT_DELETED },
+#endif
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "two.txt", .watchid = &watch0,
           .eventid = QFILE_MONITOR_EVENT_CREATED },
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "two.txt", .watchid = &watch2,
           .eventid = QFILE_MONITOR_EVENT_CREATED },
 
 
         { .type = QFILE_MONITOR_TEST_OP_RMDIR,
           .filesrc = "fish", },
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "", .watchid = &watch4,
           .eventid = QFILE_MONITOR_EVENT_IGNORED,
           .swapnext = true },
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "fish", .watchid = &watch0,
           .eventid = QFILE_MONITOR_EVENT_DELETED },
         { .type = QFILE_MONITOR_TEST_OP_DEL_WATCH,
           .filesrc = "fish", .watchid = &watch4 },
 
 
         { .type = QFILE_MONITOR_TEST_OP_UNLINK,
           .filesrc = "two.txt", },
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "two.txt", .watchid = &watch0,
           .eventid = QFILE_MONITOR_EVENT_DELETED },
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "two.txt", .watchid = &watch2,
           .eventid = QFILE_MONITOR_EVENT_DELETED },
 
-- 
2.43.0


