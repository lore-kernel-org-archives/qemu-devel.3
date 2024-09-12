Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42387EE57FD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZmD-00040l-IT; Wed, 11 Sep 2024 22:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm0-00034H-P7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZly-0004Bs-WF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-207397d1000so12570275ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108890; x=1726713690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxtmNqmck/OIJOdLsPx3DowunmnWeT0vfej1ZczH/vo=;
 b=cOemehlhWyybeWQYZtwSGN0Qb5uxB50l08AXKAuwZ1SYBtq7DZoxVMmixOb1mL247M
 ms4xr8OTeuEpWMCAi5iSWdC5qImSS/2TrActlsYl3krxvZdfxATXkIuLYxFQYwH5M9kN
 I3G2NRodAmiTr5owAzma6Gbrj5Y8jpsbg023ezvhyC5oT3A7dHZ6zK5o3avv3x0Nsyl7
 cZuU+FgfzxSkjxvLCt5HsPHIATh+66YsVgFybZORMsL/S7fEKPgMnk6JrUTnCWK3Tmy6
 jgStsSw37SKvBQWY9d9ukRmLeXwHh2WHET4k6OYxd6I704iAx0A9cu7WISy/4CTWznFD
 A7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108890; x=1726713690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxtmNqmck/OIJOdLsPx3DowunmnWeT0vfej1ZczH/vo=;
 b=lq4y7/8/917PSZF/pDAMe1CFU/1I76lmUyNf+46ZOiQ0aQIRjavOKGHPe5N8k1tv7n
 +wn8rfq5cSXDO6QeUCbpASOIM6pkFLQ1k2Nu+6lLvLSUe5bpJU8WcHnt2xvCeOG3Lb7M
 L5KcX27Ia1oILUs5UsJFwd1PDNfbrS4nFqa0bn2KmQcVjBAmwPk9CXYM1cfJn3tigLHN
 0CNyKdYTS4DDTIuW0HpnpUIGV+yjDZ1gIYLNuA3bKJEAiyee5Yj3FfHfxF/t4tSqyzvO
 gyWZXjRmbdxXgknZitzU5kunKHSeACe+QspdIg/1bajZ3c2iYsP94h7lC73nAxCMacAq
 Q40A==
X-Gm-Message-State: AOJu0Ywq/ikGi7nviutdHwxWq6qe39wsA2/HWTsiTTcwCf1b7g+qKkmM
 Gw/0qNBtwNt2JsUCzy2gFHbOaAL32vMkc3e83oINVbYTwGY6uP9g2eATqJNXrh45uDPLBbG6eVu
 a
X-Google-Smtp-Source: AGHT+IEJHV5v22YLjCiXoys59vkn7Sskqa/qEF0F7LbuL1GSisqC3Th6diHQaVr6CNGBuoG4c8VE8w==
X-Received: by 2002:a17:902:fb0e:b0:206:a6fe:2343 with SMTP id
 d9443c01a7336-2074c5eec88mr73282865ad.8.1726108889704; 
 Wed, 11 Sep 2024 19:41:29 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 15/29] target/arm: Fix whitespace near gen_srshr64_i64
Date: Wed, 11 Sep 2024 19:41:00 -0700
Message-ID: <20240912024114.1097832-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


