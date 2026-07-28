Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F77DC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZoH-0006SG-PN; Tue, 28 Jul 2026 00:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo1-00064I-Ja
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZny-0002XJ-Lw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ajKC2692919
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ialOb4lBs31
 Xcoh12WvuYUT8J5a901A7R/KeRvPIz2g=; b=LYkMFTF8ichsuaZ27tl0HXnph8l
 GEXp3pKeHvueD8kadGxW1PEQjDzYmNG+wP7yYcljmKMhj9yUbl4l6OEN0KkVvXsd
 SjewhT1MXXbHzBA7FvbrvHM8F9qKO6exok/KaHtY0l1NRGqV5CX4gzTDUJgYvOT1
 hO6RNMcMcORyFyUUlowU5vELZriVxYhrRrTdq2OX5WUw/9iffR/hsc9wWHDQHQNs
 KMZy+iD01BLkQHX3Ixy2eRzMDZH6QVGNmdMxPbr3nsK1quOim+1IdWl0vde3rq9q
 nsCXuEYuFTcRODYbK/ZCYR72nTbA0nGP5HysQmRbGrgQg18BMGAxnXFU77Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5jffb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso50050065ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214356; x=1785819156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ialOb4lBs31Xcoh12WvuYUT8J5a901A7R/KeRvPIz2g=;
 b=I5LZQbkSHPAxSr8qlpqnjuBEKFUmabYvkp2obdGS7extLR1gQxlGfNCkTh1NdQS1hy
 OGbAdat5C8ae7CiIW0dIgQ6ORBYPRfwkdtdXwB2QRE8aSviDH9+ITpNJjrrK0riaNJS4
 PoE2sA/VrJ+nVXne55L1tcuqGgYp0Hi+QPhFIXXoSEJlXyBBu8xVAlyHOE4C3G8KVkwF
 YVVUYACT7aiRCtwg72Pn1y4jEFB6DJ/9mMoyxr7lcg7C/qs8f1iFCFx61S/mI6OVuS6w
 qIIMMS4HzXqg423mk1OMcXnU9Ktd/i6oZO7xRlhvz2dikS8ELeVOiyKcHhF2jCOrPSMR
 6Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214356; x=1785819156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ialOb4lBs31Xcoh12WvuYUT8J5a901A7R/KeRvPIz2g=;
 b=jQGm19zANjmrgdylW2bDg+KSx/qOHl032oZUAN93CupBUjHIjkDfAF67Aoe6b847z9
 h0REWmMmtVnv1bP440eMWFFrqPOwcDgid2e4O3gpr8PJUDFvk9teoXsAfMw73UiREJKz
 +iw2Vg2BHelFH/MbDvSfvhVGDGT8Wn5r8N4IdDIxzCAuhVdaaE1+liJRKnzcAxYGDATi
 5kOU+Y/g+izaLBBND2nEfSS0RmGDKK+4FsiM1k9MQv/lj3r4kE2HoKOEClqoC5mfzlPm
 LG5ZclJUoWWrHyKbRAM5SEnJIdiHqGSuBVBwVtBb6I6JLs82e6PuUHUiU4nAZOCILuxF
 51dg==
X-Gm-Message-State: AOJu0YyfJTslIsKIM9KnBytxa6xOrRdpwukT1JOeieyfX0Qs7Kl2L9M4
 WYt070+QJ4I7Tb26JJxwEYKk4FIfQu5jAT/qE1HjfmdkXv6heMiEjgYmdilY/Fl+mKw36P/k5Hj
 xccpwTvfAgaKW2azS30vlfP/xLAmOWSQ180WEpoVay3PX5kNB3lW6mVazeDwRhB6ZCw==
