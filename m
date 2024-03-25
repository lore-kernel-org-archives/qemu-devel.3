Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C7FC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropwH-0006bx-9I; Mon, 25 Mar 2024 15:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1ropw9-0006bI-0V
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:24:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1ropw5-0007uV-Py
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:24:48 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PIxFB2031715; Mon, 25 Mar 2024 19:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=PtHzLDtw97KMI8RioTmO4IejAd+WDCiTKGwfhwHtp4w=;
 b=QGtogi2NWULFUxV+RmnjQ8UltNx4EXHuMjsnADamAuctB6kz2Ximn+2vN4AKg3RfgpIi
 SOdQnSX4kYqDxFHC0vtGJp043ZftJKFM25LmoopJUlG1XB8siDB8GUlM9XoIOCdWjGDb
 FQflRgFICY5f6geTqcOApCUaiKeAvfzvFeBli+Sk+okGQ47fxSkrPdYOFX3iro0nIYdI
 QUdO09Pc74C46BVqxLrTClhwAAi+nPbRE6XIIPGQMcVz9o5z46UgNdy9Gyy+Q2gYUbZI
 I0wA0kqQS2Krha8JFJkZC9x1ldlQRYK3h/FUAWW/qQc9BeF5x+BCfV6ewijKLxcOh+Ce Gw== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3995rwr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 19:24:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PHCkQd028790; Mon, 25 Mar 2024 19:24:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp373b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 19:24:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42PJOdre17105184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 19:24:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0265020043;
 Mon, 25 Mar 2024 19:24:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BBD920040;
 Mon, 25 Mar 2024 19:24:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.7.191])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2024 19:24:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/4] linux-user: Fix shmat(NULL) for h != g
Date: Mon, 25 Mar 2024 20:22:58 +0100
Message-ID: <20240325192436.561154-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k_vOrP2kxqI2YmL3X_cxE62G8mNx_9MF
X-Proofpoint-GUID: k_vOrP2kxqI2YmL3X_cxE62G8mNx_9MF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_18,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=851
 phishscore=0 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250116
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v1: https://lore.kernel.org/qemu-devel/20240325153313.526888-1-iii@linux.ibm.com/
v1 -> v2: Remove an unnecessary ifdef, add R-Bs (Richard).

Hi,

I noticed that while shmat() now works with /proc/self/maps,
shmat(NULL) got broken. This series fixes that along with two related
strace issues, and adds a test.

Best regards,
Ilya


Ilya Leoshkevich (4):
  linux-user: Fix semctl() strace
  linux-user: Fix shmat() strace
  linux-user: Fix shmat(NULL) for h != g
  tests/tcg: Test shmat(NULL)

 linux-user/mmap.c                            |  2 +-
 linux-user/strace.c                          | 10 ++----
 tests/tcg/multiarch/linux/linux-shmat-null.c | 38 ++++++++++++++++++++
 3 files changed, 42 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-null.c

-- 
2.44.0


