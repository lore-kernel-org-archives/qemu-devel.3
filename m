Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3761107BCF2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oDl-0004UY-Ol; Wed, 18 Mar 2026 06:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oDV-0004Db-3G
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:33:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oDP-0002Zd-Bt
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:33:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso6932459f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773830001; x=1774434801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eb9ND8Ru+1r4jviscKaZSR5cTPKG7MGtBYqAB3umF08=;
 b=yoJEIyZCpfyUSN92drcAdB9HpLKoKVHjLD0C91128k7FpawuS3Q2Q9ULm3cRpG9hGv
 GIMQDBHVEmoOcDh1H2CK7jFJJh9H9tbWMA4qxCNfGyUFEgnicoD++AN8Ul2R/dyanp70
 LhqGpNbNoOxUSb2aJ0n4EZwYQsnErXNms/Oz2onijOUbX8PuUmU4aqyPBARRP9RbRc4A
 GGf++AYIs4kOoZR4EiqXX2uI33TCAnUxk3/B82Lpeue1skE69CbCg0WBvE8zGND7IpNh
 brdmKG/f4HRvkww+GjmHll/imm8F2I+LZsueAZcaIhKot+sH8vp5jSFoT9OPL7lNxwD4
 RbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830001; x=1774434801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eb9ND8Ru+1r4jviscKaZSR5cTPKG7MGtBYqAB3umF08=;
 b=cpvpXzv+i5oDRrEaqUNUrWa8o0vABWuHpMDLuphiTiXceWB06b/4RtjZC1548VWBg+
 O+aJYGxXWWHJ5xDUy5XWI8ClrzM072fWHWcA3Rh/lV28mp44Ck0tCMYi/yW9bBVj4C5Y
 FyQ3A+ohYsU00cr7PlWUpev45n5oF+QLfO9ZzP9iRRAkv55YXdSbISvcRDWutenEXRNy
 kDt1c0HQpyuAS8mkhVSjv7CjWGN4mskAgHHblVdIrD46h042IbJLR5kSlnCXNJWmSVvH
 DfNeD3Zz4xO4UnZ2V/5lR15MnIFsPigLV/f6Y06gjRmLC/CYnnIUiwxxPX2WTofzPfzK
 j7Ow==
X-Gm-Message-State: AOJu0YyhHLyBT6BA9xEM1hdRac5XxKj1BjLMzbyJuskytKPHJ8nL1MQE
 EkInEz2y59r8rJsxJzl/5x3oBt2OvmOkWv1BU+f20fZmap4pmYuumrQ9sDYnyoGvgZIA8rCi3/q
 7vyXB/dM=
X-Gm-Gg: ATEYQzzLIxzyqOHJG4YGuztFZW+TIEqhpfiwxMv1uZb1juCOFNICfX4Idw/ok1Pbjcs
 YY5/KSqN655ZiFCVCj0RInnrUiQf1hX3VZxLFxCO1svoYmpwGcBK/YDcI3SvEvfKQFxAGiDV0rx
 IhbFc7/3mTcCmIfOF2zKTda7WSMEL9MzzXiXQoefXSoDLsU6O+XJsxjMearweGJbNTmcfzeZWa2
 BYska0ORwRlKtW79GRD/uJJRW2uWecJr0Hu5+WAsQR0t1WdhCPkOkc2HEbTX49CSlYrcqfhER0f
 0V6G1l9QkPynt3ld0uE59+Ny42o+g1zkBcCiRC3f8mxYgVIbVo1cFfQH2u4Elpi78vSXycm1CHv
 Y9HWpP/3+N/VMrkF8nKUIMZvR3de4ojHuwCm5XKxHawpC7VjsLEqCMDb/qCZrwzjHtgtlOCC6uE
 9eaTZVP5/TtoMlzbP47W6f3pNXxDB22ni0RKF66b1G7ZI9XXPA2kIlVV4NNMOk9HSBIZ8OocQ/
X-Received: by 2002:a05:6000:40df:b0:439:dfae:8083 with SMTP id
 ffacd0b85a97d-43b527c8185mr4689471f8f.38.1773830001342; 
 Wed, 18 Mar 2026 03:33:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51849636sm6967863f8f.8.2026.03.18.03.33.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:33:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH-for-11.1 16/16] configs/targets: Forbid RISC-V to use legacy
 native endianness APIs
Date: Wed, 18 Mar 2026 11:31:21 +0100
Message-ID: <20260318103122.97244-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All RISC-V related binaries are buildable without a single
use of the legacy "native endian" API. Set the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/riscv32-linux-user.mak | 1 +
 configs/targets/riscv32-softmmu.mak    | 1 +
 configs/targets/riscv64-bsd-user.mak   | 1 +
 configs/targets/riscv64-linux-user.mak | 1 +
 configs/targets/riscv64-softmmu.mak    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/targets/riscv32-linux-user.mak b/configs/targets/riscv32-linux-user.mak
index f069ab9a0f9..d88fdf5e1b2 100644
--- a/configs/targets/riscv32-linux-user.mak
+++ b/configs/targets/riscv32-linux-user.mak
@@ -8,3 +8,4 @@ TARGET_SYSTBL_ABI=32
 TARGET_SYSTBL_ABI=common,32,riscv,memfd_secret
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index 26080599be7..5d5016d0083 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml ri
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
index bc85d9ed04e..5b4e138099f 100644
--- a/configs/targets/riscv64-bsd-user.mak
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
 TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-linux-user.mak b/configs/targets/riscv64-linux-user.mak
index bca08645124..35621520c56 100644
--- a/configs/targets/riscv64-linux-user.mak
+++ b/configs/targets/riscv64-linux-user.mak
@@ -8,3 +8,4 @@ TARGET_SYSTBL_ABI=64
 TARGET_SYSTBL_ABI=common,64,riscv,rlimit,memfd_secret
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 5059c550480..a10dc03c04c 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -6,3 +6,4 @@ TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml ri
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.53.0


