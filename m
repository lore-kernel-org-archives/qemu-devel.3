Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E72C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxd-0000ke-CB; Sun, 18 Jan 2026 17:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxQ-0000CG-U8
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxP-0001cy-G1
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:16 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso23835235ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774154; x=1769378954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqPM6MHn7AUegnXKkA5IATnkWJcY3AmpmfrRokR9q1Q=;
 b=FWzz5RS/7u0/7SU70Xa5Rc156kh4YUTKkjy5UjUdjn9vAzsiQ/+uY3CM6dbQltTzpa
 gXSOWFuinu3owZCN1EMQJgJJKFPnIDa2eRjhMtpcMGOyPUqxY9o7WiY6/6D5TqWctEnH
 4nVJXTOzHXcxGbCW+hnwijU9uGSDdpKwPyIhR8I2/s3v6fxGPmuBKYABZh3iTCKIWXXp
 Dg5zF/ZuCq6oKnr2GlnhfhaUSixavKYiSIlcVT6fg9yyCCGcFwuBmsjQic5qKOrQvyp5
 kfkojShdX2uSyP6IqElpt/RrojelZWXt6McTLTn8QjbquhL6PFMISoYu7mcTAQPxVfKb
 1ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774154; x=1769378954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nqPM6MHn7AUegnXKkA5IATnkWJcY3AmpmfrRokR9q1Q=;
 b=IJgtoXsbNEYJ2yZNNN53go+3/Bzk5ESBq8hkWkELltvzUsYNy6yYRUyPpDzoFs+f2y
 5EPc3Oj5bbYMb93j0io0PBscBf1HzawrD2m71Z22b+iCyVNrZzQ0MWQzcIjcGwCNAMXe
 9aIkTtoxJAniJgg6lWMjQoXL5dtlt39f5KcWbJlW3sbaSWcOhFNGm3H9NVY7s7cOT1Ua
 jPDD/0iQLw8L9N/kmizGtVHcEluIPBA8iH73oN/wyLnk4CyM7c9u96dcno7rUkH0xjIl
 o3cLRepoU7hjMt0NghxMLLwFnm8WHHlxMqMAuz16L0Rg77QNoq1UpcIjHRmMwl/OcXYs
 S/uQ==
X-Gm-Message-State: AOJu0Yz9aLBBdmuL9Y7t1C76S/FDZRigjay6doLiXdHp4RjBNoy7/fJc
 mRCrbc8JrOQA06gxyCZJ3605wv0PlSHwoHfGnp2J0HKon8mNcTojsjs15ZfX37zfFDWBFDUTpHA
 sxxp/ogPzww==
X-Gm-Gg: AY/fxX47UWexUnoKfOKF8jZxAzp00o5+ypa736/huztkROJbl+gR96JTh7u83tMfDWH
 KyAIOqM2m0L19y7YiL1MjwmgOHsZ+JPHWdY/dJEBFHLQBX8Bg8fkUZu7hx6GcMWT1YwxUsYApgj
 6TuJOI7qYTq5fVY8WC4aX2bc20tpE/Yq8P8XpXDnNO8ADhT5izoTTTX1/VOy7tAtx21sVEMHUma
 lZSE0M+aVtdWiNSjnuYPrGloyfmW6Zg8qtP6/SAGCNv73KL+IywyKObidaed4lpfU/3HQaMW//T
 fCtkzTrTpxd98cMYY7Lwsos2wqmzvB363DhoyCa1hBDNm+cBXnn5YmQNVMzfD0JfwfXc75YF2cQ
 JXeiUsY1XrwHol6Yt6nOeJyt2h5ggT9GMzBWZyEHk6ps5V86PMzeEOUoOXTr8TODY+NrTH/TpQ9
 yr54pkkqVvIcYedC4tDA==
X-Received: by 2002:a17:903:1ae6:b0:2a2:f0cd:4351 with SMTP id
 d9443c01a7336-2a7175c3241mr88324985ad.37.1768774154110; 
 Sun, 18 Jan 2026 14:09:14 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 47/54] target/s390x: Drop CONFIG_ATOMIC64 tests
Date: Mon, 19 Jan 2026 09:04:07 +1100
Message-ID: <20260118220414.8177-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 2972b7ddb9..0b8b6d3bbb 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1815,9 +1815,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
      */
     if (parallel) {
         uint32_t max = 2;
-#ifdef CONFIG_ATOMIC64
         max = 3;
-#endif
         if ((HAVE_CMPXCHG128 ? 0 : fc + 2 > max) ||
             (HAVE_ATOMIC128_RW ? 0 : sc > max)) {
             cpu_loop_exit_atomic(env_cpu(env), ra);
@@ -1856,12 +1854,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
             uint64_t ov;
 
             if (parallel) {
-#ifdef CONFIG_ATOMIC64
                 ov = cpu_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi8, ra);
-#else
-                /* Note that we asserted !parallel above.  */
-                g_assert_not_reached();
-#endif
             } else {
                 ov = cpu_ldq_mmu(env, a1, oi8, ra);
                 cpu_stq_mmu(env, a1, (ov == cv ? nv : ov), oi8, ra);
-- 
2.43.0


