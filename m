Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5E4C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kdI-0003fk-4Q; Thu, 24 Sep 2026 10:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kco-0003QN-8d
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcm-0004Xe-3y
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC5waj2190404; Thu, 24 Sep 2026 14:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=K5SaCe+30wzvveO2Z75zxWu6eJ00
 E6mEFeMyIhK5rpM=; b=hH7dJ3hI8dcdm1XysYURXBnD5FyYcp98TfC0MsB6N1Jp
 Pi0un/CMOWcM89YZMarxe1P3sTIBOxSCjtYiiEDeoBIJt4NNLTYUjIuJCKx53E5T
 zBf+WJ617b/Xq7WRzeXnB6YTZvOSYkcRXrjPj4ExLeg68osEPgHKfxYXgCqaBryJ
 v/S9Vi1upGk9mwrfa4PrHpAevhAqVLv2obde9EBrd/p7WL0UDMiU+yCeUIdLBffo
 evoaz9VvpaaI1W5U1cK7/N2w1UDEODrRo9cJ2elKfIplnE2rB5U8TdHWG3jIK5pX
 U/XsSR78D6hkhJrSdv+kHmymScYalnS9dy3nVeIYCw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2sshf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OEOoNQ2194322; Thu, 24 Sep 2026 14:40:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2x5sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEeVEL26542644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D40C5805E;
 Thu, 24 Sep 2026 14:40:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB25A58059;
 Thu, 24 Sep 2026 14:40:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 00/10] Fix a couple of issues in TPM related code
Date: Thu, 24 Sep 2026 10:40:16 -0400
Message-ID: <20260924144026.953360-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: gGVM7Yi5jfsssrJHMXPuYaE2L_vmjXzK
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab53661 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=nOQdVPWBrISVqpPLdNYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX6ouzzEviJNDw
 bbx9UPP3RjN7gVoERRY280+35NUClpcSOwWe8LAyqTuSerbXOmAIIwf9wRWjDapK208G3UdozCh
 x1NlsTPEvFwP1bowwNkqqpQr3Kik1ltUiT0VSI7A94P7RapD08BhuZhDsp/jlle6PPakNVXbC95
 oLkFwCZkMFnJLIlJXRwQlcfCn3DPEclvGejjxbgjdoV7eopDUOeKgI/BPSrcocfPVtw0lQ93Llm
 jW76MXa7y4E+4bUJgjNyVXEdcPqatZYHO+6SDzEGE4v+adDzERr35zk5vh5W8JcSWEsGR/WZPXo
 wP+UUEHUK9mKLpQr9rzHflyW+AEKgnleJDGRKhJYO3XSRrq8b04Tj4G2Pk4aJMEIrDI8qDpMSV/
 oGaREwxTT4Q/D95wKWF0uqLSf45FyYjTM7rhKevUnIKUlsTzE/lj+R2d9Zhe8e5UOaNjED6p9kL
 BAyh5y4pRfxv8c7Ivlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX/sLhxtkP+j0z
 bVK0tjgp63AzMpXe5wlrRJoWab5LFwVxGkDtQ0tqk5kWfSUtyDjk6QKzNwrb/ZLzYGkTbN/V3Og
 TPKIOFuRorkFDOS1NTCzvivygl4QunI=
X-Proofpoint-GUID: BBplgR6la7z1X_vT-TtiQe8vlUBSaY5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240060
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
 hw/tpm/tpm_crb.c                        | 23 +++++++---
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
 15 files changed, 221 insertions(+), 16 deletions(-)

-- 
2.55.0


