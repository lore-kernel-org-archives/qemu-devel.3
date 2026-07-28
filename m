Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47D5C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjX-0002FH-DR; Tue, 28 Jul 2026 00:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjU-0001zA-Lr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjS-00026n-PJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aegl1714857
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=txHnoEcoAuM
 6Kf0+WhkWSCKp/0Z+/busSTuH5fB4+yE=; b=oW9/FYIDB6x4ojR2/vtMSMG7YHt
 6JoZI98iiKA3Gs0+cJxYIzqIWyA+DIu9O03zuJ4wlEP6u4dURW46neKqp/CY32/3
 G4E1cwFUeulH+fnaqXpjWqr9RS20qYmKCBic28fq3IQqqug9zx32zKNGrffmjcD0
 oSW03Hc0I1qgJe405T/e28mxAa8XIXTgwvhO9+gOsIShTGvc644r5+yEjJhP5ZuG
 rilRNY9Qtik4NUsjXjT1rt6xJGFPjoKwn3C9jCQ87vI1XLVJ38mTFT5sXiSS7e36
 huSzwG5BcGGU0PYcR484l3CbKZAcm7GDyHLvxa1qIVjA+bGF/QDloMzm4mQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkjygg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38edd45cbc4so4100390a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214077; x=1785818877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=txHnoEcoAuM6Kf0+WhkWSCKp/0Z+/busSTuH5fB4+yE=;
 b=Qf6/ABuxd5H+WPEtkVBEKCNGokVUvh6UkJ9NY+6gI914eD2KZFHL5MbLP76XvVp4XB
 ujOduCTYN+jlTTxW21ZNs+cm4BflhCId/FrcC/SxWu9uJW5+8UGW4nVSzqD/vt76ezsd
 GqHBV/qKxYRJKkCWnXeVc1678EmHQpZGj6yuxnlYsM7t/2lTaGShhyMhdbmDPBRKoYwV
 8YeQNHuh3Qy5LL25kzXBMwCiDOwtawgKlzfG3HrIcGCad27rT+yNgIFpHKINgBy25cZT
 kjbvS1VO9PKAYLgxjO/bi0yOFnfqfzwmfTx3M9rmGYC0pYYQ/lK57yC/M7SfQlgRQYUD
 PR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214077; x=1785818877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=txHnoEcoAuM6Kf0+WhkWSCKp/0Z+/busSTuH5fB4+yE=;
 b=b9/kX++/6FlCCrgiVOVtUsBNA+oA4DkJL999dP0/oxhCQes8gclZtfb27APfOzRL6c
 eb6Vfii6RiHim3WZCR8zrYKFYNZ3PKHR9WGfq22EGRixmnb4kABZ0zL2RTJqeXCuGx3t
 K9Y4SGCHQipOnA+ndBtuaKi4en/HczZ5TwTD/Xl6n0s07srbpa2/jOrtOl3lrlp7vLd+
 8qnJ1jU0jQ9yVD3l8IixtgbveYb3zgZ32bXYCWdxsmDpTDBfAJq6k7ZXWYCrTx1WzAvp
 qSFIC3Ttbvf4vQl+tZYX1/FtVGwS7XPmrbOinvuu9MG1bd5+lS65JYmr71bVpNcwzX/q
 DMog==
X-Gm-Message-State: AOJu0YyiDm2H+LJQjAX3E8/8vKh8wtcKGVxnYh5bS7xKBAJ0TmAvN7V9
 JPe4dlpgYttPA2MSogI11I5BWcv+jZsF04SE1sXN1vWMVqp7OF87LnUJSBoKiHYazdkWlOPBUuT
 UyKpyq4FvSE6H7sRynieddJYd1ZQO3dhmgl5iQdxqLaHTeYSjeA/eJhz+rkgDyRb22g==
X-Gm-Gg: AR+sD10oh/6aJ5aDQ+3KDMy7asuFiLMtaceAiy+kso79150luR75n2Nhglx6yn5PXOK
 +Rlf3sWkgOPIOI80c8tMk8RVrYI9rLSui2Ivm+oUjDwhOcoNyEh4t4OThXO8Pu4WjNNW9tJQkWk
 F1faJMRf+XnXbXd7THoHiWstgyS9/aMHHUmocgl3K1hlAQnMRC73rqQlCoRlpj+cUvGWz2ryfOe
 LkeRkYGMZARvMrvhByRbfyoV9ltGxy046Lp8mJWZx7K28KjaeK22BDldsHkR0e9a22isLdIaOFy
 eqN8dBj8Q/ngF7MtGG3cHIQqCsFjU21Q6NcWn9Ne4sHl7D5wixZUKmiHsXR3TAN4o2D1IOLcw5Q
 9tqPRe7dGOT9eqJbeEX32y2CVYcUQCtAzuh2zt2HGkILFfx4iW3WjaZLlpvYXGAT7vTFohkg=
