Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D9BCD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJvZu-0000zI-JZ; Mon, 04 May 2026 11:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZr-0000xc-Gp
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:23 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZp-0006De-VD
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:23 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8d68f702851so480511285a.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777909881; x=1778514681; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=seR931FbrhAdb+NYhAMGgy6RPmH0udBjx5jaRmN1ITA=;
 b=Qhfm84CAQWS9N7Loi2NByK6AG3ZtcNFUfIeK9omwsWMKRn3RvJbdWfgFSbps9+xxxJ
 p4IVbNePAKXQews+v7Yg3ZFhuEmf5QD+ekfNvltBQwHIRyyLYgxTeeHJgNJ7qMeF7aqB
 JKknViiUBObau8em6Kl5FdqPNKYvChpLLWDIilb62DfloTVBcAw77639PD3FKV+P5iZK
 0bH9YCqIVUOafQZlCUVOQV1eIclNu0zJS3FJ9nYrcy7OOQ+HQ/vts6ZGp0NhjcJHyRBT
 9WTqFcoKsQDb3jbDecPuw/a9NDD/qLz4MvO7x2bdJxmMmuYv/4qkStKM58tD3lb0Ma5M
 wf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777909881; x=1778514681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=seR931FbrhAdb+NYhAMGgy6RPmH0udBjx5jaRmN1ITA=;
 b=tMTWAVhHRkB+ueZgIfdpD//beXxgzjhy6dLBMzYuyDu5tqUyDhD19moiQkMMswkMUI
 NQxwJrAVnrWhxt9F4rDYZFkJo5CIN15Rt9SXI0o65fa8wuRilu0rvD6PMnnbLfIcSl0w
 /HG+qH9Td/E3di72uasHpbadUyWibSvatdpPsfplDaHAH2+bYGeqMiTuWP5BxgoGdeOM
 RcXc5PRnqMFW7WkCFOXjDEHWj2Gu31D2DN+7DbYFRbn63jyd6dzr/TqdCm9mqf4+uZOs
 aueeUJunYXEzx1gxqUhm3x2cn4g3F3MPYotX5xO/pYU8wonkJD+MOmQWKByY4Y7BLEo2
 Kk6A==
X-Gm-Message-State: AOJu0YxG6DG5dn4TAvNy59MOehm3Lm+qNa7K0Hx2EiPWLM6GjVpy77bj
 UUYzr6E0Y3dhH4er2XJEy+Yl6Bs4mnR8Jby49ZAPqI0g85Z0ZI6p1ZC4
X-Gm-Gg: AeBDiev1CuZAd5BZnLMwQAhZh5e8M+xxvWIHMv3XOdsvxIFUyVCbwLePgAcTwwPmey7
 FfEzldr0P59agmyoT5qbn6BfVNfRW94yBV9wI+K/cR7EmrUxREImb91dnBeMZCap6LlAxaHrM9n
 jiC3AgkM4Ld1eW9E//6mPbkTIn2HNGJBS3tssNddSQIC22iiLgrstVrRDeKnB5zRc2xaPDvzwBl
 MjdBLvtPSuWRCwuxL/okz2KgQNOqgOIFeMoW+uFwYhnIxgdq5snBI2AFAVV46YjTHmCV99jppbC
 dYe1is6ZJVXAsIrH+XlU3sHmI//FX5T0uR+S6P37IPCOoOQomiwA2aGwP+p5vpQRmRDtppPmwop
 F+YIg1jU36TSrV3f4pVxOcBWh4hXOBWoOrGqpfgIMypMAdv8aFekzV0HNqJ9EXqXya3IzvqU86U
 AqvN2rFug+MQYnsyjmAOoNV7Dw9KpnX59Fc5lAS0M8yZHWWMtdJAw=
X-Received: by 2002:a05:622a:54e:b0:50f:be4f:465d with SMTP id
 d75a77b69052e-5104bf50838mr143748111cf.46.1777909880546; 
 Mon, 04 May 2026 08:51:20 -0700 (PDT)
Received: from [192.168.1.164] ([2600:1009:a021:c665:5296:905f:3e4a:eb90])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040931552sm99599011cf.12.2026.05.04.08.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:51:20 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 04 May 2026 11:50:41 -0400
Subject: [PATCH v5 08/15] target/arm: add canonical MTE check logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-feat-mte4-v5-8-232a648e63c6@gmail.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
In-Reply-To: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909867; l=3050;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=taM0bnxg3Adu1LAuHiTNsQ5a1pkgBVcVSoxgQ7RpzL8=;
 b=PXd9SOLs+rn6qhmUWlWvmWQWAVLFXXbh9o9n60RMRL4bdcbQfcALc5MMOxfMDTMctJ4H5y8ei
 ExvE4fUmm9aCFso3sEwdLDg4d+v+1Xc/dWwrfr/AbUj31gMayUIFC/u
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qk1-x72e.google.com
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

With MTX active, address tag bits are checked for canonicity if the
corresponding memory regions are not allocation tagged. See
AArch64_CheckTag.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/tcg/mte_helper.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 61cdf92c54..d35e3ef04d 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -858,6 +858,14 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
         mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, sizem1 + 1,
                                   MMU_DATA_LOAD, ra);
         if (!mem1) {
+            /*
+             * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+             * otherwise it is Untagged. See AArch64.S1DecodeMemAttrs and
+             * AArch64.S1DisabledOutput.
+             */
+            if (mtx_check(desc, bit55)) {
+                return tag_is_canonical(ptr_tag, bit55);
+            }
             return 1;
         }
         /* Perform all of the comparisons. */
@@ -873,18 +881,24 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
 
         /*
          * Perform all of the comparisons.
-         * Note the possible but unlikely case of the operation spanning
-         * two pages that do not both have tagging enabled.
+         * Note the possible but unlikely case of the operation spanning two
+         * pages that do not both have allocation tagging enabled. This can
+         * happen with or without mtx (canonical tagging) enabled.
          */
         n = c = (next_page - tag_first) / TAG_GRANULE;
         if (mem1) {
             n = checkN(mem1, ptr & TAG_GRANULE, ptr_tag, c);
+        } else if (mtx_check(desc, bit55) &&
+                   !tag_is_canonical(ptr_tag, bit55)) {
+            return 0;
         }
         if (n == c) {
-            if (!mem2) {
+            if (mem2) {
+                n += checkN(mem2, 0, ptr_tag, tag_count - c);
+            } else if (!mtx_check(desc, bit55) ||
+                       tag_is_canonical(ptr_tag, bit55)) {
                 return 1;
             }
-            n += checkN(mem2, 0, ptr_tag, tag_count - c);
         }
     }
 
@@ -999,6 +1013,14 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
     mem = allocation_tag_mem(env, mmu_idx, align_ptr, MMU_DATA_STORE,
                              dcz_bytes, MMU_DATA_LOAD, ra);
     if (!mem) {
+        /*
+         * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+         * otherwise it is Untagged. See AArch64.S1DecodeMemAttrs and
+         * AArch64.S1DisabledOutput.
+         */
+        if (mtx_check(desc, bit55) && !tag_is_canonical(ptr_tag, bit55)) {
+            mte_check_fail(env, desc, ptr, ra);
+        }
         goto done;
     }
 

-- 
2.54.0


