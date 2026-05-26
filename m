Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD95CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjQh-0007Qa-Fk; Tue, 26 May 2026 00:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQf-0007QH-OT
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQd-0007ZS-LG
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so36301875e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769806; x=1780374606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/7L4SVLqfKNU7CK9jkc52FIKfdVSn65sUnvc+m80r8=;
 b=LwC6kEF4XmLbBq/Mnbr64pG+pTBAYhjYAeUH18sTjlPKZgRYQv2cXmWO0MaBdZRIY6
 AgvVkws97qW8aGKR5DQVe3nTnmNVvo2fZv+XtjvimEbxvpwppZ3/rn1Zo+XkoJYSTELH
 1PaRgQksoUXPQUW3iPDMcW5ukjaaO02+mdJBG/59wYUe0iOameodf42Lk/EOs2PcvmBC
 Lsbu4uZFJ6kGY9sribTNo8pMcyddJfSLcmwdPRj5HfklT0AQA5F5svQze/HFOdlyDwKS
 n7dZ/hUWsSi1Um8DA6Vz3du6ve3dmQi9erFcFCBBfYPBjJemPD+o3LOj484X9v5JCgyp
 n5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769806; x=1780374606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j/7L4SVLqfKNU7CK9jkc52FIKfdVSn65sUnvc+m80r8=;
 b=EigkQunyqrElCy6oYdKVVzGGQT2NT1v78FHgDDkLpRT10T/pZ1omPCFdfUQTQPqGOR
 UIs41qQRAA1hE6x/3R0UaDJUXcZekum8hK+5YRCW/NKGN3CmP7iXfH57+j5MBo4tMZRQ
 YLfdYO3SJXtHBuMtwAHl9AdVqPxs6LoPa9yGKh4kn5dlYQc1jVXNvTyl7p0B1pDBMETz
 xjbwopFUCC/JRExc0pBuqlYtQSCc5ZGCO4kC9FKYFiikkSPAp48Db1NGdXFwA8SnhWK8
 +bqX2wN4c2ETop0cHYxaFZS7OMLXbkwPKfJrUzFRcrI37HotmHgbfG2D0WmF+vUBOxQo
 0C7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xRdANH9dcEMApq42cPe15LRDkz6XdkM3tyJUsrnFnjAy3jjne1AJd2hp8Fb31WrGFZNm0QKWW+IGu@nongnu.org
X-Gm-Message-State: AOJu0Yy2mMxSaOiKdFfQ3hk5591VeZd4UVIrd7F13e6ELK291RNOzm9q
 ZBCfKM+DmplT8FymfJp3FpUuu1dwgGzZJ2hCgXu+OOgRJVL35tZLJrn3
X-Gm-Gg: Acq92OFWSAMPzovg6+yinzW0yDtF5BurFtCqAK7tdcbtWBCPFkMBlkm6Zj2MWbmHCo5
 5drkBJ00ciPiX1KjG5MfuM/4B4HW+a5d0ckAnEXnx/gunqmIN1DxiINQbAdaEltAUWv0zwHdMys
 MrZD7XOcpAgaI1W6g66iGW9oy8uY+ZCEgHEHxPNTTuTpCR86cSZbFHQt/36AsSjfPNSTCuOoyaW
 L3wieZfZ0rw/ehMxw+ljivnhXHmuNQ4UOkiifY/vUKp3YODaPX19LnxODwD2eXbAxM0VZU/3CNC
 cLldibinWDq8l6RPtnm5chzTxO+6SXEjjyqF0kuURySCPwyUK/YT+cCKdFJf+VlCN4HvFiOtDiI
 0PnfgoUlfyJt8yJZQnpBDQzKtXW74QXEfQ/khO+dkaPg8Im0sW8Y1agxYh1Q1HTlKrUu6vmax2T
 9OMn5/IcrRYu6KzoeqZaTSEzccEYuIlyBA9iajNETN6qmxYGhISD1Ibsct4bNvF5Nr79VaRrCQj
 LFIZMbaGrd5HGQNwTyo6mOC
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1e4 with SMTP id
 5b1f17b1804b1-49044ebc273mr258509015e9.26.1779769805650; 
 Mon, 25 May 2026 21:30:05 -0700 (PDT)
