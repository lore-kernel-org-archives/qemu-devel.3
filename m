Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF430C83F22
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaG5K-0006yi-FY; Fri, 11 Jul 2025 11:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFw0-0000YZ-DG
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:45:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFvx-0000hJ-VV
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:45:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEMkp5012025;
 Fri, 11 Jul 2025 15:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=KfNB8TktG1F09muA
 L1d/6inJOflrr288kL1YzWh92c4=; b=YjA6WmrVgQCNDD2ot4wbMph9gB0ypMQn
 8tcz16xXDr9frDAAs0o75y78G/piKlPCX9nAAHN3zu1T9vpv1t25xS3/pFbEjUc4
 KOWNKPNo4LPG0X3l+iR8+9bp5Py1ppEWcA86uexWXp8hmCKD6C4rhe2nnThiJIjZ
 RYHZcuZHpzA9d4R3QNvYYvQMV1mxFmnBpoYoynh9Inmg1neqNz+u5W7qRyx9RghE
 wsIrC0TqmBbtzpNpbFPUSAhCKeYiAKr2O/lLCGixFCygaserdHnEM4hGZ+90CYtC
 Xq8pBbd1tPrIKQSEBJfaz5HCqDYf3XiMBAcxq8DxhTcwO4exj3geVg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u4akg5m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:45:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56BFAQuX040566; Fri, 11 Jul 2025 15:45:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgdxyp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:45:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56BFj4Xw029028;
 Fri, 11 Jul 2025 15:45:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ptgdxyn4-1; Fri, 11 Jul 2025 15:45:04 +0000
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
Subject: [PATCH V5 0/3] fast qom tree get
Date: Fri, 11 Jul 2025 08:45:00 -0700
Message-Id: <1752248703-217318-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExMyBTYWx0ZWRfXzY8A7UGgLdUQ
 VD8TiKkYFxckZE60Kwsqjp5touU2m3FpM0ivQdgsykHoHd8OZPULHxcD2kjeQpO1//uPP2M7dGE
 T8yRX5MXFgd9JeRf+WM1PAtms9jxk0+7dvok9uNi4pmS5btwP+TskUuWqkHwntrgnL4qLF7WIRS
 bMq6PjoLhSZVjrfNo/Q2LuNQC/OGHEonaffrX6eunN6hKdqmv8Tb5k1e8hWJp7YwpTdBBX+rM5P
 Zuc4qQHlohJt18VSRgCKwrT6FrnhbTlO0b0f99IIPCbxWw8UUeHZS6LFTgRa6uy0wIcu4A0uztd
 XmK5Rd1ZEVMixLieIWOisbHLhZPphFSGBla+yW/X0daXW60TBUt3oTKIatEM1sMGcad4srTpEW6
 pYa1DM1UexE/Vdkjq2RQmPl/n5WeGxLslEWGV6ywSZQhS/3FV4UqL84Tk3C9FhNIM51rfRMv
X-Proofpoint-GUID: Osz6vjVpWY-ZgOHkpQeW4OL9YZWLwImL
X-Authority-Analysis: v=2.4 cv=KrNN2XWN c=1 sm=1 tr=0 ts=68713181 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=TM-aJEcYTPFBW_z1ZZMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Osz6vjVpWY-ZgOHkpQeW4OL9YZWLwImL
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

Changes in V5:
  * tweaked the commit messages
  * tweaked the doc
  * added RBs etc

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
  tests/qtest/qom-test: unit test for qom-list-get

 python/qemu/utils/qom.py        |  43 ++++++++-------
 python/qemu/utils/qom_common.py |  53 ++++++++++++++++++
 qapi/qom.json                   |  50 +++++++++++++++++
 qom/qom-qmp-cmds.c              |  53 ++++++++++++++++++
 tests/qtest/qom-test.c          | 116 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 296 insertions(+), 19 deletions(-)

-- 
1.8.3.1


