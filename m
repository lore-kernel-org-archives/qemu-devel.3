Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C70C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVnB-0004lN-3q; Thu, 15 May 2025 06:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn3-0004Qr-DE
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn1-00089k-Sl
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso4618375e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304770; x=1747909570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+6ury5Sg2Jud9itYU7h3OKlx8pJe0hJxXUnirJFm93U=;
 b=vpNslmbw+gzKOlII17nWYqzxxc48EtkrqbqTkv6QLobr8wcVYHjgY/WvudQEn2eNdN
 pyc8uw4trLsaQGqqLmeCovvAmK10ts026LCzwfIiFcZuxAPudEYWo5JiO96GZlb6LsRA
 M/XZ5MevUCyV1Bt17M74SbtGTqJPpuZyFBHK8HHpEr8TI22+c8abpvmR4ut06KmDEozo
 mF4mOwJL7MD048xnQVMXTLoUKAOSUtou8e58HVjZ7O27qsZBC8E0evyJug+UN6754DsF
 DhG5hoy/4b9R32xwz1d7qkAzwokNQLb3ziNBGXqJICWag7vv58cOtRGksmfVz/hunDLW
 BqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304770; x=1747909570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6ury5Sg2Jud9itYU7h3OKlx8pJe0hJxXUnirJFm93U=;
 b=F/kwZJzEWXxOOQ9WbRQ4c3cCRL/U4kaDIaaNi1F5yIcda4QUj3MnEEGhW5ImwdCwQi
 NA0V6ZxpJj/1r47Kh6ByzGsT9mnIKVo/LncjL+s69pT5d6varylfUPpkfxTdvVh2Gwxb
 0oZsfmCRs8if/cKfBNXmdayL5AgIxIWWlVzTcnVT9Of2ozTqK7kt+f2XahC51LF7tBqR
 GxBHrszxOuXzbtD9YDS4+apZ2/V3pYKWQ8o6cGq1/nx+3wmOvldiPs1t+zYnNTU5Dy6G
 Z29EE9YrU92bjveajZ9SEfVJ2cSShhK6/FnQLielr8tYp9bCAWOEdJ98x9Iuu++APfyU
 y04A==
X-Gm-Message-State: AOJu0YxXWJlAyHZJvOWNQdnRuTsXIW84PHb1GZtxbLUGVIDGbed4Cg1n
 /DAFz0YUE4RXE7ZTg04t+M0GR1TSGiMFAbDd1e4Dp7uyjpUd0sSLgvNE/WJCbfJH82237pmxAJt
 wiCw=
X-Gm-Gg: ASbGncvYhLfzbA49m40cQcLcbxY9Qk0B3hTpVp7BgOyHLDDindtIAjwKB1hmCJhEX0l
 cCvWNbdCanZigk5FN0sZ2+M93OodsazyFgiUGli3xoHb9DrDCbIXsDuvXtDJwri6INgu32Mg84f
 Z4JBzqRCDThjOF1gvjGpo+4Oi0dLDMFPOGhaIqSZ2gED4u/KVbG8IXfRRO8gIalojBZA+AP2iVY
 3wLxZpu0N79STqU/wsD1AOsRm+vTw1Rr9AtkpdeI3NzlfKbEkNlOLAgZmMpQIV0bGf3h4VOjOCz
 XitYbmH5oQqnHvqzD+gt/f/xggx2JannUZo8sS03WUDS1xRE2fOAPpmerA==
X-Google-Smtp-Source: AGHT+IFDDQtrqxqe4Z8se7EPVpp2BwPBFRAoIi3J+dkn+959IVAVHBNADKiXKVehrcgEoC8ktmKouw==
X-Received: by 2002:a05:600c:a014:b0:43c:ef13:7e5e with SMTP id
 5b1f17b1804b1-442f970b0d5mr15516245e9.26.1747304769921; 
 Thu, 15 May 2025 03:26:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/58] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
Date: Thu, 15 May 2025 11:25:03 +0100
Message-ID: <20250515102546.2149601-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Needed in target/arm/cpu.c once kvm is possible.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-6-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 2b73d0598c1..e34d3f5e6b4 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -99,3 +99,8 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_reset_vcpu(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.43.0


