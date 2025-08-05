Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10DBC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLWo-0000fc-Nh; Tue, 05 Aug 2025 13:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWm-0000cv-Vx
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWl-00053c-9e
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so3369509f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415161; x=1755019961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nyp0V1s1n3Qx5gTtUClK6ljJrPkZFehssseSlQktGtg=;
 b=GpFjWfWyD5t9WvuCqJ3mA6MajciDMZ9GIjq7dGNepN9VtXFNHdZl19uGJ4q83bHQpb
 UHNL6FffHXUECRVbSp7IQ9kOMB+M6eEzKczDSp1AqicjyeGk8bwM4s43o2YozxgbDveS
 K14vz+ya2mAMvK7QHI680zweCIYJr8OiQszRZpa6EuC6cFMGANLCCVkwNjKrzq3jaqf0
 IYt4uyL3sWET4kOYwoOJ2wr46WN59VCtgMINGtyTTrKManS9B9cwPg2fxsj+siRSdTXq
 8n9CS87mktYO5MESZ/8DEcFi7G/rbHQHW2XMxxXI5grHbv4yIIFC6iMh3nTzak+EISm9
 Fkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415161; x=1755019961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nyp0V1s1n3Qx5gTtUClK6ljJrPkZFehssseSlQktGtg=;
 b=ARMv1SqaFWTowVEXGpNi4AG739g/iyjgbixFqpZ1za363BWh0yKCVUct5jE8U0uQBB
 K2XATlpxH/oEcrvVun9HDT1gVHnJpzINcmt461E1OwFrITwAYnEMEzIB30xAlb7L4geY
 brI0fGEicmw3d/omxDOI9sctOSzKdIj1kWBieDwWmMnNwCtQonwoyTYIPn9emriEHpIo
 XVij/Lfvt7IuM6Jld0JXXOxuBeSLmYNbt5A5et9XK41EfHw/uEkX9YxZRQ0oZjSyQz1x
 mU5dZt2/0CpaiH7KcqRVeKLVQJu5GxIlcCAzFNFbqbbD3/0W5+HRu2+3hQIYt9Rr+WQm
 6GSQ==
X-Gm-Message-State: AOJu0Yw7z3unMw5wQcYtBa3XmfgqglvEsHxVkDAkZeWavPfDDkA9wO9x
 91ODvrkxnOkTZRRcRj8gyOOBM9EV0FqhIL6rSdXzd3tXVsK3r06uJdQmrlv6/a2loe7zntR/Uj1
 XLhSf
X-Gm-Gg: ASbGncuxQkTp7yLVFfx8Z/JLtRRimCXtptIXMYPElXJP6mKZmQUX28szgk0WZVi78Pj
 OgyuhGk/lMVP3R1vDQaW51NvQZehIvydICNqpWNfCG/SxTBiKHsGJ3pR1ohA5bvBn02g7csye8L
 yqeenOM2UATTP1vvQmPJ68iiNNYjg3VxkITpspW+qiKtmFfJscCNlMlQRzOs8eQHQ2sLjd0bizV
 CMDKSldykin05OnSb063dpZamJUPFqzzCwlrM97JbSO5/QHboQJlPSwD6oy/q4Bp0F+RHvku7en
 J6i6OrIX8VNK8e8iIHOCnFBUtIWsNWnbY3txm3YMTF9nS4/Mu+ipITJs6upULdNq86hLzNIYY11
 24zLuMpaDcHZvtuX6CqQVAIpnVdX9E0oQNLIqaIK+3VdmbXcVSP3gU+ByXztm1kIOT6eFLV7D
X-Google-Smtp-Source: AGHT+IGBuuD2RYM/P9sr7OS1tZQ2JnZK0H8/ogIeNzrgEgakdizwS26xurZRjzk0zXnf0K44uXEZKg==
X-Received: by 2002:a5d:50cc:0:b0:3b7:882c:790 with SMTP id
 ffacd0b85a97d-3b8d94aaf66mr8411006f8f.37.1754415161504; 
 Tue, 05 Aug 2025 10:32:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453aeasm20592966f8f.40.2025.08.05.10.32.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:32:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 13/13] hw/i386/microvm: Explicitly select ACPI_PCI
Date: Tue,  5 Aug 2025 19:31:34 +0200
Message-ID: <20250805173135.38045-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Eric Auger <eric.auger@redhat.com>

With a microvm-only build based on a custom device config,
we get a link failure due to undefined reference to
build_pci_host_bridge_osc_method() which is defined in hw/acpi/pci.c and
whose compilation depends on CONFIG_ACPI_PCI. Although CONFIG_ACPI
and CONFIG_PCI are set with such configuration, implied CONFIG_ACPI_PCI
in config PCI_EXPRESS_GENERIC_BRIDGE is not selected as expected.

It Looks like CONFIG_ACPI_PCI must be enforced and this patch selects
CONFIG_ACPI_PCI in MICROVM config directly as done for PC config.

Reproducer:

../configure \
 --without-default-features \
 --target-list=x86_64-softmmu \
 --enable-kvm --disable-tcg \
 --enable-pixman \
 --enable-vnc \
 --audio-drv-list="" \
 --without-default-devices \
 --with-devices-x86_64=microvm \
 --enable-vhost-user

with configs/devices/x86_64-softmmu/microvm.mak:
CONFIG_PCI_DEVICES=n

CONFIG_MICROVM=y

CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_SERIAL=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_INPUT_HOST=y
CONFIG_VHOST_USER_INPUT=y
CONFIG_VIRTIO_NET=y
CONFIG_VIRTIO_SCSI=y
CONFIG_VIRTIO_RNG=y
CONFIG_VIRTIO_CRYPTO=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_GPU=y
CONFIG_VHOST_USER_GPU=y

FAILED: qemu-system-x86_64
cc -m64 @qemu-system-x86_64.rsp
/usr/bin/ld: libsystem.a.p/hw_pci-host_gpex-acpi.c.o: in function `acpi_dsdt_add_host_bridge_methods':
hw/pci-host/gpex-acpi.c:83:(.text+0x274): undefined reference to `build_pci_host_bridge_osc_method'
collect2: error: ld returned 1 exit status

Fixes: af151d50eac24 "hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method"
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250804152008.247673-1-eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 5139d230877..3a0e2b8ebbb 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -131,6 +131,7 @@ config MICROVM
     select I8259
     select MC146818RTC
     select VIRTIO_MMIO
+    select ACPI_PCI
     select ACPI_HW_REDUCED
     select PCI_EXPRESS_GENERIC_BRIDGE
     select USB_XHCI_SYSBUS
-- 
2.49.0


