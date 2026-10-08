Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCC3CA6015
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvhJ-0000Yv-SF; Thu, 08 Oct 2026 17:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveY-0000Mp-RZ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveR-0002os-81
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5dxT2295339; Thu, 8 Oct 2026 21:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=U8B6818JIHNOdqy5VYEmQp1t6tas
 ELO9ySFi6zKf8RI=; b=bDGSzfGxtZX0hBh6AFZ7eOAsN9kNX58ZSMV3xj1d1Rx2
 NmNSHNSTkXRyNJ9+mxnB85mvfop05P04AeWUsXAM8Fyvabb757LP3+kStfvB/DC9
 vjio6GDYBXyaaanhADsiQZx6+0ec3reIHRvQ0PnNn972Drr84v5IBu0CIRPupfeT
 mFDjHom0TUHQPaPtgdFD697DOyPW1G9CQCwco9bQZyDGtm8DUKKyN0aA0q6uKpw+
 zvAKEEsuYU45naoExhjFZ2FymyGzL1VoUtKYUB1b/fCaaib7IbRDQIR/6PSTj+D6
 DjHtrspw2V9uu3jsM6fNscvKeHRfR9i/D9cTCGeVZA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw691t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2ZJB4019491; Thu, 8 Oct 2026 21:27:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5sgu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698LRPd329884992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 21:27:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 811965805F;
 Thu,  8 Oct 2026 21:27:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1825558054;
 Thu,  8 Oct 2026 21:27:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 21:27:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 00/10] Merge tpm 2026/10/08 v1
Date: Thu,  8 Oct 2026 17:27:13 -0400
Message-ID: <20261008212723.3679685-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX4AxNK54ijw9k
 b35Dlb8gAONWvril4RCCE/7TwZZ19fRtiyrc/+3bIFaZ6APTZZYDySiXlMurHJwZ8Fnp5rC0vqx
 O4ZN8zF+wGX4JiKBZJKOFjwtE51Inqk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX9QfbgCbx7OQ0
 FriBisYEGR6vr9MM+8Eee74ruyux8XdN87Ej3/c5hw9KgwLUHX92XWpTVuw3kU3ujm7maQ9qeyW
 Rm9Aufw8OTcNK15X3+PBFa4X1onQTE7nQaZwnoPNqIldzoWEp/AEttFMR+vyU1D/W8cxAF2zgtZ
 dSaQTMUkuFm194lh1ctqeReOAPAL+GATm9ycZWgrWOWlgGZ6ljJ3Zs5se1tGEcNsw6IuIb2VxNA
 OaKAVdfIb2GXvKlWe5wMWU8/Tje1jQqocR5+Bt/hFKvaMO72JZVgWn6DcZgvj3490NfIF2+ftj+
 OVNrlBfs0nn/aRnfVUf1ke0X1AzysYYU2T79yXrW/c61aZcGmEgVPTcbv/u+wL8+xV37Ubx+ncJ
 WojZeSdDue5OfMQMfuYWghwU/FMIgb+8w01npnLvuL9r/eh77cLU7WxuXlDewsdYWDQpI3GgbVt
 cJ7lRwCIv54siCEwKeA==
X-Proofpoint-GUID: SS6UyrHIKjShQdaMRqWkHyZx6UsGH679
X-Proofpoint-ORIG-GUID: SS6UyrHIKjShQdaMRqWkHyZx6UsGH679
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac80abf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8
 a=NEAV23lmAAAA:8 a=h9gIwb5NLW55QV2TNaAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:

  Merge tag 'pbouvier/pr/plugins-20261005' of https://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)

are available in the Git repository at:

  https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2026-10-08-1

for you to fetch changes up to 0c2f2309cddf6dcb5a340e7838e2b37e3fc22bf8:

  tests: Add tests with commands with bad length (2026-10-08 17:18:31 -0400)

----------------------------------------------------------------

This PR fixes a couple of issues in TPM-related code.

   Stefan

----------------------------------------------------------------

Stefan Berger (10):
  tpm_util: Pass TPMVersion to function writing fatal error response
  tpm_emulator: Reject TPM responses whose size is too small
  tpm_emulator: Reject sending commands smaller than the request header
  hw/tpm: tis: Only read from response buffer if rw_offset < len
  hw/tpm: tis: Use uint32_t for len to avoid truncating size of command
  hw/tpm: crb: Do not clear internal buffers when backend is busy
  hw/tpm: crb: Avoid potential integer underflow
  hw/tpm: crb: Implement tpm_ppi_uninit and use it in tpm_crb_unrealize
  hw/tpm: crb: Consider response_buffer->len of received response
  tests: Add tests with commands with bad length

 backends/tpm/tpm_emulator.c             | 12 ++++--
 backends/tpm/tpm_passthrough.c          |  2 +-
 backends/tpm/tpm_util.c                 | 17 ++++++--
 hw/tpm/tpm_crb.c                        | 21 +++++++---
 hw/tpm/tpm_ppi.c                        | 10 +++++
 hw/tpm/tpm_ppi.h                        | 10 +++++
 hw/tpm/tpm_tis_common.c                 |  8 ++--
 include/system/tpm_util.h               |  3 +-
 tests/qtest/tpm-crb-swtpm-test.c        | 10 +++++
 tests/qtest/tpm-tests.c                 | 56 +++++++++++++++++++++++++
 tests/qtest/tpm-tests.h                 |  8 ++++
 tests/qtest/tpm-tis-device-swtpm-test.c | 10 +++++
 tests/qtest/tpm-tis-swtpm-test.c        | 10 +++++
 tests/qtest/tpm-util.c                  | 55 ++++++++++++++++++++++++
 tests/qtest/tpm-util.h                  |  3 ++
 15 files changed, 219 insertions(+), 16 deletions(-)

-- 
2.55.0


