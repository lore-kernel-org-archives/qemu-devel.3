Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0673DC54798
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 02:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgbRw-0003FA-FJ; Sat, 02 Mar 2024 21:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbRu-0003EN-MW
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:19:34 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbRt-0002zM-5L
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:19:34 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso2774143a12.1
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 18:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709432372; x=1710037172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiPhLFQiO4QN9hKUgYGuIcZ2MtHj3Vm7HTpPgirxlrI=;
 b=Ra8icspqLhv0v+KWLFeh8NhwIWBmiIyLbhz/Q+E6+DCnNjGKqV9QE8lGbHTABTFiJF
 CovR+xKTt7xCUKURWxOBrUBi15YBIjW19hp4Xmbo7MDN2YZHtTIjOEWKaCKP6Q63qSfY
 shNA5XSyxIZLmdsp7xvFnC/QUK+nUzaQWtEkR4+3/YiH9IWCdKn8+SoVMKR7L5LSc0A8
 OncYMBuSFm7b3bbrTaDhTw0Bhs5nieM23gssw6Lj2t8yc1wyTvBStLRMuXRAykS7mVj/
 GgxCB4dGFKTCbGGtpEdtnd01Ki/VsKxC5j/jo2kCe4iJKlWQHpL10hnc6sCejBvE1qAF
 tBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709432372; x=1710037172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiPhLFQiO4QN9hKUgYGuIcZ2MtHj3Vm7HTpPgirxlrI=;
 b=qLiFHP3dBSpOEPt2E6NI5fsj60pEua0o4OdIj1kzAjptGKgcYaD7Jkusl00li3N8cG
 gfFBOcKQrN259EzkvOXNEkXGBuZvh0lMzrNiJn61iwQBc7cGZcX8jbnKeGYpqFaYUTag
 YQmdwUKGHL4UprkE49L/96GQfm3+UUacjWP79EYylRmn6w3lAZHMR0hyriSpBjVvvqUi
 9oK0g+WLgO08+ARqJ/L76KX77uU1ciIT/qxdQk814UN7H9mmHoljK/djoY/SaSYopBoM
 k1FAbGPIngdpDfElnNu7sKE2V8bfBKB1ylVezFSFduv5B28CZ36u7qL8zlgHgdsJBAvi
 fKKA==
X-Gm-Message-State: AOJu0YymMuNr41VH/vRraThuoaAKP5qXWCJC02YH1h4RXKdabZFFo6fn
 Cjujp9K1LhFalMmbr4qqhrGtX1SrLt+WhcMwluR3CGjEekbpDvUMwiPCfspYmD005d1pUk7G2Tm
 e
X-Google-Smtp-Source: AGHT+IEUD4xkVhh9bbj82cx0sNYO6tp8ec9PSJIrvsE2r08ly0Kih6mmRsbJRXB/mnyoUPhfTLCuow==
X-Received: by 2002:a17:903:41ca:b0:1db:d66e:cd15 with SMTP id
 u10-20020a17090341ca00b001dbd66ecd15mr7469958ple.59.1709432371835; 
 Sat, 02 Mar 2024 18:19:31 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a170902dacf00b001db5ecb2899sm3512578plx.162.2024.03.02.18.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 18:19:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH 2/3] target/hppa: Fix assemble_11a insns for wide mode
Date: Sat,  2 Mar 2024 16:19:24 -1000
Message-Id: <20240303021925.116609-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240303021925.116609-1-richard.henderson@linaro.org>
References: <20240303021925.116609-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
index 585d836959..6dcc74e681 100644
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
+    int sp = extract32(val, 11, 2);
+    int i = (-(val & 1) << 13) | (im10a << 3);
+
+    if (ctx->tb_flags & PSW_W) {
+        i ^= sp << 13;
+    }
+    return i;
+}
+
 /* Expander for assemble_16(s,im14). */
 static int expand_16(DisasContext *ctx, int val)
 {
-- 
2.34.1


