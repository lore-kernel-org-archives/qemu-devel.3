Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FF8C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1D-0004Pg-9n; Sun, 04 May 2025 21:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0p-0003wy-Ca
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:58 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0k-0002ZH-C4
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:54 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso3334316a12.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409968; x=1747014768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaY3toZMvHik6Oxfda0st+OdZGZoqXe3KmHGIqEM8+g=;
 b=kEnksYJdcdwRz60V/NYZ7YC78P8UnH6IkaNuAv+PjwGH4jhdegGHEG8xZnHij/7JLu
 ts7gdM3lXpkC6C/1KQLWdxTDV9QZLgTNxKDMP/7EeUAuNgmoAxdwf/DTYqNuufJJsQvi
 29hmfWVmD0H9dAYfP1YFSO8vw+/F6rQLxDxnVhJNTcy7qm9Fz19sEcBRGVQ0q1t8slX+
 qwiz/i7Au4clcvorv8U8//cZQJDWU0FKiTBeaI3d8roeE41rnKqFiSV651qg0XJHuqQ/
 k+M/NqzitmtKMnSng4uCvHWMiNk9ixRLETV0XInoD1AZG1yZ4nDmVx91dInb2B8aoKID
 zbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409968; x=1747014768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZaY3toZMvHik6Oxfda0st+OdZGZoqXe3KmHGIqEM8+g=;
 b=BJG2w2nVXckph1jE4XQ5txcjfCXwlSG4k+3dEJwj+cpBNxD7EWaTXN4VR0ef/LIUZh
 Ee02Xapny6++yr+Znx8CE4Ypaj4VEYPQwO96PfCxvxRIzC2EunwkgUYQu8YBEMka1l7q
 RfIIfhpfQIa52K10GVrRBIYlj3sH/+Zxn/SOBl9DTYSio9dO8ZxS83/uzotcaIXbUDED
 mGWhsPsnCM1KqLPSgRWpmJJejbbuL3DvdNLoAQVTLhqECdBy1WDXTEWbwzY3gypS/0iN
 Dp8bjU/GYgwE4NQCBHXtyzApYqgoQTQxJuPhh9siHevcPmGa6KVF8TnT4gSjYsGPSe5P
 0jKA==
X-Gm-Message-State: AOJu0Ywia6Z7zOc8ayPOx6cE8WV2SuTPBmTIT9ieyYDbsPafG2GaiDsO
 s3VH1hSGbcGVatGekPiy6qzQzGwHR+6k1Fhyp440Pb1szStfhzehTSHpUrCOTSG/woat/nCDKNi
 O2ts=
X-Gm-Gg: ASbGncu7+MC40RB1NVfa05Lk//aofr14LfYzrdJTpD8RAL6yTyTq2GfYczNNRQnLDJ/
 jdSQEvIjOk5ApgQhdZpE0Lq4wD3/GuXOZnTbtP0bMgVQqp99fHE2hfXNvQhsrfjOy4iUd34obPk
 Wai7uZ/HnMnlPvg3Mua8gHt7yYkxP3fyyEEwa2nMmQTpq8xYbjH/cQmNHE3QN6hEFxrI4u/BkVZ
 94lC304xbHtfOs4rLuJzMGgsD3c/sh8HoJoyJ2bisqQ6k0GP/xvqaz0G+xXaq+5iOssTF+lNmt5
 YobnKbM/VSMEK/r5AI35H/3bYP0hrJV4sUUwed7I
X-Google-Smtp-Source: AGHT+IGMm7xh0qrjrDmS5dokWUiqHyCM8ckPHkrd3OnayFEN11uivxurPNZNriZNLtkAQt4mHaKPwg==
X-Received: by 2002:a05:6a20:c890:b0:1ee:c8a4:c329 with SMTP id
 adf61e73a8af0-20bd47660fbmr21220313637.0.1746409968309; 
 Sun, 04 May 2025 18:52:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 22/48] target/arm/helper: replace target_ulong by vaddr
Date: Sun,  4 May 2025 18:51:57 -0700
Message-ID: <20250505015223.3895275-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 10384132090..7daf44e199d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10621,7 +10621,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
-    target_ulong addr = env->cp15.vbar_el[new_el];
+    vaddr addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
-- 
2.47.2


