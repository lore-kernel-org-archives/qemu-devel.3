Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A743DC2A074
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vciJc-0000vU-AH; Mon, 05 Jan 2026 06:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJW-0000sW-UO
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:59:56 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJU-0001mq-RK
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:59:54 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so116297485ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 02:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767610790; x=1768215590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W5jhhkMaw17W8AVbfiXx3cwnzurwMC1YXts/xR76cAo=;
 b=W/FnGCxT9lBpH6Au/UzFu+8eBMYVUcNBCMYrDzAjgtak03z1RX1X/k8a6obywJD31u
 MNpqdfsxjTVY9cnFgu3GfTHuEd3rTXiBWCFcpoMDCJpcRWpgAqy6tuG6jJDPaAfU7maW
 EUz7AEY9ULzAnx9R1I66ps7MbY1LQADXoPTpPsGdpdgIFz0+VMpeuIQTNCM1i5iFsIcu
 gUzpuLUGvjGCJF+9qxJ4FgHQjgLj/MYO3vg/CVl3gZrHCPyvJMh75GLnwAJEkey/iZqS
 G91Hf4q+EWh0u7eSiNZtyljXKOVXxMfTPpFMFY7r8goN+qCkhztn7yq/lXT7VsGTqYC5
 e/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767610790; x=1768215590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5jhhkMaw17W8AVbfiXx3cwnzurwMC1YXts/xR76cAo=;
 b=BZWcEtiPtVYqnzYdjbESvqSe527un0PN6AnVT9EqWKsHfyfGOTzbp1cE65wCJls1ly
 agYS0z9a1uSY5kLa26GEpQAvMX5yQXOPHB7NsODL9KZ1I0Px9HlBibrHrlKsfs7KzoOP
 pevJZ424Zgzy0FyCvRGIIG3Cjw0X3CPDQ2V70Rx4CEZsFQ7wyIQPrWGTmY92cEv85g1l
 AD5Vi8BEBwwkg0VC1+vX2L50zDcBs4yIaejeIslpp9BsnNC1Bv1SQcJ3PoOijKxcwoRr
 QGDxcYPYhaWHVAWdwIviGGr5Hrif0rA2bRHtmiJAJYzzMxDX2DS2RQ3orLwYZaBpY6/H
 fMeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX77O2zxpiMuoU8zI2LPSWodY9n9OrsSSA7QziTQi34P/dRL27aA+6XVsiaRZyK2rTqqSIAzxJqRfaK@nongnu.org
X-Gm-Message-State: AOJu0Yw3+/gBriEnduuEJuESyqa7Z4Ft9zjBk/7Wj9T2TFfG3/56upCF
 EFcELzFxLr8fyYihzlL5NyJ9iCVXray/oLVR5HQBPsPbf70FXHY+HjKVPzDkNUdckGg=
X-Gm-Gg: AY/fxX7plPyyAMnHXFrCG0sjWKGrvuhQkkCnnR3Aff7qt4tmZqLopQf5IWcqwOKt9Aq
 bILj+YCFD1ojaH4Jvmp4284nTNhZ7NFKLoF9ckIMH19BQxURqFmCFp/UmH+QdyZoCrsez3WNUnM
 obvR9PxF1IUORCMFjNXqKJEo4FSwj16+TaCzFSdZVOlPYOgeBH20YR1HsdH4CmcEwzJcWjf9MEt
 TgP/0WRTNDNGofLzbMiDBbsF+OcNDtAxRlcohiqwgxWHnSi4HMrrdgsBkcZpTwa7REV1avufRgY
 qDpY5PYJYys2P+XScNAAAL8W+o6gacOdLXh8yLvR3Y0JoqQsS6AZ/gDWf2kuyp47aEj1oRgGEZB
 mybgKhigTs9CpY3b5B90syeJXrdgbgcNUvGUj/A+c3MWyueIDUjCOsnrBMQ4N5uzIpN7qJgPVXU
 VaBAVg+any0bdSmsZ/rspiEPQjfJE79hsWFlgH
X-Google-Smtp-Source: AGHT+IEkGPJyA5YQ/q2gYdVF4ex+qcSlTxC7m+3+zKD4AyAswDUOowtrb0YXIDhVBAtVCTaCzVLUew==
X-Received: by 2002:a17:902:ce92:b0:295:3584:1bbd with SMTP id
 d9443c01a7336-2a2f2836dfamr456633155ad.41.1767610789861; 
 Mon, 05 Jan 2026 02:59:49 -0800 (PST)
Received: from hsinchu18.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c6661esm440193975ad.2.2026.01.05.02.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 02:59:49 -0800 (PST)
From: Kito Cheng <kito.cheng@sifive.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 kito.cheng@gmail.com, Kito Cheng <kito.cheng@sifive.com>
Subject: [PATCH 0/5] target/riscv: Add arch= CPU property for ISA configuration
Date: Mon,  5 Jan 2026 18:59:35 +0800
Message-ID: <20260105105940.3567112-1-kito.cheng@sifive.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=kito.cheng@sifive.com; helo=mail-pl1-x62f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Motivation
==========

Here is the motivation for this patch set. Please try to answer the
following 3 questions without checking QEMU source code:

1. How do you run RISC-V QEMU with a specific extension configuration?
   Please try to configure an rv64im user mode QEMU before you answer
   this question.
2. How do you know which extensions are supported in RISC-V QEMU?
3. How do you know which extensions are enabled in the current RISC-V QEMU?

