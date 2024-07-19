Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FB3C3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc6r-0006jk-K1; Thu, 18 Jul 2024 21:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc6M-0004FZ-Hx
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:08:05 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc6J-0000wG-KI
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:08:01 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-78512d44a13so847489a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351277; x=1721956077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wN2PEtP+rz1MoCCGhce/mKwLbs1GmxS63nYc3i7jjaE=;
 b=GIS28H9gxYaJWBJymaxkuh1fOecsIoYL7Dl83TWmR8h1ntX059QDEKjAv4R9euVO9L
 6I0figjFdEWQrkOExWHM/qxVkhUBcTVkXaVkD0BKTA1oa08XqAy6mIzQiRJKUu1JLmq3
 ry7nEs1DUwactNHxoT98P6Wvi3PSp0oF4E4mdtma1eb0yT84d2Zm1heG44Cs9P88PHap
 oreeVqHVSeFR+AS/UbFjpl7vodxP75hkfetUt9WSPdDdkGd6g2JaJoU8C3RQMHXMojLo
 Q0IeJ7T7HDDHnuzHD31Lr8A+UjNWHE+9ByrhYyn92IuwO3f1nsACi8MX3SmnG6kYHzNZ
 jDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351277; x=1721956077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wN2PEtP+rz1MoCCGhce/mKwLbs1GmxS63nYc3i7jjaE=;
 b=xONqIMvodZ59UtJ23l0QNj7otJ64tQEWriwdkY+YLPdFunD2AzJwGiUaIlZdHtO0FJ
 OcOlBgI10+OjvR5ULKi5XB6URSPSZfYQWhr5YjDH+Ae3Is7T8EYuQ5yRkywiUG5q3bKz
 32hvDfvc9tG1MEjWPHQwK38CQIq8jOSWYzJ6HV2+Jh3Rwg6Tz/m5H9TVhEoqirbYhf35
 wxabcLKv4zu5ZRpn6fSBnTzGRnt4fWzOBR1/cSto++KTPM5IYRo/6UBVL9McM16RDecL
 EHOIpT6lvWLG1S662w+nVvLnGPAmChZ8JtesSGE+t5bYHl5XhLVy4WcMRIfrNANgyZX7
 ybyg==
X-Gm-Message-State: AOJu0Ywhhu5Ug2XPFBpTzo5JAe/csdYF5pRngWP12JhgyqUIAhYS5DpM
 YzBOk96X2I/I5ixc2hfBBCjW6pyRIT4X7bMR7jj9lHCBY28XFYAIzR8s2AKIr7YHeohdCCEJXDX
 Ked5MfA==
X-Google-Smtp-Source: AGHT+IGhPxajhxgOVWiFmtLIIONpvdhohDePDWcIIWw5XK3xyb7NGQNt6fxO3hE1cGBghDFH+OynBQ==
X-Received: by 2002:a05:6a21:6da3:b0:1c3:a760:9757 with SMTP id
 adf61e73a8af0-1c3fddf4e40mr9104790637.49.1721351276741; 
 Thu, 18 Jul 2024 18:07:56 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 12/12] target/riscv: Simplify probing in vext_ldff
Date: Fri, 19 Jul 2024 11:07:07 +1000
Message-ID: <20240719010707.1319675-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

The current pairing of tlb_vaddr_to_host with extra is either
inefficient (user-only, with page_check_range) or incorrect
(system, with probe_pages).

For proper non-fault behaviour, use probe_access_flags with
its nonfault parameter set to true.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1b4d5a8e37..10a52ceb5b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -474,7 +474,6 @@ vext_ldff(void *vd, void *v0, target_ulong base,
           vext_ldst_elem_fn *ldst_elem,
           uint32_t log2_esz, uintptr_t ra)
 {
-    void *host;
     uint32_t i, k, vl = 0;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
@@ -493,27 +492,31 @@ vext_ldff(void *vd, void *v0, target_ulong base,
         }
         addr = adjust_addr(env, base + i * (nf << log2_esz));
         if (i == 0) {
+            /* Allow fault on first element. */
             probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
         } else {
-            /* if it triggers an exception, no need to check watchpoint */
             remain = nf << log2_esz;
             while (remain > 0) {
+                void *host;
+                int flags;
+
                 offset = -(addr | TARGET_PAGE_MASK);
-                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_index);
-                if (host) {
-#ifdef CONFIG_USER_ONLY
-                    if (!page_check_range(addr, offset, PAGE_READ)) {
-                        vl = i;
-                        goto ProbeSuccess;
-                    }
-#else
-                    probe_pages(env, addr, offset, ra, MMU_DATA_LOAD);
-#endif
-                } else {
+
+                /* Probe nonfault on subsequent elements. */
+                flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
+                                           mmu_index, true, &host, 0);
+
+                /*
+                 * Stop if invalid (unmapped) or mmio (transaction may fail).
+                 * Do not stop if watchpoint, as the spec says that
+                 * first-fault should continue to access the same
+                 * elements regardless of any watchpoint.
+                 */
+                if (flags & ~TLB_WATCHPOINT) {
                     vl = i;
                     goto ProbeSuccess;
                 }
-                if (remain <=  offset) {
+                if (remain <= offset) {
                     break;
                 }
                 remain -= offset;
-- 
2.43.0


