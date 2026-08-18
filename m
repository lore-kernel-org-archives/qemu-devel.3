Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16B1C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPXz-00034F-5J; Tue, 18 Aug 2026 15:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXr-0002tp-4G
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXn-0000DP-Nw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:22 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHIlOi1971886
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LD7cbgE13CO
 DQYzNy06F2UNRRc7+a2g6dsicJvCTozQ=; b=pSwzBorbl7HjKm7V7jUcrxL3khr
 9UPSk6Je88qYEcc6Y1yTTdWxl3XBoG6aem06ZufbH6YyQFkp8n3/cpKt+9/OTFbR
 s+he12CNXBFhG8Siukq5st9oxjpa91j/cbGHaLSE7NzGcYX7d8aFWJzwFejb4m9n
 5pwkqQN0egihZ8qtlhzd+LK9WFAOofbakv6wCpTaSLCYBGeGXDysLUwLxKdsf5gp
 x5t8VIkEojcw2o1FBWw2aNdokfcEZKgHpZuz4kjLp05nWia6DzSQO2SZWdMi/S/c
 14QhV5yX2r/vAfYbd/2ZKKRb+ACHvZIZCFxuRU7UM2OMj433K6yM/v8tV1A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx1tcx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so577345a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081538; x=1787686338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LD7cbgE13CODQYzNy06F2UNRRc7+a2g6dsicJvCTozQ=;
 b=G9aYA2Ryw8AmcUzALZl7+zYEs9gpkvHid21mVMUehIRUWRQU+3KXGFD9fFCuM2AX+Z
 u7ACUoqQtH3JfHYRPmpmIF+HvkrBmb+rIQwhhSjhONq9odPBhlgnqUk2aAugA8JwRo4m
 STThIyDYuFURQdiaQuWmjKdnh8lxGoRjiyIdEI7f5d7OtPyRZthzTUi0fccr2d7VO/P/
 jJmIm4Hq33h1BxB7pxrez5t4C7g6KZNUHxHPoWZLBnbuTxTsCHv90yMq0aHI9XFVx6uH
 WPKg6rn4IPhrjG/+b41lBLJdt51/Y6is04hLZnE36pH2s0+N0SCR8cCGMqMHRPb+lxdx
 KiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081538; x=1787686338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LD7cbgE13CODQYzNy06F2UNRRc7+a2g6dsicJvCTozQ=;
 b=gD/5fcVqtW3SuUJWsrKqUERY7crntIQdRWXxHyTt2kZjbR0JSAC3Zkcji2DuYuSuOU
 aTbt2/jxv250nYfBxCLiaxlUTMsh5jArrAObpkxyOFTfsbauxN87x15pR9hUutfr1v/n
 7h/tfEDS1/lWcLT5SwRug2y/4gMVxlzKOnlbMkNXnzPZHJ8y8V2A79PU8ypfHcBWbYgI
 F/3F63Jqj5DRLhBCo9kdORB+Q4UGFIln1mE6ONX8OZi2zyoXJQGSxwji262ix/9T2Uq5
 yHuBH6vPg4uHabygZ26oEfI4jfbxdLzeXdeNK90qKptr6wtOJZn7qE6s5deAvBghuMeI
 Cxyg==
X-Gm-Message-State: AOJu0Yx7GV5ER9P9EikcGWhXrosacy+eHuqTjoXtqhTDwE6t5iPtOXm+
 d4H2Sg5vLdj8xbYA2xbgNJX2DogG0sr6J6Ka6JqTNcpGWAavvt8Ag8id/GAZRg+iw0QPsOpwFFb
 8DV01eeMKjCYPDIRtnacY2nNxLkiL8wDzSmkHHAWtldpcOhfbEcsKTvXGZrQKMFSArQ==
X-Gm-Gg: AR+sD10yUAWazlvxOOvYnC17pYq8dhhdzPVcZwUOd0uUkMrx/3VXQ7Z+ct9Haq40hZp
 1rLz3xjcOQFI4ItQvwRZDyFKskw8+9XvalNTpSwXPNlOgVzw0fc7Ro2n9yAB8n4XEVnOYR972vR
 hVdgauLCDU0qfKJJJqJDKJ3BVt9b+8TgJWfWWoq2es7dEhqP+h0/YB9Vp1+dd8aoG9H/Ods9xei
 ahjtoZzDv9dCpiuJbnOChDS/U5WkQdn3V7iVMUKXxhtAdJEfiagP3pSrJZQQnd1ilHOT8HvMrA0
 V/daHZktBPtZnqYipMDFn8dJ9tP50iXFEYSn1JVS4CIPhYbf5prHf3zuId05DeL2Rk6/zVpcxk1
 yv9fOjl3fP60HcdpL5WlDIvuPSyzhGh9Pz0uJ8YlZUmg8lhOxwJMUGW6C//0=
