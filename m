Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE7ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 14:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCfEo-00041p-FD; Sat, 25 Oct 2025 10:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZG-0001br-TA
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:22 -0400
Received: from sg-1-35.ptr.blmpb.com ([118.26.132.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZ8-0003jD-Iq
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761395936;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=00eb6wcpigcap9zvWNW3IU66esW+FAYMAuecjq3ixY4=;
 b=V8SctDpeAkjyuxhK2Q/clZGglO3SthzBOZmBCervqzrGwbJRCf/XhVWnhiVFu/H+80gw0F
 B7vyXNrm6O/hwXVaaERmr0czd9G+Let9xFaapaM/UJDhxwm5BbR4IOMuD0vlftl5WzH0al
 HZO5vEGHSjPDb7eAT92gui/+rsM8BQUCsjXuYzQsKvWpUX+3Zt1tH5T7yrgB73AcsuomhP
 qBYn5UtOK0vU5HCyIpoRFiG16ckt399AoKdG1SPHDe+8ThuT2xDbBMOyWVFunWHHZegHtW
 8M5VlXDWh5bABRMdH2BLzdKrFhAYEC4haHJWow3fpgLNESByXKpfrdMgSv1SWg==
To: <pbonzini@redhat.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>
From: "chenmiao" <chenmiao@openatom.club>
Message-Id: <20251025123853.63139-1-chenmiao@openatom.club>
X-Original-From: chenmiao <chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Cc: <qemu-rust@nongnu.org>, <qemu-devel@nongnu.org>, 
 <hust-os-kernel-patches@googlegroups.com>, 
 "Chao Liu" <chao.liu@openatom.club>, "Chen Miao" <chenmiao@openatom.club>
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with
 ESMTPS; Sat, 25 Oct 2025 20:38:53 +0800
Date: Sat, 25 Oct 2025 12:38:48 +0000
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [RFC 0/5] rust: hw: Add the I2C and the first GPIO device
X-Lms-Return-Path: <lba+268fcc4de+f73d47+nongnu.org+chenmiao@openatom.club>
Received-SPF: pass client-ip=118.26.132.35;
 envelope-from=chenmiao@openatom.club; helo=sg-1-35.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 25 Oct 2025 10:27:12 -0400
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

We have implemented I2C and the first GPIO device in Rust for QEMU.
Additionally, in the respective patches, we have shared our insights and
experiences regarding the use of Rust for device modeling within QEMU.

1. The first patch implements the BusState for the I2CBus infrastructure.
2. The second patch implements the I2CBus and I2CSlave infrastructure, along
   with a discussion of the challenges encountered during the implementation.
3. The third patch moves the struct definition of the PCF8574 to the
   corresponding header file.
4. The fourth patch provides a set of necessary helper functions for the PCF8574
   GPIO device.
5. The fifth patch implements the PCF8574 GPIO device, along with a discussion
   of the issues and considerations addressed during the implementation.

Regarding this series of patches, we have found that Rust for QEMU is indeed
still not mature enough and requires continuous iteration. Additionally, the
lack of basic documentation also needs to be addressed. In this regard, I hope
our team(HUST OpenAtom Open Source Club) can contribute to the documentation
efforts for Rust for QEMU.

Link: https://groups.google.com/g/hust-os-kernel-patches/c/z7vHWg3xvDc

Signed-off-by: Chao Liu <chao.liu@openatom.club>
Signed-off-by: Chen Miao <chenmiao@openatom.club>

chenmiao (5):
  rust: hw: core: Add the BusState of rust version
  rust: hw: core: Add rust bindings/funcs for i2c bus
  hw: gpio: Move the pcf8574 struct to header
  rust: hw: core: Provide some interfaces for the GPIO device
  rust: hw: gpio: Add the the first gpio device pcf8574

 hw/gpio/Kconfig                      |   5 +
 hw/gpio/meson.build                  |   2 +-
 hw/gpio/pcf8574.c                    |  32 ---
 include/hw/gpio/pcf8574.h            |  36 +++
 rust/Cargo.lock                      |  21 +-
 rust/Cargo.toml                      |   1 +
 rust/hw/Kconfig                      |   1 +
 rust/hw/core/meson.build             |   2 +
 rust/hw/core/src/bus.rs              |  51 +++++
 rust/hw/core/src/i2cbus.rs           | 313 +++++++++++++++++++++++++++
 rust/hw/core/src/irq.rs              |   6 +-
 rust/hw/core/src/lib.rs              |   6 +
 rust/hw/core/src/qdev.rs             |  12 +-
 rust/hw/core/wrapper.h               |   1 +
 rust/hw/gpio/Kconfig                 |   2 +
 rust/hw/gpio/meson.build             |   1 +
 rust/hw/gpio/pcf8574/Cargo.toml      |  31 +++
 rust/hw/gpio/pcf8574/build.rs        |   1 +
 rust/hw/gpio/pcf8574/meson.build     |  50 +++++
 rust/hw/gpio/pcf8574/src/bindings.rs |  29 +++
 rust/hw/gpio/pcf8574/src/device.rs   | 174 +++++++++++++++
 rust/hw/gpio/pcf8574/src/lib.rs      |   4 +
 rust/hw/gpio/pcf8574/wrapper.h       |  51 +++++
 rust/hw/meson.build                  |   1 +
 24 files changed, 795 insertions(+), 38 deletions(-)
 create mode 100644 rust/hw/core/src/bus.rs
 create mode 100644 rust/hw/core/src/i2cbus.rs
 create mode 100644 rust/hw/gpio/Kconfig
 create mode 100644 rust/hw/gpio/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/Cargo.toml
 create mode 120000 rust/hw/gpio/pcf8574/build.rs
 create mode 100644 rust/hw/gpio/pcf8574/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/src/bindings.rs
 create mode 100644 rust/hw/gpio/pcf8574/src/device.rs
 create mode 100644 rust/hw/gpio/pcf8574/src/lib.rs
 create mode 100644 rust/hw/gpio/pcf8574/wrapper.h

-- 
2.43.0

