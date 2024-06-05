Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B145C27C5F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLo-0005rC-QI; Wed, 05 Jun 2024 13:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLm-0005pw-4q
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:02 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLk-0003nm-E9
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:01 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c283f0da84so44147a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608179; x=1718212979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12pggLB5ncte2euD32DfT2Z3jOgpAT90Wl9g66CU9T4=;
 b=RHLCjfc7GKAYuFn4Yay0A4tYeNHlIHdKMtO0JNRuzjVj3evaqTaBg71YHAnXLvA0Jc
 ryxakeGzYlTNCyZg12AVbD+vrqY2hKjxUbLv0baslH6LvTGlDpMQwd+WnEnxIwsa2FAq
 EdNR9Gw0+9z3Jw1L5U+afWRjW/RM06QrYrKus73x0NG7NN1qKGgNHhnMgiQnknfFvkeY
 CvOUh+RLNviZXlMk3GWOFltQb8l6aAI77w5+H91jqYnPu1XGLkdb5A1mjGzAvf91CRGp
 Tw9wYcV7opR17GQ01cGvWZUDHDHPS4t6eKEzU+eEMUhKivsgOetDzSYsP83bKfxlYFkx
 /afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608179; x=1718212979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12pggLB5ncte2euD32DfT2Z3jOgpAT90Wl9g66CU9T4=;
 b=Xx665ClyiF4QJ6/4de8TEJbc7ULqh9X1LYdjFulICh4odyN9o9Ibs/A48rtesMpLC0
 HA9g70cPFLaJSHlvlVtLndt7/ETfYSdUyafjdNQ/LcIXFofpYk1ruTPdp6AsR8dznolq
 wlcBM/CxNZWXtvCzJBMou0c6DPFGzwwzWETDyY+wl5Ets15GpYvxhwr9F1m3VindmfxI
 4HpJXNSpuFc6nJVSKB/8wx+vd45G0Tpgb1kaeeBN5iy3cd78L8JFACVzeFwEXaU3vybI
 /KdEdut2CvjRlIlLCHL+Jkpc38DHXJYEdQK9iL90LPocA8Lg57yXoQXjw2fam9nvxhd9
 Y3Ew==
X-Gm-Message-State: AOJu0YzdAq9g9S7qsMVjmuL0wgQ77o03NuidYip1ltO+1RlwCuqNLGn0
 NosYOP1/VbT2o7KJpy4as7d+M15aHkZdl4VH3q9cH+l+jm/Y9E7Np4EWOMHhLG2fbIgiiD3cy8G
 R
X-Google-Smtp-Source: AGHT+IHQIAxmPx/r+lPgLdjS/5+Kx1j2L1i6dd2927AVo6inBn9Pkdzyof0ima3+o5QGFgUFIYJ60w==
X-Received: by 2002:a17:90a:ba8d:b0:2c2:848:de1d with SMTP id
 98e67ed59e1d1-2c27db227cdmr3798886a91.26.1717608179009; 
 Wed, 05 Jun 2024 10:22:59 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:22:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/38] target/sparc: Fix do_dc
Date: Wed,  5 Jun 2024 10:22:19 -0700
Message-Id: <20240605172253.356302-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Apply DFPREG to compute the register number.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 00c2a11353..1eb1a6decf 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4253,6 +4253,7 @@ static bool do_dc(DisasContext *dc, int rd, int64_t c)
         return true;
     }
 
+    rd = DFPREG(rd);
     tcg_gen_movi_i64(cpu_fpr[rd / 2], c);
     gen_update_fprs_dirty(dc, rd);
     return advance_pc(dc);
-- 
2.34.1


