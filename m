Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1D7CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 22:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urOD6-0006hM-68; Wed, 27 Aug 2025 18:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1urOCy-0006eV-W9
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:01:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1urOCw-0007dy-5F
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:01:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso1436445e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756332088; x=1756936888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QwvFQletpVNX8GiBuI/ugiqp5mFwp3F4H0YL0Nrucjo=;
 b=S2X48AtVfLhYcEWNY+QeJwQHyJVKSBzaUlFo66TGR08WYKnTr5fXFKlh364IUG1al/
 bBq6C9rPW84e8tHb2nsLD5kFVgFRSHWs709HZRY2QuzjhBTv1AxTiQgkETMgRuVjdkDg
 RMzyXy1HrKoe6GFi3gMFxLA5Q5IG95OQb7Z9JZLhzmezHDt/TGigC6IVWwYNBmvH0rQz
 KsbNEBGrf5DiNmCt/IfWSpwl2SVCm2A3ck/YIuGiMbJFPtWkQfCAtX8cOUGK10+D1gbn
 iJdykhAgmMY6KOwQ/VCNkRFlYFdRJwAyRnBpush+MReRKv2QYn4iK4ZdlBGaDGA0lAwl
 IMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756332088; x=1756936888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QwvFQletpVNX8GiBuI/ugiqp5mFwp3F4H0YL0Nrucjo=;
 b=pY7DTaIe9LKwlemXVBZmh46Va/6I8+wZtdM4jtfdc6GGt7g9wOiPAE95rOlDfr2no3
 d/6az42COe0nrjNzbxkY+ekTwC+Ymlmdn2kx8beI+PVrAHO1F08CyZJ8apTpKupr5XvW
 b8jQXHMCja8v95y5JKodHJyrM54sgWg4sJF+vBQ16z80bZx9+j/dXAH3cDUMvocCrWW+
 /+KUxzVQ9bsdbShGwo60C21J886NlaUUtzhHz+/YEFUwr6WZWIXvx2uD63OfPzi9MMSX
 Eehpk23Hp4kMWDeDWVRlN6ETlSC2t5K3PPNTaQoAeEAhIMpe0pE95PGrJWU+nt6X1V6W
 AlMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVErhFjiyGGDgAt7zmjhmOozMZOh4FD5W2DMvA834yX+bpLhw9c/KVhOD8yMe91L1Yw+qojbyJNnWgA@nongnu.org
X-Gm-Message-State: AOJu0Yxv8tjha7VV5fX5gYGYWu+5JgiNOpGTrYyf6kxF3aZvnIsWnJhH
 5MqfONBiDsKUVJeGgo86c5HGHILBcfvxlTn+yNsbYNWZg2zdHj9T27P9
X-Gm-Gg: ASbGncuv5qgmtD5QSwSiteBqTKM6GF0jJESDNYrNWpmK6MPWhk+hdpRyiGKxp/AgNRA
 OesdPzvZyef4kVD+Lsb2N+/ApEQ+/LdDqFUHgp9ndI9v/3VbiKUzAtv/dXcC4Mof1bMIlHjfp4/
 Ps4NcsFqgATOilnbTM3F0c1OtHKpCn5oJRjWgvXYFG00GnV59B7FttaMourtlxdgj+dScQMPPCC
 4d4+yYDqUgH9AetXSZQXmGUsqcISU4dN4XKYWaFPBQoEWv3Rx8xxQSxof5ZquRCftt2RClzqU28
 /yYZWQP+0g8sDa8KLbFVnDi3+ZH2Ve2B61bk6gvcrV6ioQNnVeD8mHW4Naajm6e1cLHo7YTgAv+
 BRCy/cQZsskmyJldLxxKikEfLP82v5MyxFihBEzni9/RVFEzV9jArpdcS/DAR6qKV6LgBlspfJ4
 CRCWKj+By74w==
X-Google-Smtp-Source: AGHT+IGWnIXNg4l3Z9gc14eublFreCWGC1Upn8tP+Nv/xMig/Th939wMK03+x9CAoYEiZ218d4vCjA==
X-Received: by 2002:a05:600c:530e:b0:45b:615c:cd2 with SMTP id
 5b1f17b1804b1-45b615c0df5mr109108895e9.8.1756332087486; 
 Wed, 27 Aug 2025 15:01:27 -0700 (PDT)
Received: from localhost.localdomain (46-116-237-160.bb.netvision.net.il.
 [46.116.237.160]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b797ce2b8sm4116755e9.12.2025.08.27.15.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 15:01:26 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Introduce a battery, AC adapter, and lid button
Date: Thu, 28 Aug 2025 01:00:46 +0300
Message-ID: <20250827220054.37268-1-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x332.google.com
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

This series introduces three ACPI devices that are particularly useful
for laptop/mobile virtualization:

* Battery
* AC adapter
* Laptop lid button

Link to v2: https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg03166.html
Link to GitHub PR, for ease of review: https://github.com/blochl/qemu/pull/3

Changes in v3:
--------------
* Rebased on latest master
* Addressed the v2 review by Igor Mammedov

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
  hw/acpi: Support extended GPE handling for additional ACPI devices
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
2.51.0


