Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1902A10D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B8d-00038A-Ao; Mon, 30 Mar 2026 07:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8Y-0002yk-D1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8W-0005ux-B8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCS3jb8S1yuHlO3cPPXyP/0uPMB67ud4t/A4TbJfwUU=;
 b=Z52aiebZaY5ehrVyZeNxdKK67RU8Z/u9jXkhz06UY5bDEbUbmywiQ1q9O7pa/+Rw+vtCHP
 A1YdHEHMnKRh+0CXSig70ur0c84iTaFRBUZsKHA3GctTXqcKJ1EIYO+BhsAZoBFxqGozgZ
 nPbSgdP4S6OAHT7iuW5gMsj5WaO9m14=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Fc4Ne78WO0WU85WmykTATw-1; Mon, 30 Mar 2026 07:50:26 -0400
X-MC-Unique: Fc4Ne78WO0WU85WmykTATw-1
X-Mimecast-MFC-AGG-ID: Fc4Ne78WO0WU85WmykTATw_1774871425
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d03db814eso369756f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871424; x=1775476224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCS3jb8S1yuHlO3cPPXyP/0uPMB67ud4t/A4TbJfwUU=;
 b=sZy/aREsO+72j/HNsaEXVScpL+ZQdEUDDOX2YiaDamRnZju81BuhLHpno0jdkd/xjm
 IM4lzTHvXCBvEBx0zqN0dzSyIPaEFjpc4yw7E+wfSLx9XYtvazZvx/Tx2HVwkWTiDWzI
 tRz4/pNKP9oYapbJAcx/vSXO3RnOsXD0kE7FBnpAInDBoz2sB00NN/NqfPgFmIHYA8zQ
 ooVxeNVKbzHri16hK471n1K5LCqksXVT9luHND522vJ4qMrmAX81lU8NE6vHH2ii81Hp
 VlwABlCSQtZUy1bRPzFW0GWXuyyQD+KGyLr1DcU4S/Apo1CxdouqVZxRC5Yh7f/zAsD/
 DMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871424; x=1775476224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCS3jb8S1yuHlO3cPPXyP/0uPMB67ud4t/A4TbJfwUU=;
 b=X/nMX3TUA1HXdjsrnBzNOEINk0Da9BcL4lhdX4NoKcdokeK/eODScGAPDrXZEMJwSJ
 qXAH9WNQ7+Ve+6tdEGSxqp56txOtsfZG46Nyhkp6/znn/Zq+6Y2azQwUFx9Vag4iYz9/
 DTAQbkqCzfBGHo+c67PqtvbVLK+mw61ZGnWp6qwikCt2Q4yMvjkgvxhAo3oHtgBWiHqj
 UBP4VyY3X61CbKmykGB3ng5TImExOQYEZWbvzwTtxH0Q7xPKsfJJ5ppyhs2ULth+MHXD
 uWMA5Duh6nC0t+mrGRlGndJM7ZyBBTdvsvuZVv9LOrongENmHG7pcsg/2cOmLFADDYy4
 22sg==
X-Gm-Message-State: AOJu0Ywx6U1utd1hyo2mxKOsF9o8o9LhKcGuMjelQ8nl605GwJCnPfzx
 Y9FdtcR5UijUQKfRJ4KV2sURo9Vaq52mlwKA4qOOkDkIlOgwPtaXmBTlrknBefcmz2kUrD8SsPQ
 jJTAO7XEFSXDAqo7ij8Ity+q/fsjmb8RIRLkCHXCOkydxgJShkCz7FUvn9lOMmcICx1Ucn84wB+
 TJT6p2+eah8CX7/DEsde1W7Gy4ha7BED8OofCTbvun
X-Gm-Gg: ATEYQzxOwt1zGDeH0fEDTIpnX3hjcb8aQThtcgpNnz8bbkWxJa3hBJlClyDKZyVKJJF
 1Eerb+aAywNUG+NAIgFgtGzr3D9D1fOPktFJX33AUB52f+vqATKu6SuzyxK5KlH+3EOvcyaHalA
 uLr96LpEotuQ0Zpn1hWMzWrGpUSLS/VsfHWS/zcfb1U3hKfuCq6mI/wCHHdzYbxQyvFya3iWjhy
 lsqn3GsHLqJJfO2lpQcEPepaAn7gikSGaywWqSW4A9JG88CDli921f+hfci70xwQzUuB5RUAvv1
 Ys1Hxcg1J4AKtPUylXqF1rVSYCLjmysv/JvQMVhbZbA99BvIEZXetIx7pQufM+syTqY4IHAIqUr
 +w1GHjoKXEybdaTaGfsCLsHJTSvBMBSbGqpeF/lNcDj/WBTc2+e8rOyhDD12FG6UX3i0JK0TBvd
 ZaHFmbqKhDh+vuund7pGOY5zBe
X-Received: by 2002:a05:6000:430a:b0:43b:5022:804 with SMTP id
 ffacd0b85a97d-43b9e9ee7a9mr20493851f8f.29.1774871423763; 
 Mon, 30 Mar 2026 04:50:23 -0700 (PDT)
X-Received: by 2002:a05:6000:430a:b0:43b:5022:804 with SMTP id
 ffacd0b85a97d-43b9e9ee7a9mr20493760f8f.29.1774871423105; 
 Mon, 30 Mar 2026 04:50:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245f8a3sm19823302f8f.24.2026.03.30.04.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 02/12] docs: add WHPX section with initial info
