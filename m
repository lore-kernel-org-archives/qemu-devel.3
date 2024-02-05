Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DE1C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 20:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX638-0007QO-6x; Mon, 05 Feb 2024 15:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX636-0007Po-Nx; Mon, 05 Feb 2024 15:58:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX634-00037n-1J; Mon, 05 Feb 2024 15:58:40 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415KgC3h022319; Mon, 5 Feb 2024 20:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=K1N2J01iDo0TTtTYwFYAgKh7B3Zv8ONaQ4h5jfWTu6Q=;
 b=kX83G5L/bMWqHFRaj33tY0VMeiV2Nt6rIYVK7QbYm9A1/8yQiLXrs7re8SpX65B9qIOl
 MCZnMRhfBECxlgIHkhQ0s/2GnI9uZlE3XovmYQTFuIohBWu7eqGjl3pdjNXZwgLvKFN/
 0HA5Rwior53cQILcfmGtAdycyzbLEpYLjJ/ATcRm/d4ukBqVJThYy04+O11eweaBtisq
 lj4khE0P3XJ+gI5daRbSHh7k8BTB1uHgYPOnzJZGWqDz2td7uQNjkH7T7xecc7tmpZ3V
 s/APIDLn9Cax7wM04kA3B6YaM1ILsw/GqUjkJFstapYFiywqTtiJg0QFZnXaWnzb5u4t Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w36xj8aff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:34 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415KswU7020725;
 Mon, 5 Feb 2024 20:58:34 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w36xj8aex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:34 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415J4YOp020383; Mon, 5 Feb 2024 20:58:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytsu4sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415KwVtt27066804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 20:58:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADF2920040;
 Mon,  5 Feb 2024 20:58:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4742620043;
 Mon,  5 Feb 2024 20:58:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 20:58:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 0/4] target/s390x: Emulate CVDG and CVB*
Date: Mon,  5 Feb 2024 21:54:52 +0100
Message-ID: <20240205205830.6425-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7mne-fiFW2MdbvXiZbI8Z_z0-e3yotH4
X-Proofpoint-GUID: vS41bha-1rMXVF4ceIpaTYtfSWBBuO6c
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=508 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

v4: https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00434.html
v4 -> v5: Remove a redundant CVBG overflow check;
          Write the comment explaining the remaining CVBG overflow
          check;
          Add R-bs to the tests (Thomas).

v3: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06664.html
v3 -> v4: Implement CVB error handling (David/Thomas).

v2: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05048.html
v2 -> v3: Resurrect an old CVB* patch (Thomas).
          Add Richard's R-b.

v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02865.html
v1 -> v2: Fix !CONFIG_INT128 builds (Richard).

Hi,

Ido reported that we are missing the CVDG emulation (which is very
similar to the existing CVD emulation). This series adds it along with
a test.

Best regards,
Ilya

Ilya Leoshkevich (4):
  target/s390x: Emulate CVDG
  target/s390x: Emulate CVB, CVBY and CVBG
  tests/tcg/s390x: Test CONVERT TO DECIMAL
  tests/tcg/s390x: Test CONVERT TO BINARY

 target/s390x/helper.h            |   3 +
 target/s390x/tcg/insn-data.h.inc |   5 ++
 target/s390x/tcg/int_helper.c    |  97 +++++++++++++++++++++++++++++
 target/s390x/tcg/translate.c     |  24 ++++++++
 tests/tcg/s390x/Makefile.target  |   2 +
 tests/tcg/s390x/cvb.c            | 102 +++++++++++++++++++++++++++++++
 tests/tcg/s390x/cvd.c            |  63 +++++++++++++++++++
 7 files changed, 296 insertions(+)
 create mode 100644 tests/tcg/s390x/cvb.c
 create mode 100644 tests/tcg/s390x/cvd.c

-- 
2.43.0


