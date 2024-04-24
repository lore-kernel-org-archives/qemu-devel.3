Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA2CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzkwt-0007aS-Dx; Wed, 24 Apr 2024 18:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzkwj-0007Sf-G7; Wed, 24 Apr 2024 18:18:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzkwh-0002ZS-LB; Wed, 24 Apr 2024 18:18:33 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OLuRZa015679; Wed, 24 Apr 2024 22:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3l7a+LtlfYLSSeP8pV1bFtJy9PTMyZYRKayWoEi4qOA=;
 b=B6Fpb5Stf1APYT6VR2jc3I/3jDI55ZaV744/tGWgl9r0PBj5Rr2JIp+EG0a77ofv7fQA
 1vPQ5OjylHrqb+F/x24sCbz4cTOiLIMSmlaNcowswY0GX/1mK9N3h5H26RnGo5Xy7hVQ
 0faR7I1Q+qm88I6EWLVXRBMWYSJSE5dyyQaGixTi9Bx1Yq96RM0Qzxumc4fTQvF9nxx3
 kH+i/v+8pFXEZ372ytt1LQQipRw2lMVqSB11mFE+LR9ICuur1l0V9HwL2uMt2cDtYuDh
 GM1NWp1oxgEH/84PwYcn9eqnZ3Tru547kxMAhldozd5WV8yHr6SANGnqTBK/SbWOF1tn Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqae10176-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 22:18:25 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OMIOH4014087;
 Wed, 24 Apr 2024 22:18:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqae10173-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 22:18:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OIkk0t015299; Wed, 24 Apr 2024 21:57:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshme2vj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 21:57:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43OLvAgF41746760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 21:57:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33C6458056;
 Wed, 24 Apr 2024 21:57:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ADA058064;
 Wed, 24 Apr 2024 21:57:09 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Apr 2024 21:57:09 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v3 2/2] target/s390x: flag te and cte as deprecated
Date: Wed, 24 Apr 2024 17:56:33 -0400
Message-ID: <20240424215633.48906-3-walling@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424215633.48906-1-walling@linux.ibm.com>
References: <20240424215633.48906-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1uUrZ6p6nSysA2-63l-HxXKY20dsxfc5
X-Proofpoint-ORIG-GUID: 5iA9nptpUpFhUin1megX4bkpFZdOX0Fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1015 mlxlogscore=986 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add the CONSTRAINT_TRANSACTIONAL_EXE (cte) and TRANSACTIONAL_EXE (te)
to the list of deprecated features.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 target/s390x/cpu_features.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index efafc9711c..cb4e2b8920 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -218,6 +218,9 @@ void s390_get_deprecated_features(S390FeatBitmap features)
          /* CSSKE is deprecated on newer generations */
          S390_FEAT_CONDITIONAL_SSKE,
          S390_FEAT_BPB,
+         /* Deprecated on z16 */
+         S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
+         S390_FEAT_TRANSACTIONAL_EXE
     };
     int i;
 
-- 
2.43.0


