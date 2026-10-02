Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F301CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeCv-0001JS-8v; Fri, 02 Oct 2026 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCh-0001CU-H7
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCY-0001mp-I5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DZTIL633763; Fri, 2 Oct 2026 14:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=trgvInahni0HEqWXWDLLh3KxqpMa
 6u+t2jao5YZNuHs=; b=eoGaW3r63D/B7AjIME+csZIQ7EhhfIwZYDK2LGAyVfGz
 7eeRXzuOyVBxGIuja+nwl/wcBsqhawmE4TnPeIQLHvC90SV33VK7TMGv3FWFxQs5
 ExaZv4VueIxSaruILwRW2gczXkiUeKgBJocjDwslmgdHSJOsEQzUo2DFW8MGUeWO
 uVjqTXXEEVSa+dMqd/7oaN3g6B7u7y4XuWdwz9mU45wFkL0oI0mdVvReIwtudWU2
 F6eOb8+lIEfA0duFd6OPpkHGW2X6LG7e5VLJN40xlOQyKBe23i4fPbRygIKT1Fxp
 E26WnHmpB0Xj/zE0id+e0H4Hsy99OjgzfFhAVvxC0A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptr887-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DHiK42576808; Fri, 2 Oct 2026 14:25:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h1xk1360y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692EPQ4W42074386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 14:25:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 049995805F;
 Fri,  2 Oct 2026 14:25:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 901E558062;
 Fri,  2 Oct 2026 14:25:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 14:25:25 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 00/10] Fix a couple of issues in TPM related code
Date: Fri,  2 Oct 2026 10:25:06 -0400
Message-ID: <20261002142516.2063735-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nr4LA4jzbl17ViLlTygG1TPeWUu0WHyr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX/KFw6na9P59M
 kmLms35Emazqv/GQUaQ4ZCiRxSbHH2AMpG6rmzy7Xtf2IBZKsU9M9Oi1+nGvcFq+iTfqRjNxZk2
 ATG0MFblohSKxrUSqEi/m3LDjQ4gkSgZ45UBBx12fA4LcB75do5G1x6RaKaaLV0f8xyEmkeTEDb
 l+ifQtoxPP//ZuAl+yMaHib1zpXWh3jOZi69xR2+lN7NLlsqsCU4Axgxe+tdz6x+tFueMbyi2ae
 jK+wvSY6Nlw5WUFH8nvwaKZAmg0FZT0fQvLNPB0nL28tQlV9OGwCLndXI2BBnoIkEqPefD1g+8h
 3Z/LNg7C5iYMVyvALAmTi2VYZmJ6pU91cUDyTunG0dTFlPYDZowRMfAoQpKV6s+/JqT1DNOzWtm
 bJUOuNhxsKMiLbxYVm7klVQaIboHl41v6dRxF2pbsjVmlb0ljjwjJpGtjqL+u4v6G7spMccAemR
 6KUXXA5TdmBJUiNFJXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX4ptJ7M4ZL/uJ
 RH7504uyoBYtLuaJZVFieMUMd+py9nEj87P0L1YQDDZK57O319H6JqtMNF+7xunh4il66U836SU
 XSRDyo11iRIig4su7iZuQwJgxtbfds0=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abfbed7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=nOQdVPWBrISVqpPLdNYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NWImQ_-GP3C-f_26ipRWwh76Fzi85GJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020056
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

This series of patches fixes various issues in TPM-related code, such as
memory leaks, potential integer underflows, clearing of buffers while they
are in use, and the proper handling of sizes of commands or responses.

Regards,
 Stefan

v3:
 - 6/10: Remove call to clearing of buffers

v2:
 - Address issues pointed out by Marc-André

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