X-Gm-Gg: AR+sD13bZjWNKK5AZ/YkHD+am/ZpXQ6EvuBY7wF60nvfbme/NDxqSkHzfukyyEAsYyo
 TnLN7BVAmoCdUNwICqJS9fgSJb57LlQCiGPTpXSUzg7vKVNSK0l9ueTr9s272HnG16wvfr9Dadp
 t7AlaeLWytbWsx9tD8CqnC3TvCDl9lQ7pBi3qhW9VLKRHwUqR/NG7MxrobYQBVtYGKsddaZnBBc
 bbPrOIHRdvk5EVUATA7qKnQHJUhSexlBoAFaK9M+mAjkROZLnFlRTpKQaOJnEVr4su4lRqOguOO
 DOovqE0QsonXJibrSgVtoLMPbtawh4bQdXKyuAnmmOALasJdWL7pa/aa0kKwgej2sqHme6nCPcr
 o8IpIFxdfh00o0V0+dThV1qyBwRkdlCOUx59clbiTYeUUdGYNRkd2Bf52Gk1MzFHKczEctGU=
X-Received: by 2002:a05:6a20:7343:b0:3c3:9a7f:72fd with SMTP id
 adf61e73a8af0-3c8ba5ac31cmr1152977637.44.1785214356495; 
 Mon, 27 Jul 2026 21:52:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:7343:b0:3c3:9a7f:72fd with SMTP id
 adf61e73a8af0-3c8ba5ac31cmr1152949637.44.1785214356072; 
 Mon, 27 Jul 2026 21:52:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:32 -0700 (PDT)
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
Subject: [PATCH v6 088/103] tests/tcg/tricore: system tests
Date: Mon, 27 Jul 2026 21:42:32 -0700
Message-ID: <20260728044248.137626-89-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfXzzSdCeBjDGfQ
 y2LkUMBb0QE7KvgWbYDqXLYWpP9qwWs8fgMj5RlfOKVSPbbMMYBWvjYG8FVvmpxlymWOfAL7reJ
 bfMDE4YdJWUlLdkLrMmkvpInX+9RyMQ=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a683595 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=4feyZHKGdxcD__gy_rYA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX/mFZq//MARmx
 Iu5w1Oq4APCPhWyNQkm4ORLBpgO7dhE6dBLbON7KnCdaj0k7vZfjCVCojmzUWTVK/er5gPAFyW5
 XDOkSlUP5JQT2q6mIP1111BJ6IVLkK6Sxx8W2NskZvSpm8Je39TNzhlOa5tekUx7ZAQw0JwTelm
 x6GUCnYPosmZZuO3Z7u9hKTJXHvoLzmuLRMc1+zz/8rW9ec1oMp1jVmLp38hMnw7ZLlTA+0TN13
 7Y37tI+RF0u6nGy1152lHazbGSWKVHyTa7ZD+t7IObG2ToqdvoDgswkWU48U6xxzwEob9w7+h88
 pqcUy7/DiQa0NvN/gc7KgQwpZWiqomf/hIG3Ypa/qsH8v728RxpbzylDPqr4eh5ZC/CgiN3SjkD
 KW8Z5GwZBCXVglhd6aIW4RoTDpwgP+bcFpPoLGDW0kMMsRFP3R6e7Ks1VL2a2vL2QF98H7Ldu0V
 tO/IOuxOcjKnMp4k29g==
X-Proofpoint-ORIG-GUID: 0GoWc8-qZXTRu8MWRJFU3csquZGjU-Gm
X-Proofpoint-GUID: 0GoWc8-qZXTRu8MWRJFU3csquZGjU-Gm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                     |  1 +
 tests/tcg/tricore/Makefile.softmmu-target | 53 ---------------------
 tests/tcg/tricore/meson.build             | 57 +++++++++++++++++++++++
 3 files changed, 58 insertions(+), 53 deletions(-)
 delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 create mode 100644 tests/tcg/tricore/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5a132d9021e..992913fa21c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -154,6 +154,7 @@ subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
