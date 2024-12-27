Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B24E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 12:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR9EV-0002zL-Sy; Fri, 27 Dec 2024 07:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9E9-0002v3-AV
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:14:04 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9Dz-0005FS-P2
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:13:55 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so1163405366b.1
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 04:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735301624; x=1735906424;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tzaam/nGV/lsyhD2IkbRADjyZNYlfrfs4BxSJyTg/mY=;
 b=fdVoEpyVAIP0MHEzsUJyKDLbAyMqQNghTFIdhV+btJsqlnmhnCSreZJdJ7A2+KIrUI
 U+N567ZQkUjgwnsCGzU5c+w+x5rwoWWl/8k677gyQaiq0ZBCjPpBL7B6tRhVipQ+xC5R
 Jr4duBAvB1FHSJPT4Z7YH0qx9dInjktU5JMd9necxWdp/Yh/IhXz2wOjWuM1Zxi51qbC
 HjeVtwgT3kOP8DdZO0CtBaAiCt60Qu1LO1R0uDcWYNt7SCUpAz982UBNZUd26xfVshmW
 JgKdwg87u8RAPYmcQh8IgQp51I+jQry7L28BTxt75B0HpQ6zezW9cOSP7j3lQ8usouG9
 wHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735301624; x=1735906424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tzaam/nGV/lsyhD2IkbRADjyZNYlfrfs4BxSJyTg/mY=;
 b=cDsvxSfLPy/3gBqzhgxzDJINhQ+qBTuYCFn7i9lESrYJKK7hYSfJlLytAzvaeKGm/7
 NL6wPhlX187TNZF0jwSXBu2UvBb6rYekJdap2ezHXdwQHt14xAOxd0IMglzYrVsoZuvo
 0tClf2Dj0yoKSrvPt3yDjGkfIb/lUOsC9Okx9foMa3Gpq8O4XN1kreNBdI2ad0BNgPGL
 x3vRVSeg12Yo4oTHyed91QDkR64FXpb9JmfBFAAYfJeh4qqPCvilF25mqKo5IYhqnwtO
 n7Z2LM+1ZzjbUIoeY4ky0TuY2vRd15gawih235YdVtM3tCwpzYs/2p9FvalwvtFeH7U1
 eF+Q==
X-Gm-Message-State: AOJu0YycuWE2RlMeQgIdPo/5idoE1G2eHv8Xsbh9bfMafL1DWHGjiFir
 NRLXCKuRr1sHU6xObVP2OTzEc98yJZ446z/apT2RMsFK88piCG6pZRO+5TuzhJw0FnmiuuMiQDA
 =
X-Gm-Gg: ASbGncssH8QiihC/FZFyariN+8ILyib/a6RyU6B/gUAyt9JpSHL3hb5oQo3O8AGwYTS
 6GDhU+0i5T+z/pChkO/IPV1/YpUGkuZWJfoWFY58ayOiMPaNsQR6+0qLGcEPf3lZKa9LKNwn86+
 SWS1AMrnkQ+QiMT2vLEJdj8rsknHzmrkKaVzQyI5r1+OJSV3h58VuS8KjHy57B9RYzhejsyr7OC
 QUiRi61SawhY6eZDYPVMnf9opwCRP2dArtX/JSSMomjlUsidSJvZxhRRM/2UIJURyC5mzWvx43N
 8HTJpzIFOsgX3AjgGYC/SepZiVFcEkdT
X-Google-Smtp-Source: AGHT+IF3w2JggRZgD0FbZLPCmGRUT5l4cYHujePTS0TXQQVccL+57i6Mms/qF89RkEgitHZMC/QFpw==
X-Received: by 2002:a17:907:d09:b0:aab:73c5:837 with SMTP id
 a640c23a62f3a-aac3366a0ccmr2122677666b.52.1735301624178; 
 Fri, 27 Dec 2024 04:13:44 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82ede9sm1098662766b.2.2024.12.27.04.13.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Dec 2024 04:13:43 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 npiggin@gmail.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 0/6] hw/usb/hcd-xhci: Fixes, improvements,
 and macOS workaround
Date: Fri, 27 Dec 2024 13:13:30 +0100
Message-Id: <20241227121336.25838-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::629;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x629.google.com
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

