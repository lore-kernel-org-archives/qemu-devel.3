Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DECCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyC2p-0002a5-2m; Mon, 15 Sep 2025 12:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uyC2l-0002Zj-EU
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:27:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1uyC22-000687-6J
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:27:06 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDv4af024250;
 Mon, 15 Sep 2025 16:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cS6EkZ0ID1VVa5aIP
 luUiD/+AuL/jgI+GJo/dc8rhy4=; b=Kf15CyoLmfwukJwHeqfy1oquBLktJt3QL
 X3oeV2wUaNr5X9Srg/Q7IqfhFkYDBPVPGSifo2K2/EHyIJ+zhe3cIcrYUwzmGTY9
 5eB+n6N7jDIObDtqP1ZAwpLdXW61JiOkQXxY+a08rrSkmTSUZtazE0BF5zjEBEhZ
 1M7GrC4jc0/amG3cReSw49fDmLnoDQjwN+C0AllAyVM6x2dULIbn0G9DzALCX8dk
 qxz97DVJkcoZljVX9kjBW/bKzBJyjvx+DpaNNIVAeRB6NMUd19Dpuo4vMLG3qMcL
 5NF31vrX3GB77MYiavrjfpZFg4SlO6ybjNOaamgbdRd0ju2i/7KZA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnku0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 16:25:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FGLJCQ012282;
 Mon, 15 Sep 2025 16:25:46 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnku0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 16:25:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FG4aJ8018625;
 Mon, 15 Sep 2025 16:25:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5m756h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 16:25:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58FGPhEl61211110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Sep 2025 16:25:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3346420049;
 Mon, 15 Sep 2025 16:25:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69AB220040;
 Mon, 15 Sep 2025 16:25:38 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com (unknown
 [9.61.163.204]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Sep 2025 16:25:38 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: berrange@redhat.com
Cc: amit@kernel.org, armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 filip.hejsek@gmail.com, lvivier@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 maxbr@linux.ibm.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com
Subject: [PATCH] char-pty: add support for the terminal size
Date: Mon, 15 Sep 2025 18:25:35 +0200
Message-ID: <20250915162535.147642-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aMfR3N3z6_fp6Lg9@redhat.com>
References: <aMfR3N3z6_fp6Lg9@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kbk141anzs8XQXHi6Zqj7Hhror-XTc0D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDAyOCBTYWx0ZWRfX8bd3sIxWTVi5
 UnuYyCtx+VZq8HIp0Rk+DInpQIBt1Cd+UhG5XfzrsCLkDsuxBiKp+U29A1ThVCACc7ku/oA6azO
 7RKGgVGtsPwlCvuEUzKA3NG2HbPyoS0E2Vmv/N2glrGrZkdqCbhQGICnHesi8fhMz4WfECMin/q
 EY8COnLNLwkatv9vBK7HDStyoU2EThQJYB0DV4CwDH70hmn6VSXsD6x/JXrKg9sUdA1MzJORHU5
 rX64Cns282CnlgtCahu1BbxoKBvMmuPFjhGmqX2YY0/DJaSIDvSXqlbiGwbAgWxmVswsC/guSQ3
 +Rt45Eam1KknfkIBpkrZodiCNqmhrU9ya3tuoEXcOt3YZzQIIfAzq4+cLF19flHzHk5G9wSKjmR
 pufuZoMN
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=68c83e0a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=GfxKoImt5xJX7E72Q28A:9
X-Proofpoint-GUID: 7KXbZ_87q3VgVme4eejIgBNgoQjKHBB3
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

To be committed with the patch-set: [PATCH v4 00/10] virtio-console: notify about the terminal size

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
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