And here are my answers to those 3 questions:

1. It's hard to configure RISC-V QEMU with a specific extension. The
   correct way to configure rv64im is:

     qemu-riscv64 -cpu rv64,a=false,d=false,f=false,zfa=false,zawrs=false,\
       c=false,zifencei=false,zicsr=false,zihintntl=false,zihintpause=false,\
       zbb=false,zba=false,zbs=false,zbc=false,zicbom=false,zicbop=false,\
       zicboz=false

   I've seen 4 different QEMU wrappers to handle arch string to QEMU CPU
   option: 3 in-house scripts, 1 open source script in riscv-gnu-toolchain,
   and I guess some vendors/developers may have their own scripts to do
   that as well...

2. I don't know a better way other than reading the QEMU source code.

3. I don't really know the answer...

So how do other tools/simulators address these problems? Toolchains like
Clang and GCC use -march with an arch string to configure, and Spike uses
--isa=<ISA-string> to configure.

Could we introduce a similar way to configure QEMU? Yes, I think we can.
That's what this patch set does.

  -cpu rv64,arch=<ISA-string>

to configure QEMU. And also introduce arch=help and arch=dump to show
which extensions are supported, and which extensions are enabled/disabled.

Also supported:

  arch=<profile>["_"optional-ext]*

to specify configuration with RISC-V profiles like the toolchain convention[1].

[1] https://github.com/riscv-non-isa/riscv-toolchain-conventions/blob/main/src/toolchain-conventions.adoc#specifying-the-target-profile-with--march

Overview
========

This patch series introduces the arch= CPU property for RISC-V, providing
a convenient interface to configure ISA extensions similar to GCC/Clang's
-march option.

The arch= property supports the following modes:

1. arch=dump
   Print the current ISA configuration and exit. Shows the full ISA string
   and the status of all supported extensions.

   Example:
     $ qemu-riscv64 -cpu rv64,v=true,arch=dump /bin/true

2. arch=help
   Print a list of all supported ISA extensions and exit. Lists standard
   single-letter extensions, multi-letter extensions, vendor extensions,
   profiles, and vector length extensions.

   Example:
     $ qemu-riscv64 -cpu rv64,arch=help /bin/true

3. arch=<ISA-STRING>
   Configure extensions using a standard RISC-V ISA string. The format is
   rv{32|64}[single-letter-exts][_multi-letter-ext]*.

   Key features:
   - First extension must be i, e, or g (base ISA requirement)
   - Single-letter extensions can be concatenated (rv64imafdc)
   - Single-letter extensions can use underscore separators (rv64i_m_a_f_d_c)
   - Multi-letter extensions are separated by underscores (_zba_zbb)
   - Single-letter can transition directly to multi-letter (rv64imazba)
   - Extensions i, e, g can only appear as the first extension
   - When arch= is specified, all extensions are first reset to disabled
   - G expands to imafd_zicsr_zifencei
   - B expands to zba_zbb_zbs

   Examples:
     $ qemu-riscv64 -cpu rv64,arch=rv64gc_zba_zbb /bin/true
     $ qemu-riscv64 -cpu rv64,arch=rv64imafdc_zba_zbb_zbc /bin/true

4. arch=<PROFILE>[_extension]*
   Configure the CPU using a standard RISC-V profile, optionally with
   additional extensions. Available profiles (64-bit only):
   - rva22u64, rva22s64, rva23u64, rva23s64

   Examples:
     $ qemu-riscv64 -cpu rv64,arch=rva23u64 /bin/true
     $ qemu-riscv64 -cpu rv64,arch=rva23u64_zbkb_zkne /bin/true

5. zvl*b extensions
   Specify vector length (VLEN) in bits using zvl<N>b where N is a power
   of 2 (32-65536). Requires v or zve* extension.

   Examples:
     $ qemu-riscv64 -cpu rv64,arch=rv64gcv_zvl256b /bin/true
     $ qemu-riscv64 -cpu rv64,arch=rv64i_zve64f_zvl128b /bin/true

Individual extension properties (e.g., zba=true) can be combined with
arch= and will override the ISA string settings when specified after arch=.

Kito Cheng (5):
  target/riscv: Add arch=dump CPU property for ISA introspection
  target/riscv: Add arch=help to list supported ISA extensions
  target/riscv: Add arch=ISA-STRING to configure extensions via ISA
    string
  target/riscv: Add arch=PROFILE to configure CPU using RISC-V profiles
  target/riscv: Add zvl*b extension support in arch= property

 docs/system/target-riscv.rst              | 144 ++++++++
 target/riscv/cpu.c                        | 226 ++++++++++++
 target/riscv/cpu.h                        |   1 +
 target/riscv/cpu_cfg_fields.h.inc         |   3 +
 target/riscv/tcg/tcg-cpu.c                | 424 ++++++++++++++++++++++
 tests/functional/riscv32/meson.build      |   4 +
 tests/functional/riscv32/test_cpu_arch.py |  94 +++++
 tests/functional/riscv64/meson.build      |   4 +
 tests/functional/riscv64/test_cpu_arch.py | 411 +++++++++++++++++++++
 9 files changed, 1311 insertions(+)
 create mode 100644 tests/functional/riscv32/test_cpu_arch.py
 create mode 100644 tests/functional/riscv64/test_cpu_arch.py

--
2.52.0


