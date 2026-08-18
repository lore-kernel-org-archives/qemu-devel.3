Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C619FC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTe-0003pQ-66; Tue, 18 Aug 2026 15:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTZ-0003dx-F8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTX-0007RE-6a
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH1c51006318
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dBnnSlMW0Kw
 vNswNebjMM6kjD+A+lIzU6txmm1jnQ+o=; b=nzBUhHipGgBF3VCBP5ofjcQyZpz
 PyMWlA16k3ZYSJYQ+4AkLZymivoMo2rjPAfpP7KIpC2RADtKrXAWSIfb/lVB9Eed
 oVPCtbKa5KFGMW4CmuUlNbvmtevs1fyVumGVp+GJvxJloChWt6uJLyZczTj0eYTW
 kz6SLoAwm6iU117qTeL8oosDPY103dV7PZbU2gk/pW5b5gvP8G3g7om74qc10iZU
 2YBnF+i304SNzeVAhO4YW50Hw0cJaLj5ErFGPOdstDe5ANR73gAvppbQeNI1CGDB
 K1wOF8+k0Jdlh1RYgdeKpiUZZKcLrrezMTaui193UoMNkizwxTyub6ZGIjQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4tkmrvma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so552025a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081272; x=1787686072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dBnnSlMW0KwvNswNebjMM6kjD+A+lIzU6txmm1jnQ+o=;
 b=YTA6ly/ZtE0gnbQqisyAD2IyUAiX68rwU84Oxj7sPkJN/Gk0dRTwZL0lP4OZm3hQAY
 OudRyCsnwHdQtLh9+Y1tlTm2UZHijLrdRlqjnBrZhi+dIUGSJ4JDNtFmM+YEV20y8KbY
 XbTQxebahSmIdGET+wbBcwIStGECbJA9crJrnfgZqqlYoyuZ9zJcoP45cTMshVozajiI
 S4aLHK+xeNDoL5yaoE7UzxILAr+Og8dz+7vqbkVF88eLzKW39sKjCeTS1LWDearTZqiL
 PnbDijvz58wCkqF42XwtRJ5JO0Jnm+CAzS6cBA1pTJoB04vTqbXkuuM+cn+ZXvoVcbJZ
 27oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081272; x=1787686072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dBnnSlMW0KwvNswNebjMM6kjD+A+lIzU6txmm1jnQ+o=;
 b=KzMgrfrUVaEpUWOh/GrnQdA5ZxKST/LPMS0wRdz4FxjhEuD+1z6ybTy1YhqrPCSBKk
 Gsa0EDB2Croy5oO1YSRQiVhfm3MMnODAHsPe/ESEMdfntsFhMSHzokFw7gelw+2mNPC1
 yyc4bVhOR2vDbi8auZuxVPS4i8YkmLrGApS4Vl8klrj9PWdbIwNehYondl52XyqR3Hls
 Wt4yJW+B33UqEBepY0eZPbYfrhD9DmRgrAd5UxP4/s4XqOzSf7/0/j9mquPwYLVMqVjf
 NlMOncQ4x0tIzSLdZ+LuQptCll6WBs8COqmmZrk0PMw4SM7oWZx1XmkISEV7IHNm24zW
 QEjg==
X-Gm-Message-State: AOJu0YxEb07n7foMsJuNZ2dGewIK8sUm13efRozK/6sCV9OiqUb3f26H
 8Sayefz+6VI3PNsPPcmRu39u++Z5uZjiwd1VV13nTn0JblR2Q5/CD5atHv3/7GZiKHS8ALyjGV8
 3yy2gdpRZeXDkYTU25m4RQ/aPtFGo2Rd1/nqw+3MsHqhvX/K5+7ltQRGg8gmVgjKdnA==
X-Gm-Gg: AR+sD12BpwS4vDtuGgISMSj7D0/WbHmrMsfTz1Jp8H7uDcSGM4+yfEZOR55rAycGpbR
 apnNvu2EMx/SYk1Imy0zAzDZ8uMOQUKkRQCiktJKuUI2EGGyec06NNmcWMOGIlDcVVGjGqrENbI
 DGBVxs78nHlj0x7arTLBBAMS6HAuFgZfCHp20BhLsvhGtshdwMBQx1b37W6KGWhfzmAR+5sCxdR
 EJa85/JjBTGTLc6ZKOZ5+Af3pcIy7VB34hr0eS4WxOifj6NWT+DF41PnPMmpjtTMAqztEUn0So7
 ctaRcj4pBTI58lqMn5eLjnBZI8lgJhrjOjd1HEBiRXJ+TFRl/tZwRg9/cmEQ7YTZcJNwYg+XQSF
 iT5LdBJmWy3gKxDTajUfzI1E95R+UFXGF/+vVUeCozq92qofHy0PwpB/8Omw=
