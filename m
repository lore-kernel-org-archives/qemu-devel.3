Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E934E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkem-0004un-AG; Tue, 14 Jan 2025 12:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkee-0004qQ-AZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkea-0004dO-T0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:39 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC0pIt008511;
 Tue, 14 Jan 2025 17:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=8rPaoWYIcnG3ayWCY9iT0bK/pDFWNJDVmUYTvhb6Vrs=; b=
 mIWhrka/Vp6kchkecGBcDIcZ9Hjm6RGwryx9qfNsZkSAL3th68oDPi9d3unRNgxP
 ykzFSPXM9u8sOfFHO/lDfjYP6ptB/BiumiSuYzNJY6kzGHkr96XUsxh2nyCegWhj
 yvgxKkwVFE+YBhnKMsrvwj4GUkprLyU3g6AGmcWEAlWPTh6onYcF5Cft00k9ff1N
 X0ACGwYkT97sLycm39FJ+njgFpwwFblRoqCmnFbRdh7eFKEiSYN31jQJVx9TyhJa
 N0q1/5I4LF87wToMvIVNDab70sBTO6F43hC6r0EOVHVNM0tnsT/iKX+zusGFTtih
 UfeA0XLRw+a1kRd8DJmW7g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjap70q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EG2QTo020265; Tue, 14 Jan 2025 17:24:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eq6st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50EHNtYE013352;
 Tue, 14 Jan 2025 17:24:30 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 443f3eq5us-23; Tue, 14 Jan 2025 17:24:30 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 22/24] tests/qtest: assert qmp connected
Date: Tue, 14 Jan 2025 09:23:52 -0800
Message-Id: <1736875434-106563-23-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140133
X-Proofpoint-GUID: Kn09RxzadvB3dZLKy_AHnIxsoCFyHWwk
X-Proofpoint-ORIG-GUID: Kn09RxzadvB3dZLKy_AHnIxsoCFyHWwk
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.794,
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

Assert that qmp_fd is valid when we communicate with the monitor.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index b1e0df9..812b7e8 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -788,6 +788,7 @@ QDict *qtest_qmp_receive(QTestState *s)
 
 QDict *qtest_qmp_receive_dict(QTestState *s)
 {
+    g_assert(s->qmp_fd >= 0);
     return qmp_fd_receive(s->qmp_fd);
 }
 
@@ -815,12 +816,14 @@ int qtest_socket_server(const char *socket_path)
 void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
                          const char *fmt, va_list ap)
 {
+    g_assert(s->qmp_fd >= 0);
     qmp_fd_vsend_fds(s->qmp_fd, fds, fds_num, fmt, ap);
 }
 #endif
 
 void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
 {
+    g_assert(s->qmp_fd >= 0);
     qmp_fd_vsend(s->qmp_fd, fmt, ap);
 }
 
@@ -881,6 +884,7 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
 {
     va_list ap;
 
+    g_assert(s->qmp_fd >= 0);
     va_start(ap, fmt);
     qmp_fd_vsend_raw(s->qmp_fd, fmt, ap);
     va_end(ap);
-- 
1.8.3.1


