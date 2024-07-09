Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E397FC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9GR-0001TM-4W; Tue, 09 Jul 2024 07:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sR9GM-0001DC-Q0; Tue, 09 Jul 2024 07:44:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sR9GJ-0004nE-Ge; Tue, 09 Jul 2024 07:44:02 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4699U7Ug008768;
 Tue, 9 Jul 2024 11:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-transfer-encoding
 :mime-version; s=pp1; bh=oL7zb131sPzUfUDE25zycfJ9ZwnkfX2NNjnp6Jr
 7+nA=; b=iRCcIcU4jW8+s+aHAh/tsQyYOedeetB5slT+qrRw5rzQPFOnz1AimBk
 syQyj5Jn9RB4uWkDDSZwawQMRnW5j5+804lvBLRso9jDBKpZOyZhzzJ4suX/WNIq
 HvXy9pkaNbQt6umfmFMpr+LLpWdnlM21uDYPMKbWf+unidAjVEBPboe5vhy5xEI9
 4C/PUfEwzGTYQ6CfjSdj8KjSI9hgpYXUOi+dVH5UdC1+M4YCqD2OPnXayeL9sU6G
 pgBOqg32T2HPn/dNlYSNB+fI8h7ju0XAyd67PZXlp3rDLwWrW8iZib7VNTS9Z7g1
 F9Px676Y+wTCBhRXbSyyHvyNR2JIjaA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4092ks8b5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2024 11:43:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469Bho1N016027;
 Tue, 9 Jul 2024 11:43:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4092ks8b5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2024 11:43:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4698b1fo025952; Tue, 9 Jul 2024 11:43:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmm5xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2024 11:43:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 469Bhkvh49676760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jul 2024 11:43:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E60672004B;
 Tue,  9 Jul 2024 11:43:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E19F20040;
 Tue,  9 Jul 2024 11:43:44 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jul 2024 11:43:44 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v3 0/3] target/ppc: Update vector insns to use 128 bit
Date: Tue,  9 Jul 2024 17:13:38 +0530
Message-Id: <20240709114341.152175-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DrAaioYPL5-JsXDwJZncYAehf2Qt8zLa
X-Proofpoint-ORIG-GUID: 3QjbmfMy-Yd25Yx2zjFFT4zIC85kfnVJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=830 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

Updating a bunch of VMX and VSX storage access instructions to use
tcg_gen_qemu_ld/st_i128 instead of using tcg_gen_qemu_ld/st_i64 in
succession; as suggested by Richard, in my decodetree patches.
Plus some minor clean-ups to facilitate the above in case of VMX insns.

Change log:

v3 : Rectified EA increment from 8 to 16 for paired insns in patch 3/3,
as pointed by Richard.
Retained his 'Reviewed-by' for all patches, after the correction.

v2 : Applied IFALIGN_PAIR memop changes in patches 2/3 and 3/3,
based on review comments by Richard.
https://lore.kernel.org/qemu-devel/20240630120157.259233-1-rathc@linux.ibm.com/

v3 : https://lore.kernel.org/qemu-devel/20240621114604.868415-1-rathc@linux.ibm.com/

Chinmay Rath (3):
  target/ppc: Move get/set_avr64 functions to vmx-impl.c.inc.
  target/ppc: Update VMX storage access insns to use
    tcg_gen_qemu_ld/st_i128.
  target/ppc : Update VSX storage access insns to use tcg_gen_qemu
    _ld/st_i128.

 target/ppc/translate.c              | 10 ----
 target/ppc/translate/vmx-impl.c.inc | 52 +++++++++++---------
 target/ppc/translate/vsx-impl.c.inc | 74 +++++++++++++----------------
 3 files changed, 63 insertions(+), 73 deletions(-)

-- 
2.39.3


