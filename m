Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DDFCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMrl-0006FF-Tm; Wed, 07 Oct 2026 04:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEH1Y-0000RA-QL; Tue, 06 Oct 2026 22:04:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEH1P-0004ee-Dt; Tue, 06 Oct 2026 22:04:49 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6GqJ3415786; Tue, 6 Oct 2026 10:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=sXbhlQCXpE1tB0ECLpEdbnWN0sXNARwpzyZn2O4hr
 OE=; b=WINw806VoC/sQMxxoE2QJcucoLR4zZLlVxcCxkgoNjQHyuUE2fOPDJbgP
 ezEzHF8K9Acs5F7jXXZ14//JxX1duT6WqZ/ND96YQ7Hn+pZw5J6saprjl9Qjo2Aw
 B5Mu+CE9t9m8uGEVPBbpGJslXoCVR+CpeL+y9CIQgXmAL0lwsnhRva322N8UXWOl
 zZ46toIHnoFSEwAVD1rVGWCpTz6kp7edTAkIQ5Io3OUledjNfLyaRlh8SoUZzydw
 gM5PUd5Be3Ehs4Xst1JTj+6GboqXw2g9fLDNToZ0orVwN9hPab13VHU2j6dljHSN
 FD9LsDNeYc7+c3OVL47DVKLYZ7K6g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv6hhr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6GU9129430; Tue, 6 Oct 2026 10:57:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1psrsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696Av7V931064746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 10:57:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F21D320040;
 Tue,  6 Oct 2026 10:57:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBD402004D;
 Tue,  6 Oct 2026 10:57:04 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.135.85]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 10:57:04 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com,
 milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 0/8] Enable DMF for Power ISA 3.2
Date: Tue,  6 Oct 2026 16:26:11 +0530
Message-ID: <20261006105650.189752-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ecnS3Bgr0JpSc8FeEXTpwITL_SCgITTh
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac4d408 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=Ixqt2FsUAAAA:8 a=WQa2n-BGj3dUJBCbj1EA:9
 a=wbNHd7AAyUN6gYWAVcba:22
X-Proofpoint-GUID: llUJgKwF5GLvRnOM6fqTNriBpUinGqpk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX6elzB3XHuV1Q
 3/n56FtweOKYEgdZSjOUiXEgr8sRx020cCr8cYvejXhsLTpOTwBaUfq7XlhXqgLceEsTBM0MmBp
 5omeaCaXfuLUEWr8dEoCVKJ5PO5P7mIOxOj+M44GkAq/XikrINcVwTcLNE/Tw51oiWhJ4i2/VOs
 2WBePey6revbwYGWCPpnONx7InJQAF8SaqHwwCJ+1Ind2ptrF9vun71le8Rz5SsBqkUUaO/fBv2
 sRXuz72ootiRQ4f+xBxmljsnv2+HXdwmqMWttYwmtTXizuTNtt5ygYiKsZP2kQ8QiuEwmUoX8AP
 bFV3Em0vosQ5ygFnd8HtpBJrcRULb/uu4g0hb+8VGiY1FxUZ3HeL03y5fZRvRt3n6Wjy0F3CZzr
 Q+Kog9mXDXnjvibxYeQm7Ea5122fPenN7dVoqaJ9Rij0fZ0Z64RuPwlbtjO3iu7lYXtAF7Bq0yM
 wkzHsxVQhWLVLzAE9LQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX8hp1Hv6ZFJkJ
 nFS+S+h+lTLrDNd8N8uBeSCPpvF79YxNo4FlPsR7ykWFnacQgIw+fjjl6lib/zVsyzfJDdhARn4
 TZm3n9GJkfz1AqFq7+LyHFnBP0gs9oM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060042
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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

This series aims to implement the dense math facility introduced in
RFC 02653: Dense Math Facility for Power ISA 3.2.
The RFC is available in the OpenPOWER website here :
https://files.openpowerfoundation.org/s/Fyp9TWZf8oYTd7D

Chinmay Rath (8):
  target/ppc: Add flag for Power ISA 3.2
  target/ppc: Enable Dense Math Facility for ISA 3.2
  target/ppc: Implement DMR getter/setter and some DMF insns.
  target/ppc: Add FSSIR spr for ISA 3.2
  target/ppc: Implement DMMR and DMXOR instructions.
  target/ppc: Implement DMF accumulator instructions
  target/ppc: Add function to point to dmr regs in tcg_env
  target/ppc: Add DMF Outer-Product accumulate to ACC insns

 target/ppc/cpu.h                    |  23 ++-
 target/ppc/fpu_helper.c             |   5 +
 target/ppc/helper_regs.c            |   4 +
 target/ppc/insn32.decode            | 201 +++++++++++++++++-----
 target/ppc/insn64.decode            | 244 +++++++++++++++++++-------
 target/ppc/int_helper.c             |   5 +
 target/ppc/translate.c              |  13 ++
 target/ppc/translate/dmf-impl.c.inc | 255 ++++++++++++++++++++++++++++
 8 files changed, 644 insertions(+), 106 deletions(-)
 create mode 100644 target/ppc/translate/dmf-impl.c.inc

-- 
2.55.0


