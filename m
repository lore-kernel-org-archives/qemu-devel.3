Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0626C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJAF-0003zZ-VN; Fri, 10 Jul 2026 17:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJA2-0002of-L7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9y-0006Tu-Rl
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALClqX1931570
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wX3Eqk5vi2Z
 ZnlvEppbMijpvkSBDQZ0hkC47d6p08Pw=; b=bUtTfmVl/38Zz1PYuS+WdfRcdt6
 ta6q6nkCgeU9kr7InldzUqjE+z7yPHzdktS6OFBjbhP8e4hSAUr8SBigkEvBahXF
 0QKMHvNtqFomsRXoBSQ4psSmr8OnJ1PEwUzgaoFTgg5fn+P4Y2mH3D6QCGBeuHa+
 QZ4iYvbopW+vjzT2BwkBubUBim5iDKFe/nKifqx9vfGplnrw4rw/0iW37IH1Ryq2
 1oMvqWa8Sr5fzKdWCS4sgsgPaw6OMAC2yncMVygcMS52NX3b/v8Rf9PtbZR5TUJM
 PN3iZrMmrPHDgJmp2Ldyc5LOkZ8WihITHKdsO92o6ney9WQMhcvQEhG2wNw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r3fn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c892143db7fso1312002a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720405; x=1784325205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wX3Eqk5vi2ZZnlvEppbMijpvkSBDQZ0hkC47d6p08Pw=;
 b=O1M2uJRkbMed16Ycq+k/ALeX72FWH+uC144o3P3q8YhuBevn8rI/UfZgAorRqdyQ+y
 DNBiJzcdaBCf3amWCE5UZe8EjEpFsd40/PG9pnMxdV5GKYysb2hdIoX4DA2He1CtOdP1
 DBosZHro/dRG3JvLPJZMK2I97hRCQB8wpqhzTW4XBExA5mE/6eGYtMl0EwvOrDU3JYbZ
 WHUzXG3R9oqdbb8SSnkWcGMargvIiwmWJqIfu0kPSBUFkc6Mc9gPNEL2FhClRZ30xEiy
 9wMGXV7jPDGzXtcq6YqaTpD4EI7d5m+jIGJjYPFapklQrNXCf+ij2c9CN+0wvde5sHZO
 lPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720405; x=1784325205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wX3Eqk5vi2ZZnlvEppbMijpvkSBDQZ0hkC47d6p08Pw=;
 b=A4B3mgZW2bx9j9HQOGdWREABnETNoMLfHuKOWtvO1owlnR4eovbAirlS2I5PEfL8pN
 RY6vNwCZrOp63GLq3odT1jOOA7MDczV58qJVSE8P2xQbtx0xS4PPLQSJ1MQHVZZU3X78
 j4+OSnr3IX+33u5whwCnq15vUIGUtB+Kw4qrm3VReYA7qZ0fw8C3BntaWpXA+jzJhZqr
 QwVIXc73g/7b1bo04+Y44zEkpo96hNqTuFDoOOXp9xpSHXCxJpPE5IBO7cOVt/ye30RB
 FlHu/Q4enRlLos3flI/Woo5x29jP7zMMR2Dq/7IN9OJsxKawqaduJOOWC3zE/ahz+jE8
 kySg==
X-Gm-Message-State: AOJu0YwcDjApkNnFCu1xvC0P9xslzb716tya5kAHZWEHLdwTt3lsuKVm
 Cf4Ja3Fdv6p69QobveIZpd+MtH4zuET9Axb4whUNph3Z/Qr0GyoeEqjnhqZfzMLjOd0+XFpHckj
 9MUqv/8heCMMfcsKwTtHdCyMU5DCaz3eSSxzAXQs0BpF5YzA9YGvfhakBqpoJBG5/4g==
X-Gm-Gg: AfdE7cmFf3W7J6wYNT29Rp7YOHuFOLJW9ffdhE8GEvD/33e/y7fRTKgzJWSadPo9Auo
 PwP8q4LOV6zLsZAD8GojunlxJOWJKwa5Nr9FY+Zqh41/NxIv4cRNwYmzMjqM9UlOBmSPXGbXzrH
 mTHuVrNYlHfBmB8g/XHtuXzp/xzeYYesPMGVVJBVN07xqvCr5VsoJTGJTQ0Wbt1WifOkQbr+BnJ
 NYrE2TUmA4HvkbJURFLvTLTIlLOeXFHsa2hhQRR9uLq4+KiD+Si+gB9l6fk1PVsglj9DKrJUhgc
 SzvU7V/UQC8jpQUobWxDPz4GWPueK2rPlfj1qZSgWGOMudWIvtiOReYNOiJW694pWPBGtYFcZPt
 xhm/5c1o6nf4ecgBrhnXir5cB256sqjTeDNISwEbNs1Wam+xs3hDMh21EdkGgDt8XDPsUAPbDAA
 LolddtMQ==
