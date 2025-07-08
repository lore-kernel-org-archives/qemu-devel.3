Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A155C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFE4-0005mB-JP; Tue, 08 Jul 2025 16:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDqm-000762-S3
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:38 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDqg-00086D-O0
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:29 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6fae04a3795so52018746d6.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002354; x=1752607154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSHu2C6AHkdi6I2MI+MN+9VTwDs09gk+qY11owIPdS8=;
 b=nh4K83BCOakJ5XXA29pCLwszfOv10O2HVUmBrG4keb/Jk9Y7NLfk7JcKRPTW8itMFR
 oe/1T3PiTpswA+ar4EVsl8T+HaA+diLUgm/zzRm79OIJkOVOcynOMyf21o7+qxzfNoU0
 jvYyFh6dVjJ9jDMBB+loBg3xr7i+gNFt0e1M+xW2bvd//IEpQ53369fc+413nYk+Bui7
 wYg0PKEBgx9u7EdMWYOGl141qOzcr0wj1NiUAtdKOyJ5OG0pT1g/YS1nrvKgUHROOXcP
 QLpY6PchjhBzXcMCry9tWqhPW6AsH4oQ7rOrYUHpKloVeHHgRkyZKKHHVqMTJ530s0zs
 Z3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002354; x=1752607154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSHu2C6AHkdi6I2MI+MN+9VTwDs09gk+qY11owIPdS8=;
 b=WlKWpigic082tGcN6w9iNaAK763pt/bIih2/DuxriJNUcs2KCOx8VxCbsciBTDrGzF
 aFD5UUpkoHJ1/8nqFqtfbL8QLenMEuK6K3LrZYHhGsxUOtnMRt/gTqVAhIAH7HZ6NuVh
 cerJfsNB77myagwoAJWDq0fYAhfn3eu2HX/fMb0Ty9KhFxQwlnGu2Fslkc+ku92lMmr9
 dJAXu8tscc7PvMkMY3zb13N651j/ZjdJA8ymh+l9GVQ4BQ3+nzgfE5OsnFyhsolmvxQg
 9GDQ3EOWtSifvVhsuMfypYcbs007YXUgTjJL3uvjXUfypJWCKEx46IBFv/kABmjFC3zd
 Hx8Q==
X-Gm-Message-State: AOJu0YwYtn+g0r9Tyv+pCoDf4XcPx9/4m10nKoKc1S/RPxwyS5/6HRK0
 98NROCMVCl1GshPNrODfTDykugu8x2B2B5UQ+byPM8Ehap+LytzWDYSCoMH6js44D+E=
X-Gm-Gg: ASbGncsO7iv0wglCDC8ORh/bIgj73nMoKq0Mb/tazbe8BvX2nFAChiFC/dvaE/XPaKO
 FcbQwhhAktjY/2qymam/HNx9CF5CNcWCHSaYZDgvko1+mq5tG1+85ZY8RdmL1rU6cmFVsNaz7La
 /OckGqKzAvw0P6t5T8/kchrP2FpbFn6FSO5FqgaBqlx31/5R7kbsy7GmPTweMjVoGRWnM3TGCqA
 PHgVDv4XkxAiJP4s80YZ00b39Vq/RBIx0rciLOd93G8suMj8rrZHNN9XcEovIX81dX0VhbK4Vu7
 L1l6LuRMs5DHG76f+QT3rrMYwiOG9zzwcOpwRhwko7iqqMHqFNAsVyCuS6702obf/Yo=
X-Google-Smtp-Source: AGHT+IEPVtapxFZtywAliaVxF1CHWD1ZAc5Em284q4ol+mGChMbTsCoMBELPXXvtyKtgjOyuBt2igA==
X-Received: by 2002:a05:6214:31a0:b0:6fb:1fc:788e with SMTP id
 6a1803df08f44-70489abc6bcmr10112406d6.2.1752002353700; 
 Tue, 08 Jul 2025 12:19:13 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702d638846asm56289096d6.22.2025.07.08.12.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 12:19:13 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [RFC PATCH-for-10.1 v3 1/5] target/arm: Add the MECEn SCR_EL3 bit
Date: Tue,  8 Jul 2025 19:17:00 +0000
Message-Id: <20250708191704.1068604-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708191704.1068604-1-gustavo.romero@linaro.org>
References: <20250708191704.1068604-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf34.google.com
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


