Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0B0C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UTB-0006QR-5n; Thu, 03 Apr 2025 19:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UT9-0006C8-Ba
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UT7-0002bK-K2
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso10283495e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724772; x=1744329572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlgmqWinD7NQwKFSRiJub8ZlgVYRN5tlN02/pnlcz3E=;
 b=fjjV1REmAkE1mGQxGCUgyfu0FsZxFQAFLHr0ZGzywRmqGkSXvlVSzti66bmb3PYhDc
 qJCo628v+nZ6fKd8sWYsFY1WyKNVjL12LlM53in37wq5iHKORbDNqcC14yP4l9G0ESbb
 MKFsEDO5w51kdswwIssqjSm8R8hpmSW19qNuQTxPFdnYNvUx1wRAl28Ho1crAgU+QpyU
 z0++uV9NViPYPZH6NYYTd71p2FRdLJRayvLB/14px8/5TREbUC11PA7VmCFlhcVYthu1
 G0Dzoen2gPd3iTWnTqjjydWINvkMaKa3MWq8NtJLFtszCW3UaEZHztdXhoGokU2oB5DR
 4DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724772; x=1744329572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlgmqWinD7NQwKFSRiJub8ZlgVYRN5tlN02/pnlcz3E=;
 b=If2SELc7F//YYaqdkfGxoptAKZSsSqe+yyLWmlkckj768cvh5saHetPkoy6AU4HJXw
 GKeIYVTMBgSRrH95hiEM5FGyBuBOsA1rOFIir86D1cfIh/55zWJRO8eq2Swu00k8Go/C
 Lx2m2totYf2U2zaCM7GC59lg7oZkbRa1dnOxpxK5oOT/tZ6FoMI1wNa1cUQq/GUW8udK
 Iu/wz+AEYla+wGVnETtjNLYqITfAX7FFyM3PnJLPRKmv6Q4lqnzHN6l3aTe+l7EJtnCz
 ofEY6plBSy9o026OXycXCuBcGFF5ZlnhTC6UHG9CcIscO7hSMFQSoxhvdSPEroc+JrBn
 /EQA==
X-Gm-Message-State: AOJu0Yw/4XaQe0iY2iJP+myv3DMWInc12HE1+j6SA+dMDyaIS6TK1+OC
 hdE1C7SfnDVeNaHy1BrzlYUoTpWpRtTGkhP43OoFw25zGFceh7GuCgO8A+6Hmqct3KUR88msTcP
 K
X-Gm-Gg: ASbGncvuFLw5IOLfskQFYqw2As0m2JQGWgsVDmNzokGmY1wsg1y3dXnKxeSO0131vFv
 +YSVuc5Fs1E1s+V2fXA2J5h+ncbr8VMRMPj5Nq/933gUZjaivHoQs/uTNybE/LhMkZhPe9w22on
 3jM/OGMB7e8C/HANHuU+Sc9WIFycBaI/7UcTsy45dpzTeSwtESPpaqapt+fEToY9JNACIrFxKQO
 cV0KgmIq9HfD+NXhffCnJuMHEto+vghD0fwQaxs+9H70Ci6vez+DV0Tz1jGaWiWNF5wQgzal8MR
 G9VCnPHKKchc4FfRC3/LoiDcp55kFCuceOSKw2FT1vDR+oR7q4c6Kk6LqNF4kLmXhHTMGI75ga4
 p2j+U/vKCaGEDXfSg7oc=
X-Google-Smtp-Source: AGHT+IF09BhASywjAX5ZsiulAo4Rauvhlxk95gVgwmib999VxaYGlJ0y16uTLFiJbPYYkf/me8Z9LA==
X-Received: by 2002:a05:600c:3548:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-43ed0b5e285mr4975835e9.4.1743724771664; 
 Thu, 03 Apr 2025 16:59:31 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bf258sm30610115e9.23.2025.04.03.16.59.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:59:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 10/39] hw/arm/boot: Include missing
 'system/memory.h' header
Date: Fri,  4 Apr 2025 01:57:52 +0200
Message-ID: <20250403235821.9909-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
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

default_reset_secondary() uses address_space_stl_notdirty(),
itself declared in "system/memory.h". Include this header in
order to avoid when refactoring headers:

  ../hw/arm/boot.c:281:5: error: implicit declaration of function 'address_space_stl_notdirty' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
    address_space_stl_notdirty(as, info->smp_bootreg_addr,
    ^

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index f94b940bc31..79afb51b8a5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -19,6 +19,7 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "system/system.h"
+#include "system/memory.h"
 #include "system/numa.h"
 #include "hw/boards.h"
 #include "system/reset.h"
-- 
2.47.1


