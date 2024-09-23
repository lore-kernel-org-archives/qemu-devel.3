Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7BECF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpc-0006X2-2m; Mon, 23 Sep 2024 12:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpW-0006TE-9S
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpQ-0000bO-Mi
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:29 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NCtDAh025675;
 Mon, 23 Sep 2024 16:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=pzYh8X61AcOIy
 slGUInFv/uLPzcvCXA28/NcWxm1j+U=; b=Lsaldixk0STnk+oeblgT17rFBSo+N
 FT9S/uAyc+gmiG5lnunPWGhe0keowVIVvozdqjcX2gycbbuFqwBgz4J7Z8EpS8ha
 ONvf1ZTAP3UwfXYawR5+r++2KESKF98+VwGZb17L2nCs7EzRmQ23exLk17aEEENx
 1+Zr7en7EwJK+7OIeEYqtlnFMhLtey5ntR6ZBx44nRsSsAOUUBXzYufq8h7AIiBp
 RUwmjm92jA4XxPsrR3Xjl7iHxcP/aTJKwD8iogOm3tQ5scdh4okCXFTxOEOy7Kmq
 0t/8h7Pr84td9JjZG/yQpuoB8x8bpPfCdPMzLmENgljxjbBOcR8Z/5znA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntw558m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGMLfE032081;
 Mon, 23 Sep 2024 16:22:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntw558g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDhh9Y008707;
 Mon, 23 Sep 2024 16:22:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t8v0ym0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMHRs49414526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FC0120043;
 Mon, 23 Sep 2024 16:22:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B58820040;
 Mon, 23 Sep 2024 16:22:17 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:17 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 02/18] gdbstub: Move phy_memory_mode to GDBSystemState
Date: Mon, 23 Sep 2024 18:12:57 +0200
Message-ID: <20240923162208.90745-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2T6xRTnjojjEAELqIszvBUvxMcVRvHJn
X-Proofpoint-GUID: pBESDwe66eSkFIzXN5gi8L_ej87KlQMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
be inside a single struct.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/system.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index 1ad87fe7fdf..5ce357c6c2b 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -35,6 +35,7 @@
 typedef struct {
     CharBackend chr;
     Chardev *mon_chr;
+    int phy_memory_mode;
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
+        gdbserver_system_state.phy_memory_mode = 0;
     } else {
-        phy_memory_mode = 1;
+        gdbserver_system_state.phy_memory_mode = 1;
     }
     gdb_put_packet("OK");
 }
-- 
2.46.0


