Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F061C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIq-0000Ie-Oo; Sat, 11 May 2024 07:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIp-0000ID-3n
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIn-0006xZ-4B
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:10 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34c8592b8dbso2240539f8f.3
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428447; x=1716033247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m32BdCDoIDtUZU97rjMJn0R/q9fXLMgEs1BlUjCyWs4=;
 b=oB1R5M0vWv1DO3FldvS07YuNfuU8aeyfYlmwc9TB1F9yOgj1Jz1bAf9bhnemvzR6wG
 OV1Sq5KWa3TlENtTuV5eAEkd9fqL+RublvRK2cEOvQD/UiXkvPaptMuJDn2xRHwkTxK4
 Yp1Nxl9ptHCuRF5lbZGCATDXaHF8XZ85b9GvFIOUchBcb/c0W7EiRBDCCXGwpVILsFJL
 BBJrY0nS7an44P6X3ENm7BedLmye3a7mbO2J0jFzBQrOoY4cp1OUNRxdmo/7zYR7uRak
 WmGZhNE8eAbrX2ZFMHdt6lOgqcCPegVh7tkl+r3an55hiHA5rBraB3biDpUbtn+lCGDm
 a3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428447; x=1716033247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m32BdCDoIDtUZU97rjMJn0R/q9fXLMgEs1BlUjCyWs4=;
 b=HUtbRPihMnERShIcp+gppwSKG+0+ipcWNhsH+BiafaMogJvHxeMHiDjFeeppUUNtWh
 2uBJi4cqlH3sKLHjbGyDYZEwNKuAnLv/GKEwqoyPTXVHwa9ZOzkuNek/DhDdMZ56EbLv
 uZauVKTUmrBYI9WrTSjWvjJgciu1lQ36HjIgcpYUfkfTb95WXMkn8OpvqeTfb2rkxls4
 6nEHr2pz6Tn2pGj1ERAm+MhobF+0f1LsG3O0qXOkPZ4hF86rToqzv5/vx5FBgBlWnJ+h
 LclCzdOXXpyGjkn7GuB0FnoTFetFaa6UusHB67GLwDFyA9CuiP18ug29/q1M7ir9PBxr
 k3dg==
X-Gm-Message-State: AOJu0YxxL5K39RBbfpQnvJbBxbjkBQZWNzcU69SIvYs4FSTIN9NEbIfb
 v6KS9+2PBG30VMbsb+rbOixc5gMOHG5ggy1rVNkfjiquK969dkpNsTzXlzlPkBpj2Ar50MMd/np
 8IbU=
X-Google-Smtp-Source: AGHT+IHZMnFpf1Y2GHDVTd0LeF1e7fmOTek+tFrCz8wth4peVTgG+6xjpJnG9VN+1AZ/GMor4fffag==
X-Received: by 2002:a5d:698d:0:b0:34b:2a61:b3c9 with SMTP id
 ffacd0b85a97d-3504a73ece6mr3512221f8f.40.1715428447727; 
 Sat, 11 May 2024 04:54:07 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 05/17] Remove return value from reginfo_dump
Date: Sat, 11 May 2024 13:53:48 +0200
Message-Id: <20240511115400.7587-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

No uses actually checked the error indication.  Even if we wanted
to check ferror on the stream, we should do that generically rather
than per arch.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                     | 4 ++--
 risu_reginfo_aarch64.c     | 8 +++-----
 risu_reginfo_arm.c         | 6 ++----
 risu_reginfo_i386.c        | 6 ++----
 risu_reginfo_loongarch64.c | 6 ++----
 risu_reginfo_m68k.c        | 6 ++----
 risu_reginfo_ppc64.c       | 6 ++----
 risu_reginfo_s390x.c       | 6 ++----
 8 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/risu.h b/risu.h
index 1b87af2..aa8cc22 100644
--- a/risu.h
+++ b/risu.h
@@ -120,8 +120,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr);
 /* return 1 if structs are equal, 0 otherwise. */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
 
