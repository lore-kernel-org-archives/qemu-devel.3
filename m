Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E62DCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MuP-0006Rv-FM; Thu, 16 Oct 2025 08:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mu8-0006MO-Rm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mtv-00089H-St
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so3522845e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616963; x=1761221763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j+2P7KrD3i0X1sjZ1fqJND7LBgH4Otx8XliirqNS5bU=;
 b=u36ZdwRFYiuQMMl6p3zxTElHM0iEn7XTDzVwWMWHBb91i8iCxvGftng7dhy1lgeq2i
 wiiQ8kWj4Nb7IFU13SFC/sTM/7qAyWK37kKkI+LtVKJchk/FXRbHB3MAKePBTcoL1nuH
 3sCznU5C0ibFxfeki8WayOhQ+ZCJQ+ChePGBWzGrnNGXCV5HvCTmCEoBbSlF5sff7NBR
 N8DqOpFgwKkiteWVTxY7FtjCrAiE6PvpSZf6mrypkLp1CYoM+ixiOCFhmQOzCNVIxheS
 0wBVRAfgIp4+SfsjsLJKTIAOhGnIhTnycG60ibAuY1DktlKvTKSPhRROMYVHszj20w8A
 YzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616963; x=1761221763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+2P7KrD3i0X1sjZ1fqJND7LBgH4Otx8XliirqNS5bU=;
 b=pCFoelbR95Pg5v/TW8xNPdDqgTQA6ijegeCkiI7hdhG6mfQVSuCWK1XVrL51ITQMsf
 JH4D2o86yfx0ySRfFC4+GTAq4MS5vH+r8UIJBfmAtMDFKBRJuRU6LByl5bziziROlsOr
 UqrLP1vpBSdlHoNFu5if/Ta3BV/R7BUu6bJK5TD9IUj4PAvEhB9JB77/Flt9blgmP4n1
 BQ8CgES871w1JrZhJfSZCFZLuP7IL5brA+zCRx1U2Zpoq44i2icS4D2JFElkOTyzMvqk
 C9x/bf2Ca291TplHz3jAtfDoO+HZo0jSks8HbitT2M0U5RzWL+bAed2SLwEDIEmMYIT9
 o+xg==
X-Gm-Message-State: AOJu0YyYZf02e47oHJy+Rcs0hkq1yPbBB0A7ryZL/LOkVx9eICytO9rs
 iEMa31/5GerGZkZT4ngm4gGjUeyUbEz95gv7XCfvpeItTE0FLkDsMyDA0iCEIHHiC6D+JnC0vwD
 +UIKlrgI=
X-Gm-Gg: ASbGncv+SJ0IS/bFks8R3PzAT2UoKb30LIvWgmnr6SeO7Yn9Hg4skw3u3vAv9vUFK29
 Q6Vsq+GEBulPuuI0cGFoguJccp4tnoODV+X1ioQH87v5lPGVO+IUIu1hjZCifEkFnJStf4nqyGM
 KZm8DMJeNpmyI2gNmyZ8q6TuYDJLAWWHqfBz+8XOSbejAFONj1H1S3MVMFOqQEBhy/Pn42V5WJ0
 wZ/B/R6onrrLXepxr4khuEBlgvTjY4Ds3cd5lirg+U/lrLqmQdL/mC0JD98jBtpeSkqy0uQDITl
 8jjqxKiCK+Yq/aZX9jWG4eUDPTt5BlQCcDY5Sk/lBkH5NGSTUHokEiUGzGzAwYoUKonIV8+6R+j
 OvizMLux0c9hI43xiIxerNcNNKl9W+ZmK49bOF2dEM5UU8cp/chceSCK/ZOKqoA7x6m3diik4gV
 2JKEbXdEAzHrSRewfrdl/yGlzHoOIDW5fdVcLjnuPULtz2urAoJBoJPU2OnGwfXtux
X-Google-Smtp-Source: AGHT+IFSUYiZoREWBW82pMjcKYLjL9eLcC5HAhuELeyfOY3OPBEA57Ckwda6IKgda9rEhsa9DIs6Og==
X-Received: by 2002:a05:600c:6749:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-46fd6823e87mr71223225e9.13.1760616963290; 
 Thu, 16 Oct 2025 05:16:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710e7050c6sm21038465e9.1.2025.10.16.05.16.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/75] target/hppa: Explode MO_TExx -> MO_TE | MO_xx
Date: Thu, 16 Oct 2025 14:14:22 +0200
Message-ID: <20251016121532.14042-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Extract the implicit MO_TE definition in order to replace
it in a commits.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/openrisc); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009101040.18378-4-philmd@linaro.org>
---
 target/hppa/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7a81cfcb887..859c6cf5f9b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1691,7 +1691,7 @@ static bool do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i32();
-    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUL);
+    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
     save_frw_i32(rt, tmp);
 
     if (rt == 0) {
@@ -1716,7 +1716,7 @@ static bool do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUQ);
+    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
     save_frd(rt, tmp);
 
     if (rt == 0) {
@@ -1750,7 +1750,7 @@ static bool do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = load_frw_i32(rt);
-    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUL);
+    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
 
     return nullify_end(ctx);
 }
@@ -1770,7 +1770,7 @@ static bool do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = load_frd(rt);
-    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUQ);
+    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
 
     return nullify_end(ctx);
 }
-- 
2.51.0


