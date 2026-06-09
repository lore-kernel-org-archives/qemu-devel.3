Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EBCCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JR-0007MD-NC; Tue, 09 Jun 2026 17:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JG-00071U-4x
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JC-0008FN-92
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4Z1l3567432
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qsjW7QrKNyn
 sfdqovcaksLcMw4O8hgy+cGosp4YWPgA=; b=jv/JcQ5YOv+xVCltl47yuRsU1NG
 c/X6fNsPm4hpQdWOWFAyXiykqhT17KwLyp2xtvmKPm8QC0MjKlBm049QZaQzSCYV
 ECS0gKL6Y6rdKEuqABTtNLTxlhz3l6N6/PeXAUaWoFNSZQ8g0ZAwqDwHfpiJgkwk
 n3G1bMo8qiV8TvnFthAzfxBCbuW/cg50v6nv5eHn4i2lJv8FIqA57eCpn7/HshFn
 pPBoUI9jge8EGjDrBgs+ZxV5NVPRKegp9eshFwHcBuA93oP38GkV2q+tYvm5gD1a
 yz0w4TMcqZX8YW1IfrDtsKD0xPPuWwgeGqZG4ZIxM5Qf8u6T04Wg7NdBWiA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4kyun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:23 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13815e0e6baso5108117c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041702; x=1781646502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsjW7QrKNynsfdqovcaksLcMw4O8hgy+cGosp4YWPgA=;
 b=aP3LRTTFQo50BTqk7WgLtoShikvIm0Ha3pLjySIpyEbXz4jpgTFZgzVRJP1TSfuXi2
 M9w3NCUHzWSycrIJuibUOKKN69m5iwyzFvjVnfliQVMW45r940lEisgosJ+B6s9jJFWp
 Uto8j5zK+dhBsYn7J+Tov4rwjwQPi7OvhodZp8eMEZkNy+SUNmX23U4+46IDwWJMw0TV
 rVq+sF20zQ43ztcrEdYyVat6Ei1gOFcZ6cWHAJb/DseGqQb6jNfDUSChmaH97OtpOjvG
 HZZU5KwEGlh4iIfHIzwAdXQtwUhobiRdMGln8GdyC1UavOQ1P/1BSIG4SPW80XFay9et
 NLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041702; x=1781646502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qsjW7QrKNynsfdqovcaksLcMw4O8hgy+cGosp4YWPgA=;
 b=Jt0azjE6YSkM7AJOhMK69ebfINuhDeEsq3jK1lyRzKoAMyy3OkMUvOLrMShJiawJSq
 6/P8Jq8vUTWzMVA8O2apWeDuA8sTN15ypP3pIugEo5b4+oU0p27NvR8I6upgY9Copb9D
 e02HZUQ3Y3vmcnb1+XSu6MVot4O6dL3jHG7sOAF78aSvrxLB4k4GjgF8W0Xu6xLB2i7v
 GBu4ZZlFAji/NqxcaUbWdfCBl76GzDjaiU6FzFNAtwB8OZtBpYGlAMZv/MBNkc8Hktag
 r1UFcWQM4uqNnOFMOmC5XqFsvAJ8+Y3ayF/xoDX+C7gcrKUGGlsF0TZns5ymsuL4GLBg
 V5YQ==
X-Gm-Message-State: AOJu0YxzGAj6RUJwDjaT8bia2KgGkwrOTI1EX4x/GjLPhZzhLWK9XIO2
 Tdt7+Bl4bWa1PK1APVGj50I5g+FCHu6+SEIz6o8FuJxT3DdMgUBJoCOUDUVQQqGIGMD45zIJpDa
 KID8M0VhnZH5BpPZ+wwYXet7OI1dqcxYM7XoNRr/HXGFW8OHG3R/G08WP0TrnwDvxr2tP
X-Gm-Gg: Acq92OFhK+zrltQEUegw6NP//Pz2HmGYM5V8Cb0o2RF6wt19zGiplwY0Cyj43nLsqAd
 KDeZQ/zzQayNUYXxKNzPThfTXoPNwjjhhzw6W0y/j/fQwzd01OYjy7WKHL/x/0ahZzk2pByOsHi
 3ovGsRjPMA7DKPL5ZMSdIbH46Dyq79AO4bSjfbuMhn94EnnJbqSQmdLASAyAZ4FJZ/chhzkrg7L
 FC6PEsABdeCrSR4zTRJN7Tq6+h9Phr92gjjpuzdMJsFHKhAFB4pk+5GJ2y1DZVMl3ze0+GnRs+G
 PjvzboKsY/BasF2pN4MZikP7XnpdNkXjRXX7Tsw5JJir3Mz1dkezm+rvSAvAyBQjBAt8rJCK+Gg
 pYnXFmA/gTPd+7JnplKCtQo13TBMvTA12KG4owvacJajgU8cJx0ednkHZh3cB0qEG/VL66Jqsmm
 Z1EjeqP20qccNRCn+a
