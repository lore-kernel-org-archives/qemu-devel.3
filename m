Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A90DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9n-00049i-1m; Wed, 08 Oct 2025 17:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9i-00045P-NV
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:06 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c96-0006f0-U8
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:06 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7835321bc98so322492b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960585; x=1760565385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sl08bFFOE8sFkEmJSjjl1K0xzgVR4D+vJUoRJse3hLM=;
 b=kf9o61edQEhdpqChyKmR8DC05dNcAyoD9jZrJ/6g8YnV//2wGlWPvt0i+QV3lT0X0O
 ZEkY7YhthHNsVPW4WSgTYHYD8VcUrJ9Pzsj+jcGVAqozLkxXJZspZgLjM1Ef3tlxhaZO
 fPUd7r1R9RXgk2Jpa2iNEy8OToJUa3k4qeVsTC6S0DwYFjCG00Mpj5FJtLIDQ2KbHWl+
 HIchiXhDNvCNcm93wDJzqrgT9pitITxZYHdMpCvkHiBRajjwmWDEDNGjsU0nmZiquV0P
 WBfj4tSH63EkXCztvzL7U32gPbKHQGU4j/owAZEWIpY2DLHl9ljLEwYCFCpIbLXvD6hI
 rI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960585; x=1760565385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sl08bFFOE8sFkEmJSjjl1K0xzgVR4D+vJUoRJse3hLM=;
 b=bDczZT5hMOh5LSjkf5/CTkgbClhYtxOJYjD6WVt/PINt0dfd6kpAXQb1NYubsJhUIo
 gfyXGQLisw0DMG6JmeS9N2ELd1SFgCAfop/WKmhoH0lpK9y93y4ssT+WrAkx8DMq1ZXa
 rRuH923AHKUsyuXyY60Q9Iqbn4Zg088aiv8dUa6VG/vVG0eGV1VMiThSzTz2/1LdgQfd
 Ihf62xwMw7iiFVxkHufqM99M6VEEVd9eFZOfwdBouaMAOHslKeSydppMPAeaK7Zr2H5t
 kdjGS6KeVbUpj02S6SKhKUcqzUEAFUvNZXlx+V4/1NG0X0h/sNSU0fyy24/9EgVk1Bmo
 KOfw==
X-Gm-Message-State: AOJu0YwZShOyL8CypRvIZiFKC5S801AI3lFd6Y1rhzg8Dm9lgUYXoGPd
 gBxtBxB6SFf0T2dseCGBO4i9xep1gnzumwPFFC7CEZ7RLgKRAO7sBN9WypvXXuyN0kO2KUr5KfI
 /fEKT/3k=
X-Gm-Gg: ASbGncvwsyGSz55xYqn7XBPJeziou72tMpUEW9HhWf5CoWomYIaWndEhY5hI/1iDVjC
 mYl0rNz+12VozSVtkRPSv+nar3ryNFvXr2bn7Vp6ZBCRc+sSCYweGutnMxRlmxDtZrRyRWFBKEb
 nx04zOkmpVnWAgqRZOCKilGJ0kwfmTqI1cM7RLrTeNR0oHcoor0bFx8Dx0NN9ojUDchHtRqtQvo
 R/GC6IJ31EvYHYoLCC6oLWbPdK902Dv6mVllLV77bZf2lZRUajwVoizgXNaFnf+y/jwoPAHU+9p
 LSrxS6XVM3o72H7BOX37DbgyX3gTiyrry3GZK28zOT+MAfJDH8ARAA6IX51Tuhegga8nkirXQvx
 F1bvBaRmBwpfJxVsUsFbRZrfsTvppkZxGbx9qAGb8iBLp34W3eiNo6L1g0eBagKp9uoc=
X-Google-Smtp-Source: AGHT+IHTCQuboYi6oG5QQPvPWIx9xKjEdOacQgwXoOT1OSXj+uitngiUCFSXJXjDVoV3EbuPWy68ZQ==
X-Received: by 2002:a17:903:38cf:b0:25c:25f1:542d with SMTP id
 d9443c01a7336-29027342b50mr58558595ad.36.1759960584789; 
 Wed, 08 Oct 2025 14:56:24 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 15/73] include/hw/core/cpu: Widen MMUIdxMap
Date: Wed,  8 Oct 2025 14:55:15 -0700
Message-ID: <20251008215613.300150-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Widen MMUIdxMap to 32 bits.  Do not yet expand NB_MMU_MODES,
but widen the map type in preparation.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 accel/tcg/cputlb.c    | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 0fcbc923f3..60d3f01900 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -201,7 +201,7 @@ struct CPUClass {
  * Fix the number of mmu modes to 16.
  */
 #define NB_MMU_MODES 16
-typedef uint16_t MMUIdxMap;
+typedef uint32_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
 #define CPU_VTLB_SIZE 8
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7214d41cb5..3010dd4f5d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -90,9 +90,6 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
-/* We currently can't handle more than 16 bits in the MMUIDX bitmask.
- */
-QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
-- 
2.43.0


