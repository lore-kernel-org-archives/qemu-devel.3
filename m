Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2774EC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWb-0004pT-4L; Wed, 12 Mar 2025 23:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWJ-0004hv-ES
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW5-0007py-NP
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so13129375ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837552; x=1742442352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeHYr04W0m2zNJjTvbQgJtgjfEjOKbLo8D+48jtu/vU=;
 b=apgGhxNfz8l0nr98joZ5VjTQT3AouuNHfOdPKCGQEQp0PztX87IDlGUDbUrbkGenCe
 in+XCFdV4bYGkfFnPiplJ9+B2FIx1s5UNQwVhbJMgoGV4AvRIo4oX3gVjufMEPU3v30g
 4LUdlmuYaeVFDMIpvKnT9xfPNfaqEG5v4KgCsJMOo+kHCYfgOv+pGO6d7kT/ijAmkrfo
 G9Ux3vODhWJed2kTMbV5cAA4QU8Ainub+WR1ssWXMdxdXJv9kLr4dmkatJxQlnA+B/NY
 y+2iDz/+WkeCU+DLr/92jL/iy4JNuyxFDZLyioue+wRVKH+q+ye5HFp9TlIE4U0Rudyg
 aUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837552; x=1742442352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeHYr04W0m2zNJjTvbQgJtgjfEjOKbLo8D+48jtu/vU=;
 b=b+T3N/WwFgxc9biiPySWiD6ue8WrvKUdz3GTulWo2h1ysWs3sZwoxGyBEeDYHLet2M
 EsQQClMF28h7M80z5bfbl5s1ZAgYkJooC8iJAOzDcBlE6JI0e6FDAPtbpt9aFTDCSNJy
 8JHNdInHHil1Jy4ppHReM8gk+uaFrXlSzcMWSemJSMGGwOPcuAaAuedBZJBm5LGjuA4h
 witOEWNssXHUbbQiPVz14u4NsMT9X2WYfRMs8YINQTPos5Nft6zgfBqz0Gwvq1yA5H5w
 i6vuGTfzd4aWLr3roF/skTGGZLS+5jY/+2trF4vCMdVD/zISaC0TPd4m+H/8UTTUSGZ7
 aBIQ==
X-Gm-Message-State: AOJu0YxwvBs8tkME0jzep27EznkKbYzpQhf5OaSkYUrPdigHmUehEp0z
 lPhyuPP8itwP6drJNtBsLfNbHHpRt3YUDqlxXLuv0/cYsk5fQju+z1TvZnYNSOotjGfIUPu4aLZ
 y
X-Gm-Gg: ASbGncusUp9LukTEMoLpRjEkkn++xPV+0lV97Z6IqDDh20u7ak6sRq7AfDa++sBpkB5
 xHcFmRe4kj2M22jrBagCtYLY6k5lY0Cp6YNmUufH+bfxhCgAw7s+HautK3MOErFylqtj9thtiVM
 MxQPUyK+bgpJ4YwEJQsIr6xxtmJPtR1BvR5JnfPDVKWeMdFbUwqLLEXkuywIUaBVrCnXcoFe2K2
 F/n+ZUaG4B2d09ZzBUEqS5X/KGQockS1sEjjMtK4WmW8mBU10fL/1ZfwloZYvS4JgjOcp4QZFHD
 kvFd0ttmNaJMTavTYfJb610IcjD63W5p+7GJX8RvdEVvUBmSi3ZTw3mg4SnIt4lYX64+CnArui1
 b
X-Google-Smtp-Source: AGHT+IH6KzYNJgqrsntWeMdEJX1DYVpdy8lU6buYMBc6gn2XxSDo9sKCkeDP1f2clV0x1CWNQgqcoQ==
X-Received: by 2002:a05:6a20:160c:b0:1f5:8c86:5e2f with SMTP id
 adf61e73a8af0-1f58c8660a5mr17897201637.37.1741837552327; 
 Wed, 12 Mar 2025 20:45:52 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 32/37] include/hw/intc: Remove ifndef CONFIG_USER_ONLY from
 armv7m_nvic.h
Date: Wed, 12 Mar 2025 20:45:12 -0700
Message-ID: <20250313034524.3069690-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


