Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFEAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 06:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwcU2-0004FD-Mz; Tue, 16 Apr 2024 02:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rwcU1-0004Ev-84; Tue, 16 Apr 2024 02:39:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rwcTy-0006OY-U1; Tue, 16 Apr 2024 02:39:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G6TRiP026159; Tue, 16 Apr 2024 06:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fjqGa3FJp3fo+EiBTvfolxuczE/fzv15LF5lgFjmfG0=;
 b=iB4W8ZZiKg2IKsjl+T5J1LzpRDdS3IIC1ud1w3y29wWoHwj2DTWjn5KUFFSrYlprv8sk
 jHu5aSnNVLStuq+OUrU6Jzxa1qL8OLp2VkI9NTQlXy4gQNu/KUQHdE38JLn57xIRog2m
 md253+Ss95NwvHn6Y1/xe3rzJkRG7YrWxrng6DeO1gWAh5uqdstiJX6kW/tS1LgMOdHE
 MVvjOSi36c+Tyhjn+ZPpivkWMt1EYPoNhxUDMHNEqsr/9DJ8RJSWRdV1mJnvrpeEuDwC
 QpnWc++L2XvuaUHna6dzxXISAzcufQw10zEPUfUO6z4d4VewUPcyG+47+GqQrnzH5c9Q dA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhm3f80ke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:39:50 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43G6aw6d004730;
 Tue, 16 Apr 2024 06:39:50 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhm3f80kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:39:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G41omW011164; Tue, 16 Apr 2024 06:39:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg732c2ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:39:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43G6djW732178906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 06:39:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2BA02004E;
 Tue, 16 Apr 2024 06:39:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A87920063;
 Tue, 16 Apr 2024 06:39:44 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 06:39:44 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 0/8] target/ppc: Move fixed-point insns to decodetree.
Date: Tue, 16 Apr 2024 12:09:19 +0530
Message-Id: <20240416063927.99428-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rkepkHYgNaiar_L1a_x60_CfDXAjOg4s
X-Proofpoint-GUID: -PQv8_QELuwMwVlVXetIXfp9VFPy1cS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_03,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=400 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160038
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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

Moving all fixed-point instructions of the following type to decodetree
specification : arithmetic, compare, trap, select and logical.

Chinmay Rath (8):
  target/ppc: Move mul{li, lw, lwo, hw, hwu} instructions to decodetree.
  target/ppc: Make divw[u] handler method decodetree compatible.
  target/ppc: Move divw[u, e, eu] instructions to decodetree.
  target/ppc: Move neg, darn, mod{sw, uw} to decodetree.
  target/ppc: Move multiply fixed-point insns (64-bit operands) to
    decodetree.
  target/ppc: Move div/mod fixed-point insns (64 bits operands) to
    decodetree.
  target/ppc: Move cmp{rb, eqb}, tw[i], td[i], isel instructions to
    decodetree.
  target/ppc: Move logical fixed-point instructions to decodetree.

 target/ppc/helper.h                        |  26 +-
 target/ppc/insn32.decode                   |  93 +++
 target/ppc/excp_helper.c                   |   4 +-
 target/ppc/int_helper.c                    |  24 +-
 target/ppc/translate.c                     | 841 +--------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 639 ++++++++++++++++
 6 files changed, 770 insertions(+), 857 deletions(-)

-- 
2.39.3


