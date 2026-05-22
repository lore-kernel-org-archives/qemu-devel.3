Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CEFCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNl-00023U-Na; Thu, 21 May 2026 20:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNf-0001w7-5c
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:47 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNd-0003Xy-Ec
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:46 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3697f25d26eso3463229a91.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408280; x=1780013080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dY4qsp6I25BpbHtaR7u0x/TdjhzZeRX0TyV/91M9Ho=;
 b=kzj2E9nPnheDke2EjGN9K8czvXdI2k51e71lYSLStEuEbNF1PFgSb4Bbsm4ojulAKb
 BJoIi7ZxCBFvrK90YycEjTWvtwo2/Au+VRkrbv+7nH2A9Vbbb1IPXWjdxFtFsbyAXGjG
 Zv1U+f1s6wqBifZWJkOhuaTsOvl/GpmRN5PjuFKh+QnDcp+QrrK8mh2rd8lJhBaeeSm5
 E5EJ1CMuXBsVMmYbdwLlTtFpZ3r2nsLSh2MFZWtH25idw8aV+8oL4GMzNbJzNZi0oJiI
 /jI6ixkyQKRTGpQm4Vi6qwNiLZaSgpu+1H5zQwkD0520BSDOwDeMJCsup80DLDCDhKXy
 UrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408280; x=1780013080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6dY4qsp6I25BpbHtaR7u0x/TdjhzZeRX0TyV/91M9Ho=;
 b=JvEC8CAufUVgxcFsiD1OfmytzK+wnhXTaK4ibr3CkNmP0ye++x77CT7pfNUAAZ043u
 etDLufBQGmwY7LwT90PwO8o9xJ/0HuSR/KuAnCzA2IrhfupDMo5YTwBU1S70r64GlO/U
 RTJkl9CvDVwupzhgujO2eHdsbWPBRY7OhVAXOxJIL2AoSXebZDQbajpTskO6upoxi1DV
 kHNh5cYplgJyCnL/PCu5S3nqRBJv8oZ0qLoeuM/QVza0E5tm3RVHYZXuvXVN9vAvzfrV
 +BspE0/ZomQdR/3M4ovn7qm8Hyg9ih8E5flNFOdtc7emlfrzLb3bn+WM6UL9HI4Z3ot7
 e/Qg==
X-Gm-Message-State: AOJu0Yy9adqvMnciqjqqMG6Rn7wudIcAkWl7tT0QclFGfsVRmpJ1V9WP
 e2QDeuZluS4Phx5JVPP5BF+uuc2P7Qu3skiL8eUmpJjIUPrqQLKEIGaG6Xo1O5vJ
X-Gm-Gg: Acq92OH1F/jbaW6Q/Pn/uZNJskGcmt81CR98jxFpn2r8d22aG5tVrv9vto/Eakt0PFl
 HEahRrcsGhJ3JGEojkVd0lKZgcEoYmMTgojR3TaqRDsjc2q+7nbrsALTKIgKQ/ptZXweW+L/hQW
 3rpmElTsmFdidw3g9YkAESUxnHmTdpt3hS0nmad32F29V70B494oAOeZKG6xtNRaK89Y0pfEfaD
 byDLGfzstHssSQzY241sDtAyIBkt3m/FNsVfR0veaGlwKPx5wcJDftDkRC5ARL/iBizHaOjDK18
 XNieaIMCOrLqHL+uZAN6PyrHcJQZC1jUu2V3FLQKZBgr76lEZtv5O1Dhk9uj4L0o456RTMnXAFp
 +K0UHAEnaXXsF0JcosDLDLSZh4UylXcMw5yIoM4PApLTMowmUSmjE6y/VBQS6VK89x+dXUys2hS
 JrBgd6/cZud/NkLuZBg7gwdLEhngQ/9js5binY7ZHnMQ==
X-Received: by 2002:a17:902:cf4b:b0:2bd:ba44:6c07 with SMTP id
 d9443c01a7336-2beb0702610mr10739645ad.16.1779408279636; 
 Thu, 21 May 2026 17:04:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zishun Yi <vulab@iscas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/48] target/riscv: clear mseccfg on reset for all dependent
 extensions
Date: Fri, 22 May 2026 10:02:56 +1000
Message-ID: <20260522000324.23255-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Zishun Yi <vulab@iscas.ac.cn>

Currently, the `mseccfg` CSR is only cleared to 0 during reset if the
`ext_smepmp` is enabled. However, this register is now shared by
several other extensions such as `zkr`, `smmpm`, and `zicfilp`.

Fix by clearing `mseccfg` if any dependent extension is present, and
adjusting the relevant comments.

This vulnerability was discovered and reported by SpecHunter, an
AI-driven architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-svvptc/pr-134/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260512052240.330815-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8be06640e5..3f4fe71c80 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -756,10 +756,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
     /*
      * Clear mseccfg and unlock all the PMP entries upon reset.
-     * This is allowed as per the priv and smepmp specifications
-     * and is needed to clear stale entries across reboots.
+     * This is required as per the priv, smepmp, and other security
+     * extension specifications that share this CSR, and is needed
+     * to clear stale entries across reboots.
      */
-    if (riscv_cpu_cfg(env)->ext_smepmp) {
+    if (riscv_cpu_cfg(env)->ext_smepmp ||
+        riscv_cpu_cfg(env)->ext_zkr ||
+        riscv_cpu_cfg(env)->ext_smmpm ||
+        riscv_cpu_cfg(env)->ext_zicfilp) {
         env->mseccfg = 0;
     }
 
-- 
2.53.0


