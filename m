Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB64C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm5C-0006Fj-CT; Wed, 07 May 2025 17:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4u-0006C6-L6
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:22 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4q-0006Ek-1n
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:17 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso456808b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652394; x=1747257194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adKWgBvOzEaae5wZJaPVcOHVkh8QC4Zfl7HlNy4ELvw=;
 b=AHG98q+HYV17MBQXvBJ7TlYNp6udwWZ4JhgpaTyCNPa20Wudu+/QlIa7Wb3kM2ovOo
 zxUgRPiNs2jZCHsO4OLAthBp7esf+5y/bWDyjS5AvRmWD6kCMEpKPxTBNVvt2FWUSt1v
 PMCP8xEMSFt1kXUQbN6V3McnkWgt0QzF1chXJvHatZaBTQubFjBr4irozDXw7XZMBZU6
 BH//36gDZMMveEDTDNp0Z07/4/Gn+hT2qiZgfUnQRImedvVXbc8b4iGnETk8sSRET0TZ
 PsyYSDqkCUVf7IVSB/pcnuDiZhBy1UtcJgQnPk62RiIkuuY1lpAqsLs2ziwEQQyZEIe3
 HQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652394; x=1747257194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adKWgBvOzEaae5wZJaPVcOHVkh8QC4Zfl7HlNy4ELvw=;
 b=fijXDxi3FcCLuO805K5EsxEfbbACxqLW69Tu/86i0mLZ/18G45oQvoI9gCPCJB7J3C
 UbOtZ5RIGQoOgRWXIrgvELZGE6Tf4AsCcj4kYPWtycPnPPpaVtjEhFKq3wg74t1o7TOa
 wDRVvE79+9ytMzGQ4/D0QfgrjFmJ3UgXj7E+h6hCpHWCe/U3kUWectdh9iFV2evFqNV5
 MBj2b47HEdRX4CCCUe+aXVN6d8Dd2eWMvfsho+2WQBYuB2mPv383CXA09BZpN/fxRMgW
 ABjwGvEl0QwA8ldBhqylrwnrp/WQ+HtLvxMk8wLyqOYeaLgOac3ClJLMS7H06sixokig
 NhwQ==
X-Gm-Message-State: AOJu0YyKpl5ZoMFWt7kqc39zNZNM9S5/a74DWN/Krkwn9ShXB0arNREt
 Ot/mBAW2yekYFtREKp2olozdwqS/FXjfq7TZ2zTTQjMwxnjMLjHZ6RI2Sr318UueVnkvIYba4QB
 f
X-Gm-Gg: ASbGncvRs5QFxmeJXMC6O4o22Pw1EP3m5NLLFbFzLagpteK6jNfvQ3r+46CPhHLuSIu
 o6De9nONAWJst4wX04QRgEQ2+UqduzM/Jo8caWYqs/GQWuZbOIZ7sH+qVMaBcqmjh7RgPllwb2Z
 7o/WIvcGg8BatUK49nlqdQfocOQixR75QiFJGIQSCIl84faKd1zCYAZvwhUaaO/4Gc2pMd8FBjP
 sUZR5fnDzlADj84wfl9rbkV/dkYWMQGauQSCNhvWa6Kq/JqnmqjJbxtLgd6G2NblzSj2UIfb1KR
 4GBFKXCRffLjJMvkZewTeb5IigcSz2yHHMfns7pqwYex3WmW86ID0cn83RaSSE/UUmXdY69eTyV
 fYR399cA09Q==
X-Google-Smtp-Source: AGHT+IH6OzrOXfoqvyyk5/dYePVr0V7bOMiCve8kreRJubsdo2aEfmldmrkwzs4hm80eVJDGeG7pMg==
X-Received: by 2002:a05:6a21:e91:b0:20e:4f4b:944a with SMTP id
 adf61e73a8af0-2148d0116ebmr8847839637.32.1746652394540; 
 Wed, 07 May 2025 14:13:14 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 15/24] target/m68k: Remove env argument to gen_store_mode
Date: Wed,  7 May 2025 14:12:50 -0700
Message-ID: <20250507211300.9735-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Use the env pointer in DisasContext.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ac48329674..dba415acf1 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -844,8 +844,7 @@ static TCGv gen_load_mode(DisasContext *s, int mode, int reg0, int opsize,
     return ret;
 }
 
-static bool gen_store_mode(CPUM68KState *env, DisasContext *s,
-                           int mode, int reg0, int opsize,
+static bool gen_store_mode(DisasContext *s, int mode, int reg0, int opsize,
                            TCGv val, TCGv addr, int index)
 {
     TCGv reg;
@@ -1335,7 +1334,7 @@ static void gen_exit_tb(DisasContext *s)
 #define DEST_EA(env, insn, opsize, val, addrp)                          \
     do {                                                                \
         TCGv *addrp_ = (addrp);                                         \
-        if (!gen_store_mode(env, s, extract32(insn, 3, 3),              \
+        if (!gen_store_mode(s, extract32(insn, 3, 3),                   \
                             REG(insn, 0), opsize, val,                  \
                             addrp_ ? *addrp_ : NULL, IS_USER(s))) {     \
             gen_addr_fault(s);                                          \
@@ -1704,7 +1703,7 @@ DISAS_INSN(abcd_mem)
 
     bcd_add(dest, src);
 
-    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
+    gen_store_mode(s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -1738,7 +1737,7 @@ DISAS_INSN(sbcd_mem)
 
     bcd_sub(dest, src);
 
-    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
+    gen_store_mode(s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
-- 
2.43.0


