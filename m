Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97CEC9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhatq-0002sE-Uu; Sun, 18 Jan 2026 17:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatV-0002K8-NR
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:22 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatT-0000p1-Du
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:12 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c47ee987401so1508587a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773909; x=1769378709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5sBU2zk1bX0ddl3O5KkamyL/V1clpqH1xPWvT/iVmQ=;
 b=ORzOjGSU8J891NIHhvMVlVDzpY4cvCf509ECb4mMuMNxRJcsHuX2PYtbuDVg7rLbDM
 SYGgqIZSOTbOjYwqYrS7f/+gWCi7pJ2rwwSuLxx1Sb3QsQ+ZuHuAcVF9pR/CRQgmdEMD
 +TAdgWUHJKDLW5t4PkX3TTdt2wPzXplh/zyMv76STC9EnHENtblLm9Fh0kqW+iungWgB
 V2SJHxn3tM/BjAjxhsAZ/QemLZAGOq/fKbhwfUb3CIKR8unnjRp4a0rSR3zMBeYTPXRW
 FFbXfDZQtuOyNByBQ21pgvkB58i6jFcD50Ri0eNN3VHxzBvDvjhX1LvhYHIf3re+LG89
 ccPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773909; x=1769378709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U5sBU2zk1bX0ddl3O5KkamyL/V1clpqH1xPWvT/iVmQ=;
 b=u8dt6IWvEaBnAnneqZgc08NSWVkOLezyO054rwYPkrS4P7EJpjQHHPqr3RPrP5vpVW
 2NDZk5O/sazMVG/AWDBTay0ZupYRX5IkLsqFhWig4pV+39mugFOaNUM9wueTNW+SwR2J
 ntzLNLGy/chqEIlOKM6wZtQrBFFlCPeG1LuRGhAc+mxfViC0SwEe//QMwdjxRGQWmL10
 0qRMxVlEgKJnxBylZcR8P9j/yrWS42S2LGmZhIVZxC3Ec+8HPTH5MbVJgDYM+jEsTFK3
 XRGWMeJRhG4LttaO/6/GlPKFDkczIHX+vpBVvFCqC0HlzKnYDXev9rrbeL2XfR9KXgDT
 rWaQ==
X-Gm-Message-State: AOJu0YygIuiEU6kXAZt0QwlzVWJ2CRCZoENzm0MyXCDp2bAgRG7LS+ev
 Dnz1jwROpBlQF8UnDsLf2zSk+jBHCn57wBDhZ19H2Hw+U95M0Zr4ILfuJDa6/jDe5i9qAt3ftHq
 IstKwBwszDQ==
X-Gm-Gg: AY/fxX60pGmhTR5TaI7Fkez/tWe1WK6eaw3TK7ACA+helbKUcFIEhAgb73D2BMWVrQR
 9Ft6dgYK2kewU9EkL3G6G8LEWaSwue1jqBaJ0kmPZvJXPuH31dTPldPe6Ldnfd+8z4vST3Kel/2
 FyxVNkbUkb2jwi4vlDlTCUO+FnpceRsb3vfLQpq21/XnB3eJakDLFqvSSYfImPMBZ+zzALoG7VZ
 CTNuxg5ke+FtQ3g8LRx3ulsvUEOzMxZtk5xemE/NwYUURkjd/lvYHdS7SUsqmCoga2YKYhPgpk2
 Goa9DJe0RGUis3nRJNwgDeI3VCAcX8WkRnoqO2/jDjf6DQ94R8E7tNjfX4G8kVRhB6Dz24Ir4WB
 MzlDE1fPTwartlzzkhiKgWwYFxc/qLcjOwKB0NgtXEswwW7sgjGCBeT06M6pjoIvNuksj5ZtHFI
 1qUxSrldNB2ad8r4vhGQ==
X-Received: by 2002:a17:902:f545:b0:294:8c99:f318 with SMTP id
 d9443c01a7336-2a717546704mr92985575ad.3.1768773908923; 
 Sun, 18 Jan 2026 14:05:08 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 20/54] tcg: Replace TCG_TARGET_REG_BITS / 8
Date: Mon, 19 Jan 2026 09:03:40 +1100
Message-ID: <20260118220414.8177-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use sizeof(tcg_target_long) instead of division.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c                | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 4 ++--
 tcg/ppc64/tcg-target.c.inc       | 2 +-
 tcg/riscv64/tcg-target.c.inc     | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 2d184547ba..9c33430638 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -607,7 +607,7 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
     }
 
     /* Otherwise, inline with an integer type, unless "large".  */
-    if (check_size_impl(oprsz, TCG_TARGET_REG_BITS / 8)) {
+    if (check_size_impl(oprsz, sizeof(tcg_target_long))) {
         t_64 = NULL;
         t_32 = NULL;
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 10c69211ac..c3350c90fc 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2604,7 +2604,7 @@ static const int tcg_target_callee_save_regs[] = {
 };
 
 /* Stack frame parameters.  */
-#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define REG_SIZE   ((int)sizeof(tcg_target_long))
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
 #define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
 #define FRAME_SIZE ((TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE + SAVE_SIZE \
@@ -2731,7 +2731,7 @@ static const DebugFrame debug_frame = {
     .h.cie.id = -1,
     .h.cie.version = 1,
     .h.cie.code_align = 1,
-    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.data_align = -sizeof(tcg_target_long) & 0x7f, /* sleb128 */
     .h.cie.return_column = TCG_REG_RA,
 
     /* Total FDE size does not include the "len" member.  */
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index 3c36b26f25..b54afa0b6d 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -70,7 +70,7 @@
 #define SZP  ((int)sizeof(void *))
 
 /* Shorthand for size of a register.  */
-#define SZR  (TCG_TARGET_REG_BITS / 8)
+#define SZR  ((int)sizeof(tcg_target_long))
 
 #define TCG_CT_CONST_S16     0x00100
 #define TCG_CT_CONST_U16     0x00200
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 0967a445a3..76dd4fca97 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2934,7 +2934,7 @@ static const int tcg_target_callee_save_regs[] = {
 };
 
 /* Stack frame parameters.  */
-#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define REG_SIZE   ((int)sizeof(tcg_target_long))
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
 #define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
 #define FRAME_SIZE ((TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE + SAVE_SIZE \
@@ -3114,7 +3114,7 @@ static const DebugFrame debug_frame = {
     .h.cie.id = -1,
     .h.cie.version = 1,
     .h.cie.code_align = 1,
-    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.data_align = -sizeof(tcg_target_long) & 0x7f, /* sleb128 */
     .h.cie.return_column = TCG_REG_RA,
 
     /* Total FDE size does not include the "len" member.  */
-- 
2.43.0


