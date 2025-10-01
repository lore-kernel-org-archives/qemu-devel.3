Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0081CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yr6-00057q-D2; Wed, 01 Oct 2025 11:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqt-0004gR-Kb
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqc-0006Ql-Ji
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:46 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMxrS018982;
 Wed, 1 Oct 2025 15:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=N3itqlTFBV7zPp+bNBCXvQMCPjGOgCw/pQqj9VVHmpY=; b=
 XvJ92bqh2HCWDg6oW+UYFmg0CH9MYo2DlYLRVdpug5bXAbzqocWoJv8Js12hOJRv
 CW9uZ1kHSbKousJnuRqkzXZArIT8Z3x065yAwX3b99mxJT1WKcBIKaYNuPwgBaSe
 z0pRqibvShTVfAnJydwClkQhE6e0zKcXg10QiMm7qq7o5Ole4tQGFsWv+1JC9RRN
 w8HPfBWgc0skfXlhSzknhzj6xkR8qN5DoNrAMYAtvME3syV6kaSqcz4HgGX7V2gR
 1WC0deIknoAYzDMmrpdm9wq8W2IuDSV5qGdXCnDDucDr4LXHgm/SugevK4yff7b/
 mWLef6jpERh0fSOQ978tsA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmrfsmjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EkqMX023130; Wed, 1 Oct 2025 15:34:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCqu014790;
 Wed, 1 Oct 2025 15:34:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-10; Wed, 01 Oct 2025 15:34:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 09/19] tests/qtest: export qtest_qemu_binary
Date: Wed,  1 Oct 2025 08:34:01 -0700
Message-Id: <1759332851-370353-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Proofpoint-ORIG-GUID: vNYeAMaQddQO4zTK9beSRxTiBhQeHCPc
X-Proofpoint-GUID: vNYeAMaQddQO4zTK9beSRxTiBhQeHCPc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE3MCBTYWx0ZWRfX0d2D45ZD5alL
 kWFoubWJqEucieaQ9QPT9XnS5YR28AIpax0yBGeaIpgX3IigkRXA/zDaHbhLMfZhc9PqkSVAEi5
 CkBKy6++6JGz6Mf+pZ3hlpWAfQUnviFo0TTNiMtn1x+xy7u8aFsFz8S8TPzu/rW1PYpwy2P+RT8
 hfjtYxCxm3A91r7i1QJe4qNJWbwuvzGhYIZMsJgwMxZBX+IhzC7P4N0Pz8VsO5/QwtaIA45Z0fl
 c5P7goJZAJE7R/uoX/XxoGYoqMAXeV/1NbvOIEEz0g7YRAUfDqIXdnOhfiJwTy7/MbZqaw1+ugl
 UHNu/6CbdEhypxy+lqxOw2Wy+jZnjSDTCplFDdWyZ0ls89uTbTpLbjGbUGrzOSq9oh+r95SbJjD
 ii2xrLignkxptgWiRmQ/I2hesnFlVA==
X-Authority-Analysis: v=2.4 cv=VpMuwu2n c=1 sm=1 tr=0 ts=68dd49fc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=Df2fqW_L1vg5yVQ28mgA:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.h | 9 +++++++++
 tests/qtest/libqtest.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index fd27521..dc2cdd0 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -48,6 +48,15 @@ QTestState *qtest_initf(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
 
 /**
+ * qtest_qemu_binary:
+ * @var: environment variable name
+ *
+ * Look up @var and return its value as the qemu binary path.
+ * If @var is NULL, look up  the default var name.
+ */
+const char *qtest_qemu_binary(const char *var);
+
+/**
  * qtest_init:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 94526b7..43fd997 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -357,7 +357,7 @@ void qtest_remove_abrt_handler(void *data)
     }
 }
 
-static const char *qtest_qemu_binary(const char *var)
+const char *qtest_qemu_binary(const char *var)
 {
     const char *qemu_bin;
 
-- 
1.8.3.1


