Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC174C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZo3-0006CI-Iu; Tue, 28 Jul 2026 00:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnq-0005n3-6v
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnn-0002WJ-Sq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3toNe1919979
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=S9dhKn8Iu/o
 HV/S6dLCGG/WMZmkSPdhI/GdddyLq1iE=; b=bMS74znjN1RLZmvMTUieZTVRFRv
 YenfF4qPQ+weaViWFJh/XCy0okJYEyaJ+9DqIZPBlWcrtaXW5s74DFXJvRSSuM76
 FfKqMg8/PWV9WSkAFnVI0zymwCieaCJRtEEr4S3uU/IjIjhQmPZWXclkad36j6EZ
 bdB6IEr45q0kKR9O/tRjTLEqjrL0iPB9re1SBCFRaatFGhts+LjaRbrI4OIyAdW4
 Jnj7Y75+zCsalUKvaNVG5nM56nSdC2tuEhiK4fVPsY2/RvzNu/U29Y91+PVg7KPH
 dAfzPyymRonhqoJTWyhV1qhdxrnQDFnjY35zK2zUKpOitjgWAWyc+dGzHxg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy105ba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:26 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso2657899a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214346; x=1785819146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9dhKn8Iu/oHV/S6dLCGG/WMZmkSPdhI/GdddyLq1iE=;
 b=ImUlf+1LN0Usdg6SBS17BZyz8PFx1aO8hg1igBAQqL4bkRnjqUYDQ2UvgnSv1FYNqz
 sHTn0IA+DmJuYWaOb2H3L/wn4wq545Z6KGfb9H365iHzVcXCPLm9bAsa8durQtpYLcQI
 A1znXsJ6A5S9zKklg60Hnm7JPchCxGetPZ19wo00jw4RzGiuBYzDxYQ6NP4VCe6hh1To
 7higmze4E35Jc3Il8Hmr6kReCMU4JLZHunEK6EntCtpWH/MlIB4v/rsk7KdPHCECqTX6
 5tk6jHPt7qtuaz7ZMh7mSDkJIdXAIW1EYn5ZCdlqetM5Ow5o3KdeBcOOfBx2k/c0icv7
 iC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214346; x=1785819146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S9dhKn8Iu/oHV/S6dLCGG/WMZmkSPdhI/GdddyLq1iE=;
 b=A/3Hl6F871+3NIg01ZCkSCIIrJlwR6Tg8m4yhejbpuJlQi9IOjaFmduAMcSmn6gn0C
 ZlqXTruWeCzSgADEdRIwoUwwNWHhJiD6RTKn+f+BJl6C1gqKoQAIAJcp81RNsWsF/nO3
 vLE+oM/dlGT/1OpynYCjckgycOiSa+Fw6TxIc2mGcWNH6Tt1SosWDNzJFrTUzqL6xBwL
 zLPVC990Lo2C5oZftB+Yq3fbaPo3I/P6s5Tk+sKKAozuDuIpEbG0JMPdoTx9n5b3xo8R
 oDv+1oN/k+Fyr/b8/NXZ9O0+gT4RY8qwVWOnsv6DaFd1rH3saITZJHLJnHQ2x3iMQ39Y
 Vp4Q==
X-Gm-Message-State: AOJu0YyT38WHUT8aOy+IwUEBPle94xvIIZyIJTLhcueuwFrBI2DqDK7P
 8ClEYMqin4jUFwhyypGshZPuLIK+5qJ1S7Ucxvg/OBk94+3FPyAwA+OdAPvayLoHIEv7m5ICnh+
 Q9oLbVGbMLes3ee2xrnsM4qyCEuHW4sZ4Dvu0QwEFz/7Aqzp5UKpnrGZ4beYcMQauuw==
X-Gm-Gg: AR+sD13O7oJkliu1Tl5lmctzDspJ7Os4c8HtHgVl07QwGVUf3PhDEFPkbmkS3UO4Y+9
 yKDa473AFgQYF6wHKAPoI3RAyBSp3dOQIGLl1JURwjyMHKUFO7pdBUEKfF/Wr4LiqvaoNjbCeiW
 R1Br4wkA48VBd9Ad5pte356XU5JY8CuNrLwzX+cO8ThE7bhwUiWiwGNtXnG4WwGe2dTRPGE1jKn
 qA3GKRasC7LRvKqLhxfK4JxAhAWpqFmK/qJJ80ZfmGA87Qmj21VjlSeuQdsztQo8DuEdtV1X9K6
 +m9uv3oOzQZj65VDfHRzd06zgKLLKLTXKc1+8UQxVFpdeMaNOrXqTik2RIOU+DB0uqGTASZ9k00
 2Xqz/uFB31Ml1ypP1b/k2CDEYnd+3+cZa4r6RbQiSzTiF4LWEfLBeWiJsOGRONjWFweHk17Y=
