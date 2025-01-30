Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C30C02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCR-0003y1-Cy; Thu, 30 Jan 2025 13:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCJ-0003u0-MW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:30 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCG-0000Xb-Ic
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:27 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so654824f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261403; x=1738866203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uM2XjXMDd682NDA4uF6pTcUgEcj+06il83UYUtiVd8Q=;
 b=MpJVdashWJ34rsFew+DRzbya8L7eE05aDBfxp8aaHi/LNiDEUYVWP1ZUwgW2mmQxLT
 /SdrjGBXE84QQt50C307Kv2PeMSCOZfwfQVPdabaMhPMX3lOSx3mcrNiTZlVUaumCKPm
 sq/sD4u/4AyRwudg0flcugyWBpiPyAkfaHJzW57uyW7QRwUs8+AwtIlQsDDIBmw5y0M2
 9clAecp4vRXi90oEnnF/IE4GnWR3ScwRJkuP5GtbKbSek59wTmCMydZOQ1M7k9dVeGip
 xw7o2aJgE000EwipPLyptR4eBYjSekvBYY5LL/cOFJCrHRHKVWqocqiXBKmJc3HJY7nr
 cU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261403; x=1738866203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uM2XjXMDd682NDA4uF6pTcUgEcj+06il83UYUtiVd8Q=;
 b=RrUTCBY5CQ/AEkiVaEYjzETTsDeGofi5uwGh7Y9qOTPlxriGOdH2cmeZBQSZZW++CN
 gMLB5FLJhV0FF70Q6f6YqZDahIjVZgjpcnACNb64958cfYipYUuyIeG6xHQbk6cD4lzx
 DZ1GBLyLlelnpfbsuLLBMGnYoK9wSf6d1EC1y7seR1zK4dcXCdgs9tM9//01bt4G6qfA
 BZPdr04LNpKqMwrrx6B3pFDiggzjoBM7c2IGuBVG7sQQuq4HcjGybBSbVXcOTUpagG4n
 N+KnLorAixE8EfgwM/3gWF/tmbFYwkbzYcEQZFJ3gOz/M50/P00icJ5pFqe38EsrdClc
 4TDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGFMthzaRk6/7M7dnjbs4ieY7wD/n8lBvFYK7xHLiTisAjyyvq+sAcuReKAubySJlfaBwhpRJ1UJM9@nongnu.org
X-Gm-Message-State: AOJu0YyHJrDMggNAp2LPuBQ7RpUNQBABoxxX1A/yrvnVU3jxfyVK0/Rh
 kytZPKvV2dabydpt5QdhViV+dDGE+WYQDuWifWpKmQ9P+x8zw7rRtcRzBRPHQFU=
X-Gm-Gg: ASbGncvjUQzsWzO0+nqpTml/AlUxO0zlovQIWwMAbR0VH17BvKo0t6eajRLBjURXQA9
 YsZSFp3Wkbs/TQsQQVKzc3c2IDUrKsYX+pXKScMPwCCdbjz7hnHj0AwngB6yl3zP5gfr+RQqbX+
 E25KM/5InN/v5EKLgEcoGCsx9yxkbYi0zLRQMYk6Fw8dL5CsTEJ58cw1m39j9mt+ap5ZXDzeGpQ
 Ii3YmekuvLcRmR1ocAEUTjiP7fqbdaLMjjN7i8pees3YKW2OnWmrelJK2Sm8Kh8zZh0XBSIYckO
 iEsr7zeizvg2yVC8Jj4GbQ==
X-Google-Smtp-Source: AGHT+IGPLxL2UDh8VWMjiUXkoevUE03LKP+A+C9UXdFH0CX4fDCMN1qUK6Gg2OA1rjPODvsRr0fr4g==
X-Received: by 2002:a05:6000:4011:b0:385:e8b0:df13 with SMTP id
 ffacd0b85a97d-38c52095e20mr8046541f8f.40.1738261402914; 
 Thu, 30 Jan 2025 10:23:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 11/14] target/arm: Use TRAP_UNCATEGORIZED for XScale CPAR traps
Date: Thu, 30 Jan 2025 18:23:06 +0000
Message-Id: <20250130182309.717346-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

On XScale CPUs, there is no EL2 or AArch64, so no syndrome register.
These traps are just UNDEFs in the traditional AArch32 sense, so
CP_ACCESS_TRAP_UNCATEGORIZED is more accurate than CP_ACCESS_TRAP.
This has no visible behavioural change, because the guest doesn't
have a way to see the syndrome value we generate.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c427118655d..c69d2ac643f 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -764,7 +764,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
 
     if (arm_feature(env, ARM_FEATURE_XSCALE) && ri->cp < 14
         && extract32(env->cp15.c15_cpar, ri->cp, 1) == 0) {
-        res = CP_ACCESS_TRAP;
+        res = CP_ACCESS_TRAP_UNCATEGORIZED;
         goto fail;
     }
 
-- 
2.34.1


