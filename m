Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB564CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lfi-0004fI-9O; Mon, 22 Sep 2025 14:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfT-0003ux-O4
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lf9-0004xN-T5
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-279e2554b6fso9432855ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567199; x=1759171999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRMGkSahDRDIyhY1Pf+KcfrLPaCj+CJxCc4+NBDjs/c=;
 b=EXo+I5c5dou7oUmx/J32POv8Ej+lwIHgNq/lQsyBZwU2EElDu9udEUT5eFXoVoD9H9
 CPSmZ0u2NSElDO3gcwZg8j8tnXatJyGsYA+EGSdgatTP4U4n49VztwYV5CwY0kvHC0Hy
 To30ggaYdlh15t85VqnJoqiBzch+lOZC7lXEdoHpmRsgiTNIF623hF+2CZ3DjMZP1UgG
 ltNaDlB3mPgNU7rRiyBQ8KxG5pocs9Wj8vMP6xEfYAwjjWVLpbuP1CDWZL2N3T/BQwx/
 IZaoB12TMPWX4w6JVIYZp9BKGMVwAg2pkkRW63L8lKqnq7UhJQF+A3Di6Eo6Cc1w+0z3
 /8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567199; x=1759171999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRMGkSahDRDIyhY1Pf+KcfrLPaCj+CJxCc4+NBDjs/c=;
 b=wy13fx88IHydDTQF/edZedGI/nNFk2wjgn+jmaJcuXou6B+7HYMztovqfKLSv7KGii
 leu4f/9vdVKdtiFjlZ5U5sJOKIH80ZADU+u6RkRiPiy8gxlhGlS/M/z2sTYPLbMuhIMJ
 ZV5X9ZtgKG0Vb8WkHzb/YPmRStmrge9iWmOZMjIIRAehxbgEdzLz60W74i8UoTQkaJN1
 OM7ms4zPPub8l3NoYzOd7vl1PujBJAxbqPRsuhEzWye2wOSprWfv06XHbJCyiWqxUg+N
 BREsHfqNPpMjXUe/lWL0NQEJWfsMFjPpjvPkEk93AH95aQUe7S44W9Yq8C1fOYrCpdhk
 hsiA==
X-Gm-Message-State: AOJu0YyLvvtye/AeN8D8P1fCP7q9vjNlqnYTzkZZuirJrKRG/W6Ievel
 CJTxYe/wxytTuRiOploXgW8jO3HccVgTV83MAg1a3A4lnwgKpA48A7AlAybp19wb6TzMhZuS0uw
 af5RA
X-Gm-Gg: ASbGnctJ8hxQMUnXjbQGpIEBJAW1hEA/oSncx0CEN41TgMRelYuXY8ftsQcDFyCf4oh
 y+mOFm6wwKaB3WPn6Ty7pr/1dXqMvuLPrV7mOqV1J0Lvhe4k8HwHnlYeDLk7h7sEhvDh/NEFSDZ
 gitBrAUgax4bnIDE/JoqQ6ARLlg4g2HHIwv7mLTbP6Ex1MtwKR+wif7t8go9xMDtPQz+dw5wjUf
 lfLz9nQoMZIcPCAp19+Z1450WluIlyldLRAEx5o1d28PamY3GRXOrBGzHqcPywzW/OEZRNGNxwr
 e74nFf0TRAiYHj3JOl7Io/Lpu41DIcF47HwjfCuCExzF6Qr8/lcALvQDjo7Wmx3r/aGkniKVRPy
 3GlRGFEFITWgaqQMgIAh4UWaW0F4EpcXHuCwnWW4=
X-Google-Smtp-Source: AGHT+IExyq1klN3I6uzuB/YJNf++Vp8JA6G2zCD5/7hU3EOr4Brz+R0bFXwQK3i5cXT7IDyPOLHl1g==
X-Received: by 2002:a17:902:ea02:b0:27b:472e:3a23 with SMTP id
 d9443c01a7336-27b472e3b6fmr29636145ad.14.1758567199079; 
 Mon, 22 Sep 2025 11:53:19 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 47/76] target/arm: Emit HSTR trap exception out of line
Date: Mon, 22 Sep 2025 11:48:55 -0700
Message-ID: <20250922184924.2754205-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index 78d26aac04..57bc8ea4c5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1774,21 +1774,11 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
 
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


