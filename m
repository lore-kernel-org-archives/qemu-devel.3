Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077A3C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMgl-0006ss-5b; Fri, 24 Jan 2025 11:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZa-00065Y-3O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:28 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZR-0005pi-KC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so15095615e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736204; x=1738341004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ol6wjs2XXi3PGGKevFQFr1g6AWQeoCb1SFBUJSxPQd4=;
 b=MUsfNPJSrZyJxcIonXbUjb0dIzlMxExGBMzarZ9q0XS+IL+rnBcgs8gHzjFlq8x9Wk
 hVH/BE3ecc0xAJRnX2UNxu+OUtCUUrTFwGjz0rZBSHnGHIjzeWMnDbOj6llzT2UZ5jeT
 UTLaFwXHR8w/1/x2vTXYMIDBqI/DBFhgOkNYq4kx8NSVdiMDWpCR7YjwsOhWR3+W6n4J
 HGDxapOwzFEX29IZ0cF2Cb+Uz9dClEtOr8i/zhrKE5LEMoRj95ETmFDMG7btIhv3HIjL
 8Kp/BS+yAJ0sKvvsn2jUTDY6Vq8JoR711Mg1U32+EQ+8yJyMBRhSqvzUu/KPLutGHx9u
 n2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736204; x=1738341004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ol6wjs2XXi3PGGKevFQFr1g6AWQeoCb1SFBUJSxPQd4=;
 b=nh+ZXKA9Pv6+tlIzxuSq0J6h61VGjn52qW5Ie7dzwUc8anyhhhSmzwxKG6DsRyIPOn
 PfRYMb7BDGLL1wJl6kQVyj2NbQM9XShpK2ASHODL2irrBbEocCmSru/mfF/m9rTgPwaP
 vXPX4LrqT996hoHC6vLkCbkJOwo1MgHdolT9wkayyrQO+0MLMpL/TO2aF2N6TmW/h4+T
 w4xYDw9/HTBgF3LS/7mv2vzxXuoHAA51fjrbaM6iYmIIGqSu9azCo34vvqrGwumGYgxQ
 tl/RD061FfPYxskx+0E/rMb/HBNldnBwRtutsn++z7zQvuJiOQMik+Q7z/a3xauR46du
 8Oow==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7+F3+TzVuYpZKnx85nrSdck1bqi/TPCATRKHuJx/QeWb4DR9eaxj8Pi2FVExedbu/8x7B6bGO4I4L@nongnu.org
X-Gm-Message-State: AOJu0YwUftB9xp4a24ctav7OnLc4vNLDYEJKQOyitNSkjiTH98FLNMSS
 CJMkXSLotDMzrdY3H90kKGmvOuL3Beev2e9BZzLva2rbVBi0f1FUOYmbHTDQwyc=
X-Gm-Gg: ASbGncvaMiE5QjoG9T6IHIG+ALdLAnzZdq+EngbPjvEtyCQ46Yri7SlSSyWyVkfLWXN
 qS+Q+s9cj0bPVeZZymgulAn2gVdcnLT4B4KQNhrCA7Blc+bumZ3y9P80/R3OjxLnSKkRx4meKjw
 dF5d070h0UQ6iYqtC4oRcADP1TIJW4TbqpdZ76aBhppCto45vcbf4cl8iW9vCi5bya60s1R9rl+
 YhGrvm93qKmhhJj8K6BnQzKXtDINFr2f8AJk3I7+wERhi5Sgb52A2lJQ8nLAcAGsrc4LQXvef3I
 66WKCTMN5Iw=
X-Google-Smtp-Source: AGHT+IF5hA9n2rJMvLf6grf5UwAAQPLeQT8uiOk9QNzLK7gsHkQPTf8akXbaiMRaAdskRRjl3PlcAQ==
X-Received: by 2002:a05:600c:4e89:b0:434:f739:7ce3 with SMTP id
 5b1f17b1804b1-438913cb518mr283514855e9.8.1737736203723; 
 Fri, 24 Jan 2025 08:30:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:30:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 68/76] target/arm: Enable FEAT_AFP for '-cpu max'
Date: Fri, 24 Jan 2025 16:28:28 +0000
Message-Id: <20250124162836.2332150-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Now that we have completed the handling for FPCR.{AH,FIZ,NEP}, we
can enable FEAT_AFP for '-cpu max', and document that we support it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 60176d08597..63b4cdf5fb1 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -20,6 +20,7 @@ the following architecture extensions:
 - FEAT_AA64EL3 (Support for AArch64 at EL3)
 - FEAT_AdvSIMD (Advanced SIMD Extension)
 - FEAT_AES (AESD and AESE instructions)
+- FEAT_AFP (Alternate floating-point behavior)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 93573ceeb1a..0bc68aac177 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1218,6 +1218,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
     t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
+    t = FIELD_DP64(t, ID_AA64MMFR1, AFP, 1);      /* FEAT_AFP */
     t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
     t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
     cpu->isar.id_aa64mmfr1 = t;
-- 
2.34.1


