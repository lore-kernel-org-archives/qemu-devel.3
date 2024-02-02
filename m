Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EECC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmTT-0003Wt-11; Fri, 02 Feb 2024 00:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmTG-000389-Bv
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:52:14 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmT4-00028v-5S
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:52:10 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6de0ba30994so344593b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853121; x=1707457921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxeXPbX6hjz+X/sMPb06TGA1YfBXK5OBxElnE5+fhQk=;
 b=aTTRVFbtUh3abWgsKDMitp0GxcizuJ3r723wzdPOlQNPXkyTsy2QN0eBK7O9XF3tou
 H4++dgQDLZ2Yk5j8/z2+I0aSGjRBAugyPz9D3QeepnnXw6wQohQ3eGffautB65KXm0Gd
 RG6fValmWdFYP/wgxGLNNaYk19KZctv/atXAn102lBZV4CdQ9UrPEYDV4NUhNdkH7xc5
 0vsRsuYsbQ9R0J8Fnw9Zb+GT/HcZ2LEGHMbTP69uNqz1ZKQg6Jmf8BYcIZkiTGn8g4Da
 mIT4ZXmeVNDIIOtwjyHlHUSruLVKRGnv/B7bYNa/kraAWX1bIwenD/ax6GymwOiVFcGA
 OSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853121; x=1707457921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxeXPbX6hjz+X/sMPb06TGA1YfBXK5OBxElnE5+fhQk=;
 b=iFtCvtLnK2J3ftFL9F400Goyg78CqhVnzjELs8inSbLK0x254FNpcjGgFWBxtdXha1
 z2pf0WBiy+5IlJkol9E3Ssx+j69Acq6JPNe8VXRmRl9nv001LMb+pRaoeNAsfPwjYepY
 jHO/UXgx2fgHTNit5gueyFqHMeM3rwrCuaZtyStDmmcYj+wnX+NXZzrob1igWCr4cfB1
 t5EcyvhfNb9QoJM9f23ksWCdarq29UUR33FS/ICzTi15tAWmPhhufEtMwXmo+rRG1wO7
 dBcMzGAwIJnZwipLNlRnQeLA6rjRYqDbKXt0WHeK7C1LRqzTmG6ny8+QHOQW9uLk1+HW
 lUyg==
X-Gm-Message-State: AOJu0YyA5WX+LrJoowOIdW2P4JBqJVI3Vl7qUYzewvpdmznniHQYpVlq
 lgOoUOArOnbLp8xGuEbAivX3k7xxXV2xB5f1i9iXwfzYWKBNecR0gwCTUJZAKBqXx4J2WlyQGlM
 pPTA=
X-Google-Smtp-Source: AGHT+IEo3AxLlqY/rOQUXGn/vh1xXLquTT+qBhXvXMs839/3HUI8pICyiWIXLbF0zzVFRQvnnQFjqg==
X-Received: by 2002:a05:6a00:3cc8:b0:6dd:c5c2:3536 with SMTP id
 ln8-20020a056a003cc800b006ddc5c23536mr2073286pfb.2.1706853120866; 
 Thu, 01 Feb 2024 21:52:00 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:52:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 37/57] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for ASI_M_BFILL
Date: Fri,  2 Feb 2024 15:50:16 +1000
Message-Id: <20240202055036.684176-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Align the operation to the 32-byte cacheline.
Use 2 i128 instead of 4 i64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-3-richard.henderson@linaro.org>
---
 target/sparc/translate.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1082aabc14..3a59262c9a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2172,23 +2172,22 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 
     case GET_ASI_BFILL:
         assert(TARGET_LONG_BITS == 32);
-        /* Store 32 bytes of T64 to ADDR.  */
-        /* ??? The original qemu code suggests 8-byte alignment, dropping
-           the low bits, but the only place I can see this used is in the
-           Linux kernel with 32 byte alignment, which would make more sense
-           as a cacheline-style operation.  */
+        /*
+         * Store 32 bytes of [rd:rd+1] to ADDR.
+         * See comments for GET_ASI_COPY above.
+         */
         {
-            TCGv_i64 t64 = tcg_temp_new_i64();
-            TCGv d_addr = tcg_temp_new();
-            TCGv eight = tcg_constant_tl(8);
-            int i;
+            MemOp mop = MO_TE | MO_128 | MO_ATOM_IFALIGN_PAIR;
+            TCGv_i64 t8 = tcg_temp_new_i64();
+            TCGv_i128 t16 = tcg_temp_new_i128();
+            TCGv daddr = tcg_temp_new();
 
-            tcg_gen_concat_tl_i64(t64, lo, hi);
-            tcg_gen_andi_tl(d_addr, addr, -8);
-            for (i = 0; i < 32; i += 8) {
-                tcg_gen_qemu_st_i64(t64, d_addr, da->mem_idx, da->memop);
-                tcg_gen_add_tl(d_addr, d_addr, eight);
-            }
+            tcg_gen_concat_tl_i64(t8, lo, hi);
+            tcg_gen_concat_i64_i128(t16, t8, t8);
+            tcg_gen_andi_tl(daddr, addr, -32);
+            tcg_gen_qemu_st_i128(t16, daddr, da->mem_idx, mop);
+            tcg_gen_addi_tl(daddr, daddr, 16);
+            tcg_gen_qemu_st_i128(t16, daddr, da->mem_idx, mop);
         }
         break;
 
-- 
2.34.1


