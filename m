Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1458BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXZ7-00031K-6J; Thu, 14 Aug 2025 09:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYW-0002HK-6P
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:44 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYN-0004OE-52
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:43 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-323267bc0a8so1527305a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176373; x=1755781173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jXVVpPrnUxKOJDwLJ9Z6F/DAfv+srkdIqMUZ2+d07Y=;
 b=NoOd+bNTKGdFMEF2obRXwrnPTJE3/x2Tn2VNhDut91ztaXENeXQAeHq0opn3ZTjW4V
 oclM6GybcRr2opaJK7X3YRXu0OiYx04Atd2QQ1dK+7w3UY2gxjOT9bfmxKCa4/WjL4ov
 NOR2tgCWtJFQfWomG4nxZeDG1x+e2cwKGKciPX1DVKCljCTbDDktEeQn5GXBe1MXrEKe
 xfGvguDRNMv11ZWjUZ5J5OIYeOfTAKU9VtBuJ17suUVx+RfgYA3RwtSqZkp27myoElb4
 +Gupe1hNqnVzQgi15brvRZ/CPvGRi8dYgG+l3gBXR93lK+Ml+9MX1XSqW3P9Kt4kp9dF
 BGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176373; x=1755781173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jXVVpPrnUxKOJDwLJ9Z6F/DAfv+srkdIqMUZ2+d07Y=;
 b=AcOn3sy81PMDp3y03lfBLRuUP2wkdsgUORHVKNsc02RM5x2vAVE9+Sm/EiPEp8qOYG
 4bYAkahT2CAZqhk2DQgemEpK23dLnV3mn1I8rn7O2hrOsULp0un3bi/jz9LRrccZvGpJ
 GwOOCpoI2aCOGsjvUSlirIhejOD0I0a2MbMThRzNF1f7MDSKLTohhVdxYCoIHw0Py7ow
 w6ONk3rDjCbob/El+2b6HxLXD7UnM58KSc4bZ/3WuPfQy5N/ZK6KEMQ1iPQ3vfuQtCz0
 3YVZis1m/WkSJe8dwtg/eqwDLyLhquLklOd8pGcKYocHWc2FJ2c1VBA084C4RiEmSfuL
 y//w==
X-Gm-Message-State: AOJu0YynT0BPiSfu2Nr+Ywvy/Yb2N3LbnIevFYd4ma3m+9xvWLjNaEz5
 MCSNBORxpIlsVyhmyqB1JT7HeVRSBseigeYgAhZAXfFJ8QQ/nQB+wKDC6KCMhGCXYQMpWJg+HeT
 UI9V6S70=
X-Gm-Gg: ASbGncvFnXSqRRTdKnoQWEnEKll5lv5K/V5t/naTwQZcyY2SOZ4R6tZqNPZ276WdnTb
 DQr1ghqRiVlJsbj28N9tcQ/PX74WKaNBBC8VBe/PJQzFaRlLAd5v2I38bD3OOd3NkLRSOaKLNwf
 jfF8Viz3yvqaDOJtp244xU+xGTpvXDDerlFGgDFxoHXp41/NSQ+HmywMVrx3AAwm2h7i7OCyJoJ
 sKYk73P3yGQMErwmRIEoN7vkjIB99tTuKyfJipu6crSMRAj0ULxldFcfGwrGYxkcFRZlEv4F9b2
 X6POC8hOzZeY9kc+bPLtuTdKnC8n5NPNqszZ+LuWGusyQwGq+H2doEZI8VLmrAjbyM6eXQ8yTXV
 iT39QhTVuaiibkpD46PoUVp5ItVOVkLF14TcgAfiSUSarmU8=
X-Google-Smtp-Source: AGHT+IFf5KlrS5MZdN5NRx/elB0yvd3BtzYzpNp8fYM2FyZXxs70S8zW/rap1cDozRx1KdvKVbGdVA==
X-Received: by 2002:a17:90a:c2c4:b0:321:6e1a:1b71 with SMTP id
 98e67ed59e1d1-32327a8a851mr4399164a91.29.1755176372685; 
 Thu, 14 Aug 2025 05:59:32 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 28/85] include/hw/core/cpu: Invert the indexing into
 CPUTLBDescFast
Date: Thu, 14 Aug 2025 22:56:55 +1000
Message-ID: <20250814125752.164107-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index bd835b07d5..23eb849a9b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -594,9 +594,18 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
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


