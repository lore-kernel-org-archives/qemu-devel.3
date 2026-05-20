Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A04CD5BA6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf24-00047M-So; Wed, 20 May 2026 07:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPeyo-0002Jm-5u
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:21:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPeyZ-0001du-F6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:20:41 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so1048100666b.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276018; x=1779880818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLvsWS0q05lqOyXgNSpk34dhHcgF39sVzumKyZgyZ0U=;
 b=BPxxbie00GcIEJJe0BVRRoLI13xcaTcmbKvRe/kr5zo01uEZK23VObyKK/mwgjpfy4
 1/ZMVopZWDo/9np7XvvQ/pe/PTBKTxxU36fi+ajdKU+SBDWUchaKyXKVRYkK0VH16Oql
 Rzua/ejKZxz/N/m0UAgHzsGpFqU3NKqnf+eg9EtReE5Qvj90ejrMny816U1yf7hcubLV
 Q4y1kHt21eeg2N/4wdE+we3yauMYdeVTUZoF3fLYr5c9/rp5J0Eo8PMdUNh3ZuYrqmMX
 UQ3nPPQdfBiPe9tNikucd1ooUEgHHB0X1q5x+j055CeRlpyF1pGbnKb3xl1LmOY+K32Q
 DTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276018; x=1779880818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JLvsWS0q05lqOyXgNSpk34dhHcgF39sVzumKyZgyZ0U=;
 b=Fk2GP0/igqDAeKsmQZG+ikgq9ZluuL3knOxyaJVoikDJrpQtqnAIoqcXj5d9OaFsRg
 zrj2AKVKwVqUdy3ZZC28zbjgkWmtLW0YY+vxCYKTQH4nQHqcy1pc8Pfevb3UZSldOqlg
 7AsVe+456R9m+2wsOEohdPBzv17BIFS1Ye3EdWLI4hCKnDDFbO0Urojkj+FxTGP7YJvm
 FiUnEMnyBJRtDFOz8CyhOAGfCTzx0bATRG1ul6vvzzOtKXaeigj4LajT+F6tN9owpkO5
 EbkE+tjBkvzFwABUk4oUfQiwVH/HaS9uZeIJG2N1lt6LQL1W5fQlkE3qL0N1gGndFmMA
 r2LQ==
X-Gm-Message-State: AOJu0YyO+MgIcIm37akVlQDWvglQD2eYk+4Ifu1bgY0Xeq/xv1c5AUAC
 Kr5R68FqMrEIaU6IFtrOIP/rpzfI5GzoReiwT33TAr8ViPivvLugDSF+qZO+9UUT/KmZBGDYLfB
 8Frk6HAA=
X-Gm-Gg: Acq92OFoVglhP2QDx30v3hKkvlthVZCW8XrA49aT5jUNBDgYDzqfPmPb1KeEnYBRkXE
 9LNPnKRryJoxXBzSWL+TdgT7cmoWTejLjppOlliVA/Mjy052iX659BilEW8LOTzDAc1mJEmn4+A
 cOucZ1HWUqNqoATEcQqzyIcvBbKNFYIPb/xt8PNMxdRi7wp9rkUXm/t2oPGwC2id84xMP3WcZoB
 fvXiZgfvd+sCR7oNx0Vh+ZoKFwrYzw34JtZYmJQUE6NyCKqZBKJrGCr0vpYihKQqyjyEEGOZjSa
 /QqUxx3SA8FxLnHcNEKeRsYtCLogpw4tOPUdH4jVB+XQyfNweeqY3DHvHogEdcjBPfSxYVf20E8
 kVE36emAg+iTUOE7TW05j8bdt+GeznrhpAxvzBp6tBTXgmBA/PsMo5RWyrcjifPdbDkZxOZi97L
 D1oFWt5gwOwDYxDLYRJYeuIfVm9flgZraPUxwvKp6qP3Fj+A8yExFH3yGwcz+4HiPJCygokEXtb
 U1ECw==
X-Received: by 2002:a5d:644e:0:b0:45e:739c:f187 with SMTP id
 ffacd0b85a97d-45e739cf872mr18764992f8f.22.1779272320708; 
 Wed, 20 May 2026 03:18:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe1a41sm57175147f8f.31.2026.05.20.03.18.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:18:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 04/24] target/mips: expose Octeon68XX floating-point
 support
Date: Wed, 20 May 2026 12:17:45 +0200
Message-ID: <20260520101807.9971-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and use
CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-defs.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index faefab04738..cc1916232f5 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x000D9100,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
                        (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
@@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_ELPA),
         .SYNCI_Step = 32,
         .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x12F8FFFF,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
-- 
2.53.0


