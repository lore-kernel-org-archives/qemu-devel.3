Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183D5C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJC-00022O-Fn; Sat, 02 Aug 2025 19:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJ4-0001Ux-2c
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:26 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJ2-00019T-Cc
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:25 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-617744621acso485571eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175983; x=1754780783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+wQD8KFSriNM7oAz01Pl3bRnoCQlDdja1PgR8xrKH4=;
 b=UPlzVgL27vHQqgJr1eBz+eU2WKaPJzAkAqLD1i5KrA0kuHBHn1Vdx+KAD0CHrXpgwD
 pGPl/8MxROYpWDeBjRB1CxSFXcJvou04ZxXLqrKdJ9tczUA/eGJC93y6kLC2nsZAG6Z8
 wJAmqVWxiffDrHYweGf2ha7/0dbeUn7WLIsGiy8GGgvWFwi5cwvi4jyedC8uuoS+WWSg
 MP2GlQd7SRs505adFvqVjge1rXCEOk6l8zJAwGCjy1VfBJl2eb1lyNZgwbnYuOJSoFfG
 lU2ra/JCT2Hz6jvyGRY4djdGy/o6ohHjCh/3pJB85ZzCGFcINqsYhYozyOqER+pAUVJd
 O6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175983; x=1754780783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+wQD8KFSriNM7oAz01Pl3bRnoCQlDdja1PgR8xrKH4=;
 b=H5sxHdnRLLRRo+xFeru3Ant49dtbvoybzy6vD3/4bXxdGc4ymkCqgpc1jWjiAeZlEU
 wL2T0GAJ/Y5+3J61BJcCI18dnwnfbHsPA0CmEO7TRRGJ70gUgetRM5xtCyHIp6O2/TXF
 XOWSldbFrExOvfybNUk7jlvC9K2PEmHVT82lHJOpFMUKD76jJXvK9hUGtxmqwQESiTFk
 oW3dyGY/jOX/HLOSI48c0OSOHVKuD9LrOz1q6ra6bl5hIULmcO9EVPogbjA1WyOsv1ND
 pt/LTE9SLuNuFga/EOJaTC1vFR93NxZ1dMkrd903wn+zXpByPLOiy1UfNX8AVUX18b8A
 pYQw==
X-Gm-Message-State: AOJu0YzI9w+2S7uoef4KBDYI6vHh245dukqChDzY37nAfKAi6V7t16QM
 Wei2LbUl+ICb8AdnxxksH2hB3It/y1Y2+DdoFYaLSh/TmFE1gku+DvDMBLtxubPEdudnjawTGHH
 xDCtxlfs=
X-Gm-Gg: ASbGncuyO8MupLuezSaYznXqSSsOASO8xhZQS26GQF51soIxSiOhlNcluYPVzVnhhb1
 LZ0N3Fzemk9HdpXk+qc3RBRcuDW+mPO3ZUDVRMLohHcwNBesnz9zMPDv5NPWAU9wUh8O+r7zPRF
 mfX9bUoet+qCIMNbYAq9IGC9NGnK/Pwe9/8Zvngv6i2iqnrRVK3XGl990K03QqmICLmcOZw4lwz
 FZ/oOXi056iYjYWjGWxxk1Mhacx6eBRMR/nWSR7Ik5CJDUgo7CVE9fK8DT9XEsyzPpk/rOM/Sdt
 Yi00gP3kxGaCCW0+fS/mYD4/T4DzfqF+FQc9kHJ0hjY2xEL90hGXltoAjAi3w8PFiuMtkZ4fr35
 GGAfrg85lYuBWUiYIm6OmJ+PvYYXtBa9mReK0SLA1zeS0Dq2hpocv2TnFkG1remk=
X-Google-Smtp-Source: AGHT+IEoF+LrWruyH055CS64KU4oVYiHqwPqZEuSWwLg2wkb3Z0eO5RKkhi7D5mVukrfLIciVoEe0A==
X-Received: by 2002:a05:6820:2187:b0:619:9530:87e3 with SMTP id
 006d021491bc7-619953089e1mr2290180eaf.1.1754175983155; 
 Sat, 02 Aug 2025 16:06:23 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 20/95] linux-user/loongarch64: Create get_elf_platform
Date: Sun,  3 Aug 2025 09:03:44 +1000
Message-ID: <20250802230459.412251-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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


