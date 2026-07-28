Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69294C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZoD-0006Lm-O3; Tue, 28 Jul 2026 00:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnt-0005q5-L6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnp-0002WW-Vy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40gaH1593624
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dAUiB4CUPZK
 KZQDwmPYpXaLpmwtkThLdK09eGkJYNBU=; b=ooDeKrzh3i3mRIHcXWbxhwuNR62
 Qy+XxbTS9DL4L22N4HCQkct69gxUN/KaSemqMr/dIx5C90Pb2nbCdKyTJImHdauR
 aXdD2g9WF2E4bkhp2IktoFqAE/O1aOWbLeAQA/nb95QUii4WGIWtXe5A6DdM/ozY
 /qKp6ha71FSyUL0Bp9Z/L0j04CLsuLZewLCtAzlkPIHMUFz3Gqee/KxX93Tq9rTd
 t47XQHgTqSXJkdc+JC2DhAHtbz+zrH/o98gUbg8JTj8TngD/8nNXf8ha1JsapNO/
 lUkWpBIAHN+fbrLkXiSBk4ICMc8p4OMfgS+PldW8AFS6V8vymZiHbmkrszQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g53m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85798977dcso5270697a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214347; x=1785819147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dAUiB4CUPZKKZQDwmPYpXaLpmwtkThLdK09eGkJYNBU=;
 b=P7RKHFn/6yN4YUJLoy+QhN6gLHyBAKzA07jDAjaeTGACt+gy5QYMmRJK0CxIg6bc0c
 GINc9m8Cpd0EC8UeE0LB3TQr0BTxhNeSducswhWceAYog3wZapxmQHUlN2rZVwE0eqZ0
 qWfHJRcHpA8aN6k2/vM0I+Wtrec0yAsMa8We6v32gNeIMtRG/ScbBsaRJZn9FF5mnGRh
 6CwJWR/+t02240YtgADpp1GtPUk+hw5naB2wMcKfMQhyjD5M4CXWgjrWkpI4czEH7gvN
 YKd01MdGz6f+U49NhytXPwNY2Ie9ta6ktnOpvUUDwneglREgxDNqIi+2pCNjtVQXOazZ
 g+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214347; x=1785819147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dAUiB4CUPZKKZQDwmPYpXaLpmwtkThLdK09eGkJYNBU=;
 b=UVW3/C7WRDWYCIq4DGuaUT8gMMC7FdaGMmLWFfkn9lt6yirQTpC/+6tJpUKK7YfVWX
 oBHBugxSVZlnUmMyV+xqSQdzwnN8HdUlo83iqUvo0S95MLtT2G1S4EltHDmU/5oa5LdZ
 wvSZzpQLW6GJm14ETwzYqTziGapb3ssXDfSOimLpoNMBMb15MNgX9NVV54nXO5HXyljW
 BG2sfm0yvnPPGsYhcv+0CURhuz7PHbAn5ZOmmIW8A9ezes2KdRauiHdEqnOwJaD7BR7F
 Fzj/+VAbAY2jtQALHEngBufmojNntqgo3CWK2ktDoAu97LLNtM0Rm+BU4A0q9xRFjoM3
 mOzw==
X-Gm-Message-State: AOJu0Yzp71K9xBuJaQN93uN88HZ3PRthT1FaJNWHYApuhyuOgiYlCPjZ
 MSQFXF6BO3hppgYuUqQi/9inzX4yhnTHWExQDwYzVJWUm1H/c3eR9pvcdtfu3XzA3QtjnFHtlDd
 1RHwwLrs6XsRqDkHpqvE8qFn2+dhE9uTUejC8t7PQIJkF8aYrgyTBvMfjVKxczT2Lsw==
X-Gm-Gg: AR+sD12fpfx5Mh/vQUjosJeR+FUSVjowM/nu2zN5GMFJvw2GlMMNJU5vJ+k7PEejpGM
 MR1SfnLUfXNlrK6obXHU1MIjlXlWv8Hiv/GhB8tnMeVSV7Arv7r+kP1W+kJflqCr0y1/UG1N68J
 BJso8ll9YjWR7i6lyjuUMS9T6wbDjYyIjfZXuXms9GKohk6j40r8I1vAVB9um5Yi60Uy/xZCpde
 yF16uYJmlhVJZw/kvfArAsHM0Jv2qzpfz5YuONMOmOKWCpPjJG+LRMYp1i/Ig6EmEFd5tRcVK8o
 2KDTycspc2Tago7KjLS0XHONkY1CDId9hTgcVwFNKQB2m5FaQ88P14UJKxgtQoTlazYcd68aDwc
 9aRWNRRIkI5quFh1tI6jgfyAFJrmK0OuDfkqGg3Cmwul13zVBl1FxkOmsFGh/B7DzMgTzsDM=
