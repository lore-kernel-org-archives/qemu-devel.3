Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4BEC87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwMI-0006ew-RT; Sun, 27 Jul 2025 04:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLg-0005At-BC
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:13 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLe-00043j-RD
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:12 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2401b855635so325905ad.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603389; x=1754208189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMGC5A24KwjwokxNjbljMwweFFMcRjy7ppuyvfWNL3w=;
 b=TBe6yjk3WYPmjO8whI/gxXWh0DJ/pZDhycJK9T9o/9lkgayLPhWhfcRW4RJQx8M8JC
 Qp+6jUbl5cfxdicYnrL/6SQIlqTLtwPLn0al1reH0C5I2SxJASaOcpRyj8RNIkNw43a8
 7vKoqxMKhAVytIZSiYRCGoPk4UdnVVcVxOUz8TtIJqddxL6M8ZcNiSWu8FlR5CxiK4xU
 rUaQXUQr7Tv1GkoFVS270fyUtxTXXjLpWA0lRxCDczs+kdr195MV+hy3hsGHeLb5qDKU
 9grormeD/ZVSvonVHv0ZiYOZZ5J04x+/WoDZf8rndHwR3N51eMKWOqN4asNnGc7g6DdH
 4XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603389; x=1754208189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMGC5A24KwjwokxNjbljMwweFFMcRjy7ppuyvfWNL3w=;
 b=uwUIZCzXzwC52LqiwP36tNb2sKafiOQ7Yv2ytX2geLUsk44L3FwsTrZQ7Dx8f8lpRt
 9LOMfsLncUSVLdCCMaZGCOILyadbD1zJPvz4mLQ+18P4jFay0QlmmyYPmETBuc5d3vyc
 3Z2W8i6VL+88Psg9JhZV/A7orzqK/Qo/Xrex+yPs5xsEdZC3B6K2rJQMk8oLoY7nqA2F
 ani49IdSWeihGvhP3wt2F53qs9HEA7+3YFu/QwOwvy/BBWQInSpfxEIFV4/X+OGTfMLz
 H/EUmXwuf6zVZ2kCWb+NEOxjyx2uoFuU+7G/zXK1EFSJvT30lnhgCMXzKqvENlm3JF4B
 W+tg==
X-Gm-Message-State: AOJu0Yxqv80bLxg0RI8YqckciyB9gswb7ZPzLvy8TGXIVEe4suelsgMr
 stn3PQpnFt9jbi6kBytsWVgYXQv5UziEEpQzGsVo6j4S6k/BJrGRJpGxo3SG7ZI1hJRUi7IApCI
 s3KW0
X-Gm-Gg: ASbGnctAhTP03z6fki7DUM15UNqVjzRzIH6xAsxqtpSdjQ/rA0WYpP4HLSbxKrwE0aW
 dZifnGaJ2Xkl75DsJNEzmpKi8MIiKZdem9VlZn7Wi1ZRinI3FSUbDA9vXWaqtGDSxEKyhWxUo25
 8wDZECHhC/0j7tqLeHuXCtDPWQZD9jrieEYtIvFAwK0svHrUCF9d0Ufjiki/5l5W6ApzK9HlrC1
 xdCRWwiz6F10jY9yi4sQsbkevcUp1zKk9NdMa+Izq+E9IKo4WpH7CR4M8aEPBwAhALjRlgE/OIv
 C+FYgFzgwm6pXD7i9u5iM5lI6hHsX6eOAe8KI5B8KddKeBlRT6AYolOFI1wmvVPSzuKRlK6Rf/u
 726B+alSeOqaQYE2X0s3DS9HjwG8ZHrKaN8rFsmMvh4dmnMnvjk+6uxzIevsV3LqkIOx6JYs6Al
 3cSLIERrZXsZxmLdYOvN2vmeKOcJ6ZXCY=
X-Google-Smtp-Source: AGHT+IH4jY+b1OjVLIoKFK5y/UUEhv9wVPF6RDRt1TAW/dGh7V9q9DWQx2aS1sTd7KOMhNu+pw/zlA==
X-Received: by 2002:a17:902:daca:b0:236:15b7:62f6 with SMTP id
 d9443c01a7336-23fb30aaff0mr110769455ad.34.1753603389562; 
 Sun, 27 Jul 2025 01:03:09 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/82] target/arm: Add isar feature test for FEAT_S1PIE,
 FEAT_S2PIE
Date: Sat, 26 Jul 2025 22:01:42 -1000
Message-ID: <20250727080254.83840-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7f2ca51b4c..83875c06bb 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -919,6 +919,16 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
 }
 
+static inline bool isar_feature_aa64_s1pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S1PIE) != 0;
+}
+
+static inline bool isar_feature_aa64_s2pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S2PIE) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
-- 
2.43.0


