Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F15E7FDF8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3cR-0005YI-TK; Mon, 02 Feb 2026 18:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cQ-0005UM-4a
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:10 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cO-0004ts-O6
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:09 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-482f2599980so22017615e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770075966; x=1770680766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9SmiYXVM2fd88zXZvZgV+um15YTRCZVGWK+hRrqva4=;
 b=Y5WGGev8rRtnOBDqzFvdYSSaKZ3MpGnsEsoE/ie501rjPCgdp78qDADJp0lbN6kuhs
 NavluN0XhKGZplvrn0lBdeVwsBzwXgZRqcrfgZaBFQON08FNnXcW9Z1NDYWmLYiWywbj
 c8Dw2ZVjj98WH5X7ytxi1YbDWrNh1l7ncmTtdDCvV5y83oySDxKMD3QyUrPhJpNvhhVW
 iOcccxwwzW5zAJfBCd9lu8HGi+BN+Dhp5vh/UZPmsFRgiYruu+6ygG2mOvmnd5ATCtK4
 sL6AOITilL46S2354B7eoIWJak2jNybeabBnN/uq3/Mm2trWQq3GnvBb3SwPcVff/oIr
 2OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770075966; x=1770680766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a9SmiYXVM2fd88zXZvZgV+um15YTRCZVGWK+hRrqva4=;
 b=VY1SIUxQLkF4d/Et8UjbCArmZIxjMB0nha0yct27e1ng3Y39tjMVwBSrscJznFxVhp
 kzMJatzJkNEdHwjD01FjKdCLqll0rQ51/1OWtKxNerpbxatwad+tMWoKMZk/cJlnTC4P
 0NHXPFlFxXGPmfC0u+Eyk+a0X76HYmWd/E+uFPlZbe/dTVZp87VkOw2aPrGdCKIfi4s7
 9W8qUyG8TOhunxZGC29cQ4IIdsj3MkQVttaXyaFOpHJv+VRtIoBzbe1fnZ4BBA7F1UwW
 DhJF63rK4a9a+DLNxPK7vB9V3MAKo658Iq70OwyY3g6SzhjGArBrhthuGpy8FSLW2GR5
 PN+A==
X-Gm-Message-State: AOJu0Yw8iTabyne5d8H+KKtcnfpWSRHA8g4YnBbrMHdJJRS/sxpa+MTW
 DuRAD6/KoJ7RI/ie0CrD5IyrMdrKCJ6rGQ3N4KNezugb67Vb0bazBJiyObMT5ZREUIFwdR6IIwq
 UfzMjnYk=
X-Gm-Gg: AZuq6aIfeJK29kBcJxbpR/OpGu6dee32iLY+JTLhRpqPWi+AIqj8b9J74QjMY4gk1ov
 t9SpZ8ltQh1ObOfcrFp0c8iIjVTYvNnwksxLi7ab4mEQ3acPKm8WWIJc4XT1HchVeXTDsmFSdik
 NcA+Mm0A8z7GorixaFuVUKyEPw95VHuzMS0y6X5Nr/L3I1iQDLFC4Z74M92gRAMufYUZIwesujj
 PwRYaIV/ghmmlIZlbwOTO1EXADdfx6fqaUg4R+qHzieB37W6RbP6ncf7n3yXPYMqeK1ud9R2QpL
 6cSuDxgE7wMWDrMoVAbWBeYwn84IdVuxts1U8p1MYw0SQjjks/Xcm7fl7q88MvMy705MniuHzZu
 pI2Er3f/CB3huWU2pybPJzWQXgbv6G1evbX89mL5VcW+Wr9fO8syMJb5bpFXy0ZLWk+hDldNkqu
 GaVhNT6Sai5IZty/CJzEPHKdM4jIRrZZhaHyJSBKXroQt2F7ypWBHc4CqbPTJc
X-Received: by 2002:a05:600c:4f48:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-482db013b90mr207610795e9.0.1770075966128; 
 Mon, 02 Feb 2026 15:46:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830512e61dsm21403055e9.8.2026.02.02.15.46.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 15:46:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] target/alpha: Build system units in common source set
Date: Tue,  3 Feb 2026 00:45:44 +0100
Message-ID: <20260202234550.34156-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202234550.34156-1-philmd@linaro.org>
References: <20260202234550.34156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since commits bb5de52524c ("target: Widen pc/cs_base in
cpu_get_tb_cpu_state") and 32f0c394bbf ("target: Use vaddr
in gen_intermediate_code") we remove all uses of the target_ulong
type in target/alpha/. Use the meson target_common_system_arch[]
source set to prevent further uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/meson.build b/target/alpha/meson.build
index 7dbbd557171..9447f8020be 100644
--- a/target/alpha/meson.build
+++ b/target/alpha/meson.build
@@ -18,4 +18,4 @@ alpha_system_ss.add(files(
 ))
 
 target_arch += {'alpha': alpha_ss}
-target_system_arch += {'alpha': alpha_system_ss}
+target_common_system_arch += {'alpha': alpha_system_ss}
-- 
2.52.0


