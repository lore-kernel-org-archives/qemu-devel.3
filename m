Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D79EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFlI-0004I3-JK; Fri, 10 Jan 2025 09:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tWFlH-0004Hp-IW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:13:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tWFlG-0004Gf-07
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:13:19 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3rYfB015727;
 Fri, 10 Jan 2025 14:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LKeLb0
 K6yzjo1BqPmQKktPLgWotiXJx2uOaOMenZGNo=; b=X7TJi9ZmCOJD8WEZ6KrreJ
 eIc/xPC/7PemwuuBJORTn78I5UxFzr0vHa9xF8zHPclQkmCejRuObrDUlE8og8k6
 ZZjfbzac8HhioLhZ/eO0KquqwEdLCS3EVdGv7NxGrHuRSqt16e/6tiXEV2/WiKlo
 NR36eWZiz7lebP/ZNmOsgOno04h8Le1dt9a3xx8rStS1aDKQkgXhe6W1GJ8AIbHq
 UWrn1s1AbS3BAtO31wqS/oTrFLEGgrA2uVYV+hiRICP5Y7XoncXGSALo2Pon+7Zl
 p1vEFiqVe/D7W509BUFdVklQmLcjqT0ZDO7sJvFIfY4qWTWz3X0HzrX+I//qgJ1w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442v1btcc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 14:13:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50AAkFUh027976;
 Fri, 10 Jan 2025 14:13:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhkjaqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 14:13:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50AED2bA54853898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 14:13:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BADE92004D;
 Fri, 10 Jan 2025 14:13:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09AB720040;
 Fri, 10 Jan 2025 14:13:02 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jan 2025 14:13:01 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 7/8] docs/user: Document the %d placeholder and suspend=n
 QEMU_GDB features
Date: Fri, 10 Jan 2025 15:09:39 +0100
Message-ID: <20250110141255.2328-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110141255.2328-1-iii@linux.ibm.com>
References: <20250110141255.2328-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gi5gaVzoOQa7pb4SwGd_N1q0WD_FU4ix
X-Proofpoint-GUID: gi5gaVzoOQa7pb4SwGd_N1q0WD_FU4ix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 docs/user/main.rst | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/docs/user/main.rst b/docs/user/main.rst
index 7a126ee8093..8dcb1d90a8b 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -50,7 +50,7 @@ Command line options
 
 ::
 
-   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g port] [-B offset] [-R size] program [arguments...]
+   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g endpoint] [-B offset] [-R size] program [arguments...]
 
 ``-h``
    Print the help
@@ -87,8 +87,18 @@ Debug options:
    Activate logging of the specified items (use '-d help' for a list of
    log items)
 
-``-g port``
-   Wait gdb connection to port
+``-g endpoint``
+   Wait gdb connection to a port (e.g., ``1234``) or a unix socket (e.g.,
+   ``/tmp/qemu.sock``).
+
+   If a unix socket path contains single ``%d`` placeholder (e.g.,
+   ``/tmp/qemu-%d.sock``), it is replaced by the emulator PID, which is useful
+   when passing this option via the ``QEMU_GDB`` environment variable to a
+   multi-process application.
+
+   If the endpoint address is followed by ``,suspend=n`` (e.g.,
+   ``1234,suspend=n``), then the emulated program starts without waiting for a
+   connection, which can be established at any later point in time.
 
 ``-one-insn-per-tb``
    Run the emulation with one guest instruction per translation block.
-- 
2.47.1


