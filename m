Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39E7C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0ay-0001fC-4o; Mon, 17 Feb 2025 07:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ae-0001cc-KW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ac-0002Gh-5Q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:11 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43967004304so19677045e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796667; x=1740401467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bvvc3Enq3kGNn8bnjLiI+WAHa6xgA+KATFzJxNZXkg=;
 b=yp9GJhgWrBvnRBugMDnIvPpbhlKYh0pPOEB5gl2j5xBkLZFw68WezlxSP6EhLMXX2U
 GXXfmhpecuwS8Krvk34+wUrPvqpkAavfADZBFrCiXGjoM4i+KNqV6ERase0rnxHs43o3
 vMIqIz6Q+nbhSd6fBgBE1YZNJhUV07LpKV1Td0zSKKgpBsVPDnc0yuzXATOzQl5Dzp5l
 JWtmIFB2rBVKdi6WZcESRwKccYwDqFIm/Vx/lPSvLfwS8Yed7eQmx1sQGGeu4hHp6vS4
 RTpWs5ygPMKC1Wjxa8X8XTg2/6WYuk+zOg7/gXBiMLykcQ2jR+L0dHmfchSXAlkfr3id
 5kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796667; x=1740401467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bvvc3Enq3kGNn8bnjLiI+WAHa6xgA+KATFzJxNZXkg=;
 b=uk04he4BpkyidTZWR6SwjRXZ8TQrAObCHYgorAJh6liPFhYzYNBz5ytXIqy6NTVyWu
 C9EfWrYAEzmTwZFti+XeG8/pxpAMe5OeJNh97C+/4arPk9EWf39CnUiNSrJ6njT9Pa5L
 TnftX7qAvZ5EXbO8gQlfRZh6Anl2gt0mq/iFVudziAr2x44YXoSPIL7gtqC3pbbcpE5z
 HQH2DHo1VmdurxcysctFNEptczafWVWi7qUJE7uPu0eS5MokD/XCFwUTFm/kv1xZ949l
 BuwA3ePRxtMlMfcfjwwytzjNN9s7GNcZhMs1jXFBaUB6cVc87YXmSlAdXot/Iz894Zdw
 M5Cw==
X-Gm-Message-State: AOJu0Yz6g2DGQ/A5dorPzF65uBYUZJc54L6e4DCXrUtGy+VyOYlkGVYD
 VmjU9ujJxTlQXyP7wPhWmfa7O+CXdv0d3LFi/gG2+u6PDi7Wad6RE89vxpHZTTYHcpy5g8x4bKF
 z
X-Gm-Gg: ASbGnctQfcaN1OJXPtyZIdkrELaolswx9WfSVccQfXQ6wUgAmrhE+jZtTUNJovy70wO
 Q9147CeiXshsfxzJrlCTI4bHWLm0wvk4QA4vYfTtUBDNCVACNPaps1T9w9P8rlBR60qmtuKVZ8l
 geviBQkyw1JlhN++y+cPAHuJFYI8L+pOySTTMv/b5nNhG7bs1UCrt3u65DlNpBFmsQl/Jo18+/3
 kbxKIOFATa3SuukFE/ExJ/Hiu0uWUgQL5IvTiiOU8GS0OZznUu6XgdImw1EY13k5UWoIhIfam40
 faV4R1BSH9Wx/tOrXAwVmQ==
X-Google-Smtp-Source: AGHT+IHHr/C9u41NmZE6ncQEk5MCcDIglHvZ2OQdFIo+cLKsjW3sJDHNpaBWKZLSScnCW7tlUkbL0Q==
X-Received: by 2002:a05:600c:3585:b0:439:5b36:b4e3 with SMTP id
 5b1f17b1804b1-4396e6e19abmr80561085e9.12.1739796666736; 
 Mon, 17 Feb 2025 04:51:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:51:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 09/10] fpu: Don't compile-time disable hardfloat for PPC
 targets
Date: Mon, 17 Feb 2025 12:50:54 +0000
Message-ID: <20250217125055.160887-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

We happen to know that for the PPC target the FP status flags (and in
particular float_flag_inexact) will always be cleared before a
floating point operation, and so can_use_fpu() will always return
false.  So we speed things up a little by forcing QEMU_NO_HARDFLOAT
to true on that target.

We would like to build softfloat once for all targets; that means
removing target-specific ifdefs.  Remove the check for TARGET_PPC;
this won't change behaviour because can_use_fpu() will see that
float_flag_inexact is clear and take the softfloat path anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b299cfaf860..b38eea8d879 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -220,11 +220,9 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
  * the use of hardfloat, since hardfloat relies on the inexact flag being
  * already set.
  */
-#if defined(TARGET_PPC) || defined(__FAST_MATH__)
 # if defined(__FAST_MATH__)
 #  warning disabling hardfloat due to -ffast-math: hardfloat requires an exact \
     IEEE implementation
-# endif
 # define QEMU_NO_HARDFLOAT 1
 # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
 #else
-- 
2.43.0


