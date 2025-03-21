Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B9BC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVpz-0001HK-QS; Fri, 21 Mar 2025 02:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoH-00080q-GN; Fri, 21 Mar 2025 02:24:55 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoB-0002zw-Jx; Fri, 21 Mar 2025 02:24:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-225e3002dffso23036115ad.1; 
 Thu, 20 Mar 2025 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538277; x=1743143077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmhaDUCITVTolqS8yLhqK/IZH/DnuSfoIHP1VEj2LYg=;
 b=GK2uFmOot5G0xk6SadwYeqCtdAaHV4vBPg65VFwldDAwuq/GU1PTRzSwDUP5CorJ7W
 OpvZrvIE1iBcPZmloh4aEacSJ1vZNJXZ8hhsuynVHSm7f6THxn5uzGk2SjGYx8HNUwSI
 WRkOpTuJALAkUuMbbz0/D0EjxKdQzOI3CvBWE/Ft5MwNyBBBUoVTzxbzWhoHDoopnHTK
 ox7751Fz04G7uHogm6mftArNVvcnM8zQCyLIKt0XkeD5pNTGf7vqxtG13ce3buFCqcGD
 4U7ZDlSS6bAzm+OV/z0kG0OYPbVAVox3yUmgYni7XkOJTBqq0qAlts/Q1AbWif0NaklI
 50bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538277; x=1743143077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmhaDUCITVTolqS8yLhqK/IZH/DnuSfoIHP1VEj2LYg=;
 b=tHc8Ip7njaaomMmXQJF2UzaW5TYgBBSkySkZkQF2KV9wWQ564FzMfIiDNNFBK2JQKa
 JQ8d7PGXMgOWhkAUImQRY9wJb90+8tB3fomSiKGYmqqdjF28z+EQGJbAIAgxUG3BNnyP
 cNPO4Vlqg6Fd8OxiMdMNojEomBPPMsRsUuZEaAZnc0FO5adWrKoc1bkPWv2LNzSlhY9e
 S0r9UpeSLQi7chu5t/IXYK0pmWUWHGjGIczyGiXY3pGiZkTLRkWIlYYgl1V/nYaLm5H8
 +ln1bcHkxRIcWsay73s9ZATiAj3zVo9nRwygO7GWWrpLaEhS4RIHZgTqkrOGVaM//3w9
 bd0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Q6ng9tg15af+5eNOgQ6jPsV/xmhfLK7rzgYVVgMdFk6c3WRyCKiBretbb2d8nsnJgTV+6VF+fA==@nongnu.org
X-Gm-Message-State: AOJu0YxjMe+AaSZ9oD/SliKhxnJ80ujUjOT3/G65bv6YVaJ1iDOgVko/
 PRh4UVBFc97jFOn5OuRs69z7dnDKWb4GBI4e+50ripL1tCKLfIBvKtCP2w==
X-Gm-Gg: ASbGnctvGx/3d8SGp00hjxyPjFEvWeCVVKsh2x5liDZSZ7KAfgB+5gV26A2TrXtEQPT
 5+u3nc4dmjyQ+5qATSW1Wm6J/BrI9oloVFEUlGiZO/qXKuiY4jR7DRHpA9vgUxgYYhiLlhzVLXb
 zvEO9tXAGJsWRPUb/4qZHnSGh2Spd7OTmP7juZe8cKhejD0qL2wK6fdQumuIvHZCXLO+trvDY0S
 up8uqo5e35ZhalF0dR//kQTctKKTi+Ewn3nSjo8H8kcbcDhhgrxEKTT+yjT9jmSa67lw22gI8k6
 KcFeuWrla9vvPEnCYZlnH0k/GrodFEagiZRwddE/4CorI/xJ7g==
