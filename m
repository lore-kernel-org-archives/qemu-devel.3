Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464EFF3C9A8
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuunB-0006Vv-FI; Tue, 24 Feb 2026 10:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vuun6-0006VE-1d
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:57:40 -0500
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vuun3-0000pw-Uw
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:57:39 -0500
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-56750cb34c8so4713482e0c.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771948656; x=1772553456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGDY0x1qV7scWCj/d8xZ05T1lEHN+YAZifpPNfg7lYc=;
 b=eYG8fqpN32mM7zPbUACydWcB7D+/962iqp7UpStLN1BmjxrGIGHRlzbFXndJKz7nxB
 weILaJtKi+8I2UbU+VZiSREsgHdA3FdgwWm32Yj0b7fU6Dxu0JY020ZwZLrv+UEIO4eb
 /Dioq+DCbVmergS56T0UnRccArQhTxw6s8gdpJ5d4xNgjXdsECiLHaxMr49Kmtw4iJFb
 4PWeMrWxmJM9j6tVTq6hwfL/xaKuOsPfGpjBV97GmYQBzPS7I2ZYAjk1PM5JFccPQ4au
 +dLqNGuJ1ThQaDyXsZ8eq6o6478NVjjXHnq8odUsTrZNuGHG8CupIj+Mw0peO0FAxiH0
 pSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948656; x=1772553456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XGDY0x1qV7scWCj/d8xZ05T1lEHN+YAZifpPNfg7lYc=;
 b=AJpYb4Orm7lUqGMoj00ixzZ98R2eImhMqyjZuMHJb/wLtCJdI6mKnp9eL86RLh8DGE
 tnke7JXE621IzJCQWOzOYZaiJQVETo5o21eGHH5weHOYb0cvfbHy1VgIJGTkUIbD7g/I
 kipArNU2fXeBeectaJBX+UhjnDtKdXrchksE7axjzZn49CWdB11nGlxVkB14VIyobSBu
 Zp3TOcwyIuq142AFbHwfkET7nndpMffFSF9MocWnAU/WS6RwT/m91C9VPaPVGEsxnpkr
 5MDRVeJ2/at70hxwd9t9tfQozDoRdzwrhMmOEStSWEXP+w6+WwmW1eJ18hdou4OM7DVG
 bySQ==
X-Gm-Message-State: AOJu0YxUQFFFoSV3luUN+sfmlE50Nv5SOOq6JLSCeD5CbB9BUDOC0o1l
 mWqbHhXYJgvhxP3mUvyPH3cV/9ZhguC8+1hSCei/Q3OMJobv8vJ8LscSht32nCQ/
X-Gm-Gg: ATEYQzy7Q+zkvqGdCG33qa02V0mwB97cSTZDyIHNeezhjiaqezIbwDgBO7ZLcevAPII
 d/HZYY/ttkZByBlMyNgmqAWJE9BYkbIHdwA0fQN84zzfttSL4zneI4+ciyGQQXZEilZCZH0L9a6
 29lLHtgkGBwOFE75nFsMuYaks73TcajO7Ohp4LShrvlwkGReJXvk87p/ccXxeWrPFXi08xiNmJG
 z/mB/GL2w9/NEM9emV40JtBHHvAAVBa9vUNqQ7fW0VrnslvCT6m5zuqOpzPcAsibFl+azVQcATV
 MAHIIMjONFU0Dy/ofM44JLZQaH5csdfDbnl0g3xDtUHW2pmMTdP5+S6BdqCQ24GjqJ8IZSqMuGy
 sAlX3YrRLsc3r7AhCLiUUUSVixn+Ph0GDn4gWprL7VNTWn+cZanPE0GVQBStQ4Jpk7qbUUCHuYh
 rZuyzyQbgC5pdk6IfD3pu8UT46oLEOnqIqg2SLyJab5ppNtkVpucmAI90G5+yf0IVV7Flc
X-Received: by 2002:a05:6122:3a15:b0:567:4576:534e with SMTP id
 71dfb90a1353d-568e470ad22mr6287463e0c.1.1771948655905; 
 Tue, 24 Feb 2026 07:57:35 -0800 (PST)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-568e595979dsm13204878e0c.20.2026.02.24.07.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:57:35 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: mst@redhat.com, alex.bennee@linaro.org, bill.mills@linaro.org,
 edgar.iglesias@amd.com
Subject: [PATCH v2 4/4] docs: Describe virtio-msg-amp-pci
Date: Tue, 24 Feb 2026 16:57:21 +0100
Message-ID: <20260224155721.612314-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224155721.612314-1-edgar.iglesias@gmail.com>
References: <20260224155721.612314-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 docs/system/devices/virtio/index.rst          |  1 +
 .../devices/virtio/virtio-msg-amp-pci.rst     | 92 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 docs/system/devices/virtio/virtio-msg-amp-pci.rst

