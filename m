Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46313C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTZ-0003da-EC; Tue, 18 Aug 2026 15:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTX-0003Nt-63
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTV-0007Qk-4P
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGrRD2494363
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=axI5H3viwyp
 KqShaClwyTp9eSf8a0FQnfv3nw6FzysE=; b=VswEM0D4nY/FwjEmm8Zailgv1c9
 sUBkYtcce1T9O5Rcci5v7gWQmG+xOA8kJdNnGkHHjbXRU+HyhXX1W+lAgBIxKlBj
 CrhrgHjdTEEuy9xDouYyHr/676+46IeBChbWIcgS4IOyGLbmyQyn+QZF1er4Utcb
 HiGbDVMYRFytncZUaAFc6lvnrBwHWBU6WuGXsTeJljWHbcbrA5O4ukAhTIIYuzUS
 OXpCumu1wwvfGC4sWEWNtcjQrDNmpkNnWGEmJgnXQHnRHtZpJl9h21wUvgcWHpq4
 Z6NYr9G2LCoH8hqWfjqPDkYh0NG+aKuKgHFxTAO1ZCjSy1mEVh0GcaRZwpA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfnhajv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so116046a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081271; x=1787686071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=axI5H3viwypKqShaClwyTp9eSf8a0FQnfv3nw6FzysE=;
 b=bUiOek+vGDvigD7LCsiRaEcDf4Xacs6J5lLaA1CbnkaOnGz3/7Q5zo2UB/RuM5dnVP
 vOo56V+cWsbpCOleXImuF2AGqqy0Wcb8kOI6L7HBQ9KG3rwDBfr/xiNzs9kSxEwcnhSE
 rzvKfTOui1b0lShT2B4ZmcdOsIF0NkdmOvB4vRQD/hlc9Bi603sRs9YODbHeTLhsDhSB
 jJm+fexWtLJ0j9GHoOlI2Hgv/Knm+SeynkzkVvROLHjwab8/hs0mCqLW3ASwIIc3HI1S
 +GJzKICwZAhwd5zHUupMVKpaT7eCgolLXHRr8wtR7BJdjIpWj6+1Gos0J3B1CBFvdqxQ
 DCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081271; x=1787686071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=axI5H3viwypKqShaClwyTp9eSf8a0FQnfv3nw6FzysE=;
 b=X0I3D3NO3Co4CNwi+opnChKN75S1/R1ulPCEbqkK9M90mQItEy7fl7qNUTJ2Sga5yT
 T9m9eGj9BqyXDHx4h7KzyKdnn1NwTqPt+CMp4/NIsZ+zhx0S1/k8KuPDqR/deavHeqY5
 sUJBH1R//Uaa6o6IxjdMcCyUFMF80JSmzDahb6tpMnH8wurnP1bHow+9ro7SfgCJ4cmM
 E3RtwxD7nimx6xXi2aLTFQe2+KvJwWi4GimdYBRX2kWDOG+hMVhvHEwzGiTKcobM+Fls
 FGjoLwGtAeNILjv6tl67ZkNzwNESYPpcumqApEbyrbzZOT5Fm+FUWk/HSCURfJAcE566
 F1Ew==
X-Gm-Message-State: AOJu0YyV1XG+XXLHJHPFkqVEPWGHe39Epqp3AGDoghCwQRmZRhhefL+l
 XLq5bq5ggNcoOaPFxGsUnxUZ6KpdeRu6se7jstZGN4P8RGqooPa2B4mSQdFmxGcp0M+IMmGhrTM
 kpDd+/1LLt0+Ni+sR4kVhSJNHQcIGltazfhfbssq3c8nsxTuF4YNDfF9xtM1Jjyt16A==
X-Gm-Gg: AR+sD12oJzYLD+XuJbYC5f3gXvsXbVHM0Ntz4HRQcdPYC4Fa8vfhRqVGHB4gu+fuH4A
 X4LFTViKiezXeBxFV1GMM9GkilamCS5p1mwwTsXsx1t3t6hiXIQweOClsNuQgO92ZX2r9gBwmFS
 6A3LF3XMfsSzBeeE4UOZjY9Ab6791V2xwOe9NYvr+lkcf41U4w9DEo6m3fWk1/19ugO/nxZYLGR
 kdrphuu0zKWMzEqGPAzuHliDuLP8eWDe8K9aNmfSN3drCPifxEqFCPmHKcf30rqUS3TnCHPFuXo
 e8ACYQVnUt/OCxr95dSe/sIDW88xP7h2jYlhPd26SZC1NBgSnOdz4qDTqgUM3x+3d991Uu2EF/V
 x9QS42Ow027uRPu7AZVvjoSwggpsMhMzyOCGRQgT7m64FP2FGVaT/Zj6NaR4=
