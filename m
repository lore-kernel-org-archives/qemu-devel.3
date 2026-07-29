Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837EBC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 19:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp9mI-00056j-No; Wed, 29 Jul 2026 15:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wp9mG-00056W-75
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:17:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wp9mE-0005OC-Qs
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:17:15 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so1502150b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785352632; x=1785957432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aZkBkOQjOM1X/AWeGppY99mxTnO3tZqFw3DKs+FRBlc=;
 b=J7bM+Yc1ZPHnTtOzIS9vnLT6NC33Nijbk/5jQhhVQWfMWjH0mrceYTgOHzB2SpNIzy
 4vA4MC8ZL69DbV+VWKvSd4YzNdvTsmf/2GyEGogG9ktQR/ouWlqt5vZuSmsAOextKLRS
 4+GQESyV9EziSBOlGG8qMNsz2zny6XDpOKhwcqLFAvA3iF3HgFMYfHGVHyy3e3SspynM
 LqiXaAKs+XITbx9Ek9bqSmX6b9PrZHVC/O5i72fuZZpu//w7+M0l54/5WKFxjG4sC5er
 /0RDPuHunqKdSFZqADyMN7Jtwjas3HSsoXE9rbXe2/lM8W9a1yT9HqiZqZvb7/8OR2AD
 9mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785352632; x=1785957432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aZkBkOQjOM1X/AWeGppY99mxTnO3tZqFw3DKs+FRBlc=;
 b=oCtqSnwv3Z+hYayWyKoe8JoxRSVN6LDsw8XQtYe3xecAFgl+GVcu8AXpNgRr/uWd/V
 CY+pj4sckEHVkG6+X1vZAIwmmIWQGeZYBst3qDalAh5y8/qvMx1Af6t4j08hU8n5lHMH
 3Mujq5jmiOHOA5Mjp+vP1LMnx3zwD5Dupeoqmt0Vo6zKcuZxKFLr1cZWLVHgdvRiYqhf
 YTPPin9T4KNdeS2raCHUL/xcg2hLgvDurfirbgn9cOECZgCDZX/WWpGLgx6Kmbn5iAEH
 42bWHb2J/OvaN72iXakg/qCdkf56Cr4AALMmoPgSU1bzT7jF9kdmLdj6d7p/jSuhFnDq
 a9Mg==
X-Gm-Message-State: AOJu0YzLXZZlUHuG5+5C5AYasvTZrOnMGkgAAzpwWJJe27BEML+H0tQ1
 qGMsXPfv1G3lK/G6l2QQjXJYos0P44vEfB/7E5Na0X+kOlw/Hk9zUUK6An8tgZCOazLHsQZCCY8
 83Y31
X-Gm-Gg: AR+sD1395metjBJ1+lLcBUbA7Wv5y3Mi+2wyvDT6SzVy+GY7BtIGL2XEraDxrHVBVYj
 meZAHaTfQfwPrEtla9E8llHOxjrZfZjjKy8OjYAiCwcZOaJ866N/iNiqE+PXHT5AxKTzkaXng6k
 rMCFe5TRKaQ202Wzyghzpe8Y1sPSYXhiPKhKlcnLKkpCiHBeF4uYpFQaaRYaWN3RGhSP1BUIYsS
 FobnsQke1O/J7k/1JCxSwu7vI5tgpCtgU3lC8Cn6OWJJ05h6hLv+d/3VrYhrCxNKUsC4jBiYnKu
 iAQeefqhiry46BaB+5FMzfBwHE+oOM7GxrcSBmN2tchBJTUevEHGs3XRZ/qcUDqCY+g8CUGa2/8
 vs3zSEYpJJTVPEGWKOe25edyeWgTMjHjUs8WI5W1YgvlpKVzVIR11YRHE56PMc+tdhBRcHmPquO
 ItwNPtzjy9UdMgiNtidKN9Ig1M/e3GKF8FxBGPsFGhOhWtZ6d4jqbBeq+2xtUP++51C4mjpCjT+
 d4FHU3zp2uT2s7sgm0scRzBlQLFurk=
X-Received: by 2002:a05:6a00:94e3:b0:845:bcf0:118 with SMTP id
 d2e1a72fcca58-84eba1b2e9cmr26245b3a.41.1785352632436; 
 Wed, 29 Jul 2026 12:17:12 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a99a7dsm1290390a12.5.2026.07.29.12.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 12:17:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 qemu-stable@nongnu.org
Subject: [PATCH for-11.1] linux-user/aarch64: Fix SHADOW_STACK_SET_TOKEN
Date: Wed, 29 Jul 2026 12:17:10 -0700
Message-ID: <20260729191711.71217-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The token is not computed via TARGET_PAGE_SIZE, but via a fixed 12-bit field.

Cc: qemu-stable@nongnu.org
Fixes: ad1afe433fa ("linux-user/aarch64: Implement map_shadow_stack syscall")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4106
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 740142825d..097d886b06 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6906,7 +6906,8 @@ static abi_long do_map_shadow_stack(CPUArchState *env, abi_ulong addr,
                 /* Leave an extra empty frame at top-of-stack. */
                 cap_ptr -= 8;
             }
-            cap_val = (cap_ptr & TARGET_PAGE_MASK) | 1;
+            /* Note the 12 bit field is unaffected by current page size. */
+            cap_val = deposit64(cap_ptr, 0, 12, 1);
             if (put_user_u64(cap_val, cap_ptr)) {
                 /* Allocation succeeded above. */
                 g_assert_not_reached();
-- 
2.43.0


