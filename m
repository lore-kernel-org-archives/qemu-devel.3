Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD2AC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pdt-0000lk-8y; Fri, 04 Apr 2025 18:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdi-0000iC-2G
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdg-0007zi-8W
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso12393075e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806149; x=1744410949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIKjbL/Q/KXdvXQSiletYLg6oVeSYWM09NCAwSNeYqY=;
 b=psLiHy6rfNpl6bNdgBs6ZcXVJAnt4AmdbkHxLG3utYw+5oytTHBJKtRaBBFoVJ8DC7
 dqm1ixAK9Q+4wP8D9mnnqaSWrMWlm7tCDsMMknonftGTiTebhvgr6zMl9bs4f6o+j9Lg
 rJrScyAOkIBUajUu1z9Q5kwG72FuBMIIFThVDNxHxO5jr+V2WiU1XrIqsZnHTdk3dD+8
 PPEwUHAmrp0BD5oEzoIL1lpj5vKmLvbbzze6WxszsU2Etcg3VVnNs+omJcFmT4bLUfJb
 whaumcbuX74nPwplrTpnyYALKmqEh4O+YUk5BMAPJ+WB0LjOH5SZKvyp658TCgGu7171
 Qrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806149; x=1744410949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIKjbL/Q/KXdvXQSiletYLg6oVeSYWM09NCAwSNeYqY=;
 b=vjtECBeABYrCNI4yodhcDiAi7MigFLlb1NnO5k1ifLGO9DGcyWd8KpTBnFJE5H/4Gj
 9z2kmTOrGG2P4HD35kQsJMMy7tb0ikwzKz7hMaMuQw67mYz14SUUNmrLu8SkE64mGsth
 9g/uI0jDdSStpLGNyVKjE37dZuz2fJInbPxbuR6cn1gbcgV+4Lczu1E6yQDHukykCAhH
 qCR3Jw9LvXMGaKQzHKqDDGW/1rtAN9unrzU4oS6V1cnA1CWJf9ec6qhBJkbR7qaIcaYT
 9/HpBtNevM7yweWD2HEN9otW42neZUch0BMnz6LoOLKMgQE5WfJcqdwXRTPHI+5O9HZv
 TmBA==
X-Gm-Message-State: AOJu0Yw/GtUkE2CKoWqBf/8GMh/l7/Tj7mgesvHpUI1Hhr1VYox+9mXG
 eKQWKxc8WF6s0ODJ+U6bb0j5XtLcllMNloxUYvGYWui61h4/aq63INvOHcrlxec99WqejY9FkdG
 E
X-Gm-Gg: ASbGnctd8yeVkPw+FTQLBDR4zjx1fzGm7SMWNelbhlTg7MJ9OLt70wvDhfEmhHBQp9I
 IKpOzq6CQVAn3++8+Xv2trFmpYKgtHaW00lLwZxbxoKfC/c2Yi2t5KXwt3PaupQFhAfg4mcOixC
 cBl5prokrSURS3em52TkMSY8UXHuHXSIPkKNVLAygwj/ahupvjseLME1ubQMmg5JU6E1OitXwwL
 tVKxrItOy98jpgJr1+2P/vmdmGwr1YMPuWTDJ/cZi6cSTqcPFpdMFj0WP0E1Xugbxx/F+4AVGti
 CBJyqHcVTqQNF/BM7OmfsvZqq6tSopLSgLaN98ZboNsBUAvEjn3fFHDt19gzQLrAHajUma9uY+A
 oP/HIkiHmCWhCGR+3oAIvgyaoWj5oro22zGI=
X-Google-Smtp-Source: AGHT+IFPlJvU8WnmjqubHKWN7Lh+e2t99UD8VqTnax85RvFEZd3MI9E02BmGLnIEMArSsoBlpJqxlg==
X-Received: by 2002:a05:600c:6c11:b0:43d:10c:2f60 with SMTP id
 5b1f17b1804b1-43edd3bd68bmr12589795e9.24.1743806148873; 
 Fri, 04 Apr 2025 15:35:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec3429f67sm58989755e9.7.2025.04.04.15.35.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:35:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 5/9] target/arm/mte: Reduce
 address_with_allocation_tag() scope
Date: Sat,  5 Apr 2025 00:35:17 +0200
Message-ID: <20250404223521.38781-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404223521.38781-1-philmd@linaro.org>
References: <20250404223521.38781-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

address_with_allocation_tag() is only used in mte_helper.c,
move it there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h      | 5 -----
 target/arm/tcg/mte_helper.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 01408e40a34..0728e5c5348 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1701,11 +1701,6 @@ static inline int allocation_tag_from_addr(uint64_t ptr)
     return extract64(ptr, 56, 4);
 }
 
-static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
-{
-    return deposit64(ptr, 56, 4, rtag);
-}
-
 /* Return true if tbi bits mean that the access is checked.  */
 static inline bool tbi_check(uint32_t desc, int bit55)
 {
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 9dcdc1d91c1..8a6e6e4719d 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -205,6 +205,11 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                     ptr_size, tag_access, false, ra);
 }
 
+static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
+{
+    return deposit64(ptr, 56, 4, rtag);
+}
+
 uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
 {
     uint16_t exclude = extract32(rm | env->cp15.gcr_el1, 0, 16);
-- 
2.47.1


