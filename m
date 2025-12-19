Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6AFD78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfqn-0000gu-J1; Fri, 19 Dec 2025 14:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqU-0000a9-2G
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:59 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqR-0006nh-Dl
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:08:57 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so5828385e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171334; x=1766776134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xcl/NcnZq+Yw1+rjIKIhMTpPXI+v2+IMfgdqzPS39Rg=;
 b=xxfp/h0Z3ibr1RqS4h05TABZ06nVLAr+Sa/e8GmNp6/QYWhrCaWR8UroZE/7Adkv3/
 WkN2NgIw3iP1csoQ1EwbHDCRmUcrmM34NDZrk+e1dj+QslrWsC/yWK9EaGZzNtcsKodS
 FrI7OVCynxisLA/p48J/yqJFnrMc2lbfl4/oYDjlRWA2A0p+BuC9/jm/N8FzHUJDR78s
 IeDJan8FAg5Xju7n007ERoULvNhHk27w7laKLMzPS6fEfFD216iQg5cl/Wvjq5kwP9y3
 2z+h6KdzlR7e+LmGibhTFCg17tEMbRgEhVeckTOJ/6fixtBobwPSun4n8r+EYDXolhnl
 9ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171334; x=1766776134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xcl/NcnZq+Yw1+rjIKIhMTpPXI+v2+IMfgdqzPS39Rg=;
 b=VOMSRXQql/pxJScekXh085LDruM2PbMdqd16anX+rzH2EArTcQi7uRVGOV3pB/NrEB
 zUYDbbhoX3Cm6Z2vLpRgwJ8sPxTgHVy2vTblPwvY6oRSU9lG3R878R99xn6LNVzE10jT
 /7KNu2Xs8P70qfsdTEYa6cwmlnj91ME14eVFQFxChYr31KICgYekB25K9sqiJqYhsL3T
 BPPePvRhudnOCZR1vZZxPOW8BsfarfiOQkEbRBskRTf9aIpJ/y4d3by9ND1ICwktYPRW
 wORPwqjMPgy0x1Z4kOjBr4qY7lbNua073RM31fDabgTqIiG6ht4UTS6PiPO4eSysx1f3
 h5nQ==
X-Gm-Message-State: AOJu0YxRmm2e0nKsEf0CAl2IEtDxJkRMD2R+sjcBNC78/s4zsb7Qpbg6
 eAowbbBwW9oz6oA6/Sy+OYV6hQ4kjbonOW8rSTcVrnxTDBWxLTarTdteSjw97Jbluz0=
X-Gm-Gg: AY/fxX6ZMibHli53d+kL0+Elkadkv9kBwrQNdpecs92Mgrn8uliBByq1eRmPD6W0Z+6
 gt4Jk2aeDcka1MhuH/ptyXRBgwevM6hAP+IXzSANUhvA7L6Mh/3zjI5B7u6xMZGPDHAwmEpqAer
 bBnt462AaMwWKJjKOKuOMwEu/L6/oG8tsBNoPVme97H1EnH40nXLc3vp8xEq9HU7kbo2Mc2pVsM
 LTb3z5VmTxdXTiyMybjRNnOxXUyMA2ukNWRedXlwS61kaEaKUUQZWwQSFOfnjSfZXjIgpoEuw5r
 O/Ht9LdWsDChtAOvmX4LbwxYclMZ7uah1gfNjjlxi8p8qjfPtbx2gNkm7ZTF0faZ75LNS5j8oio
 lmKhgGnOL92Cp3R0u+RpOCqms+rpYEB03Thjeqd+xhpAd5dtBbDM99i2aEFqi4Jbk7d2RTe4IV9
 VUpcCpNrJmgYc=
X-Google-Smtp-Source: AGHT+IEn6/o5m3w4bAtn8aYXnG+dpd4OxZZ4P45xd7eYmqnhHtJDDRvtbEREQlfI/ePY3eM5rXprFA==
X-Received: by 2002:a05:6000:2c06:b0:430:fd0f:28ff with SMTP id
 ffacd0b85a97d-4324e4d3764mr4390225f8f.26.1766171333577; 
 Fri, 19 Dec 2025 11:08:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1af20sm5962153f8f.2.2025.12.19.11.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D2B845F879;
 Fri, 19 Dec 2025 19:08:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 00/12] plugins/next - fixes, sysfilter and vcpu_init tweaks
Date: Fri, 19 Dec 2025 19:08:37 +0000
Message-ID: <20251219190849.238323-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

I thought I'd post the current state of the plugins/next tree for
comments and reviews.

Firstly we have a bunch of fixes for the hotblocks plugins from Alex
Bradbury.

