Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B135C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSc-0000Dc-OM; Thu, 27 Aug 2026 18:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSP-0007Kc-Cp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSM-0007aG-KE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM6GN1803764
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=B8PIYzUPGrn
 h9ZlIQ+5ceZdzxfZXxRrnzNbAp7M2M4g=; b=iPPGNSn/l/BgDksugZ3hksDA0qJ
 EcMIDisupTN689vsoyuyztPj+E/Vu+dVM1apGIyioabwjUBZ9FVNSM4rYc1im5kW
 jAIqpqsQP4V5MHYG8P102r7syYAe4Wvvt99McQfpN3qKG9divESLn24xcaITclAf
 2Hnkb6U8c36orFPxcYb63WKclqmXcUD5uobxu/lkxYDMRFieqjFTQ/fxv998C+gH
 W4xPKwR0oMuHQyyFBSp0856YXE4S+I8Mp/cpmHpzQMGJYmtaBzApy7IpvQuRB6v2
 so/lntQZDoeOIwV/38ik02ROamdcprikcRAyEvHoJGdFIF5XjwBQhcRqtiQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgvmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so339486a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869210; x=1788474010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B8PIYzUPGrnh9ZlIQ+5ceZdzxfZXxRrnzNbAp7M2M4g=;
 b=kH0wUb3gLVJ0+2pdivm/WMQKw/S5M+qmLZZti4fQy/JPgiG0V6UDOy0FYChoQ6gcFA
 UapRzcGtYbz6p6t3IW0/gCSnrZlUFt/dQDEcnNH1x2ICSxadmVuplrkfytLI4yjF/9mB
 tD7z/Tz1vcGFWjiAXtGEeK5HD2uOFrGGOnXDcWPmFjtD9+Tx+cPwrgdU+ma7x9FXE7RM
 WP6PACfC01vH44wO3PjbbPLD3iJjqIFtZehBpyOutiO3g1Zc/nDoMjo1mJVvzLlzlkaZ
 Xj/IByIWCOkpSno7wKxMWQvT3AXroxU17Aw9Nkh9bmmKHLfDHDgfSKfuLeX2i/fnqpo0
 sEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869210; x=1788474010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B8PIYzUPGrnh9ZlIQ+5ceZdzxfZXxRrnzNbAp7M2M4g=;
 b=X7T4GNoe5ZD/2jKffxx0W3h6F8JK/4iGS9Rph9YG+ZwNWTHOA5W8rTsIJh6lbajo+0
 hsaJaDvxsd4GXvDJkUFBW/r/SIiqw0BNt1IH1JCGJ+JZkPR1w15J8Zy6E0SjKJp+GCVr
 jWZmdYIHYi5oos0YrJ3AalXr8zNf/LF2wgqUOyr/JbaixGSWWk66L4Qy/tHpYoRXntJZ
 ly8tzP72elFQRpBnm1tT6GVw1LIdanWEDo0m4hfL8g5qjKt2aAb2qY9VlxyZxRovbYcR
 MG0enFX9DRwlTiU6iVKqwMaaknWqoL2R6pLn0mWVdgZjEFQZ9BJiPbURITzouMWlk0YZ
 OVKA==
X-Gm-Message-State: AFuF++kVSFNDsJkjQ9VX3Qw5L+kgxKpfO9Z3Xlm4szLrtyqgFMMmmEpR
 Y82+bs9OCkDPM+rmgRbf3LqxskMx+hj4EJSBqVUPOp++Pxrrc6DQcXn0+yX0Lk7seIEqj/IPW/T
 INxZQQq8pgMp7qnda0OkZlfWKAlAAjR0Ui6MOEANQQd8E5lXVwDp/1FzEHPoF8VDdxg==
