Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525FFC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByV-0006BL-H2; Fri, 01 Mar 2024 18:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByK-0005kj-QH
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:22 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByI-0004PQ-Nf
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:19 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc75972f25so24448785ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334437; x=1709939237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZykOOhGWRLaDSZ6ojBtzy1ZtPjktUdeyK8bHHdP5Cx0=;
 b=DWkDLAOe9yvqiTfCM4cnIu5qF8tD80IlrKfbJSo8tY8BQAYQjojg+2w9g7YQJ8vzW/
 4NTVEnaC6r2ypZbVHppgYr+OWZS5nGePxl9j6WHExQFg0u2SX+jlCpy0WUZTGggt0C8S
 M8VjBcJj3pYdlZDmJkua2Q45uoD24UmkkpkfpeRFlBiT2PmWLGuykxnlIZSOgLSDV2ZX
 z+1KctoGqBpdvvbUjnkaXH4OfsoSiQYGSIeQ2vPAg99laYs7DNG1FI3NPGAvpm5AWrWA
 wAAQiOTURA9gqmc0OF4lCOa1Amkl1CByUiOklbWmCi0Wp05wktA+Ejhxuhk9FSYbH/pb
 cBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334437; x=1709939237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZykOOhGWRLaDSZ6ojBtzy1ZtPjktUdeyK8bHHdP5Cx0=;
 b=r7QFK4r5lDC0u1lfK8PzSMiXXNcxrbKhlALNAyb5+N+XflzdivhT4adAubfPjGlqvZ
 027QTFbmt+i6BqWcvt5OvHGb2K7Y17rkU1UTSTo7RZCV+dU6q2JeqLTEkS0g7ousOVAz
 JPA7sPj88ZF7/H1fq5RyIpM1srcxlZxpcL9ah0FBtoZ9gDLgAcW0FGohviwA9J8euvBi
 9VwwyYQK2XvO9Z/Gm4n35lAnt/7VAvqElEfHnhCChll+MgQ7EWi+Qih0aPtP23LkUTeD
 f6TRTp3qanIFZtTzkvHuQdyDYUvhI/RCSF5gkd2pqF+PjhpmrSr5ZPs2/lc//VQlrZ8O
 xNnQ==
X-Gm-Message-State: AOJu0YyPm/D8zytqy90iEZ9tojogDSyaWUEX2LDETqOReMd95JJ0x2kA
 reCMPO9xDoHHYGjrc8GKQbXfsph6qM6456c1bJHyyrZjtNaL+EndHBXE8E3G0QzTBUU3xGfrnQt
 i
X-Google-Smtp-Source: AGHT+IF86OZoZ3Rfe+GsmlsZF5HNppORVwW6bpcfFX/cJ3PwyFux/96a+jFmGvZK3X+GqCaKOqGHYw==
X-Received: by 2002:a17:902:ea8d:b0:1d9:7ebe:431f with SMTP id
 x13-20020a170902ea8d00b001d97ebe431fmr2723459plb.25.1709334437481; 
 Fri, 01 Mar 2024 15:07:17 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 38/60] linux-user: Do early mmap placement only for reserved_va
Date: Fri,  1 Mar 2024 13:05:57 -1000
Message-Id: <20240301230619.661008-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For reserved_va, place all non-fixed maps then proceed
as for MAP_FIXED.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-21-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index cc983bedbd..1bbfeb25b1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -540,17 +540,19 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     host_offset = offset & -host_page_size;
 
     /*
-     * If the user is asking for the kernel to find a location, do that
-     * before we truncate the length for mapping files below.
+     * For reserved_va, we are in full control of the allocation.
+     * Find a suitable hole and convert to MAP_FIXED.
      */
-    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
-        host_len = ROUND_UP(host_len, host_page_size);
-        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
+        start = mmap_find_vma(real_start, host_len,
+                              MAX(host_page_size, TARGET_PAGE_SIZE));
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             return -1;
         }
+        start += offset - host_offset;
+        flags |= MAP_FIXED;
     }
 
     /*
-- 
2.34.1


