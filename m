Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E593CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 17:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up9NH-0007Fv-CV; Thu, 21 Aug 2025 13:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1up9NF-0007EE-Hu
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 13:46:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1up9ND-0003mW-6d
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 13:46:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45a1b04f8b5so7679215e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755798408; x=1756403208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F3XTh3fVFhgbXUBd3uiI0W181C7Bc1aMSdkuayb4H58=;
 b=OpxTz2XQeSiJkYpIj2kLOZjABGXBymwdlfdG+hu8n76uLga8Pw+zP0buxJ4cY61pDo
 qIRxhl8BR4oBwOL83AHOJdeoYvrcA/QpJvPRmEeo5o2alupHHWReuJFxzliTBrzRcis9
 l4eh5qH5OjoZmIAg2znxLZnCOdNHv5jvtauHvmQLG8Zg+MYYvD6NQhgRpdoQgrAhATZY
 n2x2dtrpHP9gSEnal0x0ooR7Obd5j/Wq8oSuMxvdtWyU5UhgftL6yrVfrOp44fQCFmcc
 3wO5p05wTuYYkCaUdjxwsOMXacfrtxq/4pBbIRPy4mLxkhDWivUhpvfo88BD+6lz4Hvu
 2p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755798408; x=1756403208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F3XTh3fVFhgbXUBd3uiI0W181C7Bc1aMSdkuayb4H58=;
 b=K08C3XkREe9Yxexb/sDr9HG6n25kT1+PV+4wJT8xjn4KK20LVA/itiQ849KIkr5Ntj
 5Zy/xGEZC1dMBGhTm3WePyY5ZsvCfdhggQG2Hh8B4r1RPlOdTUGfyD/KgRe7kuQo0ByD
 kegaf2j4CVGSVubUUc+eckzubUMe5GnlK0fe3Oyal4j/r8A7j0qag1irSLohpn4y8OJp
 3OR982qIP09YUhLs5TcnBzwEO8exignfwGoqiPfanson4UBBM/mjyCjJup0d2EOE0+8+
 8j1U1kQDUU8NjjaSGo0Q1nA5cipaLvqsq3vG115d2OnyBeb0MT+taaZKpTaEbtxnuTmY
 9ApA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRM9NZzJrpGztwCmtETOcl9CT9oE6iYhg0roZgYtIUthIijtvDxJiAt60/KMPmHr3CZM3TwboCqfKF@nongnu.org
X-Gm-Message-State: AOJu0YxjgWLMQSrlk7uZK0POQmFX3utz4EQstS/bSsMwpKZ2ZBqomToB
 1eHxx1utti/kbCd6kcRV8z7V/iz8UY9Ne1NcXmNRcbmqeDdYxDno54n1
X-Gm-Gg: ASbGncugPEPxWj3T6t0cAS5oKrXdM8IUyy5KM7yg8/SH8Ts5uyilQgpPi+IGe1DC48P
 wQDJAmHWWcoXbn1hUV2C/eUqUGaQih7a8w2MBNTeAS6rG+5CTnHguYLG9b4dm7+rShHngJYBDi2
 SGROMKrF9gWJ0uvwSif1/+aDGI0ZdE4WIXKHxFWQvrX0XoFi2qG+v8TN5mumAVuGTMizPUS4jcz
 xEbNE8F87oEswxpWkQeCwHPIMQkDqW90CIQqzYqNmzqND/Mv3bWXOLJTPBgwsNLjwbPqPTOw5j5
 hQa3jPImPO4KU1/dZNRg/fMlmq5gTul3GwnU6jZgUpIOn3JplnQYOVDA7LC0BJDEdFBcd6vICrB
 4rP32/F0jkkT4Vt4OSTtGmh0Nc+R+tQ3SAvYN8sG40C9rNRqMVwyl9KGf0lBnKAmp80TZ4/pOir
 U=
X-Google-Smtp-Source: AGHT+IFrLg1QMSWuCSSJUMem7WDcamvDhoVh9Q/GeVQOGvHaEz+x6TwSGXG3B9VdIYIY5d2s3GiaIg==
X-Received: by 2002:a05:600c:3592:b0:459:dc99:51bf with SMTP id
 5b1f17b1804b1-45b4d858dcdmr26954585e9.25.1755798407610; 
 Thu, 21 Aug 2025 10:46:47 -0700 (PDT)
