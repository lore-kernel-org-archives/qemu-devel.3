Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52B5C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6ps-000383-8m; Mon, 17 Feb 2025 14:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6pC-0001zX-6h
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:45 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p8-0008Rc-0F
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:37 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220d39a5627so67734675ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820632; x=1740425432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5Lf3oD5xg4WJC6myt6Lc6+y6lzumg0EZEkqeBcijFs=;
 b=rb7FpNcYtK//suiSDD6bUBOm/+sk67ZEOI2oNbFllzBlD9qrbUfEy7sQ+v7K/+pqZo
 4fAs0zyDcKS54mXtGy2cV5r3EPcvOldnUcYdO6QIyf3xFudNTcgwJCyHBEl/ASJ4/mSx
 UKAdqWddAcdbyB2yYOVdWg/Usm+QoIMMHr1BI87TClaJwCeWTAw6pmmjAkeWJSvMZt7o
 67GEUL+Pa8urY6+lEdEwfNd8anCbfe3K3k+7RAmtahW1cUlGEhq4dpNRS02LOkYcfPjD
 ngTAaMMSY2zrYRMQ765bcgZxQNPPsYOG/IFoNdmO3kgkMkW+5csy/vlXoBjMHcM6wzPT
 Tojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820632; x=1740425432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5Lf3oD5xg4WJC6myt6Lc6+y6lzumg0EZEkqeBcijFs=;
 b=CvK6xxrV74eeQ10bYANQGi2SgnxIB3I58L6FEQIe6UXCwd4nUUi9ZqalPypp+8/w1H
 kpuxNB0AQzeIgtUdQ27XgRMtw/ynZ2Nw7SW9Ohnqpjan8T9fDBtZrChVElUbxfQFaC/H
 QS6PtsINmRqEpqoNlM3kzm+HZ/KVIR0J4a2pIxqQLJcI0A9Zjd47Ju75+KOLN0OnCwp4
 Ye/DpBs1KIcw3w/zaETf3yXhnMIwj3hzCshrlfN31IP/EDmxux2CJ0+PHmCaaYdpb+Oi
 A6s0Ex8w7rkCxkLL2CFCtRIFr9Jm2NfmI2Re6xSYFaCUkLWIM0BasH8UqgXaHFENasVM
 Yvkg==
X-Gm-Message-State: AOJu0YxbSEEKfkvEVsOVSl4FyuOQLOOPOnX4TJeMoBjmIFQrUTcZ1Noy
 BslQx8DpRh6/lsjFku119zrMEc8AVuJba9uxqqhkSkePImgUIpkCOxs0z+xOkExWXM7sEmdFdBh
 m
X-Gm-Gg: ASbGncv7hSbpxztYK3+yS/Lik4beoDawtBSj3t229/HADodLsPq/zFV3pz8X5o/+58o
 PeBOe60L84QQ5/+TKxr0f7q6tfzyD6vkYbBB7jCGREaq2WS0gRziRX0gp/BLV07u/7CV6j7IRJq
 z6IMYLAB9JYnR2i3YBIwPQg1yxIwvWADtiAWLrTWD1lgN1o5G2vXBHXzJFUZc78KVJCg8uaXHDr
 ib1+Yd31ZbvWj1cfYKfifdFtVhvnBQbB1xDq3Py9jpvorCmXWZ8Wgy0mkgnngoM4NyHlTTXR50g
 IoI/ZllAtA1ORtgtxAupj8UZJTah5ZiLbcV2KfAr9IjDs4g=
X-Google-Smtp-Source: AGHT+IGtSGBlXEYbu0oN0V+F++OaYL7l5RbyBzCzLLttCYfrouf+tNediHDCMJjXuHoCvO4K5ndKpg==
X-Received: by 2002:a05:6a00:3c84:b0:730:98ef:30b5 with SMTP id
 d2e1a72fcca58-732617741a4mr14657672b3a.5.1739820632612; 
 Mon, 17 Feb 2025 11:30:32 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 27/27] tcg: Remove TCG_TARGET_HAS_{br,
 set}cond2 from riscv and loongarch64
Date: Mon, 17 Feb 2025 11:30:08 -0800
Message-ID: <20250217193009.2873875-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These defines never should have been added as they were
never used.  Only 32-bit hosts may have these opcodes and
they have them unconditionally.

Fixes: 6cb14e4de29 ("tcg/loongarch64: Add the tcg-target.h file")
Fixes: fb1f70f3685 ("tcg/riscv: Add the tcg-target.h file")
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-has.h | 2 --
 tcg/riscv/tcg-target-has.h       | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index ac88522eef..188b00799f 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -37,8 +37,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_brcond2          0
-#define TCG_TARGET_HAS_setcond2         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index f35f9b31f5..98081084f2 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -37,8 +37,6 @@
 #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
-#define TCG_TARGET_HAS_brcond2          1
-#define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_negsetcond_i64   1
-- 
2.43.0


