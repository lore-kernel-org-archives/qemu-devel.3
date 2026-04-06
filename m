Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5118CF46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVj-00035e-Vl; Mon, 06 Apr 2026 11:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVi-000351-OP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVg-00044T-V3
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so36206485ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487903; x=1776092703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EreTPxkuDGzkWgW1EVVjJMJZdSsPzYH3Oe6Wk0cickk=;
 b=BCP3kxIiU6W736+MA8zNbr7j4ojTRZWi3epnxOV4ULJAyJd/8iO9OJHJ7RhkMSsIlt
 jeApgNsaHXtoLSys/sWmAg59/dkmXkk77AJknHjT5gyw7dxCl3DJH+1nhqo9mhxTcG9h
 bv49E2Z5uRs0j4dzzbHlWJDTnCnVnUwBLe7r90pWDpyjp6ZArBgaYnn9KlI/49UvRr/S
 ztwc6UGY7a6Av/4/ijJ+9NPzONVGTpCi/WSMYZ23JInLazxzHGdSuFXzW6PNGqT3CGdg
 1A7UfvURN9HQKoe6+syDuB3VPWaV4b/KiR1SOGNPLOGZ38u+Qs1zFsnZHMgGx9N11x07
 uLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487903; x=1776092703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EreTPxkuDGzkWgW1EVVjJMJZdSsPzYH3Oe6Wk0cickk=;
 b=SbyqU2GnX/GnCk/K1bJ+YUzJoIdoiPFpT1RiJg7in4l/Y3kgV6deuzYl2j+Zn0FoUp
 N4T2rxRfmvIbW8ZzZYoy2DmoI7A4nRu1Dn1qN2XRIoM9ja3UH/eJB7vJ2ZtrJhbMjSjH
 UwSVHSFbebA6jQLqYqpzbhbSvCqrOPadAVwoI1PNh24YVx6+F8GnGkrJCJB4RSEkL8JA
 dZwruf5+3EO5p4eHw+qRzp89t5deAecR7H+vEGkdOCC4f6vIHDC8XGmxOYOhzcb45kIs
 iVEUnx6mpZ3eQA8bmuQHErNCzw7waqu3E2ZQdNIgdHGmNgwkbkGmgxUg5us4BR8gPFnQ
 HomQ==
X-Gm-Message-State: AOJu0Yzu0zFgoarEAnxh2WgghCsoB5Inesc7WaDBMNKmzdJTciei65Q3
 R4SiQ3MTh2QwoQUf/hj8awP/Xv3YEvcaws/D5aoCe5Saed/SK0NdnzWh/P5QeeRPW/95Xmarrnq
 /9yWbuGTfDg==
X-Gm-Gg: AeBDiesjxv9OKpXYFRZJsBItUJbThzFesxJaSNoSfADQq4b6brlmUaKFbe8iS7ICjzJ
 LnndDMA2krsC3r9n5uW+5y+RpnfMzGkSHKHvEmCdwz0VwP1zH6re1w9hIPxPnL1jABRZ2iYia7E
 N1Z/aFCdP4XzQJrF9NhtVG9FVMnQWc4OTzHii6uZNkpRD/YxbK8MoXSc+DWZC8osxovi/565F63
 Xe/jklu+8o1wejZu6nTCZrk+XE4Es9YWzmZGxLDU+Mbz3LlJFt0HPAz98UPLbTsD0wRrRuiWWqC
 brFpHYmh/1XWiSBj73xvoyX63SPxfwU90NF615n8rqPSt0hngCev7uJa0a/p78rvMpm33m9X2rg
 +Jw8khXPOVdrANsbjU8WxpXvFpmuq2JwJFrYb84xgmvIS02mSAr4cQIojcxsVRC33XgFW7nJUVa
 zZkr76i/nrxE+kuqLbsQv7fXxkobfReJtkiFmNjMKBgVilsPBiSjheIgzNpHtvFuhoDFcNJSKS0
 ZbB
X-Received: by 2002:a17:903:2b0d:b0:2b0:5923:5194 with SMTP id
 d9443c01a7336-2b2817991a3mr138358225ad.27.1775487901927; 
 Mon, 06 Apr 2026 08:05:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:05:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 08/14] target/arm/tcg/translate-m-nocp.c: make compilation
 unit common
Date: Mon,  6 Apr 2026 08:04:28 -0700
Message-ID: <20260406150434.407201-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/tcg/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 89c3b476822..70beec7a6c9 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -18,8 +18,9 @@ neon_d = [
 
 mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
 
+m_nocp_d = decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp')
+
 gen_a32 = [
-  decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
@@ -34,7 +35,6 @@ arm_ss.add(files(
   'cpu32.c',
   'gengvec.c',
   'translate.c',
-  'translate-m-nocp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -65,6 +65,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  m_nocp_d,
   mve_d,
   neon_d,
   vfp_d,
@@ -76,6 +77,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
@@ -83,6 +85,7 @@ arm_common_system_ss.add(
   'vfp_helper.c',
 ))
 arm_user_ss.add(
+  m_nocp_d,
   mve_d,
   neon_d,
   vfp_d,
@@ -91,6 +94,7 @@ arm_user_ss.add(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-- 
2.47.3


