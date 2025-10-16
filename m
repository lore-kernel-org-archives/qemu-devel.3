Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7753ACCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MxU-0003zT-VB; Thu, 16 Oct 2025 08:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mx9-0003h3-HX
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mx1-0008Vz-RK
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so604476f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617158; x=1761221958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a2FNCvyGFg9O+kN7HmNjPDkS3eD+FHFI+svktT+ylZ0=;
 b=PLT6X9E2Xn2dq2YS+ZzXklYdnR+HHLcnOdoilqjrZTdNwDK2j3ccFVqddzRz0rPBRp
 FTDFUlK0FoAmTQzameK85vrhVkigQRC+PzqIORb6Rr3QAU9CYLS0608zu/kUM1cVZFvV
 XFNf1pGkuyMuctgxEP9kCrR9rz9RUF643c6LqlEMoJhbORWV1WgwU+8Yl1KUIKLZkkky
 4nnaSPkGd6pNvqrHiJPDKOIImlJjvfVQDpzzqXn9H9G6DYtEOq+nSjglLe6XtX4yNh47
 lXoaiL0wc4Y1ku1TGDFk6HvooXaLv1vJ/nuIbR56xTIgz4/3tlKSMbLzrO7E1bWNeg2/
 4/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617158; x=1761221958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2FNCvyGFg9O+kN7HmNjPDkS3eD+FHFI+svktT+ylZ0=;
 b=m3m+mvw5nb+iUOKjiDmq9u7yrGuRQGs9jg0z+ZuzSpgNBR3xGB3v4jIeWhp7Vu8if6
 f98X9KprRmJACZuBSBhOhqFbG54Lyg9taxg3Pi8gGvENdrcREWl9VSRVDwisq5r+RL8D
 Yxt1HOSBe90c5O/gxI2DI19YGsLUX8mlNtx1DHvx8mCxpYkzXOHQ7/VmZ1vEqDVomUXe
 R/qpy+LqUT+N9jUF5mQwrWYaiEI8LXdy6006WynG48FEOBoZ8Fy8omChOj1SpgASmplz
 DDK6ekqILRAwYBjlESpBaUq07jKeVqnY/aQ23jOfWjims5rqotDgLXjBaOiAfUakD1nR
 UypA==
X-Gm-Message-State: AOJu0YyyGwDNDBg/WIPaKaHSssgaIInwKIWIpG7KMcDl+oZ1thE5zLdJ
 498x/Yx/SWWUi9hOZ/gLjjYB4pmN6MVtdxzTTeCOtAyMHf2jIst9nWN4exa303eYJ/XoZoAbrk7
 VCor1D7M=
X-Gm-Gg: ASbGncsJLPYHtNIYS60Zk3nbv+a555t0/ONKMS5EekWgqwV/gYi13orkd4AwMFL1qNo
 hS+rdLctPbtwAjaBA01jP0kLSvtNe4YMbnMtD0NFF8uwmYrXi4mgiN6VuxzVYHXAjopfnIUZJV1
 rNPMNWU0uAr/Kxycr+4dzoBSjH6xIRiZLGWzEy6ypqUQC4H8yL1w7io0rObUSQOxcgZB5R2JdIQ
 NengDIpKF0fkAeAgaVc6wCmswDWpPblsdQLlbSJFydwhcfPwd+OCSpHY2UHdcw+535wiy7qeihy
 MSlJwJAN3lOMBN07H2VE+6ol701iofdJQfpulzSNGXN5M+LN/13tkb+M/b2X+DrpVcImgyF4iFt
 aHg3IbFhja3PSEqQL3bIGlqOs40zikf/Mg3glDFpL88m0/chhuHZHBnvHjrluO3Nzkb8W99Hk6n
 FcpyKZ2sg7M+jVInbJyb5UuHGAukSBdPxXUS3SJu5YM204H0jDUdKedw==
X-Google-Smtp-Source: AGHT+IG3taEeRWIxpe4Q+pGjS0eWLUvMQ2WEWSiu7CVRl9Pypomg1DLnfg3mHTqlcDcMLLTUNqQiPw==
X-Received: by 2002:a05:6000:1867:b0:426:ee08:8ea9 with SMTP id
 ffacd0b85a97d-426ee0892e2mr8027954f8f.44.1760617157785; 
 Thu, 16 Oct 2025 05:19:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426fe0addc0sm3971214f8f.12.2025.10.16.05.19.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/75] target/rx: Replace MO_TE -> MO_LE
Date: Thu, 16 Oct 2025 14:15:04 +0200
Message-ID: <20251016121532.14042-49-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We only build the RX targets using little endianness order:

  $ git grep TARGET_BIG_ENDIAN configs/targets/rx-*
  $

Therefore the MO_TE definition always expands to MO_LE.
Use the latter to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009151607.26278-8-philmd@linaro.org>
---
 target/rx/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 6ed7ef629ff..f2168243c88 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -74,7 +74,7 @@ static TCGv_i64 cpu_acc;
 
 static inline MemOp mo_endian(DisasContext *dc)
 {
-    return MO_TE;
+    return MO_LE;
 }
 
 /* decoder helper */
-- 
2.51.0


