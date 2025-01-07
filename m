Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DFDE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XS-0000VU-HR; Tue, 07 Jan 2025 03:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wo-0000E2-Ck
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:32 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wm-0002uS-Cw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:29 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216395e151bso161392385ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236887; x=1736841687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Va9p08X93j/jzeWcLncWLYR0nY5/Q2/Ig5KLzRua/5s=;
 b=kweRXHyDZWRrc1GfQUud3Ig0aeQlT4dIQgNLPMhffNFyasrLjqR0o86mj9++l6bgpk
 42gcRMGghHw4agTXd2I29ErxQo8jIq0sg5JgmaerpSIk3wR/qZUNHMGOGJxLoW8A02Tj
 +3j0vnRLza/iSIzzh1UiKJrX4E48m7dDNd+4bpbsrqC7QS38J5yApz4Iv6DUjngs7ao1
 SaQOH5MoF8xNDcKaykX8yrPFmFF3fsBgs36K09mXpR7Jd0CzifhWDebBrpjvVl7gavqF
 NkP2qT99s3E+ZSLjrNdEJ+uEyljo660MifV5St5VtTn78NF1seYsh2KknQCcXLbEXjKh
 Uu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236887; x=1736841687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Va9p08X93j/jzeWcLncWLYR0nY5/Q2/Ig5KLzRua/5s=;
 b=TIeeUbqZY6VCdsqNXe2NUnWORLAOpOsx5yuFL1rG2jvQKE8LHoJzUi7DCtSWq9H84r
 LfJaItHxmlX10MWuiQ0w4rMQC2W0MVr+cpHC+V6a8Isb1eWMs1tSyXkzGX76LdUU6Oi0
 gBNSQGDxqCYJI5I/lJNeBZf9S815zFTBXWXvmelAhca1j49y8LI3Q4z9v0IOH7FTWdUr
 S7ajIaBY8m0Y92rCztqDiY588RtS8BvGeHV8VLUWQro1p9JJ9KJYwfn/tLgBTG1c0OxN
 tSVWsY+d/H/KLZv7vAXPM68ZN94o+hHzPYz5D2KKBlRN30xqYZRaCXfUaHmuJq+ErxvM
 2d1Q==
X-Gm-Message-State: AOJu0YxtwvZmrqv0WkQxyqV7eigQ6deNoH5TceJCehH2HPuwj4D3rXlk
 f4GgxwkQHJvgwCbwndyOQNbO6qC6QNvdOzFZkuDYknJobbMMfvxyZGWhr4FhoeMP+ND5swbgn3y
 p
X-Gm-Gg: ASbGnctBSw/s6i/kdAwEsUfGHkMkA7Nxlang8+yug+CF4MHO0LWQKVMPn6ttLZwBgSu
 2TXxTAYkgqv/qDIU2ono3Rk/nzdBL4WY8FWmF3yLnREsv1iNmaG1kpvTIR02uO1KzppCA1Mhn2r
 nKrApuqO7KyrFNw03i1XT6kFPD118Cuu2n9cctBh+eukJp7u5vC8p2m34dpxxS+ET2ti2sLiDki
 dfV8HuL4tTT4GU9bD5ru6pd52uy6VN6RqHOITvYPS3e7qcwRly4V1c6Mvb+3Zspr1qj7/3NSMHN
 rWg38WGOmruxbsDHCg==
X-Google-Smtp-Source: AGHT+IEec4J2eznnnC2FAYCOgggCxFbkfPFDKd2H2me7rMRHI9DtFgRcQW/+sspKhYr7evylB7viGw==
X-Received: by 2002:a17:903:32c9:b0:215:7287:67bb with SMTP id
 d9443c01a7336-21a7a0dc406mr33571705ad.0.1736236886964; 
 Tue, 07 Jan 2025 00:01:26 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 12/81] target/i386: Use tcg_op_deposit_valid
Date: Tue,  7 Jan 2025 00:00:03 -0800
Message-ID: <20250107080112.1175095-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Avoid direct usage of TCG_TARGET_deposit_*_valid.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ab416627b7..a2b940a5c3 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -25,10 +25,8 @@
  */
 #ifdef TARGET_X86_64
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
-#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i64_valid
 #else
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
-#define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i32_valid
 #endif
 
 #define MMX_OFFSET(reg)                        \
@@ -3449,7 +3447,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     }
 
     /* Compute high part, including incoming carry.  */
-    if (!have_1bit_cin || TCG_TARGET_deposit_tl_valid(1, TARGET_LONG_BITS - 1)) {
+    if (!have_1bit_cin || tcg_op_deposit_valid(TCG_TYPE_TL, 1, TARGET_LONG_BITS - 1)) {
         /* high = (T0 << 1) | cin */
         TCGv cin = have_1bit_cin ? decode->cc_dst : decode->cc_src;
         tcg_gen_deposit_tl(high, cin, s->T0, 1, TARGET_LONG_BITS - 1);
@@ -3501,7 +3499,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     }
 
     /* Save incoming carry into high, it will be shifted later.  */
-    if (!have_1bit_cin || TCG_TARGET_deposit_tl_valid(1, TARGET_LONG_BITS - 1)) {
+    if (!have_1bit_cin || tcg_op_deposit_valid(TCG_TYPE_TL, 1, TARGET_LONG_BITS - 1)) {
         TCGv cin = have_1bit_cin ? decode->cc_dst : decode->cc_src;
         tcg_gen_deposit_tl(high, cin, s->T0, 1, TARGET_LONG_BITS - 1);
     } else {
-- 
2.43.0


