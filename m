Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039EFC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziS3-0004uJ-VG; Thu, 27 Aug 2026 18:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRe-0003S8-DW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRb-0007B4-UH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM2OS1117797
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UUk/EOMms+r
 HVnuEal2ydbDj9602AOphDWcGpVltqSU=; b=AK8x5JP8RXsThEp/yg6LM/eKCUJ
 FaWGWvwZOqN+Yb9fVdHp2YaFKFVvbtP5gZsZQE7suqzK6u7GkhoXAKtxgFXNzwLT
 e5AIerE8F/OT24Zlppxq4VtzyYoQxMNpin6/EBpACZRQvXJZ3/w9sTyRQDYmae0U
 YEJ8XkGHBTm9Ssy7jhdEYVVcXv1wMxnlvdqaTMlApaXK185qz6h0efa7617RUmTG
 V/VZQaFE8rP0HRfHEftdMjt/IQA+7UV9tFUBYCYjCM7ZySxUUb34U3Of07ecYCIF
 MRMVJQ4oYBd6CsV/QHwyITtAQ3AhKVMFsikT9y0dQtndrZOnZhe5zRUXO+g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hfwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so660603a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869164; x=1788473964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUk/EOMms+rHVnuEal2ydbDj9602AOphDWcGpVltqSU=;
 b=PA9P8F3/JfOtlHRmHGXsphjyWemAlGuwUKS/ToIOs61ppXKJTNuWZFMutYX6Jc8uJ+
 nQA+WHQpklF38o2tuGGzGFy7xTJ4nNyZndSGjhsZLDASdsYvysYNGAgQwasIRTNdYRO3
 0sPE4VKy+Eu8o53AMGKFhEoxdX8dK2ypwAkviepORMYnA1i14zo+f8ZkaeMz8he8ksZx
 yXBCCBQNAT4M23z0mSfGTgx4KDX/L/9DCue0x0IGit48aJO+s0TLuxkx6JQ9nzw0ymYe
 cdP7x9B2HxpfOGubF16UDXywUr3mv7AnOsAF2L4f4Ey6VF8OzsHvSAXudnKcPo2a03R2
 F44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869164; x=1788473964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UUk/EOMms+rHVnuEal2ydbDj9602AOphDWcGpVltqSU=;
 b=BYWGz7brREQ/KavS9Z7x16yMlA7eir2kyCIPSQj2inoUucDautNPAU4bSVxLaqncXC
 w0Vw7lD/BjnmgPdn4SA2gWpCSPG6eSWxFPz4yBLabjznzkE1RTDvifaKpgYxLd2mY0ov
 6RHOS6oTpOqLzNnkHUbuTBDxIHzAKHvZMfUtWP88afvTtn30J7gZnyCGV906pEJkMh8s
 LlpDWpXVgpRN20ZxTNx+teNfU0xMO9J23uxqeCJuaS024nd6uaOZBt57xypRL6Az/aG9
 US56MVRBFc2lI7Pr7ZRwGo55pkCLt3FVp9kTzBAUPsRiVOp1i180LGZOPm8i3SstuQSk
 +AVw==
X-Gm-Message-State: AFuF++mJO0UoCVeDyXe6ooiExrYh8/NaE1JwsVyGI3bHc5Rhthz1cIeb
 cyBRjcKN0B2o1O8X1grWG1KiREnnB40gQJxeKD4CclPSBqzSOCbGj5FqCnFfWb6U9vKtUrXSI34
 7mZ7mIc+OYmRkTWrICc/orZQi6L3O3wUXyIXu70nhsYKPvAMuNLj/ogUxcCF5be8k9Q==
X-Gm-Gg: AR+sD11z+DPBgeWW92eieVI1c1Z/V7Ecc+4w7SNV9mQ7QTt2kU1GxBOpThr9y3Vao+4
 OB/7b3SEuj3qwU/Zjq4bP3IGDcSARzhcPD3+bzOFCcYL5o4aG5LTCz2GA8R4I6cbyxU9cMzj5Bj
 zDvTdBFgbfYQBZt4kPnIhiFKkV4/i6dJKXYxL6eWNHJnMWN+VW9XlYEAWU4N483XlUsg6FB+DDH
 zTbpyfRJvn1jcBOi+YnZ+HfhbzdZXGoNz0cNcQ/exh4vO4QPc05iho7J77QkONj5D9NMJhb1AFr
 zIcRBelaS2jWMY7ctfobDenbD1x19Su7tLCtiV3N/VbVDL144gan0Sx/0D9vc8qW6yRH9S/8dJx
 FdfI2M9TORYgEtqf7hiRWl3Q0e7pra/hpXVGdkNh3RudEKM2GjBCY+BOcie8=
