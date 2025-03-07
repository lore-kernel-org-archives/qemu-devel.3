Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB5AC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZQw-0005pd-TC; Fri, 07 Mar 2025 10:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQV-0005md-NS
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:15:54 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQS-00038I-Jm
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:15:51 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bc4b16135so11856585e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360546; x=1741965346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7oKWh8O/IZLO/Fz45tuitlzS7POId7kZ1F5N/LuYBuM=;
 b=jaLGyH1CaUD7/aaX89qRGysWbd5sEHMr2Ge2E4M6R4K8ut2GbmhPMvR2xg/HcdQwyH
 J4kAR3Ex1LMRFqddpkImqkvk6H/3CmSRVqSqkGmeppGWFXL5h/EEzb8cR8+xm2RvySFH
 NGySEPZhJnRtMWEDVNuxSbIIR204lBJKmoIt6SmvO7Xl6sRbMgUb2eTh6c9IkwxvH96w
 akeMCIaAZjYB+3Fidtkf5auzBi4wi+EO/9NGPxYKEapFYr48vCuiigx9T+bN+1Vh4NjY
 KAg9/6LnfCPDX4qrI7bdy2UZcWriudVS8syGVIOivtCLX7PS2+kxor99elWbAZ4Y/XXk
 Rj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360546; x=1741965346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7oKWh8O/IZLO/Fz45tuitlzS7POId7kZ1F5N/LuYBuM=;
 b=W1NZGzmuRxoUkPOqfDX6ahwasqhvWirWqNaXDcHUU4tXaNwl0jHD45Fbexo1qsm09e
 ZnOQM+nz9DgaveCfN9FzYKoAkExfXI7wchPvVSTzAu8z6yOhwzNJAAmAZcVzjE6bi9F7
 rLytXkkcoOutSrOTyAgnTo3gVBgc1GD5KCiGftxDRmv0QzfCamdmgOh9JJZY1AHfd/vT
 z/E79S2FX94xbOyMMRhIEuMbSwtojhSyXyTMZSM95dL6cLFFtD96z4PR03LgHCKVoSmW
 Gm1n1T7AcbY+Mh0TSUZ/swgHNVEDJdFANYIUhCpFn0OfZ908uJtZimtbiL7wMSBvP/S3
 ydOw==
X-Gm-Message-State: AOJu0YyI8swBUr3qjjzGfCQhkcTeJ6xUSoMgLyw907xucQtTJrdMOzH+
 sIfPe8CEjTzwsx+uCvq8vprUROdDFtvFMzsQp9j3GeA1aBZe8tN8dgpLpA5+DKwbuW1zYZy5P9A
 2tyo=
X-Gm-Gg: ASbGncsvfkEWrb8FEsoQxp+iAIFyqrcifd/Sfd/xka1tCi0qcjhA73+xf2CL9Bk5NHk
 h/NtoWJhxJGi4lH1//UuHOlLTT8CifRyZL22WrWtEto4QGLfBljDrjW++Net8yMx0Tihen7t0h3
 L4JoM/3V048BltLLlyFVlL9AhDC1wx9Lj19CHxFoTsoiVDwARvAEe061/NDyN1o6wXpy2YcXEIW
 dk8bkcABXmbwQuCmRf3cK8zL+En0lMFHBu+GRr/iAwWARsshZcbU7F8eMV7KhfmBB2SnxqZdVaC
 bIZvQl+ISK6XT7QukVs4twpqww5ZMJC8lGbnl5HpD+2RVgsYPFecCjYqpjiBQXJuzwJ0rrdcxfD
 uWrseDSxNlv9zy3uJtqg=
X-Google-Smtp-Source: AGHT+IEeMAOkiYda9KJWykCtQsfkURmdlX5nIBs8EvUkcBmhy9h8osraHRrgUBginPGiAcsVJ/CJiQ==
X-Received: by 2002:a5d:5f89:0:b0:391:253b:4046 with SMTP id
 ffacd0b85a97d-39132d3331bmr3113963f8f.16.1741360546018; 
 Fri, 07 Mar 2025 07:15:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7934sm5702072f8f.12.2025.03.07.07.15.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 07:15:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] hw/virtio: Build virtio-mem.c once
Date: Fri,  7 Mar 2025 16:15:36 +0100
Message-ID: <20250307151543.8156-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Replace compile-time checks by runtime ones:
- CONFIG_DEVICES::CONFIG_ACPI -> acpi_builtin()
- TARGET_FOO || TARGET_BAR -> qemu_arch_available(FOO|BAR)

Philippe Mathieu-Daudé (7):
  system: Replace arch_type global by qemu_arch_available() helper
  hw/acpi: Introduce acpi_builtin() helper
  hw/i386/fw_cfg: Check ACPI availability with acpi_builtin()
  hw/virtio/virtio-mem: Remove CONFIG_DEVICES include
  hw/virtio/virtio-mem: Convert VIRTIO_MEM_USABLE_EXTENT to runtime
  hw/virtio/virtio-mem: Convert VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
  hw/virtio: Compile virtio-mem.c once

 include/hw/acpi/acpi.h     |  3 ++
 include/system/arch_init.h |  2 +-
 hw/acpi/acpi-stub.c        |  5 +++
 hw/acpi/core.c             |  5 +++
 hw/i386/fw_cfg.c           |  8 ++--
 hw/scsi/scsi-disk.c        |  2 +-
 hw/virtio/virtio-mem.c     | 88 ++++++++++++++++++++------------------
 system/arch_init.c         |  5 ++-
 system/qdev-monitor.c      |  4 +-
 system/vl.c                |  6 +--
 hw/virtio/meson.build      |  2 +-
 11 files changed, 75 insertions(+), 55 deletions(-)

-- 
2.47.1


