Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA807C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cxj-0007RM-PQ; Mon, 21 Sep 2026 08:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1x8cxJ-0007M9-6Z; Mon, 21 Sep 2026 08:17:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1x8cxD-0008Av-Go; Mon, 21 Sep 2026 08:17:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LB635M1318002; Mon, 21 Sep 2026 12:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CFNgNI3BkMiKN8SP5
 S4jfgzxsrPOQo26loFun9qQ0CA=; b=LZgBoJFQFz47wkx/MAxwASxphHZHRC9rw
 kgujHUSBrwpJC0zseiqe7AiY37G3y7ZLcqFQjFt1w4nZrm8rA+O3HU+U340iPzBG
 hB5/5tnkRbTb/8BtvfAPnApotmsfr7txJd6GMkDYpyBVDFeeMTjWJPnUliOa+6K0
 UPw9B7uVapE02JGKDGFMim10ZGxg1d2vZQxi6v38zxgz2+YmZb7hnKj3s7Ah2/+w
 5wIsyBoIrTiyAljQZugb6UqmE+B6esSRkVrCn0WI9MblUVS6hrI+b3z4ICTY4SQI
 oJDYbbXS91zgYpA8GJvRi30vnC9ijWhY3iHs7ZIJBn0D8zdOfEMCQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg28eck-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 12:16:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAlUeN1115361; Mon, 21 Sep 2026 12:16:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gn4rt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 12:16:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LCGhns44433734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 12:16:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DECE2004B;
 Mon, 21 Sep 2026 12:16:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B37C320043;
 Mon, 21 Sep 2026 12:16:42 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown
 [9.224.79.183]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 12:16:42 +0000 (GMT)
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
Subject: [PATCH] s390x/sclpconsole: implement resizing for vt220 consoles
Date: Mon, 21 Sep 2026 14:16:41 +0200
Message-ID: <20260921121641.1354712-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: khq3xPDRaortyYcrsXzl5ycjgPexeBHI
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab12030 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=JB5WKEnWKPbm2V9RWeUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX8mccZPH0lvU8
 T0lSi7zvPqp7PI3lt74iyiR7PZeqiyFQUexGSpOgQLY20V9bq6gHvMNqax3z8hdeiQqITIv+x5M
 QkfH1xwOYXLHXORueQ16p6gewSNoVZFSUlGV4LQ3P1kRyQP3EiCvjXMkpEkrGIJXNYlE+P+qAdV
 0E41bLYz1LDu4LCLIplWCw3Sc7BkfYCuCMnSvFumq3RPtztYYxjdsuAwF3jUZiOORo5tf205suf
 nWmNLviGI+8C7iJxl8BPZ9ZCUQn553XN0ruS/pldSQ8iSZGA3yDxpQXTj6Zvnv3qj/whczaWBC4
 B3pg0rFW3qHgBjkY4KZaUhvbyP/+2Ks/Z30PIfGADXgTD/2eC+KjT5bxaDtCfM11qb9T3+wETJO
 C0ghmovvBzQw9waoyX9Kqif1Dv1TXnwdio3vGlquKcjJDPKcnsaV9+fbLE4w3/4PGJp4h7XdWS5
 GGc+u6zajFcAKUmBZwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfXwdnNx2JyFG8U
 dqhLtAaGCTzZjH0rQI9ZlIn3SyAiAI5X830OerCdbk3b8n1K6n5hBSebV7syq9KKYNGF80zeivK
 KNI9ZeZAd0uv0zO82mxrQwdW3psSPsc=
X-Proofpoint-GUID: nj84j39fS_fNqswW6HWNPnRqiqZFBq4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=maxbr@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a tty code to indicate a resize frame. The body contains two big
endian 16-bit integers rows and columns.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
---
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
 hw/char/sclpconsole.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 179d12745c..acf1fea6b5 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -42,6 +42,7 @@ struct SCLPConsole {
     uint32_t iov_data_len;  /* length of byte stream in buffer             */
     uint32_t iov_sclp_rest; /* length of byte stream not read via SCLP     */
     bool notify;            /* qemu_notify_event() req'd if true           */
+    bool resize;
 };
 typedef struct SCLPConsole SCLPConsole;
 
@@ -81,6 +82,28 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     sclp_service_interrupt(0);
 }
 
+static void chr_event(void *opaque, QEMUChrEvent event)
+{
+    SCLPConsole *scon = opaque;
+
+    assert(scon);
+
+    switch(event) {
+    case CHR_EVENT_RESIZE:
+    case CHR_EVENT_MUX_IN:
+        scon->resize = true;
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
@@ -105,6 +128,28 @@ static void get_console_data(SCLPEvent *event, uint8_t *buf, size_t *size,
                              int avail)
 {
     SCLPConsole *cons = SCLP_CONSOLE(event);
+    uint16_t be_rows, be_cols, rows, cols;
+
+    if (cons->resize) {
+        if (avail < 5) {
+            *size = 0;
+            return;
+        }
+
+        qemu_chr_fe_get_winsize(&cons->chr, &cols, &rows);
+        be_rows = cpu_to_be16(rows);
+        be_cols = cpu_to_be16(cols);
+
+        /* first byte hex 0x08 indicates a new terminal size follows */
+        *buf++ = 0x08;
+        memcpy(buf, &be_rows, sizeof(be_rows));
+        memcpy(buf + 2, &be_cols, sizeof(be_cols));
+        *size = 5;
+
+        cons->resize = false;
+
+        return;
+    }
 
     /* first byte is hex 0 saying an ascii string follows */
     *buf++ = '\0';
@@ -233,7 +278,12 @@ static int console_init(SCLPEvent *event)
     }
     console_available = true;
     qemu_chr_fe_set_handlers(&scon->chr, chr_can_read,
-                             chr_read, NULL, NULL, scon, NULL, true);
+                             chr_read, chr_event, NULL, scon, NULL, true);
+
+    /* set the initial terminal size */
+    scon->resize = true;
+    scon->event.event_pending = true;
+    sclp_service_interrupt(0);
 
     return 0;
 }
-- 
2.54.0


