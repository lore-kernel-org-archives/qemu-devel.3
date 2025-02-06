Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FA8C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5kP-0002pg-UA; Thu, 06 Feb 2025 12:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg5kN-0002iL-NT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:33:03 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg5kM-0002r6-1n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:33:03 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361c705434so8707845e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738863180; x=1739467980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jTUl8shDQDg+BVRzsTYJLl6JuW/NwoZq701w5pB0BvM=;
 b=tTUZcgLcEPkrR46uK7763MbVKUJITXlSRKH0VMHlTlEtyssFUMV6v6CNXtb/S7NpJv
 bFeK7Hs49VLZacfhnDNV2P8hAfmNjPf4vINAtv4dvo41xiKtBpVJb2r5SpwnCaGXyK+U
 /rVfPvll8nI8NBGB/uCESgnFYgxCK3j54Zffb2Qx7x/Jcjoxirt4NuRBbf6cOFr/c1ka
 26GBETtHxK6zWZ/yUC0YjkvRpMjRn87HktCpO7Scu24VAszPujKxTju5GSZXxDUtGxGG
 sVNmxKIUBqD9heQ+NVzxBlFA7cuBlG5JvjYcGBmY2v7Mhteb4z8DQahkBvVEiq0o+fPO
 2jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863180; x=1739467980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jTUl8shDQDg+BVRzsTYJLl6JuW/NwoZq701w5pB0BvM=;
 b=lihurxjhmagKdArwEp+uoTV0R/SqkDqaIOs5ivUhQE5wBrCf9XohAs2IMiH2RMV15z
 DnwjT3mwZ5aov26WlInr0+Z9XNqtoWOINPKYpBJ9NsMnxbix38jFLIz2AsRKLc1zvFNJ
 YgPcQA+0bZHHxFGwEIB8DQZex8smWjk0+1Y7Zmm+eoMq9AadlzYCjVyebj2WpgBBefkq
 c/IVp4t81zQCqUkjw56K9TBr6dA8cX0DENfoTg6RupYuPaxjoPqP7YlejXCiZvCSMpZu
 JU2Wq0cv16vkM6Gz3I/JW9DhvHPhdIhSYSwYvh0HVpmQG8l12upSgn+DRuVm/eGIOksS
 HEnA==
X-Gm-Message-State: AOJu0YzfeY6q+iKsNi3rdoM5J8C5hhs8Mw53QLYGGlC+yQ3Oyi+jfim2
 MoL/t9SmLlWjKbkBMB9uRx+KrJBqbBH2xpYL4wMveBDxApQRlk/43oxozbeggTjJztWA+FUu2gx
 PLDg=
X-Gm-Gg: ASbGncvupwkr5M7kMxv8TBZFLwYrsraQRn4s1PwNrRNzWQW/283rYIJQ3mEAd9s0McO
 JT7eANPBqFbcmitHekcuydsCap7zn/IL2PGzDnXJHhWwrYAv+eiZb3Jfv8uovNmNAKtu/tUl7b7
 haSLMSEnZs2mN9/p0ZxbqU1Ef2FBUCBb0YMMQsGIEALvKFuj3EAya/KYKEvYno8GZdgr+zW3xv5
 mD9ECf3C6V4wcU6ZWP0ti/i6iU0F+CFe1CiIktCtgrjXkxem4R6RP8L5IK47GVk1pczatM83de4
 y8lLUWor6KsCQmkAHhTTVtptcZcWCo5o5krcD1KvL5M7zOmJyBDHywcCvViScp8XgQ==
X-Google-Smtp-Source: AGHT+IEJoJq46iEU9+eP8QKUsZxclcjDmZPPGJdqZ9C35Fz3aYARQD0jvsOqBnYgfF3qGDPunLu4Qw==
X-Received: by 2002:a5d:4ace:0:b0:38d:b1e5:7e09 with SMTP id
 ffacd0b85a97d-38db493870bmr4763105f8f.49.1738863179854; 
 Thu, 06 Feb 2025 09:32:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d9335b6sm63108675e9.2.2025.02.06.09.32.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 09:32:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/tricore: Inline TARGET_LONG_BITS in
 decode_rr_logical_shift()
Date: Thu,  6 Feb 2025 18:32:58 +0100
Message-ID: <20250206173258.36624-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

We only support 32-bit TriCore architecture.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6819b776686..c5b783b6a70 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -5936,7 +5936,7 @@ static void decode_rr_logical_shift(DisasContext *ctx)
         break;
     case OPC2_32_RR_CLO:
         tcg_gen_not_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
-        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], TARGET_LONG_BITS);
+        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], 32);
         break;
     case OPC2_32_RR_CLO_H:
         gen_helper_clo_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
@@ -5948,7 +5948,7 @@ static void decode_rr_logical_shift(DisasContext *ctx)
         gen_helper_cls_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_CLZ:
-        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], TARGET_LONG_BITS);
+        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], 32);
         break;
     case OPC2_32_RR_CLZ_H:
         gen_helper_clz_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
-- 
2.47.1