X-Received: by 2002:a17:90b:5102:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-3957b29774bmr106063a91.8.1787081272362; 
 Tue, 18 Aug 2026 12:27:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5102:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-3957b29774bmr106005a91.8.1787081271900; 
 Tue, 18 Aug 2026 12:27:51 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:51 -0700 (PDT)
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
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 047/104] tests/tcg/arm: user tests
Date: Tue, 18 Aug 2026 19:22:11 +0000
Message-ID: <20260818192309.22169-48-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXwUFqv1RuQeTx
 LteTr/rVWd5PNYmSplCgl2WVhzmmfvLayv93H3+gPReIqGCBiJ4k4wkfKCy5l5+Dmn3gCPl0f6F
 G5DtBYNQ1DAek1k4x6J6VSenVOMm6pm98tkIWeqIAE79nqd6DmYcqrXrah/TAoY2II+RagWbAII
 MGTa6ThWWNmTw1TCyKCaB+rJDWkttSVyoAt+X1VkusSofhSZujuQo6yVeiYDdiyOuc2iFPz/Ik1
 bZL0+42zftS9XpEdGNoiX1IH6EobjRv0vJ3ISlaQ48oWdgevZ1/axZPMod+9czHJdMPPPeUbQq1
 uPdv0g6JimGIf3jw/gRp6wf8qDgU4J5FVYqTtcXM1jGYkqqOh3N9JMgouvzYINkYGa6IYkI/Pzk
 4s0K3Ugb1SK32zTAmljgvM7A0rsHxQR+sYYR1tO/kE8kyOsitqW50DS82CCljklqmZZmqZ8j2fn
 PnsOC6E5yE+ycj33QtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXzuRXTmeu2Rjr
 maN9l2RSQ4bcZrpm5nSNPpUGo3JbrrKjV4ISqSaEkh+JkhV7OWk5K8uOMMP15Nw9JgClxYwsBc4
 /yl6HDRJT/cMCZU0D3ewkA5X2/ES4xo=
