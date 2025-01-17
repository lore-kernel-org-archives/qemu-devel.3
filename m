Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66CDC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr6L-0000Wc-J3; Fri, 17 Jan 2025 13:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5p-0006KA-U9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:18 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5o-0000LL-4P
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:17 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef72924e53so4221460a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138555; x=1737743355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAiwkYkJhNlr+QIGt+u6tAyqiV7uHPYy+16J2GO4X34=;
 b=HsfBVp2SyIyE5i2N/TV+AUFckmV0WK7bpN78XdNdppQz2O16ynrO2SkFOMOYWk2bhF
 ekEeqr+YmOv7t8GMPy7ZVb8sCgV2xpPNIyDIr3kkBhOaavVF0ZQTaqzNpbCI0r1oXIaK
 EMX8D+ecLWaKqvW6olySImq8xGHClW8MpTwWGwL8CYxkKwLceIfJg7fHlqzgMDPHp5P3
 pEUiRrbGqItuyj73n30JwSvWlSJe4B0Nbn0ONd+0RSR9c1S9PB9hlmoJr783wAR74/IJ
 jNM/hw0R0n6idRxdGtMW0uuwUQE8v6xr6BOn/zMx7onFwbraCt8aOm0T0jZudsnHS1gG
 MS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138555; x=1737743355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAiwkYkJhNlr+QIGt+u6tAyqiV7uHPYy+16J2GO4X34=;
 b=oQEHHy3x+Ib2sCVdWqdRHDbPYobFIVWQtyEZUjrbN+CN0I9fbV1QNxPBS3h1zmbOE/
 4F/dqOshF7P8Vu2G8EGW7alLGhSP6ikQeNzqzCjPQQ2CBzlNMNTUSUGRt6wtc125IlDM
 qoye6mJumEK/1dg2npU+33P+YJiAtNIEgbjvBzfONREIVhPqD6wFuf/XazXkPSCQsc8a
 JJgMZeggVm91Ld3zYzVnt3pi/JYlq1D7oCOP6GgwCAUM6Z7ij7TdKhC6ZcJH3O7US/I3
 9jH8/pcwM1HTSkR3aHzYOr+MHfYNJHfArQE1U9GO8tITX56CNWaBbH952aSlbzW0OwPz
 eccw==
X-Gm-Message-State: AOJu0Ywcza2hHP44xl12+w0cEIFUjK3cm5mpndR+7L06plpgYfxJKb+V
 /fBuwgsjwOrEwCk2+AOe3MSEzvsaag8Ggv3tVWjV8XDKN6zUD09dn+ZCKgXuaaRt0fwzzDHxMMF
 f
X-Gm-Gg: ASbGncsHoss7GZXQ5zvpBJNRJJmJWWfvrSlDprPFgyp0r3XKksNqfpHeeJe5sXEj9Ou
 g3KcV+OrXB85G69H0b6wjZJDOFOixiiejsLnvxJoIOrRxzIUtO+5BRTgfMND9jkMid3AnKIEqkX
 /PefZR2Wb+ndHe7HOWLqr3GU+FcTEh/v3rBIetFlzlQallSWGOl8qxA9VLbzmuNPaIPNS9TG1gW
 ucB41midQt3ULuVBlxh85VHfjffAZciz06g1Z6K8XApH91e2eSJSqES3nhTMe/KN7VRWW6pAGZS
 2sZ1QAZkh+CD4Y8=
X-Google-Smtp-Source: AGHT+IET9LwXabtjzbgxUS2oYUexJ0sAKMhHXw8kAf7BjZ8pG+K8CmBSLUnlV+IirmuhTdGSNBehUw==
X-Received: by 2002:a17:90b:1f91:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2f782c62983mr4984856a91.6.1737138554829; 
 Fri, 17 Jan 2025 10:29:14 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 68/68] softfloat: Constify helpers returning float_status field
Date: Fri, 17 Jan 2025 10:24:56 -0800
Message-ID: <20250117182456.2077110-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

These helpers don't alter float_status. Make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250116214359.67295-1-philmd@linaro.org>
---
 include/fpu/softfloat-helpers.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index dceee23c82..4cb30a4822 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -124,58 +124,61 @@ static inline void set_no_signaling_nans(bool val, float_status *status)
     status->no_signaling_nans = val;
 }
 
-static inline bool get_float_detect_tininess(float_status *status)
+static inline bool get_float_detect_tininess(const float_status *status)
 {
     return status->tininess_before_rounding;
 }
 
-static inline FloatRoundMode get_float_rounding_mode(float_status *status)
+static inline FloatRoundMode get_float_rounding_mode(const float_status *status)
 {
     return status->float_rounding_mode;
 }
 
-static inline int get_float_exception_flags(float_status *status)
+static inline int get_float_exception_flags(const float_status *status)
 {
     return status->float_exception_flags;
 }
 
 static inline FloatX80RoundPrec
-get_floatx80_rounding_precision(float_status *status)
+get_floatx80_rounding_precision(const float_status *status)
 {
     return status->floatx80_rounding_precision;
 }
 
-static inline Float2NaNPropRule get_float_2nan_prop_rule(float_status *status)
+static inline Float2NaNPropRule
+get_float_2nan_prop_rule(const float_status *status)
 {
     return status->float_2nan_prop_rule;
 }
 
-static inline Float3NaNPropRule get_float_3nan_prop_rule(float_status *status)
+static inline Float3NaNPropRule
+get_float_3nan_prop_rule(const float_status *status)
 {
     return status->float_3nan_prop_rule;
 }
 
-static inline FloatInfZeroNaNRule get_float_infzeronan_rule(float_status *status)
+static inline FloatInfZeroNaNRule
+get_float_infzeronan_rule(const float_status *status)
 {
     return status->float_infzeronan_rule;
 }
 
-static inline uint8_t get_float_default_nan_pattern(float_status *status)
+static inline uint8_t get_float_default_nan_pattern(const float_status *status)
 {
     return status->default_nan_pattern;
 }
 
-static inline bool get_flush_to_zero(float_status *status)
+static inline bool get_flush_to_zero(const float_status *status)
 {
     return status->flush_to_zero;
 }
 
-static inline bool get_flush_inputs_to_zero(float_status *status)
+static inline bool get_flush_inputs_to_zero(const float_status *status)
 {
     return status->flush_inputs_to_zero;
 }
 
-static inline bool get_default_nan_mode(float_status *status)
+static inline bool get_default_nan_mode(const float_status *status)
 {
     return status->default_nan_mode;
 }
-- 
2.43.0


