Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B57AE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 19:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKMmu-0005Kb-Cl; Sun, 08 Dec 2024 14:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmn-0005JE-6p
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:45 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmj-0001Vl-R6
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:44 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso638171166b.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 11:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733685457; x=1734290257;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6alYAl+5PavmhKtWab9UBk7WbQqjrTnT3d6S0WNKJw0=;
 b=nqqTd5Py+4oGSfJHxZWvFUaZYByVJK9rt3BLxPNkG/GfAY+nfBMo1V0gk6yPvqLpGn
 MnKvOJpOM2wg+I379qDeCvrIA+4CXxmJUWlMyTYUbw1rPygojwT11lyvUhOfxRe+5/ue
 UysPRM+ok35z0XiDTppY6903hmGJT1xnIvWMeoYEKZiqgb7fvj+yypXIAv1OjcNciDZC
 bSwsDJuYLBw6+tARIPXOMy7P9BjkKzMYwqISBAsU3O8U/hC2ebSYGALjgDW2B/lsqCqv
 4kKb5OvcQKOu32Ks5Ji99gizySq4XxRag1HOue7M2uj8lFlT4s+gqWNODCm2LTQSMK+2
 zevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733685457; x=1734290257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6alYAl+5PavmhKtWab9UBk7WbQqjrTnT3d6S0WNKJw0=;
 b=gWpaUijoQsdwck3IIn6BNQxnm5YfTyUCYUPtrawUS/M44MWDQvoU+ZBhMLpAKTvZQm
 aHhn9K0wEQY9H+tsTf3WhB6c52hZV2axq17Zew150hKZtlvqFPrkrN9UuSGJvAThVJtt
 MGJMzfS5vTiQ9BVySloxT4VZhG8taQWUKHPAwGVy9l/Lbirt39R6WyoVRW8mK8hqVnzt
 XwPCdwUymSxGDVvP0CgsYK6pHWnfCZLzE5uSbICQONaT3RzTWp7ex06f4rFVPsf7u2Hq
 0m8+2lEaWAy1f5n1U/s8zKqzrMZfHa/l+MbY2NwM2VUvQmNWiEfc2TqAP2YC13JEEKFv
 qzYA==
X-Gm-Message-State: AOJu0YydggPyPIHYo9eZ+32R8ttSEK+ICIJUTW5XKeIqMp0Tsmrk0+Ra
 UKwbs83rW9R2rrCJNmnBEaygre0cervN9wpyx0CbaiKIQdwMEgTTv8O1qK7d+nvfZrIa37zVT5c
 j/A==
X-Gm-Gg: ASbGncsbu5gtSsKwG4K7OZIFsDnmVp+Gl1L3kNm/XChjgB+WvIZH1gi0/aVAWj5ID77
 yVw+KXSv+duL0+snr7YuRqga4HsEsrbTeSUdcg9jSteJ+A3JtMaSrrb26BT/nhToDDbWvaAxfdt
 C8i0BQY1Me6fithpqzvlYHSAKhhrmTDfnX0AU7g6Bk7ytop00aGzwtIt2TJ7BlRhPtn5AaOfqIO
 LA4t0JO2S8tOhmlEBhunHHNj5bPjm+HQxi3ydnHxrFjVS3UbCTv2EvH87Mqo5phBLrjYwFOKkCh
 InWY//ypaZ+PDTywG7g18F0/pg==
X-Google-Smtp-Source: AGHT+IE81xZv8E4G2O2ZpLjgdINbYJMSzfmDAVzXBwpNLDvsVWVuJW1B/Bx1YVCQfFWHP4ZI6H6Xfg==
X-Received: by 2002:a17:906:328b:b0:aa5:1d08:dad0 with SMTP id
 a640c23a62f3a-aa639fa40f1mr961323466b.1.1733685457370; 
 Sun, 08 Dec 2024 11:17:37 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa665119a06sm240350866b.121.2024.12.08.11.17.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Dec 2024 11:17:36 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 0/6] hw/usb/hcd-xhci: Fixes, improvements, and macOS workaround
Date: Sun,  8 Dec 2024 20:16:40 +0100
Message-Id: <20241208191646.64857-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62f;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

For a while now, I've been chasing the problem of macOS's XHCI guest driver not
working properly with QEMU's PCI XHCI controller when MSI-X is unavailable.
I've finally figured out the cause, and I think an acceptable solution. I've
explained the problem and quoted the relevant sections of the XHCI spec in more
detail in the linked GitLab issue:

