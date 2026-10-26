Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71E606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mX+S8KyR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLJY-00019V-KR; Mon, 26 Oct 2026 10:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH4-00070c-Q1; Mon, 26 Oct 2026 10:02:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH1-00018n-U7; Mon, 26 Oct 2026 10:02:06 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QBEFqm3336092; Mon, 26 Oct 2026 14:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9918ohsG6bcNAQM+t
 DHebKjUHqF6jdoTRXUmU//TDO0=; b=mX+S8KyRhQG6oINMF+9TgQuREVR6ur4g0
 o61RLJGkoy9IafvrIHyRHuCELeqD2nnmVFtkd7CYC4WnMzV20eve61bB7MDIJfUv
 i0zqlvKtpJM1f7zW71OEIEiYSO9GWSIJGAWVoktxlCCMpVMxCttUHGavQxuyChCn
 Dr8uLA8FiclHmLw12gjeP/BcmPwW2Fl3t6HJjrN2+Jfr6AJp4VowMdNwXRf5cAQd
 OHwPngWuNDDu2ngHKtf2TMhl9j12BeDhAEWtj7i1cpT+USkMlCnrG/esovv+/odv
 hNJBI3rgKz40TCAP1Sh8WGtBmLWbT/FkX1fMlycm4gE3A1Qihjvhw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6tanb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:02:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QB5LKd2503111; Mon, 26 Oct 2026 14:02:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh9py5xuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:02:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QE1x1164291134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 14:01:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9A9A58053;
 Mon, 26 Oct 2026 14:01:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DADC58043;
 Mon, 26 Oct 2026 14:01:58 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.109.57]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 14:01:58 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 3/6] s390x/sclpconsole: implement resizing for vt220 consoles
Date: Mon, 26 Oct 2026 10:01:50 -0400
Message-ID: <20261026140153.2072253-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026140153.2072253-1-farman@linux.ibm.com>
References: <20261026140153.2072253-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX5dDfdmV0HFYQ
 9BWTQRg/bpxPEUbDulJyd5qGbSR2ci0rMfVcxHIAI/9h3CJxPt8LSIqX9+Owlnwhkb1Vp3mnN2/
 cbcgp0LNb3E/SZwcTkqfmMF6uXY0fVc=
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adf5d59 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=q2DVYbRnPiRVfZbQHhQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX+q85sATBmX6Z
 PWkwIxnrOLJwywRQs+Hp+QsOlSKHbclG4Kul0IaXPdvfcIhN5VdFxAcuIPDEw/7nECYgiTpvLee
 PQ57XwXVnNNbmvz0irEuP10hAXBBHIu9NWOj820fbg6PQmeyIiU5Um1D86FmORb5brVz3gobGXv
 yBiCZ8Sz5PdSMBBCMLhSVUi6BwtRfvt+OrY/sh7JbrujCPp5fLXVIX/oZkVpNaRNXmW6uiqpGK3
 +GimfRHjt+VoaN2tBLnZv0iT4owBPmPRuaMb0FYgkuZFjxm3dVCxXBms884QExXFU03gxXN3utz
 BQgQojm4xk811Td+5fNI3kw8HhRdYjeJQeX2gUh3SyhaiaawvwdWgP4Gc0s01GFKO2xMV/Lvag/
 UQK2xg6sm8suByweX9eAQ8OK7HgxmQ==
X-Proofpoint-ORIG-GUID: LJpMTiHOX4wklllrQOwKakK8HIq61Xbj
X-Proofpoint-GUID: LJpMTiHOX4wklllrQOwKakK8HIq61Xbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

Add a tty code to indicate a resize frame. The body contains two big
endian 16-bit integers rows and columns.

After reset, the guest must be informed of the terminal size again. A
chardev that doesn't report its size yields 0x0, which shouldn't replace
the guest's default.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260929152012.2696005-3-maxbr@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/char/sclpconsole.c | 76 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 1ad39084d3..12033e1e46 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -33,6 +33,9 @@ typedef struct ASCIIConsoleData {
 /* max size for ASCII data in 4K SCCB page */
 #define SIZE_BUFFER_VT220 4080
 
