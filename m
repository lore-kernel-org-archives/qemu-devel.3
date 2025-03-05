Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEF5C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdUG-0001wB-66; Tue, 04 Mar 2025 20:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTZ-0000BC-6c
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTV-00071e-6M
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:07 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso40736085e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137783; x=1741742583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1HY9sBjuk9kbpZKm7s52igZtwUaZd0dmJ6wZJ2aD0c=;
 b=blyXb4n7rIarjWat9guQIA2HxtaZD7jdUg4C+SzPCMlxA50rWHaupiWH3duaXDzKsX
 MIzah7xmzFK8pub6Zp3t6mVs44pg1Hka824qd1OmNros6B64muGrCmR/dZvAXpIKVqab
 LBStIj12poTlHnq7TMm28QwiQ+VF0/UStvMtzwMC7rAXFO60IL1jrlXY67FsCQ8m6WK4
 In+23n/17Q3fKF9DvbMgQHDVBDa9OnGv50Tomm8opYxae0p0/K4SaOe46GEf7YxnnuBr
 Vp5PBN+Q4h+LwyUiAeiJJMkLlU7uAv19MB7DrGFlRK7HfH4j1yyx/XcKvQp93KypPRrq
 MxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137783; x=1741742583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1HY9sBjuk9kbpZKm7s52igZtwUaZd0dmJ6wZJ2aD0c=;
 b=hvhi1sfdJXCYIDBY5yoOmNtcQ82zZ8oVFQhtLgRUgA+18r29hPlS/eYJN0NnsC/NAI
 cVl7iO65MvmyazHukHogxDEjxrVzjyBy3waH/AtHm1LS1GISlPvqOxCV/f/+WyqUDB1E
 2fl3opEkmNqDaqOc6YcvsZCfnarM7+fiI+c+hEX2Ef9E1Y7rjA/os7OK0CX+PSXt0Rwd
 7LoQXI8XXuir1hbqzpCloeMaVRKGRuF2jXbxTA35Xo8HylLS+0C15rVSsOcpeR4j0jyo
 JIrfADOIxLy/N/DINK5jPgVz7qQGT34RiAN4ahLoAcjkyLtoendml6BEfTxDJvDWLt3E
 mmPA==
X-Gm-Message-State: AOJu0Ywo2nCjgZdtlVGX/+LwZHOtdrYIxp66tYry4cMtn2yoDTZ92XQ4
 Huir9FOYHBOW8gL1LGmlQrRdmleJD6UPSNaLyG4Nq6YfQnWw0cg1F2eQZ4LvzHqsTiUcP8OH2db
 l9b4=
X-Gm-Gg: ASbGncs1A2SeeJcF9JMD9syTRprqcjBIp+HzQ8rspDPQ2pYyTiCpsP/tB3GfkEsMZKP
 fGZcjJbU50f1AtUMjkaUk/MP2ARtQPDR4v4+l7U1TyRQ5zkF78k6X3tAHeMd0spqN/9WIcZwa41
 o1GzXoAojXTmO4ipXc1qFT9d7Z5RxF22Sf6Yunx9p2USwD/qaby4QpKUUMQpNFq8Uka1vkaJpCK
 e3svpIFA4rDEf+mTUVI9DMMCWbuPZh0iGVeNkX6Aa3PwjT+TDKCKzIOX49Km5EY+s2tVHf3wwNT
 kkzHvRI1FmywkRpfNMl8ML0aLC8bjvpXf3lwxJBCZmm084vZ3AhI0hEg6lQdo3svtvUPsuBltyo
 bV28hOwdyA8Gkx/bJJPY=
X-Google-Smtp-Source: AGHT+IGKilKfXDFpupZCE6t8Xm96A8TSiW0MpnEDwWP8SPmCYvEhJajQdQxNiEJfpAWd5ORZ0G6XZg==
X-Received: by 2002:a05:600c:35c3:b0:439:9ac3:a8b3 with SMTP id
 5b1f17b1804b1-43bd29dd2b6mr5818615e9.18.1741137783469; 
 Tue, 04 Mar 2025 17:23:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844a38sm19442661f8f.75.2025.03.04.17.23.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 13/41] hw/xen: Link XenPVH with GPEX PCIe bridge
Date: Wed,  5 Mar 2025 02:21:28 +0100
Message-ID: <20250305012157.96463-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

XenPVH requires the PCIe/GPEX device. Add it to Kconfig
to avoid when configuring using --without-default-devices:

  /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-pvh-common.c.o: in function `xenpvh_gpex_init':
  hw/xen/xen-pvh-common.c:174: undefined reference to `gpex_set_irq_num'
  /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in function `pci_dev_bus_num':
  include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: include/hw/pci/pci.h:337: undefined reference to `pci_bus_num'
  /usr/bin/ld: libqemu-aarch64-softmmu.a.p/hw_xen_xen-hvm-common.c.o: in function `cpu_ioreq_config':
  hw/xen/xen-hvm-common.c:412: undefined reference to `pci_host_config_read_common'
  /usr/bin/ld: hw/xen/xen-hvm-common.c:428: undefined reference to `pci_host_config_read_common'
  /usr/bin/ld: hw/xen/xen-hvm-common.c:438: undefined reference to `pci_host_config_write_common'

Fixes: f22e598a72c ("hw/xen: pvh-common: Add support for creating PCIe/GPEX")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20250218162618.46167-2-philmd@linaro.org>
---
 accel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/Kconfig b/accel/Kconfig
index 794e0d18d21..4263cab7227 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -16,4 +16,5 @@ config KVM
 config XEN
     bool
     select FSDEV_9P if VIRTFS
+    select PCI_EXPRESS_GENERIC_BRIDGE
     select XEN_BUS
-- 
2.47.1


