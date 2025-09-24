Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625FBCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UqF-00029K-9s; Wed, 24 Sep 2025 15:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmC-00070X-Ki
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:42 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkA-0007sg-KR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:36 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-32eb76b9039so184112a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740480; x=1759345280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJiaoiqB2SYQYYaP+V4AKhL/433rJSvOrhZgOKxZ4EQ=;
 b=bANoZF1Z8ktlPzVNcA7mUPUOPzAIE94D6J/eRFbG+qVHXPJ+tDzlRFXiEpUK6lVdnW
 mthc/I2y242OO3HY79xVfWAcMIaGJHjahdcZy+tQgKPds0+s+hNsv66KNkZTpru5MrGU
 z+Z+dbeBdM6hZ32bk8ctNuUbRbxsaFKc7yJVR3VI6ANRP4snTQfcv+TEc++txneA6wyg
 lQhBRcHtgOrcPKLF9HCFdBxKxymIKmgdh63HLXZ7jk5GkRMxkNbjefD7Pxgp4qLX6b53
 oXR792O8Wte497K3ALct5AeyGQOtr/DLjp9h3Ft3llL9YP10oHbNjP7sdleBCFtrNFUC
 Zbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740480; x=1759345280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJiaoiqB2SYQYYaP+V4AKhL/433rJSvOrhZgOKxZ4EQ=;
 b=udeeM25jV55A+rCWXdrF7pf9kdgZzjJZ9FyGQpogjEUMaUhgGPLmHzUqVF6JghtHlp
 1nmxYqNsdMJb0SwNM7y/TP9KmkhpTZ4euBIeHpNj7qf4ix1oRyV2izcVxMxKbg5u9zZm
 dqE23meN0C+wbUsFuY+8VuyrZSHpIV+S2dVFisKv/D6cRv6LB3+/ZAPty4Fmj8joPqcm
 Mlj1wBOFrhyui4CdnScAX4mF2P14ZqDc32w1J4vATr9E0mHehZ+Ebz7RxR44tsOJA/zl
 9Am/KExxGB3DCTyzKBHjNNGvTVAP3yq6TVr++IgCy0QbjcZrCCtjsPjmncHXB9Lvagxv
 sXtQ==
X-Gm-Message-State: AOJu0YzueOOcUGSE1GNrd0NG4yXAGvuwn6xA6uvx3P73hbEKLg+ZrjE+
 YH/gGQoNThPwdWnbp+9xJbPVpa8uao2XA4/BFh8G5s1pHaHT521kID8pXliP5EzA15CLbfv3cHL
 RqFcX
X-Gm-Gg: ASbGncvsjrGmFuUQCDi+rpF+qGrcUYAldxYTXlLLt+uWXbXRWYL/4cG8W8IHGWGxrlj
 xSt3GJum0D18ZRqlf4tvp65+YVWSs7hHysqL39PxvorCDcG0QD3LnRpXP/0BjjqdXExP9nEXSYS
 F3UZkrrXlQ86kVYzBls+L1IycieBNTN+VoYLXPFpBlF38JPyyGslfKI9Qno0JflF5EdlEp8cxcc
 1r+mg86RCKrSA838WEGk8UbKXB9y7tOH0tfzxpSmEeM2E0ift5T5maIolrTEArlsVC+JNoNREBV
 LR6P58aAeP66c3u2hvFbGBsKiYPGxG7FmsJGbeRkiCNUHjF3bft22r9ku0GJy8WzYdJU7feGKOm
 vCnt2ctzSpncgDkr82o7Y3IBZy2J2
X-Google-Smtp-Source: AGHT+IGOtfGLm1AAQEYSWx2W3wEU/zbxLQIBDr16Vp2u1hDDlJMG/ThWuOBtHSZwv+HCqOTNz7/Itg==
X-Received: by 2002:a17:90b:3911:b0:330:6d5e:f174 with SMTP id
 98e67ed59e1d1-3342a2b1263mr782271a91.20.1758740480141; 
 Wed, 24 Sep 2025 12:01:20 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 17/32] include/hw/core/cpu: Invert the indexing into
 CPUTLBDescFast
Date: Wed, 24 Sep 2025 12:00:50 -0700
Message-ID: <20250924190106.7089-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

This array is within CPUNegativeOffsetState, which means the
last element of the array has an offset from env with the
smallest magnitude.  This can be encoded into fewer bits
when generating TCG fast path memory references.

When we changed the NB_MMU_MODES to be a global constant,
rather than a per-target value, we pessimized the code
generated for targets which use only a few mmu indexes.
By inverting the array index, we counteract that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 11 ++++++++++-
 tcg/tcg.c             |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 22a78c9ee1..c9f40c2539 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -603,9 +603,18 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
 }
 
 #ifdef CONFIG_TCG
+/*
+ * Invert the index order of the CPUTLBDescFast array so that lower
+ * mmu_idx have offsets from env with smaller magnitude.
+ */
+static inline int mmuidx_to_fast_index(int mmu_idx)
+{
+    return NB_MMU_MODES - 1 - mmu_idx;
+}
+
 static inline CPUTLBDescFast *cpu_tlb_fast(CPUState *cpu, int mmu_idx)
 {
-    return &cpu->neg.tlb.f[mmu_idx];
+    return &cpu->neg.tlb.f[mmuidx_to_fast_index(mmu_idx)];
 }
 #endif
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index afac55a203..294762c283 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -425,7 +425,8 @@ static uintptr_t G_GNUC_UNUSED get_jmp_target_addr(TCGContext *s, int which)
 static int __attribute__((unused))
 tlb_mask_table_ofs(TCGContext *s, int which)
 {
-    return (offsetof(CPUNegativeOffsetState, tlb.f[which]) -
+    int fi = mmuidx_to_fast_index(which);
+    return (offsetof(CPUNegativeOffsetState, tlb.f[fi]) -
             sizeof(CPUNegativeOffsetState));
 }
 
-- 
2.43.0


