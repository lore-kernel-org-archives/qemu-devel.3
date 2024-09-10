Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88228EE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so99p-0006az-B5; Tue, 10 Sep 2024 18:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so99j-0006Rm-RS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:16:16 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so99g-0006RX-99
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:16:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71798661a52so233952b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006570; x=1726611370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YSyqJppZZS4UpzgxKNiY6ieJzLYfceDr8xhPE0xjFbI=;
 b=DgM3TYdqDLAoXO1ahL5m0BMH82qpbxJ7ZnqH48YL2TxDqwtWjAXoldG0wEyAentiB3
 2dK7hUwlqBbwPpUhDQhPOQwedIrc22os38nCwC68W5tbOuTd1rbT13Bhnh0izYx89JLk
 EgikWt4GwduDAo2BEx8a3D3W3AA1S8aqYwaHVED5E6kJt4OgmmRF4aCSMac9F8PVfsCW
 9sMvGsb8rqU+u47TA3XJwwvJa1WtkzGWPxwOtgs1ZfT6hm3TmbMzNgVDpZAqr68SF7sG
 gpy5EwJB8QC7TqXjyiKRNc44oAqhUrgfUMo7IKH36WgMGiU6wRJkW6s1G5eiJxzfi8DV
 h5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006571; x=1726611371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YSyqJppZZS4UpzgxKNiY6ieJzLYfceDr8xhPE0xjFbI=;
 b=pyRexNtfNGqDlLrgH4EhlHaiOZwDsuyud79v8ePSnVXRL78kioiYYlN9iRvek0ody9
 /vyuhr1Pkzyu4ONFFk3RYYNZlvRjdCGx2e8wiTzp5UwtIBcIIX/04oVzqisnBCK5YiK5
 Maw34cLKDcNGyjzBb6S6Py0UXacwMFlXIFITkg74fVYJ0IYcTuKz6pf9lCdzp8v8isS3
 uCIfMajVLtQwjBvBU7yhYRtV0SagQjSg8Hr4UhgfDKzzKOppsO4LzH3HI6iOV5VqkTl9
 Zn2Rzm8O3f4hqnZL5b+tl73gKx0Xh2591LfcE0VqMtb+rEqmw2/eMbX72/nFeJ36Oca6
 ySug==
X-Gm-Message-State: AOJu0Yyfq7XtWWtNvxIQQOrFykQenSbpnklxt3GMwGcnE8oQZ0yubErw
 5JETxwnwt1DCjy5JwHhy8HS1LZ6/iRKEYKW1xdolsl6U97KXvdqd+vDfqjEwdlxqnuyOcIbQEIF
 W7TglZMYJ
X-Google-Smtp-Source: AGHT+IFq8D12w3lrLR9iZPp9dBLWaCbloOusYWBwljwNqw7WFauubajh8SDyD921iLBgiiedqovYTQ==
X-Received: by 2002:a05:6a00:9484:b0:712:7512:add9 with SMTP id
 d2e1a72fcca58-71907f2dc50mr6196737b3a.13.1726006570484; 
 Tue, 10 Sep 2024 15:16:10 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:16:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 00/39] Use g_assert_not_reached instead of (g_)assert(0, false)
Date: Tue, 10 Sep 2024 15:15:27 -0700
Message-Id: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

This series cleans up all usages of assert/g_assert who are supposed to stop
execution of QEMU. We replace those by g_assert_not_reached().
It was suggested recently when cleaning codebase to build QEMU with gcc
and tsan: https://lore.kernel.org/qemu-devel/54bb02a6-1b12-460a-97f6-3f478ef766c6@linaro.org/.

In more, cleanup useless break after g_assert_not_reached();

And finally, ensure with scripts/checkpatch.pl that we don't reintroduce
(g_)assert(false) in the future.

