Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B86C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIE-0006h3-SZ; Thu, 28 Aug 2025 13:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXg-0001By-3v
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:53 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXe-0000Kz-7T
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:47 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b476c67c5easo625104a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383345; x=1756988145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ehuepqbbm1Pb/ucVF5IT0BiMjGQDJEiKUXOOtANgHtk=;
 b=DhBT56EXoOv/V/CcOTZKNbHkaGLKTTn2nA+Z5Zku1xpkWzj/El3Ux/ptiUaPvo0BH6
 6kKGha+ODS2y0Lf2zowC9KOtKShAWh+XIVYZVtOXAxkFZW3m7Fqh/QO7iPD3zU1wuPEg
 tqayZ2pl7Pbk5kYPUlPyRoGIBsNzNvalBIZ5Oq8WIr2jI1gOvGcsi6c7oJPdvHhuHLsc
 TKxmVnVbij6PJM3daza9M6p3yTs9UPnkDKntBV/jGyxPuIrbXmr6seySGIe+vGkx8qnu
 6J5TxVN+Lrl60Y8YBxEDRiYwls/nIpAsQAeqhawOxMioX+bKq9UrMDWu6p0CLQcrRWHN
 GcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383345; x=1756988145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ehuepqbbm1Pb/ucVF5IT0BiMjGQDJEiKUXOOtANgHtk=;
 b=C2eXX5qBXCoeEBoz7oI/r6FEYo9kj6b//88k4vLWA5O//hWLN/+k6id8UQkTZoJfsQ
 UIu1+Npk9ZOfk8hU2Z0tVLK6OBwaXKwO4GHp+JOpR6Iz3OF/9tGtNZdg9o8poChPM1cz
 ORc05fBQzfJVdAKj/aXZ8Mv7eHhqH8BY0X7i6xzmTXxXim1f1uKdO7/Ttx021krQf58k
 XDfa9dM7Qdgaeix/hWAoma9zEj+XhaUooi8VaHZDmsV/bMGBEnTlo/JJHHhBRI4UqEJj
 HaHpcdIyc64rTX5FHjc2Ddx0IOPEWWVXKoy9MA2YWyzSLSHKRnVwfSvrqP1mNXC8jY5L
 g6VA==
X-Gm-Message-State: AOJu0Ywy1tigjogSbPm7HGz7+fGZga4rinQsvY/S84EK3Q9HwKQ2ofiz
 wjmNL4BnA26YTSGAvb3me2xv0b/4sP+CwUEfVBMa1DLKtMx8AEMGVCdR7qQITCCc/dH2FMo9Yp3
 B2988Wp0=
X-Gm-Gg: ASbGncv0dxV5u6NW5FQZofwvN2iisfoYiywLqfWAiQCd01/rLQjPgMvwFaCqZ7tRnLj
 Bso2SoZzUd8+t3irCTuB5OUqiCAAByV/13jUUbg+3FXZbEoN6NWSD1fprIR7a0zqBMcjKB64Orv
 5i6YupBQM88l9OMpJUfOs4q6WUdaiMew/gtaY7cqZAQNJQIYUlXWJjjt654CbB0FiaMtZr7fFXL
 Po28umPqMKbx4gaF3HWwHyr0Emlvt9xzL+llYSl5u12BsPLxtxeUFzMU2FmRFLiNhhoGlLArGAj
 482OYb6iomdSsauI5pSzYr312r12CUerPcT5/4ApksD1MWez2wSsip65KVot5ssUqAqGPhpd0bO
 3mpBAFm2fbVnooCW33kNsA6qOLYJC1UaElMNA
X-Google-Smtp-Source: AGHT+IGnYOgiZgFUBmexVpXPbW+GyWuvuonPWIMc+8JZjmJ0YTI2c5spnaAnReUGa8gRtiBJDdeezg==
X-Received: by 2002:a17:902:c947:b0:246:50c0:ae8b with SMTP id
 d9443c01a7336-248753a2457mr119845495ad.0.1756383344713; 
 Thu, 28 Aug 2025 05:15:44 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 76/87] linux-user: Move elf parameters to riscv/target_elf.h
Date: Thu, 28 Aug 2025 22:08:25 +1000
Message-ID: <20250828120836.195358-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/riscv/target_elf.h | 10 ++++++++++
 linux-user/elfload.c          | 14 --------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index 48d9af557b..51b8def1d1 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -8,6 +8,16 @@
 #ifndef RISCV_TARGET_ELF_H
 #define RISCV_TARGET_ELF_H
 
+#define ELF_ARCH                EM_RISCV
+
+#ifdef TARGET_RISCV32
+#define ELF_CLASS               ELFCLASS32
+#define VDSO_HEADER             "vdso-32.c.inc"
+#else
+#define ELF_CLASS               ELFCLASS64
+#define VDSO_HEADER             "vdso-64.c.inc"
+#endif
+
 #define HAVE_ELF_HWCAP          1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 705d726922..6e476d5308 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,20 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_RISCV
-
-#define ELF_ARCH  EM_RISCV
-
-#ifdef TARGET_RISCV32
-#define ELF_CLASS ELFCLASS32
-#define VDSO_HEADER "vdso-32.c.inc"
-#else
-#define ELF_CLASS ELFCLASS64
-#define VDSO_HEADER "vdso-64.c.inc"
-#endif
-
-#endif /* TARGET_RISCV */
-
 #ifdef TARGET_HPPA
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