diff --git a/docs/system/devices/virtio/index.rst b/docs/system/devices/virtio/index.rst
index c292101ade..f2d8c24353 100644
--- a/docs/system/devices/virtio/index.rst
+++ b/docs/system/devices/virtio/index.rst
@@ -21,6 +21,7 @@ can also be off-loaded to an external process via :ref:`vhost user
    :maxdepth: 1
 
    virtio-gpu.rst
+   virtio-msg-amp-pci.rst
    virtio-pmem.rst
    virtio-snd.rst
    vhost-user.rst
diff --git a/docs/system/devices/virtio/virtio-msg-amp-pci.rst b/docs/system/devices/virtio/virtio-msg-amp-pci.rst
new file mode 100644
index 0000000000..3290a75eec
--- /dev/null
+++ b/docs/system/devices/virtio/virtio-msg-amp-pci.rst
@@ -0,0 +1,92 @@
+Virtio-msg AMP PCI
+==================
+
+This document explains the setup and usage of the virtio-msg-amp-pci device.
+The virtio-msg-amp-pci is an emulated PCI device that provides a small
+set of features to enable virtio-msg over shared-memory queues.
+
+Overview
+--------
+
+Virtio-msg is a message-based virtio transport: instead of MMIO/PIO accesses
+to discover queues and kick the device, the guest driver exchanges small
+messages with QEMU. The virtio-msg-amp-pci device provides a PCI wrapper for
+an AMP-style shared-memory transport. Each FIFO is a point-to-point message
+channel backed by RAM and a doorbell register for notifications.
+
+QEMU exposes a virtio-msg bus per FIFO. Devices are attached under the
+``virtio-msg-amp-pci`` object and exchange virtio-msg protocol messages over
+the FIFO. MSI-X interrupts are used to notify the guest when QEMU enqueues
+messages for the driver.
+
+Use case
+--------
+
+Virtio-msg is a virtio transport where driver and device communicate over
+messages rather than using memory accesses that get trapped and emulated.
+Virtio-msg depends on a lower level virtio-msg-bus responsible for delivering
+these messages. In this case, we're using the virtio-msg AMP bus which moves
+messages back and forth using a FIFO on top of shared-memory and interrupts.
+
+The virtio-msg-amp-pci device exposes a BAR with RAM and doorbell registers
+so guests can implement the shared-memory FIFO protocol and QEMU implements
+the backend side of it.
+
+Virtio-msg-amp-pci PCI device
+-----------------------------
+
+The virtio-msg-amp-pci device has the following layout:
+
+- BAR 0: Registers (Version, features and notification/doorbell registers)
+- BAR 1: RAM for FIFOs
+- BAR 2: MSI-X table and PBA (created automatically)
+
+Each FIFO gets an MSI-X interrupt reserved for it and a dedicated doorbell
+register::
+
+        REG32(VERSION,  0x00)
+        REG32(FEATURES, 0x04)
+        REG32(NOTIFY0,  0x20)
+        REG32(NOTIFY1,  0x24)
+        REG32(NOTIFY2,  0x28)
+        And so on.
+
+Each FIFO uses a 16 KiB window in BAR 1 with the following layout:
+
+- 0 - 4 KiB: Reserved
+- 4 - 8 KiB: Driver queue
+- 8 - 12 KiB: Device queue
+- 12 - 16 KiB: Reserved
+
+The guest driver writes to the doorbell register to notify QEMU to process
+the driver queue. QEMU posts responses on the device queue and raises the
+FIFO's MSI-X vector to notify the guest.
+
+How Does virtio-msg-amp-pci Compare to virtio-pci Emulation?
+------------------------------------------------------------
+
+Both virtio-msg-amp-pci and virtio-pci emulate PCI devices and allow users
+to plug virtio devices behind them. The main difference is in how the
+guest uses virtio-msg vs virtio-pci to discover and configure the virtio dev.
+
+Virtio-msg-amp-pci Usage
+------------------------
+
+A virtio-msg-amp-pci can be created by adding the following to the QEMU
+command-line::
+
+    -device virtio-msg-amp-pci
+
+Virtio devices can then be attached to the virtio-msg bus with for example
+the following::
+
+    -device virtio-rng-device,bus=/gpex-pcihost/pcie.0/virtio-msg-amp-pci/fifo0/virtio-msg/bus0/virtio-msg-dev
+
+Multiple virtio devices can be connected by using bus1, bus2 and so on.
+
+Device properties
+-----------------
+
+The virtio-msg-amp-pci device can be configured with the following properties:
+
+ * ``num-fifos`` number of FIFOs (default 1, max 8).
-- 
2.43.0


