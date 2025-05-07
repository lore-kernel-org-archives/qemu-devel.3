Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF37EC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ1-0000Ql-Fq; Wed, 07 May 2025 19:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPj-0008NC-Jh
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:59 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPh-0002Ut-Nc
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22c3407a87aso5734065ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661376; x=1747266176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylmW/mRzMuupLX6PASMDyZOaBb+Dv5gnstRJQXcdzYM=;
 b=Ds9iWIcAvkQ4PcpkKJV7V2gvmTL1UcCET5BoYjmfR31CqIJauNvwshxC3pyqJUDwwV
 lzx1988E4ar/xdvlN9h4AJuhJOvJb5hVBtAik4Y8gr1Psep9At+ZmbBSMsWITJzzckqw
 z5fiSu353Nb903hO4qRNufPlQhTbp6q2NHAoJwnioIV23K5MfBwEoiG8LHG+qJCxTQHz
 +LUIiFdp3XhGTF1G9t7rB0AaB1kl71iooddmN/OLtL+ynqBdxiDQ9yr+dyLNTRapAzeB
 8fPl6ylXNSPPG8o9x4WXaUAdSuGhgydEhXnoivxn8gBwpq3+k5pKRFDC8ZfVjMEXkX4i
 z3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661376; x=1747266176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylmW/mRzMuupLX6PASMDyZOaBb+Dv5gnstRJQXcdzYM=;
 b=JrR+VNd4bxD6ifUbZNGLy7o8cbtC06IxtvCkHiBPk7pavcJketO6f/GeFYsH2J/ZN2
 pqCW0lJg3eh53B19HXxCnijHWbLzkbnjJmPtMd7MlId4aXZfq/kxXavdZFSvDM20MTAB
 JO0g1rk2iCVQHr2dC1FmAfFJ5bgu3M3FaYSTNQVbmR/VwUWEaUKUb7ZyjOyioNvmaYCW
 Ag5KacDytLPgBE3qTXQPboxAwPMjCHBsZaBPb4N7yKIsn37w5wMcDqShEYzlR5KgQdro
 73fMWuKo5kPciue0AZZMEO1nH6CO9NhjG58FFMrApaXrdbfJltm17DGj1L487S2dN9lm
 wwjg==
X-Gm-Message-State: AOJu0Yx5WMqBGWddPX+TRDJxUE8/ge9bkK1dmRBc77uruPlu0t2YapsR
 QlN2ZbtS0YfLwSYPmwmaPBRj7qBYnn++gNqSJoKQwaXfsAAwoYGmQOvVQXlbVGY328ll4z+AuuZ
 J7cGofA==
X-Gm-Gg: ASbGncsr825Gw4HVjkiyFy1td8QLPI40LrrscakdGNauzbQcaPN3mZuaJ62ukM4AU7z
 WP/YeoYbip70bz5cP+p3pldEqEodfflHD0LDHTBNAWH34qJ5QNV7wj0HProma/6s4T429yr6Hpg
 u9g4d97ElyrzhirZBcdrn+DYH8/rTpIwkWyWkC4mITlsPQ38XoAVFy83C+IOqDohcuLbRWu1xia
 IdmsUUCSvLmHGI4jevztQWZ6GlR4my47GvE6tXVmZhaJTZETyef/Yoi/XSEsG7pTKF0L7sjFjEc
 P3c9Na6zqxCaqxdk6GFrqgOGulxUwHqqsnDLh9dm
X-Google-Smtp-Source: AGHT+IEpWx9aGe5EwvwUP443E+5HNMG+cmlLCI/w0wtSLqbMMqVFdYEOw13y2ya2bBtZ4ZjIU1REbw==
X-Received: by 2002:a17:902:d487:b0:220:c813:dfcc with SMTP id
 d9443c01a7336-22e8e24a912mr20255915ad.40.1746661376490; 
 Wed, 07 May 2025 16:42:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 15/49] target/arm/helper: use vaddr instead of target_ulong
 for probe_access
Date: Wed,  7 May 2025 16:42:06 -0700
Message-ID: <20250507234241.957746-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h        | 2 +-
 target/arm/tcg/op_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 95b9211c6f4..0a4fc90fa8b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -104,7 +104,7 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
-DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, vaddr, i32, i32, i32)
 
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index dc3f83c37dc..575e566280b 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1222,7 +1222,7 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
     }
 }
 
-void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+void HELPER(probe_access)(CPUARMState *env, vaddr ptr,
                           uint32_t access_type, uint32_t mmu_idx,
                           uint32_t size)
 {
-- 
2.47.2


