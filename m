Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C37C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPY1-0003AL-Kb; Tue, 18 Aug 2026 15:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXu-0002xu-43
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXr-0000F4-Qh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHJG3Q735618
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=COUC2c5o2mX
 W/S/gIDLm+9aSfiLmoCe0iSdwO62AN4A=; b=ij7mwO1ru7CkdFjYhfR6Oj1GXlX
 xTqcMamBn2aNgaIXoNFOg45O0eiqCrhhBG9K+UjbXSuKb9p+OS0HT+sMobZ9eb1r
 HNZxe7fXSOasqP3daqlNilyakvHbXyCoRp8CMLMVIMEawYOm7/2ZlvtgaZyJF+pt
 UcjFdhzMZe0pT8f1S1+RnNd8KjHZ4KdreFpuIHYPdJpCsb7Xen79vkChmS3TveK6
 ZUPFcXq5G9RNlK8Aj3nm2Z029GCqD8zP5xAxuJ/ulnT/Rp7V8ER08JVDB3W660dU
 Zs6ZiZZc+5l5IwoF9U83yG33QpZqNd8dS+5AgPZGKJELBgJU3f1KLQ66P0w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4reshmus-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so127342a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081542; x=1787686342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=COUC2c5o2mXW/S/gIDLm+9aSfiLmoCe0iSdwO62AN4A=;
 b=HpExBMiQquJLl0r3M+OGFENij5vgh03JkiU5PC7aZbwpUChEzXyQf5m5ZsnaDHaB6w
 oVAQhYV142mGB9B/Vk9SzUnTqMG8FS4+OtTtAadXBx/Usblfkz7Oop0gDtFgTHMDByD/
 tOSlv+gAgvgOsmKwlymB5GyYVv/CXWBHgORjY/imp9Zm67MdBNvte3+23BC1s62ZHHMK
 rItiAxpsn/IFY8MSJGGh29VYYY9gHCkcxuirqOMzTMudLhPD+peJS4o6rhN/CnUxKuBk
 7Si0XJLxnvMFcRn6JUa0VeRuQCDlcv/ROl4jdxnnjBsSNUdJGyktJbA9m6Unq6lzkq8Z
 Yfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081542; x=1787686342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=COUC2c5o2mXW/S/gIDLm+9aSfiLmoCe0iSdwO62AN4A=;
 b=jupSqxS5GpkluuUED22wGsVujNC4OMYtQkvf9GbtwaxzrB4BHgFQFUnx69Eglyx4QE
 v8IEGRWT+1Tig5R620yGAxHdtI+twKZ7ra3PCJVLSeajAm+XLU+2h0cVvtirfXPecXty
 3/0QDMPkPafIfhtj/Zy7S0z25xpwjYfc1kkHDPiSFqFmNKeCRZZxD/C/NTNVYBJ6YsWD
 B7hDPu7Lr5oo2fAFIC90oDkpaWafDKHxIGiJzOWYj2OuulDs1cFs/h3DqyyleOiEJJJU
 M/3WTRvaVzO3LmrDgU8lPUTLOPwvS5/IxeQCH8Gu7ID8waFwWSglE0hRIwFwsGeHPlzX
 rsIg==
X-Gm-Message-State: AOJu0YzS9hh+cDfZHC0mGV+70AvVR0UtKFFvWTIn+pFjjSGKhbk8hm7Z
 8RiZEjFHpk2H6/3rx4Sa4m7Zn9rxTwJZgQzS2DrB5dtkdthyjRCRoawNZbqTka7gzh36u4rKLM5
 QQAn7vgRDJJLzz6fjIq1wZEajgGkwORn8UK943gjajok2K+I2alcHzqshyxPYSOQwxg==
