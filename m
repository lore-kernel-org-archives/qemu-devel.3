Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0029AC3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETVJ-0002EC-EN; Mon, 12 May 2025 09:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETV9-0002CL-5y
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uETV5-0002SB-0G
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:47:26 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9d2p027149;
 Mon, 12 May 2025 13:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=uk8O9Xsn
 Fnk4mEfeCRTjWhdUIbLrfGhFFZUv5J6qlZo=; b=XP8dqghrUrSerf0reC+Xoyib
 CjwKoYHEbiTyR9UxVteOkfeCdiO4NRZ5py1ozVQKOqVDgRQjhmrYWQ2FiHth4e2b
 LAd6av+O1szPOgFIJaV1gOJksKxZAL0cUARBhrtdsfNF2RL2SlWVVSkpq/yL1igg
 sEJ0MzgrLeQZKLwbPNWxUdoHQABpIHxyOnTnqxklOKVBiFi9n/hWGAR3xOzLiTU1
 KnqaOx3UxjRs3xEOUrHJFZ8ucEqMytnl1u1IjdldrpLKooLPX+nQgs0OQwuZjJM8
 O55tiWzyiVC5KIao/XZzv6dIJQLKngMIpc69ca6H0+cCrk/nbhGg2fQ6oMldOQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnjjap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CC3P8a033100; Mon, 12 May 2025 13:47:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46hw8ddfa9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 13:47:17 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CDlHVb001568;
 Mon, 12 May 2025 13:47:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46hw8ddf9k-1; Mon, 12 May 2025 13:47:17 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 0/5] fast qom tree get
Date: Mon, 12 May 2025 06:47:10 -0700
Message-Id: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=979
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120143
X-Proofpoint-GUID: 53GHB2XSa_Dm-5S7ZDgBWcDZUFeXanZU
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=6821fbe6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=dt9VzEwgFbYA:10 a=PaH2gP4kqpskryv8OzkA:9 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NCBTYWx0ZWRfX6xdVxjdvwG6H
 BpBteGlfUOEuNG9sLj+ZBNScSznuUAnLoOd9JhgBPOMY66ppCGgnb+pTYfOAjW3ssqzVYTLzBhR
 qnKuDt7wwaYArwFzO5tcmoS4w7spF6etvE/0VHxhEKonKNOKpERkizPG7ux/sOFBB5YmKT20+QG
 Ssp4LIJoJ4BgwAHLJ+PlNl4kkQBInKKOZIcy+3NpyIyQdY4VJFjsEt9zNDGSq4MxiAZoq93iZKY
 AMY+wHJ8MEfIEgKnR/8Bu0W1Lfr5FUyCbXm6CdvQ1y2n/vEzgGyNY/uo87B+xMovUFJTUwJ3iON
 pcVlsC/PxRywECQNjRmbFhDcaahg/HuNYDuTrGAI8qjxd4DQjmr5RlVvxsS2ClIn8Jf+CEMhSsR
 pW0iE2UHsbkUV6iJKfEzvlQFhx54xZcZzTg+oFY2MlkHfzuWIMWoASsWjV49FqGZSivsNDI1
X-Proofpoint-ORIG-GUID: 53GHB2XSa_Dm-5S7ZDgBWcDZUFeXanZU
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Using qom-list and qom-get to get all the nodes and property values in a
QOM tree can take multiple seconds because it requires 1000's of individual
QOM requests.  Some managers fetch the entire tree or a large subset
of it when starting a new VM, and this cost is a substantial fraction of
start up time.

To reduce this cost, consider QAPI calls that fetch more information in
each call:
  * qom-list-get: given a path, return a list of properties and values.
  * qom-list-getv: given a list of paths, return a list of properties and
    values for each path.
  * qom-tree-get: given a path, return all descendant nodes rooted at that
    path, with properties and values for each.

In all cases, a returned property is represented by ObjectPropertyValue,
with fields name, type, and value.  If an error occurs when reading a value
the value field is omitted.  Thus an error for one property will not cause a
bulk fetch operation to fail.

To evaluate each method, I modified scripts/qmp/qom-tree to use the method,
verified all methods produce the same output, and timed each using:

  qemu-system-x86_64 -display none \
    -chardev socket,id=monitor0,path=/tmp/vm1.sock,server=on,wait=off \
    -mon monitor0,mode=control &

  time qom-tree -s /tmp/vm1.sock > /dev/null

I only measured once per method, but the variation is low after a warm up run.
The 'real - user - sys' column is a proxy for QEMU CPU time.

method               real(s)   user(s)   sys(s)  (real - user - sys)(s)
qom-list / qom-get   2.048     0.932     0.057   1.059
qom-list-get         0.402     0.230     0.029   0.143
qom-list-getv        0.200     0.132     0.015   0.053
qom-tree-get         0.143     0.123     0.012   0.008

qom-tree-get is the clear winner, reducing elapsed time by a factor of 14X,
and reducing QEMU CPU time by 132X.

qom-list-getv is slower when fetching the entire tree, but can beat
qom-tree-get when only a subset of the tree needs to be fetched (not shown).
qom-list-get is shown for comparison only, and is not included in this series.

Changes in V2:
  * removed "qom: qom_resolve_path", which was pulled separately
  * dropped the error member
  * fixed missing _list_tree in qom.py
  * updated 10.0 to 10.1

Steve Sistare (5):
  qom: qom-tree-get
  python: use qom-tree-get
  tests/qtest/qom-test: unit test for qom-tree-get
  qom: qom-list-getv
  tests/qtest/qom-test: unit test for qom-list-getv

 python/qemu/utils/qom.py        |  36 ++++++-------
 python/qemu/utils/qom_common.py |  48 +++++++++++++++++
 qapi/qom.json                   |  90 ++++++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c              | 112 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/qom-test.c          | 113 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 381 insertions(+), 18 deletions(-)

base-commit: 7be29f2f1a3f5b037d27eedbd5df9f441e8c8c16

-- 
1.8.3.1