We also have Ziyang Zhang's syscall filter patches which allow plugins
to filter (and/or replace) syscalls. The initial use for this would be
for something like Lorelei:

  https://pretalx.com/kvm-forum-2025/talk/KFSGHS/

where using plugins avoids needing to integrate complex logic into
linux-user itself. No doubt the reverse engineers would also find the
capability useful.

There is also a discussion thread about a general purpose PC setting
patch:

  Message-Id: e64f4a1f-ac43-487b-f0af-08de04dbd9f1
  Subject: [RFC PATCH v2 0/2] Enable PC diversion via the plugin API
  From: Florian Hofhammer <florian.hofhammer@epfl.ch>
  Date: Mon, 6 Oct 2025 15:21:21 +0200
  Message-ID: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>

but as we still need to work out a nice way to handle removing the PC
from the register list I've left that out for now.

Finally I was doing some hacking around on my kvm/trap-me-harder
patches and I wanted to check when IRQ's occurred and what systems
registers were touched when. I then discovered that the ICC_ registers
were not available to plugins due to being created after the CPUs are
initialised. I've tried several approaches but it seems having a clean
vCPU initialisation after machine creation is tricky so instead I've
split the hooks into creation and reset and moved the plugin visable
callback to reset. However this may change the assumptions about what
to do in vcpu_init.

You can see some of the ugliness in the new systrace plugin which has
to jump through hoops to deal with the fact the number of registers it
can see changes several times. Unfortunately this seems to trigger a
corruption bug which I haven't nailed down yet while running:

./qemu-system-aarch64 \
                  -machine type=virt,gic-version=3 \
                  -cpu neoverse-n1 \
                  -smp 4 \
                  -serial mon:stdio \
                  -m 1024 \
                  -accel tcg \
                  -kernel ~/lsrc/linux.git/builds/arm64.initramfs/arch/arm64/boot/Image.gz \
                  -append "console=ttyAMA0" \
                  -display none -d unimp,plugin,cpu_reset -plugin ./contrib/plugins/libsystrace.so,show_frompc=on,tracksw=msr,reg=icc\* -D boot.log

I'm open to better ideas about how to solve this particular problem.

Anyway happy holidays everyone, see you all in the new year ;-)

Alex.

Alex Bennée (5):
  plugins: shorten aggressively long name
  plugins: split init_hook into create and reset
  target/arm: defer creation of gdb register until machine created
  contrib/plugins: add systrace plugin for tracking exceptions and irqs
  target/arm: allow gdb to read ARM_CP_NORAW regs (!upstream)

Alex Bradbury (5):
  contrib/plugins/hotblocks: Correctly free sorted counts list
  contrib/plugins/hotblocks: Fix off by one error in iteration of sorted
    blocks
  contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than
    PRId64
  docs/about/emulation: Add documentation for hotblocks plugin arguments
  contrib/plugins/hotblocks: Allow limit to be set as a command line
    argument

Ziyang Zhang (2):
  linux-user: add plugin API to filter syscalls
  tcg tests: add a test to verify the syscall filter plugin API

 docs/about/emulation.rst                      |  12 +
 include/qemu/plugin-event.h                   |   1 +
 include/qemu/plugin.h                         |  52 +-
 include/qemu/qemu-plugin.h                    |  40 +-
 include/user/syscall-trace.h                  |  17 +
 contrib/plugins/cflow.c                       |  22 +-
 contrib/plugins/hotblocks.c                   |  20 +-
 contrib/plugins/howvec.c                      |   2 +-
 contrib/plugins/stoptrigger.c                 |  10 +-
 contrib/plugins/systrace.c                    | 572 ++++++++++++++++++
 hw/core/cpu-common.c                          |  21 +-
 linux-user/syscall.c                          |   7 +-
 plugins/api.c                                 |   9 +-
 plugins/core.c                                |  68 ++-
 target/arm/cpu.c                              |  33 +
 target/arm/gdbstub.c                          |   6 +-
 target/arm/helper.c                           |  15 +-
 .../multiarch/test-plugin-syscall-filter.c    |  35 ++
 tests/tcg/plugins/discons.c                   |  18 +-
 tests/tcg/plugins/inline.c                    |   6 +-
 tests/tcg/plugins/insn.c                      |   5 +-
 tests/tcg/plugins/syscall.c                   |  19 +
 contrib/plugins/meson.build                   |   2 +-
 tests/tcg/multiarch/Makefile.target           |   4 +-
 24 files changed, 922 insertions(+), 74 deletions(-)
 create mode 100644 contrib/plugins/systrace.c
 create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c

-- 
2.47.3


