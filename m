Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C14DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNk1-000844-CK; Sat, 30 Aug 2025 11:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wr-0002lS-JY
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wl-0002ga-OL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:04 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771ed4a8124so2659620b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506298; x=1757111098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6pB83+iwDUBtAVO50FPQo1KzrvptaD1cbooGa5Ri+o=;
 b=FSeDEgE6YbkiIHuW5HBy3Sfh4qKWdUzjisqf/8A9zXmK+i7qrijMSpIxRHctQjIj80
 f3urIyI1dAE+YKpcMgZ6aorxju1UGX9JcSio3rlLm4apKrmdDizYo/VcWg4ls97yWU3W
 FlPan1y82c3Qpw9JKiS7cyCFpMtMZQxVoDlYlSK6OGslWAWF3L4/2OwiHB6vIJVDs2mO
 mgpVoa9HgzR0zpy72fRPnSXa82zrATrbpdzB3t3V9AEl4hOHww3QTpOLaJKHqE3E3lJ3
 KMVbk/uOYhLPuTlBPiZl4/AtlU3nphNjlRIDp23SqydfRCOxg7pThtrVROgdw7RHBVUF
 +YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506298; x=1757111098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6pB83+iwDUBtAVO50FPQo1KzrvptaD1cbooGa5Ri+o=;
 b=pKicnzFILcfElOpPaGd8Tb95WiAWaFI6DaDd13IOUumLrar424GPPbp0h6igBXiRu4
 mqCuSbBvWLH7pEnadkxpf1K6JM47fIzkLC3SHM1VnE61oRVTiTgR/QmThrkUXgWrjRCT
 Yw6yqXnute8nSr2I/q0NBOTZCshLT4W6CxO0+reqD5dj+F6laYwzdYpjBlBtFHEv/f1v
 vNav+hU4YkMq4nv5OUtF2NYaD5lcBJz6WPu7JSgtFo0bSC5LGAE7JWCIQd53vieOqCv9
 I40NtTkKaZz4VpZfMEp4dHQHEXKZo1uqkQTyzP5n236kj0gLF5yaecjAX9v7zPtVXWCH
 sEHA==
X-Gm-Message-State: AOJu0Yz2qznUqsGDRJWNK3V4j+0ihp78JLSNmYZad5grTxRgynduhbN8
 jd2w+hieV/qiJ+VihgPS87tFSksen4eCfsv90lumACkr1EWNnA1yYM4L0OlrqmuYW3VSSRGyPeK
 cvgpQDlg=
X-Gm-Gg: ASbGncv8vV/R/oOQXboxMpGPNO6gkQBCObSliadea03GGlu9gS53Gs0U6VEEBxbDfgT
 7m9LqMilDvVF8db1GM9SOAlSoF/xgXClV1dvTXcCvRw2qxkpqbkYMr9nt+N0YeDvOC8F5Ft2hy/
 PiHaXMBaAZqQroHA7ye5qs4o5F5DwrInXSM2DzIuvduvhLXUEnhdysgkhJKRWrXC4Cj1dlQE/Ng
 wbzFxsAPZK5vvgc+8MMDkCwSU9jrWuDEl1kchj4/ZquGcCs8ihabo+9tMYy8a4+pdwIE/gwcyK8
 7u9b9HAW4MWFgKvYkuLPKsy/Eo26XFjdkLVFQ2ANCIHX+0Ok5FSaqPNY1+4GM0qTtrMZ7IGpqAO
 0kIqcWCt64vMAu9Ts6MwYTYOpk84pWcCycdMOPNRC+OPerr5tDdTygS8qhLF8
X-Google-Smtp-Source: AGHT+IHFjdW7j4hEnZoGbCecLjE1D33TGu8WKwOlTdn1gb0q49TjcVtpsuJ0pLQsyvBDQEi0z3AGsw==
X-Received: by 2002:a05:6a20:938c:b0:243:bb99:a100 with SMTP id
 adf61e73a8af0-243d6f38ffemr331997637.46.1756506298060; 
 Fri, 29 Aug 2025 15:24:58 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/91] linux-user/loongarch64: Convert target_elf_gregset_t to
 a struct
Date: Sat, 30 Aug 2025 08:23:06 +1000
Message-ID: <20250829222427.289668-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 linux-user/elfload.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0dd76937f9..1e59399afa 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -518,7 +518,9 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
 
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
 #define ELF_NREG 45
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 enum {
     TARGET_EF_R0 = 0,
@@ -526,19 +528,17 @@ enum {
     TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
+static void elf_core_copy_regs(target_elf_gregset_t *r,
                                const CPULoongArchState *env)
 {
-    int i;
+    r->regs[TARGET_EF_R0] = 0;
 
-    (*regs)[TARGET_EF_R0] = 0;
-
-    for (i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
+    for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
+        r->regs[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
     }
 
-    (*regs)[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
-    (*regs)[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
+    r->regs[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
+    r->regs[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


