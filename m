Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0DDC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Jc0-0002pn-6F; Wed, 09 Sep 2026 10:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4Jbu-0002ku-A1
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:49:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4Jbp-0007BQ-RU
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:49:14 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689BoUIL2698507
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 14:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zdD492Xt6kC
 ItyItAdMpgXFLX67x5JL6tQl71pJj8kI=; b=iNO9NRfdgLKzbMHpJRKcgpE4o7x
 jK9QucEdDfz7zD1JqA75nTm8VSQ4odhLydcSP1psq8L30plMG5JVWRPWE6veJLhr
 +cX8J+ZzYoQ7/Kl9BsH7XET8G6zRfEPZXtsmH1BRmDCQj+XBVTxtRZKNJ3LssBuc
 WK4OBYJ5P73dB3yVrUElQzaSxBLyz6AG6HXlii5D0CDBzUexW/iv4ISniK+irF3m
 z7cehvVaRVeIThOhkfk2Hn+NZMwoAGVxcJbuNQrUkN3aQfFFU2xth0W4oqz6E3Kg
 6KEN8bpv5HyW9BsO8scIv3UDYK3uAAcee9oIf0XtzZ/2JUksIsZpVI+bEZQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk6xh0saw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:49:08 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-836c9f68dcbso113724157b3.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788965347; x=1789570147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zdD492Xt6kCItyItAdMpgXFLX67x5JL6tQl71pJj8kI=;
 b=PEjBUIAcSz2f8gLkSJKyRHH6+KrgwJA6BzESWnQBC2qoblHe1AElFxOHQd6BNtnX3Y
 I6ZbmUM0aFbKBS6qrvTioEepHBVO2AoLJpMl8xzQWeSw9eninDxmJ1ioHJkyyatWKMpn
 ZAqXvvCwANyjraoyuhcPDTf3l8IMXWK0UjboLsqhW2sMSDeKgK6A00cmtxaFl1aRQb8a
 1GfBUrstZ43fDtrZu7hWGbJojukraDX5HHV+HAOAdTmrHDyMeVwM430/5Mn8hhT3T6i+
 UWTNySUo1zEuxKH+H+kTrjG7v8PJXdPkWxBRtE+QsOm4FDF24R9vs0Xm+ZB+/+zzVB7V
 zKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788965347; x=1789570147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zdD492Xt6kCItyItAdMpgXFLX67x5JL6tQl71pJj8kI=;
 b=U98KKfBbhNijCChzOYSqHte5nGOeBxsK7sc4AIxtCdbUo8vTmxfNYdq4VPZ4T5zO7I
 GiKGqzzGeGFKesKkzGvIKEcMWF0cGcU+Edw7SCscWubd6s558J4evL7rlpTWjeycAeqJ
 +E723rWbBGzPi5Q/0ZZoZqNODKFOtfCWQgm0fz23tRF0R2xHuXto+4pB5fR5eFtO3jOd
 pyFLj/EkzSXR+wdZArT7HYeqsYseo4zPN14lh7UXFEJIiqUFrO5XcBPsWCc7aPcgemHx
 4puFQgQsd8fPQE4AUbwrEEadcERfamil6htCRdySl5AmOJwGePQmJJ+yB5r0BuarGokK
 xo4A==
X-Gm-Message-State: AFuF++mRqXIjrHartBYkO2WHCvhf8Niux0YGqMf6dUnWI1PVXHF8BPF3
 1Kns/so5uDZDVd5xpOnJI0tV5IdqO6nT5RCNHMKWn+DmxGj3M9E8Tsy5jb7RAKNKfEnysgECjP5
 ZYGblQJh/4FQmxceDrr4XALNNsm+BgDfx+QWU1ZsNalxeI+oUyuTvlgKs19F4JbZMPA==
X-Gm-Gg: AYBFou1w4NxiQYLIOM2pjGFJ7ApwRcsGv2f9RJ132gNLC76jxUdk481M6JRA7Ug6vMW
 KGq0Rw0sDlNIExdC94wx487zrB7yAjGTBzY9JuX/n6sbf+J8Y5ZciHtWuvL6QGKjX/mPdHmijec
 nvsa6x3LtqBdFQJK2qQD5WRq3Lh/PKRUPy7CR4hTq2Djk0kow3KyTSsezek0JIxlF5iTIknW1jM
 ZLFOmCBmfmIHTsBH/xLgiYwbovYL2pllO53B4lqIpleGGjGfYyaoekKHcyMkNN7/ARJQJyavnGZ
 /soMQAMFjqp4Q/dGwI0B5XLqUdItWV+JoFWnLX6d5Vaqc6dbIJ04ZeBtwvMYWF5WMQLuG+/9s8B
 TIgUq5S0z04V8K1ryW3rJa23imFQCud0EB6Eg
X-Received: by 2002:a05:690c:4f10:b0:86f:e98c:fbfb with SMTP id
 00721157ae682-871284f6f3emr109361277b3.15.1788965347345; 
 Wed, 09 Sep 2026 07:49:07 -0700 (PDT)
