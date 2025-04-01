Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA813C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWhS-0006nA-5p; Tue, 01 Apr 2025 04:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhP-0006mh-24
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:19 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhM-0005wI-AX
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:18 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39727fe912cso1913581f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495014; x=1744099814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOHYuFnp4koozIqx1uCsPrUxKvA8s1qXFiegecsD2JY=;
 b=GKE3MOv8doAdvbWUDdV+pCxRzVt3L4HvMQ22iEYyp//akfn5TnA6V7jckO7eJgSail
 yEYYtMiVxEtJXqlIBr6g0f3VY6Hq5oIQ5pl/AeR6hbAoj3KUaTo9AWLJ2aqnh4RRD12x
 4kiCKhf7zeL7MF2Le1KGFTCMzHAJ6nAjqLiFS8xRnRDGjIMAEHnvf2pDC8GT8THVyiwr
 OiuYYznOlwrgX1a+lFPH/GKDCPB1TGTqt3fikI+Mx0tktfuSLZoXT++E+pIhfIR068NY
 1bwBQJMN9XJN6TtRJqZUoewATWEDXeoP1mPL1rDnZvxmaXihJr/3zld5/5tt10XaQK/h
 WSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495014; x=1744099814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOHYuFnp4koozIqx1uCsPrUxKvA8s1qXFiegecsD2JY=;
 b=BKvHNBgbF+auqC9jzny+en4aZlvD5SQ+uZeRhhR7ofzqO8i29sHGUBOOPl/HWJFuhX
 OdZjMYBMOgCTksnBmfaYt6JHXHejz6VGWsp/nwX8m4WBAszpXrh+abgZTHdcqPMt4M4X
 8aw6EyHD3P25JxCIYENLmmvoouahLVGjReRTEPkPLE2s6nrAXQGVMkU5y12F1nrffD1b
 FIBiJfnQ+8D94ofUFb8ogF5V1PV9nKB/3xiZoicxkJo/lHeMONKSFG376cnsy8v397YE
 Qc7wmOnwRK7cfyMKtWjKhEnbdQ70l/W+XKx5qxNRJ6ZPXOIyXTjNtONCkvZV6rFwZrzd
 mZOA==
X-Gm-Message-State: AOJu0YxaA46A/yGuGoycfdfx50Z0rUi3bkRbY+eTv3lAzv6sH0JbcXpS
 oKtBgNEHF+zs9SPBccmUySSfWOXvBx/+WQMtRey6lAYYDrbRJZYUB/ObwcmACwZ8Atv+2ShuOlt
 e
X-Gm-Gg: ASbGncsWHThCsw98nM8yoxKRxvozXVo3WzV1g0Qp1mIVeV+uKmjKuhi0gzx+g6mox1Y
 LmFaV7ytFI5cd5Aro1TFqDcPZYCLBjNyit3A6QUHzvBElwHQcaTTCXENfVI3tjWVFCrQ59VIDq/
 6Pm30F8gVMfp8IeZ3nEyyjRE9hjSNJyRtNYqaWuKwCvcZIBhpotxlRittY9M5fCYbtQzujXN5KJ
 FHv6OpXeAlJIhn525K/ASYBHhD1e3my6+SxX4yDHSsJ4LgU7dUD13pQl0tH+fEb1nJxNkGGrpOG
 tvGXZ1ZZbMl0T09z3Yb09+xTQnVkduJD3/p8HrrjoZL5dWWEeTy7FuBxwpMyjLmyL5hEB8CHuBn
 iWeuNAmjNc3MEefgAvp87KRkgFVIrrA==
X-Google-Smtp-Source: AGHT+IEwUpblceau/VUwUlPvpZgXaZdYfCSm7xoYW6y3V8ZLS0wVVIgmt0WvN9sSGHcbIvi57EyiIA==
X-Received: by 2002:a05:6000:1a8f:b0:391:43cb:43e6 with SMTP id
 ffacd0b85a97d-39c1211cfd6mr8560797f8f.51.1743495014350; 
 Tue, 01 Apr 2025 01:10:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dedc2dsm190349835e9.2.2025.04.01.01.10.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 07/24] target/i386: Remove unused cpu_(ldub,
 stb)_kernel macros
Date: Tue,  1 Apr 2025 10:09:20 +0200
Message-ID: <20250401080938.32278-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/seg_helper.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/tcg/seg_helper.h b/target/i386/tcg/seg_helper.h
index ebf10352778..6b8606cd6d8 100644
--- a/target/i386/tcg/seg_helper.h
+++ b/target/i386/tcg/seg_helper.h
@@ -35,8 +35,6 @@
  * TODO: Convert callers to compute cpu_mmu_index_kernel once
  * and use *_mmuidx_ra directly.
  */
-#define cpu_ldub_kernel_ra(e, p, r) \
-    cpu_ldub_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_lduw_kernel_ra(e, p, r) \
     cpu_lduw_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_ldl_kernel_ra(e, p, r) \
@@ -44,8 +42,6 @@
 #define cpu_ldq_kernel_ra(e, p, r) \
     cpu_ldq_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 
-#define cpu_stb_kernel_ra(e, p, v, r) \
-    cpu_stb_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stw_kernel_ra(e, p, v, r) \
     cpu_stw_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stl_kernel_ra(e, p, v, r) \
@@ -53,12 +49,10 @@
 #define cpu_stq_kernel_ra(e, p, v, r) \
     cpu_stq_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 
-#define cpu_ldub_kernel(e, p)    cpu_ldub_kernel_ra(e, p, 0)
 #define cpu_lduw_kernel(e, p)    cpu_lduw_kernel_ra(e, p, 0)
 #define cpu_ldl_kernel(e, p)     cpu_ldl_kernel_ra(e, p, 0)
 #define cpu_ldq_kernel(e, p)     cpu_ldq_kernel_ra(e, p, 0)
 
-#define cpu_stb_kernel(e, p, v)  cpu_stb_kernel_ra(e, p, v, 0)
 #define cpu_stw_kernel(e, p, v)  cpu_stw_kernel_ra(e, p, v, 0)
 #define cpu_stl_kernel(e, p, v)  cpu_stl_kernel_ra(e, p, v, 0)
 #define cpu_stq_kernel(e, p, v)  cpu_stq_kernel_ra(e, p, v, 0)
-- 
2.47.1


