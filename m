Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75373D4335D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92NR-0000pW-59; Thu, 07 Nov 2024 08:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t92MU-0000iD-6J
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:15:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t92MS-0001LZ-Ha
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:15:45 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DAZI4001770;
 Thu, 7 Nov 2024 13:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=mAENxy05zLgwzmAj1Z933JCP8+hO
 eZA2XsMFeHOXqxw=; b=O6cDbvbpRL6ZIgBVpNhdI2ie6OqkHYDV874HPzo+xQ1Q
 eeyjBcdsUMM/5m9zFWcB/dejkSAbRRSZ75HntKpTf9use0G9o0QaPUaXHl+puy3i
 H8IGD+5g6FCeZ4A9CmVTXBMdsP26lBelzOBwOJ03AWYQancbPtvi+k8trW8k84EI
 M4QDouiyYM0ei/wJXrwol4Wvbpwz62QZ6RVfRJFJwHD5/OiMYPuqb8VmRJvhL5bR
 pMOTh6L/kUeuTll44mcVGJcKzR4wdLB1qZs19tokh2xIZ5msuZXfhAgWCV3ZfH+R
 QPKUvjjYNGTiUqf9VCznbN1v/b86pjrCRJ9hNKlZwg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rx6ug0t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 13:15:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71nnR8019625;
 Thu, 7 Nov 2024 13:15:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj85fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 13:15:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A7DFe8464422356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Nov 2024 13:15:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F2E558058;
 Thu,  7 Nov 2024 13:15:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AA6558057;
 Thu,  7 Nov 2024 13:15:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 Nov 2024 13:15:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 0/1] Merge Aspeed TPM test 2024/11/07 v1
Date: Thu,  7 Nov 2024 08:15:38 -0500
Message-ID: <20241107131539.36843-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -N-OZdUHPlqqo55ur5OYCEcxDJ37q8vT
X-Proofpoint-ORIG-GUID: -N-OZdUHPlqqo55ur5OYCEcxDJ37q8vT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=621 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070102
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

  https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2024-11-07-1

for you to fetch changes up to 0736038408308012ed34aa2135ea3b458d9cff41:

  tests: Adjust path for swtpm state to use path under /var/tmp/ (2024-11-07 07:58:04 -0500)


Stefan Berger (1):
  tests: Adjust path for swtpm state to use path under /var/tmp/

 tests/functional/test_arm_aspeed.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.47.0


