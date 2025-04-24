Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A71FC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lGO-0003vC-OG; Wed, 23 Apr 2025 21:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFR-0002i4-Cv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFO-00079c-7W
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so382384b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457565; x=1746062365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JhhILi6kCl6QHk3rZPaZJbYqQ/dafTh8uv7kqMAXi2E=;
 b=eIXQcSiSNwn2JhGfNF+ROGiFl7miMq6PSoMcPX1RrTMWs/K/LwJD3O2P5asHo5HIex
 eYZ8MNao0klwda83QxXjEn4bB0VdRQlCF25mi+FkOXylnVWdBCWHAu+uNWjwBmIkcdg4
 M6l7p2TLTitV1xiWo+pj7IOmHUOZrHDdVcnkHBtY3OXk9ygCoc9Jxd1vTopt5M/Zlftq
 gzrmQ1EpYXlxPsHq6x5algak92/gyd2NEKxfcajoThwWfUvRulepJvzSCDmejh7+4CNV
 NprJVGX9yWbmjk5BBaspwnmzb2bJnVIGP4VKrdbZ3t7vo0wwW+HHT2mp5GhVNZWlmUEt
 t85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457565; x=1746062365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhhILi6kCl6QHk3rZPaZJbYqQ/dafTh8uv7kqMAXi2E=;
 b=XK76tW9v34PCidFRhQJlS4YpZ0IGPMwUzOxLizkyzXtRGMS4nER72Mf+s26uaDFkTC
 AKv23ZPA7k1pQrpDVF8m/Dgnx6gGmlAXSu1kYg4l07pfKh3kxz5bOaYikApldoQGnfux
 M/Ep+FMr9lalskXaABoUp/b7+C8kyTd6JwnA5kRbhYumqtZSHRKxuIjU+7RZ5YXAdQG5
 /wlH8Acnfel1IEOmcjLVECRZe498GG2jEr9+x53ZuAl5Rit9RkyAWIXWnRvsf4NfmEYA
 v9dIIPbjcXzvBc7R+AdiYaSSXa28ppR6NUuSpTZP/QCjbplk1scl9pKdjfKDmCFmPMj8
 7q1g==
X-Gm-Message-State: AOJu0YwBjOG4/bHp6GknzpJEmzRLCbRq0kTPmqgsL8nsTEE08p7wWLQd
 4zaYnQ/AzaYRKi6wI6rO/z7DWZ1MhADXfWPgE76n8kH1P6XHUaWSGwPkhPUl4fbVGPyGX6rC0Gx
 t
X-Gm-Gg: ASbGncswz4MpnPL2/2J84i6CyPm3ir23TKciegtdeC0YkVQJIdH/Uw2rXGRsBTQL7lw
 YfEtl4S6gudF813xqlsX/Id2TUGFqN9CbQJtMp2oAAtjgmdqACJ/Zv5vWkSfC9pPSdiJNZsumkX
 o9t2Mf7bPZJoSqLlQByMGSmOnnu3WAnI4y8nv1TnPYI0YxQpiblDcbn5oVRQmr/NKm5ch7VOGUa
 9S7el1b6OVm22iEHy5zGDS7U3WDwNJf44ki8vLXdoYz+4knn1U0pISsWtaEEqy3Qch5T+zT6Fj1
 jPQHG+ZHhuCuJ+9e7mseh+oSGY0Cv3GVGJu9ekufPqrmILVc/0FgOHgX73h/s55M1KEvuQ0kv8Y
 =
X-Google-Smtp-Source: AGHT+IEbm3rotnea/g+7em2IQXJmJth92d/NknR4nMT4uPw0WmXL9wwC6p5clcgQ9gqp7AsrPUU89A==
X-Received: by 2002:a05:6a00:1410:b0:739:4723:c4d7 with SMTP id
 d2e1a72fcca58-73e24cfa1d7mr1135199b3a.22.1745457564653; 
 Wed, 23 Apr 2025 18:19:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/15] accel/tcg: Simplify CPU_TLB_DYN_MAX_BITS
Date: Wed, 23 Apr 2025 18:19:11 -0700
Message-ID: <20250424011918.599958-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Stop taking TARGET_VIRT_ADDR_SPACE_BITS into account.

Since we currently bound CPU_TLB_DYN_MAX_BITS to 22,
the new bound with a 4k page size is 20, which isn't
so different.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tlb-bounds.h | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/accel/tcg/tlb-bounds.h b/accel/tcg/tlb-bounds.h
index efd34d4793..f83d9ac9ee 100644
--- a/accel/tcg/tlb-bounds.h
+++ b/accel/tcg/tlb-bounds.h
@@ -7,26 +7,7 @@
 #define ACCEL_TCG_TLB_BOUNDS_H
 
 #define CPU_TLB_DYN_MIN_BITS 6
+#define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
 #define CPU_TLB_DYN_DEFAULT_BITS 8
 
-# if HOST_LONG_BITS == 32
-/* Make sure we do not require a double-word shift for the TLB load */
-#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
-# else /* HOST_LONG_BITS == 64 */
-/*
- * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
- * 2**34 == 16G of address space. This is roughly what one would expect a
- * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
- * Skylake's Level-2 STLB has 16 1G entries.
- * Also, make sure we do not size the TLB past the guest's address space.
- */
-#  ifdef TARGET_PAGE_BITS_VARY
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  else
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  endif
-# endif
-
 #endif /* ACCEL_TCG_TLB_BOUNDS_H */
-- 
2.43.0