X-Google-Smtp-Source: AGHT+IEOGvsxTiBD3KHtcOeVNMlnmFFi6gUvshWcXmiSLOJZ/rOF8QGFXWq8BVl/pOHX2VbOcGCIYw==
X-Received: by 2002:a05:6a00:ac4:b0:736:4c93:1bdf with SMTP id
 d2e1a72fcca58-73905a275famr3039921b3a.18.1742538276697; 
 Thu, 20 Mar 2025 23:24:36 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/12] pnv/xive: Fix possible undefined shift error in group
 size calculation
Date: Fri, 21 Mar 2025 16:24:07 +1000
Message-ID: <20250321062421.116129-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

Coverity discovered a potential shift overflow in group size calculation
in the case of a guest error. Add checks and logs to ensure a issues are
caught.

Make the group and crowd error checking code more similar to one another
while here.

Resolves: Coverity CID 1593724
Fixes: 9cb7f6ebed60 ("ppc/xive2: Support group-matching when looking for target")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c  | 27 ++++++++++++++++++++++++---
 hw/intc/xive2.c | 19 ++++++++++++++-----
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index e86f274932..3eb28c2265 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1662,12 +1662,20 @@ uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
      * (starting with the least significant bits) in the NVP index
      * gives the size of the group.
      */
-    return 1 << (ctz32(~nvp_index) + 1);
+    int first_zero = cto32(nvp_index);
+    if (first_zero >= 31) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid group index 0x%08x",
+                                       nvp_index);
+        return 0;
+    }
+
+    return 1U << (first_zero + 1);
 }
 
 static uint8_t xive_get_group_level(bool crowd, bool ignore,
                                     uint32_t nvp_blk, uint32_t nvp_index)
 {
+    int first_zero;
     uint8_t level;
 
     if (!ignore) {
@@ -1675,12 +1683,25 @@ static uint8_t xive_get_group_level(bool crowd, bool ignore,
         return 0;
     }
 
-    level = (ctz32(~nvp_index) + 1) & 0b1111;
+    first_zero = cto32(nvp_index);
+    if (first_zero >= 31) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid group index 0x%08x",
+                                       nvp_index);
+        return 0;
+    }
+
+    level = (first_zero + 1) & 0b1111;
     if (crowd) {
         uint32_t blk;
 
         /* crowd level is bit position of first 0 from the right in nvp_blk */
-        blk = ctz32(~nvp_blk) + 1;
+        first_zero = cto32(nvp_blk);
+        if (first_zero >= 31) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd block 0x%08x",
+                                           nvp_blk);
+            return 0;
+        }
+        blk = first_zero + 1;
 
         /*
          * Supported crowd sizes are 2^1, 2^2, and 2^4. 2^3 is not supported.
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index f8ef615487..311b42e15d 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1153,13 +1153,15 @@ static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
 
 static uint8_t xive2_get_vp_block_mask(uint32_t nvt_blk, bool crowd)
 {
-    uint8_t size, block_mask = 0b1111;
+    uint8_t block_mask = 0b1111;
 
     /* 3 supported crowd sizes: 2, 4, 16 */
     if (crowd) {
-        size = xive_get_vpgroup_size(nvt_blk);
-        if (size == 8) {
-            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd size of 8n");
+        uint32_t size = xive_get_vpgroup_size(nvt_blk);
+
+        if (size != 2 && size != 4 && size != 16) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd size of %d",
+                                           size);
             return block_mask;
         }
         block_mask &= ~(size - 1);
@@ -1172,7 +1174,14 @@ static uint32_t xive2_get_vp_index_mask(uint32_t nvt_index, bool cam_ignore)
     uint32_t index_mask = 0xFFFFFF; /* 24 bits */
 
     if (cam_ignore) {
-        index_mask &= ~(xive_get_vpgroup_size(nvt_index) - 1);
+        uint32_t size = xive_get_vpgroup_size(nvt_index);
+
+        if (size < 2) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid group size of %d",
+                                           size);
+            return index_mask;
+        }
+        index_mask &= ~(size - 1);
     }
     return index_mask;
 }
-- 
2.47.1


