Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE94C83F21
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuLy-00060C-Pj; Thu, 10 Jul 2025 12:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZu52-0008I4-5Z
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:25:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZu4z-0002XE-7U
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:25:03 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFqEBK023674;
 Thu, 10 Jul 2025 16:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=zToMb8GAUe62wM+X
 g48W3JtcjnIzHCTds6t+OiN1Vec=; b=bjAOaTPYunSTshenpkuwksquXz7+iqCc
 fm/B+HCbEEx7oqV27GN5qRPqJzeBJpPlvrP60gJpXicYJW2fnwQygNlnWQ9E0mi0
 qiCIt/1vOwWjiHVfCL2nHy76SfhegZgkgkAYj+Q4auMDtS0UfU0YLndzTfcmvx1K
 U3iY1ymLPbhACoT121c5sG3ZS8Q0gNhFNI7H/CjGHxhai/HYRtxNVRCmj5e+FNS/
 imrJwgmmT+FqiXcwiDGreSpmtFElAa5UOqZoH6OSH7y8iyyK5k1p4Fwk8nenP961
 kTTeYKdWkw1SYRu1hY84bbV3UPEW4rECcHA/dyEAISQkhsDEWdBDtQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tghe01vj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jul 2025 16:24:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56AFWrju014147; Thu, 10 Jul 2025 16:24:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgd9bqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jul 2025 16:24:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56AGOtom005343;
 Thu, 10 Jul 2025 16:24:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ptgd9bq1-1; Thu, 10 Jul 2025 16:24:55 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 0/3] fast qom tree get
Date: Thu, 10 Jul 2025 09:24:51 -0700
Message-Id: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100139
X-Proofpoint-GUID: TI9YEJS3yN_EYMShhl_G5GZVedZiPty1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX0n7nUCr/t4oC
 //m2exGxFsbls3GRZ0PAA157BTE/7zckdZq8i/4f25OpNL/hqtu9w7csSN+fS5zMGWYAMHtY538
 RlNa1PLFGH4lIb64YV2e34+iGMn4eg+bYdxgf9SCorupkmVHfYijmpYPp0xBM/cSDOQQ3rHNEMU
 gUm81GEueSeAYXcCzh+vCkde2xKY1KfwPO7WuN7LuLO7vvXlCABU9DTYDAYqItoYmTmcFf47fKC
 hx0FT841s1rtcg/7xkrBcwwvBZljIoIklz93Bj6YTwR3cLhTpD5V9Z1YW0ZKkf3BhFWZ5C6YanT
 UBV5fQ3cG3h/S4oHpQ0woFY4rHLvS17poEImdoHKZxUwu5cwgC9kyGj+I8yO/iA0uLb4ELltWoa
 ajlZYEnP0BDB1rzrKWRIiG3qd78oLB6VsU1jmySTd3sDrd1i0PVr/b9TI2W6qom5VPd4iXHa
X-Authority-Analysis: v=2.4 cv=X4NSKHTe c=1 sm=1 tr=0 ts=686fe959 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pGMINUbP5fDhvze3-5cA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: TI9YEJS3yN_EYMShhl_G5GZVedZiPty1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Using qom-list and qom-get to get all the nodes and property values in a
QOM tree can take multiple seconds because it requires 1000's of individual
QOM requests.  Some managers fetch the entire tree or a large subset
of it when starting a new VM, and this cost is a substantial fraction of
start up time.

To reduce this cost, consider QAPI calls that fetch more information in
each call:
  * qom-list-get-one: given a path, return a list of properties and values.
  * qom-list-get: given a list of paths, return a list of properties and
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
qom-list-get-one     0.402     0.230     0.029   0.143
qom-list-get         0.200     0.132     0.015   0.053
qom-tree-get         0.143     0.123     0.012   0.008

qom-tree-get is the fastest, reducing elapsed time by a factor of 14X,
and reducing QEMU CPU time by 132X.

qom-list-get is slower when fetching the entire tree, but can beat
qom-tree-get when only a subset of the tree needs to be fetched (not shown).
To keep things simple, provide only qom-list-get.

Changes in V4:
  * renamed qom-list-getv -> qom-list-get
  * expanded the qtest to verify a value
  * cosmetic changes in the docs
  * expanded the qom-list-get commit message

Changes in V3:
  * dropped qom-tree-get
  * modified the qom-tree script to use qom-list-getv
  * cosmetic changes in the docs and code.

Changes in V2:
  * removed "qom: qom_resolve_path", which was pulled separately
  * dropped the error member
  * fixed missing _list_tree in qom.py
  * updated 10.0 to 10.1

Steve Sistare (3):
  qom: qom-list-get
  python: use qom-list-get
  tests/qtest/qom-test: unit test for qom-list-getv

 python/qemu/utils/qom.py        |  43 ++++++++-------
 python/qemu/utils/qom_common.py |  53 ++++++++++++++++++
 qapi/qom.json                   |  50 +++++++++++++++++
 qom/qom-qmp-cmds.c              |  53 ++++++++++++++++++
 tests/qtest/qom-test.c          | 116 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 296 insertions(+), 19 deletions(-)

-- 
1.8.3.1


