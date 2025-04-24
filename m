Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D202BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krL-0003SF-7C; Wed, 23 Apr 2025 20:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqW-00013Z-9u
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq7-0004hw-2C
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:20 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so337692b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455997; x=1746060797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCrJRVmkbpqEup9kvYUmZ9cHZpBXmxcMhYIM1xbP21g=;
 b=iAkEsFdREI3xvFydTnJ2/ACHG9KsEm892KPH/W2H2zqXlx5N/pHvVDj5pZmLxa5w9U
 AMawk44JMYg2Dt3n+3G+cJ7HeGdgXmsJZTrssbPYh5REEMm0GTf/z7A7F0iLDRk5n023
 gVMRYrli3d4Thb4p6k9EQmhdYkITvtALOQPGkb0nXFhkCVI8oH51SCb02HGIqZYZcpzz
 FoVzMIRetIhC3e2uw1Imdmg+HLNmQPM+0lfNaPxZTyI+BX4Df3L+sMX+d+2Zuv6umAYU
 OrC/sAUfz65SHXJULeJOMXhlWB2IBcu1E9QY2Ab8PS1sSlS2xx5VbPlSx7oxr2SgebYb
 /K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455997; x=1746060797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCrJRVmkbpqEup9kvYUmZ9cHZpBXmxcMhYIM1xbP21g=;
 b=bCzdROS5tHVVplMhNIG/pAbuzNKjTuJbyAr0qUKJeG4BV0CRd0zPB5hENOmdsf2xqc
 Skyko8C9/uNPDPO7wgKm4kzLK+g/VFuEcfosrMcl972IisTQ++aUqgfZGxpOVisW3yut
 jnTpqnMi7YTagAP6Lqbmhp/KRU6s0wuw2Yb5+y8vgbkLrjZTRj0+JqE0TCddeh7WHFpX
 s3cjwv/ttqI0bZ64tsb7hp+M9U1zuQMcTw+2bgsX//OuFoUtzlVAejr4BgZLae05t+hP
 il3TvAR4KAiHv3qgD10UAj7pKx7D/y21AW9+na1KlnN1bTri2N+r7RXNb33MjZEdvAT5
 iYHg==
X-Gm-Message-State: AOJu0YyAfIGQd9h+7ACmwKK4snPPGKmyw5EgUtxn6LIcyeKPiYWY54Dv
 KXw/+vaiLZNgWUt0mYoXdPTvlVorzA84TX3KJRMlEnVi6hTO6AKaKT4nmLyRMRGw5rmmThjkcQE
 6
X-Gm-Gg: ASbGncuj+kVf+UL0p2xgY09FH83OK7PwZaNKZXv5uBkaXmNFlv+c6fL6qClGDgkInWf
 7InWwaHmNTeNxet1N31FDJV7ML70Cia/FxnwFU+iGjnUZqYeVBViKn9oL6gCaXaqG7m5iTThkRi
 MBDYgpCns6Mh4cXZkVujuD+LYmkTaMREDaR93TirBikWDR+0EUvfFH185kreiu5uBQg/DMvmA7y
 kXjk3oQjU/jid2H/P29h+pINECV/P8mEA25eXzpphj4b5LLAQpzd+GcFoRHBeD6bQPT7Y/EGOss
 MwBAd9jNdiDe8sjI1aKn0fMKqxmj2+YswrfrL75NBSGNZWn7V6N5fU7qTtlEdGFY8DnCVUm7Tvk
 =
X-Google-Smtp-Source: AGHT+IHb09rYN2NCy5Rxf2AnuEhFhHhOUMRdbVhZ+Llxm3gNevNcLAB2Cfa8Ux/TuDaChebFJokc5A==
X-Received: by 2002:a05:6a00:1d88:b0:736:b402:533a with SMTP id
 d2e1a72fcca58-73e245bd3c1mr1007869b3a.1.1745455997489; 
 Wed, 23 Apr 2025 17:53:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 054/148] include/hw/intc: Remove ifndef CONFIG_USER_ONLY from
 armv7m_nvic.h
Date: Wed, 23 Apr 2025 17:47:59 -0700
Message-ID: <20250424004934.598783-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.  The inlines
for user-only are unused.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/intc/armv7m_nvic.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 89fe8aedaa..7b9964fe7e 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -189,21 +189,7 @@ int armv7m_nvic_raw_execution_priority(NVICState *s);
  * @secure: the security state to test
  * This corresponds to the pseudocode IsReqExecPriNeg().
  */
-#ifndef CONFIG_USER_ONLY
 bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure);
-#else
-static inline bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure)
-{
-    return false;
-}
-#endif
-#ifndef CONFIG_USER_ONLY
 bool armv7m_nvic_can_take_pending_exception(NVICState *s);
-#else
-static inline bool armv7m_nvic_can_take_pending_exception(NVICState *s)
-{
-    return true;
-}
-#endif
 
 #endif
-- 
2.43.0


