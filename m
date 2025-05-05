Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5848C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57K-0006a9-TK; Mon, 05 May 2025 19:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC571-0006HZ-6g
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56y-0003ZW-AJ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso59553855ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487235; x=1747092035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYwtbXWo/TvD/k3nLDnPjIkSoANte4qu/UhShUcHmQ4=;
 b=JAUr5g3P6PTBOXh6QIxd+V8bq/E58+Rdacyq+PQ4rnIMmPb6opQDT00H93kif+ujp3
 y1AEyfep1Yz3l0OKiyrn8EKxaDWdLcNbe/ti2L+bSlt3BKtQgq9pTUiWtp1Y8bN0SX6J
 cDoD6tWSeCpLuvT/omtkyZjv6UuS0rK4mbowfURTvyjT+jjy50FEEdgZRsOUN3Qpd0FB
 xKNk2d/0OJlLPkDiONngSWVAxEiwoSJZlu8gzlaP++33NpAQPhwQ6x96N74cG8VBVFiN
 mYDzsSSpd+1xBx4NkhxSCSyhkk2p0fAVpSA/nVXR4o50eyAbQR9bfL2cyAss7+nyGFdo
 Ff5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487235; x=1747092035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nYwtbXWo/TvD/k3nLDnPjIkSoANte4qu/UhShUcHmQ4=;
 b=c3j/BBIUEW+6Ac+JInMTe8D96KjZAOF0G09qzAqanu2yrPs3cyZntuTxENjsqpQRx2
 52bS4+066xMl4BVdSjhu5MrtJE8Y8fIAeH0GOh5LiaIsNQKm4KzKQ5nh4/hvnY9Qr5zd
 nZOTkcKFoRtpHPDizt4yZsv/YFhZT0eM+DtHrGHiBzsN077p4MKALpIjHSxoAebdb+5y
 HxgB+YgrhEUshfx3NCDTFqD9scWrhCu7OrlJbEGexr7Opb9ICA5W4hcGtMhdslcahUvo
 aCcDmfrp7Ss/boDfVi6uN7blXKkWDMaQnB0qaw8v/Zp1H1fVgen/DBIzCddfurhNadD1
 8pTw==
X-Gm-Message-State: AOJu0YxSAuMoD/HRaOcMhRtL1NKAiiFW1mwXIhCisUbm3n5tGNn0y7YP
 /70v5sTrxfUDPCdVasFAE/CAocHFgH/FArDvqrpMGFr57fFpMTAQk/3f35cqzKeVwbZZ1g9tPWs
 Hyqw=
X-Gm-Gg: ASbGncvHSz93u9zUP892lTA2QMWx7rWEtCab5+0wwK2KKjeZihNM+/iInNHU2FNPQup
 mPd4f+VjH/p4FbWNOL3mnrYcp8vwYPphVMU8kJi85EBwSEQrM+/rzVIaS3PWOiVQXJvrAtVrd7d
 lcMr58bXsWPlXhyof8l6jZoDZcpFvvD51USkxkjvaDhMxw6Uatefq9nnEO/nfRSObpAVKySNgdg
 VJZ8iPCPyDxCnQiVYENFfRyn21EKr4bNB/d5tIWvAZqfOdnl4gqD8vjfyjZJyj/xega/e4viK7A
 9larPLvIZpI3eNQLvP7KIO+jhnxEPjrPG+H2l8G6
X-Google-Smtp-Source: AGHT+IEZ6VqsUNG24iDMT3idG7vLgb1bzL1cG05Jn05ziI2xH8ByDBSw6lb+7MbuYw17U4nXGnFALw==
X-Received: by 2002:a17:903:d5:b0:22e:4203:9f33 with SMTP id
 d9443c01a7336-22e42041dd8mr586475ad.33.1746487234785; 
 Mon, 05 May 2025 16:20:34 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 16/50] target/arm/helper: use vaddr instead of target_ulong
 for probe_access
Date: Mon,  5 May 2025 16:19:41 -0700
Message-ID: <20250505232015.130990-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h        | 2 +-
 target/arm/tcg/op_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 95b9211c6f4..0a4fc90fa8b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -104,7 +104,7 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
-DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, vaddr, i32, i32, i32)
 
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 38d49cbb9d8..33bc595c992 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1222,7 +1222,7 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
     }
 }
 
-void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+void HELPER(probe_access)(CPUARMState *env, vaddr ptr,
                           uint32_t access_type, uint32_t mmu_idx,
                           uint32_t size)
 {
-- 
2.47.2


