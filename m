Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97785C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrtr-0001Vz-Bh; Fri, 17 Jul 2026 19:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtq-0001Uv-9W
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtm-0006yp-VR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:22 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ceab75934dso85665225ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330596; x=1784935396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JU4rrR299+XISy9LcAmasYIokW518EoY+ALWFUyVnMI=;
 b=wISbja5fsNzhH05Ke1YWjE3YN8lVnpAtdLMXqetUZHuVaiQMZeMh4OjsS47f31sNEg
 tEJlNZ0KlLgSHKXVyiii6r1a+MxHSQuzZGqkS05k7zbg5R2tRD9yG+C8hzh4ZfavcTrk
 +0x5M8n06P4TzR5R7Rjvuh1wkMKi7/CvQ++hqHfzoZSbgbD8nBPa8XhnNUzjLNIhiaCB
 IOU9iG/WpsEoPPGFj0cJWkx7x5qvF23bSmK+iGU7GbKRVSbmDYef2fOk5q43j26q0En5
 Zdtmw7ckIwgQnIJ+tT0e2GWYmb75FdELMsHcjgQQTTJyHEEzM2+3EOkRgUpWRVimwbgr
 t6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330596; x=1784935396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JU4rrR299+XISy9LcAmasYIokW518EoY+ALWFUyVnMI=;
 b=GdEk0PJzkoKZhonS/u2iHIn1fcesT8UGCobgDhewjQ8vpBd6dGHQHk1qGARRqILPhB
 lJ5Xu69zjMqFtDNHl86pBzj4fw9brVdzL3l3SCbzOAijDzUWGt31/MPp513N13Pp/7wB
 Th+ir4p75WOIpj3kBRIlyyWiBj918tnr3JXQuArg9WUaT0oR/mD7JIVa1Kr3A2Y/b56F
 y/pJ2XRIADXHJvnwd40x7mD6eSzR/aWEclkD0QMOXCjNbXLg1JhGR5Go+TmmIAh6MQuC
 01cbpsNhnxJXrWntS3kd2StWx8n4XujXmYiQDUr7oLIG47hIWH0eEyvBzVzePYc1OSql
 logA==
X-Gm-Message-State: AOJu0Yw40RBVjsvROuKKNUk2HuBk+Xlkp+ELO5mNWykPI3A17nN6j4D4
 ZcQyGcE8vo34Ye6kfMrxvdSl7SVRJGsWOjUFcyWtqpH+aMmF3mh/ORiUsHd/hEcPqjtKKJNdq5Z
 WEGXo
X-Gm-Gg: AfdE7ckJMb9UVUL1NtYqjLo1zjahF0Ol06USh84VuTxz93VQVISW0iwADuJO17kQdnI
 SkAsKRzRVpnz+9wcs6JaFe5MFLnMjVut7Y+LWzbV81d/GGNcehG1zYlU/RYk9UVgBQaf3qGPKWP
 jJ/K7NV0xWPKn15TNBcu2BRgILuFYCdhc4tFlTSHfVp1f/parl0Ai8c0rRET7/oufMCrmdgZqKU
 UXl7VPEC/lOMVU4jznX02aajGnlK0VcD58dKW5Ln/sVDppWtXk42utB3YcWXC8ME94MBtaaY6gg
 RB/dmhicKg/QDkjpPr2cLg9yYR+fBMkgBKywZa5Rr6ZWTLcmVRkKjjwWCa+7abWhg4XlM646Jde
 LuwtLLvzs1U9owr0ucvi8JKqMa9lcsFiVk+uTBqWkVE/N8PPdZ4777TY7N7c5HJjS183IlP2lDX
 OLy+ryyG8=
X-Received: by 2002:a17:90b:5588:b0:38d:a150:ee04 with SMTP id
 98e67ed59e1d1-38e4b55aabfmr4944229a91.30.1784330596237; 
 Fri, 17 Jul 2026 16:23:16 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/17] target/arm: Simplify invalid page test in
 allocation_tag_mem_internal
Date: Fri, 17 Jul 2026 16:22:54 -0700
Message-ID: <20260717232306.378988-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 905e9d7eaf..8f7a222b9c 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -133,10 +133,10 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
      */
     flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
                               ra == 0, &host, &full, ra);
-    if (probe && (flags & TLB_INVALID_MASK)) {
+    if (unlikely(flags & TLB_INVALID_MASK)) {
+        assert(probe);
         return NULL;
     }
-    assert(!(flags & TLB_INVALID_MASK));
 
     switch (full->extra.arm.pte_attrs) {
     case 0xf0: /* Tagged */
-- 
2.43.0


