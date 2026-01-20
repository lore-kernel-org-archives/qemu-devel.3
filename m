Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435DDD2ECF9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 04:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi3pY-0002cv-I3; Mon, 19 Jan 2026 23:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi3pW-0002bi-NS
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 23:59:03 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi3pV-0000FX-1R
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 23:59:02 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2a1022dda33so30201195ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 20:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768885140; x=1769489940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHPPQtLsBrf6SxxB3IwlY/gIhjLfsrdUl251mQ5AQeg=;
 b=msnJj/ZN1IK94GlglrmGJYYXnmH/sB8uzr2yf9QYgGeDMuCnZO9aNq+QpFLRMYb0gF
 Ao+YGPrcZUzvmY2JjUN4i/Y/6kKXPyE2UDRXCgEKYBCkMtpkX0sPtfmsKXs0b1YuwWyv
 5IJ2r67xe3q09/nm6x+lrC/EeOCpRqVbxHD3N5jdYP0glZJecuHWVu6Pi0dxCVt8Bl6H
 jp7XXkQJUpbU5XF9unYvSRiMVu9aP0cmq421EHg9bDfJsoPX4TfEtmoQCQss6Ldd32CW
 Yszwh9I7K3F8yuWFWp9hI/vSVHEQeThAiqLCVfyaghs7FjH4jmPz1p1Nl3H+zcEoTbM3
 ArGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768885140; x=1769489940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iHPPQtLsBrf6SxxB3IwlY/gIhjLfsrdUl251mQ5AQeg=;
 b=ZPm76dI3Wnugn+VwDmD+B2Lg/GD6HHiwi9OukxCmQWbKh7+EUbgQJROjN3VYBoG5jJ
 0oC9rb4dzPwsnut5aeUvzCExdoTBybEXlAl6klIod/tvScUAtAk/R0sAwy1alKq4WGxs
 djRGu/Ixfgi4T0Jlj7vESLDUKOPgBV5SiipHPSfc7Kzcisknv6YWMWPqZH7kw4erUibI
 5An9UccpFLEqlj3drQ0uUks3C0L7OOQQfmiW+OINJJMm2Y+d/X/I4z8VeSvZYpWtao3o
 8jrKfd3oJjUHyVVfZWfeq3ppzRE3l68OYaWzEPhgmolNB15uEYCzY/zro6A/3Hr8uZY9
 9PuQ==
X-Gm-Message-State: AOJu0YzbFqYBkQYYPTW3sHwMULaChmuIPdNWlM+o20tz61NXVa/QFQu+
 i3nJXc3fJGwig6cW433UXvQgG69lh4x7pM+5pGCJPCJg9ffSmqWlHmBV
X-Gm-Gg: AZuq6aKE/L+RCz+aDCqOc7+MlKdVmrSlIRpSk5B6lFzR5PlD70C/cYqFdudeYeXE+E2
 sld+bWJy4eh3hMj0qFvgV8ORXnJ78z3l1oQ9ZOTOPueQn8PGv5HPuj8TZr6JNTz0t78iCc9EdFf
 vZm3LjQFrmX/37kWQLTqBTVr8W/5oj9K1W1LiM4bIWdSwMH6gGXkBG0o+qkAKKvYiOWnXyypTgn
 6044mUFxRVRsA89TCOF27ERU3yG5NpR6RQweKYpqLBAttozvVmPnSbQrlnp8+OL409QN/2jvEu7
 oTlMnj1xRlf8oyrN0JcZBuYGwc7tMkfL8BpACguoafJwnAmnr4TkvUDuNRHIq85nM+ueDx0yXTq
 KNWHXhXlv61Hpdcg0fESG1Mis7+BXn6z8CVd+iIW7+ubIP9o2RB0/K9ZmMTfx+a/Ggu1GaZrfwu
 x/EqWtzA0IYOo2yOOHIIOMc77CQUfA9kRL+bKpluiRXsRkqVvUbLZtCJXddcA=
X-Received: by 2002:a17:903:22c5:b0:2a0:9eed:5182 with SMTP id
 d9443c01a7336-2a7698f99e1mr6136605ad.20.1768885139717; 
 Mon, 19 Jan 2026 20:58:59 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.21.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190d14cfsm110703045ad.38.2026.01.19.20.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 20:58:59 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu@zevorn.cn>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v4 5/5] docs/system/riscv: add documentation for k230 machine
Date: Tue, 20 Jan 2026 12:56:55 +0800
Message-ID: <03fd30a68eae5d850953fef26f9b69294ff00048.1768884546.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768884546.git.chao.liu.zevorn@gmail.com>
References: <cover.1768884546.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chao Liu <chao.liu@zevorn.cn>

Add documentation for k230 virt reference platform.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 MAINTAINERS                  |  1 +
 docs/system/riscv/k230.rst   | 48 ++++++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst |  1 +
 3 files changed, 50 insertions(+)
 create mode 100644 docs/system/riscv/k230.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 5464e7fb5c..80d6bd6e90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1761,6 +1761,7 @@ F: include/hw/riscv/xiangshan_kmh.h
 K230 Machines
 M: Chao Liu <chao.liu.zevorn@gmail.com>
 S: Maintained
+F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
new file mode 100644
index 0000000000..3e6ca295df
--- /dev/null
+++ b/docs/system/riscv/k230.rst
@@ -0,0 +1,48 @@
+Kendryte K230 virt reference platform (``k230``)
+==========================================================================
+The ``k230`` machine is compatible with with Kendryte K230 SDK.
+
+The K230 is a chip from the AIoT SoC series made by Kendryte ® — a part of
+Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated computing
+structure.
+
+This chip has 2 RISC-V computing cores and a new-generation KPU (Knowledge
+Process Unit) smart computing unit.
+
+It has multi-precision AI computing ability, works with many common AI computing
+frameworks, and for some typical networks, its usage rate is over 70%. Besides,
+the K230 chip supports many peripheral connections and has several special
+hardware acceleration units (like 2D and 2.5D accelerators). It can speed up
+different tasks (such as image processing, video processing, audio processing
+and AI computing). It also has many good features: low delay, high performance,
+low power use and fast start-up.
+
+For more information, see <https://www.kendryte.com/en/proDetail/230>
+
+Supported devices
+-----------------
+The ``k230`` machine supports the following devices:
+
+* 1 c908 cores
+* Core Local Interruptor (CLINT)
+* Incoming MSI Controller (IMSIC)
+* 2 K230 Watchdog Timer
+* 4 UART
+
+Boot options
+------------
+The ``k230`` machine can start using the standard ``-bios``
+functionality for loading the boot image. You need to compile and link
+the firmware, kernel, and Device Tree (FDT) into a single binary file with
+K230 SDK(k230_canmv_defconfig), such as ``uboot``.
+
+Running
+-------
+Below is an example command line for running the ``k230``
+machine:
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -machine k230 \
+      -bios k230_sdk/output/k230_canmv_defconfig/little/uboot/u-boot \
+      -nographic
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddaf..b0b2f9584f 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
 .. toctree::
    :maxdepth: 1
 
+   riscv/k230
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/mips
-- 
2.52.0