X-Received: by 2002:a17:90b:3901:b0:38f:a81:15b1 with SMTP id
 98e67ed59e1d1-3955f1b6cabmr8853313a91.19.1787081270719; 
 Tue, 18 Aug 2026 12:27:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3901:b0:38f:a81:15b1 with SMTP id
 98e67ed59e1d1-3955f1b6cabmr8853288a91.19.1787081270307; 
 Tue, 18 Aug 2026 12:27:50 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:49 -0700 (PDT)
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
Subject: [PATCH v7 046/104] tests/tcg/alpha: system tests
Date: Tue, 18 Aug 2026 19:22:10 +0000
Message-ID: <20260818192309.22169-47-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5D8Ru/M8egIT
 GIVlZ1DrKMtkYC+mafmXeNa4iK/0D9EvJR0+koWYK+Z5KN1U5pu7ND1SWGALsZt3Ncz4KUR/9dH
 d7FPNO4goNqF4kC1rzKeRY00JwC8Ujw=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a84b237 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=04VGBHJcbsNav9IjXu4A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: aeZSlK36-gqkfnKOCmXRBEavMvD-b7xc
X-Proofpoint-GUID: aeZSlK36-gqkfnKOCmXRBEavMvD-b7xc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX1UMyqd9vvtqL
 oMfBlUODc581Bgq6SwGl0yPY6Bar/aG7vYU7n2MbtEZWV5Wv7OgPNd7UhNW6OrraiKmHtUfu8vf
 ZrDN721GkxZM6ymviPOL1z85Vnj24sHBdtMx3qjAhibqIi3T9Zty/E5b/T6zMItG6DqmpT7IFvk
 l6KSBI3p/wnRyO/j64njPOczk7EW9hgKv2HqdmF6dSRB+Ugji1E4MY9O4/zCSqm1Ptsc54p+1iM
 zdMN82O2bpEDsLY82zRxJyKHTM0P3Ewo8ovxr0I+XXuf3nXRFSPSeCmx0hKqZUJYiBJIT8DC0wB
 q1Z67Y18dnlwu7zOuGQEb7DWEEoxh6u6m3VpqvT5EWtCMyfIXnUT++8/S5HAag65O8LCZ5tbm+j
 PSNDDCl4S0FGc5K4Nw3nfkMcnifcynwbquJ6gAQniVLHqNyQ8Cup/fAxTpiqX6Zl8MdIuiam4xe
 3e51KPwoEIklTJfdgow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
 tests/tcg/alpha/Makefile.softmmu-target | 34 ------------------
 tests/tcg/alpha/meson.build             |  2 ++
 tests/tcg/alpha/system/meson.build      | 47 +++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 34 deletions(-)
 delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
 create mode 100644 tests/tcg/alpha/system/meson.build

diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
deleted file mode 100644
index a944102a3ce..00000000000
--- a/tests/tcg/alpha/Makefile.softmmu-target
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Alpha system tests
-#
-
-ALPHA_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/alpha/system
-VPATH+=$(ALPHA_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-ALPHA_TEST_SRCS=$(wildcard $(ALPHA_SYSTEM_SRC)/*.c)
-ALPHA_TESTS = $(patsubst $(ALPHA_SYSTEM_SRC)/%.c, %, $(ALPHA_TEST_SRCS))
-
-CRT_PATH=$(ALPHA_SYSTEM_SRC)
-LINK_SCRIPT=$(ALPHA_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(ALPHA_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -mcpu=ev6 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0 -mbwx
-
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
index 08e371116c3..fe60ce2496a 100644
--- a/tests/tcg/alpha/meson.build
+++ b/tests/tcg/alpha/meson.build
@@ -2,6 +2,8 @@ cc = 'alpha-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/alpha/system/meson.build b/tests/tcg/alpha/system/meson.build
new file mode 100644
index 00000000000..b10f2c3e28d
--- /dev/null
+++ b/tests/tcg/alpha/system/meson.build
@@ -0,0 +1,47 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-mcpu=ev6',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += ['-DCHECK_UNALIGNED=0', '-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-alpha' in emulators
+  tcg_tests += {
+    'alpha-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha/system',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-system-alpha'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


