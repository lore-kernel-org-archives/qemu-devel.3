Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C08CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DQ9-0002nT-99; Fri, 10 Oct 2025 09:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DPx-0002fW-M1
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:44:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DP5-0008DO-5R
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:44:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso12414385e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103798; x=1760708598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQ1xy8T+SXo1JHTBucWTk/aOP1Ac+xvM/ygDmheTPxE=;
 b=m5w//XjQlm2YmAwHdnjSLtZZfmwSjmFXltxEjVwfgPnIQT6t1sSdvSd0153IH4PbQZ
 p+pgGHBwvTHT191v2USp9WK78d/ObrCRCoGc34LXVSOn2ukW4BRhe+0ORKRmxYOxy60Q
 kdAFjCsICKQFjLqsCLY7E6wQQtTCnkGOjwrhH09CCIZkSirHQiU3ttRz+Ax5li4eXJ+i
 jLHtPvBqCvFrkYGTqBo7KDkPh/yVYWUSwq78cI1TW/dZPRQP4ZBrzq4a7FdW8vNUwT2H
 0WWxix/q0b1e9zaZhOq7mvg+zNdX7RWiZTP3X+OtLMIH+eQrKf8ZGCb057un/SUeWkt2
 ih9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103798; x=1760708598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQ1xy8T+SXo1JHTBucWTk/aOP1Ac+xvM/ygDmheTPxE=;
 b=G47x01Uwyn7p5USEcf8tuIZN7RhvDBXUQFoJWXgdOByINnJzrwML+Iw5CJnwNjU+NY
 jFtx2GX+BIYrsW9qEKYvWLoe1W7CFbW8/jWDesckoddhwjbcGpWzD38qnuN7h9gRQDic
 NneeXqWwUL2qoExLMz85rhuG7Ili+zUWrq0BtKjITffNsfqwFFGP1Daajbu4vnxvrUkC
 KDd/zJrIT7W6TTM5QrsvCcNQH3YffrVQKywAtvSZGcAMAmc9BCHYVYGy2gInf0prGDDu
 MkjVACU9dv3GitvIlw+lYFzcxPl9ri55GsaTfFRGQ/nlFECOkV9PoJxn87A0iFAEoIrK
 4dFw==
X-Gm-Message-State: AOJu0Yxrh3xJORMSyU/xI0UafidIE9QOsNSF2TzBglGOGJmEXfCaZChl
 bRgiTh6Mm99NZ0yjkhGzMei7C61gUjwhxSnBnMIcpZ4hQucc0cWLawO9KasvK988sDZdw/Uf1Jk
 qxUG2Yoz4JQ==
X-Gm-Gg: ASbGncvy5ZJdFOH6PySxaOMsvPS8ySah8epTHSBgywNgkWO8Qes7oc1ASlBcIZUYJVR
 oMczuF+IqLe6eHUI5Rnpf6NmfReRCL+ZtacFGvjL01S6zrBdb7aZCy8I74b8ch3RwS9PshWqOyy
 1KYl5iSpBqRuUeN/0jHuZ1tC+pR2GKRx9fpzc6RrZoIoYkqBkQ1V6JD4UVzVhBxjBZMY2+VMnLC
 MNOon/UlQVTAoGet98pXNUsf616GSb8Ng7rZ15zzjGGY8nEOTRgMyHYTQG6P+cIfOuH3FLFAbPL
 6oDKealk87D1g+lvaUNmFOjqpV0O0cPS/O9bkYvbW44iJd9FLUN58k6kUWgWiplHthnsqyBaFQ1
 KBjxpUexySVqvagd+kCw6SqgMDThyIRCJq6B4WyBeJlU+M7BXbrZfda6NNgQ7xU+MGS6v4s2PZp
 yesov05P8QoGe1D0+mra3x2K8phJXbSA==
X-Google-Smtp-Source: AGHT+IFIPOzsMbnQa1BO9UiaMqXHUl6fRwbyBMETY9o6Uiq0UhksFIKSO4ECCTsdlFGZdCkYMwb9Ag==
X-Received: by 2002:a05:600c:a43:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-46fb32e50fcmr47908965e9.32.1760103797977; 
 Fri, 10 Oct 2025 06:43:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482ba41sm49073145e9.4.2025.10.10.06.43.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:43:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 09/16] target/alpha: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
Date: Fri, 10 Oct 2025 15:42:18 +0200
Message-ID: <20251010134226.72221-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Replace compile-time #ifdef with a runtime check to ensure all code
paths are built and tested. This reduces build-time configuration
complexity and improves maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a492520075e..b93cbe3b61f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -235,11 +235,12 @@ static TCGv dest_fpr(DisasContext *ctx, unsigned reg)
 static int get_flag_ofs(unsigned shift)
 {
     int ofs = offsetof(CPUAlphaState, flags);
-#if HOST_BIG_ENDIAN
-    ofs += 3 - (shift / 8);
-#else
-    ofs += shift / 8;
-#endif
+
+    if (HOST_BIG_ENDIAN) {
+        ofs += 3 - (shift / 8);
+    } else {
+        ofs += shift / 8;
+    }
     return ofs;
 }
 
-- 
2.51.0


