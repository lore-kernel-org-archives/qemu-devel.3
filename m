Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D02D1AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 13:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t14BR-000147-M7; Wed, 16 Oct 2024 09:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t14B5-0000rM-98
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:35:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t14B3-00049b-9X
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:35:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GDKF7s026703
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=tRgsc2Mtj/TSId4mpKfiwml2sOQjEOHtJ/ZYOAdaB
 CY=; b=jNodwCwtZ/dWpt9QC86Q/Vxo0qDJN+/1HDH2zyunNjUb9PWQ8IJ+RBkZT
 eGB2y/YPehxFXNTBa/RDNuuYUdpnCoW7MRTgzq6rBhy33bt1UXsJxzZ6WMnh08YU
 +CJn7SiZNrHkuLfT9qQMhcxmVBaIz81vt0Dlb3wXTlkDjo3QtRqBQQX+BFqCtrHP
 JKJLV53bi+DhaZvfrGKdpfMeOEP6fCjtI2tukvjxhViIf1ZD/pFrzBbncISVwqbT
 hmbLUAt5L8cVjkeSWjJUIGVAUztQE2ADO553dOOCYU87aNfmAU8nq0bKYYePtc5v
 9FFTREb54Lm7NhGstq2tbwoexFpgA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ae9g820p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:34:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GDYwmX029189;
 Wed, 16 Oct 2024 13:34:58 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ae9g820n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 13:34:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAtwja005215;
 Wed, 16 Oct 2024 13:34:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj9cc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 13:34:58 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49GDYv0J47972674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2024 13:34:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64F0F58045;
 Wed, 16 Oct 2024 13:34:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D652D58050;
 Wed, 16 Oct 2024 13:34:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2024 13:34:56 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/2] tpm: Resolve potential blocking-forever issue
Date: Wed, 16 Oct 2024 09:34:48 -0400
Message-ID: <20241016133450.1071197-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ERbt5Pxi9EqrVx1bNQJkqQXL0cO_moTB
X-Proofpoint-GUID: ZgO6nJc0IDxnA5WsXjuqXxNr2WQbHQaE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=514 adultscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

In case swtpm was to return a control channel message with an error code it
would only return 4 bytes. However, some of the commands expect a response
with more bytes and QEMU would get stuck in qemu_chr_fe_read_all() waiting
for bytes following the error code. Therefore, read the response in 2
passes stopping if an error code is received in the first 4 bytes to avoid
getting stuck. Implement an exception for CMD_GET_STATEBLOB that has always
been sending the header in case of error.

   Stefan

v2:
  - 


Stefan Berger (2):
  tpm: Use new ptm_cap_n structure for PTM_GET_CAPABILITY
  tpm_emulator: Read control channel response in 2 passes

 backends/tpm/tpm_emulator.c | 45 ++++++++++++++++++++++++++++++-------
 backends/tpm/tpm_ioctl.h    | 13 ++++++++++-
 backends/tpm/trace-events   |  2 +-
 3 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.47.0


