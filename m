Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C182BCFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 11:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNV33-0004sC-GY; Mon, 24 Nov 2025 06:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNV31-0004rH-KF
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:47:59 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNV30-0004de-3k
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:47:59 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b3d4d9ca6so3385396f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 03:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763984876; x=1764589676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R3BCt6mRRKHL+2yqebBYLsLG9nPkDZtSoCS4ZfOrDa0=;
 b=s+Hz2cdjmrdCFNGy7MFcjEuaIWmmjeeSP/J7M3X1ncAVq/eSZBFuH+LL1XjKbe/2qw
 8o6MkbYWRRmhmDonMters45QEKg1rbdtQY27fuEhVJCMMS2iNCqsWJjhCW9F1++AN4Wf
 Zdl7rX8GthzsA3vqh8SZ6J9neDSUSKv0WX9EdLZ5LdwXapAx8E+3Qf4fow2yj0UMR3je
 /EvFm+fH4tpt10MRSs5vWHqBdaH6Yo6GVsNOO3VSHZoAWxMH+5NbGqUvlQrWwLYNI1cZ
 5bx6kuwxl0+cwl94knGlZRohXrsWhV0gPPYBiFrgwyYPj3KDsXGLnYwQDr41/wiwbCwG
 a87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763984876; x=1764589676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3BCt6mRRKHL+2yqebBYLsLG9nPkDZtSoCS4ZfOrDa0=;
 b=OnGPeCqFdfuNGAYkh8bHDsCCTt4MS3I6YuJJ+f1lCPmyFBpK91WGsCUHRjIk7dx4nU
 yc6RhCHOct2CWJsthYvdaIGpErYGBrwU9yJV1p+cnsgDPBBBI2cxPfbR0z8NPaVJGxtZ
 xJN7HLOES1bJneOL4hdgzKJkt6CoKUJfHiZi1Ew62dgcz12lYrmqzhI0i7TndzpBHouq
 4P1Yr5Blo9YttoMchdNocfvz47+R41+00VH9kMz1c47THZQHmSHVpnGll82r5uZ2mEMs
 tNXRohTLb2SEDlYkc6jIq3PkVXcwapj4uhHXRGM7K8Q6Hkozvw28YVKvVACrPHQr9wEZ
 0vGQ==
X-Gm-Message-State: AOJu0YyASLt6DpuyiOkIRB2kuRc2huItHOR4wYXAjRWouK83hJzOIUI5
 Rjcup4Bea1aj8Ij5mDXu/MybG95rFTGO/p6tF9AAUgjK256KEEbyXsmKvdCGwZ8GNQ5FktFwTjq
 6PXkgv82M0g==
X-Gm-Gg: ASbGnctV1qTruR4gMVNfodBpKNMawngPszJIccnY6atIaXz70Uj7wfR9dPVRNTB4aeK
 rWoz5V0tckruE7Mi+vhoV4IzA+CW3ITk5oluOa6TSqfQAx7YRbudPMwE9ZYzOobYGXsT3eJH7GQ
 ECgMy/0vYu0SbKl0zmD5BFFXkrabdfciqv4yiLqoHzt/zvpnUbNSZ7v2N20Ps7MiD2FSjUGYRhh
 HnZ0/9sfQzpQt/6/ltrr/aBCT6EjBrouifNsOhA01T1FiAOo7WG2u3t+VUyKxKZe5rEOl+gktIa
 mmqshZTf4UGL5Ae8qvPyABytzgzmRPFjkWZfDWS3SzAHWdCxJ2Uacb6xAVQasUbrEvyRnwA84/+
 Y7bbT4RJlNRaS4roGYm1Cv9Af6vCG1x55pj+x7G3zfRay4Mv9B7jbIjf243bGQIJ2wEXJho3Fun
 KYR9epxB3Fuhb8H+KXlMg4koiTX1jwgQLn55D9Gf/GByqL4LhnyBSOe1Waqm8w
X-Google-Smtp-Source: AGHT+IFerpXzKLQRfLpoT8pDVQrHPHDsGTzrIcTW0NzbE2L4Fw6QJGnAdZdE14LpwFkD2vCjDYs/TQ==
X-Received: by 2002:a05:6000:24c8:b0:42b:3e60:18a3 with SMTP id
 ffacd0b85a97d-42cc1cf10d5mr12673696f8f.24.1763984876023; 
 Mon, 24 Nov 2025 03:47:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a76sm28107081f8f.24.2025.11.24.03.47.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 03:47:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/pci: Use correct bus aperture for device container size
Date: Mon, 24 Nov 2025 12:47:54 +0100
Message-ID: <20251124114754.79831-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Before commit 3716d5902d7 ("pci: introduce a bus master container")
device view of the bus address space was correctly sized to the
bus aperture, but then it always used a 64-bit aperture. Restore
the previous behavior, so devices on 32-bit PCI only see 32-bit
address space.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b1eba348e06..64f33b9de04 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1375,7 +1375,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
 
     memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
-                       "bus master container", UINT64_MAX);
+                       "bus master container",
+                       memory_region_size(bus->address_space_mem));
     address_space_init(&pci_dev->bus_master_as,
                        &pci_dev->bus_master_container_region, pci_dev->name);
     pci_dev->bus_master_as.max_bounce_buffer_size =
-- 
2.51.0


