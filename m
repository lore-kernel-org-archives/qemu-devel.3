Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A60CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKdw-00065t-H2; Wed, 27 May 2026 16:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKds-00065P-Rh
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKdr-000577-9P
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so80271075e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912854; x=1780517654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcS3pGu767DyDfpU/yLApw18aqoV6ysV4gLdhBJ6clc=;
 b=vHBQ0aZEiJvZkgi2YtrA9uih9g8Ou7mfZPVwe6gxYyx2cHKtrkkuqwsJE9POlEqpYf
 YNFj+hqfRMrZP2o7y2VitUXu6Fx/FEYTrHdE3/4H2dRmslpZs7/CzGtKobWjCy9KKcG9
 M6acgmup1/ZO/wJ3pCTxvIGoysbkWnaIfPXEvGeVTv+UdsjHCn/cGmHkkIeVnQ49bVsI
 qVM/KqPvfX8LDhiZCffLDQLOhDS7uL0iPlvZwqNhaP58MfVrCu15635+vn3sgfkirCIP
 73Y7nII0bJn4Jl/L8M1H9bP1szqYGl0rop3Tlg03nhFhdv0iU/Vu5fWkq140C2r+jZ2k
 DzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912854; x=1780517654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fcS3pGu767DyDfpU/yLApw18aqoV6ysV4gLdhBJ6clc=;
 b=tV01RyEXvSvvMGbwvUln7qQjFM3EG20Lxv48+rksUvylz6igeHLbfcq+Hr0GbqlFRa
 WYTh03yBcSSvqhbHptnRNpO1/Yx70WLZMN7cDRpoI2SVAe+lkxmU/cDVv6pct6YaCkUw
 RNjFWzBc55+rwNjVolJMGGfKpv0g6/HECGLz+R2jzh7M3ac5HKU1IuKTX6sFjWqMtenE
 iaBlkfCIO6uV8Ftk1uH8fJdnvFqwyA6dl5NNuD6/ezkfHHp/UwJuDSq6KLba6tH6/d4j
 2+A63DLtbNotaHW5vKT52BEggxjydo1VtXIBqY4TKJI4a3wYg1AEDy5C+/SMaUvEfjXr
 G2gA==
X-Gm-Message-State: AOJu0YyCLZZAqJUE0qVD2db9voBzw9S/+GtI/PrmW4inDXVrADxQCvX0
 qOjSPWiDxWoPQNnMRvPn3Xt0mBdI07mzF8rxbl8IZypC6BLLxTitQ4v0hSTF5kzlrScg1PHB75Z
 PYtmNWTh1dA==
X-Gm-Gg: Acq92OHZ0FP1LtcqGyRrG1XoXvEPUTe/Ja4dWFtt5rlFiILmw3I/yyAfi+gr5r8Lk9B
 r1FGRWXALIO/r8QqzEmNsS7GyK1l2ZRgE9Hu5DM0qUoiy28tU8RVSg3K7fzaoYUagYot4b0fevx
 iPSXcv5oqEnzFNkz/RJHpSYoz4VIkZFlKa5c9dOaVpM4OjfNhdKTa+Tkg3t9rZ6Z208B6JcpFCI
 ZjzyvM2IeFD0a/PXuVx/MXJj8QqoPEsCoL8KKU2HyqRtu1G674/we6mOwlJDkVP3MRUZjSGn0aY
 k3I21mGJFQ7agt9aaXuc5W1TN+Ndegk174MTazgu6igKnCcU8/HJj6j94fHGfPXHNeikCyg1Ljr
 hsJre/MwMt6ySYZJLgvqgr9sSthasW2eivJaX0P3FB437BKQ0oZDTbIeYbpn4QFb+LDHQ20/VcP
 CbUF0xGa0iGZBQzTbcrE9EDObFuUcyFanlmZXvqTb5Hde34nqqFXdu860QMOvstg040Q==
X-Received: by 2002:a05:600c:1c0b:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-490426a495amr384507365e9.14.1779912853653; 
 Wed, 27 May 2026 13:14:13 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a33dsm385306125e9.11.2026.05.27.13.14.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:14:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 03/12] target/riscv: Assert PTE.N/PBMT bits are not
 expected on RV32
Date: Wed, 27 May 2026 22:13:39 +0200
Message-ID: <20260527201348.29511-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

PTE_N and PTE_PBMT are undefined on RV64, assert we are not
under RV32.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17305e1bb75..f86bfdb32e7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1490,6 +1490,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         return TRANSLATE_FAIL;
     }
     if (!pbmte && (pte & PTE_PBMT)) {
+        assert(riscv_cpu_sxl(env) != MXL_RV32);
         /* Reserved without Svpbmt. */
         qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
                       "and Svpbmt extension is disabled: "
@@ -1643,6 +1644,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     target_ulong vpn = addr >> PGSHIFT;
 
     if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
+        assert(riscv_cpu_sxl(env) != MXL_RV32);
         napot_bits = ctzl(ppn) + 1;
         if ((i != (levels - 1)) || (napot_bits != 4)) {
             return TRANSLATE_FAIL;
-- 
2.53.0


