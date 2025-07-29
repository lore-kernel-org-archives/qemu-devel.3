Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B1EC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucy-000173-Vw; Tue, 29 Jul 2025 20:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJC-0004oX-Q5
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJB-0004fh-2y
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:38 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso5934165b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833875; x=1754438675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DZ//QELelSxw3zEngsoJMwE8i1iZC2E4gBdrBvf657A=;
 b=M1kfCaP/wNKnmc8eHwgpS4A1dsPO4tfCKMMRtUp7SiNp5r3ZI0ARbts51oy3sd6xll
 123f4HN5KYgDiUsmXOPvIkzB1yWhULNGMf5XrGTygBhzOTavvL/SpIaH+5380lwEH2zK
 nRpY+Z1vBk6Erj8EF29MX9QSaIskfzbkv3JljgRefOm042FUr4vjE1Lj29lvAg8/cK/u
 SFR04/MY4yG0j3tfGrE2SgmIzVrUchS554li0HAJlVjzvV8ZFtMQLzDFAjXrllmaEvA8
 DcAiLDdXAjZGwoUNPuU7y4DpzM3I7QH5KdzPGnpPCWPcoDvIIr1JsRN8v+wbDerN4nAR
 IITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833875; x=1754438675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZ//QELelSxw3zEngsoJMwE8i1iZC2E4gBdrBvf657A=;
 b=LF5zZ7NufrKKoyMYm5RAXYqVzdvs5wM4BgJx6KlHPswSJUNyVBtDuv6hdW3Jk0qKUn
 YFtrS41Mob376CFBxSslKw2ViOeLGeouNts+8ClqO3Zz2HTTBayrz33rNpDVAFF3JPan
 gTdhEaMhh4LZZp8SSDk86vMXyX/sg4MbMBh4BCBvG71tfJgQ6cMYdUGg69H8+VhDM5aU
 JUgOg0sKj7fgXyeYET5g+67NfC5PltxB4CEa+x/zyRdCOLiUfCehJHnHBfdiPOUggmnC
 5R9qE2d/Mz2u6FaNEZXRlt53x9Iq32fGkD5xZcj+op6mLJtt+wOyYppifpyr7dw3LVhA
 B88Q==
X-Gm-Message-State: AOJu0YxT1GnAju/S3DOrTKVtnbu84AIPW1F8YC/J3nwPFEtchEnNYCiZ
 1XXPlpg69c9gwm2a30cK0ivYJx58vSutJ64I7u9eg0ebbwt2EW2laHAS0/p4oNK94ZdNKnG9to8
 Zp90n
X-Gm-Gg: ASbGncvK3qWKTwfpmcXwUgPeE6wgdrLN3g7hFhBlPBHj6J9ve12IsCOSosC9NWHSZj1
 Z2WavK8bNQEGBBRq+Kc3nWzc4PQvtAnqE8JPhBcWNVyLRcsoTW4LPy6AwLJ85vJNLyFtA4qN9qB
 5BRP6NAc6wIhvcdAHUFYzMgtI/Hz5Ne2SW5eQjy7CHpFiQVqUO1kLoLZV3f0f9lDhdB8sECRBMA
 YAileCZ6G7WkHOnN60XVmw2I4sI/kJ6f6eU5pZ3d48bLlA53nJQpL/FhvVOFQoTJ54zEBj/P/PE
 uPoQ/IZPzXRWoIgs9V0rTFblPK0WnT0QVjClru9CGFtj8+qgsR5P6f1KbS6CaA5SU7hvXNZ0/mA
 jkSojFCof8ef8vISfkcLMJ6gyd0mqYcQZhRKoNrYWh9aJ61qvYVJsnQCJnF6j9vwcRww/AnVacE
 Kfc/7VRERa3A==
X-Google-Smtp-Source: AGHT+IHSkRztpI8MUWq/IsDuH6ZZnMufVS3CSnDseqiL7aKoVHBY/UxZIYk12GtJPv6IO/XNnPj8Sw==
X-Received: by 2002:a05:6a00:2347:b0:74e:a560:dd23 with SMTP id
 d2e1a72fcca58-76ab30c553dmr2237845b3a.21.1753833875451; 
 Tue, 29 Jul 2025 17:04:35 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 62/89] linux-user: Move ppc uabi/asm/elf.h workaround to
 osdep.h
Date: Tue, 29 Jul 2025 13:59:35 -1000
Message-ID: <20250730000003.599084-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Move the workaround out of linux-user/elfload.c, so that
we don't have to replicate it in many places.  Place it
immediately after the include of <signal.h>, which draws
in the relevant symbols.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h | 8 ++++++++
 linux-user/elfload.c | 7 -------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 96fe51bc39..be3460b32f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -133,6 +133,14 @@ QEMU_EXTERN_C int daemon(int, int);
 #include <setjmp.h>
 #include <signal.h>
 
+/*
+ * Avoid conflict with linux/arch/powerpc/include/uapi/asm/elf.h, included
+ * from <asm/sigcontext.h>, but we might as well do this unconditionally.
+ */
+#undef ELF_CLASS
+#undef ELF_DATA
+#undef ELF_ARCH
+
 #ifdef CONFIG_IOVEC
 #include <sys/uio.h>
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1ac3a20813..70bfd18de6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -35,13 +35,6 @@
 #include "target/arm/cpu-features.h"
 #endif
 
-#ifdef _ARCH_PPC64
-#undef ARCH_DLINFO
-#undef ELF_CLASS
-#undef ELF_DATA
-#undef ELF_ARCH
-#endif
-
 #ifndef TARGET_ARCH_HAS_SIGTRAMP_PAGE
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
 #endif
-- 
2.43.0


