Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5ADCCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lIy-00020E-GB; Tue, 14 Oct 2025 16:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIw-0001zZ-9r
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIq-0005Jn-F1
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:29 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2697899a202so1826495ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472440; x=1761077240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83gITCsTSz6Z2rymdsqW04YSPMva2dhKn7k0rNEW+ko=;
 b=cwYpe8bE0Yvzh6TMNLlB6mSkrDO/qF/b4mB2wGIQ7ujWHcw8LXmeZyxywLJRDwV2GX
 exsVCpaA8lijEQz438BmQSfdlRyiGHuqtDi2E9gVrYm5bljmNXojx6vPU7irOevPyotD
 h0QF5t/A83BMdDzSfBJfpTybmmGp46Dh4T/hHngkM3yBq8oqtuqIDzSJdhFbVHolpzLk
 3jJdFQiGbtkCqxdwopy00H7WxjsUIXqctl0WSKjvBQjP2KiLplIDvKzRHcRcve2qCZU9
 4r+i4vTL5C0mZZsEUNQDeuSKp06soX2A7d7l9OBx07ij6uAi2aGTeL8FVK1Nc1wkg/Ya
 yHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472440; x=1761077240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83gITCsTSz6Z2rymdsqW04YSPMva2dhKn7k0rNEW+ko=;
 b=p6/gXswuYfYq8qvm7Kqg5OaJi69Npc1o1VW5NqICACLz2jCFwBNyobYbqStMxxqPqK
 zQq2m+5pcLozeNHcUXwcxTXX5Xwi1sxx3uK2nzAY+QvHM+9TEi1EDdtAKqyaOWrnK8xR
 BGoKxtF0qxu9J3REPrkHGcxE7qOAaLRZ4/VZHjcdNOU0udrPDVqy4iufjujUQ9K9ny74
 +MajOdbtMEKbVy+DI/mpfLJ/jU0MZfyzilTfPNcEACAKibayEpijmXMyZZES1aTYpdek
 x+MSIIBF4ACQidrIlbQwTGWSICcS2LxRKnvx07ryXOKZNhlxJTqYEGHT/uDx4jksov9v
 71Tw==
X-Gm-Message-State: AOJu0YzEmtzb+iqUVGIpuBzzl6YYZHfma+zyj8/G9RjBi94nvIMvSb8+
 Fd9rKHBiGFNZ+oRHtHFUpsGrZHtJcJTyMu94MznMJzhYNZQWb2BHwwfPYFS6VdX2UYHTIfLp5cX
 u+uPIZI8=
X-Gm-Gg: ASbGnctiabwsLmyAiEWkT3wa+RktZf2mdpUm8olwlTg5zBomTYh3HkZaogAlJtHnpae
 bIEc9d+B1Avd70mtgt1epDN/fBZiVbPwDM7KzJZNYTHU+OidKJuqMK4m/yiIBPD/k7VAZF0IyJ5
 ez1ikGGXIVMHtztIMuKwp5mgBanW03AtQ/V9F94BTmRvsn935QiATDKDAToSaAhBieJJK6duRXE
 rWJyTN/aly8TOoymZPM/ShVzAjaW4A7krLra+D6gbYKE1uuN69K9QfGnPAMwyFRYAgFAX6FNSq8
 C+/ekwz848gFUhC8Vm83d9MBp5khLLwS+PDO+lLryKzCPIqBYk9QlkqrW+AEptiuXbRaNIPGc2j
 j72jU4K3H2JiRzVZOfNyVMDpdfJW6DFcM2xQCgglvZVH7UpsCiFA=
X-Google-Smtp-Source: AGHT+IGttS3HusLzPEQjBbOn4URsYgIGZ8JWt57lHAZ4NlDOxPAE7DL1Rn+1bZHTbL2m2zRycqNiEw==
X-Received: by 2002:a17:902:c410:b0:249:71f5:4e5a with SMTP id
 d9443c01a7336-29027f3e32emr368783955ad.26.1760472440113; 
 Tue, 14 Oct 2025 13:07:20 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 01/37] target/arm: Implement isar tests for FEAT_SYSREG128,
 FEAT_SYSINSTR128
Date: Tue, 14 Oct 2025 13:06:42 -0700
Message-ID: <20251014200718.422022-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 579fa8f8f4..9b7fdde0d7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1019,6 +1019,16 @@ static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, MOPS);
 }
 
+static inline bool isar_feature_aa64_sysreg128(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, SYSREG_128) != 0;
+}
+
+static inline bool isar_feature_aa64_sysinstr128(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, SYSINSTR_128) != 0;
+}
+
 static inline bool isar_feature_aa64_rpres(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, RPRES);
-- 
2.43.0