Ultimately, for macOS to be able to drive the XHCI controller with MSI(-X)
disabled, we need to disable interrupter mapping (in the sense of XHCI spec
section 4.17.1) when using a pin-based interrupt.

 1. Fixes an assertion failure crash when XHCI attempts to raise an interrupt
    on a MSI vector higher than the maximum allocated. It turns out the
    spec says the MSI vector needs to be computed from the interrupter
    number by modulo arithmetic, so this patch implements that behaviour.
 2. Moves the msi/msix toggles from the NEC XHCI controller to the generic
    hci-xhci-pci superclass for consistency. This makes testing with MSI-X
    and/or MSI disabled easier when using the qemu-xhci device variant.
 3. Implements interrupter mapping disabling as per XHCI spec, when numintrs==1.
 4. Switches from tracing to LOG_UNIMP and LOG_GUEST_ERROR for certain
    cases of unhandled MMIO. (This is not comprehensive, but came up in
    review of one of Nicholas Piggin's XHCI patch sets.)
 5. Add a new boolean property to hcd-xhci-pci, "conditional-intr-mapping",
    which defaults to false, retaining existing behaviour. When set to true,
    additional constraints for enabling interrupter mapping are enabled,
    so it is disabled in pin-based mode. This works around the macOS guest
    driver quirks.
 6. Enables the "conditional-intr-mapping" property in the VMApple machine
    type, which does not support MSI-X or MSI and has previously suffered
    from the macOS guest driver quirk.

Of course, patch 6 can only be applied once the VMApple patch set is also
applied: https://patchew.org/QEMU/20241223221645.29911-1-phil@philjordan.eu/

Patches 2 and 4 are optional for the purposes of fixing the issue I
set out to fix, but seem sensible enough to include in this series.

You can reproduce the problems being fixed as follows:

 * Assertion failure crash fixed in patch 1: Use a x86-64 VM with macOS guest
   and machine type Q35. For USB, use: -device nec-usb-xhci,msix=off
   QEMU will crash with a failed assertion, "vector < nr_vectors" on guest boot.
 * macOS guest not driving the XHCI controller correctly with pin-based
   interrupts: Either as above but with -device nec-usb-xhci,msix=off,msi=off
   or by following the instructions to boot aarch64 macOS 12 on the VMApple
   machine type.

History:

RFC -> v1:

 * Gated conditional interrupter mapping support behind a property, enabled
   that property in the VMApple machine type.
 * Added patch to fix the MSI vector assertion failure.
 * Moved msi and msix properties from NEC XHCI controller to generic xhci-pci
   superclass as that also seems useful.
 * Broke the workaround up into 2 patches, one for mapping disabling required
   by the standard, and one for the conditional disabling workaround.

v1 -> v2:

 * 1/6: Switch to modulo arithmetic for MSI vector number, as per spec.
 * 6/6: Set the "conditional-intr-mapping" property via compat_props.
 * Commit message tweaks

v2 -> v3:

 * 2/6: In line with recent upstream changes, the property table is now
   const and no longer carries an end-of-list marker.
 * The indentation fix (previously 5/6) has already been merged, so is no
   longer included.
 * Added patch fixing up logging of certain unhandled MMIO cases. (4/6)
 * 6/6: Moved the compat global property table into vmapple patch set -v16;
   we now just add the conditional-intr-mapping property to it in this
   patch. We also set the property on any device implementing the abstract
   TYPE_XHCI_PCI rather than only the TYPE_QEMU_XHCI device specifically.

Phil Dennis-Jordan (6):
  hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
  hw/usb/hcd-xhci-pci: Move msi/msix properties from NEC to superclass
  hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported
  hw/usb/hcd-xhci: Unimplemented/guest error logging for port MMIO
  hw/usb/hcd-xhci-pci: Adds property for disabling mapping in IRQ mode
  hw/vmapple: XHCI controller's interrupt mapping workaround for macOS

 hw/usb/hcd-xhci-nec.c |  2 --
 hw/usb/hcd-xhci-pci.c | 31 +++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-pci.h |  1 +
 hw/usb/hcd-xhci.c     | 30 +++++++++++++++++++++++++++---
 hw/usb/hcd-xhci.h     |  5 +++++
 hw/vmapple/vmapple.c  |  8 +++++++-
 6 files changed, 71 insertions(+), 6 deletions(-)

-- 
2.39.5 (Apple Git-154)


