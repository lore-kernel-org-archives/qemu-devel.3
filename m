Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4836C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZBj-0001NK-2f; Wed, 09 Jul 2025 14:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZB5-00013j-Iz
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:05:57 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZZB1-00048h-Tv
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:05:54 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b3226307787so235382a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752084350; x=1752689150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSHu2C6AHkdi6I2MI+MN+9VTwDs09gk+qY11owIPdS8=;
 b=GyvGoAZ/ANAFePzdECm7laBFQbFvsGoo95Je9Xu054E7YHLlKU0yOSggLgLq4PK3oY
 zPGRZ7argdtYrifbGmA53LluwO9cKklk54MGuf/qBFrhhh7V4BREOm/RWWMZffNdzPak
 gJ3scFiC8JInlkxymTA6nE9AkVUueDhSMywBZOxshTkJAYdee+wMPg0TMEz+vosO/KWr
 o2hyB0ALKG3x5iHzfRngl5eZKvbT7XZjYnSgsAGfPFz42F29SLTlcu+kwuk2FkZzSSaG
 1DVWpfYRE2RCa/xBd4+zVCWNE7cPLf18sF6Hww5CEu9hXNAfULEeVhz5gYM7cgg+O2lt
 sxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752084350; x=1752689150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSHu2C6AHkdi6I2MI+MN+9VTwDs09gk+qY11owIPdS8=;
 b=NtphHdAFOSBEM+2c9YPPEOlfpdHYwS7hfZ+tWnn9MJo5/9Oj7guReL+PMJNvblngb6
 uQs+zUyMDUvUSAVd4GbzWisSMGeLis7uANaaJCXQjJd7LC1FaOJav7ulwJBr/i3LdybH
 YhuRIDbPE3+5UNIFvUyds8DT9YrHDwhizWOOnajBW/M96eNaa20SRYv+dnQh77MfnWVe
 qA3A/mn8U6jhGvxB1SQbG68WbzJkE7jVWkvfuJ0bEy6qlLUWiOvAsqUNkhhcVZtoh+P6
 raSmZ1HkcFv3CAM7lB7hYId8xBhm6r9mCWCMAxZCVvbKqLhGxmwKKmns1QW2ONfDe3Zt
 mZLA==
X-Gm-Message-State: AOJu0Yz0YSv4FyCbeTil0ljeTqSWUxBeBNYqdUzNQHziXL6cSVLTjyJg
 YZoxjx/2zsCV0fUSRQVSrIJi6XHYoTqw+8eGTuUQR2h6e+RVUhx7rgvbRnS0UK303YU=
X-Gm-Gg: ASbGnctNXIaP5N0fksSWTnHNn7rvxmqcgpV8mzOBudYViYWHjsU98AIePvoA4n05Upq
 aI+L8mmz/hDv7LWEa2pX/1W5vS32ARRY3rdnQKULwIq0aaPU20W/h0WTNqglgBV9fKhopj1rNQh
 JKd9+jHBqq9YHl9NyoxLL2a5VA7afcP4eLrW1y/Bo2zIVd8me3WiANhZFXVTRq8ff2/rmwWFvRS
 ke4eOr7ipAmHqlCiRYBseHetCbIWMGD3eQhkti3gehiT1O9CrMNilAT43TaorXFN0Xw/5HHQ5/g
 pC5JEfvaEbHF09TgREFd7pPTIE7+UZnrlnhiFB9Dkqtm9jWoECdytNFDKRSUbfa5++A=
X-Google-Smtp-Source: AGHT+IHlaKJfJDEhDeguKXFw3p6Nu7oCLURk+bMtTCV7YeCCek8aHndypC4k1qqUj64kyXUeg9BgKA==
X-Received: by 2002:a17:90b:1c0a:b0:31c:203f:cacd with SMTP id
 98e67ed59e1d1-31c2fe001f2mr5359211a91.22.1752084349958; 
 Wed, 09 Jul 2025 11:05:49 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c84599f07sm153380175ad.218.2025.07.09.11.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 11:05:49 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 1/6] target/arm: Add the MECEn SCR_EL3 bit
Date: Wed,  9 Jul 2025 18:03:21 +0000
Message-Id: <20250709180326.1079826-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709180326.1079826-1-gustavo.romero@linaro.org>
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x532.google.com
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

The MECEn bit in SCR_EL3 enables access to the EL2 MECID registers from
EL2, so add it to the SCR mask list to use it later on.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c8cf0ab417..0f64c7b163 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1717,6 +1717,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
 
 /* Return the current FPSCR value.  */
-- 
2.34.1


