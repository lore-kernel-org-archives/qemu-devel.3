Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE8DEE6451
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhs-0008GE-6z; Thu, 12 Sep 2024 02:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhm-0007my-65
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:28 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhk-0003U2-0W
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:25 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5365aec6fc1so649599e87.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124001; x=1726728801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5FoqK1kIA8mj7Qd/lvT8K/kPhvh2nZqcUgQPUn/2U+o=;
 b=XTNUFyTu2lmpzZsAWtv4mo0RQoaEe73o3W79l6tiGW87w4Hyeh2w5Dxh8GaUHpncsr
 yYRlXQSFFMKlrzZ9Aqwkl7+RyekhMQs13vG8d6BtLLBUrV1rLdm9KmgDob4TdgUohpMZ
 5s/hCNRNfW8eyftk2Q8CblTZrRzKW27sASEXZRaDI7z3g6a+mjJcHFDi1cnEi28mdhiV
 KZSPzyIRynZqX1R6zsqTCCCJs3YmZZqcINXT0kk4TNKka2hhJzSf8VN3Qc8kyRvoxwsa
 jy7PpFrQjsBwON9QYzrEF08xu9ODcizc5htKwZ4+nXBVNLm59gZi8CJN6W+Fj8Uf/rZt
 /HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124001; x=1726728801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5FoqK1kIA8mj7Qd/lvT8K/kPhvh2nZqcUgQPUn/2U+o=;
 b=QXukNxIxYcmSk+XrOzuT+TNvdXgpQr+l8QMI5nLzIv5oORJQKyUWctvZHsytZ151vF
 54GW3u/wZqV5vsB5xbFhWjxthEvBH4+aNmVXLZTGzwAXjpwkWfWBFN8YNS4KeQZzqC9c
 CWPGHdmAYU64BjPsWKbxJ2cplU7IMWxIg05ohz6XVOVEUqzuYYUMJoRJ26BrTZqtQ4Om
 yVmD/Fiklz3QBHyHBq8fiEJA5Or1ko1jvDXJVsWOTAbb4nS0N6ETTfg4mQl1DzBHt1Ng
 z7ccJBvygkJhB3Wqazt8xv0vCMrPiWqrYpSItVl4AUPriOKllsJseKjJXX6GC1n99NWJ
 KHFA==
X-Gm-Message-State: AOJu0YxX5W3AAUr63Lt2J/1zIKDzgiMmjorxiDM8oQehADgAqdQXw4Kr
 mHm7VjC9KPOVTA6ET/xxLgkcWGKg9zSKxtRnR6mR59gTQYMa0MgTxGjwnHrAJoLUwdYLsWT5Glt
 A
X-Google-Smtp-Source: AGHT+IGTZz+aE0ePcdX6QJ6/iPOF2WktjT1byifudGhS+2Npuc2quXQnM14oA4oRs2REobN6uHhvDA==
X-Received: by 2002:a05:6512:4019:b0:52e:fc7b:39cb with SMTP id
 2adb3069b0e04-53678fce759mr917978e87.26.1726124000681; 
 Wed, 11 Sep 2024 23:53:20 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caf016a08sm161947705e9.16.2024.09.11.23.53.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:53:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 54/61] hw/gpio: remove break after g_assert_not_reached()
Date: Thu, 12 Sep 2024 08:52:23 +0200
Message-ID: <20240912065227.67848-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Use of assert(false) can trip spurious control flow warnings from
some versions of GCC (i.e. using -fsanitize=thread with gcc-12):

  error: control reaches end of non-void function [-Werror=return-type]
        default:
            g_assert_not_reached();
            break;
          | ^^^^^

Solve that by removing the unreachable 'break' statement, unifying
the code base on g_assert_not_reached() instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-28-pierrick.bouvier@linaro.org>
[PMD: Add description suggested by Eric Blake]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/nrf51_gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index ffc7dff796..f259be651e 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -40,7 +40,6 @@ static bool is_connected(uint32_t config, uint32_t level)
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 
     return state;
-- 
2.45.2


