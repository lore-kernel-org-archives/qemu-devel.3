Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB3DCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjQl-0007T8-1c; Tue, 26 May 2026 00:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQj-0007SB-E5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQh-0007aT-Hj
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso44960015e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769810; x=1780374610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VoRWV4KuXE1NBOqs848LK5rIJtwxJka5Ant/9lNcJsw=;
 b=Mpox/IpZNlm7XMHSiZuGEgneHfG1CQZVE/GPffI5lOAq0/kACl4Jgz6xREvkYboKPw
 L7KjM8mrbqsrRcZr/FmRntQYLr9afV24z3JPAMZMyo/FCUP+ESqVi3pAmWL86P5Fi29u
 WoPmkjO1Mg2M/W+1ht/JhKyMRznmxFwRGTdOa+ApmEVnTM3BVPxjnvZbyE9MlOHUhJZ+
 e7U5Jyyao40nxPwv8RqpWbQezcEPEuy3jTwIBGyHuM/lwJ+XhM02BFwld3FpQD0l/NPf
 BOrjSv7nb3TM3s39/FNdkFVXZZHLTXF1ihgwrOpBdZsNya8QfM1FS+b9uXufOd7e4ZD0
 LzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769810; x=1780374610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VoRWV4KuXE1NBOqs848LK5rIJtwxJka5Ant/9lNcJsw=;
 b=tZd91A9hd7utcs2W25NFLWfUKaodXjoUYdNSPnNX4aIyp8/VBP4gFUZ35xC1NbA+0J
 AWardDrSe0XEUWHbgLgJ7zymk5X0x3pccSvGiByLNS/0ez9PUMpE4Z1X1aOpal09lpX9
 lNkX/dkr4UeZq0Z+uz290l5r9b8Cvi88iPhPgRfMS+DGy9BGppPmDM6+SLjXrbgHMu3A
 lDGkuOB4F/9GowNMdYfsj2EkcLRmYN12p9x/z3wryPJbpr0DxV7OmxPB8CgBTwT5WOgJ
 18y8/VNujliWxtr1djO5Y7dSzJuTEeiZ7rQ6hrf3z08X593+pIyNkH8CZc88uJ+L/x9O
 Nlaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ96Jvn6uC0qW3HNhtDCtfzD4fPk6r5SJJnVPF2PZfaSCBTsPQXgg0fKIKdbSIHtiZSZmzP8oTCU7rdc@nongnu.org
X-Gm-Message-State: AOJu0Ywk56X0Dt89vga19nlFjSJldvKrZxaOOOtZL+pqGyAZhaRg5z0f
 Kgk/ndEHkK0OViuKv6wsfctm60MnLgIwhK2lPvLEql8OAZB6La2nTob5
X-Gm-Gg: Acq92OFzTzfRFe3REpYX6ETLeZsHkElfDCdS4cA8gzuA3gHbex7BGdIn2UEMByF4ecu
 /5UxKwwhq4mMnf9arfej7HBJ3khZvSkSMSH4orNAkTzyCoMgiiaKnV6fLe/iGTh+0hDyORyTpuS
 8V218OBZzQc/UyWdnsYuTZzNHwZC+C+G2LKKOQw6sCUw/ykBGpE6og0nQTvkbOcHszifxcpg8HS
 MNgA3OIe/EcwkGKgqSPlSY/qx5UwOunMXuKBqmyxaOH2lBlKVCd8PZvqr//orGEiTM45mB1y36u
 Hk+/OdV2TFx9K+t3h+Ml+zCsPvA6IzlA8e5k1S7lEPgDHUhYu9giVhFuWq/Zo+aKbCzob1Gtfx7
 kalKmAIof4/KdUzLZ9gwUBLGynRXsQUluPBLZm2f8Z71xSvmArzWXK/ineWbGqEtM69yhQ3E6oQ
 zm60YGr6t1YNUeVZLsYGNkhmmvgxLclaCITap6+NoOxPFtnLZhfFSj8U0l1jKBH9ew1DvsLAeVN
 Oaq5yNiRVbhBsCXEAyZ1NfG
X-Received: by 2002:a05:600c:46cb:b0:48e:6db3:ff33 with SMTP id
 5b1f17b1804b1-490426add7dmr276165165e9.14.1779769810005; 
 Mon, 25 May 2026 21:30:10 -0700 (PDT)
