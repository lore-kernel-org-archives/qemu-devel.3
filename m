Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605C1C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnth-0003TI-T7; Sun, 16 Feb 2025 18:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntS-00034B-Ga
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:46 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntQ-00066E-Ge
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:46 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22104c4de96so20666975ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747862; x=1740352662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B42brmX6Sw54IUhyyL7gR7KEGaR8YSHOiijWohK5cbU=;
 b=r8+iYt/ir59UiKWpUCOHjNoa5Y9AHj2b7Ks2q6taLmCLEODeAjufr0basE4dC+qx6w
 qD2LVedQrFVA2KGzhqhZ7qhqW2rMOqAOv4iVT0KvNPfaHPllmmzK1igBwh0EoHuZTqEC
 A7gUpIfAfQSXPZQ58F+qHkz/V7KMImnVOScpcrFuR4IJRJB+OxKdezCmIJujVlwhbzPt
 Gqel6mfRF9UqEV+LqwSJGmgNsbjPlhMosevAWbYiTsMdSzUq6hdlhTqq3hNKOfBADCFE
 f9NzlxPULCmeWnTW2RFe1TOYLXDQcNDomzYN76Ir471tG3KIpwvo/L2vZllqRK93zvVk
 GBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747862; x=1740352662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B42brmX6Sw54IUhyyL7gR7KEGaR8YSHOiijWohK5cbU=;
 b=cQ1cILNeSHy/LOkVvcC+QDUKIQkPnDdqUFIK8tcer4LYD7uh1UKKeLVG9Sy5lkTPqG
 hUmytYUIIPfNfNhsMHayT91m8/NEASSM5ZpyBT4qQq6yaRgfCpcsb18qjjaQ76Yw11gK
 Rc9J4B3APg1q/s1kDXYtBmd/u+GkrqJhlOiIYlHBHxuD0mVZdgRiM+CRFogDDGGCPYbx
 To5KC85/09M/yuuwdqSNNJyfck5zHQmv85PeyLJapfWYEp56E3L8iuwXZoyBIIvStqoT
 lzj7xRqRH0oqPClUju/TlsDqzXROxdGBSktLyIs/AcGgzMtpOn+Ph+ts9+VHmrg1Dnhw
 lvow==
X-Gm-Message-State: AOJu0Yz9t4q3u+BSiJBDluCrTBSQ5xUB7mERrqv0L8t/vzSlI8Eh0XJS
 WRmhLIzLAefdreYK0kAiNdn5DWir0JQyYWYRu9jo7GKIM5+dxauTsBFP0/l8vT2QGcj6bUC3PyU
 Y
X-Gm-Gg: ASbGncs13IKkBdQxAzhM0J40rHemudiFZTj7/9JcipRANbREqaBx5eUeJUsNu92Z7Jb
 7U30WQailv4G+JTylumI0kk7H7a6mOzZsGeQbwJIHIVgyweZSGI7/Sq9OOofTVLhWgEG+S7G0Xy
 tDf6SKVIsYuAnMDS2MPBVpgx8HjPrT9VwflnO/m99ohJHO1f5D1ZPVJzNv4tCuUmoYTx738DX6x
 Sdx8tk1Ewj/hzQmsgyDQZJyhvGw75cCB06rSoP3shGOl6gBD1Ekc/IxfUZqha1s88I6+ndMwQoX
 QRB5gskPmekrWmqw5NJB973JrYaUByugLJevDuTTY8sOo1g=
X-Google-Smtp-Source: AGHT+IE3nRAAWoO6Si213u+gNWVzdmbu9hZWFd+IODhrQuuEUKoDvAc+S5Z0VHyVS5foI1FQ48ZJiw==
X-Received: by 2002:a17:903:1ce:b0:220:cd61:c03b with SMTP id
 d9443c01a7336-2210404bf14mr100809515ad.21.1739747862653; 
 Sun, 16 Feb 2025 15:17:42 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 118/162] tcg/i386: Honor carry_live in tcg_out_movi
Date: Sun, 16 Feb 2025 15:09:27 -0800
Message-ID: <20250216231012.2808572-119-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Do not clobber flags if they're live.  Required in order
to perform register allocation on add/sub carry opcodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 1782a38e4d..cbe67102aa 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1092,7 +1092,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type,
 {
     tcg_target_long diff;
 
-    if (arg == 0) {
+    if (arg == 0 && !s->carry_live) {
         tgen_arithr(s, ARITH_XOR, ret, ret);
         return;
     }
-- 
2.43.0