X-Received: by 2002:a05:7022:4a9:b0:137:f49d:3388 with SMTP id
 a92af1059eb24-1380670b402mr11382914c88.21.1781041702409; 
 Tue, 09 Jun 2026 14:48:22 -0700 (PDT)
X-Received: by 2002:a05:7022:4a9:b0:137:f49d:3388 with SMTP id
 a92af1059eb24-1380670b402mr11382888c88.21.1781041701863; 
 Tue, 09 Jun 2026 14:48:21 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:21 -0700 (PDT)
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
Subject: [PATCH 25/27] tests/tcg/multiarch: declare system tests
Date: Tue,  9 Jun 2026 14:47:43 -0700
Message-ID: <20260609214745.772536-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a288a27 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=8vYM-gic8w0O4C_0kjEA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: mVTyyAxCY8NHuvQndysQ0oScT9F3E4er
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNCBTYWx0ZWRfXzrCJmdwbJ61U
 CremoAUzSqrzPUnehG+BCIXSzg0LkM7AiZm/Ehn+FilmHr1ADgxFvp2fSx2a2DNGMiGwCQlyZr4
 lB6CzdGgf0YSYroGwSOan2KMFZh0EVifg87bq9SqDVAIujq5rI9X9JgFj96UmRr/vJw1W9wceRH
 dOTE+qbqmKg2DuGP0CuZjYHnaGQ/CqzdW4prWAh8jfTl1vS7YN+unyuRu7lbiQi6WBIYd4dpYFV
 vABkpHMjLB8b7NBXPOe1DOoUyUwh1hD1QohWhICxcskD8d/sq4naE6SdQBim71dMdIJr9avYQOJ
 IxMZWUYhJs1HqTDOvKPzsIsW2MEEnnv6Yh2BHcVKTNMdMY7uWiUuC7RlrUJ2PM9eaDFqgBknVsd
 ruTlSIBYGMgi3Ktvv2+CPWkOzTpm6q/rWouiyL/2rmeqgAeoe7nZFdT66ZENgYzV9WUnGc5/jHp
 tWF2V0/21NC8svbUoEw==
X-Proofpoint-ORIG-GUID: mVTyyAxCY8NHuvQndysQ0oScT9F3E4er
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090204
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

We now declare all multiarch system tests.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/meson.build        |  2 +
 tests/tcg/multiarch/system/meson.build | 53 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tests/tcg/multiarch/system/meson.build

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index 99af41b3fcc..508fdb585b7 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
 tests = []
 
 float_helpers = files('libs/float_helpers.c')[0]
diff --git a/tests/tcg/multiarch/system/meson.build b/tests/tcg/multiarch/system/meson.build
new file mode 100644
index 00000000000..f71c12db38e
--- /dev/null
+++ b/tests/tcg/multiarch/system/meson.build
@@ -0,0 +1,53 @@
+tests = []
+
+# multiarch src path are written to be included from any other arch folder,
+# so all arch can directly add those tests.
+multiarch = meson.current_source_dir()
+
+tests += {
+  multiarch/'hello.c': {},
+  multiarch/'interrupt.c': {},
+  multiarch/'memory.c': {},
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'gdb_test': ['--test', files('../gdbstub/memory.py')]
+  },
+  multiarch/'interrupt.c': {
+    'gdb_test': ['--test', files('../gdbstub/interrupt.py')]
+  },
+  multiarch/'hello.c': {
+    'test_name': 'untimely-packet',
+    'gdb_test': ['--gdb-args',  '-ex \'set debug remote 1\'',
+                 '--output', '/dev/stdout',
+                 '--stderr', '/dev/stdout'],
+    'wrapper': [prog_run_and_check_forbidden_output,
+                'Packet instead of Ack, ignoring it']
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'registers',
+    'gdb_test': ['--test', files('../gdbstub/registers.py')]
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'memory-access',
+    'plugin_test': {
+      'plugin': 'mem',
+      'args': ['region-summary=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-memory-counts.py')]
+  }
+}
+
+tcg_tests += {
+  'multiarch-softmmu': {
+    'tests': tests
+  }
+}
-- 
2.43.0


