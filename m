Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8CBC282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslbI-000496-J1; Thu, 13 Mar 2025 12:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslaf-0003Nz-Oi
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:25 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslad-0005f3-2I
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:25 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso2110796a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883962; x=1742488762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfpTTedni4gUGfvRcfnvXw4xTvY7JO0pNjOjXTZ7pI8=;
 b=qvkDh1NyR/+BUch47nSEhf84ofXc5JtK3ym6SEQmxx09DUmvsKTrDzxMxh64Njq+YG
 P/i3AWdaD5kVwy8CvnbJGFHXxQth//3mF5Qjy0PCP43vyyg0JgLcxAMOD2a0eZqO80O7
 GiUGR+rW0WTey8F7NitrorvOERTHkKlj6H7HX6uG9BPWVO18mOw+NOsCLuwjhp9XTJqk
 kIfJJ4zqCjxwEW5KZnlrOHsQuthj0T9PhIv/UuPSWQCSwXO336A3k87s22Wti4GcFJUZ
 O5W5nLv73KL+vZ9TCEhHeMJSCtw34SmRg+p211tJLcn9ojefT/0dFAPOUXFsoXk/epeJ
 enfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883962; x=1742488762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfpTTedni4gUGfvRcfnvXw4xTvY7JO0pNjOjXTZ7pI8=;
 b=ZDGk/9lW8pBDG1c/HMwbAK5xulHmyWziJrKRMnIVslKeu1LzQbq+hWP/uvHvOFBeZO
 hCvNoLvbRAZytTIGDR848N13ZjaRUrSYBE85YbKfen7d70kvuVkRMC49cjCy2np9WwhK
 HSfr4+L8vGEduKEuSbM2AhR9oOPkvfZm4JEWTF30IPUF5HaPnozPY46tWL7tGAMX8nj2
 j1MPhhzTiMbj3GuAOznxxomFcu9OL8y/6K1ELrpuMsfvTR5NoyC6hsd1r9fVDmk9TzMm
 o7kcUX30NcD+M/ffUTQVl4hk2kdcsjhzOPzHvifBQ+E8Gi3+B6QvwQHMhXqhBnhzKesf
 HLDQ==
X-Gm-Message-State: AOJu0YyOLd7+VhM1uV3aRD8GGphnjlwQv15u4gtcwVtPfPLc/1eitoeV
 k5qInUVMJC9yGhAktYP6uwVaCKUwK15bncuI9PjFYE2Ikfevff94mkk9HcdIQsZgqNRJooGNPs6
 lcbU=
X-Gm-Gg: ASbGncuCdKyZT+aZz3FdENyJYkM7w93Rgb1Bpu5dTyoAFw95pa4onWjhp36ooK/z7Kz
 zXjpLZVI1ktFUmrO87nATU/+pfaNKJmlq5IfCVzyOFBKZpKkSq0fpfGnfVutGqtnkF0MpByhpeR
 6hjPez6v7TGV8pYmUZIK4U7hqaUQJp61Y3v6JyBBBEh1OE/tRNr6TL3wPWeOi7aDTSr4S0TkjCI
 SZ/61IDyxYtIGlZKDTPfH9rxeBk0W38p8lJLZ7o034rIY6eT1NbAFuar1OD14mUfo2Wd6WLTIEc
 e1uRGwynY/sUabVrQtzffBZDiMUQqjxiTW6/VLCj/7x6
X-Google-Smtp-Source: AGHT+IGoee0FqI1pRrQ30nb92L6Ez6iWr624Iw9VfJKN6XKShQ8vco+xd3ltWnO1olhH1gK/7mxIvg==
X-Received: by 2002:a17:90b:3ccf:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-3014e8bff05mr210801a91.34.1741883961740; 
 Thu, 13 Mar 2025 09:39:21 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 09/17] exec/ram_addr: remove dependency on cpu.h
Date: Thu, 13 Mar 2025 09:38:55 -0700
Message-Id: <20250313163903.1738581-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

Needed so compilation units including it can be common.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index e4c28fbec9b..f5d574261a3 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,13 +20,14 @@
 #define RAM_ADDR_H
 
 #ifndef CONFIG_USER_ONLY
-#include "cpu.h"
 #include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
+#include "exec/memory.h"
+#include "exec/target_page.h"
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-- 
2.39.5


