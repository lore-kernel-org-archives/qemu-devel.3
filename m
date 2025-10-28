Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E8FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlYm-0007bX-00; Tue, 28 Oct 2025 11:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYk-0007aE-32
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:30 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYZ-0001OP-HA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:29 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-59093250aabso6758702e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761665052; x=1762269852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dLLf9GaBacUfah1oHIjm5nJTHVBfOOXl36JDtbIshE=;
 b=jUVpu9eFO32zN87tLZFTSHTUEQhvtW2Pe88GZJnEkXJP7iX30/Ua3VxFz7jrYlikQu
 aiVp9UoI+hmPbJTMyk+o3yCTXIhvnyb2IONAZ/nJoiLArkAwDhbvOpSJNCGwvDKsB4L/
 UO7zk9m+VLyQq8nJdfWk/MEqAyMze73zQfUbONChYh3M8rLI+25zgZjYidQfELBkPxx7
 r0fOdPrxAhXwGvE7dUK58UUZZIwRPbppLi6zErISN/SfhtB4HjincQX+eoIet23mbQ7F
 xauAuhwXPgl8jJklu53xefO2HNuVetWpd9JrwbecMlgzuOFCXzp2jSjriXNPpSxdu5ro
 PzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665053; x=1762269853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dLLf9GaBacUfah1oHIjm5nJTHVBfOOXl36JDtbIshE=;
 b=PGO3u3+6e9FZuOihRO+mDN0Ijr7LpILNsu4l68zKBZq3mu6eZAI8Vf+IgQPm63ebVx
 OF/WhVfR/Q01FIjiv8CI8/j58BOc1Z4ogZnF2HfwlLCaJFV5Yn9H57bjb/ksr4H/PQ+A
 9N5ZvJIw6/kM15QXNKO61ssOyhEosILa7mG562WUoQM95Oo4PUEJZip5TYDml5Lam7ir
 9FFyfsMB35XUVs6IaEwia2eT8UMDAnLDQd+5beNIJuSL3uZl8/zb4pnSsav7JfLoOdU4
 Wp7Vf1WmmUGD82IfYZZfTNjQitsucGARIO7ZPMLJhbgrEVX5+yojSHdOzE/4Mmlcj3g+
 otCQ==
X-Gm-Message-State: AOJu0YxVG4SNe0zh79AvfLZ8ePCH77rCbr7+d+X5jiQfovqPaDA30slp
 NKvq6kbD146KAXoozm89iCUH85r11JLvvw00pg9/0PFdkwdbdg0XbaistsFZl8WVKz80tw==
X-Gm-Gg: ASbGncu5rblMKepZ2vj/BXe1L8SszU6rEuRSckCLaSNU9ZCp87eesYhpY6xNWMTiBKu
 CQYVkUmV83ISK7+kjJiXjNG73y8Alfa/Ae6+wRIDvSg3GuHodDBBmV+pHeNZ+qWoHPKokVb/Qn8
 2F+WNUqqWBoFPtxKY8aQe+3DGq6GnzOPBECoKPIU53TR+jNy+BnFGPWNJcxmP8Y0hYshipVxZAA
 ve5/8h85hjFPL1xJL5elErl6+sjXvRaE43CDhPaX2nZ5TcW7IEqtrlSCU4YAaLBpXhqHlSlQaIg
 Fc0KnGtDB6CQLtRgyKgnZe2njRDeAn2P4O9CmvjIoACxyGb7QsA/t/TNyoSrvgQ5Z1zwXbpF1lV
 nmotN/kh36CpWdptuTwM9xrZoIRqHh5zSH7sa4idtkE4NDlZx64BePaI9s0aEnYiR5oa3t2WZEG
 ERzen9hJGNKPQPMYKbXjSIlIo1Ht1Q6MGSd48D
X-Google-Smtp-Source: AGHT+IHmc55O4jIX3hnbINKfeyWtRYKvJrYoXmT+ygMAnR475KdDN8y3H/tz1IS+6x7qbm64VGF3QQ==
X-Received: by 2002:a05:6512:4027:b0:592:f766:a49c with SMTP id
 2adb3069b0e04-5930e997932mr1297028e87.15.1761665052300; 
 Tue, 28 Oct 2025 08:24:12 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59301f60af4sm3060403e87.60.2025.10.28.08.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 08:24:11 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, bill.mills@linaro.org,
 edgar.iglesias@amd.com
Subject: [PATCH v1 5/5] docs: Describe virtio-msg-amp-pci
Date: Tue, 28 Oct 2025 16:23:50 +0100
Message-ID: <20251028152351.1247812-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x131.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 .../devices/virtio/virtio-msg-amp-pci.rst     | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 docs/system/devices/virtio/virtio-msg-amp-pci.rst

diff --git a/docs/system/devices/virtio/virtio-msg-amp-pci.rst b/docs/system/devices/virtio/virtio-msg-amp-pci.rst
new file mode 100644
index 0000000000..c73f7a878b
--- /dev/null
+++ b/docs/system/devices/virtio/virtio-msg-amp-pci.rst
@@ -0,0 +1,70 @@
+Virtio-msg AMP PCI
+==================
+
+This document explains the setup and usage of the virtio-msg-amp-pci device..
+The virtio-msg-amp-pci, is an emulated PCI device that provides a small
+set of features to enable virtio-msg over shared-memory queue's.
+
+Usecase
+-------
+
+Virtio-msg is a virtio transport where driver and device communicate over
+messages rather than using memory accesses that get trapped and emulated.
+Virtio-msg depends on a lower lever virtio-msg-bus responsible for delivering
+these messages. In this case, we're using the Virtio-msg AMP bus which moves
+messages back and forth using a FIFO on top of shared-memory and interrupts.
+
+The virtio-msg-amp-pci device exposes a BAR with RAM and doorbell registers
+so guests can implement the shared-memory FIFO protocol and QEMU implements
+the backend side of it.
+
+Virtio pmem allows to bypass the guest page cache and directly use
+host page cache. This reduces guest memory footprint as the host can
+make efficient memory reclaim decisions under memory pressure.
+
+Virtio-msg-amp-pci PCI device
+-----------------------------
+
+The virtio-msg-amp-pci device has the following layout:
+
+- BAR 0: Registers (Version, features and notification/doorbell regs)
+- BAR 1: RAM for FIFOs
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
+How does virtio-msg-amp-pci compare to virtio-pci emulation?
+------------------------------------------------------------
+
+Both virtio-msg-amp-pci and virtio-pci emulate PCI devices and allow users
+to plug virtio devices behind them. The main difference is in how the
+guest uses virtio-msg vs virtio-pci to discover and configure the virtio dev.
+
+virtio pmem usage
+-----------------
+
+A virtio-msg-amp-pci can be greated by adding the following to the QEMU
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
+The virtio-msg-amp-pci  device can be configured with the following properties:
+
+ * ``num-fifos`` number of fifos (default 2).
-- 
2.43.0


