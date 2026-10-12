Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970BACA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJRk-0005OF-Nl; Mon, 12 Oct 2026 13:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRP-0005DW-S4
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRH-00075n-VD
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:03:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so1156459f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824629; x=1792429429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZBeoqsuLlvT9DZ1W3YVZQU/yAZaDmhpUannbrhcqvH4=;
 b=lhwj0WQJZibAg3uXUxOrxWLFylJe2oajaCkKFlo5d3J+B6CylhHmdC4jATzgnxmaDB
 Y4EbYKzt3Ho0+/aJIzKntyuua+KuJvIS0+6nxT34dCxJf7AVlAUZrziVm+Uqh2l7W10L
 ZCXjTzuLE4PAWMMSzu73s6q5oPeTp+eZvb781NEewIz6JMK310akyEx0IkEljAvJNNF/
 /KrGAOeqvsLjTbHPdz7b4PIK6Qm0gJQf0KoLl2eodiqIdtpa6JnOa03mWTiabMqmE8cU
 2uFEyFc8/VP087OAwVhFe+4DCvfkQav8oaBDwobokcLxY20+9z83PUAd6nkhpCNKeLSG
 encQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824629; x=1792429429;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZBeoqsuLlvT9DZ1W3YVZQU/yAZaDmhpUannbrhcqvH4=;
 b=SYRNHSaaFKYttd/z5dhAcNZrmLvx8epF1BkTFGAKF85u4nU0NgWBpxKl14jVrfDBWY
 a6eV9SNhVRC6nLAPrQKVjpFhN10AMp/5SgZPDnWIHCot4LQRR2bhYycDR4E1MZ3vG4kJ
 K3ULzuDTzkEJHR9ZNBzfV+21Jvz0GxtRKiyDwE5BJnNH+iTv0VQM8lIdpKIVX5Gg/PdR
 nRLzzt5XW7T8qQpX4N8SFAFr7mc1EVle29TV0OcjHuLp+oibgMqo0hVnEpPTlnKybV8q
 SgJTUL4tfDGuH4N5d/g6T0w21oHU4IQLMgPg6+zj2mtiOrFpvrnvbhZKXuAHE46VFs/2
 A9ig==
X-Gm-Message-State: AFq9FYJgpp5jsrmr+MBOlikX443W5Xx5Ah3GoOtffcGI1M1Z9ek//tSi
 y1b+Ks6ji/cUKyncArPzyZYhMsqMKt2lBliJNBcaIcynrmARntnDR3JEsAPiN64jmX8=
X-Gm-Gg: AYBFou2cRShNHgme9xJIdaEPupowPWB660jxgKUoXgjgtFGVyn6eTA2EdyB3VuOtTct
 O1HEGpVdoGR5Igjy2UWYA47dU4HagcVWS8ZQNaEnxA4Xysc5ZV5w7iPHInkBktEujRMQFZfGQYq
 kKgsLccwEGPjmZfR/LZGFVzaGHt/i/DpSFQDA8Np7g7t5r54eE8nLtyjKaJuDRrZO3txerDWZEA
 F1Xj2I4i+47HituRN5x0b+p5pVRf15VC0hd3CwqWlUXtSJU4cUy+FMLr/SR2s/GueEsxYcoAXPC
 gJz/OPBz4dLs0G4WCZhhwLeBWkFD95t1tifFq2TpAOJv7KdUYT5CYwAUKJNlbV4C5NO/oCvMm8b
 d03DDprkzUVaQGzDHOskURk+4qqI9LkV+qFGjAYFLsbl08QZ0sCoYbplXfaT9ga+qkS7s/o5RgL
 qmjfgPP7uqht/2BqsR0xprsXdwCY0LyLIfvE8MwgqsSjH1+EhFa5a/i43BwfT2SredzC3TDzcnd
 h5DQAgK