Received: from localhost.localdomain (46-116-239-136.bb.netvision.net.il.
 [46.116.239.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49076a6abfasm6659625e9.12.2026.05.25.21.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 21:30:04 -0700 (PDT)
From: Leonid Bloch <lb.workbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Leonid Bloch <lb.workbox@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 2/8] docs/specs: Introduce the QEMU Battery documentation
Date: Tue, 26 May 2026 07:29:21 +0300
Message-ID: <20260526042928.9203-3-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526042928.9203-1-lb.workbox@gmail.com>
References: <20260526042928.9203-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---
 MAINTAINERS            |   5 ++
 docs/specs/battery.rst | 154 +++++++++++++++++++++++++++++++++++++++++
 docs/specs/index.rst   |   1 +
 3 files changed, 160 insertions(+)
 create mode 100644 docs/specs/battery.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5c4831e2..e356f46a58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3036,6 +3036,11 @@ F: hw/nitro/
 F: include/hw/nitro/
 F: docs/system/nitro.rst
 
+Battery
+M: Leonid Bloch <lb.workbox@gmail.com>
+S: Maintained
+F: docs/specs/battery.rst
+
 Subsystems
 ----------
 Overall Audio backends
diff --git a/docs/specs/battery.rst b/docs/specs/battery.rst
new file mode 100644
index 0000000000..2ce2b90da4
--- /dev/null
+++ b/docs/specs/battery.rst
@@ -0,0 +1,154 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==============
+Battery Device
+==============
+
+The battery device provides battery state information to the guest via ACPI.
+Battery state is controlled via QMP commands, providing deterministic control
+for testing and migration safety.
+
+Configuration
+-------------
+
+The battery device is created as an ISA device using ``-device battery``.
+
+Properties
+~~~~~~~~~~
+
+``ioport`` (default: 0x530)
+  I/O port base address for the battery device registers.
+
+ACPI Interface
+--------------
+
+The battery device exposes itself as an ACPI battery device with:
+
+* **_HID**: ``PNP0C0A`` (Control Method Battery)
+* **Device path**: ``\_SB.BAT0``
+
+The device implements standard ACPI battery methods:
+
+``_STA`` (Status)
+  Returns the battery presence status.
+
+``_BIF`` (Battery Information)
+  Returns static battery information including design capacity,
+  technology, and model information.
+
+``_BST`` (Battery Status)
+  Returns dynamic battery status including current state
+  (charging/discharging), present rate, and remaining capacity.
+
+I/O Interface
+-------------
+
+The battery device exposes 12 bytes of I/O space at the configured
+I/O port address with the following layout:
+
+* **Bytes 0-3**: Battery state (DWORD)
+
+  Bits 0-3 hold the ACPI ``_BST`` state (1 = discharging,
+  2 = charging); bit 4 carries the battery presence flag exposed by
+  ``_STA`` (set when the battery is present).
+
+* **Bytes 4-7**: Battery rate (DWORD)
+
+  Current charge/discharge rate normalized to design capacity.
+
+* **Bytes 8-11**: Battery charge (DWORD)
+
+  Current battery charge level normalized to design capacity.
+
+All values are normalized where the design capacity equals 10000 units.
+
+ACPI Notifications
+------------------
+
+The battery device generates ACPI notifications through GPE events:
+
+* **GPE._E08**: Status Change (0x80) - Battery state change
+
+QMP Commands
+------------
+
+The following QMP commands control the battery state:
+
+``battery-set-state``
+  Set the battery state. Parameters:
+
+  * ``present``: Whether the battery is present (boolean)
+  * ``charging``: Whether the battery is charging (boolean)
+  * ``discharging``: Whether the battery is discharging (boolean)
+  * ``charge-percent``: Battery charge percentage 0-100 (integer)
+  * ``rate``: Charge/discharge rate in mW (optional integer)
+
+  Example::
+
+    -> { "execute": "battery-set-state",
+         "arguments": { "state": {
+           "present": true,
+           "charging": true,
+           "discharging": false,
+           "charge-percent": 85,
+           "rate": 500
+         }}}
+    <- { "return": {} }
+
+``query-battery``
+  Query the current battery state. Returns the same fields as above.
+
+  Example::
+
+    -> { "execute": "query-battery" }
+    <- { "return": {
+           "present": true,
+           "charging": true,
+           "discharging": false,
+           "charge-percent": 85,
+           "rate": 500,
+           "design-capacity": 10000
+         }}
+
+Examples
+--------
+
+Basic usage::
+
+  # Start VM with battery device
+  qemu-system-x86_64 -device battery -qmp tcp:localhost:4444,server,wait=off
+
+  # From another terminal, set battery state via QMP:
+  echo '{"execute":"qmp_capabilities"}
+        {"execute":"battery-set-state",
+         "arguments":{"state":{"present":true,"charging":false,
+                               "discharging":true,"charge-percent":42,
+                               "rate":500}}}' | \
+  nc -N localhost 4444
+
+Simulate battery discharge::
+
+  # Start with 100% charged battery
+  echo '{"execute":"battery-set-state",
+         "arguments":{"state":{"present":true,"charging":false,
+                               "discharging":true,"charge-percent":100,
+                               "rate":1000}}}' | nc -N localhost 4444
+
+  # Later, update to 50% charged
+  echo '{"execute":"battery-set-state",
+         "arguments":{"state":{"present":true,"charging":false,
+                               "discharging":true,"charge-percent":50,
+                               "rate":1000}}}' | nc -N localhost 4444
+
+Simulate charging::
+
+  # Start with 25% battery, begin charging
+  echo '{"execute":"battery-set-state",
+         "arguments":{"state":{"present":true,"charging":true,
+                               "discharging":false,"charge-percent":25,
+                               "rate":500}}}' | nc -N localhost 4444
+
+Combined with other laptop devices::
+
+  # Create a complete laptop environment
+  qemu-system-x86_64 -device battery -device acad -device button
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index b7909a108a..3442b76da6 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -22,6 +22,7 @@ guest hardware that is specific to QEMU.
    acpi_pci_hotplug
    acpi_nvdimm
    acpi_erst
+   battery
    sev-guest-firmware
    fw_cfg
    fsi
-- 
2.54.0