X-Gm-Gg: AR+sD11q0G5D4STP6HtizDE7FfGXfJYij3yg4DtKTD62d3Q5ir+5FHgQcYh/aEGgE+5
 vG7JYB2Gg+9Px+2axHFUmu6gPepdUFtMyE7A01zlwXwAgg9rR1PenHALyvzMyu4MLZErPkdH/yt
 /XkjV2YNl7fEQGW6/V7b8j2+MorMUCM4frz+jc5CeEidu0fSuAdUXRziSDuBoobd5sMmjLh4edJ
 B6QF+UlSLOyjVP2Ch8EPOfJX/RGEBrAWY5glIDkz2SOn92p8K1Si9v6RlfgW/OJ1KHXcGNEOu7h
 L1f31kQD2jGlinKmzevQjiNgSQD3uiC+QPHaEgHSZAhrFd4F3/NSETBWDc6/gCwCeCuRIooR5Af
 msuq0yLrRc1Qysb6kauL4f4m8uVPbjSHlWxBhrgMr/KVNP6uuuHjp6K+2TME=
X-Received: by 2002:a05:6a20:d28b:b0:3cc:f280:ebc6 with SMTP id
 adf61e73a8af0-3ccfec89780mr411146637.5.1787081541670; 
 Tue, 18 Aug 2026 12:32:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:d28b:b0:3cc:f280:ebc6 with SMTP id
 adf61e73a8af0-3ccfec89780mr411059637.5.1787081541177; 
 Tue, 18 Aug 2026 12:32:21 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:20 -0700 (PDT)
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
Subject: [PATCH v7 084/104] tests/tcg/s390x: user tests
Date: Tue, 18 Aug 2026 19:22:48 +0000
Message-ID: <20260818192309.22169-85-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ne/WEWD4 c=1 sm=1 tr=0 ts=6a84b346 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=U997BogEOwLcalXFwzwA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: _n8KHSHo4E_zWT4iSrkOfvcNLxaWg9qB
X-Proofpoint-ORIG-GUID: _n8KHSHo4E_zWT4iSrkOfvcNLxaWg9qB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxzXmqqj0Q4dd
 JM5pdVGcPKUOi+6LBb/vIw6UjyXx7BMnu9xcf54A3KUlLcPKK0+9fbvG5WPCFGTvNogWELJ3hxs
 vN78svL1HVL83Vw5bu193BhtaIA/wtQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7niJp2T0M8W9
 JxMjIBbeotntWWmr53AD2OCKpDVGx3nj+yyi0jewtVsA/d1uZKg/gAb5B6GNcRJBA837xS2PKA/
 AImansILYp1/VqfhfY//kO8V1Qs5M2Vw8Oq/gjyfkBk/q7TBZiZKc/aT6C5iyyu89UXMeqVd1MR
 gqxV7hra8AscVbYJusdJwPNVq1JQm7T4FW9QTsOvdmkOWHimotzK80gG/7sRZkQ0w2xghDXmIEA
 FX+20csN1iIP+OW8fSGWozC0MGq9PC7UDAeMj7k18lyM12Mu/KR0o4Y7X6t/wFGhWdSDiL8vGh6
 N/iXae/vXLMea8Xa4P+pBdcRcoBS17YrnoUb180kPxYALMjJCxNtU4b80no+D8ycpB4yJsL+aYX
 G/VuS9ykRNZbiYTOKZK7b3KBjk/D4+JzQ6+fHI53t4zS5Kj/FCR2RSKqOoTHqkNUsFXeh76GoBQ
 geKwI22G6qhWs0UothA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build           |   1 +
 tests/tcg/s390x/Makefile.target | 129 -----------------------------
 tests/tcg/s390x/meson.build     | 140 ++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 129 deletions(-)
 delete mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/s390x/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1a48b37f75c..6bc2829ba92 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -152,6 +152,7 @@ subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
