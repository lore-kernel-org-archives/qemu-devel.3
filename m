Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4043C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 12:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvGA0-0007kR-Gw; Fri, 12 Apr 2024 08:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1rvG9z-0007k5-MS
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 08:37:39 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1rvG9y-0005nY-5U
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 08:37:39 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-23333ef4a02so590456fac.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712925456; x=1713530256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=S4E1PuKOUz8LfABzslNZ9y/3jCscNV0FvezWVXxnkPM=;
 b=PLHzSppVCVi76sZ2OwXWmKy0GwZPNqFlEpR4gpItj4ByW9oYmya0VpvP7qosApEnO2
 WVKVjYVoTGyWaf3YnNHCsp5eZnU+5+3ajiSgRzMUKXLXumYVVoIx186MXV8OjcgMJb73
 bfCWiuQ6aPxR4o9ZBbQS1er9y2fAlx6slg2qvaIfPRLNWH9cJBBCwBnZtkzJY0/wkm13
 YFdURlmX+9IcYs+h46SOBdbABEBKH0L/Yv78gUEl5dFV5H72ujuHdPUghR2fwgzvUG+7
 84JVleNXpCcWn6Xd7zyHFdUlvqcMUqNm992efqVWFUlso7b8XoinOz7XjhDDx20gmWxg
 +gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712925456; x=1713530256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S4E1PuKOUz8LfABzslNZ9y/3jCscNV0FvezWVXxnkPM=;
 b=rstf1OoH7q/knelVL8vtm1kbdC9WMZpTqFcT1AlIMJvjYmpvE/1ZQ/rcna2aRU8vxl
 OSl85H3k0ZAnp9yFce4iGRXSmqV3U1S+7ox0Fe9GA40DyfqtNqfayTQfy1hkeknRXiWk
 usiZ5uW0uMLxRkpbqsh1yXtP5aHHULO3JlkhpSr/pw4oX0G5EnSGQMVqpNatqiD5YjfG
 r/qAgS/+d3IxqLagvFpIdYQcXrrPy5QJNS+iJcvhGphLuMO7cbl5rGnyJOZyJlUq+3PN
 O3LEO4nQeCM6euUD4ZpYY026UraE+ThHIOMHO491CEzMF3fiuTeC04FmL1vK/9b52NxZ
 U6zA==
X-Gm-Message-State: AOJu0Yx8KhbvQkjB0A0z+1yCcOBlfyjcrE0ikSNiWPbn9Tdt5IgwGXNz
 vtDdqDT+STv3CQUtUK8etxsQUht6UbF2K/9JPc94j+fAoYNVANeLN6b5iw==
X-Google-Smtp-Source: AGHT+IHCNHzaDynkOOZ/wM931Z1lsWXyukwdR3SCyg59Cdhx1Z+Mza5BLE5BPqqoMuT5AVOPPXe+HQ==
X-Received: by 2002:a05:6870:330d:b0:22e:9e7:8b2a with SMTP id
 x13-20020a056870330d00b0022e09e78b2amr2794224oae.0.1712925456034; 
 Fri, 12 Apr 2024 05:37:36 -0700 (PDT)
Received: from ubuntu.. ([149.28.154.72]) by smtp.gmail.com with ESMTPSA id
 go16-20020a056a003b1000b006e64ddfa71asm2881074pfb.170.2024.04.12.05.37.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 05:37:35 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Update my email address
Date: Fri, 12 Apr 2024 20:37:29 +0800
Message-Id: <20240412123729.1340062-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The Wind River email address might change in the future. Use my
personal email address instead.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1f6922025..50729a0985 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -332,7 +332,7 @@ F: tests/tcg/ppc*/*
 RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
@@ -1614,7 +1614,7 @@ F: include/hw/riscv/opentitan.h
 F: include/hw/*/ibex_*.h
 
 Microchip PolarFire SoC Icicle Kit
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
@@ -1641,7 +1641,7 @@ F: include/hw/char/shakti_uart.h
 
 SiFive Machines
 M: Alistair Francis <Alistair.Francis@wdc.com>
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 M: Palmer Dabbelt <palmer@dabbelt.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -2137,7 +2137,7 @@ F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
-- 
2.34.1


