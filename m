Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7456FE6ADCB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVY-0005jY-8E; Fri, 22 Nov 2024 17:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVW-0005hn-Ag
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:10 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVU-0003iX-R8
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:10 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2124a86f4cbso24693275ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315926; x=1732920726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Px0xDe5+quVoadfeWboWHp/rKvNNinVDrxKYT34EqKI=;
 b=LBeX3KNcTdRY1AxxdzwRdlDcFIslatyw4AmuDPzB1ivyvbC7Vlyit2fCPL0PzMPOZt
 DZQ3iIaDRLcx1+uNWOokh5s3O5Xrx6174v+zWKjOWnABi1F5zxLnaQgukrZ16Gr55oxy
 WR9B2OdPLf33CzuM6zmiMi2TRrNyKBTOXI7flNasn+D9+bR6q2swtot9sE+r60+K8gdK
 58f7bI/ZoxA1dTNsPjG5J9a6vHLv5MV66JveC9Fj93bx2kXSUVZpVdKdRKyLurzcM0MQ
 kfLMyZAeGAJ3Pg5vhwXEkKAVeK5wtTWTUm1lYMn4UPrivCX5BbUtfpVvPOUlA+WsAynT
 I7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315926; x=1732920726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Px0xDe5+quVoadfeWboWHp/rKvNNinVDrxKYT34EqKI=;
 b=pZxMUuEKig0mjRf3/hfIesHCjVckzlPm4maR3Va5CTyRXrhSAXBu35GAeNl9oR8o4D
 PMhFswTuM+sCX20QjCSu90GVCkvN6Co3AgFpyj/MzV4RjKNJzUwYC4vjTH6331N3/lEC
 3qOneLfMTMi/Thao1eeQ3+mny74OOsdS/OQnhamNTEmk8Ys+73DPCSji/jm5zq0Quchw
 x/DTYDCMqQ4rtip9yJSYkNZw+4jPjnahtQfGczmVXBLne/MhT7hisQobA6oFrX5Ydg3k
 TvGF6cGREnSmZIyGX47+NsSCIk7zCzUsQ41VRZbHhk40Lq9IKMvsNt5r70XXgTHJPykU
 HV+Q==
X-Gm-Message-State: AOJu0YxkZ9TucF6bNFU/o2rMN/7DadqbCtmESOYCiBJ9ZWKKKPE3BObw
 a8Q6CmKt0YR9OyBchi+G84uk9zVrrS4kWwNXm8ZOix2eiFfOOo6ddrXJRNke0sAF9Hb7A2LlIOq
 C
X-Gm-Gg: ASbGncuZHvq3/9lBE0xpCjzxSnhcIp7FF6DeqvB+sKvN1REEM1JofFbTs+RF6HPYU8E
 08LUd5fzWH8d9ry/E82eW2/F9h4SjY2Wf+4LCHSijMcnmjfafPsJEPYAGUGVHWOtwWFUAABsnsa
 3BwFw6b7rxVxkK0NwrWFam+GlQ5FFxQqW+5tIMQYoUtUcuY10XX3ZDrfHmW9ahI/tsF2Cy+jfER
 iiwhFZZT30zeh2YHYrBzLjjhm0MJEaA1PxQBdjWSrFKJKU5qaDmIZKGvM1T7I3Aqk/atoZEHT0K
 k+iBCMTnv3wgyQ==
X-Google-Smtp-Source: AGHT+IHjP7cDF7bjSkQtSaziaMNTwr8YpUvG9RAE8YpTO+DYBNjpmmQAoAlj39xHNrM2CdiAEJ42qQ==
X-Received: by 2002:a17:902:f705:b0:20b:fd73:32bb with SMTP id
 d9443c01a7336-2129f730378mr62433145ad.2.1732315926655; 
 Fri, 22 Nov 2024 14:52:06 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:06 -0800 (PST)
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
Subject: [PATCH 03/12] docs/system/arm/emulation: add FEAT_SSBS2
Date: Fri, 22 Nov 2024 14:50:40 -0800
Message-Id: <20241122225049.1617774-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index af613b9c8b8..50d0250b1eb 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -137,6 +137,7 @@ the following architecture extensions:
 - FEAT_SVE2 (Scalable Vector Extension version 2)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
+- FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
 - FEAT_TGran16K (Support for 16KB memory translation granule size at stage 1)
 - FEAT_TGran4K (Support for 4KB memory translation granule size at stage 1)
 - FEAT_TGran64K (Support for 64KB memory translation granule size at stage 1)
-- 
2.39.5


