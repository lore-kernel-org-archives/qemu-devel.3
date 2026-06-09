Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C64CCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JM-0007CD-MW; Tue, 09 Jun 2026 17:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JC-0006tg-1s
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J3-00089D-Ve
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4rhh3266507
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mX9AURxEn3F
 Mu3PeaHMHnmctpbTWl3flWrxnltNaJGQ=; b=khaS2TK+2W/LmJrDQoWiaRWmkZX
 Lk5xkS0THDVfQkOpcO717BaUhFMS1IrM40cZqaaK60aEa8ING3rk+d9D/D7bDEps
 Ai/nAxPJnY68EIEp3IvYdoa772Lbb2wpTSrt1NJeUuyc4MlcIiXgwbPMhH0r57gK
 +ZLzDL8+zHVHZ6XBn5z1wJQyxFF3B6D8/HyYT1OJt6SFoNykpmJGlGHA52xnlcwX
 qv9e/1fcI4PnnyDcXr3yOf9WBxYYyHUSMaV0zP/c1XRGktIttUB/s8387wdhpJWB
 VOMURg13MEXLS2/qzd7OsQPEvmXLV5SDEFC4MlM/JRd1iWCLqek/fKWXI9Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jujkf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:10 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13825e1dc0dso10306827c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041690; x=1781646490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mX9AURxEn3FMu3PeaHMHnmctpbTWl3flWrxnltNaJGQ=;
 b=Uxl+eYrk/P9Ld7kcFj2p0+Dlw28F7ic3frbT7N6F8g3i5DkAbn2QEzh+t7fmvkExyg
 otlnv8YKDnmcHo4TF7uYQTGb28GIjBJmBTn5pLBsVgE+Ia053XDUKhtCAwF2iu6TliHT
 LknUGJ+BgyL3Vttjv/uYmvCwnBxyHtfqizJxpya96dNXKr+BNWTNThrqzS4Ruj9VJr5k
 QWshPN/ZPmR3521mtc9cf/F2Wm/dDA6Fu3E22fuMJEcBFbUwWZ4FvQh9Mmk04BYix4TB
 TWh86P/kCokVPdjIJ6XNt8ocRcI5AXT53pvVc5OA1DHx0jZhcpB47hfjja88v/2rjfnQ
 m/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041690; x=1781646490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mX9AURxEn3FMu3PeaHMHnmctpbTWl3flWrxnltNaJGQ=;
 b=n82C82etuVoMP0z2S7TCl6DZf3GB4C8KuAb3jl0q5ytrGW/JS2A64ijBn+usk0FWmO
 03fpRlO+4d+z0zucEAU3ETAZvHzXZ1tdxA/VXIToYqTnxucZs5DgjzoZe9OTVbSWVFop
 Ui2rFpuL7Xt5bAUzIUwGCO3jjkf+na3cnVYQtXgBg+4qJl6jNat4SvsWrX0qOlQC8OUz
 +FRdPDOJ2s6D/3J7+M8JTu6oweBQNYkFkCptBSR63f2k4a8J3xvHFIbq8zKLQZbEdYLJ
 WpMidyHKc5f1BvbT9R1TGg/4wap++SlUNeL33/Q7d7tskDffHgFd2ol3fCiFaZVJkhKd
 4rWg==
X-Gm-Message-State: AOJu0Yz177J0p+a1okScdXKdEkebkQcjLrKQBigonWKHnG3I9UX8RjQ/
 n0d6JRtsj2RZUyC6C5vAxkV2f3nAL9xFG8nGm4ZbtRpSBN0DCqkI7kKDFUU1XW7xLdCByGWakjC
 kWWrLXeJITqY/MMCuDR+YE4QXL/zjHKTzVEKtZW5FX0ysqyukWHBXTVTjuTfd2xNr6EqI
X-Gm-Gg: Acq92OG7sGyrL4FcCgrtXUakYWxXogfMOc4wNrUziyFn1zpHBKw0eRZ0J9bguN7W5qH
 B4C6S7E3gBMQUtmG2tg6DbZsUNV4Pxs/aXS7lQoE9RkurhOEf1QqpFDgPpKLx/AlCNWgjybIn0E
 UtOGc3IKqRuJ6bCD3u/2uqhCfo8Y6bdo7y3rUConCii1thL6WAA4e6DiIuQheHnTPaZD8q4dJ+I
 tVaTldQR3iPNnYRrEN+n0WZwZAKJSkL5LBpbjG8PEa3wy5CRpX/q0OZF4LPO0ZL+lwDWckjhgxU
 n7lWFMCa8q2Lo0z1okOfT9RBVAGzckJYdNaakhSIPTP/L6Ze99aGjF+zEj460KQpWDxr5D37UcC
 ux5ZvSyq8naNZZnTv2sEEFi9G1Nh/s56Mp7Q/XxefOVDWXf3foAqYRNrjYpKGMGchpO0jfCBSzw
 W7n9JHXk/WzaVK02OI
