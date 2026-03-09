Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC25FCA199
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziex-0003Ap-QI; Mon, 09 Mar 2026 18:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzien-000343-2B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:57 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziek-0004Yk-6A
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:56 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7987531082aso118073847b3.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093653; x=1773698453; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jcqshWK0PF72SFSXYPEg36r5bTJvD4+18bCR7YlbW8c=;
 b=ArlZQQYeXAYZpL3SmDFGDACd9BVV2VrGEKWx2MRNd/BzvkZPAvdngSsBjhO9V3H/ux
 Zf8MBN+EVACO813CJm/E6l5CsCfaPV1OOAa/EZTkPJcElTPMFuIX13B0zbRB/4YeQ0EZ
 0nrku1OjBV3FmcN2FbTA9KEqUTDDN9YarMoJrB9IpLpkegQhl4dB+Rf4tAupCXwotcWD
 1Dx/a3DErmlMBaGCqVmq82LKvtNZPNawaTmIwowznyxS1t99Ac9d0hvCtgxBTCS0zZMZ
 j/6bN5RnwAl2T/UOsVzbzvq7PYXzyZ/BfYhw1vM2Upb3C9DNLMDTYlwe4XtyMaVXj/uK
 31CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093653; x=1773698453;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jcqshWK0PF72SFSXYPEg36r5bTJvD4+18bCR7YlbW8c=;
 b=uK1g7HxPrhs0syvbC4mBpUY5CHm3Etd9vzv7FOgV61ikYhcbokPa5pkTNzsuxb8zYv
 9Jb3+vjuNdXkg1P4aX2icFKTOhqzFvCHIrgaJLszwjtVEgiq6VWZSxFQsMZFzIHRDmHE
 oKdBmiK+J9fW/jEEDGgBmTZKS6k53eXFcJgG6DxepKdRWdMOOYRdsMJ3V6P6JDAsezw+
 D72krnCBjTBVgW0d21r1MjKp25XBzyEzdftwt/lFPmb3pDTt1Spr4dxvMVqm28KNAPac
 Rz7oCBb9HkJl31dFt8baqVDZlCZTUo6Rfugl7gjBqHV3/a5C8P8M/H7S6NIGob/d4mxX
 7sLQ==
X-Gm-Message-State: AOJu0YymQ+VEezWtgOV0CLkVVjFZDjI0Ng/p9fa3VrdpxUQyiqEq22c0
 pkNV/63sc68xJibWjXqYzKYci/Z4EEjzKLqxBLDvUpMBWGVqgtVqEmKi
X-Gm-Gg: ATEYQzwJXnWQOZgu3kvTBFygy+r/qwTJ2kozpVsjEbn0kWzvjJBvJndvTagxbP22XhA
 7OjIMangTGxOsAKM4GM9rXCTj5yQ3w/5NtGkSw3YFlDS57VmcX/McDPLBpAnaiMGbshSYXxZ6sK
 0l9iakrP3h3+Z9C36O2vdoGv6K5v+fu+Jwd5U7e6/1dvTV3R+9K1Hk2V2TEJeZEzM8YhxtE1eR8
 6mykfJmJqygnO052Zf0MwuOH1iXVpMZkUQP6L6akuA8+Uq4o1yCfYE2cJZTLunuXpnHXEwEbMXv
 tMFvIv1RAe62CPNmxkhkNX4VNRJiHueiqijnYcBlwQpfhAgFn0/4Ztw0kw2FBhBF/PvR0OfP4ns
 SsfFiUTOu6Xuqj78k3e8zsKiuosz1TlYhezJySUKin3c8K12JlnRcH4jTfYdblHa+rxXwIKLnOY
 WBCzy/dpzSKtdMJ0ch5qFk/7HLdTEM1zyeDVI=
X-Received: by 2002:a05:690c:6e83:b0:796:6df5:4840 with SMTP id
 00721157ae682-798dd7aa08cmr118886057b3.59.1773093652734; 
 Mon, 09 Mar 2026 15:00:52 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:52 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:42 -0400
Subject: [PATCH v4 10/13] target/arm: with MTX, tag is not a part of PAuth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-10-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=2858;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=+dUMv/5Rue52GZFtWN1V4EyVvStVLMNVxeKC+0+OyjY=;
 b=zkMRguuEE/vuWFYkp8xiTmRtRqKhMNBRH/yEUpWpKMSvy9ymScZnmMMaxkLQHPTlbzlgHxlzx
 Ljpbo4K+N44AnTwc9/GTZxjyCHX4QKqXfIsQYM3OrffLmyZ+8vJ4Ult
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

As described in the section on MTX, tag bits should not be used to store
or compute the PAC when MTX is set. See also Authenticate(),
InsertPAC(), and Strip().

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/internals.h        |  5 ++++-
 target/arm/tcg/pauth_helper.c | 14 +++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2c4369cc16..71d8b419e2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1820,7 +1820,10 @@ static inline uint64_t pauth_ptr_mask(ARMVAParameters param)
     int bot_pac_bit = 64 - param.tsz;
     int top_pac_bit = 64 - 8 * param.tbi;
 
-    return MAKE_64BIT_MASK(bot_pac_bit, top_pac_bit - bot_pac_bit);
+    uint64_t mask = MAKE_64BIT_MASK(bot_pac_bit, top_pac_bit - bot_pac_bit);
+
+    /* If mtx is enabled, second nibble is not part of PAC */
+    return mask & ~(-(uint64_t)param.mtx & MAKE_64BIT_MASK(56, 4));
 }
 
 /* Add the cpreg definitions for debug related system registers */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 67c0d59d9e..08dd230614 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -342,9 +342,12 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     }
 
     /* Build a pointer with known good extension bits.  */
-    top_bit = 64 - 8 * param.tbi;
+    top_bit = 64 - 8 * (param.tbi || param.mtx);
     bot_bit = 64 - param.tsz;
     ext_ptr = deposit64(ptr, bot_bit, top_bit - bot_bit, ext);
+    if (param.mtx && !param.tbi) {
+        ext_ptr = deposit64(ext_ptr, 60, 4, ext);
+    }
 
     pac = pauth_computepac(env, ext_ptr, modifier, *key);
 
@@ -377,6 +380,11 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     if (param.tbi) {
         ptr &= ~MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1);
         pac &= MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
+    } else if (param.mtx) {
+        ptr &= ~(MAKE_64BIT_MASK(60, 4)
+                | MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1));
+        pac &= MAKE_64BIT_MASK(60, 4)
+            | MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
     } else {
         ptr &= MAKE_64BIT_MASK(0, bot_bit);
         pac &= ~(MAKE_64BIT_MASK(55, 1) | MAKE_64BIT_MASK(0, bot_bit));
@@ -424,6 +432,10 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     cmp_mask = MAKE_64BIT_MASK(bot_bit, top_bit - bot_bit);
     cmp_mask &= ~MAKE_64BIT_MASK(55, 1);
 
+    if (param.mtx) {
+        cmp_mask &= ~MAKE_64BIT_MASK(56, 4);
+    }
+
     if (pauth_feature >= PauthFeat_2) {
         ARMPauthFeature fault_feature =
             is_combined ? PauthFeat_FPACCOMBINED : PauthFeat_FPAC;

-- 
2.52.0