Date: Mon, 30 Mar 2026 13:50:06 +0200
Message-ID: <20260330115017.256211-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260327011152.4126-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS           |   1 +
 docs/system/index.rst |   1 +
 docs/system/whpx.rst  | 144 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 docs/system/whpx.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index cd8ba144506..eb7132e39d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -582,6 +582,7 @@ F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
 F: include/system/whpx-common.h
 F: include/system/whpx-internal.h
+F: docs/system/whpx.rst
 
 MSHV
 M: Magnus Kulke <magnuskulke@linux.microsoft.com>
diff --git a/docs/system/index.rst b/docs/system/index.rst
index bb948e2993c..4509630fa46 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -40,6 +40,7 @@ or Hypervisor.Framework.
    confidential-guest-support
    igvm
    nitro
+   whpx
    vm-templating
    sriov
    qemu-colo
diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
new file mode 100644
index 00000000000..3e1979028c9
--- /dev/null
+++ b/docs/system/whpx.rst
@@ -0,0 +1,144 @@
+Windows Hypervisor Platform
+===========================
+
+Windows Hypervisor Platform is the Windows API for use of
+third-party virtual machine monitors with hardware acceleration
+on Hyper-V.
+
+It's implemented on top of ``Vid``, which is itself implemented
+on the same set of hypercalls as the ``mshv`` driver on Linux.
+
+WHPX is the name of the Windows Hypervisor Platform accelerator
+backend in QEMU. It enables using QEMU with hardware acceleration
+on both x86_64 and arm64 Windows machines.
+
+Prerequisites
+-------------
+
+WHPX requires the Windows Hypervisor Platform feature to be installed.
+
+Installation
+^^^^^^^^^^^^
+On client editions of Windows, that means installation through
+Windows Features (``optionalfeatures.exe``). On server editions,
+feature-based installation in Server Manager can be used.
+
+Alternatively, command line installation is also possible through:
+``DISM /online /Enable-Feature /FeatureName:HypervisorPlatform /All``
+
+Minimum OS version
+^^^^^^^^^^^^^^^^^^
+
+On x86_64, QEMU's Windows Hypervisor Platform backend is tested 
+starting from Windows 10 version 2004. Earlier Windows 10 releases
+*might* work but are not tested.
+
+On arm64, Windows 11 24H2 with the April 2025 optional updates
+or May 2025 security updates is the minimum required release. 
+
+Prior releases of Windows 11 version 24H2 on ARM64 shipped 
+with a pre-release version of the Windows Hypervisor Platform
+API, which is not supported in QEMU.
+
+Quick Start
+-----------
+
+Launching a virtual machine on x86_64 with WHPX acceleration::
+
+    $ qemu-system-x86_64.exe -accel whpx -M pc \
+        -smp cores=2 -m 2G -device ich9-usb-ehci1 \
+        -device usb-tablet -hda OS.qcow2
+
+Launching a virtual machine on arm64 with WHPX acceleration::
+
+    $ qemu-system-aarch64.exe -accel whpx -M virt \
+        -cpu host -smp cores=2 -m 2G \
+        -bios edk2-aarch64-code.fd \
+        -device ramfb -device nec-usb-xhci \
+        -device usb-kbd -device usb-tablet \
+        -hda OS.qcow2
+
+On arm64, for non-Windows guests, ``-device virtio-gpu-pci`` provides
+additional functionality compared to ``-device ramfb``, but is
+incompatible with Windows's UEFI GOP implementation, which
+expects a linear framebuffer to be available.
+
+Some tracing options
+--------------------
+
+x86_64
+^^^^^^
+
+``-trace whpx_unsupported_msr_access`` can be used to log accesses
+to undocumented MSRs.
+
+``-d invalid_mem`` allows to trace accesses to unmapped
+GPAs.
+
+Known issues on x86_64
+----------------------
+
+Guests using legacy VGA modes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In guests using VGA modes that QEMU doesn't pass through framebuffer
+memory for, performance will be quite suboptimal.
+
+Workaround: for affected guests, use a more modern graphics mode.
+Alternatively, use TCG to run those guests.
+
+Guests using MMX, SSE or AVX instructions for MMIO
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Currently, ``target/i386/emulate`` does not support guests that use
+MMX, SSE or AVX instructions for access to MMIO memory ranges.
+
+Attempts to run such guests will result in an ``Unimplemented handler``
+warning for MMX and a failure to decode for newer instructions.
+
+``-M isapc``
+^^^^^^^^^^^^
+
+``-M isapc`` doesn't disable the Hyper-V LAPIC on its own yet. To
+be able to use that machine, use ``-accel whpx,hyperv=off,kernel-irqchip=off``.
+
+However, in QEMU 11.0, the guest will still be a 64-bit x86
+ISA machine with all the corresponding CPUID leaves exposed.
+
+gdbstub
+^^^^^^^
+
+As save/restore of xsave state is not currently present, state
+exposed through GDB will be incomplete.
+
+The same also applies to ``info registers``.
+
+``-cpu type`` ignored
+^^^^^^^^^^^^^^^^^^^^^
+
+In this release, -cpu is an ignored argument. 
+
+PIC interrupts on Windows 10
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+On Windows 10, a legacy PIC interrupt injected does not wake the guest
+from an HLT when using the Hyper-V provided interrupt controller.
+
+This has been addressed in QEMU 11.0 on Windows 11 platforms but
+functionality to make it available on Windows 10 isn't present.
+
+Workaround: for affected use cases, use ``-M kernel-irqchip=off``.
+
+Known issues on Windows 11
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Nested virtualisation-specific Hyper-V enlightenments are not
+currently exposed.
+
+arm64
+-----
+
+ISA feature support
+^^^^^^^^^^^^^^^^^^^
+
+SVE and SME are not currently supported.
-- 
2.53.0