X-Received: by 2002:a17:90b:2f8f:b0:395:543a:cf3b with SMTP id
 98e67ed59e1d1-3957b2115acmr188783a91.2.1787081537619; 
 Tue, 18 Aug 2026 12:32:17 -0700 (PDT)
X-Received: by 2002:a17:90b:2f8f:b0:395:543a:cf3b with SMTP id
 98e67ed59e1d1-3957b2115acmr188698a91.2.1787081537155; 
 Tue, 18 Aug 2026 12:32:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:16 -0700 (PDT)
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
Subject: [PATCH v7 081/104] tests/tcg/riscv64: system tests
Date: Tue, 18 Aug 2026 19:22:45 +0000
Message-ID: <20260818192309.22169-82-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX0FnlM9+4Ff0m
 c1bs7HVxVGgMpbjzzX366aLpqg+tw72nkWt4yhHiTzVVUaD3YZ6boLNGoDuDPX/R6P+04ubwf0j
 Sin4f7Kcnpr+Ut+k+WQQpuDimHNopsY=
X-Proofpoint-GUID: SdVRHRcmnuDDju5dICGJMBXMp3G-Wwbp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7Gq/eohR6Gb+
 duLZTcktDz0S5g0IEZF3/P0n7PTNtt28vn9UTXyBHxp6TRhngXA9/HE0LiuZl5QVgvwb8I4ipa8
 9V5nFczotEiHpg8sBleen1D6LTX3xVnsn/j5pJuUIcHDvsZv4BfkFsaBOGQgxGUB/NyD0B/W2u3
 FPonIIkHKKFf9GP3mI5Q7JhSLivrTAd9UQ/RRHrT33pAFphqifcUKj9+8UxBBMOysJ689xsHBRY
 7knM37OnOE6uTT2U6MClnwZoBhzMf+lCpe+LG+pP74k+vyu5XSll/xUOBa0xkSbmsm1D24M+Br4
 2JlAKJTnYeggGGH2hMhxu51Kkzf/1qKBF9MPl1Wq5oUj6O4lFID6caUP3QszEvZEsZgCU6rAc2F
 P7ygtVav4lzKauCyBCd90GBdL55Gxe3v07JN6lwEue+2UzgEqc4heIWdB+u2/wINKzjrhhyjT3y
 E7pj9aS06aM8185R/Vg==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a84b342 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=zzQR_8oM-p7h9UWrr-IA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: SdVRHRcmnuDDju5dICGJMBXMp3G-Wwbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target | 45 -----------------------
 tests/tcg/riscv64/meson.build             |  2 +
 tests/tcg/riscv64/system/meson.build      | 39 ++++++++++++++++++++
 3 files changed, 41 insertions(+), 45 deletions(-)
 delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
 create mode 100644 tests/tcg/riscv64/system/meson.build

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
deleted file mode 100644
index 82be8a2c915..00000000000
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ /dev/null
@@ -1,45 +0,0 @@
-#
-# RISC-V system tests
-#
-
-TEST_SRC = $(SRC_PATH)/tests/tcg/riscv64
-VPATH += $(TEST_SRC)
-
-LINK_SCRIPT = $(TEST_SRC)/semihost.ld
-LDFLAGS = -T $(LINK_SCRIPT)
-CFLAGS += -g -Og
-
-%.o: %.S
-	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
-%: %.o $(LINK_SCRIPT)
-	$(LD) $(LDFLAGS) $< -o $@
-
-QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
-
-EXTRA_RUNS += run-issue1060
-run-issue1060: issue1060
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-mepc-masking
-run-test-mepc-masking: test-mepc-masking
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-plugin-doubletrap
-run-plugin-doubletrap: doubletrap
-	$(call run-test, $<, \
-	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-plugin-interruptedmemory
-run-plugin-interruptedmemory: interruptedmemory
-	$(call run-test, $<, \
-	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-crc32
-comma:= ,
-run-test-crc32: test-crc32
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index b5f574c1377..2292bf8ed1b 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -2,6 +2,8 @@ cc = 'riscv64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
new file mode 100644
index 00000000000..40e5a1373a1
--- /dev/null
+++ b/tests/tcg/riscv64/system/meson.build
@@ -0,0 +1,39 @@
+tests = []
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+link_script = files('../semihost.ld')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-Wl,-T', link_script]
+qemu_args = ['-M', 'virt',
+             '-display', 'none',
+             '-serial', 'stdio',
+             '-semihosting',
+             '-bios']
+
+setup = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'doubletrap.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'interruptedmemory.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'issue1060.S': setup,
+  'test-mepc-masking.S': setup,
+  'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
+}
+
+if 'qemu-system-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-system-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


