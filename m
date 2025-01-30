Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27575C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCQ-0003xI-EN; Thu, 30 Jan 2025 13:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCC-0003rV-7X
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:20 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZC8-0000UM-UM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:19 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4368a293339so13216945e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261395; x=1738866195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XVL1wlKsZQPV2VNsPNKghCDpbJZsLxmzWGbgwthcyk=;
 b=HWEY1YVP5vMFrNQ1SNjolJS2OFUUobKn2gJiUMxddHwEgLt4KdqfyxVbVDSdMnJoPX
 M3Od75YN9MZUhbTgB2Cbk0ZD4CYqr6/I8RLcxxkbD/n0QWoJYvNmO+oKSiweaVwUdJjl
 igic4PAl7wUrFDdDLUGOshVZMIk9MjITrZNQJSf6GYEE6mtsqLb0cReIh/bhX1IXwS4P
 qhVFdgCJAOt+LbzQompv7FLdv7timFEQfmxfkIANB/V43ebyU4ZYBWoRtX8V+YL4kwgq
 0OOVnfiZ8qBjWUtk6F8eUebKV96wOyc89wPPNeUIuHPyTq2HnUeI41b2rc6izbr+iHpp
 laYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261395; x=1738866195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9XVL1wlKsZQPV2VNsPNKghCDpbJZsLxmzWGbgwthcyk=;
 b=PaU2ujM/H3a+JsC44vlMq0YYIVlQiGXtlHPjXuUmPQZVNWsaFi0ldS3oSc466bkgWW
 U128Efl60RVwcChE2+RSn7peaCLfGsvPXQs1zgPPxoJFw4IflKEC/YL5ilMzhfSnV5cV
 JqR+laFPhltLug4hKOi0YTjnak0rOrbjpzfXCYXrk1R5B7D9nn06MD4/+gaYLGhjf0si
 xcnntjaFhDzAkeWzl+OJ2lV1N7gCs8gCqktwsKY7VHfslZkj9z1oIr+ulXVcmrW93UBl
 GCBaTcT7Q5qkCrdQiJwqsVZ6Mtjk0FdYSb+TQbJmzGm5MGRU0OsFylP8LTPJfqGHrvSI
 aPWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3jCvlFIMzknrC0pjliAPlN1Q1K5tNyMkQRUSJvSEbv1NDtS+1kd9UvUQSHWiH5hW12CT8S3mww0L0@nongnu.org
X-Gm-Message-State: AOJu0YxTltDHXRI8DwFdgufYtJ0+mwBG8aAlO45fDfEg+yp58eHlt4j1
 w3ooabMuR9EiGUJmrK+m/8JcxGuZmcEDBFiq+JiEtkMftE6Mlt8O3VFGeUV3amA=
X-Gm-Gg: ASbGncu9MvbwiuLEPXlgkZQIjpA+EMGDWgtXVbJBLDkUwNIvWJX+IxDCEWVrM6oxpN/
 lIWfAi4wDNUGa9l6gf9IauJFXz2j1DE9LGnhomOX0iDgZMppTGfGWcYIkuAcvm9qYeJhQi6AzHq
 IKXKdnftauSiLqyFD9jxLl8TRK7uTifmUqeu0nlDaRv5BMxiC/tX636JjjwqmOxRdPgRY0DVWB9
 J9WUddo2nrH/gl8K+4OvufISdrq8pSwf+IYsnEsExuKF07NAG4G4aUCW1gtJRNwYii1XNO0l1li
 GXpwLznz6P/wFj4nYdenhA==
X-Google-Smtp-Source: AGHT+IFEl4mBtaDwDRKh+R7ZNm0NJQGZd+X2Nd39Y7GBdCSES7z22sohAmIx6YE8+sjAuWJkmujg8g==
X-Received: by 2002:a05:6000:1862:b0:38c:5d42:1528 with SMTP id
 ffacd0b85a97d-38c5d4218cemr2970194f8f.40.1738261395345; 
 Thu, 30 Jan 2025 10:23:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 04/14] target/arm: Report correct syndrome for UNDEFINED LOR
 sysregs when NS=0
Date: Thu, 30 Jan 2025 18:22:59 +0000
Message-Id: <20250130182309.717346-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The pseudocode for the accessors for the LOR sysregs says they
are UNDEFINED if SCR_EL3.NS is 0. We were reporting the wrong
syndrome value here; use CP_ACCESS_TRAP_UNCATEGORIZED.

Cc: qemu-stable@nongnu.org
Fixes: 2d7137c10faf ("target/arm: Implement the ARMv8.1-LOR extension")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 74b556b6766..5d9eca35c04 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6750,8 +6750,8 @@ static CPAccessResult access_lor_other(CPUARMState *env,
                                        const ARMCPRegInfo *ri, bool isread)
 {
     if (arm_is_secure_below_el3(env)) {
-        /* Access denied in secure mode.  */
-        return CP_ACCESS_TRAP;
+        /* UNDEF if SCR_EL3.NS == 0 */
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return access_lor_ns(env, ri, isread);
 }
-- 
2.34.1