X-Gm-Gg: AR+sD12cqYvOzNt3P8zvW0ufG55mdyyL8khXmpX/YnzbdpM46SxMtlYFMz2Hnd1DDkT
 6C1eohEtM9bAx1PMY5oC6aHnDmS+vntLOIhNOFA6LFn/UFDZQQVKOA06df0tPI4FJaaQpAspGjI
 UXbmy9nXXP7wqS3qKZ6UkrFlK1qqMNVS9R1S168l3L4pQ8CYFcPfKJcYsU9CW81d4vezGIrmEmc
 qlWQ1eCVDau5X8q33WS1FAEar+ZrtHfYLyOoNJcOEKKlWxK4MykGV5R98BZmuffzwsAOUDqjxpu
 j+sJmGlBcsW1ILRazRj20vBWwGO7bPr3Frx+njCu76NmfTJL7FulvzPEGJWBvjCZwBnVd75ggEV
 jbKnx76B+zJDQn9EpWga8dznraxOKWeyp/p7fbJccBd5y3thMfEVvGYdScic=
X-Received: by 2002:a17:90a:dfd0:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-396d0fccf78mr4748003a91.13.1787869210233; 
 Thu, 27 Aug 2026 15:20:10 -0700 (PDT)
X-Received: by 2002:a17:90a:dfd0:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-396d0fccf78mr4747860a91.13.1787869209714; 
 Thu, 27 Aug 2026 15:20:09 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:20:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 076/105] tests/tcg/ppc64: user tests
Date: Thu, 27 Aug 2026 22:14:37 +0000
Message-ID: <20260827221506.91574-77-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b81a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=7oZrJYRkATaSZigH0PwA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: jB5UqlzFCIk1QAQ9uqukEV5g80f5bqw4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX9apZQv3qZYyW
 wpgwmHuCVZqZ7oqR1ZdZV3WTlhyxF0PVXvgiqxmpN6RkaihEhoLnrmq3AUxy4dMjStMpLs6bmmU
 dnnZ8J520eqYsQhTATaWyIZXIj0wZm0F8O8QnKEL0ItqExa11hn4ThWqgtYdVnQcMyXfk4t1fsc
 2KlKtri0kftsr9UjgWDzUog3GS8Gx5JHXastJQ0UuFvo+oKn62DlZCQB8rGfSgbu6+gOrz2J35L
 xXnvBFZMYNM0KH2uMs5ibfmjvEU4V974tLeb04RfDsGCaZzT33u1uY4tfrSLJYYpSZZACpox4uf
 g7jdK7dN6rfDyKayGdTvDUpcY2//XLhkD4tbb+KkoOFDCROunofMg/JKu3Li5I/WDoj8wyfKQvG
 WyEAmsI0417rL5Z5hjCxO1iFGizG3q9rXIWCopfTmJIEe7EqJqo7AO3br5kLJaV1qAgRtJiGCfQ
 uaDtGLLnvMomObJSdvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX9yG4tBNWdo91
 3eAAjAM9WWnLY6oVVNaOjNg7S6aleQaZKHQspvBo5PMdkgtkVyLH58vbeW7Nc0+xx1YZFPPImMJ
 FouKK8HBb7W+M0iE0dgVCwimcTLga1I=
X-Proofpoint-ORIG-GUID: jB5UqlzFCIk1QAQ9uqukEV5g80f5bqw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             |  1 +
 tests/tcg/ppc64/Makefile.target   | 63 -------------------------------
 tests/tcg/ppc64/meson.build       | 56 +++++++++++++++++++++++++++
 tests/tcg/ppc64le/Makefile.target |  4 +-
 4 files changed, 59 insertions(+), 65 deletions(-)
 delete mode 100644 tests/tcg/ppc64/Makefile.target
 create mode 100644 tests/tcg/ppc64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d6406b5cb59..1d1986f5c1b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -149,6 +149,7 @@ subdir('mips')
 subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
