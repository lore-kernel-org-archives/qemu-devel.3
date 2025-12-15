Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0256D5B85A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCC0-00007d-0a; Mon, 15 Dec 2025 12:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vVBxH-0008Nf-FM
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:02:00 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vVBxF-0004i3-Bg
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:01:50 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so15884555ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765818106; x=1766422906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNgvwNZBX5PbUxQmqMyG71msCh+2jAm44Av728iBIqY=;
 b=dnGvQu3WYkgmiqp2MlZAuqvb6gFDExSJTWTzRvOQeLNnZ+ipb3l+bzLGI7BvPs2kSc
 wXiIeAUV9mxKr1N9HBDRQm/MF0lIN6cue1hfPJM6LJFGQZ+dfMelAo7/LCHfEZV2zTie
 +l9Xg09saff6Ekt0VKH9H/JeqAqyOVkccy4ZPLkFJxbch+N6nzBGUdJp0Uw1JRAk48by
 IQhV4fbyHuecFTb8TUYKBfbWoxU69Si51+tR/rkFQS2a3ybLPByBe3Q+KQ1i5Xmb65yZ
 IdE6DvF0YvR4twmmpP9ZlcJ8xGrBclXidBPN/J+LWeYCUxmC2MM7+FGZQEgL03j55oUs
 MHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765818106; x=1766422906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PNgvwNZBX5PbUxQmqMyG71msCh+2jAm44Av728iBIqY=;
 b=q1X/Jsl7mEMvqYgJdxcvRXshHNunCrP4NzHXLt0b+wPUaLsJ7BAU6Wt20+bJ/P6qDY
 peK0yMVv/JZN32p0mBq/kHwqCCs+L0j9oSThI0b4PjlwpKyOhliGXn6FEvZgSUVcx+ci
 CBp7WAc0fhEw6KC3tz5Y505B81ZsbeLh9dzqfyWuW3F9ub7hh72JhzNAUMXuJpte+rsi
 umehabqvmIeMMTdYpO3Wdt0cUVKuCaooxjxQ5EZ3z/ToRMF6BgaW21WN2rTPDIq9U02f
 N7lp0zXrv16cUTbct3gZ3PWVPdtFYsw2Ipe6UPWOjMJnGrIPK8FA4ku49JZRfFfAEWDs
 1zAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX05/HdI5OoseWsaH1tXOqy9lRtNUpDJ54Sp4RwXrFh7t15myvjJA6DzvNM2XwouATnmiTMGBUuYv2T@nongnu.org
X-Gm-Message-State: AOJu0Yzco1r30+7kdyWxFu2LqM2bVC9wv1LuyxBZPSwhzDDica6fnG6O
 q7W4V0mY5mDxNVQGUkZhfUkpnVX6PkUZ+UxotLvSSG9lGJIsMGmDQnsq
X-Gm-Gg: AY/fxX5vAmtWcIHyVyAH7rwgbJHj3M1MzfRxB7FFXz7oIpFJGiB3ptQ6IHHH+rPAzN2
 MqzCPcPw1Cd7BMJjU6/4a7Y+WXfDtmzxDLtGVaysYHT/vho5C/Ggmj9AUb4S3eGHRXEtlHryzwY
 TVECz8zFdZKO49yXgwtfxeQQi69oMeboxMCV6ijinM0ZZSpa+IfsduDuO53oZ9+owKM4LsQunn2
 JWTVVqh+Rt7h1wZ/kQkgT+IeCkBjhnp2tNHLSvSYcqDRU8dVQNyG/RiRMeCn9OepjiDh6a+LXtn
 3s+BhoUZ24cZlvxM0g+kGVov7X8DoBpIzSxYl1VC/5qV93IyMfbo6qv4X4uTRsoyzM0HrVt+af0
 lNMkAuZdehlv9njuYX1YYzEFU7wIPEwwKGlsqvcHAAcVhqIWUdvfOgFZjIRdzas2ILh4eCDaT2i
 OEjRhRi6xi5SQJktOWqhlsWEv8kiBkdg==
X-Google-Smtp-Source: AGHT+IGuTH11zO7sBeNjfeYh1PlC78cMIr9DMln0D+19abTANjpddSQ8F6CZPYn244IKxq5OmrTe+w==
X-Received: by 2002:a17:902:ea11:b0:2a0:92a6:955 with SMTP id
 d9443c01a7336-2a092a60bdemr85761105ad.23.1765818104998; 
 Mon, 15 Dec 2025 09:01:44 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2589d4f7sm13132788a12.3.2025.12.15.09.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 09:01:44 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: pbonzini@redhat.com, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, 1440332527@qq.com,
 3160104094@zju.edu.cn, temashking@foxmail.com, me@ziyao.cc,
 Chao Liu <chao.liu@zevorn.cn>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RESEND PATCH v3 5/5] docs/system/riscv: add documentation for k230
 machine
Date: Tue, 16 Dec 2025 01:01:18 +0800
Message-ID: <13ed5f4d13d117739f94d592cf2fc183c99f1f95.1765816341.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765816341.git.chao.liu.zevorn@gmail.com>
References: <cover.1765816341.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Dec 2025 12:15:19 -0500
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
index 1d2f2c468c..e84703c1bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1740,6 +1740,7 @@ F: include/hw/riscv/xiangshan_kmh.h
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
index 89b2cb732c..2103ff6173 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
 .. toctree::
    :maxdepth: 1
 
+   riscv/k230
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/shakti-c
-- 
2.51.0


