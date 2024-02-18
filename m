Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C32C48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZEC-0001HR-55; Sat, 17 Feb 2024 23:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEA-0001H3-1P
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:34 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZE6-0003yf-CC
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:33 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e457fab0e2so46461b3a.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232188; x=1708836988;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W/c+igS85k+pwLGqDf3MUC16NxpvSAHmdOizE67MdE0=;
 b=KSzClR0LLpBcEQC8xQUmXloKaIGZwjFOxCB2RSt6g2lRNmWoPeDXJSXGsFpeIRgdQh
 iIkkug9WVW4ePaBYxlkKNxMHhQMLH8ZEUfFrU6W7bvw18qv9RW7COzHutk0LEl9w0R2m
 UV5TN+mTRdnB9Zg2oeGfn1eD6GdcVLcHYs+Kd4y0sd0BNOwrxplvFg/0IQndfxk7Z4Wf
 2mAim1vWbCiK1FiL9HaaHi35HaXHWdtGmoSeTUswlKhankpSD2rBh+HgmaV5pgvuuUbG
 ZLr8DlKb8qSHnWjHmKjWU+4HVW9Iy3h7HBF795BUzNYQlK62WiDVavgU32JmQUgcGyeS
 AmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232188; x=1708836988;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W/c+igS85k+pwLGqDf3MUC16NxpvSAHmdOizE67MdE0=;
 b=qFAakdwYL1/s9LAcKnaLrdROEdQyAmrRBF8VSVYe+YCv2ulU8u36nHH33oa39efT9C
 J8y8QkWN8L/CimwiAoTwMi9vaV+0rmIZGglFE7G4ITykC9UCyZM398fO5wSKFVa0YEvq
 gFKVjl3c3Fuer4spG/3j/mIkL/mGWCf2ZJaOv1PA087DPH4Qsa3Dh2JgkYIpVt5tUcS2
 L09hl9lcT7P/MpT8r5ZMJasQ0u378O0qcqNPgc/SzV1r/1yAAOD9/uZAaIuJW5Dj1O5O
 EDT7XO1OQW3+G2FInFUtFnIBJEKS6Gub9/Ozd8D7lQyTxLBX9+OVrvupKP1VjegtmZpG
 rrQg==
X-Gm-Message-State: AOJu0Yy3MYVQhqF1YWXNVm4VbqrV+fUAIiKT2Qw/4549POe+LYBRDy8t
 Hoooz6ZcXBjuCq5MyzhTBmCLhEPHdBLBQPhDhdc91GDyqc1c60J3MbJZCDNWigQ=
X-Google-Smtp-Source: AGHT+IHJp8xMAn+l++MGTVWo28D/fuxqN/Je/1CUaEDS5m2Lbv9CPWH+1RBoQEuR95P3ENnKp/MsKA==
X-Received: by 2002:a05:6a20:93a2:b0:19e:5dda:6bd with SMTP id
 x34-20020a056a2093a200b0019e5dda06bdmr14199098pzh.8.1708232187630; 
 Sat, 17 Feb 2024 20:56:27 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 c18-20020aa78812000000b006e1464e71f9sm198209pfo.47.2024.02.17.20.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:56:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 00/11] hw/pci: SR-IOV related fixes and improvements
Date: Sun, 18 Feb 2024 13:56:05 +0900
Message-Id: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOaN0WUC/2XMTQ6CMBCG4auYrq2ZTstPXXkP46KUQboQTKsEQ
 ri7BSXBsPwm87wjC+QdBXY+jMxT54JrmziS44HZ2jR34q6MmyGgAoGae3oH4pUxhFgIoaVi8ff
 pqXL90rne4q5deLV+WLKdmK/fAoL8FTrBgScF5TaxlEqZX0ozNK4/2fbB5kSHGyZgZRgZqsKgS
 QBTjTsmtwxXJiPLQWRFmmtLWbVjasvUytTMtClBSwNZpf7YNE0f/6D1+EABAAA=
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I submitted a RFC series[1] to add support for SR-IOV emulation to
virtio-net-pci. During the development of the series, I fixed some
trivial bugs and made improvements that I think are independently
useful. This series extracts those fixes and improvements from the RFC
series.

[1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v5:
- Added patch "hw/pci: Always call pcie_sriov_pf_reset()".
- Added patch "pcie_sriov: Reset SR-IOV extended capability".
- Removed a reference to PCI_SRIOV_CTRL_VFE in hw/nvme.
  (Michael S. Tsirkin)
- Noted the impact on the guest of patch "pcie_sriov: Do not reset
  NumVFs after unregistering VFs". (Michael S. Tsirkin)
- Changed to use pcie_sriov_num_vfs().
- Restored pci_set_power() and changed it to call pci_set_enabled() only
  for PFs with an expalanation. (Michael S. Tsirkin)
- Reordered patches.
- Link to v4: https://lore.kernel.org/r/20240214-reuse-v4-0-89ad093a07f4@daynix.com

Changes in v4:
- Reverted the change to pci_rom_bar_explicitly_enabled().
  (Michael S. Tsirkin)
- Added patch "pcie_sriov: Do not reset NumVFs after unregistering VFs".
- Added patch "hw/nvme: Refer to dev->exp.sriov_pf.num_vfs".
- Link to v3: https://lore.kernel.org/r/20240212-reuse-v3-0-8017b689ce7f@daynix.com

Changes in v3:
- Extracted patch "hw/pci: Use -1 as a default value for rombar" from
  patch "hw/pci: Determine if rombar is explicitly enabled"
  (Philippe Mathieu-Daudé)
- Added an audit result of PCIDevice::rom_bar to the message of patch
  "hw/pci: Use -1 as a default value for rombar"
  (Philippe Mathieu-Daudé)
- Link to v2: https://lore.kernel.org/r/20240210-reuse-v2-0-24ba2a502692@daynix.com

Changes in v2:
- Reset after enabling a function so that NVMe VF state gets updated.
- Link to v1: https://lore.kernel.org/r/20240203-reuse-v1-0-5be8c5ce6338@daynix.com

---
Akihiko Odaki (11):
      hw/nvme: Use pcie_sriov_num_vfs()
      pcie_sriov: Validate NumVFs
      hw/pci: Use -1 as a default value for rombar
      hw/pci: Determine if rombar is explicitly enabled
      vfio: Avoid inspecting option QDict for rombar
      hw/qdev: Remove opts member
      pcie_sriov: Reset SR-IOV extended capability
      pcie_sriov: Do not reset NumVFs after disabling VFs
      hw/pci: Always call pcie_sriov_pf_reset()
      hw/pci: Rename has_power to enabled
      pcie_sriov: Reuse SR-IOV VF device instances

 docs/pcie_sriov.txt         |   8 ++-
 include/hw/pci/pci.h        |   2 +-
 include/hw/pci/pci_device.h |  22 ++++++-
 include/hw/pci/pcie_sriov.h |  10 ++--
 include/hw/qdev-core.h      |   4 --
 hw/core/qdev.c              |   1 -
 hw/net/igb.c                |  15 +++--
 hw/nvme/ctrl.c              |  54 ++++++++---------
 hw/pci/pci.c                |  17 +++---
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie_sriov.c         | 142 ++++++++++++++++++++++----------------------
 hw/vfio/pci.c               |   3 +-
 system/qdev-monitor.c       |  12 ++--
 13 files changed, 157 insertions(+), 137 deletions(-)
---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


