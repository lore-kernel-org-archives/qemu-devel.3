Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF40C41513
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:46:45 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFauY-0008VI-Vv; Fri, 07 Jun 2024 10:49:47 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sFauW-0008Uo-JZ; Fri, 07 Jun 2024 10:49:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sFauV-0005MZ-0f; Fri, 07 Jun 2024 10:49:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 457EctKN028752; Fri, 7 Jun 2024 14:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pp1; bh=16o8TGxfyVwh0px86GGdIRBHBJFH62S1cXdWK6jDjgk=;
 b=Hfe5g41K4u4SBrr1wy4zmoZsZIHLs9C45ln7vHWRP3kPULhQ7oXDlWasfF+FzDQX0in/
 oqT5aXsdiM6sg4CoQz8OvQ6JA6jcvqm/3XI04VT3kg0ek8nOVSKxXDBUOCKfKtArM0EU
 +/sqkkh22co+x2H9ikTqAVPIjFl3p7e18ORLVFdKypYi6/frRTE8vmpwnPuAC8/jMkyt
 cn+bVjX4fyQsp5qpZTDyfg1yadNNc7S2hMbThTGxNMBUDF8XbsFz1vV/M7BUlfAFPlDF
 6ikePkkDqimPApkJQLNHQfEKSMz+VH4vMzzIyivjXbENR2ldJ0dhNhTqdkQOlTOUNcTL CA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym456817n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jun 2024 14:49:39 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 457End7B014722;
 Fri, 7 Jun 2024 14:49:39 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym456817c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jun 2024 14:49:39 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 457Dd13s022779; Fri, 7 Jun 2024 14:49:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygg6mry8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jun 2024 14:49:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 457EnYLM28705402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Jun 2024 14:49:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC58320040;
 Fri,  7 Jun 2024 14:49:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BBA620049;
 Fri,  7 Jun 2024 14:49:32 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.62.199])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Jun 2024 14:49:32 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 0/4] target/ppc: Move VSX storage access and compare
Date: Fri,  7 Jun 2024 20:19:17 +0530
Message-Id: <20240607144921.726730-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1UDR4ryFCgl1j7VYlJDPcrcS-1vxwsgJ
X-Proofpoint-GUID: 3HM4bXlDYln5xvRvri4ctSOnVHrNRfGf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=405 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Moving all remaining VSX storage access instructions and all VSX compare
instructions of XX3 form with RC field, to decodetree specification.

Chinmay Rath (4):
  target/ppc: Moving VSX scalar storage access insns to decodetree.
  target/ppc: Move VSX vector with length storage access insns to
    decodetree.
  target/ppc: Move VSX vector storage access insns to decodetree.
  target/ppc: Move VSX fp compare insns to decodetree.

 target/ppc/helper.h                 |  24 +-
 target/ppc/insn32.decode            |  41 +++
 target/ppc/fpu_helper.c             |  16 +-
 target/ppc/mem_helper.c             |   8 +-
 target/ppc/translate/vsx-impl.c.inc | 430 ++++++++++++++--------------
 target/ppc/translate/vsx-ops.c.inc  |  49 ----
 6 files changed, 286 insertions(+), 282 deletions(-)

-- 
2.39.3


