Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D902AC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 21:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpD3L-0008UL-VP; Mon, 03 Mar 2025 16:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3I-0008So-8I
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tpD3F-0008JT-T5
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 16:10:15 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523JfjrB001838;
 Mon, 3 Mar 2025 21:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2023-11-20; bh=Pqw97mO8
 1IMD7Zh35EPz50hrrBmVzRYx8UpEOnr19ig=; b=lBaGEuZ2snizFeYL+1aUHzaY
 ZjlQeVHtcFXG0xYDf8XzGlLF/tMRd/0l6rKw7YncaG5jgztscK8dUg0aP+xJrl8H
 HBHInskSF4hXZA7Pa5Nhtn1U4hD6VdBFH+kBUk6Mwu+uHM+vqF4pXmI90XJOl26c
 Rb43VLZGvJtFYzjnTRu7ChWxebvMu7qlGYQHm8Sg53oWkNbXF8x9K1kEKwVAYtD1
 h1mzQCd/RWcKhN6TvIf/+lqk4psxD15CxK7UP1HOVOEm35ig0Hcj+lkMwJAGXyY5
 TE1c+X7teBp8Bu6luR0eQt3/zzU8nSq6Q9/Mol0aLHHPanOkvWAI5Gy2/pQXjA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavuma3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 523JiEd0003144; Mon, 3 Mar 2025 21:10:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rp82py2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 21:10:05 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 523LA4Ic022708;
 Mon, 3 Mar 2025 21:10:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rp82pwh-1; Mon, 03 Mar 2025 21:10:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 0/6] fast qom tree get
Date: Mon,  3 Mar 2025 13:09:56 -0800
Message-Id: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_10,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=920 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030163
X-Proofpoint-GUID: r2SMCtpipHebTS8wowPS9I9-CnM6hvEx
X-Proofpoint-ORIG-GUID: r2SMCtpipHebTS8wowPS9I9-CnM6hvEx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
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
with fields name, type, value, and error.  If an error occurs when reading
a value, the value field is omitted, and the error message is returned in the
the error field.  Thus an error for one property will not cause a bulk fetch
operation to fail.

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

Steve Sistare (6):
  qom: qom_resolve_path
  qom: qom-tree-get
  python: use qom-tree-get
  tests/qtest/qom-test: unit test for qom-tree-get
  qom: qom-list-getv
  tests/qtest/qom-test: unit test for qom-list-getv

 python/qemu/utils/qom.py        |  36 +++++------
 python/qemu/utils/qom_common.py |  50 ++++++++++++++++
 qapi/qom.json                   |  93 ++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c              | 130 ++++++++++++++++++++++++++++++++++++++--
 tests/qtest/qom-test.c          | 116 +++++++++++++++++++++++++++++++++++
 5 files changed, 401 insertions(+), 24 deletions(-)

base-commit: 354925d42252f6f36a9e1e4a6b929aaafb2eaf45
-- 
1.8.3.1


