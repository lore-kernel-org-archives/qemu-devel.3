Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43BCCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmA-0006BA-5N; Sat, 30 Aug 2025 11:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bp-0004qW-KL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bn-0003up-Q7
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:13 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so2376705b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506609; x=1757111409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5ZB4KmZVQ2PXnRTjB721lcPMBvmO4keQCU+w332d1U=;
 b=EvvyauHAW5i8EcEA45vOOzdXPcvKpUeIA8RcYZOW0qLNHX/gVd1jVJe5f2c1kyplQg
 2XGgkO3PdyIKki/kFu/rFd2a1JWW/mLdqz30W+69ZmuJYuaFjtotwthVLyuIjymgNziL
 +yl2r/kO+X21qSp+Zq8XSzDoBjQdgu0fFklRbTriYemFrtycNhIaa0VemoTyeeDgK8jG
 ZOW6JpI4HHkbn8TCR8OiDPlC5jfX+VpcWrbFn+pYO5hX0sF3Qz0LoVvu02kG7k6zdB0D
 BrL5PzBE7KEu88t1ysTGAzBTn06IxJ007A4xu9uaxVHxA/+jtYhIXda/vNgoDniHm6PO
 /EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506609; x=1757111409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5ZB4KmZVQ2PXnRTjB721lcPMBvmO4keQCU+w332d1U=;
 b=fOmIFmbujqo55ybSOzIz0AyJkp/ccx4y5rO3awNA8pihLhIO9i8IF8yWIpFiTf1DB6
 KDxaCHNTxsu6XhQ/1Y62tPIlDV2pcYnONoJIGMq6CV/P2hOMUma1puFcaYE3CTkCf8SZ
 un8UE0BY5gNgz2ciWbrAn21vjaRoWdNemPjuq9MrvhdvcJRyuji83jC8wb7EUx8Mbubp
 NK6IU6yZ2OtOZCFHKgWdGzFqJRK9cKx8jtY2sn/vyinmdiurpAMzd7bD9LCiRKRtK16w
 s6hK8Eqtg/0ZOj569jkyyXUzs1bsLugAi7zy6g8hKPbRz5hhrIEaS96fnR1T8K3FCBWr
 Pc7w==
X-Gm-Message-State: AOJu0Yw+sdZURAVKxTneRnxBHLd+EIU+qBbvdW1hOGwPXYjyA4O//AA7
 xSG5pJZ6Peaz1NXkUHDJVVpsss0EugIXhqFEVfd9t/3CaALInpLfb8mR9czrhix3a/BCPiGu+8+
 6upkzwUw=
X-Gm-Gg: ASbGncvr9ARd+8oHH8So8fNRT5AM1T/CB2DSKdGS57PkU0RAQhSMIKPwWuEh7Jvekoh
 okg6Ujyx3t/tB8+E4PtTkR8O7IvPEvMdYBwH/o6ZsPLpiP8NNWXEi/J44S81ZkTwA90nhchyzS4
 gI44+7YeC/XEeZ4uOw8wzkUall+KrG8n2QSni2IPNvLc/VdBuZ8ymcxPh/Qy/vuP1U+sYKvGFoE
 QyhypQ2YBE75oMxUQSVRlD0xJ1RPCVRhFg5jhtk+P+hJX/y5k8VyPUVhfKupd2fXFQVjOoy/ZEZ
 R+VpmH/+LQEdJdgyqRP9qjGBfKbrq9SOmoXKCmjGbJwVSEZe7KbQy9b0qQmJpVKaOEX7yTd6WBH
 qQqWdl0NLHic3+FXLQsaQEkdPJIIcsCxEU08uHaDWDZWoZx4iHyTHD/7Z6JZIWDdvQxWsRKUXAA
 ==
X-Google-Smtp-Source: AGHT+IGHqgg7wkZ0kwEJIR3d73aTGX5O9uPbcVO3nbt03uQkEXvz/39vWmDcEo7uMgunVpjSxO0J8w==
X-Received: by 2002:a05:6a00:21c9:b0:736:4e14:8ec5 with SMTP id
 d2e1a72fcca58-7723e3374d8mr254396b3a.11.1756506608810; 
 Fri, 29 Aug 2025 15:30:08 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 64/91] linux-user: Replace init_guest_commpage macro with
 function
Date: Sat, 30 Aug 2025 08:24:00 +1000
Message-ID: <20250829222427.289668-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Turn the fallback macro into a function.  This will produce
a link error if the other macros are set up incorrectly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 25f29e60de..81bf05f581 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1115,7 +1115,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 #define HI_COMMPAGE 0
 #define LO_COMMPAGE -1
 #ifndef HAVE_GUEST_COMMPAGE
-#define init_guest_commpage() true
+bool init_guest_commpage(void) { return true; }
 #endif
 #endif
 
-- 
2.43.0


