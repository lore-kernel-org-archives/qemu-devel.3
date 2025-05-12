Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E0CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOhw-00075a-GV; Mon, 12 May 2025 04:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOhb-0006mb-Kv
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOhZ-0001SM-MZ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:39:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso41866935e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039196; x=1747643996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HjSoGSSbFobZSLTYgmxXMnObil41G1NXuE4ls0ioHJ4=;
 b=zZK2SLPWBlq7bwD1LsgzJqWBIWbGFo1AjsS+Mqtfzu+u81tRzCDbMgRce+7UjdVx4E
 fpUv/4rZKHDsfLhBpiwG21mLGsItN3r5xzagwUOeg6sRlrlCnCS6hKto9DCUpUeUm7um
 +2zpIrunhYHjbpLtD58FTli2TQkpzSnhkV9ISO0wQT338lnjb1j/tK/5d8/pWB7HdvGf
 9Nq68ND6hVC2su2LpYkg80B5hLBvUt+uUVJsWIpIAT/UguRGSGqbBdetLplP+figTH9I
 EVek6F/y1WKZD3EcItOWfAX5VUh5fkbYeApux3I90gAGnFkCGg1ml00HjBU25AOuNl/9
 Jfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039196; x=1747643996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HjSoGSSbFobZSLTYgmxXMnObil41G1NXuE4ls0ioHJ4=;
 b=MuU7iFGRKIIIFmPZKi/rzRWbAm6nwSwjMBzeZgzM4SCxrIkXlgMU1tlhNQx4Cch+uL
 y58gYQiwvOXiuGfTDyvAFpkoX7sNg2P4wIGKajK89pl3gDyKdNQVlURFn7GzBcj30ptw
 rweuFPDhpWkNl/AxrulH4CKfzvGnr0Yq87f4O88SOcgD9ZLYyG6kmx5m1383Sfn4GqoL
 5ZYP27/B+pNXMj/jjpmI70O8hqx3kPaPC5h4sIfNOyciF80UthnPAkuI1KCj9eB/z/pb
 Ld251cZyTzn2fLbv2yq47pUMFt20l0snqJOBYlR51Q0PtcNacKyxJ6yA3NuI7rvyCHL8
 ZHgA==
X-Gm-Message-State: AOJu0YzbWlf69Xp6fswrV1siUTgJ2dAiP39cNZZGWSoZTXKhrSrWJtBr
 3cfLcwIbJ7jkqSJR1Q1jpQq8ckOO1vsDV2PyupvSpj7dgUcIIHP27eKIq6lMekKRlG+11J3Qo9o
 kWy34/g==
X-Gm-Gg: ASbGncs3XBaPpu8Y+yZe074Zx0gGc0eIj0pj3MSQtnRfHQT3VGAjm9cOG+nxh8BA67p
 MK2kcdtikDX3sy0MG9QgZwLBdGHgwVwaVjI4wszjIfnUhIfKXJlSDMeFkpc/kI/P6TztRLZgRTk
 Z5tpVgq0YaL8nzJPN988kjRKoH0XqOqwDNufDvVJIupftwdUinsoSIpJEKJ/+evERYXbNS2ivRq
 OAPhj9MKuyta24zW81cu1gCKT1xjVVEBG12gOdlZppnTF5BsCliQduDlq6zD9geDaoesOPAn6kr
 gUYiS0BQzqSnrZRPO8xYQzkbzOXp8Xe16L0IBgd0zLIUtBuZaNGryoqpULvgfE5eN6ei0w9IRuH
 f2CoACyrK3wA5rJhg6B0wl0M=
X-Google-Smtp-Source: AGHT+IGInDcmo/+tFMBCLt+PfTTtUbl02PnU8fPlG8jd+C8vEryCKB3Z+OJSG1HA6VSXKJ/1TSGNrA==
X-Received: by 2002:a05:600c:8707:b0:43c:fd72:f039 with SMTP id
 5b1f17b1804b1-442d6d3e13bmr94934605e9.11.1747039195615; 
 Mon, 12 May 2025 01:39:55 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67d5c7bsm118774305e9.4.2025.05.12.01.39.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:39:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC machines
Date: Mon, 12 May 2025 10:39:29 +0200
Message-ID: <20250512083948.39294-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

(series reviewed)

Since v3:
- Fixed 2 issues noticed by Thomas (floppy fallback, e1000)

Since v2:
- Removed qtest in test-x86-cpuid-compat.c

Since v1:
- Fixed issues noticed by Thomas

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.4 and 2.5 machines removal,
as it is a big enough number of LoC removed. Rest will
follow. Highlight is the legacy fw_cfg API removal :)

Philippe Mathieu-Daudé (19):
  hw/i386/pc: Remove deprecated pc-q35-2.4 and pc-i440fx-2.4 machines
  hw/i386/pc: Remove PCMachineClass::broken_reserved_end field
  hw/i386/pc: Remove pc_compat_2_4[] array
  target/i386/cpu: Remove X86CPU::check_cpuid field
  hw/core/machine: Remove hw_compat_2_4[] array
  hw/net/e1000: Remove unused E1000_FLAG_MAC flag
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_DISABLE_PCIE definition
  hw/i386/pc: Remove deprecated pc-q35-2.5 and pc-i440fx-2.5 machines
  hw/i386/x86: Remove X86MachineClass::save_tsc_khz field
  hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
  hw/core/machine: Remove hw_compat_2_5[] array
  hw/block/fdc-isa: Remove 'fallback' property
  hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_OLD_PCI_CONFIGURATION
    definition
  hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
  hw/scsi/vmw_pvscsi: Convert DeviceRealize -> InstanceInit
  hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
  hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
  hw/net/vmxnet3: Merge DeviceRealize in InstanceInit

 include/hw/boards.h                 |   9 +--
 include/hw/i386/pc.h                |   7 --
 include/hw/i386/x86.h               |   5 --
 include/hw/loader.h                 |   2 -
 include/hw/nvram/fw_cfg.h           |  10 ---
 include/hw/virtio/virtio-pci.h      |   8 --
 target/i386/cpu.h                   |   1 -
 hw/block/fdc-isa.c                  |   4 +-
 hw/core/loader.c                    |  14 ----
 hw/core/machine.c                   |  18 -----
 hw/i386/pc.c                        |  42 ++---------
 hw/i386/pc_piix.c                   |  26 -------
 hw/i386/pc_q35.c                    |  26 -------
 hw/i386/x86.c                       |   1 -
 hw/net/e1000.c                      |  93 ++++++++++--------------
 hw/net/vmxnet3.c                    |  44 ++---------
 hw/nvram/fw_cfg.c                   | 109 ++--------------------------
 hw/scsi/vmw_pvscsi.c                |  67 +++--------------
 hw/virtio/virtio-pci.c              |  11 +--
 system/vl.c                         |   5 --
 target/i386/cpu.c                   |   3 +-
 target/i386/machine.c               |   5 +-
 tests/qtest/test-x86-cpuid-compat.c |  14 ----
 23 files changed, 77 insertions(+), 447 deletions(-)

-- 
2.47.1