Received: from localhost.localdomain (46-116-237-160.bb.netvision.net.il.
 [46.116.237.160]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879f5fsm12485360f8f.4.2025.08.21.10.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 10:46:47 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Introduce a battery, AC adapter, and lid button
Date: Thu, 21 Aug 2025 20:45:48 +0300
Message-ID: <20250821174554.40607-1-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x329.google.com
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

First, I must apologize for the extremely long delay since v1 - it has been
nearly 4 years, which is unacceptable. Life circumstances intervened.

This series introduces three ACPI devices that are particularly useful
for laptop/mobile virtualization:

* Battery
* AC adapter
* Laptop lid button

Changes in v2:
--------------
Based on the feedback from Philippe Mathieu-Daudé and Michael S. Tsirkin:

* Complete redesign with dual-mode operation:
  - QMP control mode (default): Devices are controlled via QMP commands,
    providing deterministic behavior essential for migration and CI/testing
  - Host mirroring mode (opt-in): Original sysfs/procfs monitoring behavior,
    now disabled by default

* Migrated to modern QEMU ACPI architecture:
  - Devices now implement ACPI_DEV_AML_IF interface
  - AML generation moved from centralized acpi-build.c to device files

* Added a QMP interface:
  - battery-set-state/query-battery
  - ac-adapter-set-state/query-ac-adapter
  - lid-button-set-state/query-lid-button

* Documentation improvements:
  - Converted to .rst format
  - Added examples for both QMP and "fake" sysfs/procfs testing

The dual-mode design ensures these devices are migration-safe and
deterministic by default, while still allowing host state mirroring
when explicitly requested for desktop use cases.

Use cases:
----------
1. Testing: CI systems can programmatically control power states
2. Cloud: Expose virtual battery for usage-based resource limiting
3. Desktop virtualization: Mirror host laptop state to guest (opt-in)
4. Development: Test power management without physical hardware

Example usage:
--------------
# Default QMP-controlled battery
qemu-system-x86_64 -device battery

# Mirror host battery
qemu-system-x86_64 -device battery,use-qmp=false,enable-sysfs=true

# Control via QMP
{"execute": "battery-set-state",
 "arguments": {"state": {"present": true, "charging": false,
                         "discharging": true, "charge-percent": 42,
                         "rate": 500}}}

The series has been tested with Windows and Linux guests, correctly
showing battery status, AC adapter state, and lid button events in
guest UIs and triggering appropriate power management actions.

Thanks again for your patience and feedback.
Leonid.

Leonid Bloch (4):
  hw/acpi: Increase the number of possible ACPI interrupts
  hw/acpi: Introduce the QEMU Battery
  hw/acpi: Introduce the QEMU AC adapter
  hw/acpi: Introduce the QEMU lid button

 MAINTAINERS                          |  18 +
 docs/specs/acad.rst                  | 195 +++++++
 docs/specs/battery.rst               | 225 ++++++++
 docs/specs/button.rst                | 189 +++++++
 docs/specs/index.rst                 |   3 +
 hw/acpi/Kconfig                      |  12 +
 hw/acpi/acad.c                       | 447 ++++++++++++++++
 hw/acpi/battery.c                    | 735 +++++++++++++++++++++++++++
 hw/acpi/button.c                     | 438 ++++++++++++++++
 hw/acpi/core.c                       |  17 +-
 hw/acpi/meson.build                  |   3 +
 hw/acpi/trace-events                 |  15 +
 hw/i386/Kconfig                      |   3 +
 hw/i386/acpi-build.c                 |   1 +
 include/hw/acpi/acad.h               |  27 +
 include/hw/acpi/acpi_dev_interface.h |   3 +
 include/hw/acpi/battery.h            |  33 ++
 include/hw/acpi/button.h             |  25 +
 qapi/acpi.json                       | 171 +++++++
 19 files changed, 2558 insertions(+), 2 deletions(-)
 create mode 100644 docs/specs/acad.rst
 create mode 100644 docs/specs/battery.rst
 create mode 100644 docs/specs/button.rst
 create mode 100644 hw/acpi/acad.c
 create mode 100644 hw/acpi/battery.c
 create mode 100644 hw/acpi/button.c
 create mode 100644 include/hw/acpi/acad.h
 create mode 100644 include/hw/acpi/battery.h
 create mode 100644 include/hw/acpi/button.h

-- 
2.50.1


