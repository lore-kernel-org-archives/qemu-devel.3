Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0212C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIr-0000JJ-E4; Sat, 11 May 2024 07:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIp-0000IO-Sx
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIo-0006xn-1L
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34db6a29998so2132056f8f.0
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428448; x=1716033248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+n0y7sg4pr7eYBOPDNRNBiPuUSQ+dV4I1QimEXAPgY0=;
 b=C3i/Sm8L8fgcpfcGbXbup/T+72Vh1BcR7CdYP7UPkDqhSodM3sA2bLfKhgq/bXRS4i
 Esy3X+PASjmGBkTM6rKo5UTSuUZUdUpcEh8hQ/f9Ht1fS9lwQdx44yW7O4amMayv/cBG
 7A2t9ASX/FHO5O7x4RYoOGZMYeyaHfB1AMIbPC0zs9hjzjPHgYLclGNDKE3LHYzbX2VJ
 lCenVMlNV7Edw3Eb9rFQEnbAmJjosPfV8E66jwSjAGvCBhtJkhZbLrdHZGT8dpq5HsjC
 To72mLEKqi5TP19kIGwrv/vHtx3EtlzcxQzoXl5FO2U+3waN3QjlqgSuDcEveT7zqcug
 RFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428448; x=1716033248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+n0y7sg4pr7eYBOPDNRNBiPuUSQ+dV4I1QimEXAPgY0=;
 b=QUekZzpiceJAwlzl6gjeo54vtVjoO2coHTTt7tIBCMmjtuixg0X1gEWagzaqrNXN4M
 0nQpjOrgh17mUba3MqkDAdW53N+tFYc9+n45HEHhQJIFT4/FxiFiBhc4a+XN72TDBYlz
 UvKt4bC8j4dOB9uYn2fFeW2vHlKcR1jXtSzQTEu7+Z24ombZJ+om/uMsptYbBD2hSV8l
 3iQXyt2HZ0SD8oyfey5jyGBEPs+STt1K5iNzAULC4wxS3lWd5KCTHSdjD93dk8kAS9Ko
 e2j1Gj8gAlYrS4fB5KzmTlP6xZlgIAJtEsBEtOBcqBcQeN0g1h+OHtG6gz7aNEwG0M/a
 0PJA==
X-Gm-Message-State: AOJu0YyXhkfCRCeYZrCrnSxvE30Paloev8vWKC9ik1vjqGplnkvpewAY
 HbnNDF1ioEgNZfInQ4/RIo4opvh7sAhcb6pmJLTOFzLaMEQP9KLGeMIH8ZlVIXakSjh+GyeSjW2
 Rmnw=
X-Google-Smtp-Source: AGHT+IGx8YpfbvnPnWHEJERLk/6K4MJFluddbQifr6adM54r+UsZr/q96TL9w3O1eyszFA7uP8tJug==
X-Received: by 2002:adf:ec4d:0:b0:343:7b6b:dcc6 with SMTP id
 ffacd0b85a97d-3504a73bc6amr3813189f8f.30.1715428448496; 
 Sat, 11 May 2024 04:54:08 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 06/17] ppc64: Clean register values in reginfo_init
Date: Sat, 11 May 2024 13:53:49 +0200
Message-Id: <20240511115400.7587-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

Smash the stack and thread pointers to deadbeef, as is common
for the other architectures.  This allows us to drop these
special cases within reginfo_is_eq and reginfo_dump_mismatch.

Do not copy the unused special registers that are packed into gregs[].
Most of these are related to system instructions and thus are not
manipulable via the user-mode instructions targeted by RISU.  LNK and
CTR are not initialized by risugen, and since in general we cannot
test branches with risugen these can be ignored.  This leaves only
XER and CCR as the only special registers to be copied.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_ppc64.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index fc69805..67ea3ce 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -44,16 +44,16 @@ int reginfo_size(struct reginfo *ri)
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
 {
-    int i;
-
     memset(ri, 0, sizeof(*ri));
 
     ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.regs->nip);
     ri->nip = uc->uc_mcontext.regs->nip - image_start_address;
 
-    for (i = 0; i < NGREG; i++) {
-        ri->gregs[i] = uc->uc_mcontext.gp_regs[i];
-    }
+    memcpy(ri->gregs, uc->uc_mcontext.gp_regs, 32 * sizeof(ri->gregs[0]));
+    ri->gregs[1] = 0xdeadbeefdeadbeef;   /* sp */
+    ri->gregs[13] = 0xdeadbeefdeadbeef;  /* tp */
+    ri->gregs[XER] = uc->uc_mcontext.gp_regs[XER];
+    ri->gregs[CCR] = uc->uc_mcontext.gp_regs[CCR];
 
     memcpy(ri->fpregs, uc->uc_mcontext.fp_regs, 32 * sizeof(double));
     ri->fpscr = uc->uc_mcontext.fp_regs[32];
@@ -69,10 +69,6 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
     int i;
     for (i = 0; i < 32; i++) {
-        if (i == 1 || i == 13) {
-            continue;
-        }
-
         if (m->gregs[i] != a->gregs[i]) {
             return 0;
         }
@@ -150,9 +146,6 @@ void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
     int i;
 
     for (i = 0; i < 32; i++) {
-        if (i == 1 || i == 13) {
-            continue;
-        }
         if (m->gregs[i] != a->gregs[i]) {
             fprintf(f, "%*s%d: %016lx vs %016lx\n",
                     6 - (1 < 10 ? 1 : 2), "r", i,
-- 
2.34.1


