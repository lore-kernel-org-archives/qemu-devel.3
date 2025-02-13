Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC41C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 07:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiU2V-0006Y6-IY; Thu, 13 Feb 2025 02:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tiU2M-0006XG-VX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 02:53:32 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tiU2J-0003eh-S7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 02:53:30 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f55fbb72bso8870435ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 23:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739433205; x=1740038005;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Xcq/loJ3vQE2fd/7Vvd4R7SRDzNQCt8Syzl1F+omPA=;
 b=QEt6LF27uYwwBTvAI+Zq6BJnyGNkYZ4ZVDVvW44KNYZfX5BruwkDbWxNZdE4MNf8GA
 x4+JCM1/UZm9Jqrk7aFipqUggqWCN/YSYoPl/KLCqgy6I/Rr8dvX1fu6D3F+5oVzzc9z
 5U3iGLQZ5rC0lcdEUQxdIDhXYcZ0MVY1UFs11aMnRFhGy8F03jAW4J0e0y4+/Swxlldw
 YAGWfevzBcYKUe+3581IuUzqQFaVbUveFOFPaeTlHuHuzTvQtaWzxL2kicnypdKmddXi
 LpxlEJ16x7qPxnHrYbY7XAkW9GlR1S2t28SIzbH7HdItGOQUDoOMadzCKdTCFJnCTm2d
 K3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739433205; x=1740038005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Xcq/loJ3vQE2fd/7Vvd4R7SRDzNQCt8Syzl1F+omPA=;
 b=Fahd6Y2+GEz+arcSm2kfaThIsC+zKg9Ng4YskX/fc6YcvnKVv3QPFuD2dzTU266QR+
 eJRMioEUm8i2qaZJyo8g59PXanNGPwrMMawJsBg/Y0CXZhzPJMrU9pWcyelX+yc7LYLU
 dICmSkd84hRq86f87R0oeR+B2DFt/NjmJt6ygSl6APLawtV/84M5N7cTahdVE+Zuplgr
 j9Z9a4UTBRuGEzGOvuW/X4DDOizA4AQm+buKMn/eGd5Sl8vFuG7gj1zPzLYhEs2mAj/b
 i0Wlk2HYk4ErAw4aXK0/+dH7YVlLSvXhrGp6TsLwvCIvJaWsGzosdIbGsQD+51Z4zP1X
 SoBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOzna6+Cz5BrrJ4t/zqf4uLxsumfscaNTcKfwxufxzkxBJKgBdNAIyECEPaa/SiPm9SvV8mYLYTWVW@nongnu.org
X-Gm-Message-State: AOJu0YxWHVbItKLtv+nF9IIicLP+Z5Z4wk2wrfc0+AbE+QP1IWqTczmD
 o7G0C9dDSVT3DbWcryFWJuQ3/GaZz8Fs6r4VzwCOKpN+UJjUBsIV4Fy52WmviTE=
X-Gm-Gg: ASbGnculaQSj2eqUg2/DJNdkfnWhMnnJvA0tvK7GMyrwE0hS3BbzR5sGu0HHDDtfszC
 SwwT12g+u4I3CdV7VAgdXuB459bPRSHL8Uv7USrn0QBCn08W5aWnkE+aarYVjGpB+6s8u1xSP4e
 RKhvbfXXNmT846MRbXfwT2e7wzf4dzhQMebaZJwI9KZFdmBmt+wAxm20na4xsgHYD1+nV8xaoly
 hx9i1yOJQkLQU/6fTjg/JcB+hpgGREUDL6MMWNlW6bklABpklF5gyNb4n+UH12OuN4Ied//DilS
 RQb3GDvDu5yXJgIu
X-Google-Smtp-Source: AGHT+IF4SlBLixhnvID5sNZIDAs5i3uS7SI0vuUxYbP0oqwZ9fTmemQfHFm9676WtvH17E8gMADlEA==
X-Received: by 2002:a05:6a00:3e04:b0:730:9334:18f3 with SMTP id
 d2e1a72fcca58-7323c1bcde7mr3792843b3a.19.1739433204886; 
 Wed, 12 Feb 2025 23:53:24 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324276172asm676903b3a.132.2025.02.12.23.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 23:53:24 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Tommy Wu <tommy.wu@sifive.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: silent warnings about Smdbltrp/Smrnmi being
 disabled
Date: Thu, 13 Feb 2025 08:52:20 +0100
Message-ID: <20250213075221.622676-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

As raised by Richard Henderson, these warnings are displayed in user
only as well. Disable them for CONFIG_USER_ONLY.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/tcg/tcg-cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0a137281de..4d0d16576d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1437,7 +1437,9 @@ static void riscv_init_max_cpu_extensions(Object *obj)
      */
     if (cpu->cfg.ext_smrnmi) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
+#ifndef CONFIG_USER_ONLY
         qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
+#endif
     }
 
     /*
@@ -1447,7 +1449,9 @@ static void riscv_init_max_cpu_extensions(Object *obj)
      */
     if (cpu->cfg.ext_smdbltrp) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
+#ifndef CONFIG_USER_ONLY
         qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
+#endif
     }
 }
 
-- 
2.47.2


