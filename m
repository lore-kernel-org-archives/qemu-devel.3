Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080A3C61DD4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRo-0004LG-Np; Thu, 27 Aug 2026 18:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRb-00035Y-Mg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRZ-0007Cf-I3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLxne1358884
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=d9HRgcQ6OAu
 ONWSlsXFID75L/wWOCIWL709X7DGBLQI=; b=NLlWizwaIN3gQNqjqqY1dRexrB0
 m7DyBbjzGVXUHR6SkZOB9eE47KVt4WPSBYsUsNujW1r7VjzsWB6TY2ViiEzGRjY3
 q9h9O9lieN52uzNPs66k27B15PgbsOt/Oianny+qm8RmNwqSWvHDBE6t1zE1/8aY
 JqMf7BBJpwYdl5OYdlhwLFCqPV7ZFcO7Evs8MNPTTkk7ylMQH028dJHPKAdzmHoA
 6SqhXfxzh0WiF2GHQ16857MkPyCLCVS+rxQ3KBYkCAb5+6iCKB5hLZcVLt3idBzF
 X13vV4HUkmpUYWg2eZ6Ze271W8uyYSddRMTDWQjjDU7i0RkNdDpJFGOXSlQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgvaa7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so374083a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869171; x=1788473971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d9HRgcQ6OAuONWSlsXFID75L/wWOCIWL709X7DGBLQI=;
 b=cMeb2KCE7NSm+kaZoYbiQDY6iNImPG0InW/Xr0Do/GtLOuWz2rL7yQbgoQ0TLLauuT
 y2jVORAL1uwnPot0YPqFcpnpv9TNRmeMJDKl9UlGLTJM3ZFW+qDD779i4Jcrt2l3zsvq
 fQ0coTtwbpjJg+rR4Kyd142SzbF1uRyJ17vIoNOEQD5JFUVTaS91Y5d+mikg8oDLi20c
 kTOPHFNJlEiRyaphTHY3/vrdo8TuoeebkQk4U0wwI3I+SEitSxQ3r/ZAr1IzHwFmV940
 gTYqKGt5YxSASsIJ8IQsL2GoYp/XeoJm3+vpzTYNPVb1AJOj1gOkWGIPwq1mN9FIJdpo
 ItdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869171; x=1788473971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d9HRgcQ6OAuONWSlsXFID75L/wWOCIWL709X7DGBLQI=;
 b=W4nt+xgKnlOGceDxxAAPnBlhWpSP+Wt/zwCDwqkfjYt2zk9Rf0NM1t/JZRAPlkoEzr
 rOYAo6iRVfYqMvnNBX947v7B8PYpNwo3KCjOJkCDW1daZQ5VPKM+IA9yZHls2OEYf388
 EbiNUjArTSpdHQ0DLZDtNizFNnU/QGKO9mur5L0jXhtYGNUoD7Bw1rneN5Mk56kJWi23
 ZlrwffFvZITshVc3EHNyaTbbTJa8p0DplimdtX4MSo7/qTs6lofn+mNCjmspCAMpccK3
 g2ulVCIyAkc798T1+wvghYWfE3eEA0x6HD/Eqm5J9c8ae54ajFLWNnprDoUuPgAtHtLy
 YsYg==
X-Gm-Message-State: AFuF++lhzlUTpjOwMBJYUdlIrOtoYO/n9ysIEOhenDjH6aR9pNnKP84B
 7wgFkHfl5/gq7190jXzjt8B5oKF0oHIMVrgqIJD5vzJEd73dUeOYTtfrs9UyYs2ZZFxSS3jC/wj
 bNuYtW5etzDUa0Pkyy2BaaeQLJ5DDIG8H2J4C/RbtFkmtCwBlgxIZE0xsnqXMR1Qzkw==
X-Gm-Gg: AR+sD13fRg7XWmZHd8/z7smJZHe8W77cSJMrxGHAc/MASdx6KdK9bB/BaylpxLKGQwS
 4oJM0mHoWzRU/y4hQ2p83rHdxct2ESDIYoSbdLbxvTBasM0POifrPAwip2/odE2GsM5NGlpDyQ5
 y1qvF0b6j5iapdlBUzQwLoZ8GB9dmVRj2k58gH6ZjSMhchuohkt4IeNLHk5KZQY4Nff5wCHj8QF
 uP+SxUJfafzLdQuQf+rpTPmqbkQtU28ffQDhr9KHuXL8EZuWtUCSDexWPXF16sfWrYJgwp+W0IB
 8dIC0u6yjGvdPz+ScHZgFxOgv1sSD3E9V/HnFOAMc+UFPmWrpP5VIJ/p25m1NcW/8KHFGo3zKv6
 4u4xJO84bWL0AZ/LNkfndH9ub/IiBOhCHJqdAtczyNGXnlbTLmQ8nqVY/I1E=
