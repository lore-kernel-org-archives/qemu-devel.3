Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC3EC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgrr-00081B-67; Thu, 13 Jun 2024 05:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sHgrp-0007zg-Lf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:35:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sHgrn-0007CZ-Vf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:35:37 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D8v8g9001742;
 Thu, 13 Jun 2024 09:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-transfer-encoding
 :mime-version; s=pp1; bh=cUp7zQS8h4Pq/Jz3Kf0f8WAkAg6xZGoQxIGTvml
 Hafo=; b=S0Idix059cGk3A3SDcmLenotclUnFVpOjASAjjgZsBzyxgtcyOQhTsi
 9evrlFjCealIAH8FDH//NMwf8mOFdt1IcwTJgcTy3sfSWOCH7mDi1MC1vfxtOE1X
 9ca+we8+g3wTvH00hyYySs0/ZAaR41uwfW821mdoc5ZPQCYOrKofFh+2TOcsS5QR
 aosmv1Ky0wfWpyNtplm7YRp3uo2PWKUw5UmM7110Q2IAFVvqtBc4KCkJy28ziKxP
 tbqdzuR/jWzYLT4+e8CrVzxXgCiBhU8DQjSTTZS5tqXl9r0AQpitWyPvzZjQxRXI
 4INwr8OxtweaAFmF6QWStDsocZYYebw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqpq092db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 09:33:33 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45D9XWfp029344;
 Thu, 13 Jun 2024 09:33:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqpq092d9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 09:33:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45D9L0JO027267; Thu, 13 Jun 2024 09:33:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn21166g4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 09:33:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45D9XSro19071256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2024 09:33:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3F682004F;
 Thu, 13 Jun 2024 09:33:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4CA42005A;
 Thu, 13 Jun 2024 09:33:26 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2024 09:33:26 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 0/4] Move VSX storage access and compare insns to
Date: Thu, 13 Jun 2024 15:03:14 +0530
Message-Id: <20240613093318.314913-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YWQDfXy3qDERdCPDR0MwEgR_Jxwj7o1X
X-Proofpoint-GUID: lzdz4f_wkzW3KZUAtmTy4EEmfb4bgSLq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 mlxlogscore=605
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130066
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

Change log : 

v2:
 - Addressed comments by Richard in v1
   - Patch 2/4 : Handled proper ea calculation in narrow mode.
     Also created a new function for ea calculation instead of inlining,
     for later use by (p){lx,stx}vp insns.
   - Patch 4/4 : Unified helper calls.
 - Retained Richard's "Reviewed-by" in patches 1, 3 and 4.

v1: https://lore.kernel.org/qemu-devel/20240607144921.726730-1-rathc@linux.ibm.com/ 

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
 target/ppc/translate.c              |  18 ++
 target/ppc/translate/vsx-impl.c.inc | 416 ++++++++++++++--------------
 target/ppc/translate/vsx-ops.c.inc  |  49 ----
 7 files changed, 290 insertions(+), 282 deletions(-)

-- 
2.39.3


