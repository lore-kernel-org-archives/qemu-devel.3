Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3710CA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSc-0003OF-Ae; Wed, 27 Aug 2025 19:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSa-0003E3-9U
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPST-0004GX-BY
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:44 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7704f3c4708so473846b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336895; x=1756941695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYICAl1SaNHyJ2ii9x5dLF1fa3KYu1mSCnjRob2c0pw=;
 b=Ghr3a1cOZTBsPTgQw1GaM+WryRstFC//SdmYYyXFBESCge/o60LzdrRRd/9349pjD0
 epIeShi6qDk62AJIBPzUQgCcQXe+/5iFFPEH/nOhOVwcEVoDhdmgz/RM5brIqDfGBz2e
 mAr26GJDpULcaVuwuPv7i8p+AaYkwjx5ccgG8xUanAQAtU7qZ4v67LToPZD8XQP/n9E3
 EqTzZj6+zzDZgw71vGT5jqtn0VsyrMGHMjcFTpsMz6CATI5NOvrKQU3EpggzknP2Xzhf
 PkiyBCS1SfdxNqpUJJecal3savpUrVLFAFoqi+BL+hEn81sQe9cPFIVz/UpnOJwWvJZz
 f9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336895; x=1756941695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYICAl1SaNHyJ2ii9x5dLF1fa3KYu1mSCnjRob2c0pw=;
 b=CS+Wh+29O2MpGUR147KsDzjP2VuRU0dS+sqElQbqKGgqFZ30xa/EVeczkY1Gle+nAn
 P2oQfG6crRco1gBtTi35Cdw5LGuy7dihDDHsHBIgO6exyeDn/smMpBbXsFO3VZUnAU8i
 6dqkyJcTjYOilVecZgZmKU1RIvQ7O19OP9JcVSWTarUPClTCC6I/2iyjy2GEwkhrBQf+
 YY87RApjWhImscyOiEwAv7u5oy62REsgjjLbhwfLd55OfLRfyAMmqC1soqBri1M3hWRy
 mkMGVqRg3/lmVRsDxDlb/R0wA5CMC5PfWQiv6gzDc4EBxbSAMzUMbjzo56sCEHPgURjU
 KUxw==
X-Gm-Message-State: AOJu0Yzy5F5aQSX82TL3XpHiw6JWprybaWGRf+1+g1to1gMaa7VjH8Yj
 MEifeS/YfvU7xhRlSe8VNf181n9HNnjCbdSlhLa40aiXBExjwsFsJEU4Q+Zeg7oF+2769AgZaKf
 lbAlXCbM=
X-Gm-Gg: ASbGnctLHuaW7i3fTYCxC8IIBTPnNfox6WVsz7uO27zlC1AnZzIrEtT1LONOO5We59W
 0gBRErRKsARjsIn4Ef17JkdEBiK4J5XQN2fNWwF5q52C/irSuEl/siKezKNCv2/afZu1Q1HlTyl
 P9zCKz9fHItHqvMQmKN8yrVuLQWtcoTmvvEwJuSI4Vmn6vDMmsnaPechbT6/2G6qz90ZXt+5q4M
 ukCLdEmqZGrC0a5Y5r3u7C21oxT8G+Xlp8z04PenamdX9Q/F6610M5tZx2Rjlmcx5mgJsBDj1vX
 lJ9B0awaRoHgXrmHyxBc/orHnfhL1d1P8VUQ4a2H+sRq7BsxCR616Oy2LJEhlzRF2g7c+xSw8Ka
 9BuQ0Fi4qOKwLEI5PShkk06ITJw==
X-Google-Smtp-Source: AGHT+IF9ftOub349GivDt4lz+VE49M96Fyc/g71fkodV0xW/HlV2BwTlvzAp2rjRl7kVwJ3SYVK+Bg==
X-Received: by 2002:a05:6a00:3988:b0:76b:f8ee:4eaa with SMTP id
 d2e1a72fcca58-7702f9f150amr26372007b3a.9.1756336895422; 
 Wed, 27 Aug 2025 16:21:35 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/46] linux-user/hppa: Create get_elf_platform
Date: Thu, 28 Aug 2025 09:19:58 +1000
Message-ID: <20250827232023.50398-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 linux-user/hppa/target_elf.h | 2 ++
 linux-user/elfload.c         | 2 +-
 linux-user/hppa/elfload.c    | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 5826ca2cd2..85be00584d 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef HPPA_TARGET_ELF_H
 #define HPPA_TARGET_ELF_H
 
+#define HAVE_ELF_PLATFORM       1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9d61feae30..83cb6731ec 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1046,7 +1046,7 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_PARISC
-#define ELF_PLATFORM    "PARISC"
+#define ELF_PLATFORM    get_elf_platform(thread_cpu)
 #define STACK_GROWS_DOWN 0
 #define STACK_ALIGNMENT  64
 
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 2274fcbde4..9dd3fe092a 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -9,3 +9,8 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "hppa";
 }
+
+const char *get_elf_platform(CPUState *cs)
+{
+    return "PARISC";
+}
-- 
2.43.0