X-Received: by 2002:a05:7022:6898:b0:133:3c47:932e with SMTP id
 a92af1059eb24-13806731c39mr10893203c88.28.1781041689856; 
 Tue, 09 Jun 2026 14:48:09 -0700 (PDT)
X-Received: by 2002:a05:7022:6898:b0:133:3c47:932e with SMTP id
 a92af1059eb24-13806731c39mr10893186c88.28.1781041689317; 
 Tue, 09 Jun 2026 14:48:09 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:08 -0700 (PDT)
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
Subject: [PATCH 16/27] tests/tcg/meson.build: introduce expected_output
Date: Tue,  9 Jun 2026 14:47:34 -0700
Message-ID: <20260609214745.772536-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Wjrxi4Au2jCB_1rc_mw7EFlBnlrnMS8-
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a288a1a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=SiMjXmYFN9jqeZmQACUA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX8aQwkaHU54ds
 2fvft9dk9ClPfVMA4mOeu+6EjJ7Cef243woLj/0ann9XW4dcIly5NCFGrWhl4K+hFIiWz7Mkb9G
 zPQYdkrkOiOIN2ywe9qeil/uuGLsP01gMdvvBonjWT6MQMwF8P9qxQud1udY/fBjfdRwXNRLklh
 t55nN9tKbylL3IP0fWk/qZQW8RAmO2LKVPCL1ebw5tUQDMin3SrNHuUksO+MONai+fi7Abhl+OT
 OsN+KEk22eIVjSjei04gTWYZLDAJ2x494Pe88Kf0ITHgSZXHxWYv4aFLaRzx0zDJTW+g7tljHhU
 dbJp/WCbdEPjN2b0jkMvJkjkvPWVujFQhsHqqSkOy0ig9cHKZADop4XX9TuXGZoq1B8eSd4sKD2
 YpJKr2oR5YNaJT+51hS2+5NQW/eWowD/CKLoQi3wuBGKYVHJaJ0kSDA8K1MTUmiK212oUatr88z
 Izw46clDa0h9PvsKMpw==
X-Proofpoint-ORIG-GUID: Wjrxi4Au2jCB_1rc_mw7EFlBnlrnMS8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A test can declare it expects a specific output on stdout. In this case,
we compare it to a reference file. We implement this instead of relying
on a wrapper because we need the flexibility to resolve name of
reference file per target.

For instance, multiarch float tests expect different ref files for each
target, which is something we can't express with a test wrapper.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             |  9 ++++++++-
 tests/tcg/scripts/run_and_diff.sh | 12 ++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100755 tests/tcg/scripts/run_and_diff.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5380a360830..3d2c0d6583b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
@@ -24,6 +25,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
@@ -84,7 +86,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user mispell a setup entry
       foreach key, _ : setup
-        if key not in ['cflags', 'qemu_args', 'gdb_test',
+        if key not in ['cflags', 'qemu_args', 'expected_output', 'gdb_test',
                        'exe_name', 'test_name', 'env_var', 'plugin_test',
                        'wrapper']
           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
@@ -197,6 +199,11 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'expected_output' in setup
+        expected = files(folder / setup['expected_output'])
+        cmd = [prog_run_and_diff, expected, cmd]
+      endif
+
       if 'wrapper' in setup
         cmd = [setup['wrapper'], cmd]
       endif
diff --git a/tests/tcg/scripts/run_and_diff.sh b/tests/tcg/scripts/run_and_diff.sh
new file mode 100755
index 00000000000..d1e9243c49d
--- /dev/null
+++ b/tests/tcg/scripts/run_and_diff.sh
@@ -0,0 +1,12 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_and_diff: expected_output_file cmd [args]..." 1>&2
+    exit 1
+fi
+expected="$1";shift
+set -x
+diff <("$@") $expected
-- 
2.43.0


