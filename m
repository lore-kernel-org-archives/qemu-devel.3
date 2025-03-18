Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CD5C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOw1-0001Mp-EP; Tue, 18 Mar 2025 00:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvb-0001Em-8c
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvX-0008Tt-5b
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22401f4d35aso96536465ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273501; x=1742878301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zREl7MPAGqYRU9KvXrtENxfPFFrO3Nb7yWvR8XbX8nk=;
 b=NL3seNT7V5hvyXNUkYaEFq3M6ka3mxsrUcXevHdEVC9g6D8Sw4XikeOVhP3vd9jBuE
 oyx3A+sMI63sUktcxyeUvry8SpRYXGvcwjl78tnBIls4ONnYV0G42+0eR7eElArPfCFe
 sFZ95OQNVz/W2n7xQeK3fRlnsNMgfiwYVDHGVXCoyVgy+FrC/tH1rOB/+T9mhp5Zl+fA
 t1/X/JwuQbMof8WcJYEFshi8xScHbHYCUey04DfTvWQ5kZKIr6CluXZ02+fmJ109muBa
 kbP5fCLGYD/VPMtPjB85tHOCp9rzapiJEX24eiRMKF0qm9YlgdmEJ8RDn8QLtdgGrH8r
 sioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273501; x=1742878301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zREl7MPAGqYRU9KvXrtENxfPFFrO3Nb7yWvR8XbX8nk=;
 b=A+BMxnSmTz+DVfggizdCBf3CC9VRc2uupA/TLoTFIf1QpKy3wMvROfOmO3jrIsHFVC
 fx7EN63bohrMrH1AyviBmjspVkwpRBDpFLpG488jbTlbjvvrkrya2imhKy1Xy35U7tKE
 5ufdnSCsqyoZLacsWdEgEhrHkzLN1gegBGSIezjlfNxRkIboJM6RHLRgd6JdBosE5Vr1
 WVgQtaskmEpx2u4BWP8ZdpidLVaqtXMc/YaqVkRz69CTCwPJkSU1w8HTICGSk3U3VhX5
 PJz93nOCbkNh1D+H3zIt80svYXy2hBQiXpXMWqPZiBa+5OEI1BURkdK5gqXpqXkQpwZl
 1bSw==
X-Gm-Message-State: AOJu0YyowWnxpieRZqCkC1tGV7BJAyJbu+bnYZ89w8NFcyczDMAqK1X1
 pyjPrJGRcsp10jLe4CZQHuYA5erqO+DIZ17Y3DZrtvyc8adBmNjfPIpVthAaLR339MIekD82+J4
 w
X-Gm-Gg: ASbGncsNaazo0la9uVFTgwuTVoIbB81xdZchvADaAIyKllTaWQjJ7rAgf9n+IeGEhrR
 Dko0y+H+otWheAEYOzNYu6SVS0zrB3Vhf23AsQl/7/7LAxuZ91+rts7mnL9vM/lFADaxdTPQ1vh
 I/yuXCYONEYlSMv6E3a7HX1cjHqo7DcJfKHn4nTkXQawVnFMOjvijc2yKLsevBMGxjzpkWU8MbY
 GSSafwOLiQznaZlV6rd3eV2yLwjZCMcM1Cr9mx3qmEqnIch/Jz32Av/RETfT7NibbpXqGshFi+I
 8/fpFnAcuk9OA7L2Vx+7y9ssxWaFJRLrTBL9Y0AWwlvMvP1GVgMrSfU=
X-Google-Smtp-Source: AGHT+IFqAyZQRbRYtYEmeMsrs7MIVpz3F5a0071joCl+4E1pyIG8nDoF4tustrp2jVDZXF29mgQhWA==
X-Received: by 2002:a05:6a00:1829:b0:736:a540:c9ad with SMTP id
 d2e1a72fcca58-737572d542bmr3107911b3a.20.1742273500665; 
 Mon, 17 Mar 2025 21:51:40 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/13] target/arm/cpu: flags2 is always uint64_t
Date: Mon, 17 Mar 2025 21:51:20 -0700
Message-Id: <20250318045125.759259-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Do not rely on target dependent type, but use a fixed type instead.
Since the original type is unsigned, it should be safe to extend its
size without any side effect.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h        | 2 +-
 target/arm/tcg/hflags.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 96f7801a239..27a0d4550f2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -194,7 +194,7 @@ typedef struct ARMPACKey {
 /* See the commentary above the TBFLAG field definitions.  */
 typedef struct CPUARMTBFlags {
     uint32_t flags;
-    target_ulong flags2;
+    uint64_t flags2;
 } CPUARMTBFlags;
 
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8d79b8b7ae1..e51d9f7b159 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -506,8 +506,8 @@ void assert_hflags_rebuild_correctly(CPUARMState *env)
 
     if (unlikely(c.flags != r.flags || c.flags2 != r.flags2)) {
         fprintf(stderr, "TCG hflags mismatch "
-                        "(current:(0x%08x,0x" TARGET_FMT_lx ")"
-                        " rebuilt:(0x%08x,0x" TARGET_FMT_lx ")\n",
+                        "(current:(0x%08x,0x%016" PRIx64 ")"
+                        " rebuilt:(0x%08x,0x%016" PRIx64 ")\n",
                 c.flags, c.flags2, r.flags, r.flags2);
         abort();
     }
-- 
2.39.5


