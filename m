Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24F6CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4J7-0006kV-3E; Tue, 09 Jun 2026 17:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Iu-0006er-8v
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Is-000834-IH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4ss83266538
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aMpA1Zh64s8
 KexCk2V7o804331/kR5xrcpeFiGqPvno=; b=Of/pyJXsae0ZE6wUEAw2WKQl3jc
 PJi0w3+N5kl961PIlHmYmYFOgnwXrntI9mTFnoXybprR7BQbRFj5b14JZd7BXQf0
 9K0mKz0XSSxZGBYxWtm2WAGzwYCIc0w2KgwHAWY7WYw7inAH2SRUhnynpTOxBao/
 SHoLI7DDHmCadlEAFkjkhRgfWpsXU8vl7NU9YHI4r5haqvjC0cm2RlsT33IwODxB
 WheIoY+hHP+O8jt2UQ3txKQTXeGsXjOOnLMVCOPDCU4E5F//FDrqrBepMvJblXPf
 jZlQNO+/qST3FXnTTdRPAM9uvppH24Mt+aKvK5d31IJ9qx4tqMr1Pb/AIBQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jujj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:47:59 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137eff27f36so7820816c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041678; x=1781646478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMpA1Zh64s8KexCk2V7o804331/kR5xrcpeFiGqPvno=;
 b=gW8UBXJVVfx8kvbM2/1W86uQiYTx44Hpc8RymmJ8vgBGtpQP+Da/QqAZRyy8P3EtBq
 QtQEiBWnxqJY00DTjyUMhcKZ9UF+n8PiEdjrdjCQjRnylr6Vzm+CqO11AhISAoWMkQwP
 ZC2GvMJr6pprNeXA+KOBieuHNh8cPW2+m6hNUfgWYvDbvXGYqt+dNDf1pcYgyrX40UxU
 62sLGI8uqddQnRHD/gY3J2q9enpLHf3v7j942RqhDd1fql5P1f4En1i7vJSdxqPLNft+
 +uFn/hCRmVab/hUoDbhehXzDS2100B4Tjuwr2MvTSZ7dODCGSkq/Zu/NYuVBU+yf1wEU
 7Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041678; x=1781646478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aMpA1Zh64s8KexCk2V7o804331/kR5xrcpeFiGqPvno=;
 b=a0Zf0+PqZVwEyK7sWkuXwUkHyDwYX+fYRuEBVZ5z2DIYNDb+MDQ6tXTIrIhQRX2K02
 lEWGKlQ4QxVxpYn6uF2nmHNP6urwwm7fKqWNpPX86cgwghnx/OovoEhOzh3n39Ytk/my
 X+yz5KGF5utqdd7hNkG8QnaRoy/L82bCstT5uqIrUjrq2p3CFmwBp623XUP1OcamEJ/Y
 uul2m0frj8RzOIAE5LSr9JdWhtn2lrPTeFFO+sp6I5jTMpqbMJsPo5aXm3OBbJ53KxXq
 QfSYXk85LRRcMCCv+jhdDQarPBVyLfrHGhjCoxKy+9eQ+NrqOfyaDehN37UyV1oyJoDu
 n9/Q==
X-Gm-Message-State: AOJu0YzCbSSsz3fDEvtul84d/qtXrdhKtYHiNK38mgwjaq6k+ouzDrIF
 7I4L2zEmqpfuNInGqnp7hc3VJP37jmp5R520zEF2pNRU83MX4zB0s6cEDgTPd+St/9B3Yu/78qq
 cLmnpQF471TgN4Mkzl9NQvygcD7WXj3Rg+JnaEvzXonc5wZw5BhUJrFf4psu0iVS+VYIA
