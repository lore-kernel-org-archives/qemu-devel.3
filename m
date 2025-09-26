Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1ABCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28L9-00080u-Bo; Fri, 26 Sep 2025 09:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28L7-0007zG-9f
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kq-00043J-SP
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46b7bf21fceso16253865e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892675; x=1759497475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhNLGhktRTwuqsOnekbBybX9Mdf7SCvwNPr0M3/Sc8c=;
 b=T4BGZEoW5Z17l/kyyV2UU0dUAjbRp8njVLTJW10Twa5thbvHQwfv6TKlzOgn7MMjUO
 9IfAOnkcJj3j/KmQlYEYrDj9Mmt4tAs0trWtpkKj7qq3tL7zwwpOS9A+nZpNM59GR70+
 iMk334vNQY4CFobiJnxBDkSiJHiZtwgjPH0ysmRYYsts4ZtrQ9+auwAykh5UXYISEujp
 oUZPOzmRlW8jiD5GFpov/Xz9QBT9dXVragPkShk7mVHtr1KexJaeuoHa4Q84t3NAydwr
 FKO3b7T0LMXSIjvVaCdB8op+MwK4iyVsacxelAUU6t0VtwlQ/Xzum2RKafQrmXRCOuPH
 lv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892675; x=1759497475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhNLGhktRTwuqsOnekbBybX9Mdf7SCvwNPr0M3/Sc8c=;
 b=UEDVHihUU8xHOZJ291lEVc9yelfEROlIul3KzZBvE72KH1iVxJTbIisrT2Z4/SD2Io
 CByqmQV2CsKSxwz1IqPD8giD7teio6aEpfFRXjZN8id5LKVKar62FQmtAvf8jVywD0Y+
 g7WRTyTo+WU17U0tloxb9HSOfvvXyhgMaFigjpil4wdDyG8HapINE86bPjC30ZjCrRMZ
 aA7PrfgkRCLCuEXRwlOvzeWqPvZAMgasuzS0AfEIMPWuP2qhV3COkvBksmD0Ep5UjUCC
 hnY+X5ys5SiGcD69x1dkrEPLfiVYwDzPVgwXBhS4sxw5zXIsF5bsEGhnKkuCW6muVIOC
 BaYg==
X-Gm-Message-State: AOJu0YyCNyYTVo1E39DluS/hUyjg/zX0Rfb7eB8qq48zo2p/lk1IUClY
 M4YoRrWrf07+E/tRIXxAsOKUNZam9Fee2GNFpGfFdR4Nevs7dQu1uVEAHjFkKrw9IzA=
X-Gm-Gg: ASbGncv2YVyeS+QyFBD9EXXVM0966Hw+VO1UgDC5eAgad5EcjIvKYpKjo6tVO+ZPIDG
 JBlrL2hI8VrWoI7Ibf0gGKCmjb4x6lv9omIxkteTW3LipPoMHn48lkYDV7wYR9AS9BuV+W5ty/2
 CddZRutjUeJOoQK22OsEitODpwIVuJ3ipdQB3ldLDDeOy0qhsQL4HP5h677kVvMtGEUr3UoePkX
 q1VsT1vMxwNEHzT+eiFYwfczOOnfkyLvktmCFgYkup4ZAtC30N3KIdW+Ynw5t8hl+zDZ/nEOmra
 1RezbXtuXHHutgfqFQ388r0AY1YAt27Kn6fBSeRoQFNbagB5bzHojAAnoEe/EIPTX5Ncga/5M+A
 w/NZr4+Wo24ym98dwWtBcHgw=
X-Google-Smtp-Source: AGHT+IFOZ23h9C8Z9aOz2rcj7V/Zo5VGnV0+DO934XKhH8P+DB7c1tiq9zdkb0vmfxc3rVroUPII9w==
X-Received: by 2002:a05:600c:8b16:b0:468:7f92:5a80 with SMTP id
 5b1f17b1804b1-46e329fbd2bmr55052325e9.27.1758892674712; 
 Fri, 26 Sep 2025 06:17:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab7d4e3sm116908845e9.23.2025.09.26.06.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 612FE5F8DB;
 Fri, 26 Sep 2025 14:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 07/24] target/riscv/common-semi-target: remove
 sizeof(target_ulong)
Date: Fri, 26 Sep 2025 14:17:26 +0100
Message-ID: <20250926131744.432185-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Only riscv64 extends SYS_EXIT, similar to aarch64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-6-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-9-alex.bennee@linaro.org>

diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
index ba40e794dcc..7e6ea8da02c 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.h
@@ -25,14 +25,14 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     env->gpr[xA0] = ret;
 }
 
-static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
+static inline bool is_64bit_semihosting(CPUArchState *env)
 {
-    return sizeof(target_ulong) == 8;
+    return riscv_cpu_mxl(env) != MXL_RV32;
 }
 
-static inline bool is_64bit_semihosting(CPUArchState *env)
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return riscv_cpu_mxl(env) != MXL_RV32;
+    return is_64bit_semihosting(cpu_env(cs));
 }
 
 static inline target_ulong common_semi_stack_bottom(CPUState *cs)
-- 
2.47.3


