Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF5DE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKmr-0000xg-VJ; Mon, 13 Jan 2025 08:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXKmp-0000wS-Df
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:47:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXKmm-0006Um-Ff
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:47:23 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D85lA1000697;
 Mon, 13 Jan 2025 13:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=PnbXZSJVDES7xEtrk
 4v9vi0z8GoxCrh+mXsg6uDc/gs=; b=a2icxRWjjd1VRhG1FpZLmkAuNYbsgAMMC
 /ezVd1yKn2EH91iIWzpIb3DgPpkX40zWaJWJXfXdvSIvzrK/8CPTy5HfonwVMCKq
 gJfUuEzUD5mMCQFxJL+vCuU8gH7YI4QyfSMpBgGM4oOJrCNOSsI9LPF6xyLNyKZ+
 OQpqePgzsBghIYsan89Bip8wCiSYMxDHR1J3F3nrCgGV82lT1qlbz9vxIh3MMQJC
 RwNK2EgZrOGxb77Q50PWanmNFkOyYIq1OXVsD96ZQrwrvE/uCBg20CxfkMXkgyYO
 TYWm6/3UM8edh2mMPwQ3zkOdTX1vqZ03vF2ehyUE5yYeU/gdGOTyg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444y12hchm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jan 2025 13:47:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCSIg4007371;
 Mon, 13 Jan 2025 13:47:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ymxd0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jan 2025 13:47:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50DDlEWb56820064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jan 2025 13:47:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 458902004D;
 Mon, 13 Jan 2025 13:47:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA10820040;
 Mon, 13 Jan 2025 13:47:13 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.22])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Jan 2025 13:47:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/3] cpu: Introduce EXCLUSIVE_GUARD()
Date: Mon, 13 Jan 2025 14:36:28 +0100
Message-ID: <20250113134658.68376-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113134658.68376-1-iii@linux.ibm.com>
References: <20250113134658.68376-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: saEeJyIzuOaagVJDjQOM0sqf_pi2xa7a
X-Proofpoint-GUID: saEeJyIzuOaagVJDjQOM0sqf_pi2xa7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.787, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Add a macro that produces a start_exclusive() / end_exclusive() pair.
Useful to guarantee an exit from an exclusive section in large
functions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/hw/core/cpu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb3..a7d9d6e2b8c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1063,6 +1063,17 @@ void start_exclusive(void);
  */
 void end_exclusive(void);
 
+static inline void exclusive_unlock_guard(int *exclusive_guard G_GNUC_UNUSED)
+{
+    end_exclusive();
+}
+
+#define EXCLUSIVE_GUARD()                                      \
+    int glue(exclusive_guard, __COUNTER__)                     \
+            G_GNUC_UNUSED                                      \
+            __attribute__((cleanup(exclusive_unlock_guard))) = \
+        (start_exclusive(), 0);
+
 /**
  * qemu_init_vcpu:
  * @cpu: The vCPU to initialize.
-- 
2.47.1


