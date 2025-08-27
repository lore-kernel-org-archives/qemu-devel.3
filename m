Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA38CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSY-0002ti-F4; Wed, 27 Aug 2025 19:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSU-0002gc-JH
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:38 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSQ-0004GG-Ui
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:38 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b4bafe2e538so398247a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336892; x=1756941692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+wQD8KFSriNM7oAz01Pl3bRnoCQlDdja1PgR8xrKH4=;
 b=pA2vRw83hRlUwLpBxs2OgSJ+CK9KiRX4OKvsLA5lZonMeubr34ipL4Gwn9nV+jkJtt
 g8zvHJn8xYcy95dWsAzlpb+GyR1uXzY0nvb4rWF3GPBQLAO04eCLfTpObBv7vwk88uVV
 o4U1R8czzVSHjqp2cuWyBrZrzaw4z/2/6sAZezwB0M1J5IkWe+KC1mlEyvGbvO5uVZCg
 fk3gdDNxFxnCXCXRPFJtuIkQl295d+nZm7afWL/LXPXr89YW9PL7Jvqumqd2Ctx0rAk9
 VuGHA9p1Gqwsg1M/cxr0phqV+2rCxVAe/aHDdVpXs1BcaMpwcvsMUMzr5lFldThKHO9+
 PPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336892; x=1756941692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+wQD8KFSriNM7oAz01Pl3bRnoCQlDdja1PgR8xrKH4=;
 b=QXiqjVS7zoVSh8ythZmpYXLCgLr7cel1qE4+WDXWt5uy4hZcc6Le85oB+o2KDMK226
 FKN6f2UwsqXIsMEbT+xe18kPD0i9Bny50/qwY4foyVkD6BNhJwfPy66lDZdg/FQDWnde
 pYjobv2Mg8L4Tqq824XNFUWlm84CD2qNbT3jg8GL19ZNiHpUTNHsSSywi3SPJghBLu9c
 alj31qay+2uQxIH5OzpaSstplpJHXvLxhNICVNgCiUPBcP3jwN6ONk8xz7/G0wEiQYsH
 3FJ5PDbLujumCK8dPMokoziU3AXETsxODSIkkubd35tKcovmFV+G71f/ncD4YNkGa/8a
 slvA==
X-Gm-Message-State: AOJu0YxeHbCIAw3KJOSjnhYeqqQQlYeiIn+aExNSQ3gHO7nQbv5VjWQU
 Ly/SPNRzT3lxrs0wd6BH8L8vC0bMEtbN7qPrblgP1iK0n4WN835TcAAKsPbHIs5tw/iuODGOsHD
 XJErx7LA=
X-Gm-Gg: ASbGncu3wP+Smh4I32Ou3BhY81n6hnbKbFqgg+uXX00a1SIZdHI1C1hjCIQRgbOTfmY
 WyoNOc41xmv9xCEx50lrrMGyxX0jVJsTuk276Gkz0DNti34vV2W0OD/AwyjlyBEhgewVADwwS4C
 GalnDrsdB6ekBx7CK7lrzRBKnpG5yNpdy2FkwPeSzO2+kfHIE8kcwGtPqFAJVBAvK2kcMmPg1Rn
 8xjOqBhucjk9eyoNs1Aj13hPyd/AB7F9+CMiLDQq9c2R3jRQIug+aBYTg1Mp0rq0xzk3BMPRqZZ
 ByqQVWViQ+2FgEwnWK+WCQE0AG3VJ64BtT8BGO8oSNwtkY1buFm6CEgFtUZuDzqDFiJeNM8HvTC
 5dhxboJuNHl6rSBvnplUyHUrK3iPmiXCLLvKN
X-Google-Smtp-Source: AGHT+IFL9iI/oMZZ7QGteguoPCTFtpUimd+oMCT3prXZpC9JU2Uxax+3ALPdlpf6vudEZiq2nUcWMw==
X-Received: by 2002:a17:90a:d403:b0:327:7334:403d with SMTP id
 98e67ed59e1d1-3277334435cmr5220840a91.26.1756336892256; 
 Wed, 27 Aug 2025 16:21:32 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 20/46] linux-user/loongarch64: Create get_elf_platform
Date: Thu, 28 Aug 2025 09:19:57 +1000
Message-ID: <20250827232023.50398-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Move the string literal to a new function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/target_elf.h | 1 +
 linux-user/elfload.c                | 2 +-
 linux-user/loongarch64/elfload.c    | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 037740d36f..eb17927325 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -7,5 +7,6 @@
 #define LOONGARCH_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_PLATFORM       1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0e41737cf1..9d61feae30 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -665,7 +665,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_PLATFORM "loongarch"
+#define ELF_PLATFORM get_elf_platform(thread_cpu)
 
 #endif /* TARGET_LOONGARCH64 */
 
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index ee4a85b8d6..911352840f 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -56,3 +56,8 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 
     return hwcaps;
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    return "loongarch";
+}
-- 
2.43.0