+subdir('ppc64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
deleted file mode 100644
index 0d058b26006..00000000000
--- a/tests/tcg/ppc64/Makefile.target
+++ /dev/null
@@ -1,63 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ppc64 specific tweaks
-
-VPATH += $(SRC_PATH)/tests/tcg/ppc64
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-mcpu=power8,      CROSS_CC_HAS_CPU_POWER8); \
-	    $(call cc-option,-mpower10,         CROSS_CC_HAS_POWER10)) 3> config-cc.mak
-
--include config-cc.mak
-
-# multi-threaded tests are known to fail (e.g., clang-user CI job)
-# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
-run-signals: signals
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-run-plugin-signals-with-%:
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-
-run-threadcount: threadcount
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-run-plugin-threadcount-with-%:
-	$(call skip-test, $<, "BROKEN (flaky with clang) ")
-
-ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
-PPC64_TESTS=bcdsub non_signalling_xscv
-endif
-$(PPC64_TESTS): CFLAGS += -mcpu=power8
-
-ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
-PPC64_TESTS += vsx_f2i_nan
-endif
-vsx_f2i_nan: CFLAGS += -mcpu=power8 -I$(SRC_PATH)/include
-
-PPC64_TESTS += mtfsf
-PPC64_TESTS += mffsce
-
-ifneq ($(CROSS_CC_HAS_POWER10),)
-PPC64_TESTS += byte_reverse sha512-vector vector
-endif
-byte_reverse: CFLAGS += -mcpu=power10
-run-byte_reverse: QEMU_OPTS+=-cpu POWER10
-
-sha512-vector: CFLAGS +=-mcpu=power10 -O3
-sha512-vector: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-sha512-vector: QEMU_OPTS+=-cpu POWER10
-
-vector: CFLAGS += -mcpu=power10 -I$(SRC_PATH)/include
-run-vector: QEMU_OPTS += -cpu POWER10
-
-PPC64_TESTS += signal_save_restore_xer
-PPC64_TESTS += xxspltw
-PPC64_TESTS += test-aes
-
-# ppc64 ABI uses function descriptors, and thus, QEMU can't find symbol for a
-# given instruction. Thus, we don't check output of mem-access plugin.
-run-plugin-test-plugin-mem-access-with-libmem.so: \
- CHECK_PLUGIN_OUTPUT_COMMAND=
-
-TESTS += $(PPC64_TESTS)
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
new file mode 100644
index 00000000000..c7e495f3d34
--- /dev/null
+++ b/tests/tcg/ppc64/meson.build
@@ -0,0 +1,56 @@
+cc_feat_cflags = {
+  'power8': '-mcpu=power8',
+  'power10': '-mcpu=power10',
+}
+
+tests = []
+
+# Multi arch tests
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    # ppc64 ABI uses function descriptors, and thus, QEMU can't find symbol
+    # for a given instruction. Thus, skip this test.
+    if fs.stem(src) == 'test-plugin-mem-access' and 'wrapper' in setup
+      continue
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  '../ppc64/bcdsub.c': {'cc_feat': 'power8'},
+  '../ppc64/byte_reverse.c': {'cc_feat': 'power10', 'qemu_args': ['-cpu', 'POWER10']},
+  '../ppc64/mffsce.c': {},
+  '../ppc64/mtfsf.c': {},
+  '../ppc64/non_signalling_xscv.c': {'cc_feat': 'power8'},
+  '../ppc64/signal_save_restore_xer.c': {},
+  '../ppc64/test-aes.c': {},
+  '../ppc64/vector.c': {'cc_feat': 'power10', 'qemu_args': ['-cpu', 'POWER10']},
+  '../ppc64/vsx_f2i_nan.c': {'cc_feat': 'power8'},
+  '../ppc64/xxspltw.c': {},
+  '../multiarch/sha512.c': {
+    'exe_name': 'sha512-vector',
+    'cc_feat': 'power10',
+    'cflags': ['-O3'],
+    'qemu_args': ['-cpu', 'POWER10'],
+  }
+}
+
+# export tests for ppc64le
+tcg_tests_ppc64 = tests
+
+if 'qemu-ppc64' in emulators
+  tcg_tests += {
+    'ppc64-linux-user': {
+      'cc': 'powerpc64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'ppc64',
+      'gdb_arch': 'ppc64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-ppc64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/ppc64le/Makefile.target b/tests/tcg/ppc64le/Makefile.target
index daad5118a56..00a0cdba295 100644
--- a/tests/tcg/ppc64le/Makefile.target
+++ b/tests/tcg/ppc64le/Makefile.target
@@ -2,6 +2,6 @@
 #
 # ppc64le specific tweaks
 
-VPATH += $(SRC_PATH)/tests/tcg/ppc64le
+#VPATH += $(SRC_PATH)/tests/tcg/ppc64le
 
-include $(SRC_PATH)/tests/tcg/ppc64/Makefile.target
+#include $(SRC_PATH)/tests/tcg/ppc64/Makefile.target
-- 
2.43.0


