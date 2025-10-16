Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171ECCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvj-0008JL-4X; Thu, 16 Oct 2025 08:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Muq-0007I6-EV
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:14 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mue-0008Gy-FO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4710a1f9e4cso4911695e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617011; x=1761221811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mDQn6MAlmMBDYET455GfS6GuIuqO1dYw/LZEEdJ+rzo=;
 b=FB3Uuxja1W6uvysb2rCgzOhmwv5E0rWUawHP8svBAWipsjxDNYTQ3FsnisQ+UXm1nc
 ZVMvLua1OA9kowwWF9Rpow5/+70gjMlXtl/S72l3DCAeLAun7SPsLs4faGroUujH3Kjl
 YzpPcw5RtJz99+VSeL8kMLvtR43Ug362jtHtAF3RWPdZTY78mcjCAd6WwfQjHn8IeqXv
 bVuBmO5RLjKWaf6X0izA5P+EGFBIeVSfIbIFULJAM0IGS6dox8lmCssHZLb8bxNvhQlH
 QmPFT+dlgl1R4XP8qFLgFZuCFtCPBtQrQJHJwKPDdKJfSsFzbMeYhgPajDTFlHV8Sw/l
 20WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617011; x=1761221811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDQn6MAlmMBDYET455GfS6GuIuqO1dYw/LZEEdJ+rzo=;
 b=NL5Tvnw/c9wMs+nbNBLMj7PF3LE4HOqYNpdfc/5pm5SiKtJeuz2bKRBYLFPOKB6SEC
 sze/yAxqrtnhn99So/M0asyKPDCxeF19l2gJ4nasB0D56OZ7BpaLPVX1DFY0AnomQbqx
 uan7YbUZ5OmDOSjvrxiwka2e5R329wAHVGba1NSkeJyNQyekXykF4gjUbuQtLS1DuKxl
 4SaAQyadcfQSHsWDBD/Jmv2VtSTh8m8YW6z3kj0PfvtdmgKDJnMxwC0SVpCktgfNOnnE
 bHBuil4w9U2HZq+/Ol4AjFifY7G8dJEuq43tTSDdRKYJmE0mPnQ9U4v4ApWqH7a9w6ou
 XIVg==
X-Gm-Message-State: AOJu0YyT0DtSnnMNQMeRR6U9nPPa4X0V0B3g4l/XR+yTxXv9ZMV95HpN
 GkOK9NpiO4qVoEX8j5SNN5FfCd4Lth9EDHdFcbI7C87ikmVeqBLHUWU6XSNtzq9r5CWirI5m4Lr
 XE0o9ZHA=
X-Gm-Gg: ASbGncvzcqHydpv++xaDoGsafq8dJbB1A5z0HrFcwIKwa9U9SkBCkzZODi8zFe/rg1K
 zu1HhXBKnLv53hMNC6tc7W0EU8XCiG01c4gHxL4pntcw73ZGNYDJS+IZLKaZvh5btMftQHkkMDS
 qNBVSYNVH11b0OQlIXKzU+50T0bFg3vyKtB9xri/UAjPgE1QoMoM1woYQHl7mai2W4dfPTYVv3q
 4fuGXDteqOMUI6ZGXrUPCK/e5Auin9zCS5TwKEEOcPfmEk0g2Vr8OQqLirzGmFaOOzA/if4WSV2
 0VPPidiq3oI/N+FaevsvkCR+GXuIeOmr1GEDCn9iqjF2tzta5FyMoLMpBoW2h7oPw0c2fvwFJDV
 HybFs76YgEJtwMA2cbb4DGF7Dr1f1GAhAj6ncQS5ModnxfKtC6h5sX+c/kJ4VpF4z+Tw6nVl9sq
 l1qvpy35iE8Dddjkdh91EXJGnAGWlU8Tn/jK8uLD1NxyQ3LCGvP/5xi8Allq7iEG2D
X-Google-Smtp-Source: AGHT+IFqDG03NGWs1iIr4MFZnillkfCiYM3qI+YNc06lqXU1qfKJBjLxUNj+uKJVoe89cIBGcnHKxg==
X-Received: by 2002:a05:6000:200d:b0:400:818:bae9 with SMTP id
 ffacd0b85a97d-4266e7d91femr20478550f8f.32.1760617010601; 
 Thu, 16 Oct 2025 05:16:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe74sm33862714f8f.35.2025.10.16.05.16.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/75] target/loongarch: Remove target_ulong use in
 gdb_write_register handler
Date: Thu, 16 Oct 2025 14:14:32 +0200
Message-ID: <20251016121532.14042-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

ldq_le_p() returns a uint64_t type, big enough to also hold
ldl_le_p() return value. If we were building for a 32-bit
LoongArch target, ldq_le_p() would not fit in target_ulong.
Better stick to plain uint64_t.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20251009201947.34643-4-philmd@linaro.org>
---
 target/loongarch/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 471eda28c73..23a5eecc20b 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -62,7 +62,7 @@ int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPULoongArchState *env = cpu_env(cs);
-    target_ulong tmp;
+    uint64_t tmp;
     int length = 0;
 
     if (n < 0 || n > 34) {
-- 
2.51.0


