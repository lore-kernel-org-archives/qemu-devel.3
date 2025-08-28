Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3F0C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBL-0002TM-UX; Thu, 28 Aug 2025 13:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbb3-0007DY-JN
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbaw-0000q4-Kp
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:17 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24622df0d95so6565585ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383549; x=1756988349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XkK8vg61qwmI34q6ceU14P1e/6apOaEvxBAxU5ibvs=;
 b=t5QGlsYI1S0ypABAm1x3XFb3CQLlP+HbjsX7WeoA0Wb0rt51eBGZ5ItjM5UGuS5e0O
 tmMAV/WQr4G1lJfcMmqnxXlBXWk4+tLPYE+W6NcA0WrbNZkYJ7Y6RBbwwUn8S3tWNhPu
 2xdhegkJuikV4qKKosl7yXhZrQu/8pN4koMlHNkZUFGcHpV6mXtSFOBPxrCPTadvauq8
 hA+jEjuFD4m0OiFaOe8cgsilPIrFJ4PrDIJd1xOeF46VTGlqfpLjyng2KSkeydTG2dj0
 qs5SMEK1k8lnKbuV/KoQ5c6NAGSORJPkLMTQTrV2W0uq7ZGJY4CA4xXJnTJjNEAntKU8
 n/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383549; x=1756988349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XkK8vg61qwmI34q6ceU14P1e/6apOaEvxBAxU5ibvs=;
 b=lP7RWor3Tf8gGLuzPAFzm/+X1Xu9zgf90e2u9jDRcQYxMa/pBRzLkdLp3dMrTGJAR6
 BgpPL4yGyArRpnF5iGoX3IivjIym8RVM1FQKE4PH8I4Bdyfp3IofWqWxkI4uf8o9S36X
 /nKsDvPw6RO8px+yJ8+T9m2iU2jWchFMOf7I6wv0jBgYGtLWNOwgGYfb0y4GhTPBVQwt
 hGQDNZtRkHZJAazsdsMWMiDWehxeXWWFAo5EjEXm0esmsOGJuuLUiu1sIRJRMSuJdOTw
 XiA2Mp8BAoXLjCycxyWqwc+M+ZaQaT9yWE8QX0EnWnLshFMrPLGdc88syjs+iehUMyBq
 45IA==
X-Gm-Message-State: AOJu0YyP/Ysy5vWUfCWjz/miI2sDQ5HRvFBnCDH5XU43VFlMM/QECno3
 ByIs0zbAh2BlZsZzQ9VN9kA3E+igWyiaHt5rey3gLndLav6DCPnOIWsh34fhQNiwMUArW+wJrXm
 gfwJe4L0=
X-Gm-Gg: ASbGncukRFdx4PMC+t0H/bt69ecxR6sEvY7jycCYwjswWJzbHd5VG7DAcrjOuOev7MN
 4tiNyagdvZpf+j++faI58y7KmyG5goUXa861BIfchp6k+H6ChtunQnARs1ieqN/ZLBnCNkkB+gB
 im/FLKAOH/E56HDkoEoVnWIFcAbRZb2Bi40nNGiNAdaZMkV6NHMDUE6oDSrUIozpovSOiOq5xt/
 LddIrTXwJ9PwuhctQC8ATpFO4C1EhyOuOTFGXjVErkMXpiSeaEM0/t71bG2VkwPnFwvc+JNVzzr
 7htKfg/tH2D/yrn7VZxn0xKaqKSLxjiP52svneHEP4wGx3pvFe42S2NRjH6RFCovVWfLjG1jVY3
 0arEZnMZDQi0mrayTMm3V4aEQMg==
X-Google-Smtp-Source: AGHT+IEhLnSINAzIBAkFLnNYNExqkffZ8XEayLh5uhzGsmb5gtfVpPTnP0MthyYMfIA1HKZxM06S6Q==
X-Received: by 2002:a17:902:db11:b0:248:f30c:9544 with SMTP id
 d9443c01a7336-248f30c98f5mr8465145ad.50.1756383548803; 
 Thu, 28 Aug 2025 05:19:08 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248953dc1f4sm48898735ad.30.2025.08.28.05.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:19:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 83/87] linux-user: Remove MAP_DENYWRITE from elfload.c
Date: Thu, 28 Aug 2025 22:08:32 +1000
Message-ID: <20250828120836.195358-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

The last use of this fallback was removed in bf858897b769.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c0326928d4..8b92fba0f0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -105,11 +105,6 @@ int info_is_fdpic(struct image_info *info)
     return info->personality == PER_LINUX_FDPIC;
 }
 
-/* this flag is uneffective under linux too, should be deleted */
-#ifndef MAP_DENYWRITE
-#define MAP_DENYWRITE 0
-#endif
-
 #if TARGET_BIG_ENDIAN
 #define ELF_DATA        ELFDATA2MSB
 #else
-- 
2.43.0


