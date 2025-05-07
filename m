Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474D1C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ3-0000YM-Bn; Wed, 07 May 2025 19:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPm-0008Pd-Jg
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:02 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPk-0002W3-He
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:02 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22e76850b80so3228315ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661379; x=1747266179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgtSyivanfJoltGbQqPmVVFicsFn6el5hIn8rUX6RjU=;
 b=SXDscA7opORf01xBezOA16IBaT1HYl6ZguFrMYFQBzvi7PF0yf/K74jPhCDuBJC5LD
 WOrCt0wOu22m7xfGHewTuTZqEQcBOHgUbrEg/B5NaSXKcdQDv7rBVOUgMWmHyUlf0skH
 LLmE6qbAHqk1x6hzypclGwa0UmJUhChP1oaudLQLpwPhFAyqhOD1pJ/CT9tgjTayEjTc
 qPRKwPwVoZPBFD3DJu2zhbCZzBtI5u9Hf8dIrgh8+dvbKlWYKq0UdsynGt8jk14Ns7gq
 EyYyaoaflR+pf5+cwoX4n+ICXLNY7Hgd3ihgjGwwyTUUVtALxpRw5hfV9XSm5U9aANuC
 CYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661379; x=1747266179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgtSyivanfJoltGbQqPmVVFicsFn6el5hIn8rUX6RjU=;
 b=w2kOMSHuAGYJTWk3GZeCq7nkKhk5rWpTjFqpWbiyTWYWH+W7sLtXg+GJ1IT7PTqFGZ
 G6D33WqiRyVzoHz3n6FCpJrPpxl+QFFpsSrdQE/oZhATjkUWbCAfVI49hoQH2UiGJ2bN
 8qsaAIp8fkO93vGkBIbuESE3yIgpPODaSkHJ0e0UT+iYzI0TAfqTkF+sJe4OoCifjPrC
 V0AsoGeUxaaPvy0EphtwqenBEr+VMj7jP/2MLdRrmtH/F5B/+wEqclWMThPTSLAQqbXt
 HPD3aufvz1EkoQZijw9QshjWQbpipUE7Ggi3m2GTNOTehHeV7YUMNe/hY51/q67IRb6M
 ZTCA==
X-Gm-Message-State: AOJu0YzOTYkFyuSzn2i2hc4dRrLrbKTA20iY8s21hInyoUDCH6TUPseh
 PBKaTW33GVWiRnRCuWOc9dDuM8vp/8uZvZ6fvpwYn6RiJKcmv9oLzXGnKwCsN0+Vvwri5vybiCK
 ADquuBA==
X-Gm-Gg: ASbGncsn9RIfMCLvrg+QMYBCvVNyX2ooqzk3YDzSWrcDgyL7GighY01IZVS0t5omf7O
 S7zCeNNKFeRUXbx5SGSYMXnBzoReOGxYzSDiElrZJmEnZXopKKWB3yfELmeW7CfsmHHWYLuyird
 CKD1f2yZU/IqjYFZZzFQlQ5AoiJIzRGOfhODq5uqzfPJ3yssX1n9R0PFgHzchUa0Lir3uUJcv4h
 g/tpbVFx6va9CdGij5baMIBc6ORS26VDX6TFSMYHOEyZdVSUcwCpTXTz3WMgt1BqFnkU9anH+fh
 DVVQn5KYVx8zNTRAhNHRDbQf4/lxt8SQKe2Ew10p
X-Google-Smtp-Source: AGHT+IFZtlB2FlSxHJFsDXQB3WyDA4iBd5Ccf1T5vX11nbBzlbCtPEp6lNvox6Ap3RnU2n0tDbAJyA==
X-Received: by 2002:a17:902:d4cc:b0:223:325c:89de with SMTP id
 d9443c01a7336-22e856138c1mr20153195ad.1.1746661379102; 
 Wed, 07 May 2025 16:42:59 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 18/49] target/arm/debug_helper: remove target_ulong
Date: Wed,  7 May 2025 16:42:09 -0700
Message-ID: <20250507234241.957746-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index cad0a5db707..69fb1d0d9ff 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -380,7 +380,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    target_ulong pc;
+    vaddr pc;
     int n;
 
     /*
-- 
2.47.2


