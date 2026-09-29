Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83ABC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZdI-00044k-3A; Tue, 29 Sep 2026 11:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xBZdE-000434-H2; Tue, 29 Sep 2026 11:20:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xBZdB-00071u-Tx; Tue, 29 Sep 2026 11:20:36 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5U4q4017555; Tue, 29 Sep 2026 15:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=f4x+oSXPj3rdYcA4y
 B3usef617Q+F1wc48cgksYK/js=; b=AN0Ls4ktoMXBd628NYbKwEqDb+xs7bB6a
 ijLvzzGTk6B8MsYE8vGtTTegaPNF50IpB+5FaJP/DUIODx116MInRWuvfioDntUB
 sH6lWt3c2yHRTpmvgXjSdK4YkH64Hnsf/YaGs2KudunkVpnsSd9ws2xyv2McfrvV
 N9OHbQBad/nhd0b+c88aRTH+uVanlO+BZcnco2eMybVdtaaawl3ROIPPsCZga7Nb
 joe3175CGycbbwtPoRw9X48YcgFSF9vU615Jc3lOTR2CQpZnPAJOlIEj9IWQSsML
 kB8QlXonQdrO/pGPct2KO6Cj4kub7jjbYLHtStCel5WwkLBg1F9aw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt711r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:20:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF1tmY1617010; Tue, 29 Sep 2026 15:20:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrwact4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:20:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TFKGiD40501680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 15:20:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDE2620043;
 Tue, 29 Sep 2026 15:20:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 982AA2004E;
 Tue, 29 Sep 2026 15:20:15 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown
 [9.224.79.183]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 15:20:15 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: filip.hejsek@gmail.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, brueckner@linux.ibm.com,
 farman@linux.ibm.com, cohuck@redhat.com,
 maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH v3 2/2] s390x/sclpconsole: implement resizing for vt220
 consoles
Date: Tue, 29 Sep 2026 17:20:12 +0200
Message-ID: <20260929152012.2696005-3-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929152012.2696005-1-maxbr@linux.ibm.com>
References: <20260921121641.1354712-1-maxbr@linux.ibm.com>
 <20260929152012.2696005-1-maxbr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: d9iPjrFrWmnoXtMyi5tbPwrcg0s5ZLN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX422/r+dXo90I
 im5FJFKlQ3bsCQe9RGlsSkjWMKVIL6o0TqZsJEWMrvcySZsJMMok0oCPAA43CHb9F1MzivMWPBD
 eMWy7rjX0hW24q7RmWgxZ2OXPrw+6dlrqMANvYtj00UbkTK6DEO2gLZnKWCVp67XR9NUbLaHKND
 JTVNUTte3VSwyqRvfshhVmJurC0fM+Zl4v0roZKJwq1GYKczkAPWHS0Cz6HdRI0MLd8StSTrlbb
 v74MtpmWl6XmLRvl74W79KbgBJu15WyTttRsB9sBtxrSwwmnPEQG0gKNbO8v9NP+81lZbQHVchs
 1kWsmO6kJbedRTRsqyEVszXzvEtv9i9Wdm25UsN6cggjbNpHBQJ0xr3M8oSOWY2txhzQOJurJkN
 5Q3w7OCMKma8Ib34+NJbKcHUwj1/hgHFm+35cTmp6cKuYtjfkvOn837jpRofuIAl1ToWe1SrzYg
 gKj+KXeGIyqoF4y03dg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX+sIrz5vCle/N
 ZNb98A0quxocSZTY1l42oirTJLMlzTLnLEvWAfQ/xCUfYACKc0lvZI8OnGUE7gr/5eiuGk/+WW1
 uugIkg+DSYbYjiae9f5rDuHxh0x+K/8=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbd735 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=q2DVYbRnPiRVfZbQHhQA:9
X-Proofpoint-GUID: V7W8C5RntE6wP0Ch3QKnrHVtMxHds_IK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=maxbr@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a tty code to indicate a resize frame. The body contains two big
endian 16-bit integers rows and columns.

After reset, the guest must be informed of the terminal size again. A
chardev that doesn't report its size yields 0x0, which shouldn't replace
the guest's default.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
Changelog:
v3:
- split console_reset indentation fix into its own patch

v2:
- Use packed struct and named event type codes for resize frames
- Trigger initial resize event in console_reset() instead of
  console_init(), skip when chardev reports no size
- Reset event_pending after resize event

Requires the following pre-req:
    [PATCH v7 00/12] virtio-console: notify about the terminal size
    (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com/)

Testing:
- Tested on QEMU: commit 38879a667f with the following patches applied:
    [PATCH v7 00/12] virtio-console: notify about the terminal size
- Tested on linux-next (commit c1f49dea2b8f) with the following patches
  applied:
    [PATCH 0/2] s390/sclp: Resize for sclp-vt220 console
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
2.54.0


