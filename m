Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33F0C25B5F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIu-0000Kz-Rv; Sat, 11 May 2024 07:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIt-0000KB-6m
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:15 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIr-0006ym-GR
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:14 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51fc01b6fe7so2986530e87.0
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428451; x=1716033251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2krjFClQtt6ewuvoLiaCYVCPhv1mkrudW+d9ZYqpvE=;
 b=OuDha/HbAEvMAA/AZ4WjmBozPBkAaxl+vOZP+yE0egI0+VhUriHSSm797fzs2RJUd+
 XohqjRmbDRVl6Ze8YVQc8GkL5W3xsTiizV5RRfCDNc0M1FtHy05FazIa/Dj//XSz1nrM
 46EvoVA0bsbd0wB2uTKXVeHEGqK7wEAk8deHPgc3uyO64nuMXU73307U1MTYexqVS8MB
 kUPj6N9i4PD8L/nWy9d1qF+K+Vhq36FH2H0wN004zZNp/35wUz9DZnPS87xEMeWMFdGF
 UcW3QvIf71N+4QmkPhf5o1Z0QrvoQnRESY9UEVjpPKayOGym6Hse/q3Fp0egvuiKk/zm
 NBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428451; x=1716033251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2krjFClQtt6ewuvoLiaCYVCPhv1mkrudW+d9ZYqpvE=;
 b=KJ37eT8JqqOTjbINpJ8KT1XOqU27Ldg6ZSv6ex/wVx9Curz2/pd5xALW6Yh720xLDc
 rFrOEpIvTDxuIfmIaTzyQPNIYDkXPaWprhmfhGj4S7uXJsDh4KX71h8K/gHbtlQqyCqV
 vlHaw/5ZqrVq4VJFYSzW4iPlF+trMK9MS/ShooLqijgquSmUk9VkYGGRY40EyAzKx6q/
 taV3rNIlj87IPpFeLfvXA0Lc2wDpRuYnS6KfnUcrDp1BSA1J4nynyxl0um1o2lLRZA6Q
 Gsil/9br9t6gRQcxsyoGqGZ9yY1cfkyHC/Eg1DMervl2MkMMyXlVUWd4dDSBT+LRrwqP
 FmBA==
X-Gm-Message-State: AOJu0YyD+t/RPZrGioCwKmsO3gDna9zqhZPWTXZdK3Gctux4gpyw4ZrB
 9TGuoNPP1tY2/EQLdNNeNcL5RQywtDcwXq8M7bkm6bEs8oV5DdVLE29xJiGJudpYiYxSb5JPd+L
 Rws4=
X-Google-Smtp-Source: AGHT+IG6l7v4tIhLFQzBgJn9n8SIws77LlPkOfBOoN8fvoy1RRLSV2j0oMlilu5Mn1fgv1j34oKzhA==
X-Received: by 2002:ac2:4831:0:b0:51d:38ee:ddda with SMTP id
 2adb3069b0e04-5221057932amr3200192e87.52.1715428451509; 
 Sat, 11 May 2024 04:54:11 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 09/17] ppc64: Clean up reginfo_dump
Date: Sat, 11 May 2024 13:53:52 +0200
Message-Id: <20240511115400.7587-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
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

Dump only the registers that we copied in reginfo_init.
Improve the formatting and layout of what we do dump.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_ppc64.c | 51 ++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index e0c650b..730a565 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -75,38 +75,29 @@ void reginfo_dump(struct reginfo *ri, FILE * f)
 {
     int i;
 
-    fprintf(f, "  faulting insn 0x%x\n", ri->faulting_insn);
-    fprintf(f, "  prev insn     0x%x\n", ri->prev_insn);
-    fprintf(f, "  prev addr    0x%" PRIx64 "\n\n", ri->nip);
-
-    for (i = 0; i < 16; i++) {
-        fprintf(f, "\tr%2d: %16lx\tr%2d: %16lx\n", i, ri->gregs[i],
-                i + 16, ri->gregs[i + 16]);
-    }
-
-    fprintf(f, "\n");
-    fprintf(f, "\tnip    : %16lx\n", ri->gregs[32]);
-    fprintf(f, "\tmsr    : %16lx\n", ri->gregs[33]);
-    fprintf(f, "\torig r3: %16lx\n", ri->gregs[34]);
-    fprintf(f, "\tctr    : %16lx\n", ri->gregs[35]);
-    fprintf(f, "\tlnk    : %16lx\n", ri->gregs[36]);
-    fprintf(f, "\txer    : %16lx\n", ri->gregs[37]);
-    fprintf(f, "\tccr    : %16lx\n", ri->gregs[38]);
-    fprintf(f, "\tmq     : %16lx\n", ri->gregs[39]);
-    fprintf(f, "\ttrap   : %16lx\n", ri->gregs[40]);
-    fprintf(f, "\tdar    : %16lx\n", ri->gregs[41]);
-    fprintf(f, "\tdsisr  : %16lx\n", ri->gregs[42]);
-    fprintf(f, "\tresult : %16lx\n", ri->gregs[43]);
-    fprintf(f, "\tdscr   : %16lx\n\n", ri->gregs[44]);
-
-    for (i = 0; i < 16; i++) {
-        fprintf(f, "\tf%2d: %016lx\tf%2d: %016lx\n", i, ri->fpregs[i],
-                i + 16, ri->fpregs[i + 16]);
-    }
-    fprintf(f, "\tfpscr: %016lx\n\n", ri->fpscr);
+    fprintf(f, "%6s: %08x\n", "insn", ri->faulting_insn);
+    fprintf(f, "%6s: %016lx\n", "pc", ri->nip);
 
     for (i = 0; i < 32; i++) {
-        fprintf(f, "vr%02d: %8x, %8x, %8x, %8x\n", i,
+        fprintf(f, "%*s%d: %016lx%s",
+                6 - (i < 10 ? 1 : 2), "r", i, ri->gregs[i],
+                i & 1 ? "\n" : "  ");
+    }
+
+    fprintf(f, "%6s: %016lx  %6s: %016lx\n",
+            "xer", ri->gregs[XER],
+            "ccr", ri->gregs[CCR]);
+
+    for (i = 0; i < 32; i++) {
+        fprintf(f, "%*s%d: %016lx%s",
+                6 - (i < 10 ? 1 : 2), "f", i, ri->fpregs[i],
+                i & 1 ? "\n" : "  ");
+    }
+    fprintf(f, "%6s: %016lx\n", "fpscr", ri->fpscr);
+
+    for (i = 0; i < 32; i++) {
+        fprintf(f, "%*s%d: %08x %08x %08x %08x\n",
+                6 - (i < 10 ? 1 : 2), "vr", i,
                 ri->vrregs.vrregs[i][0], ri->vrregs.vrregs[i][1],
                 ri->vrregs.vrregs[i][2], ri->vrregs.vrregs[i][3]);
     }
-- 
2.34.1


