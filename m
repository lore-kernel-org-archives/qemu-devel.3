Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8812C98312
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9YDc-00018U-4D; Wed, 23 Sep 2026 21:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDX-00015d-VD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDV-0007Kv-Bf
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNZSWh2891570; Thu, 24 Sep 2026 01:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=gbSeMPqjIwMw6u1rXjIA5OETNdiAflfpHgOuQCqa3
 LE=; b=QUbhmg9k8Bylxp4eJJ66xBJIP52Oh8VikVD+i8BdbT3Tq0AJOr9hKxpCH
 vNwR4qfTQP+iY4rAx9vjJKYvSS4imAdgK3ge8+IXHMpp87Q849hQiZVZa/FcaYb5
 jVcJJ2I/jAWEu1YAVvDPuIAj+SQ8sENTgnVbIkZKiWkT/j6mKPBrvdNosCcMC6k8
 E0x+yFh9lbs86MM/h9xSn6kZRMEGsax5C7AUgHZuL4f74uIa/D3Kav3Y1M7W/16f
 iitSpu+BTHKjPKfj53B6lBEbdrnG5azFcgeG8DWE0oRSByFKZedk86W+Ueyp7bvf
 8wI3E4HJbziSQOtcEqbKzDuWLuIxw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1xdxy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNHaIZ1132960; Thu, 24 Sep 2026 01:25:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jukm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O1Pa7j47448518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 01:25:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E786E5805D;
 Thu, 24 Sep 2026 01:25:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6743358053;
 Thu, 24 Sep 2026 01:25:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 01:25:34 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 00/10] Fix a couple of issues in TPM related code
Date: Wed, 23 Sep 2026 21:25:17 -0400
Message-ID: <20260924012527.858527-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: QLnA4ZBwI_FeUOVWbhitVuKKcD0G1n_C
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab47c11 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=nOQdVPWBrISVqpPLdNYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX/UOuZicmbcKe
 /gl4zpzfUNAy/crv8BBaB4EAVVXs+x27kmuCNlmTVnVYJGwurVryDtsR73Xr0CnJVU6iWsV6Ao7
 5LhOxqlwZspEFqkxA4Xtg06vNXD4i6Y=
X-Proofpoint-GUID: RaedgCzwx3VlaT_QxJXK5p55RDgzbK12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX1J+0aVItfQf3
 2omtFPG8Q91Uv8a1NJM7O8AQlsRiXHUkFqU8vcheB7k8Y6tmGvY8nvcWt3cT+trQi3A4LLZ52OR
 /g3UHvLF74+f43obQ6pgHjDFZEPKyWTxEXZSmBNqKtGCgCk8x8YzB7/hmejnqN8Hj56zeTD8b5Q
 pUD99pNOn3Leqf60c74Zf5vdtYVZ1A9smJGTgm4g8OYRJOPyQiGZBTTqVxuaseGw4KszRRCWa5q
 2V/bSSCIQi2HBzDo3cLHbqbdPs1W0nfy5p8IyqJ3uee0eSiO4lnuQ8NULdMCqaEOATOyDoAM4vp
 lLUPm14nqjcg3+0Luw1Xhr+9OnYlCRnwhjcl6rTwkQaErNFhgVq9IO+sHOPBDOWaK0yuEBDYSrQ
 ftUnvPt09iP5v62CyozgFrhJ//1Vww13l56yEMqG6C7CLodGLmtfM8wFB3d+C2UvW8rjNevtxvB
 aBnVhP9s4VJF60B+qvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_08,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240006
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

This series of patches fixes various issues in TPM-related code, such as
memory leaks, potential integer underflows, clearing of buffers while they
are in use, and the proper handling of sizes of commands or responses.

Regards,
 Stefan

Stefan Berger (10):
  tpm_util: Pass TPMVersion to function writing fatal error response
  tpm_emulator: Reject TPM responses whose size is too small
  tpm_emulator: Reject sending commands smaller than the request header
  hw/tpm: tis: Only read from response buffer if rw_offset < len
  hw/tpm: tis: Use uint32_t for len to avoid truncating size of command
  hw/tpm: crb: Do not clear internal buffers when backend is busy
  hw/tpm: crb: Avoid potential integer underflow
  hw/tpm: crb: Free ppi.buf in tpm_crb_unrealize
  hw/tpm: crb: Consider response_buffer->len of received response
  tests: Add tests with commands with bad length

 backends/tpm/tpm_emulator.c             | 12 ++++--
 backends/tpm/tpm_passthrough.c          |  2 +-
 backends/tpm/tpm_util.c                 | 12 ++++--
 hw/tpm/tpm_crb.c                        | 23 +++++++---
 hw/tpm/tpm_tis_common.c                 |  8 ++--
 include/system/tpm_util.h               |  3 +-
 tests/qtest/tpm-crb-swtpm-test.c        | 10 +++++
 tests/qtest/tpm-tests.c                 | 56 +++++++++++++++++++++++++
 tests/qtest/tpm-tests.h                 |  8 ++++
 tests/qtest/tpm-tis-device-swtpm-test.c | 10 +++++
 tests/qtest/tpm-tis-swtpm-test.c        | 10 +++++
 tests/qtest/tpm-util.c                  | 55 ++++++++++++++++++++++++
 tests/qtest/tpm-util.h                  |  3 ++
 13 files changed, 196 insertions(+), 16 deletions(-)

-- 
2.55.0