X-Gm-Gg: Acq92OGkCDqNBpcVfdfdFWZEkEOJw71BnfGlzn1fKv4Pp3ehp9vhKe4u8spgVDTXBAN
 ypNp2K70oL8twSs9Hx056GJiechrpmufICGIcUE31d7guid937CBlAR8qqFQDkBJSnf0aDXc7iD
 5nGOL8Ij/DYCb8XBefNJ03365HmLCsY7qRoPBqUrtj9gWsSxDT5ocAke4kzC2m+SWdzAnZgmmV1
 e9WdzCG7uC56hok9UXhHFACQZ6kqgBviQxEo9/BpFEQtaj9QUNqemqVaIGDoQuf9vMF1iyFtbux
 Azty3tslf/4rt0JzONE/Ae1Y+Q6ENcdeg7+JsFDXotxOiZGS2UFLOOJskPIZaIlq6ihwiQnQMnM
 yyLbI76RdsHecW0UgX27o5JeBOzKQ2sHvHWbsm8uHZaV2V3CkQXBi/NMhjS3bBxvz5EpfAZfR5s
 oNtnf319iSHiOitLlc
X-Received: by 2002:a05:7022:ef18:b0:136:89f7:a2aa with SMTP id
 a92af1059eb24-1380670b248mr10296490c88.28.1781041678337; 
 Tue, 09 Jun 2026 14:47:58 -0700 (PDT)
X-Received: by 2002:a05:7022:ef18:b0:136:89f7:a2aa with SMTP id
 a92af1059eb24-1380670b248mr10296474c88.28.1781041677819; 
 Tue, 09 Jun 2026 14:47:57 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:47:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 06/27] tests/tcg/meson.build: introduce test_name
Date: Tue,  9 Jun 2026 14:47:24 -0700
Message-ID: <20260609214745.772536-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uUAL2noQDZeyGZ-tUpIECPueaJrWuCDK
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a288a0f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=FnD13UrixhZlOC8LVz4A:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNCBTYWx0ZWRfXzL7fjBsYF1lW
 kpGVo2FdZI9TaJWTc1lv9xxw64u+ybkgCZ9S8lIbx0NYxy1TT90s/8W2xQkQ6XPPlxk2h6vmyNs
 Jg/X4rXd0+OeJxfJ5XPlJHUeagMlbFrKP+fidJQbE36s2ZaxXzW2aVUOs1JujGBdC2CM3Xq1eDy
 D9d0ic2pexlLZj/sKfAiCfE8KcVqSITR+P3ptlUTvV1rdNRTQcuw97vGxuo/nsJ3rwrgFJPH+tn
 DwTC9vD5DQvGtw1ToCd+reJh4nlNOqvcdqsNrTF+J3NoO79bfnFo+xZcNL/s17E3agbxt3vLeau
 SuLE44FKaTwGZJRxfhZbkwCTKYl3vPUje+VwW8t6lryqPWTmAuukisqR1x/Muw6heJQEDqlqtPK
 x3WTIz+fCcgiwYxj+S/4/5eYUkqRtuY1Y5yTWMedviGANPLK5plbQxyk6fpc1CyUo12rIDB/y1+
 JgcwQwKAGlRDwKz6mog==
X-Proofpoint-ORIG-GUID: uUAL2noQDZeyGZ-tUpIECPueaJrWuCDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090204
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

We add possibility to duplicate a test for a given src. This allows to
declare several tests that still share the same executable, thus saving
space and compile time.

A side note to mention that meson perfectly supports declaring several
tests with the same name. However, we prevent that to force dev to
clarify what is the intent of each individual test.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 2c6d85c586a..bb0184732fd 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -12,6 +12,7 @@ tcg_tests = {}
 #       {
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
+#           'test_name': ['provide an alternative test name'],
 #         }
 #       },
 #       ...
@@ -21,8 +22,8 @@ tcg_tests = {}
 #
 # Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
-# is guaranteed to be unique also.
-# Default name is derived from src if 'exe_name' is omitted.
+# is guaranteed to be unique also. They can be duplicated by setting 'test_name'.
+# Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -51,7 +52,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user mispell a setup entry
       foreach key, _ : setup
         if key not in [
-                       'exe_name',
+                       'exe_name', 'test_name',
                        ]
           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
         endif
@@ -66,8 +67,13 @@ foreach target, plan: tcg_tests
         exe_name = setup['exe_name']
       endif
 
-      exe_name = target + '-' + exe_name
       test_name = exe_name
+      if 'test_name' in setup
+        test_name = setup['test_name']
+      endif
+
+      exe_name = target + '-' + exe_name
+      test_name = target + '-' + test_name
 
       if test_name in added_tests
         error('test ' + test_name + ' was already added: ' +
-- 
2.43.0


