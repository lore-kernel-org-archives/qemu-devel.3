Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED898C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ku8-000177-46; Tue, 22 Apr 2025 17:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktx-000106-FT
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktu-0000Pl-Qz
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:32 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so4644525b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745356289; x=1745961089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCJi3VefDp1h9YGRzx2ZhwuHJPfCFRYXDFVN4BuW5IE=;
 b=PmhBPGGYVs17fXwz1dqFzIJ/zxyTEyVUA5Y3cHz0yOiPi4U0gURuV0mSOyZdxeajWy
 XdN9ePa7Pc3NCFefFlltDasItRecbZicsc1L9aUXt/6Q5qo9xrFjpqpMClc/zlowM+xb
 SkJgUhbJ949ANmBbDC/f+JyhIYeE5a5+9uyuIusBvaRYW3Uzs68PtDJWqzzTFXDTdEb7
 0377RnqdYiPvoDItcftJXrSX8P+F5PG+qXPCQxqTf64hdp4G9cuoCcwC2jno8eLfN4D0
 ZyGCrXcKOf27OukQYjSwBEdN6A8j0w/50DGqB21U1Bix8TeAWqvBqdR16OA34xHuGguT
 b+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356289; x=1745961089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCJi3VefDp1h9YGRzx2ZhwuHJPfCFRYXDFVN4BuW5IE=;
 b=P6momhNkkMmAdEUnzCyH70yAFDn33UgRtv3hQNZgxFlLYZa8Oro/9bCQNLe8lkTaic
 hXwB3Qi8YEbdxOfILCHCf3hEssDz8ONXtyJLapmWVGXnU3XZc/2/b/FToE54NcEVf5XV
 68E7vujB19L9p0zZXiOGJAC8xXXfBqlXYlNTCqMQkx0+lMpoWRSRcaz5qKqp4hopiFlH
 /3KjWUaqXciqOLqkllJLVhrnewiDp3tPtQs0u0wEy5r2mV9AviGc+zGXsnKsy6MLwTiY
 nWxZnA/0PlFH3BYAEoCA6EZAerLsboyvBFVu0uOgvGhhW+eLdSGyH+0rAIk6SMNWFh55
 xSsw==
X-Gm-Message-State: AOJu0YzmFKI43B4K4sOr2FHqFG5Grq76p5oT/r/KWj1KfO6uhBVKDJoD
 V71Tjq61/Q/qS9N7D/xEDQ0XodNYJdQjd648yPOTCTK/nfHSB6nEUeoZDIHkJsAkzRvBHNvzxwj
 L
X-Gm-Gg: ASbGncvc+hMZEx7OEuE8YiCocyZgIzxahbmO5umSo+/VEJ7KqO2dBUT2IMhPOJSyFgG
 q0YJz2lK05ARvXaWYdl+oxsXjqXQO+uB2jF1KufC0s7wyfAicOXdAgj74OMNQNIY7J71VydgwEL
 56taYFG0IFkbY+66HJKaGdTA9k7/NRR1mMT4B/fESPd//JjF/8qZ6bqODoElyDiaQ3RW1DlotQO
 0Ri2ofzxCr9qaeQzQT9nf9Aldz6Xm85MfNtHdrXytNFzpQk7XOnoOWVGSRKGjP+FCXiKihFiD3e
 hunR1xYzroYvmQY/tDt6d+syKZdm0GE3365JO06hDN5VFzGKMNxYKmxDdGS3mALEZz4Zb4VEoEk
 =
X-Google-Smtp-Source: AGHT+IEsYXJ9IdBw/4+IGbCQ+BW/bZxGgrfjlNwgj1iiPvAkxaZLX4EDuNT/U+TrKX40xmmNoopz1w==
X-Received: by 2002:a05:6a00:3a07:b0:736:a4ca:62e1 with SMTP id
 d2e1a72fcca58-73dc148b063mr19811760b3a.6.1745356288947; 
 Tue, 22 Apr 2025 14:11:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm9448160b3a.55.2025.04.22.14.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:11:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 5/9] target/avr: Remove NUMBER_OF_IO_REGISTERS
Date: Tue, 22 Apr 2025 14:11:20 -0700
Message-ID: <20250422211124.305724-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422211124.305724-1-richard.henderson@linaro.org>
References: <20250422211124.305724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

This define is no longer used.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 6f68060ab0..9862705c6a 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -45,8 +45,6 @@
 
 /* Number of CPU registers */
 #define NUMBER_OF_CPU_REGISTERS 32
-/* Number of IO registers accessible by ld/st/in/out */
-#define NUMBER_OF_IO_REGISTERS 64
 
 /* CPU registers mapped into i/o ports 0x38-0x3f. */
 #define REG_38_RAMPD  0
-- 
2.43.0


