Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00A9C36005
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGc-0005tR-GP; Sun, 23 Mar 2025 13:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGZ-0005rt-P8
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGY-0002v7-3k
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-225fbdfc17dso54026345ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751461; x=1743356261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewSa7YLsmr/V8RFNcj2I2xqcVJc7xLcAd7Q9LXiEnxw=;
 b=BegQvGA2ByvCocHieF+qLEQ4vjq4r1wtFAX9DsuHCX2UDe4J+mU13hqZ5iJUCbrrOz
 zk3Yoi2BL2o3bTxTi400+ObusaqW2SzwFrlQm2Pe9AIGKkGvN4rVbtj0ufHbUG8MsfLT
 V8P6aacJOVFCUGBxuOpbcL+RmhW4beYcQ2gSjsIvPWBtkLAeeSDVoYoJQlBUeKmnGoZD
 p0ORISm3AtAszR3piUzL7bC8hiylVux2K9fEGzj/4IWCDd4yrHk8xO4zT4WBkwV03/tk
 qg8SBEVNsRI/9idefLQyLGjAGBkvQiPS4Df9NcAwZ2q7/2ZtSbQA/NbJDwpbsgcC6o28
 LZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751461; x=1743356261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewSa7YLsmr/V8RFNcj2I2xqcVJc7xLcAd7Q9LXiEnxw=;
 b=looOQBxZdlnnV7bVeHk7Q9FCjcrPlZL2Qw4g7HNJN/LSwZ+DCyt91ZRN8L+xVcZs4e
 fnN8Q6lE7y9C/Mhsgo+bDMaR5rGAL3X6s/hi2fN+sIeTHYM7W6hWG/3OdDkki6H/4aJA
 46SuiUSg1fTlmQk3pvs8GZLiMqpTtGrXV/y+GlNKqgpGeZ25V5Rk7B5tz61c1k1VsFS+
 Xpsjf3iO/0COLww3Tz01PZMdWxYPxzf/K5OTbZYd86s6v0/FfU7Y8kg0FomCFKkZeCWC
 Sb35b9jbeT03co7F593L2/QfdIcvb+IHXLpqW90rnfQLqljGkPcKXbOll65PLxJL1Zzm
 6WlA==
X-Gm-Message-State: AOJu0Yzt7DNqzfFA+aiEvUMNePoX3gPBCfSfqJBjoJrOoYvvrfg0Kf93
 gpzPYzKd8cYGstx6pPe6gczX9U51FEOxRF0bGxxDkkd7U48z20txrpmKHhoR6sG99KAubmlDGp6
 B
X-Gm-Gg: ASbGncv/EhMHSDZCJlL3SdlT1klvUk2SPl8GlporhomUlAxlBQ77OYCiDMDZz/L7Kx/
 CV4ejKy8YBhkHw9MA7n+9YKTlgUsmF2ATQtjgBZFd4tYVHsxWzAhZbTKNci4TjgUdNJr0P4nwi2
 5iqs1HTcj64Nb3Qjn0fneZufqfnghL6vdfuDzTUm2HZwBTKq7+kBCBeuPOCiJlAn5juUxxYmxaS
 aeiWw8Yf+nqjpq5PT/+H1gBLmpb0otLPx7jWnfg59tPUPgtywhypHSRM/Ob1WDsDBJy0GuXeYAz
 9mto5XGVBH1gx91Yi6kE6ph5B/KWxyz1DUMeZjFpyogYKnAhmsPAS1kRWH6+21f6oftKsNceIqq
 g
X-Google-Smtp-Source: AGHT+IGb6atHwiO/o1LnwdT0INAtTFlcCPcZXPjgYakMtPe84hrL7/HtqgBVrqD2LxEco2kQiu6Rog==
X-Received: by 2002:a17:902:c942:b0:220:ca39:d453 with SMTP id
 d9443c01a7336-22780d8004emr151935625ad.17.1742751460839; 
 Sun, 23 Mar 2025 10:37:40 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 13/17] target/avr: Handle offset_io in avr_cpu_realizefn
Date: Sun, 23 Mar 2025 10:37:25 -0700
Message-ID: <20250323173730.3213964-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index e4011004b4..538fcbc215 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -161,12 +161,14 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
     memory_region_init_io(&cpu->cpu_reg1, OBJECT(cpu), &avr_cpu_reg1, env,
                           "avr-cpu-reg1", 32);
     memory_region_add_subregion(get_system_memory(),
-                                OFFSET_DATA, &cpu->cpu_reg1);
+                                OFFSET_DATA + cpu->offset_io,
+                                &cpu->cpu_reg1);
 
     memory_region_init_io(&cpu->cpu_reg2, OBJECT(cpu), &avr_cpu_reg2, env,
                           "avr-cpu-reg2", 8);
     memory_region_add_subregion(get_system_memory(),
-                                OFFSET_DATA + 0x58, &cpu->cpu_reg2);
+                                OFFSET_DATA + cpu->offset_io + 0x58,
+                                &cpu->cpu_reg2);
 }
 
 static void avr_cpu_set_int(void *opaque, int irq, int level)
-- 
2.43.0


