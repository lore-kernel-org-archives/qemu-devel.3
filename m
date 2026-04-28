Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034F3FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHiAL-0006Yk-Ie; Tue, 28 Apr 2026 09:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHiA3-0006S1-BQ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHi9y-0001J2-P8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S8Y6RT036865; Tue, 28 Apr 2026 13:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=G+fU72Hr/1u861QAr1bpmbKcidUk6CaJIJ5giJZ24
 /0=; b=P2WNCwpFMLm/T1f06cbz05+N6+wPOoHu9nACs+jsGXGuyCWijwUd53inh
 Y038y60mv5nLoxCD193bfLu/D1ib/BIZksNqwqDuC5BbYha8KnoODDWC3hp1vqJ+
 GsB+mJsIYBeAVbt16CdZ4cNMt2gYobo5LWBNxFIETOHuESswFn1o7gb0K93v+O2W
 6jYyiEwPbZ2Wh5wUrT1IUlk6vO+maAbpwBn9vtILFXX2iPPKPYHlcggl9lR/F+G6
 chxYKu2MiuDjCs/mxa5rqFVsmH0nUb/GT3VHxU5QNHA10GSfDbSp/yx0WVkxWI/y
 ZKZ87QFZlu9t6w7gpQKcMQESl09NQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1dvftx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCw694020105;
 Tue, 28 Apr 2026 13:07:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avsvm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SD7RLR65339850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 13:07:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7646358056;
 Tue, 28 Apr 2026 13:07:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31D0158052;
 Tue, 28 Apr 2026 13:07:27 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 13:07:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/6] Add test case for TPM over I2C with swtpm
Date: Tue, 28 Apr 2026 13:07:12 +0000
Message-ID: <20260428130718.1325177-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FECB-XYXl8PHlw8VcVVoX54YHdcQIgjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfXxW5sxcVU0qJT
 Wu3q3yy11kzQbI14qy02f+hJI14d1wsNLCWFnBy7vgCEcM81a4jB8h/0XqRDtX//M4DCN4BuII6
 HtIjql4Ag7A4IZA7t8fJisobb/tme0OOMorRQRAMEgOu6T/DduOXJnxc2B7IqT0OcUlnSNN1DyL
 lDeg2CxhZ7G1tMwEMJC8nh5fEHa2KSR1qOShqxSSg/wgJQOrcF8pq9cBAqH73GupBWFy03jJmvw
 /ugaCbqCIK+9DWdlEFnlcmOd3Ic5OHKPnmkNR6/U6tnPfxkfuSeH0Dt9Da+50vlE9WnIiW7klpc
 NbLEEOjyACipENpOdkbTIsgE2UNJVen7Fpz929JcOilxx/2ORgfUiohRqdxu+l8fP+O5FqAp7iZ
 JZRb1rpbGnt2KlXHNyjvLOLR/gq8MuqN4gx3Em8G8pDHBANGjB14M+f8PMyv6U5S5hSR4ovU7DA
 1NSpNNQgzujrGXedrmQ==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f0b110 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=uxgVJ24SbV3yFy2AoP0A:9
X-Proofpoint-GUID: FECB-XYXl8PHlw8VcVVoX54YHdcQIgjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds a test case for TPM over I2C with external swtpm. It is
based on existing test cases for the TPM TIS and CRB. The first patches
refactor and fix some issues in exising code to prepare it for reuse by
the new test case.

   Stefan

Stefan Berger (6):
  tests: Move TPM I2C bus read/write functions to common files
  tests: Have TPM I2C read/write functions take QTestState as first
    parameter
  tests: Set sizes for arrays of expected TPM responses and requests
  tests: Rename id of tpmdev to tpm0
  tests: Implement aspeed_i2c_restart to reenable selection of master
  tests: Add a TPM TIS I2C swtpm test

 tests/qtest/meson.build              |   7 +-
 tests/qtest/qtest_aspeed.c           |   8 +-
 tests/qtest/qtest_aspeed.h           |   2 +
 tests/qtest/tpm-tests.c              |   8 +-
 tests/qtest/tpm-tis-i2c-swtpm-test.c |  86 +++++++++++
 tests/qtest/tpm-tis-i2c-test.c       | 221 +++++++++++----------------
 tests/qtest/tpm-tis-i2c-util.c       | 102 +++++++++++++
 tests/qtest/tpm-tis-i2c-util.h       |  34 +++++
 tests/qtest/tpm-util.c               |  18 +--
 9 files changed, 338 insertions(+), 148 deletions(-)
 create mode 100644 tests/qtest/tpm-tis-i2c-swtpm-test.c
 create mode 100644 tests/qtest/tpm-tis-i2c-util.c
 create mode 100644 tests/qtest/tpm-tis-i2c-util.h

-- 
2.43.0