X-Received: by 2002:a05:6a20:6a28:b0:3bf:6c07:b2f3 with SMTP id
 adf61e73a8af0-3c110ad2d98mr576603637.54.1783720404712; 
 Fri, 10 Jul 2026 14:53:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a28:b0:3bf:6c07:b2f3 with SMTP id
 adf61e73a8af0-3c110ad2d98mr576575637.54.1783720404242; 
 Fri, 10 Jul 2026 14:53:24 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 93/98] tests/tcg/xtensa: system tests
Date: Fri, 10 Jul 2026 14:43:37 -0700
Message-ID: <20260710214343.2065491-94-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5169d5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=g8Azq2kgbW9PJrE6qJUA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: lVNNkn7gKMmtRgEBSuC5aGGjqQJXeqFL
X-Proofpoint-ORIG-GUID: lVNNkn7gKMmtRgEBSuC5aGGjqQJXeqFL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfXwQhNuBtAm/4o
 bZgyBEJzzvhYmRJeSh38AYvpF+KmJL2AQuA2ilMDtx5cYMMj7XFGG/bXJjiZnI9wwQDUlp3tikc
 jlh+nQnSEhuJiE18lK0v6RrubVbHmNs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX1lyFWIGqaFgw
 ihJc2qlCNd7dxPHGjdtVskcEt7TW/AymKT9gPnjuEWCY5hEdkyegWH5M/Gyd60jwZ7g5taMX5g5
 RQ7xu3g2vbQkqG0FojSl9n6fTTGV6UFrV7oKDMSaNDcF2/3+o9rEic4Hj5Hr5zCa1GavZLUnIwe
 OD09SZaKgKEQpsn3X4JCKl/+HSs5PeSEnw6561lsY1sMCszSGUhfZ012519UijdgKIQwmZjUHzb
 AREWsjwCyKS6ax5QFYuroZqzuuT2CUlFdo5I0WDtPVX1sDL99kt/HnheQCJ3woxpr62bQi5A5Ih
 2sJPeMxG1DXSmu6f/qZGnKE91IJzF5a1USdlI0T4/l9Wc9I3DLbjdPBeGi2jGhS1RdVymJmOc+M
 Gt9KExKUAGmfxLxZPShN028S5veAdRwSTPMaHH153xNJwjb4qriypbhfKvfRgJ4AllOSurMPPHE
 tlwmpJpRBHkresxhmDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100220
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

We prepare structure to be able to test multiple cores.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                      |  1 +
 tests/tcg/xtensa/Makefile.softmmu-target   | 46 -----------
 tests/tcg/xtensa/meson.build               | 96 ++++++++++++++++++++++
 tests/tcg/xtensaeb/Makefile.softmmu-target |  2 +-
 4 files changed, 98 insertions(+), 47 deletions(-)
 delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
 create mode 100644 tests/tcg/xtensa/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d2f73ba655c..3f48c2db9ac 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -153,6 +153,7 @@ subdir('s390x')
 subdir('sh4')
 subdir('tricore')
 subdir('x86_64')