X-Proofpoint-GUID: LEC6j03pvnO-CUrqpZT6-Q_vBvPqOMV8
X-Proofpoint-ORIG-GUID: LEC6j03pvnO-CUrqpZT6-Q_vBvPqOMV8
X-Authority-Analysis: v=2.4 cv=R+Mz39RX c=1 sm=1 tr=0 ts=6a84b239 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=RSOb7l6czOOF-PCRW5oA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/arm/Makefile.target | 87 -----------------------------------
 tests/tcg/arm/meson.build     | 78 +++++++++++++++++++++++++++++++
 tests/tcg/meson.build         |  1 +
 3 files changed, 79 insertions(+), 87 deletions(-)
 delete mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/meson.build

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
deleted file mode 100644
index 613bbf0939a..00000000000
--- a/tests/tcg/arm/Makefile.target
+++ /dev/null
@@ -1,87 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ARM - included from tests/tcg/Makefile
-#
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm
-
-# Set search path for all sources
-VPATH 		+= $(ARM_SRC)
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-fno-integrated-as, CROSS_CC_HAS_FNIA)) 3> config-cc.mak
--include config-cc.mak
-
-float_madds: CFLAGS+=-mfpu=neon-vfpv4
-
-# Basic Hello World
-ARM_TESTS = hello-arm
-hello-arm: CFLAGS+=-marm -ffreestanding -fno-stack-protector
-hello-arm: LDFLAGS+=-nostdlib
-
-# Float-convert Tests
-ARM_TESTS += fcvt
-fcvt: LDFLAGS += -lm
-fcvt: CFLAGS += -march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
-run-fcvt: fcvt
-	$(call run-test,fcvt,$(QEMU) $<)
-	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
-
-# PC alignment test
-ARM_TESTS += pcalign-a32
-pcalign-a32: CFLAGS+=-marm
-
-ifeq ($(CONFIG_ARM_COMPATIBLE_SEMIHOSTING),y)
-
-# Semihosting smoke test for linux-user
-semihosting: CFLAGS += -mthumb
-
-ARM_TESTS += semihosting-arm
-semihosting-arm: CFLAGS += -marm -I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-semihosting-arm: semihosting.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-semihosting-arm: semihosting-arm
-	$(call run-test,$<,$(QEMU) $< 2> $<.err)
-
-ARM_TESTS += semiconsole-arm
-
-semiconsole: CFLAGS += -mthumb
-
-semiconsole-arm: CFLAGS += -marm -I$(SRC_PATH)/tests/tcg/$(TARGET_NAME)
-semiconsole-arm: semihosting.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-run-semiconsole-arm: semiconsole-arm
-	$(call skip-test, $<, "MANUAL ONLY")
-
-endif
-
-ARM_TESTS += commpage
-
-# Vector SHA1
-# Work around compiler false-positive warning, as we do for the 'sha1' test
-sha1-vector: CFLAGS=-O3 -Wno-stringop-overread
-sha1-vector: sha1.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-run-sha1-vector: sha1-vector run-sha1
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<)
-	$(call diff-out, sha1-vector, sha1.out)
-
-ARM_TESTS += sha1-vector
-
-# Vector versions of sha512 (-O3 triggers vectorisation)
-sha512-vector: CFLAGS=-O3
-sha512-vector: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-ARM_TESTS += sha512-vector
-
-ifeq ($(CONFIG_PLUGIN),y)
-# Require emitting arm32 instructions, otherwise the vCPU might accidentally
-# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
-test-plugin-set-pc: CFLAGS+=-marm
-endif
-
-TESTS += $(ARM_TESTS)
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
new file mode 100644
index 00000000000..08a863699fb
--- /dev/null
+++ b/tests/tcg/arm/meson.build
@@ -0,0 +1,78 @@
+cc = 'arm-linux-gnueabihf-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags = setup['cflags']
+    endif
+    if fs.stem(src) == 'float_madds'
+      new_cflags += ['-mfpu=neon-vfpv4']
+    elif fs.stem(src) == 'test-plugin-set-pc'
+      # Require emitting arm32 insns, otherwise the vCPU might accidentally
+      # try to execute Thumb insns in arm32 mode after qemu_plugin_set_pc()
+      new_cflags += ['-marm']
+    endif
+    if src not in multi_src
+      setup += {'cflags': new_cflags}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'commpage.c': {},
+  'hello-arm.c': {
+    'cflags': ['-marm', '-nostdlib', '-ffreestanding', '-fno-stack-protector'],
+  },
+  'fcvt.c': {
+    'cflags': ['-lm', '-march=armv8.2-a+fp16', '-mfpu=neon-fp-armv8'],
+    'expected_output': 'fcvt.ref',
+  },
+  'pcalign-a32.c': {'cflags': ['-marm']},
+}
+
+# Vector SHA1
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+tests += {'../multiarch/sha1.c': {
+            'exe_name': 'sha1-vector',
+            'cflags': ['-O3', '-Wno-stringop-overread'],
+            'expected_output': '../multiarch/sha1.ref',
+         }}
+
+# Vector versions of sha512 (-O3 triggers vectorisation)
+tests += {'../multiarch/sha512.c': {
+            'exe_name': 'sha512-vector',
+            'cflags': ['-O3'],
+         }}
+
+# Semihosting tests
+semihosting_cflags = ['-marm', '-mthumb', '-I', meson.current_source_dir()]
+tests += {
+  '../multiarch/arm-compat-semi/semiconsole.c': {
+    'cflags': semihosting_cflags,
+    'wrapper': [prog_run_with_input, 'X'],
+  },
+  '../multiarch/arm-compat-semi/semihosting.c': {'cflags': semihosting_cflags},
+}
+
+if 'qemu-arm' in emulators
+  tcg_tests += {
+    'arm-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'arm',
+      'gdb_arch': 'arm',
+      'qemu': emulators['qemu-arm'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e0789d9c1eb..17f48bebf98 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -139,6 +139,7 @@ endforeach
 subdir('aarch64')
 subdir('aarch64_be')
 subdir('alpha')
+subdir('arm')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


