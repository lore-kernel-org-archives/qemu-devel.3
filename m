Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C6C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 00:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX9Fq-0001ks-Lc; Mon, 05 Feb 2024 19:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX9Fo-0001k0-7W
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:24:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX9Fm-0003sl-Mu
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:23:59 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4160Co8L002620; Tue, 6 Feb 2024 00:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IdfyLjmjBFjOm41WcYRxyRP1wxtS7n7cjmmGOvVqigk=;
 b=khTs/WdX5tYEGZGjubSgNyr7L7rDGA014w70msleikSzDMvqFvfQqF1+bNF/rqb/ViSO
 e/S2QF6nakTGDTTvUtGO15qtYfvSaCi2HAyCwbOLZS2Q+SwYo2VW/KWN0Is43xFr8TNk
 GcWiEViiY/KaOu0oOZ5zXUY/CV1N02xVTtiifwHTddi+j8GA3FbuYUUYVetFAl/RultI
 b8Gg7U5TOJ7R/WG545jUEwSbtkqQxI+C9oOWg4p/bb9ExpiIvBdY8rouIL5A9Jc7FNjr
 eZvquZ1IwE/gxr/ZJ2YXpmdLVQyoo/apV24SLgMzEHfPoTgl+XH2fQYqT/eilqWNFjam mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3a1ag5va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:56 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4160L1Fr020602;
 Tue, 6 Feb 2024 00:23:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3a1ag5us-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41602quY005430; Tue, 6 Feb 2024 00:23:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akbmxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4160NqHI38863502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Feb 2024 00:23:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0E9820040;
 Tue,  6 Feb 2024 00:23:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF3EA20043;
 Tue,  6 Feb 2024 00:23:51 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Feb 2024 00:23:51 +0000 (GMT)
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
Subject: [PATCH v3 3/4] test-util-filemonitor: Adapt to the FreeBSD inotify
 rename semantics
Date: Tue,  6 Feb 2024 01:22:02 +0100
Message-ID: <20240206002344.12372-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206002344.12372-1-iii@linux.ibm.com>
References: <20240206002344.12372-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7bfUiLYSx8lUlwmckAH5mJK43CByAek7
X-Proofpoint-ORIG-GUID: eu8e0N1M_bnwh8u6XGCxvUjJ_1i9N4uQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060000
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
already exists results in an IN_DELETE event for that existing file:

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
@@ -343,40 +343,48 @@ test_file_monitor_events(void)
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
 
-- 
2.43.0


