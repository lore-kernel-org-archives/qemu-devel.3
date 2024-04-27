Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58F8C19F53
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kR7-0002x5-Gt; Sat, 27 Apr 2024 11:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kR1-0002pd-9t
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQz-0005Q7-N9
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34b029296f5so3156054f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233471; x=1714838271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hn/H/yoFNZW2Rn975+BG8+EVesDlf/lUvVb7HKZ3vng=;
 b=BPyDyXrQzJiG9xg4272CI/bqjnWhSeRpfv05+s9BhuvR1N0uGun6f6382S7nLx1y9C
 PUSZLL0KQuc4fRNTOc7fFCc4TsNShwLddGwaGsRF6QjLnnu7hmrXu1BxauumyVv4VbiA
 zmrnsoHvJF2nwMPNDxZNtqmF+TLl58cybNcj5jJrFbmyWtGSU9zVelpraDgQ5MOnileJ
 iFEy6NWEfo44ggJCKpsARMf+KD8iFFJ1ZsgOBLLd+FiRkIs8fEgPxflgAitWvPDIyKW7
 btqaMEu9NLrjK2XPAmetxf3T2f6mTvwPKdWGYxHZ7qMAOAXxcttBzXNEsAGyYEe4CMQf
 YMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233471; x=1714838271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hn/H/yoFNZW2Rn975+BG8+EVesDlf/lUvVb7HKZ3vng=;
 b=Lv4CWadH6wjqtzX+jvc1F1XUzKIbZJ7yOMbDFMzIDZhLjGI+Wvkqe9xrPGilnVaFjz
 xuL2H1gs+qfuzxSex5ndHBY0Ynx3+JynY4JYUmacApZA15HxHPr2nEr8AJ+sInugKQZ8
 1s64MF84IJmSXILYPHDHcOcBgG/eCaw9j2QWiSgs29N/1BS/DJwdN8Y5UC6jZ0qhLuZB
 /Zovgsx5pAlGh3lKGIzbYIiEaBpbwRbKCwsEAo0t+dfDdyvoNDgiulH5bWBUcJyrjxQT
 RqbYcyIs9Dq6kuYgCMEPVhPV0+Pp2N7d6WEPHCJBuzNm1sVeo9GfMKP119EFBufg1yhY
 3n9g==
X-Gm-Message-State: AOJu0Yx9b18KFGvmqO/aVBrG5enkxTqUTYQY7OYvblHsu/rqzYCagBdq
 ph20lha6CVwsWtKVFoNFgPdW+q48Kdrw7cCJvfw6GT8C1bC+5q/Os2lDYPkhKIsrTgnVfcWFI37
 1HD8=
X-Google-Smtp-Source: AGHT+IELPZVJrgh3ZeU1aoGLcuTL6hxqZlKyqfBRGG9xhyQKo5U/CciEK/0ALRlbf7bhk2xM3SXxIw==
X-Received: by 2002:adf:f7d0:0:b0:34c:8cbb:d6e9 with SMTP id
 a16-20020adff7d0000000b0034c8cbbd6e9mr2403556wrq.71.1714233471706; 
 Sat, 27 Apr 2024 08:57:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 i17-20020adfe491000000b0034cc9dcccbdsm494845wrm.113.2024.04.27.08.57.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:57:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/14] exec/cpu: Remove obsolete PAGE_RESERVED definition
Date: Sat, 27 Apr 2024 17:57:06 +0200
Message-ID: <20240427155714.53669-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

We stopped using the PAGE_RESERVED definition in commit
50d25c8aec ("accel/tcg: Drop PAGE_RESERVED for CONFIG_BSD").
This completes commit 2e9a5713f0 ("Remove PAGE_RESERVED").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index eaa59a5cc1..5ea8c4d3ef 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -157,10 +157,6 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
-#if defined(CONFIG_BSD) && defined(CONFIG_USER_ONLY)
-/* FIXME: Code that sets/uses this is broken and needs to go away.  */
-#define PAGE_RESERVED  0x0100
-#endif
 /*
  * For linux-user, indicates that the page is mapped with the same semantics
  * in both guest and host.
-- 
2.41.0