+subdir('tricore')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
deleted file mode 100644
index 258aeb40ae8..00000000000
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ /dev/null
@@ -1,53 +0,0 @@
-TESTS_PATH = $(SRC_PATH)/tests/tcg/tricore
-ASM_TESTS_PATH = $(TESTS_PATH)/asm
-C_TESTS_PATH = $(TESTS_PATH)/c
-
-LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
-ASFLAGS = -mtc162
-CFLAGS = -mtc162 -c -I$(TESTS_PATH)
-
-TESTS += test_abs.asm.tst
-TESTS += test_bmerge.asm.tst
-TESTS += test_clz.asm.tst
-TESTS += test_crcn.asm.tst
-TESTS += test_dextr.asm.tst
-TESTS += test_dvstep.asm.tst
-TESTS += test_fadd.asm.tst
-TESTS += test_fmul.asm.tst
-TESTS += test_ftohp.asm.tst
-TESTS += test_ftoi.asm.tst
-TESTS += test_ftou.asm.tst
-TESTS += test_hptof.asm.tst
-TESTS += test_imask.asm.tst
-TESTS += test_insert.asm.tst
-TESTS += test_ld_bu.asm.tst
-TESTS += test_ld_h.asm.tst
-TESTS += test_madd.asm.tst
-TESTS += test_msub.asm.tst
-TESTS += test_muls.asm.tst
-
-TESTS += test_boot_to_main.c.tst
-TESTS += test_context_save_areas.c.tst
-
-QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -kernel
-
-%.pS: $(ASM_TESTS_PATH)/%.S
-	$(CC) -E -o $@ $<
-
-%.o: %.pS
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.asm.tst: %.o
-	$(LD) $(LDFLAGS) $< -o $@
-
-crt0-tc2x.o: $(C_TESTS_PATH)/crt0-tc2x.S
-	$(AS) $(ASFLAGS) -o $@ $<
-
-%.o: $(C_TESTS_PATH)/%.c
-	$(CC) $(CFLAGS) -o $@ $<
-
-%.c.tst: %.o crt0-tc2x.o
-	$(LD) $(LDFLAGS) -o $@ $^
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
new file mode 100644
index 00000000000..d0bf55dedce
--- /dev/null
+++ b/tests/tcg/tricore/meson.build
@@ -0,0 +1,57 @@
+tests = []
+
+link_script = files('link.ld')[0]
+crt0 = files('c'/'crt0-tc2x.S')
+asmflags = ['-Wl,--mcpu=tc162',
+            '-Wl,-T', link_script,
+            '-mtc162',
+            '-nostartfiles']
+cflags = [asmflags, crt0]
+qemu_args = ['-display', 'none',
+             '-M', 'tricore_testboard',
+             '-cpu', 'tc37x',
+             '-kernel']
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+setup_asm = {'cflags': asmflags, 'qemu_args': qemu_args}
+setup_c = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'asm/test_abs.S': setup_asm,
+  'asm/test_bmerge.S': setup_asm,
+  'asm/test_clz.S': setup_asm,
+  'asm/test_crcn.S': setup_asm,
+  'asm/test_dextr.S': setup_asm,
+  'asm/test_dvstep.S': setup_asm,
+  'asm/test_fadd.S': setup_asm,
+  'asm/test_fmul.S': setup_asm,
+  'asm/test_ftohp.S': setup_asm,
+  'asm/test_ftoi.S': setup_asm,
+  'asm/test_ftou.S': setup_asm,
+  'asm/test_hptof.S': setup_asm,
+  'asm/test_imask.S': setup_asm,
+  'asm/test_insert.S': setup_asm,
+  'asm/test_ld_bu.S': setup_asm,
+  'asm/test_ld_h.S': setup_asm,
+  'asm/test_madd.S': setup_asm,
+  'asm/test_msub.S': setup_asm,
+  'asm/test_muls.S': setup_asm,
+  'c/test_boot_to_main.c': setup_c,
+  'c/test_context_save_areas.c': setup_c,
+}
+
+if 'qemu-system-tricore' in emulators
+  tcg_tests += {
+    'tricore-softmmu': {
+      'cc': 'tricore-gcc',
+      'cc_dockerfile': 'debian-tricore-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'folder': 'tricore',
+      'gdb_arch': 'tricore',
+      'qemu': emulators['qemu-system-tricore'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