X-Received: by 2002:a17:90b:38c8:b0:38d:c50a:714 with SMTP id
 98e67ed59e1d1-38f6a432a17mr967532a91.27.1785214076522; 
 Mon, 27 Jul 2026 21:47:56 -0700 (PDT)
X-Received: by 2002:a17:90b:38c8:b0:38d:c50a:714 with SMTP id
 98e67ed59e1d1-38f6a432a17mr967488a91.27.1785214076052; 
 Mon, 27 Jul 2026 21:47:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:55 -0700 (PDT)
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
Subject: [PATCH v6 057/103] tests/tcg/loongarch64: system tests
Date: Mon, 27 Jul 2026 21:42:01 -0700
Message-ID: <20260728044248.137626-58-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C9zGUH48eWP5w0PjbaZv80F_rHkRSzI5
X-Proofpoint-GUID: C9zGUH48eWP5w0PjbaZv80F_rHkRSzI5
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a68347d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=FVW9kWhLySRIolcT2UUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXzOIDIAjM7qkb
 wtimOFBuQCQCDzip6LpSWEMXRXnCMxqndGkgkZQoO7JceFP6uMBvv3aFDWy+7Hk9IWbSWwtlv0R
 TGpuwHaZTa7awjtfmfZ54SdjRoLexKdK9zYpIaF2XjeQb2PbOvAn7L9UY9BDKQNtH/m7bhieQrN
 eAK7tQK1ytIWdfXc+5wbRwBG64cXHzQEGbtq6rbbeObF9Fe1kpfpZN/b/1bI5ivK7g3MjYozMfr
 91MmUyRRRgOT2yiJGyg5W0kAvIFTD5p3aiSro9qmr8p1Vv7637T0FfbIU2hkLuTg88thbR18rAw
 RvOvSNrZtmo7rRlBnMEMl0ABXrgksbK5CcfaAoKp+m+SfqV86u+A6QU8Nd90rA8DVZY1Z/gIC3k
 +fQQU95edU4DmvJPcACnGIzPNVUAW+Q+mK/sVFZFU9i3GMrKIUtUTaXWQI5yKBMFJunH59bG5u2
 y01RKr04r6ibYCLOYiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXxnsd6KJax7Ci
 0E2ybuRXYQUwuSWCM90uWPj6KZR0lw8C5oMPUpNECtrj+w/r5dU5gZ454nNnlYucOGiuW1iYsWf
 cPxlual4+RgDlV9lzypYZqZYvYMyjEY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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
 tests/tcg/loongarch64/Makefile.softmmu-target | 33 -------------
 tests/tcg/loongarch64/meson.build             |  2 +
 tests/tcg/loongarch64/system/meson.build      | 47 +++++++++++++++++++
 3 files changed, 49 insertions(+), 33 deletions(-)
 delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/loongarch64/system/meson.build

diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
deleted file mode 100644
index 6d4a20fde73..00000000000
--- a/tests/tcg/loongarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Loongarch64 system tests
-#
-
-LOONGARCH64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/loongarch64/system
-VPATH+=$(LOONGARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-LOONGARCH64_TEST_SRCS=$(wildcard $(LOONGARCH64_SYSTEM_SRC)/*.c)
-LOONGARCH64_TESTS = $(patsubst $(LOONGARCH64_SYSTEM_SRC)/%.c, %, $(LOONGARCH64_TEST_SRCS))
-
-CRT_PATH=$(LOONGARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(LOONGARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(LOONGARCH64_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc -Wl,--no-warn-rwx-segments
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
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 209179fd96c..1d62de64ed6 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -2,6 +2,8 @@ cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
new file mode 100644
index 00000000000..b46d2234032
--- /dev/null
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -0,0 +1,47 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-march=loongarch64',
+          '-mabi=lp64d',
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
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64/system',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-system-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


