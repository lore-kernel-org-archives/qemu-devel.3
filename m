Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F2BC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguct-0000jl-Po; Tue, 29 Jul 2025 20:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ6-0004kJ-IH
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:32 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ4-0004eR-UI
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-769b19eeb3fso1457340b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833869; x=1754438669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B5S3KU2+IEJC2Yz/zbsZ8bGZAzr2DrP1ESEmkaGCKJo=;
 b=FGINStPBvbVqvkSiOlR2j6T1dpuoRvZmDLyRyaj8WhJSwbnlt3mV6plKuWklO3OiMv
 tbxcGbGrV15SpdXs/rwu8baK7lHVQxW4B5y5Q9r5ExXbWHQanaYvk+Qt8j6unq6OcrmB
 8YF4KRXO3vY0ABDjHhOuEo0FkjVaYpVls4r0rxgcC6eyxtOTFFZ0i9QI+Ia8RiNr452L
 cvve855WC3ahnvxlz7t0XhQPG0cFYl68C4C1c5DRhj15rUXleoO/uwvDufRqHVoG+6aT
 uH+KS27z2fpHZpllHW8rCpNFV4clS7CCI76obGWVI6wTOH0Dg5RrMmyMGOOq5/c6hvvL
 qZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833869; x=1754438669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5S3KU2+IEJC2Yz/zbsZ8bGZAzr2DrP1ESEmkaGCKJo=;
 b=wnZ9bwGDVBQE6Z7mWkyRkzywtDXKcKYmqv2Ny/LIl+OL9Iuk0UlG2QrqAij9J5j9hs
 X1GMsLLbbxr0KrXVnq3a5N2kE+a0fpXfAmSEyKY6bENJFnfNCHEJ8INeNVg/esBaU9bX
 MT9s/R5zVivZVWtTJNUZpWmmQ8jBZy09dZLjO0UY1uZywviZtAb6gJ36QbzBciVnOqlG
 lPWIoAiazGWwOro2fK7kNHlDPx7PlWssfzzLuSLBRqmprk3Ixrzd2GaRLbHsI/6lqrX+
 lZYjj1OUlAacUpubSqdxAVSTHSu5UkofanmrZKuW7MzB+wtGrU4wQYJyWOo1imhGArfd
 p38w==
X-Gm-Message-State: AOJu0YwOA0VgUpvuCK3utZDjCO14/M3sXTh6t+vKcU8ort1T4uTjnShH
 Tv6jLEbidGPktiS+s8mVYR6yGI5OFXn5n4sVUVrV0O5EFnvMLzZBBHdK3KngKWG4+Yn0jPNuh2T
 +wQm6
X-Gm-Gg: ASbGncvTFKigiSOWJopuZP5ijGiark0PEZFZzeKR2ryeX4iOOuH9HqXvB7i+DY4jBeL
 DMFOtkuBuOlrC06BfICZwL9RkjdVn0eXE4+6KPYMnTXuLgWersPNtkXaeQJambFpbgb351/zdfu
 FpXTh3xvIoAPVJUdGeXJWvsg7n7r4pNHwgLjhX3E+9udGTXNDEBsC3eBEO0JMkeo0I3jbdnT/V2
 U0HQ2OYZgrCxAf2rMzLUXdv5Z012sJckrbibrDFEEuVN55DXNR5T5+dmOQgI5lyDFSO5KCc7KJA
 kD7H2RHE4sLkf7hFWcn7U7G/9/yK5XoymewCBbgq+MOp5yG5jUyH+ylaDuFWtelZib3kZadKwQB
 mJN8qSD6XxWmuwJsO3KvfxuotFQBLfFGPocd3KaRz3vtAlJPlcjv7euxIuq0O8QSec0CZ6opQlW
 Mh3lYjb05RVg==
X-Google-Smtp-Source: AGHT+IF/nU4ENhJdnMHAjIWN4l4E/y11koS/zqm0M9ZbSReLVGAvnI0qpgLBv2I3S1yPquq7WJZwTw==
X-Received: by 2002:a05:6a21:66c9:b0:234:e597:fe27 with SMTP id
 adf61e73a8af0-23dc0d3e15fmr1563118637.16.1753833869480; 
 Tue, 29 Jul 2025 17:04:29 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 58/89] linux-user: Remove INIT_GUEST_COMMPAGE
Date: Tue, 29 Jul 2025 13:59:31 -1000
Message-ID: <20250730000003.599084-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Provide a weak stub version of init_guest_commpage
instead of using the preprocessor.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8ebde57fa5..01c39bf456 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -158,8 +158,6 @@ typedef abi_int         target_pid_t;
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
-
-#define INIT_GUEST_COMMPAGE
 #else
 
 /*
@@ -1151,11 +1149,14 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 #else
 #define HI_COMMPAGE 0
 #define LO_COMMPAGE -1
-#ifndef INIT_GUEST_COMMPAGE
-#define init_guest_commpage() true
-#endif
 #endif
 
+bool __attribute__((weak)) init_guest_commpage(void)
+{
+    return true;
+}
+
+
 /**
  * pgb_try_mmap:
  * @addr: host start address
-- 
2.43.0


