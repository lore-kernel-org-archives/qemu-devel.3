Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF6DCFC5EC
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syxLT-00087Z-AP; Thu, 10 Oct 2024 13:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxLR-00086z-Ld
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:53:01 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxLQ-00069g-9P
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:53:01 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8354d853f91so34231939f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728582779; x=1729187579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5NiMMM7LPvrXfhCGuaMN/pJhmT1Ybuu5mX8F9LLrXQ=;
 b=bRFMaUwK4fq9cchfgRxR6Ae1Ng6KLl1KLc0tkApBHkLoN+kSZI/LUiKEih7qreqHJq
 9Cv9wIxvhYHfRmViaEu/JEc0ZvjgCj+gVjevlhufiCwS6s+VgtdMnlinWtucap1TpvQC
 wknwKe/7PVu75sxM034q1GqzAKIJPel/O1RUM1qNHk4E39b7coNaN1U8+fvURlYqHlHD
 EisRBpt39+aOnjVcHMirBuuLwlqVA7ANHmPYCxOllZ8usJhT7tJYlsEIqw6b7t9zUNg/
 jRy+sV/3F0XmhGLjXd2W8D/pHfb0yILUAvPbb+H9hWbwR+644E3wKocbWLmEjmT8PNzk
 ZguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728582779; x=1729187579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5NiMMM7LPvrXfhCGuaMN/pJhmT1Ybuu5mX8F9LLrXQ=;
 b=ij1/e0+6L9t1QL6kFYM9Xg5JMyEW6HDbpNvQDzbMApvdiAA5Pi+Z8z507ouvg0Rxxk
 ox346QNPlvI1yyI35MeXqnfh0mx+6Grd5LWyZt/sIA3fyts9Gk4W57BkTClfPEq1brCL
 AxD0U2uIDNoJmyKjE8TnuF8Nnqeb9MW0iTGX+799LjaE64zz//61xGe4+QFlS+eS9j0R
 50DyR912D19O9FnAH4drnmiSIdhmKZpBJX5Ms3bcTCrkLZTdhZ186Qv46qq8dp2Wdfgt
 JnbUWTZz3ww5ciy6mdMoUdBDCcyzEIZ/x30mduNTDLlUvXv9YUF43lc8UrLTolCngOmC
 9d8w==
X-Gm-Message-State: AOJu0YyO+6wpLYCuKxCK/peZUokiNPjlhpi2+BlhlT7Iafu82S4FNEhN
 wA2RID2YffC3iHePSNG/ROTuR5LzfRLBl7HtNA7940X3v1ZMbi6eD6YxAFxSlwL+lrskmRHHRyO
 k
X-Google-Smtp-Source: AGHT+IGqyF3zpfYb/s6dyQxMHHimn6aYZhz8Ie+PnwXcWGSjbjU6eVYCFcI3pcgtU5dlXWCiVwzgUg==
X-Received: by 2002:a92:c544:0:b0:3a3:6b20:5e33 with SMTP id
 e9e14a558f8ab-3a3b51bca60mr3441285ab.12.1728582778659; 
 Thu, 10 Oct 2024 10:52:58 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea44909bd7sm1285679a12.50.2024.10.10.10.52.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 10:52:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 1/2] exec/tswap: Massage target_needs_bswap() definition
Date: Thu, 10 Oct 2024 14:52:45 -0300
Message-ID: <20241010175246.15779-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010175246.15779-1-philmd@linaro.org>
References: <20241010175246.15779-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd36.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Invert target_needs_bswap() comparison to match the
COMPILING_PER_TARGET definition (2 lines upper).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241004162118.84570-2-philmd@linaro.org>
---
 include/exec/tswap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index b7a41913475..ecd4faef015 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -28,7 +28,7 @@ bool target_words_bigendian(void);
 #ifdef COMPILING_PER_TARGET
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN)
 #else
-#define target_needs_bswap()  (target_words_bigendian() != HOST_BIG_ENDIAN)
+#define target_needs_bswap()  (HOST_BIG_ENDIAN != target_words_bigendian())
 #endif /* COMPILING_PER_TARGET */
 
 static inline uint16_t tswap16(uint16_t s)
-- 
2.45.2


