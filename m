Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B69F531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCS2V-0000G7-Ui; Mon, 13 Apr 2026 20:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS2U-0000Fm-Io
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:02 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS2T-0000JW-24
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so35109745e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776128039; x=1776732839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7kISm5AhX1EU2bR0bLryhHMON6XL0ZyU+Vh4s9MTrQ=;
 b=D27+WbTpCxTxcS2c7zBiZuGYC9yKaG8tZZyO/duI3hKFTl3fEQj3MtAO+iamm12VhN
 cchq2fsb/lbpFFsTczywZXefeApQLlJJDfCO9e3NEY0do9qwvYi0xbmihBNcNrQ2ikZk
 hvcYCat21KARMccdkl36XD2qc0hM9qNYDA05h1gJg9ELxv++A1q63Q5RJzIBIj0wUfFm
 WtgM6dJvRk4Nh0o70YUv9SLjuJxAvFEjV4p0aI+qxKvehq2W5Gpw1MMDfSi1SlEG3Iig
 +ODiyFvbJdGgH4EtvUruXuzDy+NVAWs0ViBH728WDt68VurGsi74REH2PrJdv2hWW5xN
 Mblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776128039; x=1776732839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S7kISm5AhX1EU2bR0bLryhHMON6XL0ZyU+Vh4s9MTrQ=;
 b=gKe/x3CoSejtC/I35YomLqo0jqhSb+jCoCecHfvjZoh0SY4PHstG/nf5zRR15IwUFU
 0mh2lgtf1+pQtymf34MpGzIiuhrCXZ3op0QSiOL2Qgdjc1cmOQteEwNIwMmXEcEL1jou
 9lBpcFpRmHgOL1aGUUsIuoB8dbZp3loP/R5eAHA3e5mOql/A8JQ0trb+d0LDgJT6JFCo
 h1qfQ0SgSrqaykBmvsfjlzkkpCHNnjC8haqzDXI9ibueFbbFaq9Uqa0ZfCiNf7CdzGrT
 PuVNHhR1PDkRTMUMC3oBbCLKVa8I4ZJCR9SLekK1XOtRdZ7tXJTin9ugnVmi9GB22V1v
 4Egg==
X-Gm-Message-State: AOJu0YwC/mumHRylk1gVUyMr9MzI9Vk1nXHzeQUU/5H80ZkTYh5m2VRz
 SIQf/IoQSYwJ3CIuXLl8WdRJnpf1493KJC7IcxSHgMwx4AlzD3ZfXHIa1aZ157yc/VnxICGyaoq
 0zA0gkqI=
X-Gm-Gg: AeBDies+T0aAZ8fGv2Qz0nEFJGsMAqPiJrTpZjKE3dPprovKoxhApIyTLkfovL8O+mF
 mqp6tqwGWpXXBB54DGUlxBL9OGGqfqNOp9QlHpNljXORSVXUtR0Am+H6fn4+1fEl2Grwsarvy9o
 EJ8MNjtYPuTtDpc7Xkz3X+Bv8PkKe0vOiKZYxmGOE3cuwKWCHECNo0TZCzYSjlPLy6UZ9bzrsTz
 LKAW3PkaGvXnbb+SHS6fowXyFr7DqwwMtmL4ARkSoAELDOnZxPU65V8I9KxvhYohRUm6z/E/BiU
 sc/5owQSwBkDh161HWAO0Vo/GB/sqHaGQ6zRSdZ5xkMUtSeDGdbQteJOStT4gbKp2eK7ZxnXxzO
 4hwZcgAeEeOYSSCW48feEsfgVP4FrFQBsfHTKvPzvAiI/RvgdyHGZtotJ3fUYEJOR9o08ey1pRr
 WuVd96LOOlQhhQJ4ybldBTXRnqXs+nSLAXg3SaeIxj7ycB8wPcH8vtH558YD4HJar8HW72TtPrc
 kmezKohHtI=
X-Received: by 2002:a05:600c:45cd:b0:488:9ed3:1492 with SMTP id
 5b1f17b1804b1-488d67f0bb7mr185223925e9.10.1776128039288; 
 Mon, 13 Apr 2026 17:53:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67e7e45sm161438945e9.9.2026.04.13.17.53.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:53:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/9] target/arm: Ignore endianness when setting MTE tags
Date: Tue, 14 Apr 2026 02:53:40 +0200
Message-ID: <20260414005348.4767-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414005348.4767-1-philmd@linaro.org>
References: <20260414005348.4767-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

As mentioned by Richard in [*]:

  We don't actually need any specific endianness here, because
  every byte has the same value.  So we could simply drop MO_TE.
  That would produce a store in host-endianness, which will be
  fractionally more efficient on some hosts.

[*] https://lore.kernel.org/qemu-devel/d64d3576-9188-4e74-afdc-3492c9feb8e0@linaro.org/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/helper-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 2dec587d386..9f0801b88b8 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1019,7 +1019,7 @@ static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
          * the page dirty and will use the fast path.
          */
         uint64_t repldata = data * 0x0101010101010101ULL;
-        MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, memidx);
+        MemOpIdx oi16 = make_memop_idx(MO_128, memidx);
         cpu_st16_mmu(env, toaddr, int128_make128(repldata, repldata), oi16, ra);
         mte_mops_set_tags(env, toaddr, 16, *mtedesc);
         return 16;
-- 
2.53.0


