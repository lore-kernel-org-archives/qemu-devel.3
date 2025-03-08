Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659C5C28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38U-0004Zt-D0; Sat, 08 Mar 2025 17:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38R-0004Xb-0q
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:11 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38P-0005Ky-AV
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:10 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223a7065ff8so36670645ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474748; x=1742079548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6rq6CIIqovi+rqTbWr+nZgRpCqEfphmlSslf2GR3LU=;
 b=DflgUQCoDWKXKcXvnvw4tqTdDdYo4KGjwmnBsCj9inGEnKd3emkZx+z/y8txDhoCv3
 FUBpuy70zkzWL5y06ToF/FIQg7XXMEOFdcQKUTn7YUoSpZ1YhGbWC7xGBz5HCYHriVCk
 Ilhye7GGKnwyep27cWZMbYm8AC64y9OZR+p7x4o8t6qOeNjKROxfMLroH5O+ID2MRqbg
 zCCbEoiPb8aYAbdtKQUAxPzTzj2mxeY9Bpc5kJ7Wgs0GmOCutgwPwz+kW/KJFPgVgX/U
 xepqmE+GuXuenUin2cgaB3LDO/kF9q5Sp/y6Bir67w94NzKHygbAFFm+Cg5z0fAGCcss
 O54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474748; x=1742079548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6rq6CIIqovi+rqTbWr+nZgRpCqEfphmlSslf2GR3LU=;
 b=a1HXUXqUEPU/Q4IWIzBKUlLwnFEs1lxOvHZw/6XtAmQVkWjWKcQT+VHYQwxG8gVBEX
 fyQaAvzk0mD3cKdlIhONqvLG0pqVEWWTASLA26wDB3azulnoluhWcjFCj8gmfg1XIAtk
 uwloBMpfVsKOVAHMBH97xOXP1gKS+pNmyMTAMtP6DtfeLfYL7RMVuUP4OYdmHRlIf749
 7q9gIz8TKTLwVcN6eX8msyDRctCDFy0AlFVnvpMe6cFXffnJe0obvkp5dMOs3EFJJy01
 trxe7NtPP4FSFBsXHbBs/EgA2D+6jjoyGOZhL0wHFzBgV0DbqRcTiABl+r72EvjUvw+4
 UmGg==
X-Gm-Message-State: AOJu0YyWyxzLbY82Qn8tCaTJaLrtR10xieSDNAC2JX5cbfPs/4sRVhhu
 8/J80KMCcOqg6xWKYrrEj+5u6/tkMisYldcd0ehFsNnqDr0c07erHrNg39WZMoJvj8IVV7wiSXZ
 Z
X-Gm-Gg: ASbGncsAXL8uaS7dzYNtESJFjCfEMH07T8XReCqHweeD0KBMjH8mfDfgIMbR5qA7MFJ
 khv8hGzV14ciojXd2Fe1Zjs3Gq8K0YFXa4WtjOcJSKWFrBTwNvBuq39CFjzIAtJdc39pnMLkwGE
 IoI9ZGPnMTZr9D9S7K0yX3Bek8bexPRZmmZ7yd082MKi38zSzohIPrNinIhm93Ark/WFOkkm4G1
 kDcULZ/TVad88+7Iop1t9dghaV/VpxyLeYkkzjdUwsMS8pzAQORWYKH4p4N4ONZVDIX1zRBVGKa
 A9ljduAimHzqrlqvX4o/CNpzO3n9qYIIAlFJUH/PWVXRlREtTzHzWxqwghn1lUkXEG48H9gy8d+
 b
X-Google-Smtp-Source: AGHT+IH9sBytUo2G54lMu9pvtKTDQAQ/F4H9J3Vvvdj5UwQMkxdXJwLcG+KKosVlOsYEHOvzwk/P/Q==
X-Received: by 2002:a17:903:32ce:b0:224:1acc:14db with SMTP id
 d9443c01a7336-22428993912mr133533525ad.29.1741474747819; 
 Sat, 08 Mar 2025 14:59:07 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 06/23] exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
Date: Sat,  8 Mar 2025 14:58:45 -0800
Message-ID: <20250308225902.1208237-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20241114011310.3615-14-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cputlb.h   | 7 +++++++
 include/exec/exec-all.h | 3 ---
 include/exec/ram_addr.h | 1 +
 system/physmem.c        | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index ef18642a32..6cac7d530f 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -32,4 +32,11 @@ void tlb_unprotect_code(ram_addr_t ram_addr);
 
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
+
+void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
+void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
+
+#endif
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8eb0df48f9..f24256fb5e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -486,9 +486,6 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
 
 #if !defined(CONFIG_USER_ONLY)
 
-void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
-void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
-
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
                                   hwaddr *xlat, hwaddr *plen,
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 94bb3ccbe4..3d8df4edf1 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "system/xen.h"
 #include "system/tcg.h"
+#include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
diff --git a/system/physmem.c b/system/physmem.c
index 8c1736f84e..a6af555f4b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -32,6 +32,7 @@
 #endif /* CONFIG_TCG */
 
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
-- 
2.43.0


