Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23691CEE350
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 20:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLRzE-0004Mn-3T; Tue, 18 Nov 2025 15:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vLRzB-0004Gd-Fn
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:07:33 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vLRz9-0007XP-Ut
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:07:33 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b3720e58eso5446957f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 12:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763496450; x=1764101250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IOXcWSlncfaiePwDCOSbYusFR5OMNF5qhOoJv5z9fxA=;
 b=Z0L/vJKNzL3XH3EolXWnE8kigG8bnNqcbE2Xrs5A5gbHOP3yQKYUWI+u1AERYSU5BR
 wuvIjryWdDcXxn2MsUy5udyZ6M3UIQT+mjm/Gyn/TMEXZd4VnqG40J4UZLYMiI3a5kWv
 9fmxTzdZunqRJpvEewKk5Ax+AbiKcnR4T/795l9IGc4NQ1x15/LvrfD4iAlbiv0ZIZWt
 ErazTSB05b1FymLogXV+xVcOQcdRR4GKXNWzj1Mud7waDzhQ2JHj4/PgdnX9YFXYVzPF
 g2cyHbUPkpgj+7Ip2Xr3b+lUMxseCzer2t2bWiD1H3xhpTP9b2G7+0cbUHcWhY5dNWk4
 ksdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763496450; x=1764101250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOXcWSlncfaiePwDCOSbYusFR5OMNF5qhOoJv5z9fxA=;
 b=tlap3qjTmM9+wQhWFkmNLmUQVFsEiEJH7wUPUl4KjrEIyZ0UAAdh9QllSkkuw1eat+
 CyD6nWqr0u8G0hSbnFDK4crpGEfYq/Ta3QtXC/QEjWVmww0DPb5Zfb/vJpZJxfPvhwHF
 BcEq+xPY1+kLGAKo5GPltt+MwvKRowGNADpDVpSMRmPkSM3YmioE082ytmtQ0XEDKsi0
 BhUdBfkwBYc5nUva5JSRPOWzkVHKS1i2q33HvU+twloNNy0+tLoP/Z6OD2CMbnf0d7UR
 tL4b6rd+d2KPscAQkinXD5joWVniADdUEo8j6sJ8+zxH/LPWe5cF1comh4F76cISH5qK
 1QFg==
X-Gm-Message-State: AOJu0YySPW9EXX1x0b924qhccysR7yJnpgs0FXS87O+tUn6tp/1QAdjr
 +wIwdgIwxMcdY8/Y+iIzPOuXYXu6fos2+S+RO9fz0ksmnrNHlp8XNAdoqqLcxtKt
X-Gm-Gg: ASbGncs3iBZMzEnPNAjcAxQ8NDNGYcG+whsIPZlOFBoxMyW+STbVmHsdxFhDOvtmroU
 DRfVImQ4tAdGgcinC9a5suhZjib6GyagDdM9fAVlIKxVb8gnR+43kfFSlUK3UJqSgLfg8NfZ2Z5
 k1oDEJgOv67fG5eErw6R7AiN38TPpDj43web7CGWpNHXjbbkX1VxoqXdLWJdrwL1T9DdOj2g0/7
 JeRJOpsKqJiTUaFeq9yqGGNg/77yuJXE6Isromt6VLckKbYRc6qU1/EVOsp5TRf2vESMUCHnqLS
 rygysnANcHept4juQl8l0qd8zngSJaBI8NvZMZofg7feZ5YG21ZcdN98QqLz7kTUmLZTjYQ3lUo
 qRLhCyjT8jPRHCnWth/tpzbFxc6mU+XRESIxw3ERwkUPlciHzS6zNRwSY6+CPaHqLzmehBdis2Q
 naiQaEhdKXsuVJwxkoMGwu8tfy1AhGRc+HETqMCSCtLE8RPU9T8vcT229jqxrWownIrUDRuOqZ+
 ZT6UZbV
X-Google-Smtp-Source: AGHT+IFUqqgPen06RaVgSnd4AeLYArEgG3IxRCPcMwn+xaDPXZl+8v8/Z5T1WM7S0FAcRX77sv6x8A==
X-Received: by 2002:a05:6000:228a:b0:42b:36f4:cd24 with SMTP id
 ffacd0b85a97d-42b593495bemr17324372f8f.24.1763496449699; 
 Tue, 18 Nov 2025 12:07:29 -0800 (PST)
Received: from archlinux (dynamic-089-012-208-201.89.12.pool.telefonica.de.
 [89.12.208.201]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae2dsm34210336f8f.5.2025.11.18.12.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 12:07:29 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] hw/arm/Kconfig: Exclude imx8mp-evk machine from KVM-only build
Date: Tue, 18 Nov 2025 21:07:52 +0100
Message-ID: <20251118200752.39950-1-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fixes make check failures on an aarch64 host:
  qemu-system-aarch64: unknown type 'arm-gicv3'

Reported-by: Cornelia Huck <cohuck@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0cdeb60f1f..7877506384 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -623,7 +623,7 @@ config FSL_IMX8MP_EVK
     bool
     default y
     depends on AARCH64
-    depends on TCG || KVM
+    depends on TCG
     select FSL_IMX8MP
 
 config ARM_SMMUV3
-- 
2.52.0


