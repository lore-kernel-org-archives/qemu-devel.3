Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E10CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDc-0006fi-VG; Tue, 19 May 2026 12:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDV-0006ck-7E
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:50 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDP-0000e0-F2
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:48 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69d42abd04cso1019094eaf.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207760; x=1779812560; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dHHO0+eLtIM55QW60taazGzRUaV2VP4TeBWDtHdLRxw=;
 b=r93FKdaETjGmj/J/SWnT2Mbt/QSs3gwHjvVajDEUztjmZCfEI8Q9dtSx/OWWj8/EgG
 RcZ26sIGopifWhLCDuPRB36NQWK9gqfoo8ktkIAvFpFN5KW3OGBM/T33TECG9EFLH/s8
 qTYm1PikUevfFerzwr3pZDqE5XQd/9oupULvgD8Xb32NHWuX5UZ+tOwKW/+eVTQctE68
 w7+g6G4KT0m2yeLlR5gp6uIFz3uxsP2hsFLzRtJzNteNlfyQsfY6Adtb0SWaQVuSJ4Yz
 riTMtUD22SipmyI17vegMVNsSp7JybEC+ruYBnWdYXbf6Zs3J0b2+/+XepXwLIIExKdH
 mc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207760; x=1779812560;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dHHO0+eLtIM55QW60taazGzRUaV2VP4TeBWDtHdLRxw=;
 b=S0GwSNvxCu7ZiFh762VNyMy2JAf3o4ukRwj6SLANhaZhoJXxoi13gPlmrlnIANGnk/
 A6VtZaMI/8+4pRxpCO5xEHGi0ZO2a1csII3rc9ey8tQDOyiEhxZwZ42FwelYT3Qf2jUo
 vkZyebqqD+hjqS3MnYMV0k/M+jSVhjc32U2WaZCEIjkYCGozX/QnVOxrkxsAfF2WsNGk
 UTX75/xqsHZefTHqPOp+9PjcpDOMJMaKQ67zFw6zkkkacmr4RQgKm+VH3RzmGTUoOplG
 WeWPf1PnLF06k1qMD/Tjw36gaYpjsPY6zaRpKu8UKZR6QchySIAk3Olp6Ie8JpbY52nP
 tp3g==
X-Gm-Message-State: AOJu0YyWJ5wycQrFOJcuuCn1Hl8APeh/oJJUsjWSs8HpxAeor1XY4Ml/
 w7hevYcImbgXZYMr482MSfHiXvZ1kqtGqq6dWnPnf8AuQpIrlOmdiMEo
X-Gm-Gg: Acq92OGhTXfoCdkMWBXVZoiUROR6/E5qJKpgbHdAARWBMPfgsQdMN4fXr76OuxmgdgX
 EKmOsxGAM3g8XJ2Qb5AyKIc44qeM35woVEVVQ9UWhhd/zWQVKkUDNsyvXKgQTIWJInqoQRuZVZ2
 vLwtTV2G9BdzPwp+3B7EtFLTMiniY52B88MTkVUs0p1xz6mfk1KpI7vjYnQS6LDmxEGwNufQwmy
 04EKEvwLBp8XDGpw7UcALYaA/RFdEI4YmMP9LReQCWdtkgOjNsvIm9aKtwYO9MvZjuhdk5a7usK
 Tzc1KWhYmOZQJ5XAPZppiFf712F0iRoZhvnIjt9+5ttUt/c9cRbLJfq5/NoGNtUdj1rW3H33flN
 oyR1neOrusSae8iBmoGS+GhKR/ti1eC8MpJGoH7D+8gaimfRQObFswv+laROw7JVPJjm6yx1s02
 ELTAlzmSA1bRed2CMUubkmKJFxe1hh05mY3rqUW8s65rwTadmp/YL2rDnihjrpB0dk0gPHe38Ch
 o8evuvmLhAeUxdJza1/geM3ULBomwihHns/LtMVkTXymk4MeRgxpCOQCl3KnWWdNGj5cTW0drGx
 QMs=
X-Received: by 2002:a05:6820:2685:b0:67e:36e9:79ac with SMTP id
 006d021491bc7-69c9431b961mr12362273eaf.27.1779207759897; 
 Tue, 19 May 2026 09:22:39 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:07 -0600
Subject: [PATCH v9 05/40] target/mips: drop Octeon zero-register fast paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-5-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc30.google.com
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


