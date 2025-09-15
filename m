Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93DCCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyCAR-0006qz-Nj; Mon, 15 Sep 2025 12:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uyCAO-0006qC-Aw
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:35:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uyCAA-0007YB-7u
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:34:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDId7a023574;
 Mon, 15 Sep 2025 16:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iXwxhs3IlBLgethRh
 Z+Lz5FtrIcS1AsOKcUKFw6BXEk=; b=bOr+RCE1vxLe62Hy3xU1AmxcgADrodUpJ
 aeeGywTV+KMxv55U/I32RzZOUN47ic5Vgj/qfYW5GQqCvxiZxlTZr45sCOvnkyTg
 PJWKKLZ6SFJWQE6HEL1UEuVh/rfbVVzKuEnO0PYeQRJl3EopvQMk2A4aTj/QRlTr
 GJ8XhLf/tohCn93GoKyB/d1s/7Wh6mz6zHf2Ck1y7uHlgmCIu7pr9ddF9Hk41xyE
 9fm16ws+rO8K5/029BHeUL51BawpwM388aw0X3zlPkv29asTskR8qWYRH/FXjImA
 VlnkLbWP7EA3RrGm9e0pN/ZkaeDBzcVdmcqXXd4y/yEuv67Ww7W5A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnkvf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 16:34:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FGWcsw006560;
 Mon, 15 Sep 2025 16:34:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnkvf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 16:34:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FF9XF8022328;
 Mon, 15 Sep 2025 16:34:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpfdj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 16:34:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58FGYMfq55837026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Sep 2025 16:34:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4350820043;
 Mon, 15 Sep 2025 16:34:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FDE520040;
 Mon, 15 Sep 2025 16:34:17 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.61.163.204]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Sep 2025 16:34:16 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: maxbr@linux.ibm.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, filip.hejsek@gmail.com, lvivier@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, noh4hss@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, qemu-devel@nongnu.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, nsg@linux.ibm.com
Subject: [PATCH v2] char-pty: add support for the terminal size
Date: Mon, 15 Sep 2025 18:34:15 +0200
Message-ID: <20250915163415.149190-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915162535.147642-1-maxbr@linux.ibm.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ra2wi9pZVZIMeCh9dBk13vyyxokuDGk-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDAyOCBTYWx0ZWRfXz5iKkU7gFaAa
 cjX8ByxGaKWBs4hMc781mCK9i3nHJSZehKtVU+ZYW1FOfFhGChjxmNBOfsVq4SzbGUX0h6OmYxn
 zC5vIZSzU6z+FxxqCpq4lZRSJzpd5+l9Q2D2UxcAEpZLADxy1xCy064aDLhPQFmMUehspGLonjT
 8QooWvmKLBj+AH1Ybd+X79bH8nWELOP7ukRz1VYrZgK+I79fsKsBmmyPKYwzsXIFBmvo0H5SIUh
 urvyjt955E11lCuy6KYrSQXvI9nUwyjxsKYM64AMzMgH/tryHZc/ElVinrW50ReA46zWtM58yRl
 e8kbL2f1tq2JhQlR+8oTGKswTJJPs7MqSsoZzQMQmPsQdEeuZy5jkv5oZNMSDEHqqCeMFIZiILl
 7mVv8WZM
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=68c84014 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=GfxKoImt5xJX7E72Q28A:9
X-Proofpoint-GUID: 0HuAXI7QRoHD9IIjFj9g_kIzXzBW3Y0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150028
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

Update the terminal size upon SIGWINCH delivery.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
---

To be committed with the patch-set: [PATCH v4 00/10] virtio-console: notify about the terminal size

v1 -> v2: Move comment regarding patch dependencies to note section
---
 chardev/char-pty.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 674e9b3f14..802bae9037 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -28,6 +28,7 @@
 #include "io/channel-file.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
@@ -35,6 +36,8 @@
 #include "chardev/char-io.h"
 #include "qom/object.h"
 
+#include <sys/ioctl.h>
+
 struct PtyChardev {
     Chardev parent;
     QIOChannel *ioc;
@@ -43,6 +46,8 @@ struct PtyChardev {
     int connected;
     GSource *timer_src;
     char *path;
+
+    Notifier resize_notifier;
 };
 typedef struct PtyChardev PtyChardev;
 
@@ -85,6 +90,15 @@ static void pty_chr_rearm_timer(Chardev *chr, int ms)
     g_free(name);
 }
 
+static void pty_chr_resize(PtyChardev *s)
+{
+    struct winsize ws;
+
+    if (ioctl(QIO_CHANNEL_FILE(s->ioc)->fd, TIOCGWINSZ, &ws) != -1) {
+        qemu_chr_resize(CHARDEV(s), ws.ws_col, ws.ws_row);
+    }
+}
+
 static void pty_chr_update_read_handler(Chardev *chr)
 {
     PtyChardev *s = PTY_CHARDEV(chr);
@@ -331,6 +345,12 @@ static int qemu_openpty_raw(int *aslave, char *pty_name)
     return amaster;
 }
 
+static void term_resize_notify(Notifier *n, void *data)
+{
+    PtyChardev *s = container_of(n, PtyChardev, resize_notifier);
+    pty_chr_resize(s);
+}
+
 static void char_pty_open(Chardev *chr,
                           ChardevBackend *backend,
                           bool *be_opened,
@@ -376,6 +396,10 @@ static void char_pty_open(Chardev *chr,
             s->path = g_strdup(path);
         }
     }
+
+    pty_chr_resize(s);
+    s->resize_notifier.notify = term_resize_notify;
+    sigwinch_add_notifier(&s->resize_notifier);
 }
 
 static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
-- 
2.50.1


