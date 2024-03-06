Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3A1C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWY-0005DN-2n; Wed, 06 Mar 2024 01:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWS-00054f-B0
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:00 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWQ-0006HS-0j
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:00 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so6015059a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705577; x=1710310377;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yGeMs1iCZ0kYFimT5ghb04qtjFZ9LFucaNJHUGnodnI=;
 b=KrFz/HSMEuAYcW4zzh91quGXRXsCDYnR2Uo9t9p1yZsigRTtBK7I5Ocnzbzy2kTR85
 AMXAWkwsOjR/RYf0uBerAe65q3KTQIR4YC0b4JM+5efhy/gr6SII9EHnHdPliAvzR2Sm
 4nijgBlH4K5z11lQVWTCEuwKpHnY8typ5/BNDK/0XVCQc1r0WcsKJ5+wzuTsKRh1TEgD
 9CNZdi+2piMe/S7Xv1I5qRAzNEKzmrMfleKvM18Q/XZiLjsMh7gAEhRrDw0FJcLGQ+O+
 D/m4VlRDHbaeSq1DgEnMJ/l5P7VGa/+8wITcTzPFPEfo4aSJ9fGdlASRc06NHe5PDx5b
 2J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705577; x=1710310377;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGeMs1iCZ0kYFimT5ghb04qtjFZ9LFucaNJHUGnodnI=;
 b=Xtq4JiEGGQdzFSl0w1pO0znokVIe9aw5lIWkb5TQNvHdzZHL3x6rtDvltJxJQNVfMD
 yl059xRKL6f0Hn2lgLIO9dQHFVi4mvY6KpGfRHrJdY+DKtxRtrFqttI1XkTQHXvJu6Df
 S6+XI52BSCYc8x/EsKTaWJam5VTOCJ+/pyPaXed8GoqqVQZNMzIbV1WBP9snPxAOl2L5
 KhVw7Wd/4Wyl6t50ZVKEeS/drk4Ys6pR92Eys6ssh8WDzMs+HummfK/0z0WfZGyBXwuz
 q52xc+zTb4UYi3S839XQJUOXjpzQxq60ZG769wiVE2QuHkeP6jSYqsrxQMwSjzNdWdRL
 R1eQ==
X-Gm-Message-State: AOJu0Yz6MGZ9vvLqi91mQ8/NQCD0tktSp1obDUYLGgEAMHllmYItdGuk
 +UidRG81Pl5J8Ffwcl6bfrlaHwmW5jmC+Pt5WCyCJW3tbRA8KN6itakQO9yW0jg=
X-Google-Smtp-Source: AGHT+IGrkiDILy/5lZjvpi5U7foXOTMdKbyQzXaBxkcKse70tbDLJjNMfb6HC17MBWa8fnZSspNF0w==
X-Received: by 2002:a05:6a20:7350:b0:1a1:67b2:8cf7 with SMTP id
 v16-20020a056a20735000b001a167b28cf7mr614478pzc.31.1709705576740; 
 Tue, 05 Mar 2024 22:12:56 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 kw13-20020a170902f90d00b001dc90ac1cecsm11598573plb.284.2024.03.05.22.12.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:20 +0900
Subject: [PATCH v3 14/19] contrib/elf2dmp: Use rol64() to decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-14-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

rol64() is roubust against too large shift values and fixes UBSan
warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 51e1abe26a17..e404612bec00 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 
 #include "err.h"
 #include "addrspace.h"
@@ -47,11 +48,6 @@ static const uint64_t SharedUserData = 0xfffff78000000000;
     s ? printf(#s" = 0x%016"PRIx64"\n", s) :\
     eprintf("Failed to resolve "#s"\n"), s)
 
-static uint64_t rol(uint64_t x, uint64_t y)
-{
-    return (x << y) | (x >> (64 - y));
-}
-
 /*
  * Decoding algorithm can be found in Volatility project
  */
@@ -64,7 +60,7 @@ static void kdbg_decode(uint64_t *dst, uint64_t *src, size_t size,
         uint64_t block;
 
         block = src[i];
-        block = rol(block ^ kwn, (uint8_t)kwn);
+        block = rol64(block ^ kwn, kwn);
         block = __builtin_bswap64(block ^ kdbe) ^ kwa;
         dst[i] = block;
     }

-- 
2.44.0