X-Received: by 2002:a17:90b:2b47:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-396d0d2c9d3mr4941359a91.3.1787869163912; 
 Thu, 27 Aug 2026 15:19:23 -0700 (PDT)
X-Received: by 2002:a17:90b:2b47:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-396d0d2c9d3mr4941279a91.3.1787869163459; 
 Thu, 27 Aug 2026 15:19:23 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:22 -0700 (PDT)
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
Subject: [PATCH v8 056/105] tests/tcg/i386: system tests
Date: Thu, 27 Aug 2026 22:14:17 +0000
Message-ID: <20260827221506.91574-57-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX6pFeDzinD98g
 58cvEx2Ey5cQxF2H0nWErXSGb6Sd90gU0VcplhsLVfbC7zRfCzFGi9EZWf/5p+Df+bh8Pd1eB1R
 jYYt/Dt2mLIdhza+ZNZXuvqzz/2q/pE/kXBTbpO5+v9+gWiIQ15Ng5C4syhnUQQ/HH/09Okqdcc
 A9YXJ9snwjwnE6zwFOZDxoqqphP8k2mWMHR+uV9Ap8X1wzjXYOvrnyUT9ZySGnVMG5plwRhuaVm
 /cf3gGJlIRrNHNjKo9k6d8VAPwAzPKc20x2Cey3ieCSgpS4O+24pvegRp4ZFLK9UI7GPfajlMHc
 wAnJ30snwAaW7xfbwrrgt77sFYe2YjSsgpUg/iW9p1rNzGgagRIrQzDDheqggbil6NR/3zelPgM
 Xp4YQAI5sn2QipXSvKvo1DGCQDVgl7cKP9oi1vL1ENC0XUq2S5wIISxeJPxyKilR+prt1ag+Kte
 tQJLS9nKd2CcjYMgAHQ==
X-Proofpoint-GUID: 2psnBWseU7dyWvgMX8P5-jr9QmRQ_rcz
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b7ec cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=YfLzPEwJW_iPccEctz8A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 2psnBWseU7dyWvgMX8P5-jr9QmRQ_rcz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX2zkSbKgaigrf
 v8pAJVfXRHnsY3ppqLcZKu7IpCtvVo9XbkmBsdLw0M36qs8r3E7eQw0p/EgGpsZ2p4v/AjnpHDl
 JePEvtHagNrS1DzXTr92vWm88vL8l74=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/i386/Makefile.softmmu-target | 37 -------------------
 tests/tcg/i386/meson.build             |  2 ++
 tests/tcg/i386/system/meson.build      | 49 ++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 37 deletions(-)
 delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
 create mode 100644 tests/tcg/i386/system/meson.build

diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
deleted file mode 100644
index 4096a1cf31f..00000000000
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ /dev/null
@@ -1,37 +0,0 @@
-#
-# x86 system tests
-#
-# This currently builds only for i386. The common C code is built
-# with standard compiler flags however so we can support both by
-# adding additional boot files for x86_64.
-#
-
-I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
-X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-CRT_PATH=$(I386_SYSTEM_SRC)
-LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-TESTS+=$(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-# Running
-QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 62074b86c9e..5cda03655fa 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -2,6 +2,8 @@ cc = 'i686-linux-gnu-gcc'
 cc_dockerfile = 'debian-i686-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
new file mode 100644
index 00000000000..d3f73997c7f
--- /dev/null
+++ b/tests/tcg/i386/system/meson.build
@@ -0,0 +1,49 @@
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
+          '-Wl,-melf_i386',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-device', 'isa-debugcon,chardev=stdio',
+                 '-chardev', 'stdio,id=stdio',
+                 '-device', 'isa-debug-exit,iobase=0xf4,iosize=0x4',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-i386' in emulators
+  tcg_tests += {
+    'i386-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'i386/system',
+      'gdb_arch': 'i386',
+      'qemu': emulators['qemu-system-i386'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


