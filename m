Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1407CCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8l2e-0001cl-Ur; Tue, 14 Oct 2025 15:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2Y-0001a4-6S
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2S-0003Pj-O5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-781db5068b8so4598893b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471423; x=1761076223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeiwxiUvqRGSS/dH8aPGA6TRw5Wq+/Vm3e+77xD1954=;
 b=Y5xQATKgsuX4jZDOeYZYwNJm6jdu3iKGiq4rd0dgOHroE2GsDFtScZxlmIL0/c3EJF
 /fehpSlRjq24/3Qj3PhksPID3C+8FEdbzKC6RlkcqwaHgu/x1D/n8frCUjOZIJtfnnxP
 UcjJL4K6kWteX2JC5dTZbMNICa4ENNGdXQYf3a8ulBR+q0FZVS61fb3QHxEX3JQj/LAU
 +vS2YaSUVu9mPVs0HtfIdbRGHN0vf7oje6JUivYWpSy3syy9cbCLM6nEf/z7XkWGuLnE
 7/IJ/CAn5ZSZpqL8C9YEcp1IcS4Ymv+jBN+1BTFytG40uQPXfJaZwj6r5SFUYX/tVypi
 Xlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471423; x=1761076223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeiwxiUvqRGSS/dH8aPGA6TRw5Wq+/Vm3e+77xD1954=;
 b=VHG9Wyq0CTvvajjcY+KNzrs4vG58vWmMsUxjPzrT4XofKz/ttWX4/oqJ3LBT5ZutkY
 DRvMKPbkL9SVjefO+3e2cWF0aWE4Uj2pyY8RNL9xYEzut5hDDK2m6kZD2upLjpWmQyxh
 +h9axa6PhAZ+/bXXxM3TSU6g+r4LC7AzaQ7RFHtqqYTyTXJOY3BVn6qcXKtx+27uE+m3
 E+GOISGb4NzUj2AGH9b0firkETQzf6SG5Lz1oiaHBn5yg7YhSszh2+BaQjk04kKT1bA8
 ie+OQ4E2p78NlgS503oDHDZYP6qsXo2toJGSyFx7VLr8910SGpPhLt0wtlFDNqU0BfbZ
 U99A==
X-Gm-Message-State: AOJu0YzvzL6sAkPnpKdXDP4gcPNK2D0t1ZWShC7X2tjeLb7SVY/GwWsK
 y8fS1mqUNfwZViBTxVFzKBWSpi5eHiQhaOxqwj8wpRV7KBsLb4NcYmU4TweItUFws6PHCQQgdkv
 JgGHfnZo=
X-Gm-Gg: ASbGncs0dIjx4MHaV0LDkyj6F4DrqiJly5wFKprT4542zy4P/+7D2T1CPnyYfC26Q30
 dtaA1pHmBqvOI6EauO8RSEDsrBSp52GDE5L9KOlIsuud00PErcxuLzFdi9afCK2U4qN/YHQEuOe
 x8fWrJdzG6wBVsllCH/gobQ5rs7+4yb9w+QQdJOxfCYfUnJPo/M/3hQbIktS9BZjbb7xKJAwXBy
 /xJMwCRXKVxazsgT9fCTGSbmBjcjdIu2GwzGLsve1eTwDzQnApnk6ozbT4khXCCgcBwWW4gOv9M
 AviI3TCZmUQLtnlDttX+vMRvHDX8DLAF9vLKH5pcQR2qkfJ7aovmQs1Nz4krlcIINVZznXBn/Mz
 YPzwneHMuX/8GQoiBU2GD8CFTY1vRATQw1aMH81BFlLTGud5jK9CXHRMV7ZrnKQ==
X-Google-Smtp-Source: AGHT+IGMt05uYlqnkiw+8u1XhFFkjfrOirM8wSU2bcTQZGp5rgX88XTJXBcCZA7K5K8jq1i151CiPA==
X-Received: by 2002:a05:6a21:3291:b0:2ee:afa3:deb3 with SMTP id
 adf61e73a8af0-32da83e686dmr35355003637.46.1760471423331; 
 Tue, 14 Oct 2025 12:50:23 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b63a03dsm15918727b3a.19.2025.10.14.12.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:50:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 4/7] target/arm: Drop trivial assert vs attrindx
Date: Tue, 14 Oct 2025 12:50:14 -0700
Message-ID: <20251014195017.421681-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014195017.421681-1-richard.henderson@linaro.org>
References: <20251014195017.421681-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

We just extracted 3 bits; the <= 7 test is trivially true.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d4386ede73..54c45fc9fe 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2320,7 +2320,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
         mair = env->cp15.mair_el[regime_el(mmu_idx)];
-        assert(attrindx <= 7);
         result->cacheattrs.is_s2_format = false;
         result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
 
-- 
2.43.0


