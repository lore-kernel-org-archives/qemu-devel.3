Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97D0C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYmL-0007CL-K6; Thu, 01 May 2025 14:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYly-0006WW-O1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:36:40 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYlw-0007sx-At
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:36:38 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85dac9729c3so127231339f.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124594; x=1746729394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8xzJ3zlVkJ9sCHkvUcas2yFr0SZOS/PHLHHyjGCEldc=;
 b=AlpWgqayG1ZdCoHm0rIrfh17c7uCiB1lz0g1VhMG11IaUfe0ZwRqJfFV9uCuZiNbeT
 FunwpASamJ3HTvxkFPVKb25sloAj9riB1r3HSI8J5dEmKr/O7UKw0qeUkM2vLYvkkQJl
 Ce6Nadlw9uwAEi1AmXepcX6Pn3qkwWxReRZ9sjHH8W9jPcYW46Xf6OT8pOCbUZbR+tC/
 6ZNxhKaCKgSLbn1gcZd8EJD9SkYPArZoRN/Fc9EQ59n48OxgPS4hYDa2fwktuysm5hxK
 l59DwVeBkwbzoR7Jf9mHT7mvnKTRPTKrFTwFAY0iAp+HhVRaNrT9CTQMDdfPBR+kXC4u
 fnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124594; x=1746729394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8xzJ3zlVkJ9sCHkvUcas2yFr0SZOS/PHLHHyjGCEldc=;
 b=MukLDkRPsuvP5cuwuO6Ru67BVods0Y+k/eOBf/IBgMV6PaG41B2CL29Q9t0dbgdA3i
 BFKaJD8NlmdILkzoETaK9XhYAzpPlDNMyouUuTy27Nb2k1qd8kKWmJMV8/NeAKPrGoyx
 aIzyoKKP80uSLTYDiRwTUqZnQXp0HhBxWF/aMHUFg+yvoGW5MN6W5umpxOEsXXKX3w3w
 kzH3T5+ejdpwzQGggmmx/qW+HSdD6V4aISRMVVwHYiEyq4QUOmde+mQmr9BFuX1aacvH
 88zlAcQpTDoEZ9/ihpj+Apan4sBuWAHGriUQxaXk1/Tp8fkGoDx/9uw4aiHxV2bc0pZU
 LKAA==
X-Gm-Message-State: AOJu0Yy3eor9m78TSWvuLByMAR0/B5YwR2VKkxicwnnOwsSsGkD6nG0P
 BkwyztEAvW9XwN9znMRsHeZ05Zfc2tCEIMMJP6XnWqLoQiMGx1UmIcZCG0kcwOfPjQpw1Y3A3Q/
 o
X-Gm-Gg: ASbGncsB/SqguCdUF050w9BDaOqlwKpYs8f+DXil4lAcu6ZwxuRm6NjWd8dpu/upKyi
 OwQ8w2b4sqjYHc5BzLm7oSj3F0RuQD7vHsJyNbMiiKYb45ww9ZQ13Qsb6RRWgVocDeSsTO+hgAa
 Esj0mZQ67t9oIMCDDqrKP3kAR7wHw8IDU4Nv+ISXy0sn6clY1ZH97t5nDe7aWDdpoUL2Y+f9pUK
 0o1vj+2INsnxaI1+9Skw/0/TnzAp6SS8TlPMC7xiRE7sZtE1mYAIqzYSNU7lq3n2mLtBYUVafbu
 VXeqDl5DjzNoqY1SUORd0KEc1V+Fz4fsRzGKUIznV0t614rdsiL7UMBKKUwEzD4U1hSxt9WrTv8
 56rTfextDIzHHQsrDUdvbTLQ+m5p+3vE=
X-Google-Smtp-Source: AGHT+IE7ElCsB+rMoeWTxC2zU0vJEXQRImybFmMySRC7xN4p1t+ZZ11qafNef5UfwjOJXGMPrN1YyA==
X-Received: by 2002:a05:6602:4088:b0:85b:482b:8530 with SMTP id
 ca18e2360f4ac-8669fb09e0dmr33449639f.2.1746124594717; 
 Thu, 01 May 2025 11:36:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882eaed79sm306695173.18.2025.05.01.11.36.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:36:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 00/16] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC machines
Date: Thu,  1 May 2025 20:36:12 +0200
Message-ID: <20250501183628.87479-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2d.google.com
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

(repost since v1 was incomplete)

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.6 and 2.7 machines removal,
as it is a big enough number of LoC removed. Rest will
follow.

Based-on: <20250429140825.25964-1-philmd@linaro.org>

Philippe Mathieu-Daudé (16):
  hw/i386/pc: Remove deprecated pc-q35-2.6 and pc-i440fx-2.6 machines
  hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug field
  hw/i386/x86: Remove X86MachineClass::fwcfg_dma_enabled field
  hw/i386/pc: Remove pc_compat_2_6[] array
  hw/intc/apic: Remove APICCommonState::legacy_instance_id field
  hw/core/machine: Remove hw_compat_2_6[] array
  hw/virtio/virtio-mmio: Remove
    VirtIOMMIOProxy::format_transport_address field
  hw/i386/pc: Remove deprecated pc-q35-2.7 and pc-i440fx-2.7 machines
  hw/i386/pc: Remove pc_compat_2_7[] array
  hw/audio/pcspk: Remove PCSpkState::migrate field
  hw/core/machine: Remove hw_compat_2_7[] array
  hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim field
  hw/intc/ioapic: Remove IOAPICCommonState::version field
  hw/virtio/virtio-pci: Remove VirtIOPCIProxy::ignore_backend_features
    field
  hw/char/virtio-serial: Do not expose the 'emergency-write' property
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_PAGE_PER_VQ definition

 hw/intc/ioapic_internal.h       |   3 +-
 include/hw/acpi/cpu_hotplug.h   |   3 -
 include/hw/boards.h             |   6 -
 include/hw/i386/apic_internal.h |   1 -
 include/hw/i386/intel_iommu.h   |   1 -
 include/hw/i386/pc.h            |   9 --
 include/hw/i386/x86.h           |   2 -
 include/hw/virtio/virtio-mmio.h |   1 -
 include/hw/virtio/virtio-pci.h  |   2 -
 hw/acpi/cpu_hotplug.c           | 230 --------------------------------
 hw/audio/pcspk.c                |  10 --
 hw/char/virtio-serial-bus.c     |  10 +-
 hw/core/machine.c               |  17 ---
 hw/display/virtio-vga.c         |  10 --
 hw/i386/acpi-build.c            |   4 +-
 hw/i386/intel_iommu.c           |   5 +-
 hw/i386/microvm.c               |   3 -
 hw/i386/multiboot.c             |   7 +-
 hw/i386/pc.c                    |  18 ---
 hw/i386/pc_piix.c               |  23 ----
 hw/i386/pc_q35.c                |  24 ----
 hw/i386/x86-common.c            |   3 +-
 hw/i386/x86.c                   |   2 -
 hw/intc/apic_common.c           |   5 -
 hw/intc/ioapic.c                |  18 +--
 hw/intc/ioapic_common.c         |   2 +-
 hw/virtio/virtio-mmio.c         |  15 ---
 hw/virtio/virtio-pci.c          |  12 +-
 28 files changed, 19 insertions(+), 427 deletions(-)

-- 
2.47.1


