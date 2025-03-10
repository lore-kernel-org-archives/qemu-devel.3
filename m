Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85319C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVEP-0002xB-O7; Mon, 10 Mar 2025 00:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEE-0002jV-KJ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEB-0008Cb-Ic
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224100e9a5cso67677985ad.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582738; x=1742187538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8s25jeAGTcBk8xCVR99anv09nY4TtNOY1pAkSQYXuE0=;
 b=FT2AMJmHPXRPAFnTCSUvwxAyd8qigQBdwqs3pQGAweV0AAQUZurWGzj3Q8QReepFfs
 0wrE4ZHYegSPjEsl2gLm6ggHjt2CDd8Q8b3HmcOLLRTE56fg/vTxymABUKlabEZNhrVr
 ippkwC7tzKq9RUF0fDXlDcDYm6mFNbDadxh5bvYImksfRF/eUMS/JIp+cretcZpR/YpI
 0XBGpKQ9I5ZLKiYCtcRZuTnyGkL4XK277KSZb4B1LWZdyMK6th3nauVhMSJw0PMYqd+M
 Xn3vRjxy3ZsrpIiU/YwWwpa8P7gPk4dAfaNWbJC9y6UWiKeYOVkWFoe28EYapIK0mSrF
 eQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582738; x=1742187538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8s25jeAGTcBk8xCVR99anv09nY4TtNOY1pAkSQYXuE0=;
 b=chQOQa8XnZoa0mzv+NjkZJD+k0l5iL04Le1ZDltv+HXGFFJNzvdW0cL9s2qrGwzELz
 NL/2fhWeokcuyr5XA0eedSGDyYTTvHxzhAc3/B4Y2BHN/BTxqtHYB0idMHlvuMivl54Z
 D2DEw0U+XVI+IYnpQEFd+amUcCCN3VMt++59D+43Kdz2LzbbI8BeQDTOuX3Vj+dCBYOG
 kcJfeLmzanT7Lyq5lOsBUHD8ZTQ+3UUwHp9Chx7SGfMj4HY8V33SUviBIQ19fxIrz7mU
 6/B9Mn9Zfeir8miomNc9gE64IqbHLI9bdhrgLI2y9TFdKMp/iXAUDvmzM3trRwAZde/J
 HtnQ==
X-Gm-Message-State: AOJu0Ywuz0vwieBWgYF/0puuLhPN+OFqbA1V08StXgsQrG/+Q4syATHd
 5sFwubmQAxc+I0RLgkvrJTSfVhHcDkvuBQSnUYqt4nqoj9TpbYEVFnITsF2U3avaZ4a83BU956B
 aOJ0=
X-Gm-Gg: ASbGncvhPhWdi0cMYwW8HV65eZ/SQgrvh+FM81seakm0IGtV22pYS564/TZMb3XGwie
 ZDpNKNFOC73O7JF6hWdn+IeoHJpxuvXGag2ek2gbQrDvmcwpQOsXQEFcKrGiQP3CJFMhMXA+577
 cq4k//TVJj981Rws9dMdSESZhwo+D1nFY7UMjaw0uMo6RmHZXMuMSlqvGrWEgtFOu6Lq743vcuK
 foF1uSLtF7Rx/5LfjfZFwhZlU2iY+hcoAIno3+i0ep0L87ouZIvSpTzR1O2jsaA2VCo1dcV8Xa5
 cMp85PFrZZhMYLQlupmjf+hxsxqoSOv12+O0VJ0jqvibNm1ZAPnbhVI=
X-Google-Smtp-Source: AGHT+IGRoGZ7coEeYo9o9fE7YTKv7YM5Vcb8VYcCl0LtzUFuhPuPAIbAabhl/TEnMhgrans4FlUiUA==
X-Received: by 2002:a17:902:f648:b0:220:d601:a704 with SMTP id
 d9443c01a7336-22428a967a4mr181654565ad.18.1741582738292; 
 Sun, 09 Mar 2025 21:58:58 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:58:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 07/16] codebase: prepare to remove cpu.h from exec/exec-all.h
Date: Sun,  9 Mar 2025 21:58:33 -0700
Message-Id: <20250310045842.2650784-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op.h           | 1 +
 target/ppc/helper_regs.h       | 2 ++
 hw/ppc/spapr_nested.c          | 1 +
 hw/sh4/sh7750.c                | 1 +
 page-vary-target.c             | 3 ++-
 target/riscv/bitmanip_helper.c | 1 +
 6 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a02850583bd..bc46b5570c4 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -9,6 +9,7 @@
 #define TCG_TCG_OP_H
 
 #include "tcg/tcg-op-common.h"
+#include "exec/target_long.h"
 
 #ifndef TARGET_LONG_BITS
 #error must include QEMU headers
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 8196c1346dc..b928c2c452d 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -20,6 +20,8 @@
 #ifndef HELPER_REGS_H
 #define HELPER_REGS_H
 
+#include "target/ppc/cpu.h"
+
 void hreg_swap_gpr_tgpr(CPUPPCState *env);
 void hreg_compute_hflags(CPUPPCState *env);
 void hreg_update_pmu_hflags(CPUPPCState *env);
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 23958c6383a..18bbb1403c6 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -2,6 +2,7 @@
 #include "qemu/cutils.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
+#include "exec/target_long.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 6faf0e3ca8b..41306fb6008 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -29,6 +29,7 @@
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "system/system.h"
+#include "target/sh4/cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "sh7750_regs.h"
diff --git a/page-vary-target.c b/page-vary-target.c
index 3f81144cda8..12fda410bb0 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -20,8 +20,9 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
-#include "exec/page-vary.h"
 #include "exec/exec-all.h"
+#include "exec/page-vary.h"
+#include "exec/target_page.h"
 
 bool set_preferred_target_page_bits(int bits)
 {
diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/bitmanip_helper.c
index b99c4a39a1f..d93312a811c 100644
--- a/target/riscv/bitmanip_helper.c
+++ b/target/riscv/bitmanip_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
+#include "exec/target_long.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg.h"
 
-- 
2.39.5


