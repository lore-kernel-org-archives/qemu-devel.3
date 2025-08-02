Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00D3C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLoh-00066t-5V; Sat, 02 Aug 2025 19:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLmS-00035J-CZ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:36:49 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLmP-0005kS-Ui
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:36:48 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso2744422fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177804; x=1754782604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5djZzXS5Dinimievq/95HDV9TuYnTpWymA6EcqizEU=;
 b=WewFUTzrhMyAaMPW16MAi/D0aolrbYQglpWe54n3vZa28NtVYYBcbVWKt3Obh2Us6O
 aKFGZPDvaELkv92xH2f6gasiD0LJNnGNQOR3aa3/t6+YHNRyKM61tboK/NE18wnENh04
 jXum7ebydV3w99WkIMMHwKVwSx+tD3G4vE8PfsnWOe+VaUtD+Defwyb34bwI0Kti2EXr
 41YyWR+hDMVd0XqJeTDG3jvBDGSUB7hZBKVRJAMcRPw7ODGbUnIM9UHtIrIancsMR4rS
 bUZiTtWB7S29NhXBiI+GhuFdL1MH/shLnk12ALabYebcLMbQdnVqn/yK4lINxd8gsHNO
 mKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177804; x=1754782604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5djZzXS5Dinimievq/95HDV9TuYnTpWymA6EcqizEU=;
 b=K9AymI6+P4K75JTEly8+ynLd4TdVB4yspFTMQnJ+OxV6CMgJTVYIes5z+S4U8YVXWB
 Q3YfzJK5IErG59MG9U80xGZTlqXjh7O7YkPCF4j5+uFGfh0PZ4INcRzKl2nza6e92sxG
 wfp7Qbu3K135Nax3Obkx8cu339q4JiKk7l/z3WL5eLm4rzxyuEUW9CjY6ejVDKmmWkit
 VG0WTMzqPQzk9czXXeWG4mrmtTVdG9WkVBxpqCw6LWdCHwyn7rNqxTCrpLEeUsIz1dWp
 FJIC8ti2/YIyZCVyVvz0B1cS6thhFRqLBk9w4KTla1P86jj050MyK1PeXxdfTZyWu1uz
 A2UA==
X-Gm-Message-State: AOJu0YxdEpBLMy/R+6zlJS1WKiSMRt1LOxhYwRDStyAhDShzCBCE7Cq6
 10UoKVoSuIhpzW/VSRQAJTdkwe/JoaQTPtUTSfdFs5s18kBG4tjGGB+4OxSSMGV9Eu4jc8/fKNi
 +z96kzAs=
X-Gm-Gg: ASbGncsJ1nAbqh8IOduidY44BbLt+L2pPmASkdD6xcAbNDJA1CU8ipn2VL5zaHNRclk
 Y2GmFTeC7VqpgOoWPN1QiMvsfok1GNkEudnoOF/7tJunksN3WYf4nqJ5P8CUjQ14eOJVfYm2P19
 LiY7m+4DWTJmfXAR+yT++zS15JnF4BRya7ZvAQ9rkdkvKTcitdlEIsraeoFeGyQGIr2/K/NP1Do
 1L8Gi5/5EH5U+h8QoGtYT5pHYbrVpRxB/jekfzGhBtXwjyfkpbIBCJ4xj7q45hj77g03EtXA5PB
 78Ci2FbKOBlT9NuT6TzBlcz2NfJcCSoHhFbjumqHXxpwII8dG56sqaldD+KjzulljL8p2nQvGZR
 EnKcvO5Uhni9dlGF5Qut9yppU2Y7w74TFzwaZUSfVVxhUeBU63E3e
X-Google-Smtp-Source: AGHT+IE4Wrfck9OUylO4HcW2JLy6SCukYXLWAEj+KiTJ/TuJwyvRkCA2EjU5ISzUVsUPpkabZqFXWg==
X-Received: by 2002:a05:6870:a9a3:b0:2f4:da72:5689 with SMTP id
 586e51a60fabf-30b67739802mr2633111fac.15.1754177804040; 
 Sat, 02 Aug 2025 16:36:44 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:36:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 46/85] target/arm: Implement gcs bit for data abort
Date: Sun,  3 Aug 2025 09:29:14 +1000
Message-ID: <20250802232953.413294-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      | 1 +
 target/arm/ptw.c            | 1 +
 target/arm/tcg/tlb_helper.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 805f4a1876..7a42f8be0b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -756,6 +756,7 @@ struct ARMMMUFaultInfo {
     bool s1ns;
     bool ea;
     bool dirtybit;  /* FEAT_S1PIE, FEAT_S2PIE */
+    bool gcs;
 };
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 3c84f0f024..ce9626b627 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2393,6 +2393,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         fi->stage2 = regime_is_stage2(mmu_idx);
     }
     fi->s1ns = fault_s1ns(ptw->in_space, mmu_idx);
+    fi->gcs = regime_is_gcs(mmu_idx);
     return true;
 }
 
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index ae2acd6727..37c7651799 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -78,6 +78,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
 
     /* Form ISS2 at the top of the syndrome. */
     syn |= (uint64_t)fi->dirtybit << 37;
+    syn |= (uint64_t)fi->gcs << 40;
 
     return syn;
 }
-- 
2.43.0


