Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C6DC3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 13:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3wT-0001NT-07; Tue, 25 Mar 2025 09:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vi-0000zt-Io
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:03:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vg-00084b-Hn
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so33781995e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907770; x=1743512570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4sDqJtqOWjvSs4usBVbY5N6y1YZHqf2bWga8DmhhKKI=;
 b=Ufxvfb3QUcH/FBOuo5nefIOvDMg0xxbi6vDaBau4MkOTlleXS/slSd9WKBysjJEheZ
 ot3jG3vsfpQP1LwCK30Q43zpAessJ0baDQKdgEERqaUJnX8IksP053BAsdxtsCrr1w5D
 hgEJSRbOnAcklC4Px5UTsJvkMnwsWAiIGm6av7pglzk8NuMwHpNdtbd4cqcjXUDg5HIo
 wgIokFHu4EFp1Vpg4Lz3/fD1nyLC2fHGM5nn8XPnAklP9OpccStzduR9JT605kk++qYS
 L9m53DLZHQagtKg9X0ln8diCEeuzxz1wJpbSpTQruqNXmczucZ0kY7+Ffp1KjAHuqWeB
 iH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907770; x=1743512570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4sDqJtqOWjvSs4usBVbY5N6y1YZHqf2bWga8DmhhKKI=;
 b=uMHvISr9See1P4ifmMaMdE3y3ennHmMmpRGpmHSFM/oYOg3PSuAy91iKYZycUVanAj
 7m9stMK6kQnYcXDXMAWurAO3FJQw7G7B1bgnFkzcFbMXLLRWBlNawPgsNoZcuDHYrU96
 5kupLiDfvobUSPuIM2MmV8AbOy2o5Q5aRQl7SfstypZqZkOl/x3fx6Fh2NfC7szJCccu
 7K4VLxmrmhdyHaBiMpwC2qTIC7YWPnyHTg5KEsSY+P8PpLhwqoPOev5imk4nb402oKfL
 sfsXp1gs2j4UkxjOdP3AGZAWI9/Nw1z6Hi4U6PDGEhFT1ZwoOkT/jIxLnkUZTlbI/Hi2
 NZbA==
X-Gm-Message-State: AOJu0YyA9duvR1XsY3ckh3Hew9KemXauBOM+Zr3ojIQzHt+RuEPlVpla
 LRkGANu/cPnbRtd2i/4m1oMAnW0IW6Jt41UMPF+/rl8U4G/fPnwCBxaBDGzzGqG3jsPxqJ142MG
 3
X-Gm-Gg: ASbGnculcYeI4YQjF+iK3P0TAL9Evm+1iMI4fr95dnfVLOwd4csIKxKGwBtI6mbNYAD
 s9gOz1gXNBQHo6rrlsdNsqf9rHJ2F4SrGrtGNIiThVQQUs8cjmr5L8K5i/+eLyHC6qOmxWefiaE
 0Wy2sME+IcTSbErO97kThedSRanFlWznZMIqLkKWYGIcyPMFWWXjIkaQq0XcW3I8BxuNd/IFfe0
 y9sIZSID0/ULGoacN+vNljzFBYwbV+7SePQsei0zVfP2epz1o2LddyXrHufh8wM7fuFxlfT4e7r
 NW/LU9FLMjhMeTcSI3JWz3kDxo3wAkhKwN+USotoMHa401HhGMxhv1/ZvZGDPxo0HxmDwsSnbb9
 VGD3z9V3QJwOnm+kXtk0=
X-Google-Smtp-Source: AGHT+IHYsYWl0t83+0KxiDgq8X1lmd9f8Ood9cREOUiUzl6ZX+LzQoQnAbSp1vOaQKh2X4n0wy90lQ==
X-Received: by 2002:a05:600c:3552:b0:43d:186d:a4bf with SMTP id
 5b1f17b1804b1-43d523cf4d6mr124041165e9.0.1742907768709; 
 Tue, 25 Mar 2025 06:02:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9ec29sm149225455e9.30.2025.03.25.06.02.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 06:02:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.1 5/5] exec/target_long: Remove TARGET_LONG_SIZE
 definition
Date: Tue, 25 Mar 2025 14:02:20 +0100
Message-ID: <20250325130221.76116-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325130221.76116-1-philmd@linaro.org>
References: <20250325130221.76116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Directly use TARGET_LONG_BITS, so we don't need
the TARGET_LONG_SIZE definition at all.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/target_long.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/exec/target_long.h b/include/exec/target_long.h
index 3cd8e26a23f..d8898625f4e 100644
--- a/include/exec/target_long.h
+++ b/include/exec/target_long.h
@@ -20,17 +20,15 @@
 #error TARGET_LONG_BITS not defined
 #endif
 
-#define TARGET_LONG_SIZE (TARGET_LONG_BITS / 8)
-
 /* target_ulong is the type of a virtual address */
-#if TARGET_LONG_SIZE == 4
+#if TARGET_LONG_BITS == 32
 typedef int32_t target_long;
 typedef uint32_t target_ulong;
 #define TARGET_FMT_lx "%08x"
 #define TARGET_FMT_ld "%d"
 #define TARGET_FMT_lu "%u"
 #define MO_TL MO_32
-#elif TARGET_LONG_SIZE == 8
+#elif TARGET_LONG_BITS == 64
 typedef int64_t target_long;
 typedef uint64_t target_ulong;
 #define TARGET_FMT_lx "%016" PRIx64
@@ -38,7 +36,7 @@ typedef uint64_t target_ulong;
 #define TARGET_FMT_lu "%" PRIu64
 #define MO_TL MO_64
 #else
-#error TARGET_LONG_SIZE undefined
+#error unsupported TARGET_LONG_BITS value
 #endif
 
 #endif /* _TARGET_LONG_H_ */
-- 
2.47.1


