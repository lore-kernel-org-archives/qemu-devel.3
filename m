Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE291CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjQq-0007Xl-7O; Tue, 26 May 2026 00:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQo-0007VI-Pr
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQm-0007bB-Ox
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so63400505e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769815; x=1780374615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GgotwpIiqgakcYFqmApeCWJNrj5+Tz6ljYoT6vEE4I=;
 b=gZ3Ii3oZmMFlGIXfSz4k01E6con0NUuyBesmsMbu1MAk+59eG7SBUlDF+rx0IOkcsk
 k6gm1RQzgYTB3021MK/4ejlWlvYjkzMRTTJlK8QKWSQXSKBXs7s/00n2EgJQojNu+ufO
 08aq8gG9tjrbkWzxD6VltbAe3FW4r4/pUTfsHy58GrDt6BdxtPoopWZhpITwrLJpvgTa
 /qwI+Qvnw4uEfAsz7GVn+xkve8dayuuegIVoLn/LdIt6jSULuYY6IjsmWFBuqPvPKc87
 N5+rm8hy0qYEJOR/iGOKHZdm56k4ycxRojBQxEPj2gqByAvyCw6kPLDwrdn9cq9SZiYV
 kggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769815; x=1780374615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1GgotwpIiqgakcYFqmApeCWJNrj5+Tz6ljYoT6vEE4I=;
 b=FlcWEsZSbyvLhW4VHQGch9wtOBqtleaNuPCIdAs90KszqLdKAKQEYtkuBHkzHcKT4k
 XHPnONI3/A4FA83PCP9xe9/NwSYsnM4ba1fOhPvv/YXshMWBStKGrhFg9U9/rAxy2Jfg
 SoQWgL7HHVnjhSxJkYE1sMGUOuPouHz0EZIei6waWzgttXKQBmk1qiGmh6Ri8bafti17
 mC87cXlCpjKsTrr3ZpevNlLvSqV50ufZOzMLFQPSGdlhjD9T+Lr0K1Qw3yYmL4c76C6q
 gIJe//JLVnn9/qNNVVaWUrN9o9FnqEXs8vfeSoeAriwbN95mSqIL/ftnzNxWIuFasSyd
 4Uqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oLV8XNHflxx/8mom59Ye1Q+HacUHs9OV6xRc2N3VGI4NTtENRNtDpSp4Z/RQheC4k2sPUM6nGpiyO@nongnu.org
X-Gm-Message-State: AOJu0Yx/skjtKgWB5343wQe2mrNiaIOpriouO6kuALU6juYGmAJBJ0dB
 lRjSW7cH9P+42Gn8KRVeBy2BkUv6XDH1HNvyd32Ah3uFugr2ygHoZA2B
X-Gm-Gg: Acq92OEarSOqxKt+ueUU5LXcljaFDO7bmywFjiAjWV+bKH7hp0j9JQFMJq47P/qATvS
 za1jE831HEUvGsb2hSAWbcObVhxwGYSjGsYWOi7ZmcikA3+X3vFQMX89Me3GnKe3QTAzNha4GAO
 pfO1TBF8MRtnSCmllUsesX+dpFJoVSbaIB71J8ZoDnvUDO56dfTNQ/5HC9c/QlWGH3UQ4K+qEjQ
 Dm8QTlB/OjRTGjXyS28jxIrcbojorLNxZOT7IbIMHZ7jAFaPpBJ4ygdfw8KcphJItCil6H2ue84
 RFIBLnFfZN6UDMkru+EEzitew4tUk27wScCzotfoLlrrUatf24lsV8twDO7yiJEsm0XUf57sOzK
 3chioHw61CgctAaqa4OMWasEyP4F4znfvs2F9ghUFnXsxaX3cWhmpKKj2yuB9yl6CsElms2Ykqy
 rcM8NpSHLjm/sxokH9mB/0o96JBt71tiKMPzhbVFJOj78S28YJ5/558xAEjctZ9kgrxAFu0JE4v
 vIlyBoTwMj5LA==
X-Received: by 2002:a05:600c:c059:20b0:490:31e:d6fd with SMTP id
 5b1f17b1804b1-490426d3319mr205667305e9.25.1779769815217; 
 Mon, 25 May 2026 21:30:15 -0700 (PDT)
