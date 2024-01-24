Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E250C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSdQG-0006EP-QO; Wed, 24 Jan 2024 08:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rSdQB-0006CX-B9; Wed, 24 Jan 2024 08:36:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rSdQ9-0001VP-JA; Wed, 24 Jan 2024 08:36:03 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40ODMJ4Q012719; Wed, 24 Jan 2024 13:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8gI2PYwBFH1wCeusRbOoH7KX7wjxRnkABSzLapb8aiI=;
 b=W3JD9lH/XhFmuktw/QrdyMq5ooKzGCQvPa4vR12tymDshkJsrEV8S6lgLglPPo4f3bcS
 3NEmQVY0OlBb+TAPMX9qOMU5cnMOn2HKI74YFnfFTvcrDBjBto0qOprFo1iXm2ljgaYV
 NWQEV7iXjNyFkaYEUQsoEG24m5Y4/9oAlohB4AIeh1UaamQBxmBxTG0gQh2OUGHZZi9C
 8l8DK/EZJlgxvmpd+11flPLIPVc6oH4dFn6s5IIDOzM1r9L9RDKKmyJo37GvHB7WukxR
 k8+FgGWHIT2zGsCRRydNHZ93J2oJSTgfxbEquREfJoi8qnwI7KZCbFi2+S5k1j3yHX5u Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu3cf8d7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jan 2024 13:35:58 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ODMlCM014267;
 Wed, 24 Jan 2024 13:35:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu3cf8d74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jan 2024 13:35:57 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40ODR6pv025892; Wed, 24 Jan 2024 13:35:56 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrsgp60sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jan 2024 13:35:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40ODZtBn26608366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jan 2024 13:35:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE32558059;
 Wed, 24 Jan 2024 13:35:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5369D58057;
 Wed, 24 Jan 2024 13:35:55 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jan 2024 13:35:55 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org,
 npiggin@gmail.com
Subject: [PATCH] tests/qemu-iotests: Bump timeout of iothreads-stream test
Date: Wed, 24 Jan 2024 07:35:38 -0600
Message-Id: <20240124133538.2784097-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2WtICwH-Rk4Yf1PkOcwrCfhop_uYGIpR
X-Proofpoint-GUID: 7qCW9Jqul57TQ1DJHz1r_li3Tt2oBDYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=770 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240098
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Current value of timeout=0.1 is sometimes too tight.
Bump timeout to 0.3 to avoid test failures.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
 tests/qemu-iotests/tests/iothreads-stream | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/iothreads-stream b/tests/qemu-iotests/tests/iothreads-stream
index 503f221f16..32e46e044e 100755
--- a/tests/qemu-iotests/tests/iothreads-stream
+++ b/tests/qemu-iotests/tests/iothreads-stream
@@ -63,7 +63,7 @@ with iotests.FilePath('disk1.img') as base1_path, \
     finished = 0
     while True:
         try:
-            ev = vm.event_wait('JOB_STATUS_CHANGE', timeout=0.1)
+            ev = vm.event_wait('JOB_STATUS_CHANGE', timeout=0.3)
             if ev is not None and ev['data']['status'] == 'null':
                 finished += 1
                 # The test is done once both jobs are gone
-- 
2.31.1


