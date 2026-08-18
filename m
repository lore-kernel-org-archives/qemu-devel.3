Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CC1C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPU4-0006SL-BI; Tue, 18 Aug 2026 15:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPU3-0006Mm-6b
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPU1-0007VK-86
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGtfq1006264
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=d9HRgcQ6OAu
 ONWSlsXFID75L/wWOCIWL709X7DGBLQI=; b=TnKONA3Mi5NtfuDUHmBZHPIkoX4
 dBiXJj5xq7W7CdaT0jKy/XMstKJVKiHWibwcwWH4nRIePpFrxkYc+7nwyGU05e+C
 UkFhqjuO5x6XDjZmYdGRZ2vWX9+v9Infpl6BCtiVgnc596H34i3UjaogWqAjhH6R
 HNJ3wJ5gqA3tzTdfGjqJrbUCdySWxqDRkoxA4PDVZWJQ0cyYfjQ3TafbAIl8g+9W
 B75JLtDDy6HuJxlhBbyS16KOiisfarbrpTzrf9Fwtyrj3hCHBSsUXDQPJPA2fHs8
 nnzahSxBoYTaYB3zTis4jTIZ4ec3gH67feNTxppPJKMeQDew5iXaqCbHRRQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4tkmrvnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so185894a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081293; x=1787686093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d9HRgcQ6OAuONWSlsXFID75L/wWOCIWL709X7DGBLQI=;
 b=ZbYr9sou1LLp8jX6HTtjCofvuE0/hwom71D6xeNK57LlTJ4RgO1lwUPIn5SC5nGLcD
 Xb9BjmDAMg0GnQws1dm02OA/9FxHdr2n9kltWk+LIfBsdfzkPvne8cYVLye8+z1FHiib
 u15tTRZHiKTy1MtCVF/Udo9lYR/tmRzQCdwfuD6/ipzdeFRQIMATzYAX/eNQ2lY83JES
 8L52/ufcC1/Lb2GOQ9S0LIZsDKmB5AyLTQCdPxDXCM995n738aLRNd/CNA61MdQQ+2s7
 zp0DTQBgpOAFrprBRDzgzYzgtZ7iPESyN28injtQjQ40l4K8iu+wJOQKnm1OyLLG+Whg
 7OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081293; x=1787686093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d9HRgcQ6OAuONWSlsXFID75L/wWOCIWL709X7DGBLQI=;
 b=Vq/PvNFlSdG8TgrMxVw692TRGqV2lXY4LvqcgDASXu1lUJiSnIYo8eKb3w9tCZ2D67
 reYaewZVhUCCGQ4UVaPekTbanxFvsa0ogcZAKO2ip/xQsh3+np49sgxkfBddxWWp8WRz
 WqXFL28whzO0hGlwEe+6aLJu1IioJctRlMsp5z61otXqyAON/UfA71yQSggi7U4FxvdB
 HQ3zgtRREp+2n5EduuSlXYEkS2d0F0yyzMmd3QeBN9WhnOAAniOV/th89XL4DzXCqqgt
 uo6ZRLjsPgUAXWEwm9k1RXCtCp1Sz61aQ5yUp0Lj0bfu1HlO2Z6I6hGdq7BL9nvQ2ebe
 /vbg==
X-Gm-Message-State: AOJu0YxagLl1Vfyuiu/khybpELjWArJt+K9ahfUKGR7b3x96QE8Hjyuk
 011s8U9mxyoPUEPg/g7r4K+4suKGBIUGx+t3KLmS95ffn2v9lzmwg8yMEfIrBKbJqFK0fHlEBrk
 BaD5fRD3GwlTRB4F0BZ5XUBExIajhifUDEnAo8jAzngSeHWg971s2SCcxoHzunpUFrQ==
X-Gm-Gg: AR+sD13RVICNUuVOONHLa6bAjrmCqD8Gn729sn/3oo5RS0WniVME6SesvOK6BttSrR0
 6U/dZI4o1hESU+HYZtSEL9BFyJ3xhOp/TH/ZT5+zbSKZA+xR99k4L2ue1AC4/ejUVqS8MipDHaH
 UC2BvfHiuF2+ziSW75KvGpXcqZcckZIwRtVaEBRXxy25R+ES8PxnBtX+WS2YA5LiwNIpnZTkWZy
 8EoiwqFRR2Dfkx6o8tIrViYoUV6Lkzptrj6q3s+3CHzlD9zJQH60cLvXNMSxhnb/r9kWdmu9lhf
 Cycd+u/HPLHVLqImhkYjwct+mkAB2wzJM83Elmv4uLwr6PuwqoifhTyWAy6dxCpT4uHlk3XRzB5
 efv94TbjzAjALL90dX2UnwqlcS4A9cog9ZkILnIZwTZuVZXZHT1tHlG4ERko=
