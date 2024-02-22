Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5CBC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 21:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdGvo-0000zX-7Z; Thu, 22 Feb 2024 16:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdGvR-0000p6-64
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:48:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdGvC-0005PY-4Q
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:48:16 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MIQTQW027804; Thu, 22 Feb 2024 21:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=VpBVeMIAWmtd8e/4yg8wM074HFClXVcWCLt5XFXuryk=;
 b=gwoEO9uNn1fF8NOYU4YDaB2YeTh3V0ufcxLIufKDtbrw8XaEn3q7ijmMP57RLP6JT2SV
 +C6cufOrE7B96h0Sacq45H3O0bQtUizJir9ow3fvYbUTNNxZ/0FUHqdmQy6lwG499uQZ
 Wj4dt62csfGNl9VodHYbzLHltAfoiRYgVW3a6nQCYK8Diux/+/yPzlmfbEulXiyce9+n
 LY9/zjG47+6dnlt59lVucZqOQPVx6aijCxBipxJymqQEWc1NmJP1Us9e5/VrPfAGYf4w
 Hk94LcbgijmgSgI1pj1XhGBw2AwHYm+hrRAgL2kcs68xSvam5tg9eQvY35WpR8qLf5ck 5g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu5ue2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 21:47:53 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41ML0PPu022357; Thu, 22 Feb 2024 21:47:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8bft4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 21:47:53 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MLlqU7037274;
 Thu, 22 Feb 2024 21:47:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8bft40-1; Thu, 22 Feb 2024 21:47:52 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 0/5] string list functions
Date: Thu, 22 Feb 2024 13:47:45 -0800
Message-Id: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220169
X-Proofpoint-GUID: wTF7BmEwa5cAeeLV0vwjZ_IdNXKvK5CL
X-Proofpoint-ORIG-GUID: wTF7BmEwa5cAeeLV0vwjZ_IdNXKvK5CL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add some handy string list functions for general use, and use them in
live migration functions.  These will also be needed for cpr exec mode.

Changes in V5:
  * renamed some variables and one function, replaced GStrv with char **
  * aligned backslashes in QAPI_LIST_LENGTH
  * restored cutils.h to exec.c

Changes in V4:
  * added exec migration patch

Steve Sistare (5):
  util: str_split
  qapi: QAPI_LIST_LENGTH
  util: strv_from_strList
  util: strList unit tests
  migration: simplify exec migration functions

 include/monitor/hmp.h     |  1 -
 include/qapi/util.h       | 13 ++++++++
 include/qemu/strList.h    | 30 ++++++++++++++++++
 migration/exec.c          | 57 +++++----------------------------
 monitor/hmp-cmds.c        | 19 -----------
 net/net-hmp-cmds.c        |  3 +-
 stats/stats-hmp-cmds.c    |  3 +-
 tests/unit/meson.build    |  1 +
 tests/unit/test-strList.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 util/meson.build          |  1 +
 util/strList.c            | 38 ++++++++++++++++++++++
 11 files changed, 175 insertions(+), 71 deletions(-)
 create mode 100644 include/qemu/strList.h
 create mode 100644 tests/unit/test-strList.c
 create mode 100644 util/strList.c

-- 
1.8.3.1


