Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2A1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 19:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOgza-0007in-Av; Sun, 17 May 2026 15:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wOgzY-0007iJ-A9
 for qemu-devel@nongnu.org; Sun, 17 May 2026 15:17:36 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wOgzW-0006dB-Kb
 for qemu-devel@nongnu.org; Sun, 17 May 2026 15:17:36 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c796163fac5so1334289a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779045452; x=1779650252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zFux4jIuglWnB1aVTd1Rhz6y08uXxkYHIJXx1fdQVCI=;
 b=Ajaka+9ciVWQ3B6DuMxYvTnefm4WJB7BjMMJIE8cu7zK1QIBG0MF5v0MGK6CICfHhG
 TN+vE5wJTV4jknzO3B6SvXQM4jgVs8ZlPk6soXHhrCP8vynUOfKAMGnIq1MjkCUec1dU
 TwxpC+m7iR0ehnLDYn1vGalc4oq7W9jeabuLuvpwUahhJSCtZUVoh7q8bVK7OvM03u4I
 5saambIJnN7qQOfSUoStSnlCAz7hhbL2a0O9BPcU8R8MJFSj892FjH5Yp2eN0Z3irosv
 s8GqOPFyB5/tyxiQ2wFYkLgWhANYZ+T2x/n/98JUQhILjl8gnaT1rrAHc5Bfdrl6L7Aj
 RJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779045452; x=1779650252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFux4jIuglWnB1aVTd1Rhz6y08uXxkYHIJXx1fdQVCI=;
 b=SjvNzUByTmj2E75yF6kswvXn/z+aaCq67CAcQOQbKVK0ktEEK6RyGFR+a1k+6EPa9x
 Ym4NGGODpayPLlgI9xid/rwtpazYeljXjgJJAnH0tkFBS+P+wpVtljCvRyItKcuIgP8c
 gKqCSQVEgcq/USf3Su2Hbbo2b8NT3eC0P75wIHwMBtGESBpanAXASaDUneTET7EGntct
 vwaBPlxwVPm8W0PkHY/OrvRS9Q4IE25HPmvXSWN6KEwBtjRj/c3UuvzM5YMcN/hj82Yh
 7LFIDfHgYpP+x+g9DRBm961mOW2yB+bctu/OzQfVn4nPRhP6UQf3jsN06TqVK9arUYcq
 rJRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8la+ZLRvBzaiV6iDiP9pM3gGngPhoHd67/bnD8MlThreQ3jCfJqyaQcIjIXHkGM9KJmwhoUgT6Cino@nongnu.org
X-Gm-Message-State: AOJu0YzjKJBpBBbr+MYkPqR7fuop3PDwjhvrAPtgjll7PikTFNrkI7/o
 RCaXtQvTsJG/Vvu/lMgaDKdNM3LMV4meJskXLUXuvatsevHF8GA9PPG9
X-Gm-Gg: Acq92OE5//PWACmLZJa9Ov9stLdsfyuuDx2H3FUFp+zrYyXaUGJveM4+oYx32flz07J
 nYCKE0QCx8jFdu+gr4dkQ3xAs7xx1FigddB4Oz7EYHiVP/o2zFdj0MMk88BtmIhsM8TceU6cRBs
 wlO3vrtqLMkxpM+g9bMraZvuqaRKxeeuY0zqsAbsw+ITumPWlZCjxhhTkQH+uvnElqs1KWjlUti
 Wv+tMZdD7j2apNwCZOE8fWQlXU+1Od7btlJ1W/QDR1++qmBahD8BRmEjEXLstoUYHQE6sUN+wnq
 wnfqhdLagm/GowN8in6TkbTssh9X24dQZWDQNFl0BKMkW4wZMC8h/Sj58RRnoUipE40KGXsx/D8
 9ic8asxdFm4vrl6kX1en89/OBawmyhBf7xeBQfw/1LsopiqdfBPSqDrUyFE94CRl8CmjbfY3HIe
 IQo3L6TB7y8bEKHafqAjc2Kvdtlp6wlExqzeEGw7xqoeixIWjmsM8KwQYDojXS6oK7Oy8i19RCD
 msRKljnG3GwbnuTxprU6pGpL35v6XVizbT7rQl5HBRH
X-Received: by 2002:a05:6a20:12d3:b0:39b:e6af:2d8 with SMTP id
 adf61e73a8af0-3b22e7b139amr13864715637.4.1779045452442; 
 Sun, 17 May 2026 12:17:32 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (54.109.81.34.bc.googleusercontent.com. [34.81.109.54])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb0ff0edsm11566646a12.20.2026.05.17.12.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 12:17:32 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: laurent@vivier.eu
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] target/m68k: Fix fmovem.l with multiple fpu control registers
Date: Sun, 17 May 2026 19:17:15 +0000
Message-ID: <20260517191715.3815186-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=visitorckw@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Executing fmovem.l fpstate, %fpcr/%fpsr results in incorrect values
being loaded into the fpu control registers.

When fpu control registers are moved to/from memory, they must follow a
strict order regardless of the addressing mode: FPCR is always at the
lowest address, FPSR at the next, and FPIAR at the highest address.

The current implementation in gen_op_fmove_fcr() processes the bitmask
incorrectly and uses the wrong loop direction for pre-decrement mode,
mapping the registers to the wrong memory addresses.

Fix this by correcting the loop iteration order and mask checking to
follow the architectural memory layout.

Fixes: ba62494483ab ("target-m68k: add FPCR and FPSR")
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Closes: https://lore.kernel.org/qemu-devel/87cxyv4390.fsf@igel.home
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 target/m68k/translate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 138c89d3e5..8d8531b1ad 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4837,24 +4837,26 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
      */
 
     if (is_write && mode == 4) {
-        for (i = 2; i >= 0; i--, mask >>= 1) {
-            if (mask & 1) {
+        for (i = 0; i < 3; i++) {
+            if (mask & (1 << i)) {
                 gen_qemu_store_fcr(s, addr, 1 << i);
-                if (mask != 1) {
+                mask &= ~(1 << i);
+                if (mask != 0) {
                     tcg_gen_subi_i32(addr, addr, opsize_bytes(OS_LONG));
                 }
             }
        }
        tcg_gen_mov_i32(AREG(insn, 0), addr);
     } else {
-        for (i = 0; i < 3; i++, mask >>= 1) {
-            if (mask & 1) {
+        for (i = 2; i >= 0; i--) {
+            if (mask & (1 << i)) {
                 if (is_write) {
                     gen_qemu_store_fcr(s, addr, 1 << i);
                 } else {
                     gen_qemu_load_fcr(s, addr, 1 << i);
                 }
-                if (mask != 1 || mode == 3) {
+                mask &= ~(1 << i);
+                if (mask != 0 || mode == 3) {
                     tcg_gen_addi_i32(addr, addr, opsize_bytes(OS_LONG));
                 }
             }
-- 
2.54.0.563.g4f69b47b94-goog


