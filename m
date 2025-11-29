Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D68D116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 14:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLxH-0002AZ-5S; Sat, 29 Nov 2025 09:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vPLwN-0001yv-VP
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:28:48 -0500
Received: from sg-1-17.ptr.blmpb.com ([118.26.132.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vPLwJ-0000wg-9P
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1764426506;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=2WiHlMuUSvjmJ0Vv67Hg/mnuUYeHDimKZMo7xovJsEM=;
 b=2GD+wy7kXeIn8hzkZBAyJg0sXmv/EyvcD6Gpbe0rvJSMq522L/Sjhrr2OLd4oY1nUUYv/0
 dL8cHK4jADspQpg9e4r/kTmmltNi5e+hylF/ORyzWamr2p874fMFqLuRAVAEtXv+NwGLXM
 CjW/FveIZoaDlz7UEWLAt+8JNkMvGhnId4ieUxYTiRtwyAV3O5ztO5FVgYwEs2cvYpDyAc
 sxqGtUPgZzhGrlY0osE1ff4a9Vzgh5Yq6FxlrxwMw+RA/LCsAvSGSFNc/uxT3e0Tg8VG8l
 lNFEg8nmkJSc9geuOwR88yQVnAhzlkPhQUnuhSPNX5OsOx6vdJHY1JxzA37FIw==
From: "Chen Miao" <chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
Mime-Version: 1.0
To: <zhao1.liu@intel.com>, <pbonzini@redhat.com>, 
 <manos.pitsidianakis@linaro.org>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>
Subject: [RFC PATCH V3 0/4] rust/hw: Add the I2C and the first GPIO device
X-Lms-Return-Path: <lba+2692b0308+adfaf0+nongnu.org+chenmiao@openatom.club>
Received: from nyaos.localdomain ([114.249.49.233]) by smtp.feishu.cn with
 ESMTPS; Sat, 29 Nov 2025 22:28:23 +0800
Content-Transfer-Encoding: 7bit
Cc: <chao.liu@openatom.club>, <dzm91@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>
Message-Id: <cover.1764426204.git.chenmiao@openatom.club>
X-Original-From: Chen Miao <chenmiao@openatom.club>
Date: Sat, 29 Nov 2025 14:28:18 +0000
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=118.26.132.17;
 envelope-from=chenmiao@openatom.club; helo=sg-1-17.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

We have implemented I2C and the first GPIO device in Rust for QEMU.
Additionally, in the respective patches, we have shared our insights and
experiences regarding the use of Rust for device modeling within QEMU.

1. The first patch implements the BusState for the I2CBus infrastructure.
2. The second patch implements the I2CBus and I2CSlave infrastructure, along
   with a discussion of the challenges encountered during the implementation.
3. The third patch provides a set of necessary helper functions for the PCF8574
   GPIO device.
4. The fourth patch implements the PCF8574 GPIO device, along with a discussion
   of the issues and considerations addressed during the implementation.

Signed-off-by: Chen Miao <chenmiao@openatom.club>
Signed-off-by: Chao Liu <chao.liu@openatom.club>

chenmiao (4):
  rust/hw/core: Add the BusState of rust version
  rust/hw/core: Add rust bindings/funcs for i2c bus
  rust/hw/core: Provide some interfaces for the GPIO device
  rust/hw/gpio: Add the the first gpio device pcf8574

 hw/gpio/Kconfig                  |   5 +
 hw/gpio/meson.build              |   2 +-
 rust/Cargo.lock                  |  18 +-
 rust/Cargo.toml                  |   1 +
 rust/hw/Kconfig                  |   1 +
 rust/hw/core/meson.build         |   2 +
 rust/hw/core/src/bus.rs          |  44 +++++
 rust/hw/core/src/i2c.rs          | 303 +++++++++++++++++++++++++++++++
 rust/hw/core/src/lib.rs          |   6 +
 rust/hw/core/src/qdev.rs         |  17 +-
 rust/hw/core/wrapper.h           |   1 +
 rust/hw/gpio/Kconfig             |   2 +
 rust/hw/gpio/meson.build         |   1 +
 rust/hw/gpio/pcf8574/Cargo.toml  |  28 +++
 rust/hw/gpio/pcf8574/meson.build |  37 ++++
 rust/hw/gpio/pcf8574/src/lib.rs  | 178 ++++++++++++++++++
 rust/hw/meson.build              |   1 +
 17 files changed, 642 insertions(+), 5 deletions(-)
 create mode 100644 rust/hw/core/src/bus.rs
 create mode 100644 rust/hw/core/src/i2c.rs
 create mode 100644 rust/hw/gpio/Kconfig
 create mode 100644 rust/hw/gpio/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/Cargo.toml
 create mode 100644 rust/hw/gpio/pcf8574/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/src/lib.rs

-- 
2.43.0

