Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D293E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSw-00029d-VY; Wed, 11 Dec 2024 11:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSY-00015w-PL
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSX-0007qA-0K
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:10 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so77598405e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934067; x=1734538867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lp6ND6RqUxytAfiDR0J13A4aL9KjQfAUqGM2pRH1+ko=;
 b=l4/DQnHRs5EkyrXQFQfH/oIlUmI8nWfM13sO6tztd9u/9uuQoa5xi0ZZVA0eZviGua
 ZPGjNSyH5rkHff+a+KmnT9QZvL2oE3hTtEU0qHJPc9reyJTDAiEreeKZ0ihU7E4jWY80
 5G/aZ5KTT0d1Kf/ajRLFR6bXCjGnWCZk2IIeRBOp9wNn/K6n/F5vpWjaXvwgFVUObt2/
 8wJfCRU9xh1nCY+quHwJGwdh3d9oB5w/UKmKe4xP+9xFWiYBLvKaXL+z/p0pvQNgbbz6
 nsPm+QYhtl27Adcnxyarjn9pgdg5aLy1qZlxAfBnNRjkjFzNJCREQhbYECUejs71crGm
 QHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934067; x=1734538867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lp6ND6RqUxytAfiDR0J13A4aL9KjQfAUqGM2pRH1+ko=;
 b=pTclqnMGnaNOkqWrrJWMcFa9bvYUeln7S3N2y2Zij6SZ0S5iBb7dFW2PECoMLSakPU
 47QBc8vBckgZlCQ6cd556jea1QTQiTwjhK45qc0Eedb9sLCETKB9d2A6hASZTAescDBv
 Aze2UJr/ZgynI6JkmRrSwLpERV0CoK0xm4KfsGwJf+2pBMSCBbqRvKH7j90VvSllsWnH
 VfKQEItrribbPezxcPHWwr7N14yL4A00ev6bdBS7EJDNWD1Npq3Kpvv3M5DVNplScu6o
 NyjcK1NhU3UGWqtARTuiHobLhDaXmA10WqNhXpGORT2oj9gtULYcOQksIF5XM7GfZ1On
 +KEg==
X-Gm-Message-State: AOJu0YwKm+RXMYeccp+H3cbhmK8rg6Cx0cIB3U911gmaN34RusHgdMzP
 G2WqT/B4NU5EwyS5qh6fU4EAAK9E60uppYV9+4ryquevtVVSdzHUmE8CdUrJzqMZkzDVkB6Ahxh
 c
X-Gm-Gg: ASbGncuShOlhoyrtIZ+SyqeKRDPWIST4Sce6m6xVrThSyGDvsTiR9zvA7WU4S3+g0fL
 0cHeIskrC1x4Ju0ipjOVofJhTTraQYxysIxL+wEu8ol63rAa9Wmex7F1BP3nnHeXSaGmiDJQWil
 lWH5lkxDosKgymFu67RW0/07TouMdrbA2ADf5XdDXSrJVxWFDw6nvV8hV8NJrutWufK206lf6FY
 /CBi14ZEvkzjn85rAE6SqAcMQzOQNzns+GxPt78Rkref+1jKxFxVQU6fbX+
X-Google-Smtp-Source: AGHT+IEoT6geVVer9wEv0tcAkw+ech4MwQIsRJdOgPTp9GEztdsmdFvXJCa11fPeMcnnypooBSv+/g==
X-Received: by 2002:a05:600c:468c:b0:436:18d0:aa6e with SMTP id
 5b1f17b1804b1-4361c396ad1mr30778415e9.5.1733934067663; 
 Wed, 11 Dec 2024 08:21:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/72] target/rx: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:45 +0000
Message-Id: <20241211162004.2795499-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Set the default NaN pattern explicitly for rx.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-48-peter.maydell@linaro.org
---
 target/rx/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 65a74ce720f..69ec0bc7b3d 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -100,6 +100,8 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
      * then prefer dest over source", which is float_2nan_prop_s_ab.
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
+    /* Default NaN value: sign bit clear, set frac msb */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
 }
 
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
-- 
2.34.1


