Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA8BC88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6975-0003Rj-JS; Mon, 14 Sep 2026 12:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696Y-0002zO-Fm
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696W-0004c8-EV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso42122515e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789401623; x=1790006423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5szqtR8RuknodoYZb3hLembf/Wl4J7+JvbplK6l/9Mg=;
 b=UuUgEIQRQeC+smmk6f6j/NONW6Ix0GFmR/cEvMludroSidPgD8WWRQFlgKJPE+prLa
 FV6X3WlGf6cHU5/JHOoEV9Z0pQPvX3g7BMjtmr1gOd7TNaj2c4rBA1XxP2zer64LMjsp
 yj5qiN2obAemOtAlipTQUooOcm8PL+2Gj27UZ312Zp7+Q1M7LOeQ7KYhGN/wrqo6j4QZ
 ds2+R89ztholMSKSJUZJ84/HUZMB2X9DH3rw3/uhtI9XUmsUDYHoiC+w7uourShb3h6y
 4RdKzS2tvAhW2pL0tPeQrkzKAcojJELiZVEpPoJIB6gXWdYiXqDxuun0UIOjIzTeRmOv
 6ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401623; x=1790006423;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5szqtR8RuknodoYZb3hLembf/Wl4J7+JvbplK6l/9Mg=;
 b=Gj/Ac/f0SOJoSw/zpBiOeLj6p+HUHrOPVKXq416XUTYQBq1x9pn1H1Cgrz3YWksMnR
 AGhb5zPCbmIMDxo/7UHcNxNxzcJyTEuLhZvzSt00jV5FwVDFa2WNeX+llp2yKvBhRVL2
 IvN/tbHAc4Bh2Zk+Qhlq7aY8LReeFcuUqVHqQhOnOYGm16xOyXZ/lfGGTq4k28lLK7FD
 2g6vraJBGfGT/8XTD0Y0HCKKTOAUh9wIJHFWlbozLVHRDJKzLs7HRskOhUYyn3fGRkI2
 w/5Ob20f3t181wJFM8Yg6uTnjLbf0EKcB/DK9IAsp2aq6CnOMeNjIxtbWWsuvh6QpsOv
 u77A==
X-Forwarded-Encrypted: i=1;
 AKwUvByRz49bnkAg8G1C/8KAc3W2Q/jK//8vws54HTW8nLmqb9lpDg+xKRDBkf8PuaF99iEjni5OadCjuJZ2@nongnu.org
X-Gm-Message-State: AFuF++mjVzEZJQgmF+POhTSPJrGMXnx3c8ewh1oETCiJsv1wrvb/zp5m
 ukykU+nsNYi5MoGndYzZUmAYWPu+mlVq1D+IJ74kIdSsvi06vSKRg6M0r3supSjCb8M=
X-Gm-Gg: AYBFou1kU9gDhEjDu8ser+nmvpn3tWsHE4F9KYD3PQcJNGhq8E75jbCa90v14ieqBoc
 zxCE31xKYyCQ0VFu5yde3Cq6xuyu1yHdsXBoW+KWcl8rFGkgLIcxvYG/Z+D0m4+xXpoWx7Q2740
 cqN4rzGyvXSZfTQ+CzbnyKqMi0kMqJfi0rkHE6gMJ2k9XGLrX3eA3r974chVgn051/hXixzn1K7
 BT3NzqI/YxpKMQBgxX4D5OVdtqXk/Dm5bwkTfreVb8EGyhgQ/1IlxEb/V4WaK0y7kQp81P4UZZG
 CLfrJxiFErh30sZLuNb+aQXFIv/fIBXmAuKtH/OEhdtTYk1fxVy8J41uBQZXltDW/Sh4OPVE4Oq
 dFtgmlKzYxHMft255tqFhSJptMX5LzgsDUTcVkAsNW394W9yKjAbAoaOMBgErlI+eCAfsuCdzS6
 WJExKk/kYPRA3aQr8Zqb4vj55KpLv5McZeCepMuJBFPMCdYoN0nMROrgzwQkbW1yDTZS/QF7YpT
 wrR/d7NstQLI3LGuqa9QhjUGELT8dvmqOPzFkRUbG1rmZukzPPw+ejh3zXvcUFo4xhu/ySmAMA+
 J7b7
X-Received: by 2002:a05:600c:a47:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49e7a67741cmr40422615e9.24.1789401622458; 
 Mon, 14 Sep 2026 09:00:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm30797695f8f.27.2026.09.14.09.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:00:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] hw/intc/arm_gicv5: Minor fixes and cleanups
Date: Mon, 14 Sep 2026 17:00:11 +0100
Message-ID: <20260914160020.327787-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

This patchset is a compilation of minor fixes and cleanups to the
GICv5 code that I found in the course of implementing virtualization
support:

 * Various in-memory data structures are defined to be aligned to
   their size, even if the guest provides a base address that is less
   aligned
 * We had some extra blank lines that didn't match the style in the
   rest of the file
 * We were unnecessarily extracting a bit from a raw register value
   when we already had it cached as a boolean in a struct
 * We weren't tidying up our allocated memory on finalize
 * We can re-use arm_cpu_set_irq() rather than implementing the
   set/clear IRQ/FIQ/NMI locally. (This doesn't matter much for these,
   but VIRQ/VFIQ/VINMI have more complex logic in arm_cpu_set_irq()
   that we don't want to have to duplicate.)
 * Now we have a 'max-v9' we can clean up how we deal with the GICv5
   needing a v9 CPU
 * having the cpuif identify itself by IAFFID and the IRS do an
   IAFFID->cpu index lookup is unnecessarily clunky

Changes v1->v2:
 * fixed the lack of ~ in masking calcs in patches 1 and 2
 * patches 7-10 are new

Only patch 3 here has been reviewed.

thanks
-- PMM

Peter Maydell (9):
  hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
  hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
  hw/intc/arm_gicv5: Regularize spacing in config_readl() switch
  hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
  hw/intc/arm_gicv5: Free memory in finalize
  target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set IRQ/FIQ status
  target/arm: Only allow GICv5 on CPUs without AArch32 at EL1..3
  hw/intc/arm_gicv5: Pass CPU index to CPU interface
  hw/intc/arm_gicv5: Pass cpuidx rather than iaffid in gicv5_get_hppi()

 hw/intc/arm_gicv5.c                | 72 +++++++++++++++++++++---------
 hw/intc/arm_gicv5_common.c         |  5 ++-
 include/hw/intc/arm_gicv5.h        |  1 +
 include/hw/intc/arm_gicv5_stream.h | 10 +++--
 target/arm/cpu-features.h          |  8 ++++
 target/arm/cpu.c                   | 61 ++++++++++---------------
 target/arm/cpu.h                   | 10 +++--
 target/arm/internals.h             | 14 ++++++
 target/arm/tcg/gicv5-cpuif.c       | 41 +++--------------
 9 files changed, 120 insertions(+), 102 deletions(-)

-- 
2.43.0


