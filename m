Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7F5C4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 20:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZdGE-0005jX-EF; Mon, 12 Feb 2024 15:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rZdGB-0005jK-K8
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:50:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rZdG9-0003QG-Vv
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:50:39 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CKbVS9019474; Mon, 12 Feb 2024 20:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UiPeJOx0ETDNIXAKYypll/nld8BVuCht7yp3n8HTsl4=;
 b=QRK4tYgw5vLra5xPEfmX1rWuEGf5OztIS+jvWdjOg56uzk6EkBn9mm+YzIBdfUvw/pVT
 ZoEitzJXaO4yGZDW4qnU3rXDJQTbnUSBUQll8lFylylHev/smPl3IKjifus2oPz7q8Sh
 ApPu0YSDcg+JxkequI7O6xpkG+jY7gTpLmvyjN83VuTpQQ9FOavv/3fP6xxG/z6M3O2O
 Mn3h410TEYGZWi2aJEHn/TDLXrJ318QuTIDI81vZsBldPcTJ6ddcp0QIoYXD1/a/N2gx
 PKoBs3/W/pfnfQ1iICeZRBlUrT5846mfTInd2LqEg+MxffNK+N1Hzz1dYTzzEaZRjneb 7Q== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7the89dn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:50:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CJfIMH016203; Mon, 12 Feb 2024 20:50:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymb030-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:50:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41CKoT6v46793146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 20:50:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 644312004E;
 Mon, 12 Feb 2024 20:50:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 032F02004B;
 Mon, 12 Feb 2024 20:50:29 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.4.126])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Feb 2024 20:50:28 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/2] linux-user: Map low priority rt signals
Date: Mon, 12 Feb 2024 21:45:42 +0100
Message-ID: <20240212205022.242968-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212205022.242968-1-iii@linux.ibm.com>
References: <20240212205022.242968-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3vipn1ZmSg8w-Lf-8TyqpMK9TiaLISW-
X-Proofpoint-GUID: 3vipn1ZmSg8w-Lf-8TyqpMK9TiaLISW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120161
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

Some applications want to use low priority realtime signals (e.g.,
SIGRTMAX). Currently QEMU cannot map all target realtime signals to
host signals, and chooses to sacrifice the end of the target realtime
signal range.

Change this to the middle of that range, hoping that fewer applications
will need it.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/signal.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index d3e62ab030f..a81533b563a 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -511,13 +511,14 @@ static int core_dump_signal(int sig)
 
 static void signal_table_init(void)
 {
-    int hsig, tsig, count;
+    int hsig, hsig_count, tsig, tsig_count, tsig_hole, tsig_hole_size, count;
 
     /*
-     * Signals are supported starting from TARGET_SIGRTMIN and going up
-     * until we run out of host realtime signals.  Glibc uses the lower 2
-     * RT signals and (hopefully) nobody uses the upper ones.
-     * This is why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
+     * Signals are supported starting from TARGET_SIGRTMIN and up to
+     * TARGET_SIGRTMAX, potentially with a hole in the middle of this
+     * range, which, hopefully, nobody uses. Glibc uses the lower 2 RT
+     * signals; this is why SIGRTMIN (34) is generally greater than
+     * __SIGRTMIN (32).
      * To fix this properly we would need to do manual signal delivery
      * multiplexed over a single host signal.
      * Attempts for configure "missing" signals via sigaction will be
@@ -536,9 +537,16 @@ static void signal_table_init(void)
     host_to_target_signal_table[SIGABRT] = 0;
     host_to_target_signal_table[hsig++] = TARGET_SIGABRT;
 
+    hsig_count = SIGRTMAX - hsig + 1;
+    tsig_count = TARGET_NSIG - TARGET_SIGRTMIN + 1;
+    tsig_hole_size = tsig_count - MIN(hsig_count, tsig_count);
+    tsig_hole = TARGET_SIGRTMIN + (tsig_count - tsig_hole_size) / 2;
     for (tsig = TARGET_SIGRTMIN;
          hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
          hsig++, tsig++) {
+        if (tsig == tsig_hole) {
+            tsig += tsig_hole_size;
+        }
         host_to_target_signal_table[hsig] = tsig;
     }
 
-- 
2.43.0


