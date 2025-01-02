Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F35E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbc-00076I-Fr; Thu, 02 Jan 2025 13:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbK-0006yx-Lz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbH-00059s-VD
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:17 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2163b0c09afso155743595ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841233; x=1736446033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gm1Ss0byfyZskUZlhHT47TIvd3i99CNzu3mglGlAgro=;
 b=TcIPmSQYrxS5yxK0VmHMa7sQZklvEZDyGfNSQiq7EO20BIDoBTvLTH6SSWs8xEHXtu
 aDlexsrqFoXeXmiqRzmjTRvQOuokxcMKkAqySY5q92iY/srmxd4N8t1+nLwsmU8Pjat7
 oab/FopIWSb1AH56kQP/HmIZFZzSuzlEdtD45CfYN5hjUP0DbVQvkpO1anTUsEMF4dt8
 +fFBcgE8n9v0U9OWkNsdipMu+WOsW2y0fxfTvobfMP+4iNDs6UfRxh8xsh+4u5DqRIgw
 iTFuaWGJ1VzJRMZlvSOyV9fKfylQOLjLlwUDto2g7TaBPsdLQ7+/zq0gGIMSSuD294N7
 VeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841233; x=1736446033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gm1Ss0byfyZskUZlhHT47TIvd3i99CNzu3mglGlAgro=;
 b=eAh1//s+Pq+Uf7r2jYebIaDjVHREeh+wBVGPXifu6535FZzPBsjrr+7jEiGfXbrWcZ
 vvPN37GbNFnb2+Sa38bWiVXrlAHzJCrCuE9vm1bNn5/bUCIF92oSOe+SHeVe+/ycQVgw
 6rmcaBDzioBFILzev5bgcUOrPSnPQevy1ZyC2IcAfDOvjNu1Yu7PgOzr6xtfSMM1UG5q
 0J7AUkF1OBtELvTorncy3h65Ujk+B0DRaK42kJDgIrydBuGvINmtobQloqk6DMx4wVSQ
 YP7ssxUJxYUfHKsKfJwDCYS/dGJOEIvknijVZRkO6AnMTw/SHSIJcGSZJUDel94wCKki
 k8DQ==
X-Gm-Message-State: AOJu0Yy2uXYbxu3tO6T/gtyQ4DtT+q7d8HlRik2X5e6VRdqj5zFgkfry
 w+mTk7MYkfuL0cencGayJ/0wYfsA5n9nY6/sDSSsrfgJPgpSJzzsQCz5EHyxDObcVZutJpVznhn
 O
X-Gm-Gg: ASbGncvgb8mwcWGAMewCU0LoQTMLeUB6sI2+P8dl9Q9Y8ZKiYToMEPkHbyIY+wUn7Bk
 bDDXRt9sdEzLwByy9MtZXuclzJ6zlGnmqMQtrlmSKHcYf/RXiTnRof7ExZVVT0qe5bZfPoYkzRb
 knswBjfRprnymEbh3iLqEMrdCk6lXW2UhYkS91b9KeQohVowneuZKGNkJY0b6DgGOL6tXOJSPlz
 U0kJIM2Gngn7X4mZt7+dM6Er5rk145i7UO83TgHjuPMdnqvxfIHXRb5NPwAVA==
X-Google-Smtp-Source: AGHT+IF14o3VejrR7n3wNVQfYan0V5/uWBe/UzLfKCiKrswqDvcd7YZl6Np1fK+mgxmhHYJ3wmnfdg==
X-Received: by 2002:a05:6a00:8c4:b0:727:3c37:d5f9 with SMTP id
 d2e1a72fcca58-72abdeff523mr57977200b3a.26.1735841233497; 
 Thu, 02 Jan 2025 10:07:13 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/73] tcg/mips: Expand bswap unconditionally
Date: Thu,  2 Jan 2025 10:06:03 -0800
Message-ID: <20250102180654.1420056-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

While only mips32r2 has explicit instructions for bswap,
we have built subroutines for bswap for use by qemu_ld/st.
There's no reason not to expose those subroutines for
general purpose use.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-has.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index a934f86e30..1a8b6d571a 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -54,6 +54,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_muls2_i32        (!use_mips32r6_instructions)
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 
@@ -73,7 +74,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -87,9 +87,9 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_bswap16_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_bswap32_i64      use_mips32r2_instructions
-#define TCG_TARGET_HAS_bswap64_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_bswap16_i64      1
+#define TCG_TARGET_HAS_bswap32_i64      1
+#define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i64     0
-- 
2.43.0


