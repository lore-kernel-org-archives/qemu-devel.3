Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B52CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ncW-0005x7-8x; Thu, 09 Oct 2025 06:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ncR-0005wB-18
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6ncN-0007Ex-Ff
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso847707f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004684; x=1760609484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OwvJQ3doaI8Szb7M98Eo5fwi+WUjQSYHJ9eGvXs2yQ=;
 b=PzhdVwS+ABfyRdPsWq7VK6K+ABcqdC54gOMMKIaqCm8730Z+UWMdiBYP0F8jYTqlwp
 On8iK4IS42IutctRLHxWhcpIYXN7Y0tDcCkQyKmTPeuaSTfuT1wpfdE3V/fOjUCGNSyH
 bdMXX4sGHi2/O96OXLk1suB99hd4p1QnjWvSih71xDaJ/cm3B4CFOVJjJ7vkZMTogHpe
 rSftRS/4k9kSWlLdU94sdG0fjhQzR/xYN6LkOEX4JWWa7SVDyXTmXUSpSScVKAMfWxyM
 +Lrds43zd8MJSTX+LA+fwa62W85v5QIYTjSl8MyAmoOMMN99v8PcGGbohNMi9OUx29LQ
 GeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004684; x=1760609484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OwvJQ3doaI8Szb7M98Eo5fwi+WUjQSYHJ9eGvXs2yQ=;
 b=i6Fv1ijgupcYRZzFsqLf9dg6zLu02sI/R0zWl/m78S7K0eI+osbAP8zg4U1vGPs5Ws
 LRLzC9tufSDCCXW89MYUFKxYXQqFcMzQz6XGH95id/W3M6r0ZU1cRMs2lv721DK/L1ze
 Qz/9E/I4ESd22L+sZRxVnxYnS8rTL+RuQiHl1n1e3jgWe6XDzI9Vx3XurDE6C9l5qn71
 WyR/qxpk5OOo7v1ngVNVCeQtL78cigGTD/CexEmoP3rwTxGryur+tgc21SzrA6nyGSCd
 eLWtvpi4567PeYZXMkWzHbzSLEIj+iITTeMCapUs+ztt1laxW6An0oN4glz31iBvEzcE
 0hng==
X-Gm-Message-State: AOJu0YxrOp5acbjqcnie5/+hZ5I0cTXgO34yB/mtRnbEdPIOaVTItCej
 xf/ZPC9C4s5ay51Ib4XznT/BA7JGMXZF7KSqN0oQX4eGMAaUiuIJSFTSWoqJ/7jdOFALXApHfj+
 Nb768DCjfrQ==
X-Gm-Gg: ASbGnct6+wTGToSMSdJFZABKAULZslH+yB38rALq9+Sh34hcMtA412agJm2uUAuWhb+
 z07OFLp4lMqGWiqwhwiTuBHDegsR9rZv+OX6JVOeeP9JFvJNMbAwKonjFS3D6LGQtUPTW3hBwtH
 ThTanDTXZkL52XPNBnA0iMoorBbG01M4uQBy7+qfD8QEgCbd2GRjSvI5n7htSi/u3VONlw30+i8
 JKfzlitRCV0aOFhVoixyBa0TD8CMugGLx+Laz0dA9hlv+Bj50Zq8aAHqOPupZDn0EwG4/MrwTGw
 Z6no5foMgB/xvxtVhu/iy07BW/SfHkUJw40qPQVgQZFEmbOh40jmOWlD6OAbS21n9Lx4wBm8U69
 fgF6JoZ9k3ory+CpRoOUShsCDUJkKFnnXNMYi+QimKFxNpfMq4DblDpHXF3tkeOsoz5Ncj2wW+F
 k5Hyi0GzdF3xzGt5FdWnpcQAUc
X-Google-Smtp-Source: AGHT+IGA/SraKfHFgWJm46ONmB9Q1qkmsnFwbpcVWntY2aKV+53BAuHoPaH0v2SZeB6T19GgGljFUA==
X-Received: by 2002:a05:6000:420a:b0:3ee:114f:f89f with SMTP id
 ffacd0b85a97d-42666ac6b77mr4428709f8f.15.1760004684401; 
 Thu, 09 Oct 2025 03:11:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe49sm34436116f8f.21.2025.10.09.03.11.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:11:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 9/9] target/hppa: Replace MO_TE -> MO_BE
Date: Thu,  9 Oct 2025 12:10:39 +0200
Message-ID: <20251009101040.18378-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
References: <20251009101040.18378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

We only build the PA-RISC targets using big endianness order:

  $ git grep TARGET_BIG_ENDIAN configs/targets/hppa-*
  configs/targets/hppa-linux-user.mak:5:TARGET_BIG_ENDIAN=y
  configs/targets/hppa-softmmu.mak:2:TARGET_BIG_ENDIAN=y

Therefore the MO_TE definition always expands to MO_BE. Use the
latter to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6fec63cb433..c9009441ad0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -106,7 +106,7 @@ typedef struct DisasContext {
 
 static inline MemOp mo_endian(DisasContext *ctx)
 {
-    return MO_TE;
+    return MO_BE;
 }
 
 /* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
-- 
2.51.0


