Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21E8CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjj-00074r-Le; Sat, 30 Aug 2025 11:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7b3-0004JK-Ge
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:25 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7b1-0003Ys-Kd
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:25 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77238cb3cbbso566798b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506562; x=1757111362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44Ix+VHgXVTpI6uZhrpTffYIwF1OKTl8a2mFmzwrnbA=;
 b=OUWxlZeXhQ+OksSL4Wv5+uLAkNRNtx+7SQJgC+Svoqkw/czbOuYpNv2F1uH7VqpNqv
 50JsGbh5VYMwgt/QnZBrYZQYC7+8nQzebNuNzyFvRUrz3KNjZ/BJrao+Wopexu7jT6YP
 gY4+jEJ08OSSMVbU4D9cHv0UVuR5DTAytcupncI70bzYzVoZ0VWs+xpYNqTIok1f8arh
 e4xW8D2pVXfBlJhDX7QjFplpJIZqwoCS5b6FHA+jX/WgwvZCm4p/DnRgqILCBwRCXGrR
 h6EOsSz4Skd5W82kN9q6tXCfeylSAfftxfzkmd73gI9snuP/BW5sxeeqmtla0a9B3yXZ
 grfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506562; x=1757111362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44Ix+VHgXVTpI6uZhrpTffYIwF1OKTl8a2mFmzwrnbA=;
 b=JdhMfGtSD8tWv1r/ThfJjIU0OD4nSgy1mCr110wX1+P2Bb4VUYUZaGmnSVPCnSro5w
 p1xSP4jfa3wu+E+cKN0z3RdlBXYzsJ5gD94cEAY5AJO0vFhkjtKIEkCtmJc/2kNaeJAb
 UObZZWL65NcNUfZm4bXpOHcXgHKAc64j8MmY5mq1Utt0UIEa/429qv6MzOvgv0rtgwWK
 Bu6hnqnpZyTBKzl/z7d8ADPGOvzquiTTUFMzGliwpl2i6qgOMBJ85qOO1kiAjO13eKxW
 S09KNhmHg5JdqDDBISzZLFJS+TA0WMI84mZqV4V8yt43mUyOGQeiwXXP3u/Wj1OzCQIs
 3FAg==
X-Gm-Message-State: AOJu0Yybqjh3zSdcLg4At/+gRZMG25VVaEK0k0W4VP3SIhidbUeGYnpP
 TyQ2h4QBgXFMezFgTvYWBfWXwbya68Xwjf7nPMX68+5vbLxeECE+Qt1V992jWmVonHl7ztAiVmT
 dG/8IyHA=
X-Gm-Gg: ASbGnctSL9qtBKFza4Ky6m3Xk6BDqw0Lnwl1OGb/wckV8spXVXNzvXuIWRmZF1z+C6U
 YVJeeEfdU9z422Y51fF2YUi6tFZkBiZ82Bgp2DDKmEYg4DoBIHSauVH7V+d9ubd6xTUXbHZ7w8q
 wlc6drnPZvlkqpXMB1VJ4IHhupXCuSgcIausUnYyKcUjTRXTVX7DLk5SWOriaUCeKUWW6BLdPy4
 /TqdtSwHEUaGtHRjriQx+raCwcvi7JsyBWCT41d98yn/Qwvn4ROA/6iSYhchaXAUvydA2MXy/ew
 VJFxzQnpDSPzQBlnhzZP/7mtJYSqY0bnwQhDH9vDshhYnl1lQX7QR+wxZTUOMg5Co9ZUi1sMI3Z
 MMl8G59pCBdlSNiK6FVD+fNdzQu0r6gt2smmeoWReze71XK/dYDYaqbDbRHwQipyZvZ3C3ITLQQ
 ==
X-Google-Smtp-Source: AGHT+IGnVXiRIPZQD6tCla+NrBkNO6hf6RTbibcT5TPifnoijN2zqamSCKFRSja+5zU/FWDGzb5FCg==
X-Received: by 2002:a05:6a00:2ea1:b0:772:2869:14d3 with SMTP id
 d2e1a72fcca58-7723e376d64mr238317b3a.20.1756506561711; 
 Fri, 29 Aug 2025 15:29:21 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 44/91] linux-user/loongarch64: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:40 +1000
Message-ID: <20250829222427.289668-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Note that the kernel's uses an array, and then it has a bunch of defines
to create symbolic offsets.  Modulo some reserved fields, which we do
not implement here, this is the same layout as struct user_pt_regs.

Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/target_elf.h |  7 +++----
 linux-user/loongarch64/elfload.c    | 14 ++++----------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 90bca4499d..1f40419af2 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -6,16 +6,15 @@
 #ifndef LOONGARCH_TARGET_ELF_H
 #define LOONGARCH_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
-#define ELF_NREG                45
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 832890de10..ce3bd0c607 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -65,20 +65,14 @@ const char *get_elf_platform(CPUState *cs)
 
 #define tswapreg(ptr)   tswapal(ptr)
 
-enum {
-    TARGET_EF_R0 = 0,
-    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
-    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
-};
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
 {
-    r->regs[TARGET_EF_R0] = 0;
+    r->pt.regs[0] = 0;
 
     for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        r->regs[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
+        r->pt.regs[i] = tswapreg(env->gpr[i]);
     }
 
-    r->regs[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
-    r->regs[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
+    r->pt.csr_era = tswapreg(env->pc);
+    r->pt.csr_badv = tswapreg(env->CSR_BADV);
 }
-- 
2.43.0


