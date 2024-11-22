Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66DFE6ADCB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVY-0005jf-MG; Fri, 22 Nov 2024 17:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVX-0005ii-Ik
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:11 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVV-0003ix-6t
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:11 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-720c286bcd6so2451311b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315928; x=1732920728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LchKyCC8/lK94Twv/nBZVCfFgzSxUclYfBwVM5ni+0=;
 b=qiY3ISDEcxxVDuIf4khJX4WzHNZVO4McH30cLtplkx2aAARH9/kiWGqczvz6fn+8Ee
 ZuoFR+UWXZhOqZYwJAbAHhO0smQvGl+8IKiUEh0zbxpbAGVGdo6mhnDQctYBvx2p6xPd
 x+LGUlBKcdngDG+P9QrvqB3eZ1Rzs4iFa8DqkpKl4AwC/93PXhm4ist+CYKzbUlbClAs
 hV/w7wqS0cWNpyB+ks7rgKmIfkqCH1T+8e61l6WpWX1pvbfbCd1Pi0SFYcnnYzr6mtC3
 sWQpah9t9fwbTnLsdBd8RMBEE7ZcaeK1XQ7kkh6+AJUBmjY/9j9V8OQBNfU5dlECggE9
 UdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315928; x=1732920728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LchKyCC8/lK94Twv/nBZVCfFgzSxUclYfBwVM5ni+0=;
 b=gwOQIN3ZnxPxuUiRc6AdEWDWGucV8Pe1rxM8mo9W3LJ3eMW8G8xHNAxaBzUeFeljLn
 FJp/Lf2TTBN53XvQg6E58WnOOJIPJuToCxTVXAiUZRzdkZpphM762Do+KTKZezlDEYTQ
 ++cNFsGNaihHDDHYOE3CzCUhC19FElWH7Xt1j7aaOgQDB+ty3Ph3JUkBMCOwUx5TFpVK
 UahbUkMRFgJZuqFh1WwBLB4pYbshH5lxu+DtC/IAfTMUoO022Nxv+3+kv52KUcwe14Fg
 bUwNEt1PNvd1tZ2wCgTARtmyLKNr5LuuQNrv36WRrfFv4slHgPsOxNXQkVUFOiDvIbh/
 21yg==
X-Gm-Message-State: AOJu0YxYFP3m1KL6NawCKxVToZ2J3KKMuXb3LE5xE2/FLxiYAGqk2zXU
 1WRgoqFvWyPlaJf7ru6NN/2U1EfmI5VrnVTPayDTukF5XwtLbZ12NFGqOwLHUuOqY0J3t66vN1r
 4
X-Gm-Gg: ASbGncsnWEVpSSfD2j5HHD9/JjrdcBOUB4x8G/qQ6FwqQdlGcoW+C2NL8EcLCQfRpu3
 EV5Jhrjhdo+vWTU0+5AxudoCN5ErncIDfWZ4Qel+LY/ipWJOy83Lq1/5HhJ1M9V0sJmNLrTjQcv
 /3nQoCfCZORGQu5/P3m3Ys9qyUh9VHP8rEOA/jayYisgb+i/KUyS+J27DuuS2tWqfUgVeBhbxBa
 uN02K1v2lPXU2lev8bKDurFkeM3lk+f5Rj+p8jOFNtYkPZtnmCtk9ZMKupEcJA9cSTvU59b0mYm
 qYmRTpwi54saqA==
X-Google-Smtp-Source: AGHT+IHw8iVN+ZSOv/TEg5Cih/cMGfzTOajDhRYtMu/vMbTv8vmoACzHOunxshdthvNacOue6I0Tog==
X-Received: by 2002:a17:902:f64e:b0:212:4aec:f654 with SMTP id
 d9443c01a7336-2129f7bccb1mr76303585ad.31.1732315927763; 
 Fri, 22 Nov 2024 14:52:07 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:07 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 04/12] target/arm/tcg/: fix typo in FEAT name
Date: Fri, 22 Nov 2024 14:50:41 -0800
Message-Id: <20241122225049.1617774-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/cpu32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 20c2737f17b..4e589b747e4 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -71,7 +71,7 @@ void aa32_max_features(ARMCPU *cpu)
     cpu->isar.id_mmfr5 = t;
 
     t = cpu->isar.id_pfr0;
-    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CVS2 */
+    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
     t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
     t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
     cpu->isar.id_pfr0 = t;
-- 
2.39.5


