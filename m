Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB27BF3D31C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBOU-00023I-Hl; Thu, 05 Mar 2026 11:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBOS-00022P-W7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:17:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBOQ-00059D-QN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:17:44 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837907f535so75067915e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772727461; x=1773332261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p7RfNbSdfMIWpxffbyH0IKOlA2Ngsaa3/wQSvuf1j2E=;
 b=OVQIJIpmV+IbGvtN4n54oQXJ2QxTa4UoPs47IjgoGycoWylyQrMu8Rtc2d/32DAX0S
 Vf/QknlaDuAkZfSigBh4DxwWGKuwUhktjA6ieiuXDaPZ/JnVRo5+tUIJqNooNlnccwr9
 MN2cr6J+j0AqO0CoOB+Wnn4+KSzdqljVLvihsOCPZeOCfTo5BL9nq2EpgHMq4WL3zgs6
 RlErp0Qwjv+JaRZL+vyBM6gURAd///di9ld1yrX/ozfaefDQMpjFVgKB4jEPPRsl11tw
 Zx5ehX3zaOMo60MU4EyQ9mXB50ikvNa+jDAuFgmE+mGPzOgHQdsJTJMl1PUL8QbZfU+i
 VVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727461; x=1773332261;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7RfNbSdfMIWpxffbyH0IKOlA2Ngsaa3/wQSvuf1j2E=;
 b=cT6Mq38LeHNJYe4EWvk9BTAAl2knZeCVTJNdGsUPth6aDrKUVQ88VpDI9gUu1NHKtg
 gNnrRjxlfZ9f0Axz4nVhsvIpRM25dSFk4Eu6HjA0ubr4caYSPg39Mvu58GHNAzGoxDjN
 fkv6Bo5laABBiAxj7uZV1t897OSbYy5V4y0TcWvG1dSa1MWO9DG8oYo9oe/GEEjlb6kr
 HnsOeuo2eiq0PnF4AaoYR2oin+2WYZl17gsuaqN8C9EYWx4B++bgbRQv/WnyLSjvozpD
 9gIeR8FoDYE9nPSAGBZesUfrFM1/up2g6bn478h14lrHC3NYGbJCma9H6nIbcbutJTro
 YHTA==
X-Gm-Message-State: AOJu0Yy5dRqxwMgOhP/IXla9XcDJytOm989pSBpZDbqxp4u+B+tZ6ypG
 GaLQkG3QfTXRipGGaenrIOJ8N2GbO2dtoLfy3hibkto5YOEHW7Hw6CDVgk3sSKrcQL7oV5TkM95
 siJ4Y
X-Gm-Gg: ATEYQzx5qwn3Ix5nMrE6pJb+hZ+jDwS/WRuT46YEkj4E82aMvo4VkBAY0z5fcKKX2E9
 t9P7FA0aUQYH3sW9jQNzZ1p+pmsCJ08dY22RHOoHjbbv70wFnX6/Oq4rwEjW7/9a8EWPE6DkS5t
 9n7tMv8gDUP1WM3AUY93XCJjBSeg9loqTdW4f31hnGVnqFcjFlhqCBt5TzadPwJIupknHEZstfn
 /85n7s2y/Wa73VnexvL497CwKzO5KmWsowrtyzecLqGdslOGZWCUO5WBBTx5jrFrXVH2JvqUk3j
 LaCRkIdq5EPgwfqLhJaAMN6AqKeeoE1Em/WH68ExM2Zl7fmHSP1D6aQY8Z36mRVUnX5Na143Sjb
 bx5PX69/Z9ZVojubN0D0Kj7SnBG7cfmr3/11bQ2+LopUHa7tCReHQ/vq0lnxgduiHZCTlb0JHkS
 uNiGpEKqj3J13THRadk1mjVJWy5D/Ovfkt88FjZsCIvkm2yTJtBJwEFgtvsjArHgzfLgk3+iP/9
 7vL/NyjatjbYCybXT9ZXxBpn+a0dd4=
X-Received: by 2002:a05:600c:6389:b0:480:4b5d:9ec with SMTP id
 5b1f17b1804b1-485198a3c2cmr103890965e9.33.1772727461103; 
 Thu, 05 Mar 2026 08:17:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa85ad7sm59592155e9.0.2026.03.05.08.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 08:17:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] linux-user/i386/signal.c: Correct definition of
 target_fpstate_32
Date: Thu,  5 Mar 2026 16:17:39 +0000
Message-ID: <20260305161739.1775232-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Our definition of the target_fpstate_32 struct doesn't match the
kernel's version.  We only use this struct definition in the
definition of 'struct sigframe', where it is used in a field that is
present only for legacy reasons to retain the offset of the following
'extramask' field.  So really all that matters is its length, and we
do get that right; but our previous definition using
X86LegacySaveArea implicitly added an extra alignment constraint
(because X86LegacySaveArea is tagged as 16-aligned) which the real
target_fpstate_32 does not have.  Because we allocate and use a
'struct sigframe' on the guest's stack with the guest's alignment
requirements, this resulted in the undefined-behaviour sanitizer
complaining during 'make check-tcg' for i386-linux-user:

../../linux-user/i386/signal.c:471:35: runtime error: member access within misaligned address 0x1000c07f75ec for type 'struct sigframe', which requires 16 byte alignment
0x1000c07f75ec: note: pointer points here
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^

../../linux-user/i386/signal.c:808:5: runtime error: member access within misaligned address 0x1000c07f75f4 for type 'struct target_sigcontext_32', which requires 8 byte alignment
0x1000c07f75f4: note: pointer points here
  0a 00 00 00 33 00 00 00  00 00 00 00 2b 00 00 00  2b 00 00 00 40 05 80 40  f4 7f 10 08 58 05 80 40
              ^

and various similar errors.

Replace the use of X86LegacyXSaveArea with a set of fields that match
the kernel _fpstate_32 struct, and assert that the length is correct.
We could equally have used
   uint8_t legacy_area[512];
but following the kernel is probably less confusing overall.

Since in target/i386/cpu.h we assert that X86LegacySaveArea is 512
bytes, and in linux-user/i386/signal.c we assert that
target_fregs_state is (32 + 80) bytes, the new assertion confirms
that we didn't change the size of target_fpstate_32 here, only its
alignment requirements.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/i386/signal.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 0f11dba831..b646fde431 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -60,10 +60,33 @@ struct target_fpx_sw_bytes {
 };
 QEMU_BUILD_BUG_ON(sizeof(struct target_fpx_sw_bytes) != 12*4);
 
+struct fpxreg {
+    uint16_t significand[4];
+    uint16_t exponent;
+    uint16_t padding[3];
+};
+
+struct xmmreg {
+    uint32_t element[4];
+};
+
+/*
+ * This corresponds to the kernel's _fpstate_32. Since we
+ * only use it for the fpstate_unused padding section in
+ * the target sigcontext, it doesn't actually matter what fields
+ * we define here as long as we get the size right.
+ */
 struct target_fpstate_32 {
     struct target_fregs_state fpstate;
-    X86LegacyXSaveArea fxstate;
+    uint32_t fxsr_env[6];
+    uint32_t mxcsr;
+    uint32_t reserved;
+    struct fpxreg fxsr_st[8];
+    struct xmmreg xmm[8];
+    uint32_t padding1[44];
+    uint32_t padding2[12]; /* aka sw_reserved */
 };
+QEMU_BUILD_BUG_ON(sizeof(struct target_fpstate_32) != 32 + 80 + 512);
 
 struct target_sigcontext_32 {
     uint16_t gs, __gsh;
-- 
2.43.0


