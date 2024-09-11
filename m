Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0217EE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKb-0006yT-C3; Wed, 11 Sep 2024 08:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKZ-0006o6-5A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKX-0007xR-CD
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so17583735e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057215; x=1726662015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPDjaRNSqW+//4MAf7iMwolsYWY7f5O00bu8nr1h9As=;
 b=NWFUa6KEyfPADpUcWqN5ZYy4aoqcUJvLuClSXL7mwCrmKwbCI9VtgN34TAKtpQDp7P
 Ne1GLUSS9Dzq9Qu5x1pgYQ2/d0gCRXrbZAUN/6RoQK5fLQ438Al9RX9VGweXTzRnBtJk
 515mQLpBBdInU1NcLky8Vt6F27t+I0K95ou0BeTHyPyax8q16+5y9L2WYRr5a4jKqxAC
 u5gQwMyPqwFG8e4rONPRiv6tmbHOSxvY3qIt9K5XWBwaDpnjfoTLM4cdUVJoRPHpRhKw
 yDek/LOJtv2G+KUZz5dzg1HBSLBMpvm42ILPVjquycmSK3C48GZskOK5HulXF00pl4VH
 IGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057215; x=1726662015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPDjaRNSqW+//4MAf7iMwolsYWY7f5O00bu8nr1h9As=;
 b=DJlkSqj9E+cosfMoY7WdfKcRCoaM9lKe1Ls5NpiIuD6k4mLtVw/Fd+2ATiVblvz/G+
 FNvZY3h4lDu2ofPRxKUkc+CVFxAGtDWHaAXJRtHdDyGDqNsBWHuIzL2hi4RvPZYj8qSx
 T8kMQMLUs1B7AC2qOj/nCZuJgAb9YaPVQYDEzV6n0onnvNDhOHl7oCfczIERhIlpuOX8
 YzOvQraijFc/mpA/z3Qc+ReGL56rIvQfHNTA3PN84fsBkLg5paYO4qAaZszugrOOEsaU
 qx70W7ZMkxdNl+OBhdvbbq6DGYDE1h885EBbfZX1E0kHXNeJc3m21+apIXruEbtXtGEB
 t6VA==
X-Gm-Message-State: AOJu0YxyYVoM+7AUvo3YJnEf8KxCBuC6Ii2LSWRVH6DH+G92SIPipfEI
 BmIqYGK+dl3rBXnjOOg1ZsRuAMXbAcKCOVG7LmZTNq5a9cCPt1Cw18PQLct6gDbCQHRl9y3bTrR
 b
X-Google-Smtp-Source: AGHT+IE4AQtL13Fr3jqHVgR5po9nRxxuLvuJJ1hjMUAMyTm6z2VHhxJuV5Qq7xhB6H3eUnFlnTVetA==
X-Received: by 2002:a05:600c:4706:b0:42c:c401:6d67 with SMTP id
 5b1f17b1804b1-42ccd30c292mr21063755e9.6.1726057215394; 
 Wed, 11 Sep 2024 05:20:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb2f86488sm124364265e9.15.2024.09.11.05.20.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:20:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 52/56] system: replace assert(0) with g_assert_not_reached()
Date: Wed, 11 Sep 2024 14:14:17 +0200
Message-ID: <20240911121422.52585-53-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-11-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/rtc.c b/system/rtc.c
index dc44576686..216d2aee3a 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -62,7 +62,7 @@ static time_t qemu_ref_timedate(QEMUClockType clock)
         }
         break;
     default:
-        assert(0);
+        g_assert_not_reached();
     }
     return value;
 }
-- 
2.45.2


