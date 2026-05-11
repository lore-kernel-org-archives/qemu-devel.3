Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF9FCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHa-0004kN-98; Mon, 11 May 2026 14:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHP-0004h4-I6
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:59 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHN-0002fb-TE
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:59 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-479d4df9035so3694350b6e.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523775; x=1779128575; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DMtQ6otfSvVpuO6rahx7fwVTGsLSe4NmUYhcy52IxfI=;
 b=fC6y9StAx8Ak1nzFk5pYlgGr6YtwIY50CJhCIZgJ5jwuPdu1jeo2aKJOcIGl4M9gA7
 zK74ei2mxqfSz2aeOnyEGk8w35emjiry6g83wIsa2gPxjRulX0Lt5N1Ftk5V31KAQLZ7
 qTMN1ln0vlhEBV4M+ARisoVUZBwajWR2BYVlx8tZehDHV/INWpe1b2TpNT6wais87ETf
 ge+x5MRxiLUvQgNkS/yrHfEMPOevkwaysZnRz5BQe328JJT0+RLKwExYptV1t5yulXqv
 IEtm4mO+sy0VZ+mLwliS6F/Tvw+1DnhR8j64z1PPSFEXezYkHxoFtWvzPJ5eFsZsiHHh
 OWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523775; x=1779128575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DMtQ6otfSvVpuO6rahx7fwVTGsLSe4NmUYhcy52IxfI=;
 b=NYSHjsa/o0OAqR3Oc6Ct/dNkP2dcajPV44rteCv/8ECQT4zAjDIrzGbgaKtpbxIvT+
 jx8T5puW0YtefG+ok7MF3dafiE+eU9nEjSb/c5hlVOgcwlJXtWnIpqtyXjWaRNnKP0vu
 pqxmXYRCxksm2W8Zgl1bQhKOzKX9gCkA/uA43Mw/RU36RIllS3+wABDaOhOIqMUBo4KF
 Vy6ODhGGzKLorgWxc06PEu+3qIDmHtGLT/Uo+sirzJ1eJwoROmuLLvx33LlXn1SJpMOV
 TkHEr58wH0lGlUnpJ3q0W+q/SEC6ypGZpWMh7PfDj292Vch72R4wypLoR8qU3b+6z7zj
 fd3Q==
X-Gm-Message-State: AOJu0YyWznsumq835GJp7/PWFmYZJ01EVW3mNNpOCHPfFgLIge28OPR7
 Rs/IthZ5Zs3N5CmrN7dwagJe0dhY1D44sp8aOV2aFCdF7pkKUdSf3jqe
X-Gm-Gg: Acq92OEvF5EK9HcFbH1pjHphCuBOr6d5vcJKX2VRjB6ab5zxpUT4pzGjkIaqrdQbshV
 /hQLTvRaqhbC25fMfkQaeicAjcT9R+9xYT353GGCQ3p5mDSaGfpR5KeoYO2f8M8/WK8kX5FTwp3
 R/EeMZ/GA11xLKv4SbSG4/pSi9DzYuvU6lO0ksNESpFAHdVBjPb4Vi3msvR4jILpCXiuSXvOj00
 cbz8gbd5aAyZ4kVReh0CubM3Bm4nkZTASZ6RFnHB3OYXksa3cYbnfOqnK8fi/KlcCAiFDGYQXRR
 2osHGTE2dzK03XSZ/6QSD4wdhcnRO8ybiNJwpnuIwTtXOJ0fofMKUxzWntPaz/LxZET1GFkRIdI
 bT/xuBAnMzJY9ofatoF5Dr2X7eeE2n0fSLWyqcEo9MlBc0GqkGupkjdRNngv/3M6AeWOJlBYfMJ
 JXQ1rXaJvmggk6MbCoVgC20F4QLwFpghSUIlJGpH2NSYjWSNpIqB9ROTyre2gXiJb8sqCr35QHR
 8b/16BpRrNcgmKjcASzWyepIWSt0qcw8PCkhk2Xl1t5wYPyNm3ApY/k/2fWQ4ej2foQ
X-Received: by 2002:a05:6808:a58a:20b0:473:f3c1:250e with SMTP id
 5614622812f47-48293d40629mr280473b6e.17.1778523775026; 
 Mon, 11 May 2026 11:22:55 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:35 -0600
Subject: [PATCH v6 04/35] target/mips: fix Octeon arithmetic destination
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-4-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the BADDU/DMUL destination handling fix out of the Octeon
    arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the rd == $zero fast paths and let gen_store_gpr() discard
    writes to $zero.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon_translate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444a..4dd7626835 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 

-- 
2.54.0


