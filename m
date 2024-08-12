Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB552C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 08:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdQtF-00018s-Ap; Mon, 12 Aug 2024 04:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sdQtD-00011N-Gu; Mon, 12 Aug 2024 04:58:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sdQtB-0007lD-Hn; Mon, 12 Aug 2024 04:58:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C69TYo015789;
 Mon, 12 Aug 2024 08:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=pp1; bh=Picl/PkVUDEek
 GvLbgNwBzttafJqo51Yr3MwYqFUnP8=; b=aKoyeMBwWJMqoMhaFZDQznzLmCuJV
 pBMEsf6ABv0iv26xlVqWSsf03BFUI8AC+nagSbcMzMT+EJbLRmx+2XDqbLHq0XOe
 5DQEaQL2zlgtUejP6l9FZek872ht2K3sdY7+OnW6f6av/Yj2Mqk4D9/RqEK25Gnc
 lEGKh2L+zrdlQOeMw1R+SflhguxAQxIMgcqE/HuXMJfqpRlGAy5wHkh3a6Xvx2L6
 OD25DTMWbTfkmC6DhDZFb/bK5WVv6ZA1aw3rP9l0Dqp+V6dIWv3ZaJtpsWvNbNQ1
 ATXpS6MgquyV6BpN8PpNXNyToS52FAPVb0wTokMnNuA+mXZhhZK684g4g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyq8mdcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Aug 2024 08:58:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47C8nV3H005782;
 Mon, 12 Aug 2024 08:58:48 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyq8mdcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Aug 2024 08:58:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 47C8nUAl020882; Mon, 12 Aug 2024 08:58:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn82w8ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Aug 2024 08:58:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47C8wh7j33882642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2024 08:58:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D72F02004F;
 Mon, 12 Aug 2024 08:58:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EC4120040;
 Mon, 12 Aug 2024 08:58:43 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.70.115])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Aug 2024 08:58:43 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/2] target/ppc: Make divd[u] handler method decodetree
 compatible
Date: Mon, 12 Aug 2024 10:53:07 +0200
Message-ID: <20240812085841.1583-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X-txIWujmCMhQpFdy4S04o7IfEYYf1fn
X-Proofpoint-ORIG-GUID: DQgMGKIOmcb__OplbDy9RWLL1PW2Vv7O
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_25,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=666 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120064
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v1: https://lore.kernel.org/qemu-devel/20240731100953.14950-1-iii@linux.ibm.com/
v1 -> v2: Add R-bs and a targeted divd[u] patch.

Hi,

This series contains two fixes for the same issue: divd[u] touching
uninitialized ctx->opcode.

Patch 1 is a catch-all solution for all issues in this class. IMHO
it's worth having something like this until the legacy decoder is
fully eliminated.

Patch 2 is a targeted fix for divd[u] only.

Best regards,
Ilya

Ilya Leoshkevich (2):
  target/ppc: Set ctx->opcode for decode_insn32()
  target/ppc: Make divd[u] handler method decodetree compatible

 target/ppc/translate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.45.2


