Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF645FD88DA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XF-0003wi-C6; Tue, 10 Mar 2026 21:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XD-0003wO-Sn
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:51 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XB-0004nB-GO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:51 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c73ba417c6eso1047774a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193127; x=1773797927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iMWyjazZriGwsm1hXkdnzaZfVyQRbNSMbQT1SiBcR+E=;
 b=DB3eeUbEtMufYBzvdyN7czW524hiRs1Ht1w37zjUXMqsqLIcMwYoxwneogoJ54GtF1
 DrMjQteXTSMRneDNLmIEKk77OhkJ48Z3gSCMM0Nbb3zNFJOh+2NIbJvvU0qaU8Xp7Vmk
 BZ89q8DBgJAfU74fX9T91w/i87aR7SabNGg/Gk9W2lvL1afzCF49nVLVqk185xwBzsDZ
 PCqpdgLsaJktutRLxglSu6B0/nLl4URG2qOy37WKwD35VxeLLDgHNZzai1pRl19J4E5j
 y2khAjnfkXQ6e+P6bn3PLidwhusx27KDKPqXq927mbYKn1XqxVScy+tadzyD/Tg0z0XD
 +GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193127; x=1773797927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMWyjazZriGwsm1hXkdnzaZfVyQRbNSMbQT1SiBcR+E=;
 b=Do3dmgt2b3DwTMrMMarGUKUlBPWJwwvQxm8PryCLU/iJXt93YZmY2+lD/tWOlPBSW2
 RakgJy+7caJsmaRuWmMllwumahD89Oa3niSXKeczoUWWQglz1BhZtcmrYgxYNf0QpoB5
 NWzv1hp782/XFbNtEPlBSUTogDp+whSSMkNknWY/9tiT6h8FCB052aJAlc734n7LEP+2
 5voVudSJzJUXU/IrtcU4/DIYQOauTjc7zi9eB3zzseaEaYw50WMXcW7O6guDMwiDUiRb
 kKvhxR+N/EU9FPh6+wLAinPYxvLHRYgxovimUPcOODISdTPOZc8YZ65WhgtSIV9+G4iy
 95eg==
X-Gm-Message-State: AOJu0YwaLp3m2CAnKRAWX6RgpU8prnGsuebxuVu4MxEOJ5lqVbE6LM8i
 /ei7ivUoaaAbwjQ7QjDIEeHc15oKHQ+JQhrRljgJso7Qn09umJ+AiCpKnLqOHfCObJzs2nbXLAJ
 jhx70
X-Gm-Gg: ATEYQzyXdpQRevIF38eqx9P83BEXXMG41ChDh97EPdUICsdnWcZbHfZzaZJN1Bi/dUt
 OhBZYYxnRCke+WkWm5tgEjgFZ6dfk7sKda62ET1FEjH2u+Mt37uvN4jrRpD52WUR3eM0zYOHFej
 8I+SJK79YdTA835KDX8AMpNqs/2TVacAIa3dX6tLMKbJmxNIixUr+Gtu9fbNs0k7YgYrTm2kDnz
 /Xf0NG63oiuTz8e0ewG6BvGApUTKhGNrMkQj4I4EkDf921GpqihDcKJVhwFliv1lxV973ZIuhQO
 u/9J9dqgFYDhNz4Ajz/xC1/OaH1G2nDTAHndMSdc4cb1PkmCAMoogxnTnnOs9EbdvTbbsavAuhp
 AvGhmRzo8jZ3qBk94ifYdCVIm3hbnIpurv16XGWa4QQTpcA5IgQfl78wVo0WQmSHO59fT4ppnKy
 6GIwGyVRZWmWdWqsyPkelAo7lh0I5V05O6VHpM3SMze86xVM9+tlnS8oeL+hzRXAtJP17FNknmV
 nda
X-Received: by 2002:a17:902:e845:b0:2ae:5aed:1f4d with SMTP id
 d9443c01a7336-2aeae8e1010mr7964885ad.42.1773193127170; 
 Tue, 10 Mar 2026 18:38:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 00/16] gdbstub: Always infer base register index from GDB XML
