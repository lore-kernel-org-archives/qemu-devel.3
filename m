Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA45E7718D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2dx-0000Uj-6N; Wed, 18 Dec 2024 17:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zq-0003eK-Ly
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:39 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zp-0003Ji-4V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:34 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21654fdd5daso1605465ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561091; x=1735165891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=csnlmIZP9qWpoQxYhNQ4ejdvpdIVgMo5uAQbmxbPJDc=;
 b=akbVtrCaq3Qrj8Tjpao4PiKfxCQpkcguFvtg81q4+lz8/ieXjFgok0YanCIM4vPTNw
 7iIt8METDLrKtXV821vnfg1XKu+PhlUK54rzsjJbTWt24/xadzrDy/UDUoxWP6zQjDMQ
 ktAxlpzWt8ZExr3MfUnYHgAkHDjoaKW3oY/+DA9l5VAPeOocAW9v/3I7RTyYU7ETdexP
 g1bug4GbAjDkbumiY+CI9BqxtauyN2J20IvXzKLdvrZYVcbX93HEVtDF0ys8SG1RotlW
 /fXdMfMRhLF3+DZITSq4Eic/9gx7ooplRbu+se4OYo/qYR1KQgGXuY3E9orDSBWzXhg0
 pjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561091; x=1735165891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=csnlmIZP9qWpoQxYhNQ4ejdvpdIVgMo5uAQbmxbPJDc=;
 b=ufUBij/Zi9Ep2eG5h12fljzGnAb+/hAOD6X7VyAOb68EtsL8U03t0x8xQNG8RJ2Zcc
 vuXPmsO+6rJYYCMXjFCTfGLzEYZBNTcIVEZYQIWiIo+ggJSNU3r/jya8rrkktARrude5
 czgScGDvOn16teBsalRhqCUnoYKdF0FPypQd6ePTiXJ2TAjAf/vYY2nUvKA0CEBeT0Qr
 a2jaKDsftJmt7/67Bx9/2QzyTYDTD37q0WFFmyfMAeywfU7dqbvd/Cx4uzOBx7rl+7Wz
 HyM2W4UytYOz4iV+e72QpRVvjqLRgV4D3s2BdRumXN8PsC9BbviX14waR3uoAcAi3bRU
 x6tQ==
X-Gm-Message-State: AOJu0YycasPy4YnQauWe9UGeyxJ40RsYhKUidHbv1J1G+1RQAxHJVZMx
 KL5EA2F+Ce+/2hTKPRF03D1OtJXurMXAZcXao7fzqHikEWEM8byh8txEkTPy
X-Gm-Gg: ASbGncvg3T9zb3bHwAQwQ0Eqp+2GrmU1KbLrRca8dIHM5wgLLbaMsIn1Jq159dN+OMg
 NXL6te/MfoEcO98WAo2MJIoWUYvHqHgZ/vZjI0WelZ/TF6o4sOlx7oMepLWN5Yb9No8B86WEVXB
 1gCI0NAKigm8aI7flMeGd2c0IIdZq4E+IdiqCV8p1TQdkebGWdfOZkEt8Y24o0E7gkiz5bD5DsZ
 LigS41ph0xUVlOu7mccYuZX1pS6W1JqxqmqW08bInmduypcPG5xpj50wIW696PGap9mFLLMBGje
 5IceqGaodd29yG64qKTgd4hyMnlIGpcTqMSN4gme1hl/imC3dev2abReP99O4S4=
X-Google-Smtp-Source: AGHT+IGg+EpGqBz0ywE4JVJawfOtgB74J2Q7VGEecFgQGj3S8/J2rG5cUeOJvRZix4DSpMfGh4rEEw==
X-Received: by 2002:a17:903:2449:b0:216:7926:8d69 with SMTP id
 d9443c01a7336-218d7273da7mr63803755ad.47.1734561091527; 
 Wed, 18 Dec 2024 14:31:31 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 25/39] hw/char/riscv_htif: Clarify MemoryRegionOps expect
 32-bit accesses
Date: Thu, 19 Dec 2024 08:29:55 +1000
Message-ID: <20241218223010.1931245-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Looking at htif_mm_ops[] read/write handlers, we notice they
expect 32-bit values to accumulate into to the 'fromhost' and
'tohost' 64-bit variables. Explicit by setting the .impl
min/max fields.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241129154304.34946-4-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 3f84d8d673..db69b5e3ca 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -325,6 +325,10 @@ static const MemoryRegionOps htif_mm_ops = {
     .read = htif_mm_read,
     .write = htif_mm_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 };
 
 HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
-- 
2.47.1


