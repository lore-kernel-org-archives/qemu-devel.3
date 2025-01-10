Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CC6E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFlB-0004DM-I2; Fri, 10 Jan 2025 09:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tWFl7-0004B6-Ke
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:13:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tWFl5-0004Eq-Vk
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:13:09 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3s8QO030144;
 Fri, 10 Jan 2025 14:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TQUSXeg1nRwj4LhdP
 TK46AjA0uZM4Ycou0//eBvLHHE=; b=Fz1m049nHee7+6w/CH+bOIcS9VaoKEvOA
 ZtK/CNYag7rLMaIQBmScFmI8AgeFFGF6x6lDEKvmC5Laj4phfHsy4ZNjHLwK1bxE
 SsmG62kfGkICdPTCyG3T75Nb2oT+YWII7/v/zYXTjmLiL3BIIMPYopvpfG1tsGqS
 aiepQ99YtuBeCdeAQ/eI7lAMjgKl11SsUih9wS5/rK6VYmgwmkzc19yJP1lIYO0U
 VyitvbZN+WjdKw1uXL+3OnvCNHLxUftRU81jwJPIBHZ5D3rWg05G8Ll3+TbBVlSB
 UxFq9HviQabC/SP7k93BOqN2R4iIceG0qrkp9p+QASL3v+7/Sx8tg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442v1q2bfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 14:13:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50ADMHtj003630;
 Fri, 10 Jan 2025 14:12:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfatjs0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 14:12:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50AECvaa33489344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 14:12:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B865D20043;
 Fri, 10 Jan 2025 14:12:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0697D20040;
 Fri, 10 Jan 2025 14:12:57 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jan 2025 14:12:56 +0000 (GMT)
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
Subject: [PATCH v5 1/8] gdbstub: Allow the %d placeholder in the socket path
Date: Fri, 10 Jan 2025 15:09:33 +0100
Message-ID: <20250110141255.2328-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110141255.2328-1-iii@linux.ibm.com>
References: <20250110141255.2328-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A7hbuQyXZY8bOlGTfqYiPoEZLTMvk8jw
X-Proofpoint-ORIG-GUID: A7hbuQyXZY8bOlGTfqYiPoEZLTMvk8jw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100110
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

Just like for QEMU_LOG_FILENAME, replace %d with PID in the GDB socket
path. This allows running multi-process applications with, e.g.,
export QEMU_GDB=/tmp/qemu-%d.sock. Currently this is not possible,
since the first process will cause the subsequent ones to fail due to
not being able to bind() the GDB socket.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/user.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 0b4bfa9c488..ef52f249ce9 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -316,9 +316,19 @@ static bool gdb_accept_socket(int gdb_fd)
 
 static int gdbserver_open_socket(const char *path)
 {
+    g_autoptr(GString) buf = g_string_new("");
     struct sockaddr_un sockaddr = {};
+    char *pid_placeholder;
     int fd, ret;
 
+    pid_placeholder = strstr(path, "%d");
+    if (pid_placeholder != NULL) {
+        g_string_append_len(buf, path, pid_placeholder - path);
+        g_string_append_printf(buf, "%d", qemu_get_thread_id());
+        g_string_append(buf, pid_placeholder + 2);
+        path = buf->str;
+    }
+
     fd = socket(AF_UNIX, SOCK_STREAM, 0);
     if (fd < 0) {
         perror("create socket");
-- 
2.47.1


