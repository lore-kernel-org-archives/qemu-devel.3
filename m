Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A39C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc2q-0006wW-46; Mon, 24 Feb 2025 12:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2l-0006us-Tf
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:00 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2k-0005Yt-20
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:59 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220d28c215eso72116275ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417297; x=1741022097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcrORcmmH56vrQ4HXfxMOiWFGhxCZ0NEZ8lztnAQbec=;
 b=x2XZBjEnaWkvLeglahouVM6Lkxqq/HvDr3jUn/GZmGlpCXvX0cSocLRhYZ19ifqQHZ
 qnIzpkG99pTiBRQOT4Kt12DkSQySCuGo2S/Qv4gl/8+2eBPxbmdNqgciYl5g81Uz5CNX
 voqKle0/9h9bTOyGYWoji/ouGRxwMZHImFkqWaC6Mlj/Exsfln/fSnBbf9EbrljUqCf4
 ifll77ase4gkEtTS5z/Gmfd8xfMaSyNy2B2WCGf3S3MXEPr2X2uKo3ldJCY01fCat/uy
 G02awSpOPaSgu0nNa79rOyff02MkCSINC5hab6yFbzXbsA4nz0yNExrtju2+80I8inM3
 CYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417297; x=1741022097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcrORcmmH56vrQ4HXfxMOiWFGhxCZ0NEZ8lztnAQbec=;
 b=ovursNay/vq5/PxU2T56N8s7QxLmqQP8NWB9fBOzImpYXCtZxYClCMlbQ4TUQ9mYkf
 zueEjp6P4ElrX/ClQe2guSwamxsQSM2BtG8MNKLdOZOyTs/kmDpzq3eH/hHAn1u8DskI
 P89ZLRw3XaDdzOXVJGOSHZjUUaLA8CBnx4xlx3Pv4wDsoU6PAZzkR1Hww9Pi2Ntq29ZU
 ZxKWuumfZlVYKTYw7keihpVDTA62ikystbfxdeKNZmfmn7/f93pGNL5NpwPMfFTvk2i3
 CtaFIZjBtRLCl38M4mTk+KU4nHAumoc7MRoLqE1ld8xmHyX7XPBCJ92RV9uX8Hm23VI8
 SoCw==
X-Gm-Message-State: AOJu0YxNj8j2cEURGZmLZBMXl52OnuXJf7o/sHZjiro9jS5sodiJszoD
 ASYFvp7YKJR5xx6D/iS7AMNLUcormXoyMUyJnJhYQnVPjTITVJ6iInLum+u3WIGXPFBmtUkmmHf
 q
X-Gm-Gg: ASbGncvcpiiFxMoryNpv5fCnXMDNINuuDcVO1RqsZ2LGlGUbBy/WztzznSZdVDSE8Sg
 llEsFJRdWILPOwlU5VW2JtXT7TW6Nir3VGFuCkdJI/UX4NSzF3rOm13a4zIlv0Gek2wPqNn1WLb
 69+1GeF/9PI8pCDmWpvpFUgd42++9orx/c4VMW5cJJXPzhLzRxeIA5GL38cORG44Ik0Ib2WNmko
 hHvc/uJx1DWDmYeQUXidCvIQ4+KT5XwmVtcDpK3E9lEM2fHOVmamvO4peJgPOK48WcTcgjwtVA4
 oTPezmLmoJx27MYEhYCHynBmBKWqBXOhijM=
X-Google-Smtp-Source: AGHT+IFUHo/5qnPrIyVpHnKUM5ivodzU38kH44X2nj2bTbSax4B0zvGgo2sf03hZWj/H21FW/jb27g==
X-Received: by 2002:a05:6a20:12c6:b0:1ee:e7d0:5c54 with SMTP id
 adf61e73a8af0-1eef3dd815dmr27101549637.37.1740417296761; 
 Mon, 24 Feb 2025 09:14:56 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:14:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 07/24] target/m68k: Merge gen_ea into SRC_EA and DEST_EA
Date: Mon, 24 Feb 2025 09:14:27 -0800
Message-ID: <20250224171444.440135-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

This will enable further cleanups further down the call chain.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d3cfad315c..f093088d66 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -897,14 +897,6 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     return NULL_QREG;
 }
 
-static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                   int opsize, TCGv val, TCGv *addrp, ea_what what, int index)
-{
-    int mode = extract32(insn, 3, 3);
-    int reg0 = REG(insn, 0);
-    return gen_ea_mode(env, s, mode, reg0, opsize, val, addrp, what, index);
-}
-
 static TCGv_ptr gen_fp_ptr(int freg)
 {
     TCGv_ptr fp = tcg_temp_new_ptr();
@@ -1368,18 +1360,22 @@ static void gen_exit_tb(DisasContext *s)
     s->base.is_jmp = DISAS_EXIT;
 }
 
-#define SRC_EA(env, result, opsize, op_sign, addrp) do {                \
-        result = gen_ea(env, s, insn, opsize, NULL_QREG, addrp,         \
-                        op_sign ? EA_LOADS : EA_LOADU, IS_USER(s));     \
+#define SRC_EA(env, result, opsize, op_sign, addrp)                     \
+    do {                                                                \
+        result = gen_ea_mode(env, s, extract32(insn, 3, 3),             \
+                             REG(insn, 0), opsize, NULL_QREG, addrp,    \
+                             op_sign ? EA_LOADS : EA_LOADU, IS_USER(s)); \
         if (IS_NULL_QREG(result)) {                                     \
             gen_addr_fault(s);                                          \
             return;                                                     \
         }                                                               \
     } while (0)
 
-#define DEST_EA(env, insn, opsize, val, addrp) do {                     \
-        TCGv ea_result = gen_ea(env, s, insn, opsize, val, addrp,       \
-                                EA_STORE, IS_USER(s));                  \
+#define DEST_EA(env, insn, opsize, val, addrp)                          \
+    do {                                                                \
+        TCGv ea_result = gen_ea_mode(env, s, extract32(insn, 3, 3),     \
+                                     REG(insn, 0), opsize, val, addrp,  \
+                                     EA_STORE, IS_USER(s));             \
         if (IS_NULL_QREG(ea_result)) {                                  \
             gen_addr_fault(s);                                          \
             return;                                                     \
-- 
2.43.0


