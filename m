Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE36AC87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLpQ-0008Az-8N; Sat, 02 Aug 2025 19:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnC-0004Nm-GK
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:36 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLn3-0005tt-VQ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:33 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73e88bc38bbso1153130a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177845; x=1754782645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UYaNg4HgCgaMfA5VDdSs+JLi614JTEFfBBOaKuI9nc=;
 b=Zsag0+7plfiu6d33/UfqWFJcGnjXQoG2ZoXDSax4OyJCszjI+m9HXoGPCmzcx8n+Zc
 wriBvLowjoJIC//fhcvBE+t546wzkm1+hRs8BFgHxCp8RGnTnaXOrl1M3fwlGWb/meHQ
 63uH/rm+VXq7mw5mNIXZEWkiZueaTyqKdvesuqOKtyGrMK8xtTHsBNf4xoRJJGFVvlFO
 KnMUo18Rb/TFcKz8satbgzGugShfyp1ZJiRc64pKblErR+vMzReKLOu2xuOYMTLp2eCA
 VM1bSbkhMfkPV+ahsbZ2wzUiciadPGhrZYjSQMeHEqqr8H9wjG8YTMS82C7ihNPIMgT/
 Ycwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177845; x=1754782645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UYaNg4HgCgaMfA5VDdSs+JLi614JTEFfBBOaKuI9nc=;
 b=AItb7dBk7MfF+UxofrLAI4wLFOU7ChARUx5eabW93P2LOd79BbqPieTQ4aJ3Z1JKkX
 a5ZncRaRz4trI1ZeXARTcCPTppLf3Rp9dpoBiT/Y/yn+PVvmXbSX5ltFtilYUINcHFJw
 P9cHk4j33iRC7fZ82u2DBNCw+J95z/ww89tPlthFdIwtcyCOMHiomkCZjprE2zPedn9R
 wQBxDYppqgzRoWexSRkJkxDTh3pvsZRw4oMx7K30g77ZgMQ4sEppkkfLGATbQpeOJRGh
 d/A+8fuMBL+bblWuOZtmO+mWT6Yq5fXjq/lSNd9mKfO8QFfj8Cas1aUsCBlJPlA3gmE2
 2Wrw==
X-Gm-Message-State: AOJu0YyZpY5dui08H9yF59RS2KvUw+ldUOKWs6C2BoEAB9hqPCz4cb9w
 J8Pj8hr3Ea79O54VPA1o9cDsGVhCm7xEXaW1dlLJjHl7pquljuqITVBp+l0wkZllUMm+f79dkSy
 xE2Tv8Ak=
X-Gm-Gg: ASbGnctV/ceLiclqUr5Ro9uvjoTljUucGqGOXgQabT44m9+J2HQglFjLpdotPzTlI18
 kK5bh9HPfin9lNkxqrnDCCDgdY54y4OSd4hidR+t0KOL06bPMOd1sYfTzHMjTiwyohiPfv7t+Z6
 1gDP7BWsgZakIqzD0yBarkQ8D/rTxmU7Zg9zOh6hZ7bpo2NOj1QK7BbuUfChyBXORUP3Ktla26d
 ofuvLCQm5XLpHhIDNkEpLnCdx6VujiC354oBuG3z3jY58Ln1FdttjspyQifI4odXUS7U4UyO1lv
 5EzdSrkGSsrU7lrMJ19UPdaZpIXa0aUu6KCGLjscAvMrr0eTBKZGZ25yhbToZHYasb9JnOgjWUA
 fnpFwDcG/VRcgnpvtuwE0P1ExHxVViDwHDiXfYLAvkU+6V2qhadgi
X-Google-Smtp-Source: AGHT+IHKIfci5+yeHTN2LwNVSz9wmI34VB4fSl/XWAJJxBkB6a8QEUPA3VHuZE7MyK4FgIUxsqGbqw==
X-Received: by 2002:a05:6830:6686:b0:73d:6f86:f256 with SMTP id
 46e09a7af769-7419d1f66f6mr2975789a34.17.1754177844928; 
 Sat, 02 Aug 2025 16:37:24 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:37:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 55/85] target/arm: Emit HSTR trap exception out of line
Date: Sun,  3 Aug 2025 09:29:23 +1000
Message-ID: <20250802232953.413294-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use delay_exception_el to move the exception out of line.
Use TCG_COND_TSTNE instead of separate AND+NE.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c4dd3a747c..f6fdfaa551 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3033,21 +3033,11 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
 
         if (maskbit != 4 && maskbit != 14) {
             /* T4 and T14 are RES0 so never cause traps */
-            TCGv_i32 t;
-            DisasLabel over = gen_disas_label(s);
+            TCGLabel *fail = delay_exception_el(s, EXCP_UDEF, syndrome, 2);
+            TCGv_i32 t =
+                load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
 
-            t = load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
-            tcg_gen_andi_i32(t, t, 1u << maskbit);
-            tcg_gen_brcondi_i32(TCG_COND_EQ, t, 0, over.label);
-
-            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
-            /*
-             * gen_exception_insn() will set is_jmp to DISAS_NORETURN,
-             * but since we're conditionally branching over it, we want
-             * to assume continue-to-next-instruction.
-             */
-            s->base.is_jmp = DISAS_NEXT;
-            set_disas_label(s, over);
+            tcg_gen_brcondi_i32(TCG_COND_TSTNE, t, 1u << maskbit, fail);
         }
     }
 
-- 
2.43.0


