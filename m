Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CC5C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLf-0000ry-A6; Thu, 01 May 2025 17:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLN-0000k8-5O
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:21 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLK-0001Qm-Ty
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:20 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so1291912a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134477; x=1746739277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+Pi/MVpYTTnikQZ/n9vkB7TQs28G8OZZALzcSuuLv4=;
 b=XXDJs01hU/qoqnv9Kzcles3RgqCwmXcwIeeqHkMqfQHDI/hJ9CO0GPBojY4snq34Ia
 OZ1AC9UmILkcWeh3AOsAy3uaOiUGC2lmIDaAMTwzEvxx5Bm0gZ0pwK4ZZDj+uf65h8bq
 CmAeUHjJopVi4iTkafptzdHhi24EwowVEquelUu57/FXI95RN/cQD3Rc3QHUSp4QfVFv
 exjBwvdvPMDCHltX8tDCRkiR07F46stGsuUFzsm+u93A/szWOyea32NL98WKb1VPSfyE
 VrhJP7T//GvDI4Q4ibPc5Hjq5DsbzWFRTQCbV2hpZSTPgA2ReWO6XO1rSOCJRfUlIeUe
 HyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134477; x=1746739277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+Pi/MVpYTTnikQZ/n9vkB7TQs28G8OZZALzcSuuLv4=;
 b=GcbOOw4vscsny0NkzNfL8QLOACDFAjPKrqzdQXqbjwoiKZqflT7Z1oZXueym28ODzI
 KZa85SlnfJnSTLOrP8OMbpvEsjeRKoYuOBgYeCz5YHf3r0E3Drp6Zeu4rGo/9EPle5nj
 glQJz/fFIDFqo6ekoKD102hSg5GbqtpgvKEIZJpWz60NBiwxoX95ALCe7eMIUkMCbCOM
 9FwsxVPo5fHIO3qPTO05uHMChhq75FpzILyRrI7LaPgiC6EcfMdDUOCQOI/a/FMiSPZ6
 q/EWyYb/xaHB5Fc/Qg7n4EekF2WCrLdtSsTHVeKG+JiLQ1oS8/CipSpNQh5eXZGY1P8g
 XtPw==
X-Gm-Message-State: AOJu0YytOc2bFQ4pDTqHnMy+5tOibld4YWxC1WJ84FrwWtWkjbhoeWOw
 vq2LjdWiwjx9G/RGX3Sg4P8WCfK1xr2ZYpRdd6X9KsSzEFC+5x6t7toQCd+3wr5X2yUi0ak/OEY
 z
X-Gm-Gg: ASbGnctncKNKoavxquRJiofQdqKSUJES7wAma2J074+JnqlV4N2vhSXBWZHpaSgb0NY
 BDCbt1jmUvhaRx7Y1lRXHujuI3IQHvmThdTLI73QZrHVazzpWTjAhEjl+ECArmC/zNYLsGcSTeE
 fvlbbFe13NobzP+8yagSriW9kwftBsRubaSG6zDXzQNDxgtk+1/zY4FxvvXJ1EXgxPMumf7JdVU
 20TtEgJkN3MO/kXlpPoxWXEFzR8yFelw64Ra+1SJ5hOyYxdEVS6eoDvFXfMvFsqXdzPvVhBU1n3
 PK53OaaW1FqPDlC1cObiNg22buDnGremN7gXaGa+v2K0me1GlSemA6T9RXduhA8iZy9Mq2qyS3g
 =
X-Google-Smtp-Source: AGHT+IGNSL+dsuRnezBWqiSvQjmgy2DOOmilfaCBeDJZmqj2qXNefKKD+Zf/X2QFKqo71D9Lo5dOWg==
X-Received: by 2002:a17:90b:2642:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-30a4e1db4b4mr986585a91.5.1746134476911; 
 Thu, 01 May 2025 14:21:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/59] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_page_range__locked
Date: Thu,  1 May 2025 14:20:17 -0700
Message-ID: <20250501212113.2961531-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 714dcaedc9..927e9c8ede 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1100,9 +1100,12 @@ bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
 /*
  * @p must be non-NULL.
  * Call with all @pages locked.
+ * (@cpu, @retaddr) may be (NULL, 0) outside of a cpu context,
+ * in which case precise_smc need not be detected.
  */
 static void
-tb_invalidate_phys_page_range__locked(struct page_collection *pages,
+tb_invalidate_phys_page_range__locked(CPUState *cpu,
+                                      struct page_collection *pages,
                                       PageDesc *p, tb_page_addr_t start,
                                       tb_page_addr_t last,
                                       uintptr_t retaddr)
@@ -1194,7 +1197,7 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
         page_start = index << TARGET_PAGE_BITS;
         page_last = page_start | ~TARGET_PAGE_MASK;
         page_last = MIN(page_last, last);
-        tb_invalidate_phys_page_range__locked(pages, pd,
+        tb_invalidate_phys_page_range__locked(NULL, pages, pd,
                                               page_start, page_last, 0);
     }
     page_collection_unlock(pages);
@@ -1215,7 +1218,7 @@ static void tb_invalidate_phys_page_fast__locked(struct page_collection *pages,
     }
 
     assert_page_locked(p);
-    tb_invalidate_phys_page_range__locked(pages, p, start, start + len - 1, ra);
+    tb_invalidate_phys_page_range__locked(NULL, pages, p, start, start + len - 1, ra);
 }
 
 /*
-- 
2.43.0


