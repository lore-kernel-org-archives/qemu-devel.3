Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C17FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISJ6-000169-2Z; Thu, 30 Apr 2026 10:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wISIu-0000Ws-Mk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:23:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wISIs-0007Eg-GU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:23:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UCUqPF2648672; Thu, 30 Apr 2026 14:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=SddztLBHByQ33xZD34wZSZQBRCXfTJ2UcmUdcyl+C
 R4=; b=jCERhyYw4Z+ngUqjrQciS7pMptiex/7MwAYYBYCzwyVg+tw8pTk6hAmYl
 mcVHB01JrRh4ALbRy3b3MxQ/OwhckHzy2rbHPb1WNJnVtXg9DLCYEh03OyXNW3Pk
 Z6eyzb836u6qL77W+dOLElOuObSwxUSsa3+N3dS82NNNcDT1HP90XQqf196F/4um
 qw9bkewmjLheP6W3blT00SKsx/tiEq029ubuxK9eewH+MM/cAe67CgRYZUGM8HQW
 sEIPFUPop6mOVZrX8sOV1SrGsLbR9V80c3Zk7uMoc3CRjXD1fvh1jXb5FFrJyVmB
 0EI43d6xtlURVjvrIxWdqZe2IlSeg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vpdty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 14:23:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UE8n84032667;
 Thu, 30 Apr 2026 14:23:42 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gk72j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 14:23:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UENEav22872790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 14:23:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD3D958062;
 Thu, 30 Apr 2026 14:23:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F35558056;
 Thu, 30 Apr 2026 14:23:41 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 14:23:41 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/2] Improve handling of response buffer size in
 tpm_emulator
Date: Thu, 30 Apr 2026 14:23:35 +0000
Message-ID: <20260430142337.2104726-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f365ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=0s17AUUPUcYwv1RGZiYA:9 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: fMmAjRymj2-gj9qcrtMrASEVEfGvMW61
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE0NyBTYWx0ZWRfX5IDyubAk1eit
 KKWGAJFULkUHjjwT5O5NOOkzT6zYNP4d3eo9XC0c/HVnH646zC9cTEMTErsnMQb2nfSc99ds67P
 RVAaMnTMD7Q1DInQ2uwTPUOIrIJO9SmNmwZ3FjfeTG5Aqq994QF1vL3SRwJLsfhLHq+bLjJZ5ns
 tRctR6vGTt2IDXuyoOk2tdLKHd8uHgKbBeUq4nnshPpUGxYMHArUEH3Id9u4CIN56JqA5/AP74j
 eh8+pUIIWEI+TIdMdzm8O+4Ro7TEzz439e1ebrNfSQNC7e5NLvwBuMNl9vqt0kSAaL+OnDWncyh
 S5hISPj6ZiXBMiF0kJCqWGw0dehk6vrsjfBoXtjxgbzchxDsVzcOAcbf768iwgzvMeQZnlcizKU
 nMuzxPsSMXJk3L47TQTSDyG7x9YU/PgJmu4mwz56OesJZYXW19sBXHV2IIpS4j+o7a+u5mPS0G/
 BvlK1CXhfb5eEujzcaQ==
X-Proofpoint-GUID: fMmAjRymj2-gj9qcrtMrASEVEfGvMW61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300147
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

This series addresses some issues with the handling of the negotiated
buffer size that the TPM frontends tell the tpm_emulator (swtpm) to use.
Also, it improves on limiting the number of bytes read from the packet
sent from swtpm.

   Stefan

Stefan Berger (2):
  tpm_emulator: Reject a buffer size larger than what was requested
  tpm_emulator: Limit number of bytes read to negotiated buffer size

 backends/tpm/tpm_emulator.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.43.0


