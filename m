Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB91CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcyW-0003oP-LW; Fri, 21 Nov 2025 21:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcEj-0000hp-AE
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:16:25 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcCg-0005Od-Pv
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:16:22 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5957753e0efso2719032e87.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763774038; x=1764378838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uhfSYXVJhQzgILc5n4xlE7EXEuT5rMWIJU0DyKOMRY4=;
 b=NNVHAkhjeb0h/OkeoYwLM13Kids/cCBIwTY/9Cp4VNyEGXSBqNfV8QmJa4bS5LkV0T
 PHEVCYk+q7whWTA4+ZLNkblmzidj+bGQnWxSeywK11utQHr39YVzX3GLtrfKpK+r1Jux
 PQe5/eAj75pNbt88s43psvnvEAJpZ2R5nnX3t5Fk2jhGkGdbFZKvIzMJIXxZQcMtq9z4
 5ytm0Ox1zd9caoBMps0zjQSgV6VGbsvbMHR+kjFAUdKFQkNpmwoFZTgbS6+Yn3cGZyeT
 KNqNIKiA8VKPzie2zzMSdG+2DRCaVBZb+wBlmzBAfk46ebr1zYEgFAtl8CmyRnvg5hua
 X/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763774038; x=1764378838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uhfSYXVJhQzgILc5n4xlE7EXEuT5rMWIJU0DyKOMRY4=;
 b=V4QbBhTg6p6q48nNjcJIpS1VBrPXYhiCLrJlY9sHHTojX1yxQCYJ4p89PU2SvOAI8e
 2RjTaU5cCI+R9UgvEsV0Gl09XbicsxP72241v9f4hEQaRWxmPdkWDLxeSlbCoXNEovRI
 asJPCtKLtlQsE2hmrE0+fG+YGCvx0DfcEcqT4gG2Agj0h6AERhJt0W+E4Pvahooq9vJK
 YPc+PImnUQP+gYmswQ/Mx9g0q0DHbg/+MCEn1FZcPkS83xeWnKmvPdoJNSxqp2+BEaYH
 jkolZoE4e53OizWdaQZzt8lO02EYOAvqIqtnN8AHRFP/D8s65vKP5yh1PfpstAhCOO1R
 U2gQ==
X-Gm-Message-State: AOJu0Yyy0RAD6rhc8Di3MN6XEFSG9NQUCFcoRzdZkiOVqvyF4909eXdm
 8QrYD23352Z3xkYVAUgxQzIOpmjNwbUe8PRuYocwt7ZintSpxvOmNMcFiRYVPljm8OLm4dV4JoP
 rcSzyNPlfWg==
X-Gm-Gg: ASbGncsTCsdyKmBurNAurOF1aDczAYIgxVujBwNB4WRLvHSUBhk7tbzpIvR2Z1WB46x
 GCFMCRQIKokMcFPI84c7e+BEbrq3zZuEHE5XInfuebb5Ga5/Ar8uDk3kMsGwdXHQW0b+/2ILnSQ
 qrmmHzZKqvxz5kI4VdfsTTTq/STszUw0buLYtbtJBEKfJc7Q0+Dg2aBfPrKtftNilEkHAymIsLj
 ze7OhC/MPCH2xMKzDlGD80t4j9bW/o52lH4IpBo6go0Bw1sIfq5yq+UV4VRcvVd049BrFxK2KDz
 tAWuxhs+QzU9T5k2Xm187b516MyOGI3DS6gk1nJ5dTXKpgihAsrg3H6xA8V1MNmE+pTxf6IBeRI
 RBRyCe3bfJrIaJlLJxTAMX5f0s6aFeRt/dVCKr+mpBD3vG1BMWFbwFnVpyJV1MLg8CqBrNkF3w1
 YEIuvNhRWtipAsYmYo4k+GqV0Na/6vtCDOGekUYSdfhK4bMUGusMvsYonnVuDC
X-Google-Smtp-Source: AGHT+IG/b8TxL9CJ2yGrfcKCr8xr6tIWI9/kBLmY8vXlUe3LRE9WTL5vE8m0zohVGp43fgT2y8tBkg==
X-Received: by 2002:a05:6000:240b:b0:42b:396e:27fd with SMTP id
 ffacd0b85a97d-42cc1d2d44emr2576757f8f.38.1763732765605; 
 Fri, 21 Nov 2025 05:46:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363b0sm11300121f8f.13.2025.11.21.05.46.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:46:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 09/21] accel/tcg: Remove non-explicit endian
 cpu_ld*_code() helpers
Date: Fri, 21 Nov 2025 14:44:51 +0100
Message-ID: <20251121134503.30914-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

All uses were converted to the explicit cpu_ld*_{be,le}_code()
helpers, no need for the non-explicit versions anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index e4ec4e7d367..a3125fc9026 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -523,14 +523,4 @@ static inline uint64_t cpu_ldq_be_code(CPUArchState *env, abi_ptr addr)
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
 
-#if TARGET_BIG_ENDIAN
-# define cpu_lduw_code        cpu_lduw_be_code
-# define cpu_ldl_code         cpu_ldl_be_code
-# define cpu_ldq_code         cpu_ldq_be_code
-#else
-# define cpu_lduw_code        cpu_lduw_le_code
-# define cpu_ldl_code         cpu_ldl_le_code
-# define cpu_ldq_code         cpu_ldq_le_code
-#endif
-
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.51.0