Date: Tue, 10 Mar 2026 18:38:21 -0700
Message-ID: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

The following changes since commit ae56950eac7b61b1abf42003329ee0f3ce111711:

  Merge tag 'firmware-20260310-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-03-10 13:32:30 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-gdbstub-20260310

for you to fetch changes up to 6511d4eed79a7e59f03e661f31924277e4d6e600:

  gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[] (2026-03-10 17:12:18 -0700)

----------------------------------------------------------------
- [PATCH v4 00/16] gdbstub: Always infer base register index from GDB (=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>)
  Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-1-philmd@linaro.org

----------------------------------------------------------------
Alex Bennée (1):
      tests/docker: add gdb-multiarch to all-test-cross

Philippe Mathieu-Daudé (15):
      tests/tcg: Temporary disable multiarch tests for PPC targets
      tests/tcg: Disable prot-none test on GitLab
      target/i386/gdbstub: Remove stale comment
      meson: Restrict gdbstub to user/system builds
      gdbstub: Simplify gdb_init_cpu() logic
      gdbstub: Add trace events for around XML parsing / generation
      gdbstub: Have scripts/feature_to_c.py generate more verbose output
      gdbstub: Make base register explicit in m68k GDB XML files
      gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
      gdbstub: Emit base_register index in GDBFeature entries
      gdbstub: Consider GDBFeature::base_reg in gdb_register_coprocessor()
      tests/tcg: Re-enable disabled multiarch tests for PPC targets
      gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
      gdbstub: Move gdb-xml/ within gdbstub/
      gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]

 MAINTAINERS                                        | 19 +++++------
 docs/devel/codebase.rst                            |  2 --
 configs/targets/aarch64-bsd-user.mak               |  2 +-
 configs/targets/aarch64-linux-user.mak             |  2 +-
 configs/targets/aarch64-softmmu.mak                |  2 +-
 configs/targets/aarch64_be-linux-user.mak          |  2 +-
 configs/targets/alpha-linux-user.mak               |  2 +-
 configs/targets/alpha-softmmu.mak                  |  2 +-
 configs/targets/arm-bsd-user.mak                   |  2 +-
 configs/targets/arm-linux-user.mak                 |  2 +-
 configs/targets/arm-softmmu.mak                    |  2 +-
 configs/targets/armeb-linux-user.mak               |  2 +-
 configs/targets/avr-softmmu.mak                    |  2 +-
 configs/targets/hexagon-linux-user.mak             |  2 +-
 configs/targets/i386-bsd-user.mak                  |  2 +-
 configs/targets/i386-linux-user.mak                |  2 +-
 configs/targets/i386-softmmu.mak                   |  2 +-
 configs/targets/loongarch64-linux-user.mak         |  2 +-
 configs/targets/loongarch64-softmmu.mak            |  2 +-
 configs/targets/m68k-linux-user.mak                |  2 +-
 configs/targets/m68k-softmmu.mak                   |  2 +-
 configs/targets/microblaze-linux-user.mak          |  2 +-
 configs/targets/microblaze-softmmu.mak             |  2 +-
 configs/targets/microblazeel-linux-user.mak        |  2 +-
 configs/targets/or1k-linux-user.mak                |  2 +-
 configs/targets/or1k-softmmu.mak                   |  2 +-
 configs/targets/ppc-linux-user.mak                 |  2 +-
 configs/targets/ppc-softmmu.mak                    |  2 +-
 configs/targets/ppc64-linux-user.mak               |  2 +-
 configs/targets/ppc64-softmmu.mak                  |  2 +-
 configs/targets/ppc64le-linux-user.mak             |  2 +-
 configs/targets/riscv32-linux-user.mak             |  2 +-
 configs/targets/riscv32-softmmu.mak                |  2 +-
 configs/targets/riscv64-bsd-user.mak               |  2 +-
 configs/targets/riscv64-linux-user.mak             |  2 +-
 configs/targets/riscv64-softmmu.mak                |  2 +-
 configs/targets/rx-softmmu.mak                     |  2 +-
 configs/targets/s390x-linux-user.mak               |  2 +-
 configs/targets/s390x-softmmu.mak                  |  2 +-
 configs/targets/sparc-linux-user.mak               |  2 +-
 configs/targets/sparc-softmmu.mak                  |  2 +-
 configs/targets/sparc32plus-linux-user.mak         |  2 +-
 configs/targets/sparc64-linux-user.mak             |  2 +-
 configs/targets/sparc64-softmmu.mak                |  2 +-
 configs/targets/x86_64-bsd-user.mak                |  2 +-
 configs/targets/x86_64-linux-user.mak              |  2 +-
 configs/targets/x86_64-softmmu.mak                 |  2 +-
 meson.build                                        | 12 +------
 include/exec/gdbstub.h                             |  4 +--
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c          |  0
 gdbstub/gdbstub.c                                  | 38 ++++++++++++++--------
 target/arm/gdbstub.c                               | 21 +++++-------
 target/arm/gdbstub64.c                             | 19 ++++-------
 target/hexagon/cpu.c                               |  2 +-
 target/i386/gdbstub.c                              | 12 +++----
 target/loongarch/gdbstub.c                         |  6 ++--
 target/m68k/helper.c                               |  4 +--
 target/microblaze/cpu.c                            |  3 +-
 target/ppc/gdbstub.c                               | 11 +++----
 target/riscv/gdbstub.c                             | 18 ++++------
 target/s390x/gdbstub.c                             | 15 ++++-----
 target/sparc/gdbstub.c                             | 12 +++----
 {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml       |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml       |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-pauth.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml        |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-core.xml          |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-m-profile-mve.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-m-profile.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml          |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-vfp-sysregs.xml   |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml           |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml          |  0
 {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml           |  0
 {gdb-xml => gdbstub/gdb-xml}/cf-core.xml           |  0
 {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml             |  2 +-
 {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml       |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-32bit-linux.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml        |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-64bit-apx.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-64bit-linux.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml        |  0
 {gdb-xml => gdbstub/gdb-xml}/loongarch-base32.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/loongarch-base64.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/loongarch-fpu.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/loongarch-lasx.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/loongarch-lsx.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml         |  0
 {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml           |  2 +-
 {gdb-xml => gdbstub/gdb-xml}/microblaze-core.xml   |  0
 .../gdb-xml}/microblaze-stack-protect.xml          |  0
 {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml         |  0
 {gdb-xml => gdbstub/gdb-xml}/power-altivec.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/power-core.xml        |  0
 {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml         |  0
 {gdb-xml => gdbstub/gdb-xml}/power-spe.xml         |  0
 {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml         |  0
 {gdb-xml => gdbstub/gdb-xml}/power64-core.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-cpu.xml   |  0
 {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-fpu.xml   |  0
 .../gdb-xml}/riscv-32bit-virtual.xml               |  0
 {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-cpu.xml   |  0
 {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-fpu.xml   |  0
 .../gdb-xml}/riscv-64bit-virtual.xml               |  0
 {gdb-xml => gdbstub/gdb-xml}/rx-core.xml           |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml          |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml           |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml          |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml           |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-virt-kvm.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml         |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml           |  0
 {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml       |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml       |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml       |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml       |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml       |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml       |  0
 gdbstub/meson.build                                | 23 +++++++++++++
 gdbstub/trace-events                               |  7 ++++
 scripts/feature_to_c.py                            | 14 +++++---
 stubs/meson.build                                  |  2 --
 .../dockerfiles/debian-all-test-cross.docker       |  1 +
 tests/lcitool/refresh                              |  1 +
 tests/tcg/multiarch/Makefile.target                |  7 ++++
 129 files changed, 179 insertions(+), 168 deletions(-)
 rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-pauth.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile-mve.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp-sysregs.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/cf-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml (93%)
 rename {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit-linux.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-apx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-linux.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base32.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base64.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lasx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lsx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml (93%)
 rename {gdb-xml => gdbstub/gdb-xml}/microblaze-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/microblaze-stack-protect.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-altivec.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-spe.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power64-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-virtual.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-virtual.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/rx-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-virt-kvm.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml (100%)

