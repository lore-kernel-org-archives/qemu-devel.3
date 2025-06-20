Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB35C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbSz-0002LJ-U6; Fri, 20 Jun 2025 09:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbSl-0002KK-H6
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:23 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbSj-0004Uf-EW
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so11615095e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424838; x=1751029638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBZvBlUJJ4ZZzRhwp1RRYC3txHSba+iTcUIOSqbdq4E=;
 b=MBopYqoTNqoPrTtBiwCSqOW9yAdkqHrl/Q/wDgnn6xq+OPWcioOWHlXeGl94fjTIxF
 ROzgjT+co5iUhycIZN5eeDqenmEvnr0YGHrGwYmMTMnuzNqRKi9J/UqzudFDfGpBXlgy
 aUsNUSsa4DXXIfOwbvmW0I6I6i0WaNAbrxYBzgS0YixcHONlwD1aVV8RZxmM3bP2R9BU
 +W9pKTbi143ZOOz3XTsDLGVJoAnxYRb2pQPJcDdNxTxsq2i1TyWINvpS1XUPp9Rq0RtL
 zh3y6lDLweGgYF83p9DCyXaIsj+qNDtyUPwN6G2DiNehZBqdzOO93q7fRNMRRcQ6gxcC
 TXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424838; x=1751029638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBZvBlUJJ4ZZzRhwp1RRYC3txHSba+iTcUIOSqbdq4E=;
 b=NRMMQERtE9NVieAlLoA+LF4KDolRjFzTIaY1QTUtnUiJe/g/4XmOFYnYSrz106maj9
 Tg1rNlfifaqA1P2+yFaG/gaoFSbYVaqaeg4ZruS9vkmYIoBs5zscFLyWhD7hc+EaN198
 bliWDYjO5P4XIFGI80PWZrGFcEk5F+oOxGlzH733gxfPGiIgdxdCUt+hiVwRs+FzYeXK
 2gn8l8eUTBlqh3PFVNNBNepTbf9NWv4bvVZqsXVTy1rlKqxGZraA3Ld4Tl4/9+bl4WSm
 T7lTFLS2tEMC67j0PEo05Gd+eJycIpRHttjiHsALMOoLQG0gKyFzfZOI6hwZ/J0V4jGR
 RwwQ==
X-Gm-Message-State: AOJu0YwX7+WmNwr0i+vbGUwTx4fN0SX49Fm2B1tNOIz4ElZvfzlaUGDA
 Tsdd3o+1vlYuk08P54SFsjISqzLxCELQAU/suzgfOcK4GOWCBUPrMlUT8WGrXJvkIktWl3myXSk
 GY0vGa2Q=
X-Gm-Gg: ASbGncvxkN3rhKD3R3AHGMCkPb2ukSiJN0v9D95WGDg77xmkOwuUfG6udum8sBwU0+Y
 nQzZimKuh1hklynr2l1mLdR25IKKMAnylz5Y+n6+czUmRPKkKAwNdkvGfj+4IYpg8Z2MXhHOkRB
 4CUPoMe2UINbtrAoQze+afQJ3t71oVCxIVlvAYr9n9SlOUD8bOi2F5l242MK4shJIaf0tGsOmcK
 aItu+Rrprac0GI/FQD/+CSlaUHgQwNY6ygr+EqbHCo9HweIGZUqsxXvPRxvYHXziUbXdiy8NXYB
 U5SOo2zo+IAPsgl2hpdOYjOrAFzjvFXULfeX9OlN+mXSEydhuWJDA/4m2Bty7OI/HJt4ttvlLjB
 LIArk8GoED+Kx7iWjFzVC23yeYIWNAEx16+D4
X-Google-Smtp-Source: AGHT+IHkCPt6KL3uT84KaXQEf8w6Zl9aLccw1KatAjKZiNkbl+svh0rrY7kI5cIzTp13dZSGCGViFw==
X-Received: by 2002:a5d:5e09:0:b0:3a5:39a8:6615 with SMTP id
 ffacd0b85a97d-3a6d12fb239mr2292246f8f.11.1750424838047; 
 Fri, 20 Jun 2025 06:07:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb692sm25426765e9.2.2025.06.20.06.07.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:07:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 01/26] target/arm: Remove arm_handle_psci_call() stub
Date: Fri, 20 Jun 2025 15:06:44 +0200
Message-ID: <20250620130709.31073-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Since commit 0c1aaa66c24 ("target/arm: wrap psci call with
tcg_enabled") the arm_handle_psci_call() call is elided
when TCG is disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3360de9150f..5ed25d33208 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -650,16 +650,12 @@ static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
     return false;
 }
-static inline void arm_handle_psci_call(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
 #else
 /* Return true if the r0/x0 value indicates that this SMC/HVC is a PSCI call. */
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
+#endif
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
-#endif
 
 /**
  * arm_clear_exclusive: clear the exclusive monitor
-- 
2.49.0