https://gitlab.com/qemu-project/qemu/-/issues/2705

Essentially, the macOS driver attempts to use XHCI event rings 1 and 2 even
when there is only a single pin-based interrupt available. The interrupts for
rings 1 and 2 are dropped, and so events are only handled after a timeout.
The driver appears to expect the device to act as if interrupter mapping was
not supported - the spec only mentions that interrupter mapping should be
disabled if only one **interrupter** is enabled, not one **interrupt**,
although there is some ambiguity in the spec's wording around enabling and
disabling interrupters.

After feedback to my initial RFC submission and discovering some more unhandled
edge cases, I've now split this up into 6 different patches.

Ultimately, for macOS to be able to drive the XHCI controller with MSI-X
disabled, we need to disable interrupter mapping (in the sense of XHCI spec
section 4.17.1) when using a pin-based interrupt or MSI with only 1 vector
active.

 1. Fixes an assertion failure crash when XHCI attempts to raise an interrupt
    on a MSI vector higher than the maximum allocated. It's not a smart thing
    for a guest to do, scheduling events on interrupter 2 when it's only
    configured a single MSI vector, but we also don't want to crash in this
    case.
 2. Moves the msi/msix toggles from the NEC XHCI controller to the generic
    hci-xhci-pci superclass for consistency. This makes testing with MSI-X
    and/or MSI disabled easier when using the qemu-xhci device variant.
 3. Implements interrupter mapping disabling as per XHCI spec, when numintrs==1.
 4. Add a new boolean property to hcd-xhci-pci, "conditional-intr-mapping",
    which defaults to false, retaining existing behaviour. When set to true,
    additional constraints for enabling interrupter mapping are enabled,
    so it is disabled in pin-based mode, or with MSI and only 1 vector. This
    works around the macOS guest driver quirks.
 5. Trivial code formatting fix for dodgy indentation I stumbled across in
    hci-xhci-pci.
 6. Enables the "conditional-intr-mapping" property in the VMApple machine
    type, which does not support MSI-X or MSI and has previously suffered
    from the macOS guest driver quirk.

Of course, patch 6 can only be applied once the VMApple patch set is also
merged. Patches 2 and 5 are optional for the purposes of fixing the issue I
set out to fix, but seem sensible enough to include in this series.

You can reproduce the problems being fixed as follows:

 * Assertion failure crash fixed in patch 1: Use a x86-64 VM with macOS guest
   and machine type Q35. For USB, use: -device nec-usb-xhci,msix=off
   QEMU will crash with a failed assertion, "vector < nr_vectors" on guest boot.
 * macOS guest not driving the XHCI controller correctly with pin-based
   interrupts: Either as above but with -device nec-usb-xhci,msix=off,msi=off
   or by following the instructions to boot aarch64 macOS 12 on the VMApple
   machine type.

Review notes:

 * I am not 100% sure whether I need to add any special code to support
   backwards compatibility and migration to support the moved and newly added
   device properties.

History:

RFC -> v1:

 * Gated conditional interrupter mapping support behind a property, enabled
   that property in the VMApple machine type.
 * Added patch to fix the MSI vector assertion failure.
 * Moved msi and msix properties from NEC XHCI controller to generic xhci-pci
   superclass as that also seems useful.
 * Broke the workaround up into 2 patches, one for mapping disabling required
   by the standard, and one for the conditional disabling workaround.

Phil Dennis-Jordan (6):
  hw/usb/hcd-xhci-pci: Don't trigger MSI on higher vector than allocated
  hw/usb/hcd-xhci-pci: Moves msi/msix properties from NEC to superclass
  hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported.
  hw/usb/hcd-xhci-pci: Adds property for disabling mapping in IRQ mode
  hw/usb/hcd-xhci-pci: Indentation fix
  hw/vmapple: XHCI controller's interrupt mapping workaround for macOS

 hw/usb/hcd-xhci-nec.c |  2 --
 hw/usb/hcd-xhci-pci.c | 34 ++++++++++++++++++++++++++++++++--
 hw/usb/hcd-xhci-pci.h |  1 +
 hw/usb/hcd-xhci.c     |  5 +++++
 hw/usb/hcd-xhci.h     |  5 +++++
 hw/vmapple/vmapple.c  |  7 +++++++
 6 files changed, 50 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)