Pierrick Bouvier (39):
  docs/spin: replace assert(0) with g_assert_not_reached()
  hw/acpi: replace assert(0) with g_assert_not_reached()
  hw/arm: replace assert(0) with g_assert_not_reached()
  hw/char: replace assert(0) with g_assert_not_reached()
  hw/core: replace assert(0) with g_assert_not_reached()
  hw/net: replace assert(0) with g_assert_not_reached()
  hw/watchdog: replace assert(0) with g_assert_not_reached()
  migration: replace assert(0) with g_assert_not_reached()
  qobject: replace assert(0) with g_assert_not_reached()
  system: replace assert(0) with g_assert_not_reached()
  target/ppc: replace assert(0) with g_assert_not_reached()
  tests/qtest: replace assert(0) with g_assert_not_reached()
  tests/unit: replace assert(0) with g_assert_not_reached()
  include/hw/s390x: replace assert(false) with g_assert_not_reached()
  block: replace assert(false) with g_assert_not_reached()
  hw/hyperv: replace assert(false) with g_assert_not_reached()
  hw/net: replace assert(false) with g_assert_not_reached()
  hw/nvme: replace assert(false) with g_assert_not_reached()
  hw/pci: replace assert(false) with g_assert_not_reached()
  hw/ppc: replace assert(false) with g_assert_not_reached()
  migration: replace assert(false) with g_assert_not_reached()
  target/i386/kvm: replace assert(false) with g_assert_not_reached()
  tests/qtest: replace assert(false) with g_assert_not_reached()
  accel/tcg: remove break after g_assert_not_reached()
  block: remove break after g_assert_not_reached()
  hw/acpi: remove break after g_assert_not_reached()
  hw/gpio: remove break after g_assert_not_reached()
  hw/misc: remove break after g_assert_not_reached()
  hw/net: remove break after g_assert_not_reached()
  hw/pci-host: remove break after g_assert_not_reached()
  hw/scsi: remove break after g_assert_not_reached()
  hw/tpm: remove break after g_assert_not_reached()
  target/arm: remove break after g_assert_not_reached()
  target/riscv: remove break after g_assert_not_reached()
  tests/qtest: remove break after g_assert_not_reached()
  ui: remove break after g_assert_not_reached()
  fpu: remove break after g_assert_not_reached()
  tcg/loongarch64: remove break after g_assert_not_reached()
  scripts/checkpatch.pl: emit error when using assert(false)

 docs/spin/aio_notify_accept.promela     |  6 +++---
 docs/spin/aio_notify_bug.promela        |  6 +++---
 include/hw/s390x/cpu-topology.h         |  2 +-
 accel/tcg/plugin-gen.c                  |  1 -
 block/qcow2.c                           |  2 +-
 block/ssh.c                             |  1 -
 hw/acpi/aml-build.c                     |  3 +--
 hw/arm/highbank.c                       |  2 +-
 hw/char/avr_usart.c                     |  2 +-
 hw/core/numa.c                          |  2 +-
 hw/gpio/nrf51_gpio.c                    |  1 -
 hw/hyperv/hyperv_testdev.c              |  6 +++---
 hw/hyperv/vmbus.c                       | 12 ++++++------
 hw/misc/imx6_ccm.c                      |  1 -
 hw/misc/mac_via.c                       |  2 --
 hw/net/e1000e_core.c                    |  2 +-
 hw/net/i82596.c                         |  2 +-
 hw/net/igb_core.c                       |  2 +-
 hw/net/net_rx_pkt.c                     |  3 +--
 hw/nvme/ctrl.c                          |  8 ++++----
 hw/pci-host/gt64120.c                   |  2 --
 hw/pci/pci-stub.c                       |  4 ++--
 hw/ppc/spapr_events.c                   |  2 +-
 hw/scsi/virtio-scsi.c                   |  1 -
 hw/tpm/tpm_spapr.c                      |  1 -
 hw/watchdog/watchdog.c                  |  2 +-
 migration/dirtyrate.c                   |  2 +-
 migration/migration-hmp-cmds.c          |  2 +-
 migration/postcopy-ram.c                | 14 +++++++-------
 migration/ram.c                         |  6 +++---
 qobject/qlit.c                          |  2 +-
 qobject/qnum.c                          |  8 ++++----
 system/rtc.c                            |  2 +-
 target/arm/hyp_gdbstub.c                |  1 -
 target/i386/kvm/kvm.c                   |  4 ++--
 target/ppc/dfp_helper.c                 |  8 ++++----
 target/ppc/mmu_helper.c                 |  2 +-
 target/riscv/monitor.c                  |  1 -
 tests/qtest/ipmi-bt-test.c              |  2 +-
 tests/qtest/ipmi-kcs-test.c             |  4 ++--
 tests/qtest/migration-helpers.c         |  1 -
 tests/qtest/numa-test.c                 | 10 +++++-----
 tests/qtest/rtl8139-test.c              |  2 +-
 tests/unit/test-xs-node.c               |  4 ++--
 ui/qemu-pixman.c                        |  1 -
 fpu/softfloat-parts.c.inc               |  2 --
 target/riscv/insn_trans/trans_rvv.c.inc |  2 --
 tcg/loongarch64/tcg-target.c.inc        |  1 -
 scripts/checkpatch.pl                   |  3 +++
 49 files changed, 72 insertions(+), 90 deletions(-)

-- 
2.39.2


