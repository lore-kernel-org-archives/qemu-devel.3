Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3E2CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjse-0008VE-H2; Tue, 19 Mar 2024 20:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsd-0008UX-Ei
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:31 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsb-0005WU-SR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:31 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c39579af51so934250b6e.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894749; x=1711499549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukEfuyWQnP9Sb76LI5tjGbSBopWDatLwKjWYccct6BU=;
 b=GyzHEBp6naIADOy44Q+stQboeD7n7ysIs6SiXWyMgr2/GGYImpe7CQReSZo6GbmrQX
 wKhotJu94egf4+iu8sMHjdPgL/mVw0vOq/fRPrOFtpLr6RtertWYdmpdKZbymuI4Z20/
 TBhN6EYdgrhxHOSA20rqARdn4Asn226/41RuRgEG49oXvuF7potEe6Pgr0RAmtNuNAHv
 zXAZZauivVWknZEBIqWDbVtM3r86LVt3qdWGW8BRSnVKOVX0ETzGYgVNmxNejnxKHlIK
 Si7qyxCapYciBWUyHWC3aF16y32Cv7u64LOkcFvh5uspsmsR6bwtV8MPN67/q7aLmA7u
 /OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894749; x=1711499549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ukEfuyWQnP9Sb76LI5tjGbSBopWDatLwKjWYccct6BU=;
 b=pvsy15ynd/oy90IUorIgNgxo+YTZ++ZUKiYCT6VgQSvHWsDWtw6dSZ3rs1SrQIVGRG
 taEtxievAvmXR9TtMalj23ZyOOWVFAz3PIzLHJqBBmWB7HApfNN4RWNZo3pmN8Uzkd6L
 q+fbjItQvqHTmFp0VgWJa6ijFudy6gjQSNDiLEU2XyP1P9lsds1wJqbjEMK0qlSvfa1y
 jhtSe4x44sSE+N8gcmkrauyKzVostMAbiZiejtRhNfoYZsfRvXA8y6guKXsKprUlaF61
 Hdezl3yuVi3lCpdR5lhfZBC4aHOt+/lya76XrJhiBlrsUTeTWhaPpapl+YWJRNCyhGQZ
 I1Dg==
X-Gm-Message-State: AOJu0YxxGrgZoqf/3TlmrHP3wBuVHWQM5Ru9IIUj0i7Aa7AFIajjHJj4
 CuJaAcLL+imP+pkd58VvOjqu+CTCm0eg6beC4hOiLf6r0c+iMstWA+3w5G2O/D09BrXIL8sKv6j
 A
X-Google-Smtp-Source: AGHT+IGEAct/PNd1V5TKiD4xnNqxOtrNxnFeWAFmTcAuYBnwJVr867SwLM12bZiDRA+O9JAktRy/Dw==
X-Received: by 2002:a05:6358:5207:b0:17e:76a1:8b7e with SMTP id
 b7-20020a056358520700b0017e76a18b7emr16489706rwa.4.1710894748706; 
 Tue, 19 Mar 2024 17:32:28 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Sven Schnelle <svens@stackframe.org>
Subject: [PULL 2/9] target/hppa: Fix assemble_11a insns for wide mode
Date: Tue, 19 Mar 2024 14:32:16 -1000
Message-Id: <20240320003223.554145-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
Reviewed-by: Helge Deller <deller@gmx.de>
Reported-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  7 ++++---
 target/hppa/translate.c  | 23 +++++++++++++++++------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 0d9f8159ec..9c6f92444c 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -24,7 +24,7 @@
 %assemble_sr3   13:1 14:2
 %assemble_sr3x  13:1 14:2 !function=expand_sr3x
 
-%assemble_11a   0:s1 4:10            !function=expand_shl3
+%assemble_11a   4:12 0:1             !function=expand_11a
 %assemble_12    0:s1 2:1 3:10        !function=expand_shl2
 %assemble_12a   0:s1 3:11            !function=expand_shl2
 %assemble_16    0:16                 !function=expand_16
@@ -305,8 +305,9 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
 # Offset Mem
 ####
 
-@ldstim11       ...... b:5 t:5 sp:2 ..............      \
-                &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
+@ldstim11       ...... b:5 t:5 ................          \
+                &ldst sp=%assemble_sp disp=%assemble_11a \
+                m=%ma2_to_m x=0 scale=0 size=3
 @ldstim14       ...... b:5 t:5 ................          \
                 &ldst sp=%assemble_sp disp=%assemble_16  \
                 x=0 scale=0 m=0
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cbe44ef75a..40b9ff6d59 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -121,12 +121,6 @@ static int expand_shl2(DisasContext *ctx, int val)
     return val << 2;
 }
 
-/* Used for fp memory ops.  */
-static int expand_shl3(DisasContext *ctx, int val)
-{
-    return val << 3;
-}
-
 /* Used for assemble_21.  */
 static int expand_shl11(DisasContext *ctx, int val)
 {
@@ -144,6 +138,23 @@ static int assemble_6(DisasContext *ctx, int val)
     return (val ^ 31) + 1;
 }
 
+/* Expander for assemble_16a(s,cat(im10a,0),i). */
+static int expand_11a(DisasContext *ctx, int val)
+{
+    /*
+     * @val is bit 0 and bits [4:15].
+     * Swizzle thing around depending on PSW.W.
+     */
+    int im10a = extract32(val, 1, 10);
+    int s = extract32(val, 11, 2);
+    int i = (-(val & 1) << 13) | (im10a << 3);
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