X-Received: by 2002:a05:6a20:7f8b:b0:3b3:1b38:d9d6 with SMTP id
 adf61e73a8af0-3c8ba5d9d11mr1190126637.39.1785214345687; 
 Mon, 27 Jul 2026 21:52:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f8b:b0:3b3:1b38:d9d6 with SMTP id
 adf61e73a8af0-3c8ba5d9d11mr1190100637.39.1785214345240; 
 Mon, 27 Jul 2026 21:52:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 084/103] tests/tcg/s390x/console.c: directly implement
 memcpy and memset
Date: Mon, 27 Jul 2026 21:42:28 -0700
Message-ID: <20260728044248.137626-85-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8kZ1CUIzcZpImLF7ayiXAIgQjGV8lWsS
X-Proofpoint-ORIG-GUID: 8kZ1CUIzcZpImLF7ayiXAIgQjGV8lWsS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX2pJ+Oo0+qLiG
 NeC/Zrm+C87dSTe2fmq2r9/zuMIPBLsC3o3CRX2vYmKArqzYmuUlBz6XO4GNX9/VrbFd1+hB+Z6
 f2YkswN27rme35wC/tUkkJ4cEWkmolDOoWw8F0Ojc3wroQ+e13Nhz+p8NpLCe19/girpKWgsYJ4
 JBU5laIstdWnTJEhJ+TDcWoMIbyqPUPUs5M5ZsCCI9sU+WbkExrnxOq2oK/y3qsT/wRo8Jqykl5
 nWmPxIaKKVhkGUxvYPp+z3xfMxB29TNSmJ8FNEjBSKPSJniM2Zz47mjVi9JzI9v48Jj6AnLNzgH
 FIJTeRILNTO5jf2BP+xg+X5TZ56mp5K+5f/yZ8pFD30RJEzWkPJnPY2a+qfDaN8zesfgx8S3uxO
 pnEOCJyQOj+pcCNRc63ixGlDapSQVdmPd59zbXKC3Z6meizD+MlUQ3xLzqOMPK0kiGyOPZpYTVu
 opj8Zpdvaj/sgpqlamw==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a68358a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=-FtdqLbzwS2V55xVmDUA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX+Ia4shDeWHXQ
 /gRBxMWJu04bx15BUz64nUyxf2fcA1+zJr+o3OYjyCQTerqaU6k+40pyM4fi7dw+M9c2tuKk17r
 r/BfhbnffjI3A+oYMHsAkz1VaFu/vt0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

pc-bios/s390-ccw/sclp.c uses memcpy and memset.
pc-bios/s390-ccw is part of QEMU repository.
However roms/SLOF is only available if submodules have been
initialized, which is not not always the case.

To break this dependency, just copy their definition here, and remove
include to submodules files.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/console.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/s390x/console.c b/tests/tcg/s390x/console.c
index 6c26f04949f..061b9437d98 100644
--- a/tests/tcg/s390x/console.c
+++ b/tests/tcg/s390x/console.c
@@ -6,8 +6,34 @@
  */
 
 #include "../../../pc-bios/s390-ccw/sclp.c"
-#include "../../../roms/SLOF/lib/libc/string/memset.c"
-#include "../../../roms/SLOF/lib/libc/string/memcpy.c"
+#include "string.h"
+
+
+void *
+memcpy(void *dest, const void *src, size_t n)
+{
+    char *cdest;
+    const char *csrc = src;
+
+    cdest = dest;
+    while (n-- > 0) {
+        *cdest++ = *csrc++;
+    }
+
+    return dest;
+}
+
+void *
+memset(void *dest, int c, size_t size)
+{
+    unsigned char *d = (unsigned char *)dest;
+
+    while (size-- > 0) {
+        *d++ = (unsigned char)c;
+    }
+
+    return dest;
+}
 
 void __sys_outc(char c)
 {
-- 
2.47.3


