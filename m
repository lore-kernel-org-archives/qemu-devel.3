Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CBAC3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5Br-0001ev-Bw; Mon, 05 May 2025 19:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AX-0006yt-9b
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AT-0003x7-NX
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:16 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso59580825ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487452; x=1747092252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsZT/scaGxab+Vo7Y7hWrcYUC7iBy9GgtXflG2/7Eik=;
 b=Lv3O3SSXxd+pqn8+ybQFRsShC0uBSKS5bf1kY3Kb+sVEBjLD2IZN8WVo9teAc/dbwv
 qBAU/M7/3yc+SBcJzweWgHpYaHSStNT/KhbXzLCMNtyXQ1xASk593x0FVnlI21c2lBlT
 t8NH8QBeMYHtfIGBnaup6FRuABK/dvWSCL1sPN1LDT/fZQa22xyZ/0i0T6gz831K9nzf
 9ZHI+NZis/eIYzeKyrM9kHxZ5DkWkWK8VUMBvCvl9sGp+1mtDyicErSMEuZV5OPuPeww
 yvm4f0ia7nR8+t6itN5KZlQCpa0EKdhEst7siMX+5fdczupriM8GfD005JgPK7Xo/ttq
 ZcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487452; x=1747092252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rsZT/scaGxab+Vo7Y7hWrcYUC7iBy9GgtXflG2/7Eik=;
 b=YSgNQbLRd8gi+uNpM6VKh0Cp6jXiFxwrEv9GcuAxA0izyqg9Ohv+1RrRFrxIMRWL6+
 nfJjlTqEuPi96ty+hhutirjiegSaFqTvbTZHfxLJuqaO3iBaEdX2WvUXBKBjphIsFOS+
 YhpA9998i1sfnQ1H5yR8GGV/tVsI7qtfeWy+U8IcfhIKhyoAkLxEXKKhQH6S6t/EHVJI
 /r33Y270lAJr2d9y+XwGL6HUnk/lXWLZ97ALVS1VHZVSLdJSySAVfl+f+lyijtH2ZDOm
 Ex3KrNtSAwWbfj4ST5xAngtIzNxh+AZAryApPo7hoOZh2cEutHTQZkG9AJpuBwADP3HH
 tgGA==
X-Gm-Message-State: AOJu0Yybgyhdn71ualRMgSAtv4EHZthzKZgsn2BgDdQq3bj/D2oZjjtg
 jURGzUIUvd5olYXkrL8GGfouXhKeUHqVeT05Pdubj2adT6zVOP/R2m40gCOWdR7r6AIiwBltdvQ
 eSbI=
X-Gm-Gg: ASbGnctnLcx1h3oQJtxEoYIPpJJTA6+dyRuNB8hsQCo1JDax+R5qFhln5IKJS+Ji2jV
 FfQs/ug8JyTQmBhFX8Kzo7FRv1I+1eFxZJWkXDI/Mpbshvy67SkMRUds5iuQslo1PtqeVMEoiKP
 i+9B+IJlbCmZW/zlRQ0ES0Y3ulJ39CSpFWWfuLGwdUZcXv5IsS1K/YKbTPkXfgVvh7XkQ1ciEYe
 tA5hOfI5+cJST6XTctw9VdJjeIbctTngIfnV0GqZX9PqZ/RtFwqhTnpSO+XCWUdNCWhDcvkR4aj
 8LPgS2+Yi4nPtkgUsxQgcaq/OVn4uZ5y1vvFklmqLiDzqQYiL/4=
X-Google-Smtp-Source: AGHT+IFAhPucFlkZ11OgWLPowthveQnohlxYQE/0ZLy0irLJH4rJEHICQLoX26yFH/+v+7ZBHx2EcQ==
X-Received: by 2002:a17:902:fc43:b0:224:1e7a:43fe with SMTP id
 d9443c01a7336-22e1ea8de5cmr133671325ad.46.1746487451718; 
 Mon, 05 May 2025 16:24:11 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 44/50] target/arm/tcg/iwmmxt_helper: compile file twice
 (system, user)
Date: Mon,  5 May 2025 16:20:09 -0700
Message-ID: <20250505232015.130990-45-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/iwmmxt_helper.c | 4 +++-
 target/arm/tcg/meson.build     | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index 610b1b2103e..ba054b6b4db 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -22,7 +22,9 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
+
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
 
 /* iwMMXt macros extracted from GNU gdb.  */
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index cee00b24cda..02dfe768c5d 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'iwmmxt_helper.c',
   'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
@@ -68,7 +67,9 @@ arm_common_ss.add(files(
 
 arm_common_system_ss.add(files(
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
-- 
2.47.2