-/* print reginfo state to a stream, returns 1 on success, 0 on failure */
-int reginfo_dump(struct reginfo *ri, FILE * f);
+/* print reginfo state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE *f);
 
 /* reginfo_dump_mismatch: print mismatch details to a stream */
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index da221d5..0161044 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -219,8 +219,8 @@ static void sve_dump_zreg_diff(FILE *f, int vq, const uint64_t *za,
     }
 }
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE * f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE * f)
 {
     int i;
     fprintf(f, "  faulting insn %08x\n", ri->faulting_insn);
@@ -263,7 +263,7 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
             sve_dump_preg(f, vq, p);
             fprintf(f, "\n");
         }
-        return !ferror(f);
+        return;
     }
 
     for (i = 0; i < 32; i++) {
@@ -271,8 +271,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
         fprintf(f, "  V%-2d    : %016" PRIx64 "%016" PRIx64 "\n",
                 i, v[1], v[0]);
     }
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 221bd8a..0e179be 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -161,8 +161,8 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
     return memcmp(r1, r2, sizeof(*r1)) == 0;    /* ok since we memset 0 */
 }
 
-/* reginfo_dump: print the state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE *f)
+/* reginfo_dump: print the state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
     if (ri->faulting_insn_size == 2) {
@@ -179,8 +179,6 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
                 i, (unsigned long long) ri->fpregs[i]);
     }
     fprintf(f, "  fpscr: %08x\n", ri->fpscr);
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 18d15ca..f4cf9a3 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -310,8 +310,8 @@ static char get_vecletter(uint64_t features)
     }
 }
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE *f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE *f)
 {
     uint64_t features;
     int i, j, n, w;
@@ -345,8 +345,6 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
             fprintf(f, "  k%-5d: %016" PRIx64 "\n", i, ri->kregs[i]);
         }
     }
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
diff --git a/risu_reginfo_loongarch64.c b/risu_reginfo_loongarch64.c
index 630d6b2..060715f 100644
--- a/risu_reginfo_loongarch64.c
+++ b/risu_reginfo_loongarch64.c
@@ -159,8 +159,8 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
     return !memcmp(r1, r2, sizeof(*r1));
 }
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE * f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE * f)
 {
     int i;
     fprintf(f, "  faulting insn %08x\n", ri->faulting_insn);
@@ -191,8 +191,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
             fprintf(f, "  vreg%-2d    : %016lx\n", i, ri->vregs[4 * i]);
         }
     }
-
-    return !ferror(f);
 }
 
 /* reginfo_dump_mismatch: print mismatch details to a stream */
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 18ae1d8..a53244d 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -92,8 +92,8 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
     return 1;
 }
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE *f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
     fprintf(f, "  pc            \e[1;101;37m0x%08x\e[0m\n", ri->pc);
@@ -114,8 +114,6 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     }
 
     fprintf(f, "\n");
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 486bbf9..fc69805 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -103,8 +103,8 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
     return 1;
 }
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE * f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE * f)
 {
     int i;
 
@@ -143,8 +143,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
                 ri->vrregs.vrregs[i][0], ri->vrregs.vrregs[i][1],
                 ri->vrregs.vrregs[i][2], ri->vrregs.vrregs[i][3]);
     }
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
diff --git a/risu_reginfo_s390x.c b/risu_reginfo_s390x.c
index 9c8fcfd..cbf168e 100644
--- a/risu_reginfo_s390x.c
+++ b/risu_reginfo_s390x.c
@@ -82,8 +82,8 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
            memcmp(&m->fprs, &a->fprs, sizeof(m->fprs)) == 0;
 }
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE * f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE * f)
 {
     int i;
 
@@ -103,8 +103,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
                 i + 8, *(uint64_t *)&ri->fprs[i + 8]);
     }
     fprintf(f, "\tFPC: %8x\n\n", ri->fpc);
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
-- 
2.34.1


