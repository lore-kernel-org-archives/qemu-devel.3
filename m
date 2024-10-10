Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1964FCF07DE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypUX-0001kV-Is; Thu, 10 Oct 2024 05:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUV-0001kD-O1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUU-00041j-6e
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:51 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A6XLxu029153;
 Thu, 10 Oct 2024 09:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=tNrIMaIFg/sBa
 lnXDItBwVSU7MCj5OSIYKMxf0+uv/w=; b=D8qQYCahbiInfkT/GVNBJAZ8CBdaH
 Wjp+ZOKupLJ4vHC9PUE/v/Je5HKnIBmB4RldMTOFLHPyZnH3JlIs3qkDHeKs8MUV
 bRmlX8d0uD9XYyrvccW9Vdp6DrujjwpLT4Dugg5bkk3UIfSNEeg/7bBYMTa5zmw3
 bABJW4nXnx7StTd32Xcwc0U9mbLYolpb18uNBAA+EqBvisNrnvmff/TCLGXgc6xI
 pY8ELqEJ+PL4BKy1LI4KzzAmCstQcKOxN3yBUaQ1Q4o9xw3aifaCoAYvCW4FyZGU
 xbHqEAuLBU9HqKwExgFJTyQhYXpf6JbNuLBs8FKvQhfrsbmw6nqgzEK4A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4269rn8us2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A9H0wZ030174;
 Thu, 10 Oct 2024 09:29:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsmxygn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A9Tkgg57475472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 09:29:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB5182004B;
 Thu, 10 Oct 2024 09:29:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A03CC20040;
 Thu, 10 Oct 2024 09:29:45 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.88.135])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 09:29:45 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/4] gdbstub: Move phy_memory_mode to GDBSystemState
Date: Thu, 10 Oct 2024 11:26:57 +0200
Message-ID: <20241010092938.226868-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010092938.226868-1-iii@linux.ibm.com>
References: <20241010092938.226868-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zJuXRJXGSY6_rZkVLwH1YpM1i5XhNR6z
X-Proofpoint-GUID: zJuXRJXGSY6_rZkVLwH1YpM1i5XhNR6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_05,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Follow the convention that all the pieces of the global stub state must
be inside a single struct. While at it, convert phy_memory_mode to
bool.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/system.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index c9f236e94f7..2e31e42f7dd 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -35,6 +35,7 @@
 typedef struct {
     CharBackend chr;
     Chardev *mon_chr;
+    bool phy_memory_mode;
 } GDBSystemState;
 
 GDBSystemState gdbserver_system_state;
@@ -445,14 +446,12 @@ void gdb_qemu_exit(int code)
 /*
  * Memory access
  */
-static int phy_memory_mode;
-
 int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
     CPUClass *cc;
 
-    if (phy_memory_mode) {
+    if (gdbserver_system_state.phy_memory_mode) {
         if (is_write) {
             cpu_physical_memory_write(addr, buf, len);
         } else {
@@ -491,7 +490,8 @@ bool gdb_can_reverse(void)
 void gdb_handle_query_qemu_phy_mem_mode(GArray *params,
                                         void *ctx)
 {
-    g_string_printf(gdbserver_state.str_buf, "%d", phy_memory_mode);
+    g_string_printf(gdbserver_state.str_buf, "%d",
+                    gdbserver_system_state.phy_memory_mode);
     gdb_put_strbuf();
 }
 
@@ -503,9 +503,9 @@ void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *ctx)
     }
 
     if (!gdb_get_cmd_param(params, 0)->val_ul) {
-        phy_memory_mode = 0;
+        gdbserver_system_state.phy_memory_mode = false;
     } else {
-        phy_memory_mode = 1;
+        gdbserver_system_state.phy_memory_mode = true;
     }
     gdb_put_packet("OK");
 }
-- 
2.46.2