+subdir('s390x')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
deleted file mode 100644
index 97c0f021902..00000000000
--- a/tests/tcg/s390x/Makefile.target
+++ /dev/null
@@ -1,129 +0,0 @@
-S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
-VPATH+=$(S390X_SRC)
-CFLAGS+=-march=zEC12 -m64
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-march=z14, CROSS_CC_HAS_Z14); \
-	    $(call cc-option,-march=z15, CROSS_CC_HAS_Z15)) 3> config-cc.mak
--include config-cc.mak
-
-TESTS+=hello-s390x
-TESTS+=csst
-TESTS+=ipm
-TESTS+=exrl-trt
-TESTS+=exrl-trtr
-TESTS+=pack
-TESTS+=mie3-compl
-TESTS+=mie3-mvcrl
-TESTS+=mie3-sel
-TESTS+=mvo
-TESTS+=mvc
-TESTS+=shift
-TESTS+=trap
-TESTS+=signals-s390x
-TESTS+=branch-relative-long
-TESTS+=noexec
-TESTS+=div
-TESTS+=clst
-TESTS+=long-double
-TESTS+=cdsg
-TESTS+=chrl
-TESTS+=rxsbg
-TESTS+=ex-relative-long
-TESTS+=ex-branch
-TESTS+=mxdb
-TESTS+=epsw
-TESTS+=larl
-TESTS+=mdeb
-TESTS+=cgebra
-TESTS+=clgebr
-TESTS+=clc
-TESTS+=laalg
-TESTS+=add-logical-with-carry
-TESTS+=lae
-TESTS+=cvd
-TESTS+=cvb
-TESTS+=ts
-TESTS+=ex-smc
-TESTS+=divide-to-integer
-TESTS+=stckf
-
-cdsg: CFLAGS+=-pthread
-cdsg: LDFLAGS+=-pthread
-
-# The following tests contain inline assembly that requires inlining,
-# and thus cannot be built with -O0.
-rxsbg: CFLAGS+=-O2
-divide-to-integer: CFLAGS+=-O2
-
-cgebra: LDFLAGS+=-lm
-clgebr: LDFLAGS+=-lm
-divide-to-integer: LDFLAGS+=-lm
-
-include $(S390X_SRC)/pgm-specification.mak
-$(PGM_SPECIFICATION_TESTS): pgm-specification-user.o
-$(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-user.o
-TESTS += $(PGM_SPECIFICATION_TESTS)
-
-Z13_TESTS=vistr
-Z13_TESTS+=lcbb
-Z13_TESTS+=locfhr
-Z13_TESTS+=vcksm
-Z13_TESTS+=vstl
-Z13_TESTS+=vrep
-Z13_TESTS+=precise-smc-user
-Z13_TESTS+=prno-trng
-$(Z13_TESTS): CFLAGS+=-march=z13 -O2
-TESTS+=$(Z13_TESTS)
-
-ifneq ($(CROSS_CC_HAS_Z14),)
-Z14_TESTS=fma vfminmax
-fma: float.h
-fma: LDFLAGS+=-lm
-vfminmax: LDFLAGS+=-lm
-vfminmax: float.h
-$(Z14_TESTS): CFLAGS+=-march=z14 -O2
-TESTS+=$(Z14_TESTS)
-endif
-
-ifneq ($(CROSS_CC_HAS_Z15),)
-Z15_TESTS=vxeh2_vs
-Z15_TESTS+=vxeh2_vcvt
-Z15_TESTS+=vxeh2_vlstr
-Z15_TESTS+=vxeh2_vstrs
-$(Z15_TESTS): CFLAGS+=-march=z15 -O2
-TESTS+=$(Z15_TESTS)
-endif
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-signals-s390x: signals-s390x
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(S390X_SRC)/gdbstub/test-signals-s390x.py, \
-	mixing signals and debugging)
-
-hello-s390x-asm: CFLAGS+=-nostdlib
-
-run-gdbstub-svc: hello-s390x-asm
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
-	single-stepping svc)
-
-EXTRA_RUNS += run-gdbstub-signals-s390x run-gdbstub-svc
-endif
-
-# MVX versions of sha512
-sha512-mvx: CFLAGS=-march=z13 -mvx -O3
-sha512-mvx: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS+=sha512-mvx
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
new file mode 100644
index 00000000000..c8a8e550e67
--- /dev/null
+++ b/tests/tcg/s390x/meson.build
@@ -0,0 +1,140 @@
+cc = 's390x-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+cc_feat_cflags = {
+  'z14': '-march=z14',
+  'z15': '-march=z15',
+}
+
+tests_s390x_pgm = [
+  'br-odd.S',
+  'cgrl-unaligned.S',
+  'clrl-unaligned.S',
+  'crl-unaligned.S',
+  'ex-odd.S',
+  'lgrl-unaligned.S',
+  'llgfrl-unaligned.S',
+  'lpswe-unaligned.S',
+  'lrl-unaligned.S',
+  'stgrl-unaligned.S',
+  'strl-unaligned.S',
+]
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  # The following tests contain inline assembly that requires inlining,
+  # and thus cannot be built with -O0.
+  'rxsbg.c': {'cflags': ['-O2']},
+  'divide-to-integer.c': {'cflags': ['-O2', '-lm']},
+
+  'hello-s390x.c': {},
+  'hello-s390x-asm.S': {'cflags': ['-nostdlib']},
+  'csst.c': {},
+  'ipm.c': {},
+  'exrl-trt.c': {},
+  'exrl-trtr.c': {},
+  'pack.c': {},
+  'mie3-compl.c': {},
+  'mie3-mvcrl.c': {},
+  'mie3-sel.c': {},
+  'mvo.c': {},
+  'mvc.c': {},
+  'shift.c': {},
+  'trap.c': {},
+  'signals-s390x.c': {},
+  'branch-relative-long.c': {},
+  'noexec.c': {},
+  'div.c': {},
+  'clst.c': {},
+  'long-double.c': {},
+  'cdsg.c': {},
+  'chrl.c': {},
+  'ex-relative-long.c': {},
+  'ex-branch.c': {},
+  'mxdb.c': {},
+  'epsw.c': {},
+  'larl.c': {},
+  'mdeb.c': {},
+  'cgebra.c': {'cflags': ['-lm']},
+  'clgebr.c': {'cflags': ['-lm']},
+  'clc.c': {},
+  'laalg.c': {},
+  'add-logical-with-carry.c': {},
+  'lae.c': {},
+  'cvd.c': {},
+  'cvb.c': {},
+  'stckf.c': {},
+  'ts.c': {},
+  'ex-smc.c': {'cflags': ['-Wl,--no-warn-rwx-segments']},
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {'cflags': [files('pgm-specification-user.c')]}
+  }
+endforeach
+
+setup_z13 = {'cflags': ['-O2', '-march=z13']}
+tests += {
+  'vistr.c': setup_z13,
+  'lcbb.c': setup_z13,
+  'locfhr.c': setup_z13,
+  'vcksm.c': setup_z13,
+  'vstl.c': setup_z13,
+  'vrep.c': setup_z13,
+  'precise-smc-user.c': setup_z13,
+  'prno-trng.c': setup_z13,
+  '../multiarch/sha512.c': {
+    'exe_name': 'sha512-mvx',
+    'cflags': setup_z13['cflags'] + ['-mvx', '-O3'],
+  }
+}
+
+setup_z14 = {
+  'cc_feat': 'z14',
+  'cflags': ['-O2', '-lm', '-Wl,--no-warn-rwx-segments']
+}
+tests += {
+  'fma.c': setup_z14,
+  'vfminmax.c': setup_z14,
+}
+
+setup_z15 = {'cc_feat': 'z15', 'cflags': ['-O2']}
+tests += {
+  'vxeh2_vs.c': setup_z15,
+  'vxeh2_vcvt.c': setup_z15,
+  'vxeh2_vlstr.c': setup_z15,
+  'vxeh2_vstrs.c': setup_z15,
+}
+
+tests += {
+  'signals-s390x.c': {
+    'test_name': 'signals',
+    'gdb_test': ['--test', files('gdbstub/test-signals-s390x.py')],
+  },
+  'hello-s390x-asm.S': {
+    'test_name': 'svc',
+    'gdb_test': ['--test', files('gdbstub/test-svc.py')],
+  },
+}
+
+if 'qemu-s390x' in emulators
+  tcg_tests += {
+    's390x-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