X-Received: by 2002:a05:6a21:698:b0:3bf:6c08:fb88 with SMTP id
 adf61e73a8af0-3c8ba5ecb4bmr1152283637.56.1785214347179; 
 Mon, 27 Jul 2026 21:52:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:698:b0:3bf:6c08:fb88 with SMTP id
 adf61e73a8af0-3c8ba5ecb4bmr1152231637.56.1785214346627; 
 Mon, 27 Jul 2026 21:52:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:26 -0700 (PDT)
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
Subject: [PATCH v6 085/103] tests/tcg/s390x: system tests
Date: Mon, 27 Jul 2026 21:42:29 -0700
Message-ID: <20260728044248.137626-86-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a68358c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=SUcGKMR0j6ugdtI7A98A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfXyoaaD2ieORf/
 Hl7iGgAAS0EDJhK1Wp4uLL6oJiNeWYADpzf4fXUcmBjTsI4qyOIK92Hl5ULbuFDUzGtD6RmsvG9
 mxaQ+IKgTvHZa/bIQEmYtVFnGLzCzEcfrCVlbgCHzYuue2GaXfBIJmGi/WInl/klsRXC/+Xi6s5
 WehQTNjYXqnlCElAT+8i1atMMmTYvu4nlHe07wOVB8pk+whe0BYcZQtH/K/QUIRzwiz/qw825fy
 S2fIGGwS8irJBynfHYJzULZNM6m6GLRuIseqzUeWsj0OxiPJApeLMZoqiQVcnU0CYnrahtMBfTR
 jPMADO23UttuOYGqHsUu/5xBcKklDbwSPdgCQMvXz8fST0xEaB+lLp1p5CCNJxZAhcS9vWdfIhv
 JaMupslWvgZGugAezCa6I9BijEprfn7Ukc8zmI7Zpf5ZTltrL3RoBIon7q5mhariD08y+EDGV1z
 remAr/RWqG2Hn48ia7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX3t6V70/4MKPF
 SBN0tJ1b/i3smSOJr8zaJRz42pVEK/IY7l0cS8H9z2+TXxInKJyy0+cMGbMacInx0dMM758MQpa
 XG1Fjky4iChfE1Vwy406UFo9oDg9Hxc=