+#define SCLP_CONSOLE_EVENT_TYPE_DATA 0x00
+#define SCLP_CONSOLE_EVENT_TYPE_RESIZE 0x08
+
 struct SCLPConsole {
     SCLPEvent event;
     CharFrontend chr;
@@ -42,6 +45,8 @@ struct SCLPConsole {
     uint32_t iov_data_len;  /* length of byte stream in buffer             */
     uint32_t iov_sclp_rest; /* length of byte stream not read via SCLP     */
     bool notify;            /* qemu_notify_event() req'd if true           */
+    bool resize;
+    bool resize_init;
 };
 typedef struct SCLPConsole SCLPConsole;
 
@@ -49,6 +54,12 @@ typedef struct SCLPConsole SCLPConsole;
 DECLARE_INSTANCE_CHECKER(SCLPConsole, SCLP_CONSOLE,
                          TYPE_SCLP_CONSOLE)
 
+typedef struct SCLPConsoleResizeData {
+    uint8_t type;
+    uint16_t rows;
+    uint16_t cols;
+} QEMU_PACKED SCLPConsoleResizeData;
+
 /* character layer call-back functions */
 
 /* Return number of bytes that fit into iov buffer */
@@ -81,6 +92,29 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     sclp_service_interrupt(0);
 }
 
+static void chr_event(void *opaque, QEMUChrEvent event)
+{
+    SCLPConsole *scon = opaque;
+
+    assert(scon);
+
+    switch (event) {
+    case CHR_EVENT_RESIZE:
+    case CHR_EVENT_MUX_IN:
+        scon->resize = true;
+        scon->resize_init = false;
+        scon->event.event_pending = true;
+        sclp_service_interrupt(0);
+        break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_OPENED:
+    case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_CLOSED:
+        /* ignore */
+        break;
+    }
+}
+
 /* functions to be called by event facility */
 
 static bool can_handle_event(uint8_t type)
@@ -104,10 +138,37 @@ static sccb_mask_t receive_mask(void)
 static void get_console_data(SCLPEvent *event, uint8_t *buf, size_t *size,
                              int avail)
 {
+    SCLPConsoleResizeData resize_data;
     SCLPConsole *cons = SCLP_CONSOLE(event);
+    uint16_t rows, cols;
 
-    /* first byte is hex 0 saying an ascii string follows */
-    *buf++ = '\0';
+    if (cons->resize) {
+        if (avail < sizeof(resize_data)) {
+            *size = 0;
+            return;
+        }
+
+        qemu_chr_fe_get_winsize(&cons->chr, &cols, &rows);
+
+        if (cons->resize_init && cols == 0 && rows == 0) {
+            *size = 0;
+        } else {
+            resize_data.type = SCLP_CONSOLE_EVENT_TYPE_RESIZE;
+            resize_data.rows = cpu_to_be16(rows);
+            resize_data.cols = cpu_to_be16(cols);
+
+            memcpy(buf, &resize_data, sizeof(resize_data));
+            *size = sizeof(resize_data);
+        }
+
+        cons->resize = false;
+        cons->resize_init = false;
+        event->event_pending = cons->iov_sclp_rest != 0;
+
+        return;
+    }
+
+    *buf++ = SCLP_CONSOLE_EVENT_TYPE_DATA;
     avail--;
     /* if all data fit into provided SCLP buffer */
     if (avail >= cons->iov_sclp_rest) {
@@ -150,6 +211,9 @@ static int read_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr,
     to = (uint8_t *)&acd->data;
     avail = *slen - sizeof(ASCIIConsoleData);
     get_console_data(event, to, &src_len, avail);
+    if (src_len == 0) {
+        return 0;
+    }
 
     acd->ebh.length = cpu_to_be16(sizeof(ASCIIConsoleData) + src_len);
     acd->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
@@ -233,7 +297,7 @@ static int console_init(SCLPEvent *event)
     }
     console_available = true;
     qemu_chr_fe_set_handlers(&scon->chr, chr_can_read,
-                             chr_read, NULL, NULL, scon, NULL, true);
+                             chr_read, chr_event, NULL, scon, NULL, true);
 
     return 0;
 }
@@ -243,12 +307,16 @@ static void console_reset(DeviceState *dev)
     SCLPEvent *event = SCLP_EVENT(dev);
     SCLPConsole *scon = SCLP_CONSOLE(event);
 
-    event->event_pending = false;
     scon->iov_sclp = 0;
     scon->iov_bs = 0;
     scon->iov_data_len = 0;
     scon->iov_sclp_rest = 0;
     scon->notify = false;
+
+    /* the guest defaults its terminal size on reset, announce the real one */
+    scon->resize = true;
+    scon->resize_init = true;
+    event->event_pending = true;
 }
 
 static const Property console_properties[] = {
-- 
2.56.0


