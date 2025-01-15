Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA6EC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCit-0000C6-8l; Wed, 15 Jan 2025 18:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCir-0000BT-Kh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:22:53 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCip-0003nW-Qt
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:22:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso1499055e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983370; x=1737588170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v1ksYOM0o00abVVAGTGDr7lB/CzuY5HznVZ0izWIqZs=;
 b=bgWsKyWprwKilpkggrVmc3cJwF+vg1BwEk1Xmjg+Z4CtzcbesMoZ3qfOjjFNt2z8Fr
 gr4djez9E5vZW4xzVRIqVL92q3lfr81w2eSCp10qvTkf22xeWZpyQTkmv/XyyQxVGFSB
 9I2sBQyp8alrUi1ACZrVslll7Soe+gDY2wwYXlFRMCYyUIDPfvbIgiA7RJblmZMzETDG
 HjED8pOC/nFTKdev1SN8fko0Lptc1RIbTNgK/sEeFAQUMeVGaun7CK10GI9POtKWaqjI
 /oQrB+byWr0cTPrGKKRpzC2KG+qeLBAO6Z25jCZMQiyge8VcbgwKAW3Zh0fWWnRu7Zzb
 I/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983370; x=1737588170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v1ksYOM0o00abVVAGTGDr7lB/CzuY5HznVZ0izWIqZs=;
 b=Mf0en9bhT7x+sx6MnrjropImuvYbeKFJOB0/7sZO1jyHDiSIaLeKaFEbL2zwWuy1dd
 +BfC6cTdpadERERJQac7oW57Y5YMDe/1b3OHbvButNN0nHEo+oMVT6D9R5S636fTiXBK
 94aaE5yJJroBbpXt2oFY/CjAjyv8+CLHuEZd8DIz8Li66pkfMKzYRTBcwq7ZLduU/6S1
 pESSseC7rAkRS6JdW3qofgxpwc8gOkvx9W98RjHm4WQNXS9l4C1WosLTpa7kPs4rmFEo
 aomQBH+aY9d1hQufNdQHYBT9gZi/6B9gKILr/bNOQN9ZJJbnCyIlt+upOusSqJJ1OxLn
 i9OQ==
X-Gm-Message-State: AOJu0Yyaar1Up0Wp7Ufi02cIp6gG0cC1q736MsYr3+IizC7A6xeZRgyJ
 YSAnoQacXRmxD5q4QdX7TOKXIsICuNYN2urxCl+lBxq2fwf77VUwlLetctt5U5jQ5IJh5qNhqFW
 XPsg=
X-Gm-Gg: ASbGncv3qb1wihWI4cG3nZw6tjK4rSubPf1kXM5amzv9AU/drvoqG/Zow9jyPwm3yc2
 VNTeLvi06f6hx8mU0dp31p2+iRlaMJ3la+3uqdkfvZYRseWq/aA5OXM4q/5Bv7evRCGkVTIttTT
 94n7TYo9nJMNo20drY+RcpduwlkniWZodf17ObK5xw/E7Dz1Ffc30bF6F1SpB4yIInDmQz4TuIb
 NVT4WQQgCF5cSlJrVAP2PNgFFdqAfrd5NHk68T3FWkD27w0D0OZl3TahChDaNmjI2F6a39Z75G2
 SZXePPD0U2q765qJH2YAN36AACVMAt4=
X-Google-Smtp-Source: AGHT+IHT129G4fGxNCf1AMZdn85+6KHjetTbYExn40sz/eGQYUBhLWdZdN4+0JxI/MLzrXcfodZagg==
X-Received: by 2002:a05:600c:1c14:b0:436:1ac2:1ad2 with SMTP id
 5b1f17b1804b1-436e26c0400mr248555525e9.19.1736983369774; 
 Wed, 15 Jan 2025 15:22:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7525ee9sm38108385e9.32.2025.01.15.15.22.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:22:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 00/21] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC machines
Date: Thu, 16 Jan 2025 00:22:26 +0100
Message-ID: <20250115232247.30364-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.4 and 2.5 machines removal,
as it is a big enough number of LoC removed. Rest will
follow. Highlight is the legacy fw_cfg API removal :)

Philippe Mathieu-Daudé (21):
  hw/i386/pc: Remove unused pc_compat_2_3 declarations
  hw/i386/pc: Remove deprecated pc-q35-2.4 and pc-i440fx-2.4 machines
  hw/i386/pc: Remove PCMachineClass::broken_reserved_end field
  hw/i386/pc: Remove pc_compat_2_4[] array
  target/i386/cpu: Remove X86CPU::check_cpuid field
  target/i386/cpu: Pass Error** to x86_cpu_filter_features()
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

 docs/about/removed-features.rst |   4 ++
 include/hw/boards.h             |   9 +--
 include/hw/i386/pc.h            |  10 ---
 include/hw/i386/x86.h           |   5 --
 include/hw/loader.h             |   2 -
 include/hw/nvram/fw_cfg.h       |  10 ---
 include/hw/virtio/virtio-pci.h  |   8 ---
 target/i386/cpu.h               |   1 -
 hw/block/fdc-isa.c              |   4 +-
 hw/core/loader.c                |  14 ----
 hw/core/machine.c               |  18 ------
 hw/i386/pc.c                    |  42 ++----------
 hw/i386/pc_piix.c               |  26 --------
 hw/i386/pc_q35.c                |  26 --------
 hw/i386/x86.c                   |   1 -
 hw/net/e1000.c                  |  63 ++++--------------
 hw/net/vmxnet3.c                |  44 ++-----------
 hw/nvram/fw_cfg.c               | 109 ++------------------------------
 hw/scsi/vmw_pvscsi.c            |  67 ++++----------------
 hw/virtio/virtio-pci.c          |  15 +----
 system/vl.c                     |   5 --
 target/i386/cpu.c               |  27 +++-----
 target/i386/machine.c           |   5 +-
 23 files changed, 61 insertions(+), 454 deletions(-)

-- 
2.47.1