X-Received: by 2002:a05:690c:4f10:b0:86f:e98c:fbfb with SMTP id
 00721157ae682-871284f6f3emr109360757b3.15.1788965346841; 
 Wed, 09 Sep 2026 07:49:06 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910464bf898sm125678886d6.7.2026.09.09.07.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:49:06 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v9 7/7] tests/tcg/riscv64: add sdext "not on Debug mode"
 sigill tests
Date: Wed,  9 Sep 2026 11:48:40 -0300
Message-ID: <20260909144841.1766921-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX8642ld7zpr4/
 epCqUbd1j6saxpl0plab+Hl0x+4yNMlrLPVhv+MFlzImfnT1kZ3x7dwt8ju011a2a8zIFFq3iGL
 CoawnVsYRMHCm2gL7jorvQwZBSzTIEobMN9KBqw2L1ZkdfuzvmHUdP0YMVl2YmOZGgB/TfLFRiF
 bQFVnLB+ZrABLJ+XildxP6uxzDZYvMnxMUYlGooRS4jOw+LOOPZ25C3MmJQ9DmlEWCFDZ7QlqYk
 PZuza3k/ePjOk7PwdiUwADVDVAks2NYMtuTxG4e9CR7sCIelGBqJYxnmCoe/m87JL/Fev4adRke
 KIthqb+lPxZs0uhavg12+0E3cBSSXF27o+XDry1lm4xq59dvzj/ooFI913xS9Ogr3ldXnEF5r2u
 dtTm8EImU2jwVZ92p85WpPXePu2c+8G0SkA2AffQJNnl8SU1PZ3QA3aXZ48OUk1ueVb31hPlecc
 IyFyxp3dmaEjwRlZgrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX7PQ7Vlh/AIZ1
 UuYpT2UOgOgLVkz4TwR3avqZQooLgZIqqKxUTGB/HlY5IW1i2kkGNNrZXOh65EL+2+zbFl0d5ok
 3lbPy+2rgdP9bjonXc7HJnFh4Lw7fq0=
X-Proofpoint-GUID: siw6KG78PlENUt_byyDISTYF-YPldR6s
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6aa171e4 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=lQlWDN6XiApmBSmPJFMA:9 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: siw6KG78PlENUt_byyDISTYF-YPldR6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090165
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Adding proper TCG automated tests to sdext CSRs requires enabling
gdbstub support for riscv64, which we don't have, since the nature of
the CSRs added is that they run in a higher privilege than M mode.

DCSR has bits to allow for context switching from other modes to Debug
mode, but those bits must be set via an external entity (e.g. gdb)
beforehand.

What we can do for now is a "negative" TCG test to ensure that we'll
throw illegal insn traps when trying to write sdext CSRs in machine
mode.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 tests/tcg/riscv64/system/meson.build  |  8 +++
 tests/tcg/riscv64/test-sdext-sigill.S | 83 +++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-sdext-sigill.S

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 8604c2a45a..6a836994e6 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -61,6 +61,14 @@ tests += {
   }
 }
 
+tests += {
+  'test-sdext-sigill.S': {
+    'exe_name': 'test-sdext-sigill',
+    'cflags': cflags + ['-march=rv64gcv'],
+    'qemu_args': ['-cpu', 'rv64,sdtrig=true,sdext=true', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-sdext-sigill.S b/tests/tcg/riscv64/test-sdext-sigill.S
new file mode 100644
index 0000000000..80a6c06465
--- /dev/null
+++ b/tests/tcg/riscv64/test-sdext-sigill.S
@@ -0,0 +1,83 @@
+/*
+ * RISC-V sdext extension "SIGILL" test: check if sdext CSRs
+ * and 'dret' will throw SIGILLs outside of Debug Mode.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.equ CSR_DCSR,      0x7b0
+.equ CSR_DPC,       0x7b1
+.equ CSR_DSCRATCH0, 0x7b2
+
+	.option norvc
+	.text
+
+	.global _start
+
+_start:
+	la t0, trap_handler
+	csrw mtvec, t0
+
+	dret
+	j _fail
+
+	li t0, 1
+	csrw CSR_DPC, t0
+	j _fail
+
+	li t0, 1
+	csrw CSR_DSCRATCH0, t0
+	j _fail
+
+	li t0, 1
+	csrw CSR_DCSR, t0
+	j _fail
+
+	li a0, 0
+	j _exit
+
+_fail:
+	li a0, 1
+
+/* Exit through the semihosting SYS_EXIT_EXTENDED call with a0 as the code. */
+_exit:
+	la	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+
+	.balign	4
+trap_handler:
+	csrr	t4, mcause
+	la	t5, trap_mcause
+	sd	t4, 0(t5)
+	csrr	t4, mtval
+	la	t5, trap_mtval
+	sd	t4, 0(t5)
+	csrr	t4, mepc
+
+	/*
+	 * Skip 2 insns (8 increment in mepc) to skip both the
+	 * insn that caused the trap and the "j  _fail" insn
+	 * that follows it.
+	 */
+	addi	t4, t4, 8
+	csrw	mepc, t4
+	mret
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
+trap_mcause:
+	.space	8
+trap_mtval:
+	.space	8
-- 
2.43.0


