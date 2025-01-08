Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F402FE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 20:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVcdX-0007C3-5k; Wed, 08 Jan 2025 15:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcdV-0007Bg-Gh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:26:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcdT-0006qg-4y
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:26:41 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508E75Rx003080;
 Wed, 8 Jan 2025 20:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=h2zLql
 JHWsyk9VsMpy+BdlX4us6ZwDunSnosEn8uDtA=; b=QcZm6hHXB9eIFWRxuNxfSu
 BJk5jsvcO1BFxVX8KWcAjIwgFQrQ+ap0HNzKmvhbHaoglbSha5PZYnRrUhJ1BXc+
 G1cZH5dus1xGWj8xRnjj8BPYkEga8qelqsY1H5Dpa89HBE4Gl3d9MHatuMF54pRi
 IST+IiS1SUSO0luzK8NIpl8NIxNXNTDKEyDSXnHKPe6vllbrD6RM+J6JaMap4mef
 lyr5pjlWgXvnP9nUdVOQaqzZg0cP51pTYDYZBHqMgVIGlXiC3DrniGvK/LZtX+Hy
 6+BpT/vw6u41Qw1HEzWMFvIV2Qo8l33lvg2+Qc3KKh6xRE7PV56yFwH0hBVoj8MQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5hmm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:26:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508H4LVX015805;
 Wed, 8 Jan 2025 20:26:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtm1gp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:26:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 508KQSEw40108356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 20:26:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4767620043;
 Wed,  8 Jan 2025 20:26:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D38220040;
 Wed,  8 Jan 2025 20:26:27 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.127])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2025 20:26:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 1/9] qapi: Make qapi_bool_parse() gracefully handle NULL
 value
Date: Wed,  8 Jan 2025 21:04:56 +0100
Message-ID: <20250108202625.149869-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108202625.149869-1-iii@linux.ibm.com>
References: <20250108202625.149869-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E1NcSFeJfU5EUuOXXBmSyIy1msxkakjN
X-Proofpoint-ORIG-GUID: E1NcSFeJfU5EUuOXXBmSyIy1msxkakjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=843 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080163
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Use g_strcmp0(), so that NULL is considered an invalid parameter value.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 qapi/qapi-util.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 65a7d184372..c6ae829f904 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -86,17 +86,17 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
 
 bool qapi_bool_parse(const char *name, const char *value, bool *obj, Error **errp)
 {
-    if (g_str_equal(value, "on") ||
-        g_str_equal(value, "yes") ||
-        g_str_equal(value, "true") ||
-        g_str_equal(value, "y")) {
+    if (!g_strcmp0(value, "on") ||
+        !g_strcmp0(value, "yes") ||
+        !g_strcmp0(value, "true") ||
+        !g_strcmp0(value, "y")) {
         *obj = true;
         return true;
     }
-    if (g_str_equal(value, "off") ||
-        g_str_equal(value, "no") ||
-        g_str_equal(value, "false") ||
-        g_str_equal(value, "n")) {
+    if (!g_strcmp0(value, "off") ||
+        !g_strcmp0(value, "no") ||
+        !g_strcmp0(value, "false") ||
+        !g_strcmp0(value, "n")) {
         *obj = false;
         return true;
     }
-- 
2.47.1


