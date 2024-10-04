Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F28DCF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlE2-0005Rw-Mf; Fri, 04 Oct 2024 12:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlDu-0005EP-63
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:32:10 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlDs-0005hP-JS
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:32:09 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fadb636abaso25047121fa.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059526; x=1728664326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKHjWYe4hWo3y6AeSVqqoaCH56JRUztKe8mH70Hqsj0=;
 b=i2/RIa90UJ5HcmJkX0mtWXoQsdZZq+tyvEEbeoQeXftOnapYbGJYFrXrBfgzGUdNqF
 V2w4YALqvYtZYMj2r0UdiRepdbFK/BBZMJ+x5ODzo/A7bnd3+o4GxdijTSvw+LbgANoy
 yF1shnSDd1VnqJTTeBFfLANaBjoFcImBiM7ZwWEUNBGenvw7Lhod4XeTT8bZ6+cBYimU
 0FKqy2QBdiJJQNXx6VPAH8kiR36dxWCF+Hp9yJg3JWML+PMa8zmrkCnXvPzVuXt/ocBQ
 jtHtuUtUNnyYU3t41JOrYVWwni8bPuQDrwcxpeyvLtKm1WiZOP25ckxXDJfJdVxnuxcr
 Jm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059526; x=1728664326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKHjWYe4hWo3y6AeSVqqoaCH56JRUztKe8mH70Hqsj0=;
 b=ngM2DSAUI1D8kM4TNVc3RHOdRcZ2j9ILjN45pdjb9+gSVgnE42ARvmJOtvATXrqfzM
 +rBIgw5tiZfB5xqXzTJoXDD/3CIcnzVZWeks9wvU6cGJn+dYpf9G+V0n+lE4ohHieFQS
 u5MweWmwfj9XKctU0bUFpczdqYSwK1o9uWm2RRo4rtGmWqqYKwdMi33HuAu4J+2zrVva
 rpW8K9Rea9GSYUKFbmD+1uOTFQeEloybayEVI9F4No6bYzfXt+hKkN8mTXzwmOZ2jhtp
 zI86IxLRfi4u26lRDWncEPISMtngidEQCuIjUL2Pllps4PKjXaSAYYWNLSeZzP+VH+kM
 XNOg==
X-Gm-Message-State: AOJu0YyTXlbJ0HOhtMKf0/HBUU7hIGhPRjY5j90MHrUorBMZtGD2Ibee
 1I+LN/n60ZVoGQwI7x+vw+uoahiPb4Zar3EGrKkbfhKmpe8iMvGa8CxbtyhBvaiSrk+xyYmArw1
 eh5Uqsw==
X-Google-Smtp-Source: AGHT+IEMDO5su4/asKew0kpLbAIKmyXmPonSSWE40YWku84+mJzIUTJQbpBvY7rsFfmLpNmfBGcL4Q==
X-Received: by 2002:a05:6512:b90:b0:539:936c:983e with SMTP id
 2adb3069b0e04-539ab9ed416mr2061219e87.53.1728059526340; 
 Fri, 04 Oct 2024 09:32:06 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff2838esm425e87.270.2024.10.04.09.32.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:32:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/25] gdbstub/helpers: Introduce ldtul_$endian_p() helpers
Date: Fri,  4 Oct 2024 13:30:21 -0300
Message-ID: <20241004163042.85922-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce ldtul_le_p() and ldtul_be_p() to use directly
in place of ldtul_p() when a target endianness is fixed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index fd83e366a51..e783d166865 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -99,5 +99,7 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #endif
 
 #define ldtul_p(addr) ldn_p(addr, TARGET_LONG_SIZE)
+#define ldtul_le_p(addr) ldn_le_p(addr, TARGET_LONG_SIZE)
+#define ldtul_be_p(addr) ldn_be_p(addr, TARGET_LONG_SIZE)
 
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.45.2