X-Proofpoint-GUID: km4djMphU2DCKzGCLIqbcgl8Swn7oT3n
X-Proofpoint-ORIG-GUID: km4djMphU2DCKzGCLIqbcgl8Swn7oT3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280042
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

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/Makefile.softmmu-target | 57 ----------------
 tests/tcg/s390x/meson.build             |  2 +
 tests/tcg/s390x/pgm-specification.mak   | 15 -----
 tests/tcg/s390x/system/meson.build      | 90 +++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 72 deletions(-)
 delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
 delete mode 100644 tests/tcg/s390x/pgm-specification.mak
 create mode 100644 tests/tcg/s390x/system/meson.build

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
deleted file mode 100644
index a4425d3184a..00000000000
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ /dev/null
@@ -1,57 +0,0 @@
-S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
-VPATH+=$(S390X_SRC)
-# EXTFLAGS can be passed by the user, e.g. to override the --accel
-QEMU_OPTS+=-action panic=exit-failure -nographic -serial chardev:output $(EXTFLAGS) -kernel
-LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
-CFLAGS+=-ggdb -O0 -I$(SRC_PATH)/include/hw/s390x/ipl/
-LDFLAGS=-nostdlib -static
-
-%.o: %.S
-	$(CC) -march=z13 -m64 -Wa,--noexecstack -c $< -o $@
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -march=z13 -m64 -c $< -o $@
-
-%: %.o
-	$(CC) $< -o $@ $(LDFLAGS)
-
-ASM_TESTS =                                                                    \
-    bal                                                                        \
-    cksm                                                                       \
-    clm                                                                        \
-    exrl-ssm-early                                                             \
-    icm                                                                        \
-    sam                                                                        \
-    lpsw                                                                       \
-    lpswe-early                                                                \
-    lra                                                                        \
-    mc                                                                         \
-    per                                                                        \
-    precise-smc-softmmu                                                        \
-    sckc                                                                       \
-    ssm-early                                                                  \
-    stosm-early                                                                \
-    stpq                                                                       \
-    unaligned-lowcore
-
-include $(S390X_SRC)/pgm-specification.mak
-$(PGM_SPECIFICATION_TESTS): pgm-specification-softmmu.o
-$(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-softmmu.o
-ASM_TESTS += $(PGM_SPECIFICATION_TESTS)
-
-$(ASM_TESTS): LDFLAGS += -Wl,-T$(LINK_SCRIPT) -Wl,--build-id=none
-$(ASM_TESTS): $(LINK_SCRIPT)
-TESTS += $(ASM_TESTS)
-
-MULTIARCH_TESTS += mvc-smc
-S390X_MULTIARCH_RUNTIME_OBJS = head64.o console.o $(MINILIB_OBJS)
-$(MULTIARCH_TESTS): $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): LDFLAGS += $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): CFLAGS += $(MINILIB_INC) \
-			      -I$(SRC_PATH)/roms/SLOF/lib/libc/include/
-memory: CFLAGS += -DCHECK_UNALIGNED=0
-
-# s390x clears the BSS section so we need to account for that
-run-plugin-memory-with-libmem.so: 		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py \
-		--bss-cleared $@.out
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index 3adb7dc464c..d614531ca61 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -21,6 +21,8 @@ tests_s390x_pgm = [
   'strl-unaligned.S',
 ]
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/s390x/pgm-specification.mak b/tests/tcg/s390x/pgm-specification.mak
deleted file mode 100644
index 73dc47af0d2..00000000000
--- a/tests/tcg/s390x/pgm-specification.mak
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# List of specification exception tests.
-# Shared between the system and the user makefiles.
-PGM_SPECIFICATION_TESTS = \
-	br-odd \
-	cgrl-unaligned \
-	clrl-unaligned \
-	crl-unaligned \
-	ex-odd \
-	lgrl-unaligned \
-	llgfrl-unaligned \
-	lpswe-unaligned \
-	lrl-unaligned \
-	stgrl-unaligned \
-	strl-unaligned
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
new file mode 100644
index 00000000000..041fe83e382
--- /dev/null
+++ b/tests/tcg/s390x/system/meson.build
@@ -0,0 +1,90 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('../softmmu.ld')[0]
+head64 = files('../head64.S')[0]
+console = files('../console.c')[0]
+ipl_inc = meson.project_source_root()/'include'/'hw'/'s390x'/'ipl'
+cflags = ['-nostdlib',
+          '-I', minilib_dir, minilib_printf,
+          '-I', ipl_inc,
+          '-march=z13',
+          head64, console]
+asmflags = ['-nostdlib',
+            '-Wl,-T', link_script, '-Wl,--build-id=none',
+            '-march=z13', '-Wa,--noexecstack']
+qemu_args = ['-display', 'none',
+             '-action', 'panic=exit-failure',
+             '-serial', 'stdio',
+             '-kernel']
+
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if 'test_name' in setup and setup['test_name'] == 'memory-access'
+      # s390x clears the BSS section so we need to account for that
+      # ./validate-memory-counts.py --bss-cleared
+      setup += {'wrapper': setup['wrapper'] + '--bss-cleared'}
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_args}}
+  endforeach
+endforeach
+
+tests += {
+  'mvc-smc.c': {'cflags': [cflags], 'qemu_args': qemu_args},
+}
+
+setup_asm = {'cflags': [asmflags], 'qemu_args': qemu_args}
+tests += {
+  'bal.S': setup_asm,
+  'cksm.S': setup_asm,
+  'clm.S': setup_asm,
+  'exrl-ssm-early.S': setup_asm,
+  'icm.S': setup_asm,
+  'sam.S': setup_asm,
+  'lpsw.S': setup_asm,
+  'lpswe-early.S': setup_asm,
+  'lra.S': setup_asm,
+  'mc.S': setup_asm,
+  'per.S': setup_asm,
+  'precise-smc-softmmu.S': setup_asm,
+  'sckc.S': setup_asm,
+  'ssm-early.S': setup_asm,
+  'stosm-early.S': setup_asm,
+  'stpq.S': setup_asm,
+  'unaligned-lowcore.S': setup_asm,
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {
+      'cflags': [asmflags, files('../pgm-specification-softmmu.S')],
+      'qemu_args': qemu_args,
+    }
+  }
+endforeach
+
+if 'qemu-system-s390x' in emulators
+  tcg_tests += {
+    's390x-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'qemu': emulators['qemu-system-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


