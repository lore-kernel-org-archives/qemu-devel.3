Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBEC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 21:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWjVS-0006Dz-Nr; Wed, 24 Jul 2024 17:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjVR-00066g-9N; Wed, 24 Jul 2024 17:26:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjVP-0003V3-HG; Wed, 24 Jul 2024 17:26:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OLQTes022942;
 Wed, 24 Jul 2024 21:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=gwmqu48ZrUj+4
 ZRj/sZYZRXQLBOjqP0JxLJeKoz4NKI=; b=P4ihvY7zTa7L2kr3k7xmZ5AWoVgPg
 zV0Y+chjCwmuozt2TQKH25BhFVVM1HKBkcpPoaxve6Cx7e9bgxrE9JdxoMdE+CGg
 Nz5UMKLaX6tncgHbPapJD0k38HFHnwqN+jROHBdapd4OG8rYRoaPzfLSZOR2vz+y
 I/fXiL48nAqCUb3l+k/1bH0xJrgyfe/MPkp5gqx/IXeIyyQlBNwoF++bdOsuyqyh
 DetK8J9XMpiIwAbK4XL7mztjVQETylH1IRThN6cVTHae00vzJrBDvtX0fuFpUk6V
 YGXSdeYRxiRG0H1yQHaUAaMS+sdNnGUDEa1APvo39bNfzEwdcZhWVm0/g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k94e01ge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:26:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46OLQTNG022945;
 Wed, 24 Jul 2024 21:26:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k94e01de-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:26:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46OJOUZd007926; Wed, 24 Jul 2024 21:22:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxna23dm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:22:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46OLLsMh58917328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 21:21:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 708DC2004F;
 Wed, 24 Jul 2024 21:21:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B6C62004E;
 Wed, 24 Jul 2024 21:21:53 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2024 21:21:53 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 11/11] pnv/xive2: Dump more END state with 'info pic'
Date: Wed, 24 Jul 2024 16:21:30 -0500
Message-Id: <20240724212130.26811-12-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240724212130.26811-1-kowal@linux.ibm.com>
References: <20240724212130.26811-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NJ_SwZdSKqZ_cRHBrfkZ5lgHf8XKqhCy
X-Proofpoint-GUID: r-VLiIHTbXDlsn2AVEynivePEFP8CD-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_24,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=577 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Additional END state 'info pic' information as added.  The 'ignore',
'crowd' and 'precluded escalation control' bits of an Event Notification
Descriptor are all used when delivering an interrupt targeting a VP-group
or crowd.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 include/hw/ppc/xive2_regs.h | 7 +++++++
 hw/intc/xive2.c             | 7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index ec5d6ec2d6..4349d009d0 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -97,6 +97,7 @@ typedef struct Xive2End {
         uint32_t       w6;
 #define END2_W6_FORMAT_BIT         PPC_BIT32(0)
 #define END2_W6_IGNORE             PPC_BIT32(1)
+#define END2_W6_CROWD              PPC_BIT32(2)
 #define END2_W6_VP_BLOCK           PPC_BITMASK32(4, 7)
 #define END2_W6_VP_OFFSET          PPC_BITMASK32(8, 31)
 #define END2_W6_VP_OFFSET_GEN1     PPC_BITMASK32(13, 31)
@@ -111,6 +112,8 @@ typedef struct Xive2End {
 #define xive2_end_is_notify(end)                \
     (be32_to_cpu((end)->w0) & END2_W0_UCOND_NOTIFY)
 #define xive2_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END2_W0_BACKLOG)
+#define xive2_end_is_precluded_escalation(end)          \
+    (be32_to_cpu((end)->w0) & END2_W0_PRECL_ESC_CTL)
 #define xive2_end_is_escalate(end)                      \
     (be32_to_cpu((end)->w0) & END2_W0_ESCALATE_CTL)
 #define xive2_end_is_uncond_escalation(end)              \
@@ -123,6 +126,10 @@ typedef struct Xive2End {
     (be32_to_cpu((end)->w0) & END2_W0_FIRMWARE1)
 #define xive2_end_is_firmware2(end)              \
     (be32_to_cpu((end)->w0) & END2_W0_FIRMWARE2)
+#define xive2_end_is_ignore(end)                \
+    (be32_to_cpu((end)->w6) & END2_W6_IGNORE)
+#define xive2_end_is_crowd(end)                 \
+    (be32_to_cpu((end)->w6) & END2_W6_CROWD)
 
 static inline uint64_t xive2_end_qaddr(Xive2End *end)
 {
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index ac914b3d1c..1f150685bf 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -89,7 +89,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
     pq = xive_get_field32(END2_W1_ESn, end->w1);
 
     g_string_append_printf(buf,
-                           "  %08x %c%c %c%c%c%c%c%c%c%c%c%c "
+                           "  %08x %c%c %c%c%c%c%c%c%c%c%c%c%c %c%c "
                            "prio:%d nvp:%02x/%04x",
                            end_idx,
                            pq & XIVE_ESB_VAL_P ? 'P' : '-',
@@ -98,12 +98,15 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
                            xive2_end_is_enqueue(end)  ? 'q' : '-',
                            xive2_end_is_notify(end)   ? 'n' : '-',
                            xive2_end_is_backlog(end)  ? 'b' : '-',
+                           xive2_end_is_precluded_escalation(end) ? 'p' : '-',
                            xive2_end_is_escalate(end) ? 'e' : '-',
                            xive2_end_is_escalate_end(end) ? 'N' : '-',
                            xive2_end_is_uncond_escalation(end)   ? 'u' : '-',
                            xive2_end_is_silent_escalation(end)   ? 's' : '-',
                            xive2_end_is_firmware1(end)   ? 'f' : '-',
                            xive2_end_is_firmware2(end)   ? 'F' : '-',
+                           xive2_end_is_ignore(end) ? 'i' : '-',
+                           xive2_end_is_crowd(end)  ? 'c' : '-',
                            priority, nvp_blk, nvp_idx);
 
     if (qaddr_base) {
@@ -676,7 +679,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     }
 
     found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
-                          xive_get_field32(END2_W6_IGNORE, end.w7),
+                          xive2_end_is_ignore(&end),
                           priority,
                           xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7));
 
-- 
2.43.0


