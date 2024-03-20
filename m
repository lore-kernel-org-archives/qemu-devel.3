Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F96C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjsg-0008W1-Ls; Tue, 19 Mar 2024 20:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsf-0008VT-Bo
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:33 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsd-0005Wt-Os
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:33 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2218a0f55e1so3615827fac.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894750; x=1711499550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6aglnROJwkY+5hRbPbUV1QnS5K81iLfR/yfvt3Y7ig=;
 b=yrcXlrTO+W2TJdZ5XB6kQH+fBIt5M/j6SBaQADFN7FsDliwQJKh3Pc6NBBQsTOijGB
 j4aZFs+RNlE+kzFTWWVXEmo58ry4eeJzB8I8IztsKf5tbCDjWhX29bjVJjPP0RW92Fz5
 BnqUKs9caCvXNFcG/qJ6CZnu485j3dwHt5JRkzHDRox82zl4v9FbwenOYP4LqEqakKwv
 VU/O8qY3WV4g1aY2WRBlVajCu3HjeFHcQeF7u4bsqOTBi9+S4CK2aeakQkCLP8GcGmFi
 13Hy5c98pI1mpaFpUV7MoNvCV+9q70IeJdN+0yC/PSA9YCHbD9eWKNm180V8Rvw6HvO6
 wk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894750; x=1711499550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6aglnROJwkY+5hRbPbUV1QnS5K81iLfR/yfvt3Y7ig=;
 b=BsxfYNYFMM9VSgGsf1d7N2SvEB0EkR177J/8Pobc3/044YjKK4xeRhhVFGZezfoEei
 V4TG1izOdYMYDU8pXEc7O4KNlDDgBwPDXUKB5fSYEQTewMkZ1slKUnMLZfRD955B0yXA
 KKtg7kCnuxgvxtgC8yxRxa7eehGl+lMK3BbhjiUqgw/ZA1lEaUpCgovOzl9K+IcUFjYZ
 GsBiuI+kNY9ePeunZe/VG+LeSoA3FVKjzVcxog07c/nqOjdAyXeT3BsEHBJSWrscOkDw
 1oq5kCuRW8eELNWm+qvoybCoq8n5uCigt7H3tRRUUs8Ol8zbEkNqmUqZLVE7oh86wexe
 hOQA==
X-Gm-Message-State: AOJu0Yy1Pb0zjLy7smMlSTys2NfJUj9dHM5+eOXnPEnIQX3xHcfmLBIg
 0faLKYq5a98c38rjqPJ8zJAuzIpRSwAnjy9Jr08wCAMvB/5/RN4RoImeg0qEM/DO77/rwl1P9e6
 a
X-Google-Smtp-Source: AGHT+IGyRbc2nuVtp18kBdkREds0+qPZ6DOrsUiRn+nOR7eFTgEeL03+Z2w48ZAl2Hu0PaNN5QTkmQ==
X-Received: by 2002:a05:6870:4723:b0:21e:e476:9170 with SMTP id
 b35-20020a056870472300b0021ee4769170mr17905258oaq.43.1710894750358; 
 Tue, 19 Mar 2024 17:32:30 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Sven Schnelle <svens@stackframe.org>
Subject: [PULL 3/9] target/hppa: Fix assemble_12a insns for wide mode
Date: Tue, 19 Mar 2024 14:32:17 -1000
Message-Id: <20240320003223.554145-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Tested-by: Helge Deller <deller@gmx.de>
Reported-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 27 ++++++++++++++++-----------
 target/hppa/translate.c  | 17 +++++++++++++++++
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 9c6f92444c..5412ff9836 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -26,7 +26,7 @@
 
 %assemble_11a   4:12 0:1             !function=expand_11a
 %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
-%assemble_12a   0:s1 3:11            !function=expand_shl2
+%assemble_12a   3:13 0:1             !function=expand_12a
 %assemble_16    0:16                 !function=expand_16
 %assemble_17    0:s1 16:5 2:1 3:10   !function=expand_shl2
 %assemble_22    0:s1 16:10 2:1 3:10  !function=expand_shl2
@@ -314,8 +314,9 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
 @ldstim14m      ...... b:5 t:5 ................          \
                 &ldst sp=%assemble_sp disp=%assemble_16  \
                 x=0 scale=0 m=%neg_to_m
-@ldstim12m      ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%assemble_12a x=0 scale=0 m=%pos_to_m
+@ldstim12m      ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_12a \
+                x=0 scale=0 m=%pos_to_m
 
 # LDB, LDH, LDW, LDWM
 ld              010000 ..... ..... .. ..............    @ldstim14  size=0
@@ -331,15 +332,19 @@ st              011010 ..... ..... .. ..............    @ldstim14  size=2
 st              011011 ..... ..... .. ..............    @ldstim14m size=2
 st              011111 ..... ..... .. ...........10.    @ldstim12m size=2
 
-fldw            010110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
-fldw            010111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+fldw            010110 b:5 ..... ................        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fldw            010111 b:5 ..... .............0..        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=0 x=0 scale=0 size=2
 
-fstw            011110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
-fstw            011111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+fstw            011110 b:5 ..... ................        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=%a_to_m x=0 scale=0 size=2
+fstw            011111 b:5 ..... .............0..        \
+                &ldst disp=%assemble_12a sp=%assemble_sp \
+                t=%rm64 m=0 x=0 scale=0 size=2
 
 ld              010100 ..... ..... .. ............0.    @ldstim11
 fldd            010100 ..... ..... .. ............1.    @ldstim11
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 40b9ff6d59..be0b0494d0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -155,6 +155,23 @@ static int expand_11a(DisasContext *ctx, int val)
     return i;
 }
 
+/* Expander for assemble_16a(s,im11a,i). */
+static int expand_12a(DisasContext *ctx, int val)
+{
+    /*
+     * @val is bit 0 and bits [3:15].
+     * Swizzle thing around depending on PSW.W.
+     */
+    int im11a = extract32(val, 1, 11);
+    int s = extract32(val, 12, 2);
+    int i = (-(val & 1) << 13) | (im11a << 2);
+
+    if (ctx->tb_flags & PSW_W) {
+        i ^= s << 13;
+    }
+    return i;
+}
+
 /* Expander for assemble_16(s,im14). */
 static int expand_16(DisasContext *ctx, int val)
 {
-- 
2.34.1