Received: from localhost.localdomain (46-116-239-136.bb.netvision.net.il.
 [46.116.239.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49076a6abfasm6659625e9.12.2026.05.25.21.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 21:30:09 -0700 (PDT)
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
Subject: [PATCH v4 4/8] docs/specs: Introduce the QEMU AC adapter documentation
Date: Tue, 26 May 2026 07:29:23 +0300
Message-ID: <20260526042928.9203-5-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526042928.9203-1-lb.workbox@gmail.com>
References: <20260526042928.9203-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x32d.google.com
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
 MAINTAINERS          |   5 ++
 docs/specs/acad.rst  | 126 +++++++++++++++++++++++++++++++++++++++++++
 docs/specs/index.rst |   1 +
 3 files changed, 132 insertions(+)
 create mode 100644 docs/specs/acad.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index ce50329f48..47436ec878 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3043,6 +3043,11 @@ F: docs/specs/battery.rst
 F: hw/acpi/battery*
 F: include/hw/acpi/battery.h
 
+AC Adapter
+M: Leonid Bloch <lb.workbox@gmail.com>
+S: Maintained
+F: docs/specs/acad.rst
+
 Subsystems
 ----------
 Overall Audio backends
diff --git a/docs/specs/acad.rst b/docs/specs/acad.rst
new file mode 100644
index 0000000000..af79b4b8d7
--- /dev/null
+++ b/docs/specs/acad.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=================
+AC Adapter Device
+=================
+
+The AC adapter device provides AC power state information to the guest via ACPI.
+AC adapter state is controlled via QMP commands, providing deterministic control
+for testing and migration safety.
+
+Configuration
+-------------
+
+The AC adapter device is created as an ISA device using ``-device acad``.
+
+Properties
+~~~~~~~~~~
+
+``ioport`` (default: 0x53c)
+  I/O port base address for the AC adapter device register.
+
+ACPI Interface
+--------------
+
+The AC adapter device is exposed to the guest as an ACPI device with:
+
+* **HID**: ``ACPI0003`` (AC Adapter)
+* **Device Path**: ``\_SB.ADP0``
+* **Notification Values**:
+
+  * ``0x80``: Status change (connected/disconnected)
+
+ACPI Methods
+~~~~~~~~~~~~
+
+``_PSR`` (Power Source)
+  Returns the current AC adapter state (0 = offline, 1 = online).
+
+``_PCL`` (Power Consumer List)
+  Returns the list of devices powered by this adapter.
+
+``_PIF`` (Power Source Information)
+  Returns static information about the power source including model number,
+  serial number, and OEM information.
+
+I/O Interface
+-------------
+
+The device uses a single I/O port register:
+
+* **Port**: ``ioport`` property value (default 0x53c)
+* **Size**: 1 byte
+* **Access**: Read-only
+
+Register Layout
+~~~~~~~~~~~~~~~
+
+**PWRS** (offset 0x00, 1 byte)
+  Current AC adapter state:
+
+  * ``0x00``: AC adapter offline (unplugged)
+  * ``0x01``: AC adapter online (plugged in)
+
+QMP Commands
+------------
+
+The following QMP commands control the AC adapter state:
+
+``ac-adapter-set-state``
+  Set the AC adapter connection state.
+
+  * ``connected``: Whether the AC adapter is connected (boolean)
+
+  Example::
+
+    -> { "execute": "ac-adapter-set-state",
+         "arguments": { "connected": true }}
+    <- { "return": {} }
+
+``query-ac-adapter``
+  Query the current AC adapter state.
+
+  Example::
+
+    -> { "execute": "query-ac-adapter" }
+    <- { "return": { "connected": true }}
+
+Examples
+--------
+
+Basic usage::
+
+  # Start VM with AC adapter
+  qemu-system-x86_64 -device acad -qmp tcp:localhost:4444,server,wait=off
+
+  # From another terminal, set AC adapter state via QMP:
+  echo '{"execute":"qmp_capabilities"}
+        {"execute":"ac-adapter-set-state",
+         "arguments":{"connected":true}}' | \
+  nc -N localhost 4444
+
+Simulate unplugging AC adapter::
+
+  # Start with AC adapter connected
+  echo '{"execute":"ac-adapter-set-state",
+         "arguments":{"connected":true}}' | nc -N localhost 4444
+
+  # Later, disconnect AC adapter
+  echo '{"execute":"ac-adapter-set-state",
+         "arguments":{"connected":false}}' | nc -N localhost 4444
+
+  # Reconnect AC adapter
+  echo '{"execute":"ac-adapter-set-state",
+         "arguments":{"connected":true}}' | nc -N localhost 4444
+
+Combined with battery device::
+
+  # Create a complete laptop power environment
+  qemu-system-x86_64 -device battery -device acad
+
+  # Simulate unplugging AC while on battery
+  echo '{"execute":"battery-set-state",
+         "arguments":{"state":{"present":true,"charging":false,
+                               "discharging":true,"charge-percent":75}}}
+        {"execute":"ac-adapter-set-state",
+         "arguments":{"connected":false}}' | nc -N localhost 4444
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 3442b76da6..a19c75384c 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -22,6 +22,7 @@ guest hardware that is specific to QEMU.
    acpi_pci_hotplug
    acpi_nvdimm
    acpi_erst
+   acad
    battery
    sev-guest-firmware
    fw_cfg
-- 
2.54.0


