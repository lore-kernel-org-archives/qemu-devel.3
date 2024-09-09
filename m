Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDABECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAK-0002vK-5y; Mon, 09 Sep 2024 12:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAI-0002os-NC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAH-0007kM-6k
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-207397d1000so6301035ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898976; x=1726503776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSY4uf6Z/opn/dlanPt8haDJAxn0KwcQEBixe3UYnmI=;
 b=WEY0fhWKXByKxRwyOfdVO15jPfgxaIXENmekf8fVCEH5w/pO5wVhSH8RpOKAfpjizM
 49KqHRCPdqRPjheTwtg0HjCHrqa7xSEvpIpNprb7aHw1GE/Min2dbiH7BVeCzneWtJSI
 bvAevomyC7BXZul0xdS1Ix4RGAbtsLv2I8hvOCZU2VIRBt0EtnNoN1Jg89axA1HBBytN
 Oa6mVWewsXA4W+BGweWV6vZC2zghmQxh0rNWNN502OXwBR3+h1uZ5H4NJnudhdRmrT3O
 /MNuR/k+QIO8WHl2wV4bAXm2CNC9YpeFzIMYZXecP4toONMXqIHPIf3TmYHUstzmcM9u
 FumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898976; x=1726503776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSY4uf6Z/opn/dlanPt8haDJAxn0KwcQEBixe3UYnmI=;
 b=REQwmJ4lannwbRRqTOCZVhJMiIG/kAFG8CHLFoRAIOF9jn7aqmkX5lJkPLuEoHQs1f
 PcXo9ANNq3Y1R8Q4uwpleXaPfXkfM5UECuryPcYEe0FY+zzPEqPwdzAygBcLDeDNAU5Q
 mK/8vIGgrUerImyxLDGjKyqkXcH5fTxHdY1WZ8mNRSoEqDcsVjnweYRsNQTlE4owErYj
 PRSDs29aB/ODyB5PErSazQdx8OBgtmnfwxIqBt+CoWmx6i5NJOb9jX5ZwzJce/OyVG/b
 GGbzlAWN4loJvDeAiGtUpIIieS8Px4JwS647sj66ki6ofxQ61A6S1dODIcnFrp38nfmi
 DYOw==
X-Gm-Message-State: AOJu0YxMQeFXmwXKauRi9CKJOdZ0SIhdn+YcP3PgxJPhmHntKJo8aNvH
 Mj1bTzATbeFxae6OUSkryReSOz/a5dCK+G86YfnNlptzp+Dbx0APFUxdTTbf9e7femzyXvy/SZk
 q
X-Google-Smtp-Source: AGHT+IH6b+fE7T2a/RVR1ie58DdG0Ms1dfRzPIhWMhFCD1MZLn7utNAI9ucgv7USEuvwJKzYGwtsTw==
X-Received: by 2002:a17:902:d50f:b0:205:7998:3deb with SMTP id
 d9443c01a7336-20743c512e8mr2257125ad.19.1725898975943; 
 Mon, 09 Sep 2024 09:22:55 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 15/29] target/arm: Fix whitespace near gen_srshr64_i64
Date: Mon,  9 Sep 2024 09:22:25 -0700
Message-ID: <20240909162240.647173-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/arm/tcg/gengvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 33c5084ea6..3abdc57202 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -304,7 +304,7 @@ void gen_srshr32_i32(TCGv_i32 d, TCGv_i32 a, int32_t sh)
     tcg_gen_add_i32(d, d, t);
 }
 
- void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
+void gen_srshr64_i64(TCGv_i64 d, TCGv_i64 a, int64_t sh)
 {
     TCGv_i64 t = tcg_temp_new_i64();
 
-- 
2.43.0


