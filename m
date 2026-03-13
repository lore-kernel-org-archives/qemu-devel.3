Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4466A106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vv2-0004eQ-PM; Fri, 13 Mar 2026 02:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vv1-0004bC-3q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuz-00072w-Lm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso15062015e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382960; x=1773987760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7rguKCr5y03w/Pn27WjMwjHblPkkNdIBPopkPh09oA=;
 b=FRYx4O259V60b1EfcYkb67tRYJaBh7pdr0WQyL1zATYYgGkXQLUgBaLzu4Oubijk7u
 cUXaFOC5aRH5rFeWtdth2qCad4ZKjMvH3l063v3qLp1q88bGHL6n0MCkjV+wylt2PiD6
 v9irynsx21Xc0+cnP0Ze366Cotrzh1mPST7Z4Th0S0QnZ320K+vSLx0RFkzDq+/El1RG
 DzqHVI/eIF5a2g+WR0Mg6gPcsa0ur1M1buVx86FFaDi0hY02z8aQYe/TYvX/0qB9pV01
 01QPhAMZWAaziYXmkFHtu3vlLAtIEsdyKMw058lf3/3MnCMgP0eA+LKfypFP76qE+Bu9
 qPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382960; x=1773987760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t7rguKCr5y03w/Pn27WjMwjHblPkkNdIBPopkPh09oA=;
 b=oeTRvN0oOTKoKArkkqf13wNnDC/PyPFkInQP3P4+/TUL5nnn5A45Q6od0tix+tFx09
 V+q1HjyYLCIj6THrpzTrHWUpR9LofIhTX35DnPoJCHYTaqZscG4VVXOA5udgRDevLIPB
 lpkRS+vGFJL5BWyb8pDRbzpaO1gDsMs9k+7ZNw+BALCeNdzpNzb9KCRbupihmuL5oCk+
 EEpSjupiUMyLSHgTG75/DGvC+NxhXD2UiAQwy9DdDqnWF/MEM1y0YKvSJ8+VxCzadeTC
 LrXvf3HCsMMmq2cle3yaeshu/F/QQ8iSqgQT8hwM0jvVZbq246z2L5vyqr/3XFkLv1tf
 PzQg==
X-Gm-Message-State: AOJu0YzlNaWAhXILAqHZZTIuWrFBOnrjQ3Km/iYJXdnsJ/3g1Oxrt9z2
 cEGgVVvWiCyCYyjhKiMlEOtxn/jeXx90p8FIAQ2lbhZVxJiaxEXTkohQkalftS+tgB/eFqEhOtS
 0cKiMCW8=
X-Gm-Gg: ATEYQzxqRjjGixK6TYl69UplRJPdTRv35YsNbAql11c81nBD8jIPZxrrlsaN2K00Rr1
 mLuORUL18VGmIDe4YnI7LyTOtX/+/ZfQIQctW9LRiiYhhjhmnJYTywB1G8Rxhx2iHicPE/0jPPe
 2MowM+txIVYVxAEIYDJRgAix7XbC5ygmK0yBaPw+xTKga7dGKUuHsbtx6ycJzIgSDMY/Mf2sbCe
 sN+LmNY9i4Ep94rGbu7MExIOwGmIwgLde06LcxPcv+hS0YDcmZAHmf8/NJafu03E7xh/Xv/NOcl
 YF3xu+dpwy6bGFEJ4Uz6o4M+TVi9lSQLy1NzW6mvjFgkIsgiyfwgVzPZLaMCsafljnCAtj7jT5r
 5WHCvcjMnQG8b5Owia2vBLULAWnJa/nUMD1WIhzvqn+G7j6ZixvXGZ+56g5+vuL2qfHPFACA5P9
 exmOaBsGIRENApHUls823RRqvhDqbPpgQH0GR+r8jLttIzvXDpTGzEsmU7vZj5cSbPKV0owyT+/
 WzMlg==
X-Received: by 2002:a05:600c:698e:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-485566ca5cdmr30394575e9.6.1773382959876; 
 Thu, 12 Mar 2026 23:22:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e912fsm495616355e9.2.2026.03.12.23.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:22:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 15/38] system/kvm_xen: Include missing 'exec/target_page.h'
 header
Date: Fri, 13 Mar 2026 07:20:31 +0100
Message-ID: <20260313062055.2188-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The "exec/target_page.h" header is indirectly included. Include
it explicitly otherwise we get when refactoring unrelated headers:

  include/system/kvm_xen.h:41:55: error: ‘TARGET_PAGE_BITS’ undeclared (first use in this function)
     41 | #define XEN_SPECIAL_PFN(x) ((XEN_SPECIAL_AREA_ADDR >> TARGET_PAGE_BITS) + \
        |                                                       ^~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm_xen.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/system/kvm_xen.h b/include/system/kvm_xen.h
index 7d0e69f1334..ed8c357193c 100644
--- a/include/system/kvm_xen.h
+++ b/include/system/kvm_xen.h
@@ -12,6 +12,8 @@
 #ifndef QEMU_SYSTEM_KVM_XEN_H
 #define QEMU_SYSTEM_KVM_XEN_H
 
+#include "exec/target_page.h"
+
 /* The KVM API uses these to indicate "no GPA" or "no GFN" */
 #define INVALID_GPA UINT64_MAX
 #define INVALID_GFN UINT64_MAX
-- 
2.53.0


