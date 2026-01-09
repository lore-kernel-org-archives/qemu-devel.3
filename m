Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349B7D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFiK-0004YC-MM; Fri, 09 Jan 2026 11:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFht-0004DH-Mo
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFhq-0007LG-8Z
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so47664705e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977480; x=1768582280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DSvYqUFzf57A2yqzQ01udYn/MBLFsOeV1EgtZ7fE08=;
 b=vzvxbN18RLpoTspA4JZnl3ErkGPUjK/sYySDOA5+J+8iVjcCrA/C56UcwFjADi9avW
 HUJwgE4omIGzmtjjjlBmVizfuuwddjJEtf6mr3Yg9bfd9jsjQvMR1xuyaqyVSEPKOZxD
 6VD6QLpjGVPfdTN2yjJZqL2jtMXk+Wn8R1P35M6S4BJbVfKFka+1uq/gezKDNF022ndl
 m7bR/hKke96GJr+gSPZUPMLuPDgK4Lnypj/aQe3bufDzQ2PpFRndEnhEvb3D0FcTniOv
 RvTH0ZChR0erCDixEO9gKXecFOY7cI8cmubcli9sectxwq+1KROXz/mNnCmAyHtB9Uyl
 eSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977480; x=1768582280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4DSvYqUFzf57A2yqzQ01udYn/MBLFsOeV1EgtZ7fE08=;
 b=jI3HOvkFBz5RjffkF2hhM9pSPVK7imorkMMg5MH5Mb3BIpjExe6D2GaNgEkn4DwdaI
 roAfkDxb9Y9m1tyJK+cSuL3agSp6pP/VMR79IpFQHbzNd0dA8D44u1ZtJ0WQc/9bFAV9
 JYhXlrjnSKhZUjn3ckQUZtiqnmBNo96r75ahLTp8w/DG7rBSoBEY154J3xoBqkI52yC5
 Bqikt6zPlgRLVZZFr85gjbffOnoRvLkZqwmytr8TYTkgBd4FpkkVj/uhFMC2kCa1lqtK
 3++oieTQRKiWio4N+13MALRQjF+tA5vtbWh9FrAUWcclkC3Namripp/ohjTJrrMf4sRW
 e1wA==
X-Gm-Message-State: AOJu0YzZuE5errbz6dI+5D5Y9mF49dtP+cQa1epxbktHQo3SBlTRnGs1
 SLCq3BxlPgUqRQyJwUQTsxP2urxMrZXayQVlMi5qfguG0k6KRGOdxzi/wE5wtbihwYR9QGfEK1F
 72/M6reU=
X-Gm-Gg: AY/fxX68zYgQEXtNGdxwJzkvxdom7qnnyEEL2t8C2oLNxqy2TjxFlfeCxoOtrYVBL/P
 WJ/Znagp0tB6vLksgP7H9ZJ5gv4O/jFihATkE3z0MPz3Q7LEbvFEaOJRIfBfbfLtTLhH/iE53he
 JPJszqHWhftnNRVtLZk6XI898BcQhxqYFg2NCpGRYc+dkJt2DtTSrSX3pu42ds7ASllRaoBoJmy
 Se20LOopMJ0zCX2mxdgRARuoWrohRKOfy5Sqshc7fSSaUOa0TN7X0ueFXdptl5xQ3Vf2Mgoe0oV
 yO7E94skS0RKKizXVoc0P8hEjL0EilPAZutcKkAlnMLNYspxynE9MRXJLN7yt3iVI0Pj7pZz6kZ
 CUh9QrnUGz3+fSpcG6MRe24et0ZaD/4Rnuir2fZozB3cZocE8HMwlKVmgQlcCc3vCMH1jMfeOEl
 dSa4zvHmaZVrh7SPXhLIPJlbSjZXculCRhb6yvd2OsfvzN2ZdgUQ98u9QR0YQFHxzLdGQyiXY=
X-Google-Smtp-Source: AGHT+IE7Ul/roA2zlNAem4E6dMPpP/oZAPginHAyVuACJjBotpdOD4BmU5pyZa9cYq+y8toKnRG0Tg==
X-Received: by 2002:a05:600c:45ce:b0:47d:264e:b371 with SMTP id
 5b1f17b1804b1-47d84b30d79mr109626425e9.18.1767977479984; 
 Fri, 09 Jan 2026 08:51:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6953fasm210375255e9.5.2026.01.09.08.51.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:51:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 03/22] system/physmem: Inline and remove leul_to_cpu()
Date: Fri,  9 Jan 2026 17:50:39 +0100
Message-ID: <20260109165058.59144-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

leul_to_cpu() is only used within physmem.c: inline it
and remove.
Since @bitmap is of 'unsigned long' type, use its size
with ldn_le_p() instead of using HOST_LONG_BITS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/bswap.h | 11 -----------
 system/physmem.c     |  5 +++--
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index dc31d48fd13..98877feffa9 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -315,17 +315,6 @@ static inline void stq_be_p(void *ptr, uint64_t v)
     stq_unaligned_p(ptr, be_bswap(v, 64));
 }
 
-static inline unsigned long leul_to_cpu(unsigned long v)
-{
-#if HOST_LONG_BITS == 32
-    return le_bswap(v, 32);
-#elif HOST_LONG_BITS == 64
-    return le_bswap(v, 64);
-#else
-# error Unknown sizeof long
-#endif
-}
-
 /* Store v to p as a sz byte value in host order */
 #define DO_STN_LDN_P(END) \
     static inline void stn_## END ## _p(void *ptr, int sz, uint64_t v)  \
diff --git a/system/physmem.c b/system/physmem.c
index be0c8094736..cd2b0dc5fc2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1272,7 +1272,8 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
             for (k = 0; k < nr; k++) {
                 if (bitmap[k]) {
-                    unsigned long temp = leul_to_cpu(bitmap[k]);
+                    unsigned long temp = ldn_le_p(&bitmap[k],
+                                                  sizeof(bitmap[k]));
 
                     nbits = ctpopl(temp);
                     qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
@@ -1319,7 +1320,7 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
          */
         for (i = 0; i < len; i++) {
             if (bitmap[i] != 0) {
-                c = leul_to_cpu(bitmap[i]);
+                c = ldn_le_p(&bitmap[i], sizeof(bitmap[i]));
                 nbits = ctpopl(c);
                 if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
                     total_dirty_pages += nbits;
-- 
2.52.0