Received: from localhost.localdomain (46-116-239-136.bb.netvision.net.il.
 [46.116.239.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49076a6abfasm6659625e9.12.2026.05.25.21.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 21:30:14 -0700 (PDT)
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
Subject: [PATCH v4 6/8] docs/specs: Introduce the QEMU lid button documentation
Date: Tue, 26 May 2026 07:29:25 +0300
Message-ID: <20260526042928.9203-7-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526042928.9203-1-lb.workbox@gmail.com>
References: <20260526042928.9203-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x336.google.com
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
 MAINTAINERS           |   5 ++
 docs/specs/button.rst | 131 ++++++++++++++++++++++++++++++++++++++++++
 docs/specs/index.rst  |   1 +
 3 files changed, 137 insertions(+)
 create mode 100644 docs/specs/button.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 90941519e3..42179aba95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3050,6 +3050,11 @@ F: docs/specs/acad.rst
 F: hw/acpi/acad*
 F: include/hw/acpi/acad.h
 
+Button
+M: Leonid Bloch <lb.workbox@gmail.com>
+S: Maintained
+F: docs/specs/button.rst
+
 Subsystems
 ----------
 Overall Audio backends
diff --git a/docs/specs/button.rst b/docs/specs/button.rst
new file mode 100644
index 0000000000..10e57a380e
--- /dev/null
+++ b/docs/specs/button.rst
@@ -0,0 +1,131 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+========================
+Laptop Lid Button Device
+========================
+
+The button device provides laptop lid button state information to the guest via
+ACPI. Lid state is controlled via QMP commands, providing deterministic control
+for testing and migration safety.
+
+Configuration
+-------------
+
+The lid button device is created as an ISA device using ``-device button``.
+
+Properties
+~~~~~~~~~~
+
+``ioport`` (default: 0x53d)
+  I/O port base address for the lid button device register.
+
+ACPI Interface
+--------------
+
+The lid button device is exposed to the guest as an ACPI device with:
+
+* **HID**: ``PNP0C0D`` (Lid Device)
+* **Device Path**: ``\_SB.LID0``
+* **Notification Values**:
+
+  * ``0x80``: Status change (lid opened/closed)
+
+ACPI Methods
+~~~~~~~~~~~~
+
+``_LID`` (Lid Status)
+  Returns the current lid state (0 = closed, 1 = open).
+
+I/O Interface
+-------------
+
+The device uses a single I/O port register:
+
+* **Port**: ``ioport`` property value (default 0x53d)
+* **Size**: 1 byte
+* **Access**: Read-only
+
+Register Layout
+~~~~~~~~~~~~~~~
+
+**LIDS** (offset 0x00, 1 byte)
+  Current lid state:
+
+  * ``0x00``: Lid closed
+  * ``0x01``: Lid open
+
+QMP Commands
+------------
+
+The following QMP commands control the lid button state:
+
+``lid-button-set-state``
+  Set the lid button state.
+
+  * ``open``: Whether the lid is open (boolean)
+
+  Example::
+
+    -> { "execute": "lid-button-set-state",
+         "arguments": { "open": true }}
+    <- { "return": {} }
+
+``query-lid-button``
+  Query the current lid button state.
+
+  Example::
+
+    -> { "execute": "query-lid-button" }
+    <- { "return": { "open": true }}
+
+Examples
+--------
+
+Basic usage::
+
+  # Start VM with lid button
+  qemu-system-x86_64 -device button -qmp tcp:localhost:4444,server,wait=off
+
+  # From another terminal, set lid state via QMP:
+  echo '{"execute":"qmp_capabilities"}
+        {"execute":"lid-button-set-state",
+         "arguments":{"open":false}}' | \
+  nc -N localhost 4444
+
+Simulate closing lid::
+
+  # Start with lid open (default)
+  # Close the lid
+  echo '{"execute":"lid-button-set-state",
+         "arguments":{"open":false}}' | nc -N localhost 4444
+
+  # Later, open the lid
+  echo '{"execute":"lid-button-set-state",
+         "arguments":{"open":true}}' | nc -N localhost 4444
+
+Test suspend on lid close::
+
+  # Start VM with ACPI support
+  qemu-system-x86_64 -device button
+
+  # Close lid - guest OS should detect this and may suspend
+  echo '{"execute":"lid-button-set-state",
+         "arguments":{"open":false}}' | nc -N localhost 4444
+
+  # Open lid - guest OS should wake or detect lid open
+  echo '{"execute":"lid-button-set-state",
+         "arguments":{"open":true}}' | nc -N localhost 4444
+
+Combined with other laptop devices::
+
+  # Create a complete laptop environment
+  qemu-system-x86_64 -device battery -device acad -device button
+
+  # Simulate closing lid while on battery power
+  echo '{"execute":"battery-set-state",
+         "arguments":{"state":{"present":true,"charging":false,
+                               "discharging":true,"charge-percent":60}}}
+        {"execute":"ac-adapter-set-state",
+         "arguments":{"connected":false}}
+        {"execute":"lid-button-set-state",
+         "arguments":{"open":false}}' | nc -N localhost 4444
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index a19c75384c..54d8f5f7c5 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -24,6 +24,7 @@ guest hardware that is specific to QEMU.
    acpi_erst
    acad
    battery
+   button
    sev-guest-firmware
    fw_cfg
    fsi
-- 
2.54.0


