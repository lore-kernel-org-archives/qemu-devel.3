Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCD4CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4dg-0007vx-00; Tue, 26 Aug 2025 21:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cj-0004wc-Li
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:50 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cU-0007LO-AG
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so5859870b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256761; x=1756861561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7rfDexr8IojFFB3Ylls8o6GXbvzvHLWWwsryQyDt3k=;
 b=UjdtHh+fsaNAlS1CI3hc5SpGgylUcLb0LJhxkMBs1XQFY4AndllIWVQWsP2ZRPG2KI
 l81ihExcyLdGHD02q44Coi0AknEQ8l2OSSXG5dW/Olg4mMkEiJMOX1q1cRpGv02C5IyE
 XuZiLID6y3+6rPqeCoM0ql87Zw7hCafsTN58DMixNqWYpH/5w6q9GTgf7U9m08fABNcg
 HNISQ5jKhQD/E534lR74Mpxq0HKgxWHuvtotnUN44rAxAt8a6PsDt9fLKg0/Xft72xgf
 90FwjHLA6/Nqug8Jf2r0qZI54JmyxB5LNwTcAxxqaMj3naHFkaZ9TcgsS3dsJ6vrHNf8
 Wbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256761; x=1756861561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7rfDexr8IojFFB3Ylls8o6GXbvzvHLWWwsryQyDt3k=;
 b=jG2ok7l2sSmp1Ph1HY501fQLVzigIUVBQJLxJ71ZmFdkIARoeNTUKtMtp8z1erCp0G
 KD1FqCtk3FN3qTRp+sKHL+zM79wvAfshRt+vYTqEXEZEMAn7H3tuhohMHUXA2z+znRaR
 VGY6/5TYm2WnSfdhar5MpxrlfrkzVn6EsshDzNqb+KyyPHntBcbRUEuwH4s4gxYpJBxU
 bu9pvKTrhmbSWIZWglMJBMwpzNnsyb1i3rea59KLdIkQCbZf2GVawJwRhrwgkg88i18V
 d3tvUU0Txhwxzr1SAlSQULHcDUyNT3vYz56BlSffigEojPUsf38TUCsxIXOw+mwaKu5b
 vZKw==
X-Gm-Message-State: AOJu0YywDrpUNj3k4XmVotqwpSGRhess46P0ylu8Rx9+yBR5vkM+JBRl
 jJFLmWH+k6nP8xFIvgL1B0zI5cM6bFFXKsygaZhTa/bhPh2JjdhokwDyrliGrvAYXXCjM+9n8kk
 fD30aWgg=
X-Gm-Gg: ASbGncsq3G0buo3SQZmnRsXMuBHs/hHObkE/NBXwmHfzZ72AAc5iiAAJ4MSjlthl7xE
 9ZMXvPrIdKvRLs//2/dqpZIf8Uv9OmAY2wYKlFJBoys+n12DyxlJuobE0B4MSSFf/oiPbmqNJle
 22+LEBFBnunpuX2qZFutDa6r0IovqZ5/c/INALsfsqCxRpBf6KAQxj+p1yFGgOzy5Aw6eXJBzlp
 kdPrURQ1ihpGzDABPl9JhIPCkh4rCy549Dbm5gqfCcA+qZcR5s1RkNWW2yIGs+lpRmzhWmSUXiB
 ir7wlMABGSt6vtJEGBYmctlr0xggfZj2fScupKpV5dfKOorD2hekPsyE8pggxany2L7JKAdlFfJ
 GYGUmwztrCGYiim6hQr9dHIsy9lT3EmPEFxBp
X-Google-Smtp-Source: AGHT+IGgFkOvE4Xx87bEubjg8NG4HAm0VznNcD6QuwdToYXwt7ikh/5Z5l/cIscI8N6d6mnXLLRbDQ==
X-Received: by 2002:a05:6a20:3c8f:b0:243:78a:829f with SMTP id
 adf61e73a8af0-24340e4855bmr28667491637.56.1756256761356; 
 Tue, 26 Aug 2025 18:06:01 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/61] target/arm/hvf: Use raw_read, raw_write to access
Date: Wed, 27 Aug 2025 11:04:00 +1000
Message-ID: <20250827010453.4059782-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reduce the places that know about field types by 2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5f19347bc5..9dffa99ed1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1153,7 +1153,7 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
         } else if (ri->readfn) {
             *val = ri->readfn(env, ri);
         } else {
-            *val = CPREG_FIELD64(env, ri);
+            *val = raw_read(env, ri);
         }
         trace_hvf_vgic_read(ri->name, *val);
         return true;
@@ -1435,7 +1435,7 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
         if (ri->writefn) {
             ri->writefn(env, ri, val);
         } else {
-            CPREG_FIELD64(env, ri) = val;
+            raw_write(env, ri, val);
         }
 
         trace_hvf_vgic_write(ri->name, val);
-- 
2.43.0


