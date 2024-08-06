Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37059C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKYi-0006vK-M4; Tue, 06 Aug 2024 09:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sbKYf-0006rm-Tx; Tue, 06 Aug 2024 09:49:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sbKYd-0008WI-Vi; Tue, 06 Aug 2024 09:49:01 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DLR1C000773;
 Tue, 6 Aug 2024 13:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=wb2lG84tHOjE2n49+/aEmST15T
 01qAYzC+/KuUUG/NY=; b=qB8ItfSOEp0AZhv4KMRyi303gzLdyGq6imUtVqGxP9
 vP0RZ8JkZvzIqIM/gc60+gqtodoc5mgnPDgQp4RzFzaRaEydasKed9dMuDkJzKjf
 rrErkQ1uawU+hZduRDPyuOUiZjpc4cr+6y6fiNwk2bpFO1EmdkI6vDh4IiuswAE9
 h0aPYQZxPMQcxuZ3bG3RQQFeVJC6c7sIwTzZ34cX/KGG2aMaqZYz00A7aEjq9Dr+
 nlAY2pqJyi9cpXJwez/+f5zBoKkLuxn2n9IOL/sMZw++pC8xFeHdUHllHKBM+qhP
 A5HQsa3GwwjgfvqS55Zy1Ta5paUW1SMFUTV87AMK7Xag==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u5t3svwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 13:48:48 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476DiHgt009813;
 Tue, 6 Aug 2024 13:48:48 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u5t3svwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 13:48:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 476AaTXt018618; Tue, 6 Aug 2024 13:48:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40sxvu45nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 13:48:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 476DmgFJ27984578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Aug 2024 13:48:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E34642004D;
 Tue,  6 Aug 2024 13:48:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D9A420040;
 Tue,  6 Aug 2024 13:48:39 +0000 (GMT)
Received: from LAPTOP-UGTOAIPD.ibm.com (unknown [9.43.9.228])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Aug 2024 13:48:39 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v1 0/2] hw/ppc: SPI model - coverity fixes
Date: Tue,  6 Aug 2024 19:18:27 +0530
Message-Id: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -D5MbXrZkdlCLu4eWnjsnItXc3fFMyNW
X-Proofpoint-ORIG-GUID: y71-h39IYs8e4aopZwOEegonevvzhf2C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=737
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060093
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

In this patchset below defects detected during coverity scan for latest
spi model changes were fixed.

- CID 1558831:  Resource leaks  (RESOURCE_LEAK)
  Variable "rsp_payload" going out of scope leaks the storage it points to.
- CID 1558827:    (OVERRUN)
  Overrunning array "s->seq_op" of 8 bytes at byte offset 16 using index
  "get_seq_index(s) + 1" (which evaluates to 16).

Tested:
passed make check and make check-avocado

Chalapathi V (2):
  Fixes: Coverity CID 1558827
  Fixes: Coverity CID 1558831

 hw/ssi/pnv_spi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.34.1


