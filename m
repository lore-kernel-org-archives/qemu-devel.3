Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74027C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag1g-0006ZQ-1c; Thu, 15 Feb 2024 13:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1e-0006QL-Sy
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:59 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1J-0001mp-3f
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:54 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d107900457so16707871fa.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019966; x=1708624766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrBuPLAGG1fZ7WY06/YseND2NQgtprdQWY9GN68xHfA=;
 b=dD1co8GfEXj0QHU8vIP+Tjmsw935ORzWvqoEFBSOUlajuMKHEWIkCSCsZc2nmQ80Wi
 diByG00YRVFF7bnkHFlQ8AYBk+2+iSkGIt5Zif5mZyKExc0AQUhIoU1/GgHy40MzvCTR
 FEWhp0MfqR6ceEHgyDwDRyd9Rto7lOTfSHDbbYHi97UuJiCJK73gp9/EQgSgFoKQYozG
 ZsiFK2APJ24M9QP8WPzAnKbpMlABJsSGRItWQjZLf18zfhv1eVAUK3lLo+N9h1xBZxfr
 qYFUYSR/maY78Ez8csgUTQluNoqJAT43KRFZzmE04fZoI6K+2nOjdbUNlUM2p6uF/qmQ
 70sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019966; x=1708624766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrBuPLAGG1fZ7WY06/YseND2NQgtprdQWY9GN68xHfA=;
 b=ecPkAqy5yu5MhT8dQ5K4ahGsNCery9mdgmsxqj7+S+GUJ7AbtLRFy8Z4uMTHdLPFca
 /El8yt4xKuqgunPgTvOojMt5HBcta/B3Xu+UTWqwNE/6HJNhnyv29T5QdLIckSZFURI1
 uV+U2guA4zXpWH+ADX7IpaiIb1AxkhCx9EZHqu87utyqTr3KNVlwWtngdi3y3EEF56jo
 bWgMgfngU1ytrt8b5/rx/8VObRhLiGZXJg0LWcUOR2kSk40zg+XixXCeu+r6ajm3ubHv
 AoU11N+xcQq5C4xhe+75AUnZXEbaZsFiYgamiNupwO8d8zQWUE8kbfHSSYL2DCngf3bF
 jprw==
X-Gm-Message-State: AOJu0Yw8KMTPFJeXxZ0N+f+ZtWM8IjL+tt48mFb7tjPkEjy9AU3SZd5B
 vsoM1a43iePJNkCE+mq2ro2n2iMHa9HPIKh886lVICtngxHoJ1AVfkyEd2tPxdpY68DyY438YrB
 4gx4=
X-Google-Smtp-Source: AGHT+IH51ie+0zxxYbwkCimAJwZLbO7BGmjyRYpB43DbLlKiXrDqVxjE48WZv3EMDIQO6FZ/JnV0rA==
X-Received: by 2002:a2e:a54b:0:b0:2d2:fdc:8813 with SMTP id
 e11-20020a2ea54b000000b002d20fdc8813mr1374145ljn.50.1708019966234; 
 Thu, 15 Feb 2024 09:59:26 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 fl16-20020a05600c0b9000b0040fd3121c4asm2802873wmb.46.2024.02.15.09.59.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:59:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 14/56] target/mips: Remove the unused DisasContext::saar field
Date: Thu, 15 Feb 2024 18:57:08 +0100
Message-ID: <20240215175752.82828-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

DisasContext::saar is not used, remove it.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240209090513.9401-11-philmd@linaro.org>
---
 target/mips/tcg/translate.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 93a78b8121..2b6646b339 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -49,7 +49,6 @@ typedef struct DisasContext {
     bool mrp;
     bool nan2008;
     bool abs2008;
-    bool saar;
     bool mi;
     int gi;
 } DisasContext;
-- 
2.41.0