X-Received: by 2002:a17:90b:5443:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-396d0d4cf4emr4620827a91.1.1787869170804; 
 Thu, 27 Aug 2026 15:19:30 -0700 (PDT)
X-Received: by 2002:a17:90b:5443:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-396d0d4cf4emr4620752a91.1.1787869170321; 
 Thu, 27 Aug 2026 15:19:30 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:24 -0700 (PDT)
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
Subject: [PATCH v8 057/105] tests/tcg/loongarch64: user tests
Date: Thu, 27 Aug 2026 22:14:18 +0000
Message-ID: <20260827221506.91574-58-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GYTpzTYcTjzvE-dbkQRJhQJMuyOTVby9
X-Proofpoint-GUID: GYTpzTYcTjzvE-dbkQRJhQJMuyOTVby9
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b7f3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VnNF1IyMAAAA:8
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=Y62p6b28tDkMR5CZvOEA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX6mHIrmR10n/b
 5drLYz0+TOVXZINkXc1cEAVx7vIE4DcOogSciIqsxQOB84gV0uHzbEqCaapwYqOG0G3ZGbo0vPL
 EzgjsF4s2kASJVIuPSowS3hrV+/ClOTaWcV1IaTp5xdhLY87V0nvJ0elzvOfSjbCzjH0Bakzold
 huSOiKO4FV7mW4tu/zVNpjoSEsGmBLcCGopyasgLVSkUHoXxfe0XwqqzcOyrpc411zsVNWpc1Kq
 T4x+CWFUjWpC4J9RtYUs4VM6JtdtkL53fg7LF26dr5JbGyKQq451tkHYv0S40GpMAxfz+wEBIAw
 66d+REux78hvdAkkMhfVLXk/mPQOD3/eixwtr083GESrDuEvVqclVUBTRTJpNWE+zqV2MlDafRr
 Z6hKqlZNV64Z4qJbSadZg2N+ATAF7VMDTKamYpZBI+VKvTGwITi6s1Hwo1d9GR2n2a9CST4S5Pl
 Jm16rTQGjoBdduLE2ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX+JPtIt7efUZB
 aGjhbIAOBhKsskf+lYjLGJX92nt3jrtD7Nbc7rw9THSnhJojO4rB8a/btiRkKduoa04SU+z1ee+
 W9Xof9SrcqvNFp8hQeTtDqPfhShcP2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
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
Reviewed-by: Song Gao <17746591750@163.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/Makefile.target | 20 ------------------
 tests/tcg/loongarch64/meson.build     | 30 +++++++++++++++++++++++++++
 tests/tcg/meson.build                 |  1 +
 3 files changed, 31 insertions(+), 20 deletions(-)
 delete mode 100644 tests/tcg/loongarch64/Makefile.target
 create mode 100644 tests/tcg/loongarch64/meson.build

diff --git a/tests/tcg/loongarch64/Makefile.target b/tests/tcg/loongarch64/Makefile.target
deleted file mode 100644
index 00030a10266..00000000000
--- a/tests/tcg/loongarch64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# LoongArch64 specific tweaks
-
-# Loongarch64 doesn't support gdb, so skip the EXTRA_RUNS
-EXTRA_RUNS =
-
-LOONGARCH64_SRC=$(SRC_PATH)/tests/tcg/loongarch64
-VPATH += $(LOONGARCH64_SRC)
-
-LDFLAGS+=-lm
-
-LOONGARCH64_TESTS  = test_bit
-LOONGARCH64_TESTS  += test_div
-LOONGARCH64_TESTS  += test_fclass
-LOONGARCH64_TESTS  += test_fpcom
-LOONGARCH64_TESTS  += test_pcadd
-LOONGARCH64_TESTS  += test_fcsr
-
-TESTS += $(LOONGARCH64_TESTS)
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
new file mode 100644
index 00000000000..209179fd96c
--- /dev/null
+++ b/tests/tcg/loongarch64/meson.build
@@ -0,0 +1,30 @@
+cc = 'loongarch64-unknown-linux-gnu-gcc'
+cc_dockerfile = 'debian-loongarch-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_bit.c': {},
+  'test_fclass.c': {},
+  'test_fcsr.c': {},
+  'test_fpcom.c': {},
+  'test_div.c': {},
+  'test_pcadd.c': {},
+}
+
+if 'qemu-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4d74891a30b..70aaa86afbf 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -143,6 +143,7 @@ subdir('arm')
 subdir('hexagon')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


