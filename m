Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4AAD30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nDL-00075n-BR; Fri, 18 Oct 2024 09:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t1nDJ-00074r-FP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:40:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t1nDH-0001fx-Hx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:40:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IB31ga017586;
 Fri, 18 Oct 2024 13:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=hi06E5myX1QikmJuik7iJJAHGL63
 f7bp45El/sbJBpM=; b=gxU1/3aucfklL0SxKD9er4ZnHKFNx6CTmJrtRyqh+mRN
 9JVqPwuZBM+b1RxPU+Od2EEO528OnW3Pz3QMUsMXGoGeDmHCq9kfKEDbi3kI12wb
 UjyezXU3TDD6h/r7kg+S4isS3vnm7pKwYFlbakP9+cwxo1FLc46NNk8q1sBS9Qpy
 U26ZWff6jkSd+yFNeeSsx3Bl0rhntcwAh0ZaonUd8G4RZxt2Y00rwyZkkgodS4hz
 QXCH4KOfs6jJTGRNedIh2uEDDyVsKTacdLnDdOKA5AuAozRbaBaQoQLoYqKISVCt
 odlCwxk40235xJKyj2dBxjRCKd+jjaX1zlCm5Zw+GA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u91eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 13:40:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49ICePnm005286;
 Fri, 18 Oct 2024 13:40:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njmhys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 13:40:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49IDeEJl27787948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 13:40:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83A7E58053;
 Fri, 18 Oct 2024 13:40:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EBB458043;
 Fri, 18 Oct 2024 13:40:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Oct 2024 13:40:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 0/3] Merge tpm 2024/10/18 v1
Date: Fri, 18 Oct 2024 09:40:01 -0400
Message-ID: <20241018134004.2110276-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2OPcv5Q2Yj0Dfc3DwXozg47IByWzvKrt
X-Proofpoint-ORIG-GUID: 2OPcv5Q2Yj0Dfc3DwXozg47IByWzvKrt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=651 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180085
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello!

  This PR fixes an issue with a TPM test case under heavy system load and
improves control channel error message handling.

   Stefan

The following changes since commit 95a16ee753d6da651fce8df876333bf7fcf134d9:

  Merge tag 'pull-loongarch-20241016' of https://gitlab.com/gaosong/qemu into staging (2024-10-17 12:42:23 +0100)

are available in the Git repository at:

  https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2024-10-18-1

for you to fetch changes up to d9280ea3174700170d39c4cdd3f587f260757711:

  tests: Wait for migration completion on destination QEMU to avoid failures (2024-10-18 07:58:04 -0400)


Stefan Berger (3):
  tpm: Use new ptm_cap_n structure for PTM_GET_CAPABILITY
  tpm_emulator: Read control channel response in 2 passes
  tests: Wait for migration completion on destination QEMU to avoid
    failures

 backends/tpm/tpm_emulator.c | 74 ++++++++++++++++++++++++++-----------
 backends/tpm/tpm_ioctl.h    | 13 ++++++-
 backends/tpm/trace-events   |  2 +-
 tests/qtest/tpm-tests.c     |  2 +-
 4 files changed, 67 insertions(+), 24 deletions(-)

-- 
2.47.0


