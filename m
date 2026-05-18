Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5083ACD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqY3-0006tw-0d; Mon, 18 May 2026 01:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXo-0006s6-Ur
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:39 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXh-0003Sk-VG
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:35 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479ef2b78f3so1866761b6e.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082166; x=1779686966; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dHHO0+eLtIM55QW60taazGzRUaV2VP4TeBWDtHdLRxw=;
 b=LEmCuRWQ3PW77Nj5L5XCk7BhfEeT0KT3NH6rdR6qAbpgtKazzlNN6w+e/N1l1HTYnb
 pYNh01w8MLsMtsy7N6QXPDm7n1CGFIrIi5g4tOJWAj32xVrXrgpJ0ruXj+rVj3Voo8qZ
 JgoPAdS8U0sEwrRM5z7GyjV7WGJRngfbNBAmddq5gd9/v/ABXCG2Q6tN82m1Ak8s3k6n
 12jjM93DpjNURBHcXjWNw+3rT/O1k4mt1ClNBixsQLR6qIDB5Ql4DqkNclv/Cvv2eZCl
 Wm9EUyPgEmlsrvHmiaYWLDdb8mXB4pW0ERNmguK7KqIK1qLUWAoR+TGzDen/fVywDejE
 t83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082166; x=1779686966;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dHHO0+eLtIM55QW60taazGzRUaV2VP4TeBWDtHdLRxw=;
 b=N89dj+XzXTZIXr+GP0aBOKfAVYVCDitSACP3Ce4zLfIxK0tMCblvAxcq14T4nUD4Fw
 XCLidwbylmY1JtVQIzOgG0ivTRMEsUIo5s5G9wiaUtTUdlNG7RqvR9RBr26i0ZD4Kmn2
 y60yxqdJLfHQTvOr2LYJi+ybi2izBrY7htgM9CqxFJaCKXyIHjpD1JBBkrWHBbQUUWvI
 O089Hq6OmlX156SKlKv3vMR1QmX9ZKZO+hIuBy6EBFaeUBW9dob1vhFYWqBz4gBdpChW
 dPrLJkGLh/2Ns1mof9psMtUCV6H8+CCtIUufhQddbdcw5EYSE3lJteB5tvFxJhgrS7mj
 ifiA==
X-Gm-Message-State: AOJu0YzXeFQs2krbqvh8U4wPbDrsF5dCLNDN+x/RtLNmDrr5N1WlEQpX
 GwWsMjrweiUus30hPB2nTIcYXjER3FjhnMFGLdrnO6rYiP0fqQBJIFfP
X-Gm-Gg: Acq92OE5G7q+qZGzUwFiEaKm4KJxr3mg0n2PHqzHep9fvQgjKVV3LRg56HiLK3QqSqL
 cM4uKeR4VZ7ANxqqmVTHXHstyTvRKR1hxM/kOJlXtgnLoz9nqtiMAsWtHgOD6M2gddr9n2vDPeP
 ucUB7C/VJKHW8aUAz0SCQMnS0jpzyT/DDZni+l7dRvB2XBpG6QtXJr17N9tvTzjiSy7GhOg2S8h
 5sA7kGzhaNhaitQg4RNeTBJ/9/fmvMn3CHrjrFDsyZaOHLCFO1z/cpEz59+Sn0weizw8swotdQZ
 2bAGDkNnqAy+/Kf6JEUQsLo4P+zU9/XNQbls28jePemPUk6pYWrAXdk2mWKqzt0yl2Z291FArZT
 l7B32rVw+N31F+zqUpjl0zHBxGLOojDDOPl03M8pxmDTftJQIX0W8huUKS/Kwau2RoCpBXpZubl
 +CY7ucAqSNp798VpwqX4M9DBeqL3M3iBic8IQFEmPDrW4cgu3svidTrAOaHc874THFak+IH9rBV
 F8VS3Cq2r0rFSZDah8KHg6eyqsMOF8Fw6r4yd18HGH8HF3pkaT22vw6qaIdFKu7k/IuAkEm+700
 3wgowQ==
X-Received: by 2002:a05:6808:6787:b0:479:fa21:adfe with SMTP id
 5614622812f47-482e55af551mr8728620b6e.6.1779082166366; 
 Sun, 17 May 2026 22:29:26 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:02 -0600
Subject: [PATCH v8 05/35] target/mips: drop Octeon zero-register fast paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-5-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

EXTS, CINS, and POP route their destination writes through
gen_store_gpr(), which already discards writes to $zero. Remove the
remaining translator fast paths for destination $zero so these Octeon
instructions follow the same shape as BADDU/DMUL and the generic MIPS
translator helpers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Remove the remaining destination $zero fast paths and let
    gen_store_gpr() discard writes to $zero.  (suggested by Richard
    Henderson)
---
 target/mips/tcg/octeon_translate.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 4dd7626835..b7531653e5 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -74,11 +74,6 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -90,11 +85,6 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -106,11 +96,6 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
     TCGv_i64 t0;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {

-- 
2.54.0


