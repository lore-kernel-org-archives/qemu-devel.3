Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8E8C79FAF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp7Z-0001A1-3u; Mon, 05 Jan 2026 13:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7T-00017O-P1
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:57 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7P-00036G-E9
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:54 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-88860551e39so1144686d6.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636936; x=1768241736; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sxmWOzIuS7iVVisp5U0jb8AqsMyDZln6Qiom5QmVA/c=;
 b=VEzRtqm2WvqX9SuMMEMoYSdV0PUPECIvcktJ7RLOdw7d2AAZuX/zaq3u7cItfjdKSr
 Gk3AxOwIleS7XJ6XtKklI2TsfDLgqW1ffTWGFLSegTDmOm9GwoqotdXy9jKmk+W0UvlJ
 vkakIURzB/ykPJglWvSmXGYZBB3TfBEXU3VKyiMBFwABn2sHgKRCPFuTHKUGdKot5pie
 CWBcTXT752LQArSpZQCT8B98FjEoDkndmnm+IGOPT9CFj0+FnyXU5+DVdP0qMpEPccGr
 vjyJVD4/ykfXDLqN+0eRh08kMoHEnqxvYXkVNROI4KWnc2+IFbTGlUKj0XVvikTcmxUo
 t5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636936; x=1768241736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sxmWOzIuS7iVVisp5U0jb8AqsMyDZln6Qiom5QmVA/c=;
 b=B5GS/Or0UO26EQBJnKNGJdKuB1aVGoYkreZTHDvvjewV+Wq4h8cJvrnvAxL//QXlRU
 zuIw1lJWgFUKIxSjitxMoJ464lBvTwQuwUfQfTp90KJUSpGwvBCZqyXj+54usLvXHNLy
 P1Hrc3JElak3+99lJjkvDV5UG3AuigTpeetIap+5YK5FG41otzPgH5zX1DYEhPrPSZDw
 DAG3uyIzE4pRQ8Md1qEWJAKwuQA98mFhEzIbO2HCMllxN0mg09jsVT1HSqG7+sWVVN94
 wtxEbpav9rcvjZivNG0ET+5qXWT8NJmU8pN5qBBhoxmriT8pFcNftRawXoPmcbKYjRHt
 Vl3Q==
X-Gm-Message-State: AOJu0YwdnzMIUeGqRq0PlXF5gYGeHynuGQ5rSuyO2NyhU55v95lEPurc
 kebulcxiZOZ7NZvBC995erNvYnld1aX+RBj1jzE/PoCDtztNWw/sC2cKvop50g==
X-Gm-Gg: AY/fxX5mK9Or3Uvv6ttvQ4/BVBEbW6j2S3+NZu7tajMZ1uItKbYmYgY1HUlbRAub4Ed
 FJLreVJfZz6yqnh3lIMnYBqk0fqnXPVv8G/s30WdqdDuVczinROflmcXHi9az6jdl7WUFvKxvGW
 j/CpKHX5QmAh74Pc9Ndagup/byaU1HW1oXO+VY7AW3WkTzrdGM+GwHeSQormG8C3bcF+1pfOenp
 lCLkKOTYPhLsezYZwzcxA/CCiMfNdydhODqlaHN2AWCWQyD/5KjVMraVYDoz3DIGE8BMFGVPf3s
 FwMtdKR5g5I+ypT96LKQNWzX68wMjPJMiCxBunUS/0wy0NVfqXKyFb6TNta2YsJdROVwsZfqf4+
 LJ6ADtZWpwkRC3zIHtt4jvXzLg+PZOyfGYm5JHO/v9Ts6f9RlEUeSbjHMQObMJaICctaANsk13m
 2NEJey3F/1t0Y9g+wAXsDmeyHB
X-Google-Smtp-Source: AGHT+IHRr6WLlgnCzO9QYqt0pvynJC6ksLR5wXMj7GzpWFM9bnE8AUEjslEfz75SIKmHlaUbP8zSPQ==
X-Received: by 2002:a05:6214:21c7:b0:890:65ee:115b with SMTP id
 6a1803df08f44-89075ce89aamr7899386d6.5.1767636935635; 
 Mon, 05 Jan 2026 10:15:35 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:35 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:14:56 -0700
Subject: [PATCH RFC v3 07/12] target/arm: ldg on canonical tag loads the
 tag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-7-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=2899;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=tbFNfZyKp+1ZA4wXWb9GVCgQ0bgmepo0KgHb03QDkaY=;
 b=DBg52ZEmwdB093txQCKZWyPSQ5+B0B1+YXDPeTxxaTXLNCqajMRpMMc/RY1NCpFxMrcxZPE8q
 GSwaANEvQGmDlLFpdgxjctAklvHCH25zyK8wJuRSDsTev7O1A21r4/d
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to ARM ARM, section "Memory Tagging Region Types", loading
tags from canonically tagged regions should use the canonical tags, not
allocation tags.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/tcg/mte_helper.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 6827d030dd..795a5ad20b 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -310,9 +310,14 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
     mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_LOAD, 1,
                              MMU_DATA_LOAD, GETPC());
 
-    /* Load if page supports tags. */
+    /* Load if page supports tags. Set to canonical value if MTX is set. */
     if (mem) {
-        rtag = load_tag1(ptr, mem);
+        uint64_t bit55 = extract64(ptr, 55, 1);
+        if (mtx_check(env, bit55)) {
+            rtag = 0xF * bit55;
+        } else {
+            rtag = load_tag1(ptr, mem);
+        }
     }
 
     return address_with_allocation_tag(xt, rtag);
@@ -463,8 +468,10 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
     void *tag_mem;
     uint64_t ret;
     int shift;
+    bool bit55;
 
     ptr = QEMU_ALIGN_DOWN(ptr, gm_bs_bytes);
+    bit55 = extract64(ptr, 55, 1);
 
     /* Trap if accessing an invalid page.  */
     tag_mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_LOAD,
@@ -490,19 +497,35 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
     switch (gm_bs) {
     case 3:
         /* 32 bytes -> 2 tags -> 8 result bits */
-        ret = *(uint8_t *)tag_mem;
+        if (mtx_check(env, bit55)) {
+            ret = -(uint8_t)bit55;
+        } else {
+            ret = *(uint8_t *)tag_mem;
+        }
         break;
     case 4:
         /* 64 bytes -> 4 tags -> 16 result bits */
-        ret = cpu_to_le16(*(uint16_t *)tag_mem);
+        if (mtx_check(env, bit55)) {
+            ret = -(uint16_t)bit55;
+        } else {
+            ret = cpu_to_le16(*(uint16_t *)tag_mem);
+        }
         break;
     case 5:
         /* 128 bytes -> 8 tags -> 32 result bits */
-        ret = cpu_to_le32(*(uint32_t *)tag_mem);
+        if (mtx_check(env, bit55)) {
+            ret = -(uint32_t)bit55;
+        } else {
+            ret = cpu_to_le32(*(uint32_t *)tag_mem);
+        }
         break;
     case 6:
         /* 256 bytes -> 16 tags -> 64 result bits */
-        return cpu_to_le64(*(uint64_t *)tag_mem);
+        if (mtx_check(env, bit55)) {
+            return -(uint64_t)bit55;
+        } else {
+            return cpu_to_le64(*(uint64_t *)tag_mem);
+        }
     default:
         /*
          * CPU configured with unsupported/invalid gm blocksize.

-- 
2.52.0


