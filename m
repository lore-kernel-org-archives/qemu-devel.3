Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9949BCCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8l2j-0001et-46; Tue, 14 Oct 2025 15:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2Z-0001az-Ts
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:36 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2S-0003Q6-Tc
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7841da939deso5158950b3a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471425; x=1761076225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NaprHm1cxvsJDmn0tazFeaRDUdyxGs85ZVb7NZLiwUQ=;
 b=BoadkB5ufUW/kQhpver3k/OXF9svrBUAYAWwxvD+1Xuj2yt0yZsv96JVufxMP8MHHS
 eBBILFrEZIlgEQ1PMnLEW9tY5+Fcy78VwMZnrysmn04WG3dMy3bvxIm/DuAnfsT9q+Wn
 0qQ6cWoEow2OgbN46/rCF6ZBdu1MOiW7UV5ued3f8zKkSFIRpOBVhIlFKoKsLKimQ3+s
 i5ElbX8bKLR0nTpquHRilcnD620+nhm3ntsOR22nggBdM9tzuvOdzn3EtS1OGYy2JzHl
 IhDa35W+eHs+3+AXI2qd7qIDD5tgy9ll1MK5YgKBkyYL3VR7lBIhIL2SklNpmqfDMrHl
 f8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471425; x=1761076225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaprHm1cxvsJDmn0tazFeaRDUdyxGs85ZVb7NZLiwUQ=;
 b=d2SLHDW+KvgZypOXm+8t4UAOftQE+AouVxkJKtTsSQDK2wwGUYjOSF+x+mMoEzOFDE
 Gwjji075Sz16N23eYiQRWnVeVKXfCNJ+2b3FZB0zI6PgHqxKeAC6FxrKHsWtCDaC/kW4
 bhCStIOQRCb2MOYZ5jYGnvhs+0AEvL6GTvjSJtD1SHxSko33xTACVT0uyBO6h6u94V7p
 5ZA3gQ61spl6LnGca3GJhWSk1LrvcevvGBsxM5hTaaBAs7ITaPM6E9x1iTQNIIqGJR5f
 DRFeiA4oeLn4rx+EbtUHtsx1WL0uGxq3qhKw8vq3ZxTROjzRltcXiPUhs4Neka5QuMyJ
 xk5w==
X-Gm-Message-State: AOJu0YyKTdHmHzxdMWHZm5pxjH7cgjmWWXCN2ilDzZeAz+/NNlaxedqW
 t7zqkdo/b5XvL/+8ZlkMWmD6Ivl6J+OKrrOuegbL88baXl7M7wNF9/+q4itLKjIXm/ZVxzaZyb3
 dIRY9EWQ=
X-Gm-Gg: ASbGncu0QiBeDCV67JrKJKwckjxSbs7/Oz78R7ACECwSOa4asjyy51Ro+1eK5Rh/6Bw
 Lun74OzK3PygQgn285xkYew63eynsS8h00+HAqksoQrAhEiAXtOo+UPkmISCnlE3wGCVBa7PoWh
 e0J0TFBFhgw5wKPIggooZLBn/qGK0V+lxIX6jlVqGhqLTmP2Q7gNmxlod/vaMZ5WPpJDPnCwBvY
 99MH/dAI1/ks8h07S0iZhDnGOLksjY91gKUi8XvIqZD3paLtjA9neZrlLFWrmDvmO0Jisdt1P+D
 n6H21YW7TH64nCgvAs1P3OpAi8xExQ7q2WnmvWtDFrqneVnhVLH3GN48yn2tzUUGUB8wCuMV2zz
 h8XApGV3C1cmd9Y+dj9mOUbP76MaxYj0voHxOp0F0sTiINj7cjbxt9SKLYQML/37I1DZnPsal
X-Google-Smtp-Source: AGHT+IFs2rdMt6FFIg1yhnB3QnB0IBgUKHJ1uJjzdqDmzAwZsNw2o0WvRbOlaH2ZY+SGXfevO8/6NA==
X-Received: by 2002:a05:6a20:9184:b0:32d:bb3e:c1b5 with SMTP id
 adf61e73a8af0-32dbb3ec680mr30750541637.31.1760471425609; 
 Tue, 14 Oct 2025 12:50:25 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b63a03dsm15918727b3a.19.2025.10.14.12.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:50:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 7/7] target/arm: Enable FEAT_AIE for -cpu max
Date: Tue, 14 Oct 2025 12:50:17 -0700
Message-ID: <20251014195017.421681-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014195017.421681-1-richard.henderson@linaro.org>
References: <20251014195017.421681-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 1bffe66e81..6871956382 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1331,6 +1331,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
     t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bf81da124a..31a5878a8f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -21,6 +21,7 @@ the following architecture extensions:
 - FEAT_AdvSIMD (Advanced SIMD Extension)
 - FEAT_AES (AESD and AESE instructions)
 - FEAT_AFP (Alternate floating-point behavior)
+- FEAT_AIE (Memory Attribute Index Enhancement)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
 - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
-- 
2.43.0


