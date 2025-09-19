Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386FACAC5A8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbrJ-0000ZV-O5; Fri, 19 Sep 2025 10:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqy-0000R9-Jx
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqs-0007QB-8L
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:45 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtvDU014753;
 Fri, 19 Sep 2025 14:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=3iknegxG
 CeXc7Fc0k8HCoUeI59ZkD+c60Ed7Sk/pNmM=; b=oYDCCl94SNC2lUKlXphsYHPR
 ODsvUWtx0uUyuzxMEwwOtfbFu47Rlx6y3mfT2sBkm3jQocN8Pri++nlZPaLk9Qel
 uLK44Xhw2asMNth5xdxdwzHUSIfIgAtYLLsNFkp996A96lVGHHgQ36oX3hoPiyPA
 yMEjHITnzjYovTxYgw0Ab+dvbdUcBRmHj6DOa6VcoKYEuMJuCBqD67FY3BblBTLT
 zleYAFNFazFxxCqRgqVB5wLkTp1qKIJUoZq3avEh02yt4Xf2xtYNKoScf17rlbOY
 gCyl0XuP0EJ5K9CGjTxgqwHd7xJREoKzgFsrLFF/Vni85Ew3/8VqW4ihou9PGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbwnhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JCaO8d035088; Fri, 19 Sep 2025 14:12:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu92w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYX1003357;
 Fri, 19 Sep 2025 14:12:34 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-1; Fri, 19 Sep 2025 14:12:34 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 00/11] cpr-exec test
Date: Fri, 19 Sep 2025 07:12:22 -0700
Message-Id: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=846 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXy9O9IdmTHQCT
 70EHM0AM9ibxryMp5HG95w/z+dTgbCUVUWNYRKYQ6FNrn27/BFE7hqJTul0GyTjsgjdo8Gjv9zD
 EFT4CWZ0vOlsDo84F9dYqS8obrxZVKO3ZpntE9PtSbvbHSl0BUy6KhsVe5V2Ejk7+6gnCHo7pDe
 zxW9giQ6PbD9BKw+lDvhTJs0J4xCuDjRU65cdsZd1GfckefvG9W5idTxt/Wde5wRaz10igow05d
 bmfVXiubmKJUCjoSP4NqAzJqJdfaggQJg5sh8igZuMhbw56MPhsZgIYrG8w1lIZM3Hj+ueO2VgZ
 As/U4H5+u0Pp/yRKIb3jcTEgRe23OAifLWXiDN4+6l9NLuu1xqGklKIDQaP+6EQQLhDGwNmz37n
 V9JzXOvVHqAUtAI8oyOPYGzjPAqlPw==
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cd64d4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=-q8hymynZDy6LUXG9YEA:9 cc=ntf awl=host:13614
X-Proofpoint-GUID: _bq4Mwld9d3sVAF_XBB6VsOKmG_7TJ5g
X-Proofpoint-ORIG-GUID: _bq4Mwld9d3sVAF_XBB6VsOKmG_7TJ5g
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add a migration test for cpr-exec mode.
Depends on the patch series "Live update: cpr-exec".

Steve Sistare (11):
  tests/qtest: export qtest_qemu_binary
  tests/qtest: qtest_qemu_args
  tests/qtest: qtest_create_test_state
  tests/qtest: qtest_qemu_spawn_func
  tests/qtest: qtest_init_after_exec
  migration-test: only_source option
  migration-test: shm path accessor
  migration-test: misc exports
  migration-test: migrate_args
  migration-test: strv parameter
  migration-test: test cpr-exec

 tests/qtest/libqtest.h                |  25 +++++++
 tests/qtest/migration/bootfile.h      |   1 +
 tests/qtest/migration/framework.h     |   8 +++
 tests/qtest/migration/migration-qmp.h |   2 +
 tests/qtest/libqtest.c                | 108 ++++++++++++++++++++----------
 tests/qtest/migration/bootfile.c      |   5 ++
 tests/qtest/migration/cpr-tests.c     | 120 ++++++++++++++++++++++++++++++++++
 tests/qtest/migration/framework.c     | 102 ++++++++++++++++++-----------
 tests/qtest/migration/migration-qmp.c |  16 +++++
 9 files changed, 317 insertions(+), 70 deletions(-)

-- 
1.8.3.1


