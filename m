Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AACC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hK-0007cS-G5; Wed, 02 Jul 2025 15:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gk-0006ol-AP
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gX-0003E6-IL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so187884f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482794; x=1752087594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYagbleC/hcq8JgGV1mXFBe9rSbch4M6pqZHxCjKKEU=;
 b=T+102yab3decFmKQr9B45tcUUDJRYBbzhUwCY54yBbnaN7ZNVpfV8lEAEiMD6r9utY
 JebMF0V2Rbj+m5PMVQy1+Y25bXpNBdAmfA32cCwVvUBUVFCoReGrzFRWzhqOin8I6JqD
 oqvZ39cWBNrTp3S07hY9W/XCkAHoJqFNSz5V2sMwLNpYRO7RK8E/keS3r5Bt2mmB1kjZ
 9ENZ6tfr+JExQTBglMly+COpDEhPsxA5XicCBqjN96leA0ncoTBEmU+umd0VVJ5fkwgx
 ERtAF44fPuM9XF6Av8SNYEBEjK4PGaYNClaF/lzQQ52Ff6Nmm158F9mR0x9piUbQDD3y
 Z2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482794; x=1752087594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYagbleC/hcq8JgGV1mXFBe9rSbch4M6pqZHxCjKKEU=;
 b=iZAy1L/VODFpsJUmRKeDrdpHjViY/E9lXSAkuVgBuUuBd2ficrH0MFNNjC7xQC64HC
 nHV4sofIIeXHfnP3kecOkDysOfcZE2KOug1Q0zHZqpf0KhB7+36SI5RfFtTcpcUfc5CF
 tZa4KAxA+WVxvKcNV2DuOtmJW4GzaGq7nzf9dVwEnUI0RlGDicQ32lxUPmIvOipf/431
 N3JvBF6GH6Q3GyPTw0hjBcVPujXB0phAXK1RgRXD355VsfwVzs7dMQhR3Mh8x6uiTd1M
 mMT1zXTgYPzAtfze/R/2SOvvunQ93l8QnhWfOJRTKTeQ+5WjIjt5Z+BqM4xJgQeO2McB
 BjfA==
X-Gm-Message-State: AOJu0YxV40tywFLIzrRON6fKk6Cp5PMIuTy93imsPrBSkM4sd3e13Z8w
 5IKk7gjrNM144oFlrclXbrJj6OfpZfLNXWs+ESgQ032j8FPY+LRP0nUkj2VOTILPJryTGpw5m17
 18mmR
X-Gm-Gg: ASbGnctFv69JQVdAeirQ5StC/qpEh6D4C88CWx58fuNEmYCNLoAvRumcRjQwaprDB0k
 7ofFdQFoPtvv7UWRzgm1EDVxpy9FGUnHx+RLL5pVQVeJ0Cfq0rVedQLSX4M167lzDZdPgBCjwIi
 hLtibzYostC4DalkZOMlZDZk31ooLLJjKEVkVV+OOQ9lmcGxrlak6Q4lLn8++7MSWi1fe3wsH14
 2omsc7DIqh8HC0OKr+fEwgNWu26OdeGd154kfnM1XZmdNzBtK7/Bbw/f2SgiaeDWTE0AyBtNpME
 xqBVVzBjFdNXxSlkmjqVpDKQRv6eYueL4u3GpB2Id96NmRdUak+Vesd6eHZ6AnbX2DZrGfZNtyP
 mC+s80c+xvdrx1KgB1jSWlBqO/h71wb5f+17z
X-Google-Smtp-Source: AGHT+IH7JAtsFhmAb1AK63J5iC2PtfQNAlI4jKPIiYPgGu15QEkXDCrenr2fwUZnfBmSi5gFbRvEjA==
X-Received: by 2002:a5d:588c:0:b0:3a4:eee4:f73a with SMTP id
 ffacd0b85a97d-3b343e5304cmr37690f8f.22.1751482794439; 
 Wed, 02 Jul 2025 11:59:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5972bsm16895261f8f.68.2025.07.02.11.59.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 54/65] accel: Factor accel_cpu_realize() out
Date: Wed,  2 Jul 2025 20:53:16 +0200
Message-ID: <20250702185332.43650-55-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Factor accel_cpu_realize() out of accel_cpu_common_realize()
for re-use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/accel-internal.h | 2 ++
 accel/accel-common.c   | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index d3a4422cbf7..b541377c349 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -14,4 +14,6 @@
 
 void accel_init_ops_interfaces(AccelClass *ac);
 
+bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
+
 #endif /* ACCEL_SYSTEM_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 24038acf4aa..de010adb484 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -122,9 +122,8 @@ void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
     }
 }
 
-bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp)
 {
-    AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     /* target specific realization */
@@ -147,6 +146,11 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
+bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+{
+    return accel_cpu_realize(current_accel(), cpu, errp);
+}
+
 void accel_cpu_common_unrealize(CPUState *cpu)
 {
     AccelState *accel = current_accel();
-- 
2.49.0