X-Received: by 2002:a05:6a21:a512:b0:3c3:a3fd:db0a with SMTP id
 adf61e73a8af0-3ccff05e421mr195261637.16.1787081292856; 
 Tue, 18 Aug 2026 12:28:12 -0700 (PDT)
X-Received: by 2002:a05:6a21:a512:b0:3c3:a3fd:db0a with SMTP id
 adf61e73a8af0-3ccff05e421mr195198637.16.1787081292458; 
 Tue, 18 Aug 2026 12:28:12 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Song Gao <17746591750@163.com>
Subject: [PATCH v7 057/104] tests/tcg/loongarch64: user tests
Date: Tue, 18 Aug 2026 19:22:21 +0000
Message-ID: <20260818192309.22169-58-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7WJhKIwSDmqV
 u4j0Jj7nNhJtKhTNuX7a+3EunKTF+En4mdVyHGw7jq4iihK1GAPURENJ1YecVIx0Ere8zXARqWq
 uhKOGdxz7XBC1rOV65QAYa3/5K93fH/uPRjA4NDAOL71FkCI4L9+DItyQyuI2KWfvqVFEEeXTy9
 vdMcZOyDZX61+DxzMR/jfssc5xxNY3mvpvnZgN3B+hK0qdE1c81wMXYFgiT3tVeKhWYpPPqC6na
 I4DhetThFNsMt7m5wogaEzlQpjAZWnCcF9q456RRQeo/0NWESLTNUiQT6sMYIBkgoctHw3Vf+6n
 GwyPf91lHBr8LP4iBM2FzDxn57gJkX72bqBPDETuLLXZ7wNLUY5+JuqkvZEFA728vmD3PQayImq
 tlS50HUK8phGOD7PlN/qYKwW1VWhStcA4VpdVp0a9R1OoHYXBjdZwOia/ED5nqo1hNyau0E4CMd
 Hw+6nFrMHbdftiKJqAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX3P39/mgLLZos
 EGyws+MTcKYNjLXCh4BALzW69ObE7OplLcfzdeOrZXlqLLXBTk65w4GuvIlCLS+FXkQRwC3i3cW
 DilSuBk9h48n/D749rQEfJqRqjWnUxg=
X-Proofpoint-GUID: w_8yQpf1Z-Vc0Nap4Kymr8D99Jm05XSZ
X-Proofpoint-ORIG-GUID: w_8yQpf1Z-Vc0Nap4Kymr8D99Jm05XSZ
X-Authority-Analysis: v=2.4 cv=R+Mz39RX c=1 sm=1 tr=0 ts=6a84b24d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VnNF1IyMAAAA:8
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=Y62p6b28tDkMR5CZvOEA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Song Gao <17746591750@163.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/Makefile.target | 20 ------------------
 tests/tcg/loongarch64/meson.build     | 30 +++++++++++++++++++++++++++
 tests/tcg/meson.build                 |  1 +
 3 files changed, 31 insertions(+), 20 deletions(-)
 delete mode 100644 tests/tcg/loongarch64/Makefile.target
 create mode 100644 tests/tcg/loongarch64/meson.build

diff --git a/tests/tcg/loongarch64/Makefile.target b/tests/tcg/loongarch64/Makefile.target
deleted file mode 100644
index 00030a10266..00000000000
--- a/tests/tcg/loongarch64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# LoongArch64 specific tweaks
-
-# Loongarch64 doesn't support gdb, so skip the EXTRA_RUNS
-EXTRA_RUNS =
-
-LOONGARCH64_SRC=$(SRC_PATH)/tests/tcg/loongarch64
-VPATH += $(LOONGARCH64_SRC)
-
-LDFLAGS+=-lm
-
-LOONGARCH64_TESTS  = test_bit
-LOONGARCH64_TESTS  += test_div
-LOONGARCH64_TESTS  += test_fclass
-LOONGARCH64_TESTS  += test_fpcom
-LOONGARCH64_TESTS  += test_pcadd
-LOONGARCH64_TESTS  += test_fcsr
-
-TESTS += $(LOONGARCH64_TESTS)
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
new file mode 100644
index 00000000000..209179fd96c
--- /dev/null
+++ b/tests/tcg/loongarch64/meson.build
@@ -0,0 +1,30 @@
+cc = 'loongarch64-unknown-linux-gnu-gcc'
+cc_dockerfile = 'debian-loongarch-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_bit.c': {},
+  'test_fclass.c': {},
+  'test_fcsr.c': {},
+  'test_fpcom.c': {},
+  'test_div.c': {},
+  'test_pcadd.c': {},
+}
+
+if 'qemu-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4d74891a30b..70aaa86afbf 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -143,6 +143,7 @@ subdir('arm')
 subdir('hexagon')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


