Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C600D232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56r-0004jT-8Y; Fri, 09 Jan 2026 00:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56o-0004cV-II
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:26 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56n-0003kQ-5v
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:26 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso29599955ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936744; x=1768541544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9IvykFQhZVcNN3polmu+It8RjzUCm16B/WGnBoUEwQ=;
 b=syjc48J70ZBURK1s+JWewT+f5w8d1a3q1W0+S7haLdNvkYGahtCbezarrx2+6De46N
 GaoQsiyPKBPIST4MG4JJF8VYB8eEEMmEldnmNtki8YBUvJPzmTpVXGx38yG+oeClsgUr
 vZqMDT8v1Rw2Fa/w+I7jSEHxhHysVmk5cJPOsZkiKMRK78CPMfDx1M01/R+dtIeUD1nH
 Xa9D32r8rtZFwbj2rOPz/vmjD6pnp5sDAR9Z7TT3Ll+PAO42nIbY8D1nEq0sgG7lcX3/
 /Un87A1Hofyvzp63jzinZ/Ss75TEPdxzwHfAMqKIsyJYBeP8Prb3UFO/KgmWXaykf6UJ
 ymgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936744; x=1768541544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g9IvykFQhZVcNN3polmu+It8RjzUCm16B/WGnBoUEwQ=;
 b=L3kRh8cef/4PvDE1QOv17v8LaxezmoiEI3O1KisIFXcdWZPcFdrpPw1KPjQLJUsgk+
 d1S9LpJI3BIvtVh8gguoo2kygAtPLdBi1p6OBcJdBWYxkpIUCEga/GTwbM+J+DO4kpLn
 hTd+QdQovoPgwWmr5tbxaeWf6aXpm6bkNOQjuJDtPk5YnR+FfOZn2UDnUA8gRcbK14gH
 Ma+mJvx1laQW9tVqKLChKJeXXHaBIo2TTXe91hGYt39qTrpwkaX2OgOAlvsKPtcDJLd+
 Nz2HMMuDnW1TT5+L270hN58SPdn/kt46vxMs3meOddp8nCs5j9kqxXmuzS7Kwi7QTjVz
 /gvQ==
X-Gm-Message-State: AOJu0YxI5zrb/R7PA9gWq47mQUEYn2IYJyESLHLalLGMCEnwFY4jfU5J
 V0bUBy2N4EHDqlbGSgBFZRljcueXUYQhLD7isaYDOGr/j7YCX5FymwFu9oq8fQwjw/mwfxwfIvf
 9q/i/
X-Gm-Gg: AY/fxX4e5Chl4DR5tucMoWUcCpF8gD86Zu2z2nUYoSuCE+vssTtnE+ixsYLMAPN0MEe
 OSCRMVQXkObQAxihQQudo/bQ5D616sTkPPPQ5YgadTUXUX7UzOqyb/rZSlo8YLqtAWp6K5pXDpL
 oezLt+yJm1CP8pP3uTkqgdDLXS/4y+S0V9EHnTjv0xR59OfGQAm1TQYdZQFtdbwaFmR9YzJM3xT
 q5UTl3cJWhJCnknKvvvzeznWM7z9HnaucIwSVmmwSCat53yN51V+blmCQu1AsMs0yhH9UEngEfu
 cjkfP3NZQd1Z8rHLOmatMwKelZ7J+V1igEC9EK3FstlQEIMBp7OimJZFohmyoPIP29ipSE80n2e
 Hv2ZaYmmSMqMrIEd5isVBI6qmWYETas4LQeFHAYOn3mZp/CWDF27zRckyNNDFUwpYJHpVIcu6Ad
 +PD25uV3u8vTo1fmZPmknDz7fTZtgbzNSRtJu8kFjb3vmTtyVJG1eLiAVSuH4zon8h
X-Google-Smtp-Source: AGHT+IFIUhRTnx/ho0RqJne2TPJQDQ2Om/iNzzFwcXeuLv3NtUmSoA69La428ugIkIb0mBE3bv+N9A==
X-Received: by 2002:a17:903:13c6:b0:2a3:bf5f:936b with SMTP id
 d9443c01a7336-2a3ee43639fmr71557355ad.26.1767936743664; 
 Thu, 08 Jan 2026 21:32:23 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:23 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 22/29] target/arm/tcg/gengvec.c: make compilation unit common
Date: Thu,  8 Jan 2026 21:31:51 -0800
Message-ID: <20260109053158.2800705-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/gengvec.c   | 3 ++-
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 01867f8ace3..99bc4e1cfd0 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -20,9 +20,10 @@
  */
 
 #include "qemu/osdep.h"
+
+#define TARGET_ADDRESS_BITS 32
 #include "translate.h"
 
-
 static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
                             uint32_t opr_sz, uint32_t max_sz,
                             gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index d435d2e5b72..a2a636ef14a 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -25,7 +25,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'gengvec.c',
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
@@ -65,6 +64,7 @@ arm_common_system_ss.add(
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
   files(
   'cpregs-at.c',
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
@@ -79,6 +79,7 @@ arm_common_system_ss.add(
   'vfp_helper.c',
 ))
 arm_user_ss.add(files(
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.47.3


