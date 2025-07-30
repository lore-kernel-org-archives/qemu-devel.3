Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5D6C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEzd-0001Nf-1T; Wed, 30 Jul 2025 18:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwb-0001XM-Ke
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:41 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwX-0002d9-06
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:41 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2403ceef461so3250385ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913195; x=1754517995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5MOCh8vZ85TyUX2Kr+LHdMr3zhcFbFlGuu1sgPE5wg=;
 b=RG5emM8YEy7KmmVSCFPt8rxFJW7qiyoVZpmdWCp4Q9FJVEfD1ECJwOm/8En2zwqXv1
 iCfi+cMDWJghZXiqgSLIQZvYwApwFv+tYDICvr9uLhm4RLUqdiR/EgsJ272qMdJQk3Du
 464vJ6nEW/yW1+fe+rkdbRjPsaDRJnbTfmpGllf3tbiNHB7oV+Klpi9WHqh3ngPW6I3j
 NwjO1a8ijbE3dxKEdEAZR6eIwqK9YUqG2KLmVOdg/egiyTtLhLCUI+vaL/tAKTXdHRY7
 n4WZcKzTeluRHCMD0IE9QIrUMDDp8z+as5gcWba/cI32rHMnWsjOrkt6ZflDKwzwmEMp
 Xo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913195; x=1754517995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5MOCh8vZ85TyUX2Kr+LHdMr3zhcFbFlGuu1sgPE5wg=;
 b=hWrTJ2RvPzHTtTAcTMIhzi1L7FqnXAKYbHxF0H+kD4YKnsQZzDqYUue7hLM8W4xK65
 CQk3KIVr5ZIONEsb7i9io83MxbddEHHlhQr7wtrnblFrypwBITD47k3/Ya65HyMlp0vh
 iuHhLBKQH2tzeclZ7dlkNDfXQlhI1b3AmXQcL1kI3nMGTKtOn2tpaiiu/ln6f1hrU0iV
 wtFbGk8Jm6otAPOjnb798h6GQo2LNAvrXP2Gpf0A44ToFR8ayzYXFR+/3WazBfCUMLba
 6gSIc73zG48K5DxtlKZvkENY0uZe/DufQfJsFfvoazTVjEDmRZa0O+mOaeE+WtK0MfZw
 MuZQ==
X-Gm-Message-State: AOJu0Ywya3SlLQG/GkEG+K2A3eG9Xamfx/i14wM97Ux22bEZIdxWFujB
 g8bb7GRTk+xY0fWt01muN4hJ/wlUEGqh5yVjwFFNswKwZ07TquMLQvudz7apN1DwtTVnCKiP1su
 SAsJH
X-Gm-Gg: ASbGncvehHLR8+Kd8TFFnKkBDyjPJTklxgRTVRpBzwVJDCptTwv6hGIKazLGeGWVc7N
 2LK0xPbv2Yi8PNEOuHp0iKHv0tqfOPsLdBsbX9V9ZjiuLc3yUT/oAGn5V2APURWN5KRZV00Kw+g
 +xV8+nhd4Hn8bLbV12/zpZOu77xpzXdLk7vVWp2fct4xIlJXIxJciebXflAJoWnROaSMI87BWVe
 jOcNGYoekJImsSuWBc7HmFFxfvRLMREWOx1C+QP6nPcGPqrov60MLMQDdpF8yYT47RDc7zDaXgY
 QxQay9WWimLdJkihln65kM8TcvQ5CNqAIH6volSCPaNxyc/CKG9IHZWWdOp6yAsunbFV/dvgWkp
 64ck5Y3HQF88A3ACXyoI3lw==
X-Google-Smtp-Source: AGHT+IF1HRNCCD7zRktuNXo7omeQUVfwXTQJyCef5uTGpBAFnihPPCxSFKsuYupnOc+fpQUlejtg0g==
X-Received: by 2002:a17:903:11d0:b0:240:2281:bd0e with SMTP id
 d9443c01a7336-24096a72dacmr70431405ad.2.1753913195279; 
 Wed, 30 Jul 2025 15:06:35 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d272sm981535ad.135.2025.07.30.15.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:06:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/10] semihosting/arm-compat-semi: replace target_long with
 int64_t
Date: Wed, 30 Jul 2025 15:06:19 -0700
Message-ID: <20250730220621.1142496-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index e3b520631b3..715a22528ab 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -502,7 +502,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_ISERROR:
         GET_ARG(0);
-        common_semi_set_ret(cs, (target_long)arg0 < 0);
+        common_semi_set_ret(cs, (int64_t)arg0 < 0);
         break;
 
     case TARGET_SYS_ISTTY:
-- 
2.47.2


