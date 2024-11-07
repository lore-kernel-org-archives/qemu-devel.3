Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D1D4336D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 15:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t944x-0005GZ-L0; Thu, 07 Nov 2024 10:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t944u-0005D9-Mo
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:05:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t944t-00067L-3I
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:05:44 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7F5XAj016240;
 Thu, 7 Nov 2024 15:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=ki2XUxT3tDzQLKRkfBHC/IEZ1r8U
 8NE9OhrAWkEnXl4=; b=QtD0f9lVS0e3aZqr0hrAZTAtE+iGinKK8IMjHMY/jVRZ
 4VMCcZSAhGZZWlOp8l2kG0Z29jZ8aQEtV4rFq80WN96PjNjCJzCGeIWi1YUQmwqW
 UccU+V2rBJ38aZss1cLOyakUvHSlBn4PUG4Q/vNKF1ZyamAbQBSFDReg3L4RUXiT
 NnSMJsC6f2t+I9wClDk8RVmP3kG+mVbYvDxk+gUDZmyn5q/FQEo78tWv+WjYpztR
 46coC7W7xuX+NWyAqqSHqtkfTKxbOh36f/grsYez1nSlPyIBR1O5XMMiRmBkwAdX
 TWGfsufyz6pwjqBf3JTmnousD1kR2B4oraHzyYhpnQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rxmrrcn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 15:05:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DuP8F008423;
 Thu, 7 Nov 2024 15:05:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywm7bpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 15:05:40 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A7F5d9n28836400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Nov 2024 15:05:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5CEA5804E;
 Thu,  7 Nov 2024 15:05:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F2825803F;
 Thu,  7 Nov 2024 15:05:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 Nov 2024 15:05:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v2 0/1] Merge Aspeed TPM test 2024/11/07 v2
Date: Thu,  7 Nov 2024 10:05:33 -0500
Message-ID: <20241107150534.38651-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X9cJ3pICKwaHrQ-DkCM3k_h74OcTe7Yj
X-Proofpoint-GUID: X9cJ3pICKwaHrQ-DkCM3k_h74OcTe7Yj
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=758 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello!

 This PR fixes the path used by swtpm to store its state and now uses a
path under /var/tmp rather than a path local to the test. We ran into
issues on Ubuntu when that path was under /mnt and therefore not
supported by the AppArmor profile of swtpm.

   Stefan

The following changes since commit 63dc36944383f70f1c7a20f6104966d8560300fa:

  Merge tag 'hw-misc-20241105' of https://github.com/philmd/qemu into staging (2024-11-06 17:28:45 +0000)

are available in the Git repository at:

  https://github.com/stefanberger/qemu-tpm.git pull-tpm-2024-11-07-2

for you to fetch changes up to e3edada526f3ac28f71dc8ae7a0acbc76f8e2050:

  tests: Adjust path for swtpm state to use path under /var/tmp/ (2024-11-07 09:57:20 -0500)

v2:
 - Added missing comment into test file; generalized it a bit from Peter's
   suggestion

Stefan Berger (1):
  tests: Adjust path for swtpm state to use path under /var/tmp/

 tests/functional/test_arm_aspeed.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.47.0


