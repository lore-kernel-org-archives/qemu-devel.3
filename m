Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32BAF54ACF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53vd-0002kp-Rz; Tue, 24 Mar 2026 11:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schlameuss@linux.ibm.com>)
 id 1w53vX-0002jp-KM; Tue, 24 Mar 2026 11:44:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schlameuss@linux.ibm.com>)
 id 1w53vV-0003SX-Ut; Tue, 24 Mar 2026 11:44:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCjGJN3481709; Tue, 24 Mar 2026 15:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=JiND6mGiPvbE2LYKOKXLYrjLtSLL
 QoO6Xdn0gIx8CCY=; b=tg3s6Yn4Oa3yJ68E5f9V7KlD4kTaE/VBf2LP95IwNfDe
 3guni/kTKQPcEgrSk8qkPRxSbkAVpcW1dKhsIrs07izaVoP4YmJgTKytVIVafYpv
 jU8yQX04Z2TFV7d/zpVnO/XcPJiDSelOwdSRvBE4lOvZjcoiiVkdR4SPmrMibKX4
 HoOmm0BEJIfGrRgJFJm2Xd5k0Nr6hV2U7z1qu3wejozpdO01nyDEUvEU4SsdDPzP
 8n8sgPW83TAUUXfzC7aCPegnMuWtIAFOBf9mUN703njv5OcjPhhFm9bFXBGYVLs5
 5H5qrCXLkbN6tb30y+aTxacIszCM0Rus//kqhRhmSA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqcb18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 15:44:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCXFOW026685;
 Tue, 24 Mar 2026 15:44:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275ktg27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 15:44:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62OFi6iT46793018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 15:44:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4C8020040;
 Tue, 24 Mar 2026 15:44:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E35E920043;
 Tue, 24 Mar 2026 15:44:05 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 15:44:05 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH v2 0/2] s390x/kvm: Add ASTFLE facility 2 for nested
 virtualization
Date: Tue, 24 Mar 2026 16:43:43 +0100
Message-Id: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03Myw6CMBCF4Vchs7akM14CrnwPwwLLVCaBlrRIM
 KTvbiUuXP4nJ98GkYNwhGuxQeBFoniXgw4FmL51T1bS5QbSdNGka9XG2Q4sTKo6M5vadjXhEfJ
 /Cmxl3a17k7uXOPvw3ukFv+tPQfxTFlSojG0R7YnIdtVtEPdaS3mMpfEjNCmlDzNihB+mAAAA
X-Change-ID: 20260209-astfleie2-85eec9fd9213
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>, kvm@vger.kernel.org,
 Christoph Schlameuss <schlameuss@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=COzvXf95VgYEGFT3vkIvilIgEuwTrj6d18C4DXXyebQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmHNrre+3LAj5krjetWQu1N0dMFwu0S/QcPMZU9/HbkS
 uOfRT+ud5SyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCR8GyGf1YhkQU9OaxdTA8X
 fNbZdVSjL04i4KC2xpZUeeXCMoPrOgz/owONZs6Z0rV107Ml6+qjldt9oo+KfzhrkMl6e8LT5R2
 JXAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DoZzYelRpbj0VMS9CnGpYd2PlKxbtea-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX7eOt/3jKOe2N
 Ie3h0tUC2cwuRS0jkYcEN/Hw3qa0jQGCvNXzUM5SXTkSOFpwClemCRqjuIaQHXlNo23AeljuC6J
 1M/V7Are8pVRl2Bi3YeLttEo+mAJpnIbk+0S9iz4dgmTx4basFzAEFTRDTJpFHT4qaAxJeFKoRC
 utfnS7pRcEX7PVjrRFXBCKMRUMTl/ByK69Z5LQ3vrN7viVa5IizmRuG8bRjMXOvNpJNxYRFCPKn
 PMzfqAgqOU+y1VQAnOC9EuNBpAZKVz+RCJoia3sWCgy/g0G1H0tPcW8K/iCPmRcQ58u+3TV+GaC
 puE1BnUSSEEHaqxbhyMobehvnc/mr8CgJeKnXk9CwKegXCLSc9RwT+uD5eKUfUDPRH4gBdJkP/z
 akZaRPCyG7QvHbVcaaAi5PYSmij9guUyLJbCIqGYRI+X3LGwAmWJql3/1g0G5ehdYBohzv4r7ZI
 5qapC53+SBEWCs1uPXQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c2b14c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
 a=fVmZTmo3ZkCWnWwVhVYA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DoZzYelRpbj0VMS9CnGpYd2PlKxbtea-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240119
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=schlameuss@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update the kernel headers to get access to
KVM_S390_VM_CPU_FEAT_ASTFLEIE2 and allow passing the feature through to
guest on IBM z16 onwards.

Cc: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: kvm@vger.kernel.org

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
Changes in v2:
- Isolate the linux-header update into its own commit (thanks Thomas)
- Correct naming of the feature (thanks Hendrik)
- Add S390_FEAT_SIE_ASTFLEIE2 to full_GEN16_GA1 only as it depends on
  SIEF2 (thanks Christian)

---
Christoph Schlameuss (2):
      linux-headers: Update to Linux v7.x with KVM_S390_VM_CPU_FEAT_ASTFLEIE2
      s390x/kvm: Add ASTFLE facility 2 for nested virtualization

 hw/s390x/sclp.c                     | 2 ++
 include/hw/s390x/sclp.h             | 4 +++-
 linux-headers/asm-s390/kvm.h        | 1 +
 target/s390x/cpu_features.c         | 3 +++
 target/s390x/cpu_features.h         | 1 +
 target/s390x/cpu_features_def.h.inc | 3 +++
 target/s390x/cpu_models.c           | 2 ++
 target/s390x/gen-features.c         | 1 +
 target/s390x/kvm/kvm.c              | 1 +
 9 files changed, 17 insertions(+), 1 deletion(-)
---
base-commit: fa4b2e31e649ba6fdb3eb2dd43952aad4a3bd675
change-id: 20260209-astfleie2-85eec9fd9213

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>


