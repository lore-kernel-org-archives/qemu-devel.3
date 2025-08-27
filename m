Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47F0CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSR-0002US-IK; Wed, 27 Aug 2025 19:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSE-0002Ad-SH
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:25 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSC-0004EF-B6
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:21 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7704f3c4708so473715b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336879; x=1756941679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBti5m0dF6b3Sc0I6qGteHg5X6Zr9g2kU2k58zFoTUk=;
 b=tABJZGatKhz3BB+cnCxmW1MF0dm6Lm0laQ61XpzqLVjlrtGsnayoKRi9aQRK1E3JZr
 qzSLklDyxZNKXoLr9u/yJdLXV7RGhj6+YOOd7PM/22GiLaVBwd/ycUVcQhi6wRsj3fag
 230x2wXMcskLdjCh/mVRs+oTaG0v8oVP7iqsKEw4K5BjZ2O2X5oZhRYLaSrE8yxNH0CY
 T6ivKjvrdBqUUkIxWelFcQfrBhbIz/AqYRD8ylsmBF1MIUb7eH82+w0zCiyCZM5zU0Ic
 hR/h+kFzYNVQvVGevAVqNIGPCFXPi6ouJc427apQwYaZQkdF/Z2Og3NrZiZGLH3XYnn9
 y9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336879; x=1756941679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBti5m0dF6b3Sc0I6qGteHg5X6Zr9g2kU2k58zFoTUk=;
 b=YhCiJK3MMQyKHDCebsIN+gaBfWrxFCP5TRJQ+b04H46onK9Vrpo2hlNrv0g6hpWOaX
 ss0d+IbHVZ3w1Er9x2pM8/CvMtsRbYmVjIOSHrd1TxbTqjR2YA0VQ52zPTwDmTpxbbWv
 rMuovxUqrtrHAqnkJ09VXyqjcGm824Pvr0L6m57JBBPinuVGORvfKNfS/e9UGgJwT9yn
 jnYFh3rpBYHmbxdVzSjDjuJk8JSo0n272RlQczpmCCZ2brXvETKCax76lIsCa5lmQQzz
 wV80eKJPiLkxnjNmSxif++nV+XetDwgwvPR94+e1OjbQUEo41dPnbdobuPc03p9DXNTs
 vNmQ==
X-Gm-Message-State: AOJu0YyhLRFc03ane1xpVqwGyYgb9U753f4Fumi9kdZk54cpuOokmVQq
 7nHTJ+pZcDtZJXAgWC7rzueRnI/NfLXlt3sRYevDS7AseFCCCSLYZWFuo//gnFkuWsUHS49LvDb
 ivies5S0=
X-Gm-Gg: ASbGncvhbO5Dr/4Wb6lVZEB2Odm06jZcmpKP8HM7rBH5FfMyPvldLy745QMiM/RarzR
 AUJ480l9awtIQfIJBHuFlBNMOADNH4b3Jmt6Ao89bAI2VBDOMIefQ6KZncbkSFESIUoOUp4ZLlD
 z7hRhadExFGNkHyzNNoLHTtLMDT2ZX9uwNCONElb/Aj6Ht0bioxWcwXnsK1zw+Eyb8Vd7d2hMT0
 FMhbsBdNwWE00+gxpYvzHj+28ofKFDKt1u2hJcXz+VehOyISgKh8LmCtYp6uqDRZpggacawGBzo
 sn8UOr+5bhL1dKBjxpf8gOjgT+czmwhtpBOaBQk+HJrzJ/8x1l9MwlxJ64uOshp4G0uu/zb6oxu
 LUA7WPWAYksOYUTjOxWUrZDDn5Q==
X-Google-Smtp-Source: AGHT+IE93YZJKwBIGC7asC1ZPKHdQeAdQoY16l7gRIab73uCBUTdi4ltlKAi9KKKWk4lL/VtHrUN+w==
X-Received: by 2002:a05:6a20:258c:b0:243:a2f1:f874 with SMTP id
 adf61e73a8af0-243a2f237c4mr4432529637.29.1756336878827; 
 Wed, 27 Aug 2025 16:21:18 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/46] linux-user/i386: Return const data from get_elf_platform
Date: Thu, 28 Aug 2025 09:19:55 +1000
Message-ID: <20250827232023.50398-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Rather than modify a static buffer, index into an array of const data.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/elfload.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index 1b759098ca..ef3a6c35d2 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -17,13 +17,9 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 
 const char *get_elf_platform(CPUState *cs)
 {
-    static char elf_platform[] = "i386";
+    static const char elf_platform[4][5] = { "i386", "i486", "i586", "i686" };
     int family = object_property_get_int(OBJECT(cs), "family", NULL);
-    if (family > 6) {
-        family = 6;
-    }
-    if (family >= 3) {
-        elf_platform[1] = '0' + family;
-    }
-    return elf_platform;
+
+    family = MAX(MIN(family, 6), 3);
+    return elf_platform[family - 3];
 }
-- 
2.43.0