+subdir('xtensa')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/Makefile.softmmu-target
deleted file mode 100644
index a29571b367c..00000000000
--- a/tests/tcg/xtensa/Makefile.softmmu-target
+++ /dev/null
@@ -1,46 +0,0 @@
-#
-# Xtensa system tests
-#
-
-CORE=dc232b
-ifneq ($(shell $(QEMU) -cpu help | grep -w $(CORE)),)
-
-XTENSA_SRC = $(SRC_PATH)/tests/tcg/xtensa
-XTENSA_ALL = $(filter-out $(XTENSA_SRC)/linker.ld.S,$(wildcard $(XTENSA_SRC)/*.S))
-XTENSA_TESTS = $(patsubst $(XTENSA_SRC)/%.S, %, $(XTENSA_ALL))
-# Filter out common blobs and broken tests
-XTENSA_BROKEN_TESTS  = crt vectors
-XTENSA_USABLE_TESTS = $(filter-out $(XTENSA_BROKEN_TESTS), $(XTENSA_TESTS))
-
-# add to the list of tests
-TESTS += $(XTENSA_USABLE_TESTS)
-VPATH += $(XTENSA_SRC)
-
-QEMU_OPTS+=-M sim -cpu $(CORE) -nographic -semihosting -icount 6 $(EXTFLAGS) -kernel
-
-INCLUDE_DIRS = $(SRC_PATH)/target/xtensa/core-$(CORE)
-XTENSA_INC = $(addprefix -I,$(INCLUDE_DIRS))
-
-vectors_ASFLAGS = -mtext-section-literals
-ASFLAGS = -Wa,--no-absolute-literals
-LDFLAGS = -Tlinker.ld -nostartfiles -nostdlib
-
-CRT        = crt.o vectors.o
-CLEANFILES += linker.ld
-
-linker.ld: linker.ld.S
-	$(CC) $(XTENSA_INC) -E -P $< -o $@
-
-$(XTENSA_USABLE_TESTS): linker.ld macros.inc $(CRT) Makefile.softmmu-target
-
-# special rule for common blobs
-%.o: %.S
-	$(CC) $(XTENSA_INC) $($*_ASFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-%: %.S
-	$(CC) $(XTENSA_INC) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT)
-
-endif
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
new file mode 100644
index 00000000000..7c3c4f7cd62
--- /dev/null
+++ b/tests/tcg/xtensa/meson.build
@@ -0,0 +1,96 @@
+tests_per_core = {}
+cores = ['dc232b']
+
+foreach core: cores
+  tests = []
+  core_dir = meson.project_source_root() / 'target' / 'xtensa' / 'core-' + core
+  link_script_src = files('linker.ld.S')[0]
+  link_script = custom_target('xtensa_linker.ld.' + core,
+    command: [meson.get_compiler('c').cmd_array(),
+              '-E', '-P', '-I', core_dir,
+              '@INPUT@',
+              '-o', '@OUTPUT@'],
+    input: link_script_src,
+    output: 'xtensa_linker.ld' + core,
+  )
+  crt = files('crt.S')[0]
+  vectors = files('vectors.S')[0]
+  cflags = ['-nostdlib',
+            '-nostartfiles',
+            '-mtext-section-literals',
+            crt, vectors,
+            '-I', core_dir,
+            '-Wa,--no-absolute-literals',
+            '-Wl,-T', link_script,
+            '-lgcc']
+  qemu_args = ['-M', 'sim', '-cpu', core,
+               '-display', 'none',
+               '-semihosting',
+               '-kernel']
+  setup = {'cflags': cflags, 'qemu_args': qemu_args}
+
+  # Multi arch tests are not supported
+  # tests += tcg_tests['multiarch-softmmu']['tests']
+
+  tests += {
+    'test_b.S': setup,
+    'test_bi.S': setup,
+    'test_boolean.S': setup,
+    'test_break.S': setup,
+    'test_bz.S': setup,
+    'test_cache.S': setup,
+    'test_clamps.S': setup,
+    'test_dfp0_arith.S': setup,
+    'test_exclusive.S': setup,
+    'test_extui.S': setup,
+    'test_flix.S': setup,
+    'test_fp0_arith.S': setup,
+    'test_fp0_conv.S': setup,
+    'test_fp0_div.S': setup,
+    'test_fp0_sqrt.S': setup,
+    'test_fp1.S': setup,
+    'test_fp_cpenable.S': setup,
+    'test_interrupt.S': setup,
+    'test_load_store.S': setup,
+    'test_loop.S': setup,
+    'test_lsc.S': setup,
+    'test_mac16.S': setup,
+    'test_max.S': setup,
+    'test_min.S': setup,
+    'test_mmu.S': setup,
+    'test_mul16.S': setup,
+    'test_mul32.S': setup,
+    'test_nsa.S': setup,
+    'test_phys_mem.S': setup,
+    'test_quo.S': setup,
+    'test_rem.S': setup,
+    'test_rst0.S': setup,
+    'test_s32c1i.S': setup,
+    'test_sar.S': setup,
+    'test_sext.S': setup,
+    'test_shift.S': setup,
+    'test_sr.S': setup,
+    # test_timer is time sensitive, use icount to control time
+    'test_timer.S': setup + {'qemu_args': ['-icount', '8'] + qemu_args},
+    'test_windowed.S': setup,
+  }
+
+  tests_per_core += {core: tests}
+endforeach
+
+cc_dockerfile = 'debian-xtensa-cross'
+cc_docker_host_arch = ['x86_64']
+
+if 'qemu-system-xtensa' in emulators
+  tcg_tests += {
+    'xtensa-softmmu': {
+      'cc': 'xtensa-dc232b-elf-gcc',
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensa',
+      'qemu': emulators['qemu-system-xtensa'],
+      'tests': tests_per_core['dc232b'],
+    }
+  }
+endif
diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
index 95d0528c372..3df131acea7 100644
--- a/tests/tcg/xtensaeb/Makefile.softmmu-target
+++ b/tests/tcg/xtensaeb/Makefile.softmmu-target
@@ -2,4 +2,4 @@
 # Xtensa system tests
 #
 
-include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
+#include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
-- 
2.47.3