X-Received: by 2002:adf:e185:0:b0:48b:3f2:2ec7 with SMTP id
 ffacd0b85a97d-48dbacfe69cmr19116879f8f.31.1791824629276; 
 Mon, 12 Oct 2026 10:03:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab5b03sm474700f8f.30.2026.10.12.10.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 075FF5F808;
 Mon, 12 Oct 2026 18:03:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 00/16] testing/next: functional testing updates for gdb
Date: Mon, 12 Oct 2026 18:03:14 +0100
Message-ID: <20261012170330.1144446-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi,

This is the current state of my testing/next tree. There a are a few
minor tweaks and fixes that I've picked up. The majority of the new
code adds testing for the gdb stub when used via KVM.

As a result I spoke to Anders who handles the tuxrun images and he was
able to turn on debugging symbols and provide a vmlinux alongside the
bootable image. With these updates I was able to resurrect the old
test script I was running by hand and then plumb it into a functional
test.

So far I've done x86_64, aarch64 and s390x. I can't test ppc because
our CI machines don't support nested KVM. I don't have access to any
riscv kvm capable hardware.

The reason I went on the side-quest is because when working on
cleaning up QEMU's internal KVM api I realised that quite a large
chunk of it is not exercised by our functional tests. This would
ensure that at least:

  kvm_arch_update_guest_debug
  kvm_arch_get_registers
  kvm_arch_set_registers

is exercised and I'm less likely to break things in my re-factor ;-)

v2

  - fixed up the sh4 direct call
  - dropped the fw tracing test case as tuxrun images cover it all
  - added aarch64 and s390x cases
  - worked around s390x watchpoint issues

The following still need review:

  tests/functional: add tuxrun kvm gdb test for s390x
  tests/functional: update s390x tuxrun images
  tests/functional: split s390x tuxrun into tcg and kvm run
  tests/functional: add tuxrun kvm gdb test for arm64
  tests/functional: update arm64 tuxrun images
  tests/functional: teach tuxrun about launching gdb tests
  tests/functional: allow tuxrun tests to be passed "accel"

Alex.

Alex Bennée (15):
  tests/functional: test_acpi_bits requires TCG
  meson: move gdb detection into the top level build file
  tests/functional: allow tuxrun tests to be passed "accel"
  tests/functional: split x86_64 tuxrun into tcg and kvm run
  tests/functional: update x86_64 tuxrun images
  tests/guest-debug: add --kargs option to run-test
  tests/guest-debug: add --symbols option to run-test
  tests/functional: teach tuxrun about launching gdb tests
  tests/functional: add tuxrun kvm gdb test for x86_64
  tests/functional: split aarch64 tuxrun into tcg and kvm run
  tests/functional: update arm64 tuxrun images
  tests/functional: add tuxrun kvm gdb test for arm64
  tests/functional: split s390x tuxrun into tcg and kvm run
  tests/functional: update s390x tuxrun images
  tests/functional: add tuxrun kvm gdb test for s390x

Max Filippov (1):
  tests/tcg: fix buffer overflow in multiarch/linux/linux-sigrtminmax

 meson.build                                   |  15 +-
 tests/tcg/multiarch/linux/linux-sigrtminmax.c |   2 +-
 tests/functional/aarch64/test_tuxrun.py       |  35 +++-
 .../functional/gdb-scripts/kernel_gdb_test.py | 176 ++++++++++++++++++
 tests/functional/meson.build                  |   5 +-
 tests/functional/qemu_test/tuxruntest.py      | 103 +++++++++-
 tests/functional/s390x/test_tuxrun.py         |  33 +++-
 tests/functional/sh4/test_tuxrun.py           |   2 +-
 tests/functional/x86_64/test_acpi_bits.py     |   3 +
 tests/functional/x86_64/test_tuxrun.py        |  45 ++++-
 tests/guest-debug/run-test.py                 |  10 +
 tests/tcg/meson.build                         |   5 -
 12 files changed, 391 insertions(+), 43 deletions(-)
 create mode 100644 tests/functional/gdb-scripts/kernel_gdb_test.py

-- 
2.47.3


