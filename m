Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6154C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKE2-0004Io-8V; Fri, 10 Jul 2026 19:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDn-0004HO-J9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:29 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDl-000325-IB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:26 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so1545860a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724484; x=1784329284; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tmlZevgFhXIJJdsn/GrE/B6w1KsZRwMA3LkvTnWXOzc=;
 b=x82bXm78jCtDGgUp2zvNUrs1mavV+rCj+aeMAqY8JVCXxdDfI1jeMZwILxg62UHeCV
 t/kf5uw/0rrlytqNOuQRUJKGDmlrKV2Imtsb9mWIQYQl6d7MrQ0H6v1prZK9jrOgL6xf
 KgZdS/CjYtZgjxSKFRWT7N3/toN+tfobH/BazJ0n1SN3dpnAplQCmYF7MDq8mvsD9lu6
 LQ4XLaHmBJ/TfT8F8sJn4G5St9LekF3LifC1i2qypnaE4n/RF2rCF8BHL18uWZvXO3xJ
 nI6I/R6HGP0Y2dLDDF49X/V0Gm24drLz3qFBvDfh2y30MXC3/O14XTS0SqOSbRb6ytE3
 IZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724484; x=1784329284;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tmlZevgFhXIJJdsn/GrE/B6w1KsZRwMA3LkvTnWXOzc=;
 b=NlNcGhpa7a1U388RLz7a7VvIczuC7xAdbfunzOAFMa73NGX74u78gUwMFV0bNcZua3
 kK9wZJvh4wgwWKCJzkNIifQKMcb4JGhLu4HcEmKRb75Worx5Q6DIbJERwqaviLo0FD9O
 sLO6gXBh82PjroXJkANidui6J90fHH41Xc85W2xPJIed/vDKEFpKTT/5EAxAD2fsEqyq
 56ZtP5gREv2y+NMbE/VQTwHutmnvDw7s2LZcXWHADFISYctpJ5YRG7hB+bYO5K+aREzE
 e8phhoN9xiUTgT/PL1JHakYU20+ndoEVAIoEIn6av7tBZehLbmC/TgNbwdVoNf4tsWA4
 pcIg==
X-Gm-Message-State: AOJu0YyJcn4PdL3IkoZz/up7EszCQhAU8GO2FlBnSQnQDEhlvlpE/QQB
 S4eGv4JHU6tAgB8pKlM8C3KyuDK9CE+zOSWo5zsrPhlluq5wzFbSr1C2qgnbjuJPM6wZAPoYiVi
 Pg3X4
X-Gm-Gg: AfdE7ckcOMS5rnNDaFP0Fzk5oabRGAqHtkuxFhjkga2TKEqdcn45P9WrDNuWjtgQZ9u
 vqE7XV4YFVPvNvsLetsJyXnzSR+IcIOMc1JbOR2TuyvlztBZ0VgyoPBDEnpZUtKNkIRqiB30R60
 Ydp3O0KOSXE2VYy/TOu7YKRtuEQGvRNAyBXMH9v13iD9jfQhUzNK3bd4M5yiIhMNzciDijhku0W
 qEjFPBpQsN9xiNKumkAomRu20+Ad0SxHs8QdY81BQZqg9ZKElXDcq7hdq61pxpabrrTAybk8Av+
 OAYlOkkVY8wqu4Gu6H2qeBiNJtrxyNxIPsy/UVObseFZWAjj6THRLZC8OBm4hh6Hqxv/stk33uG
 hRqDs/Hiw5AVhdyG9K5wtra/g8bqYT/YZePUQ+0EsS2GRrRVWP1KMVdYfYJs6p7eJ7wZguLUIwk
 CFJeLa5T0HslNBBHbYjQ==
X-Received: by 2002:a17:90b:2242:b0:381:85c0:1d9d with SMTP id
 98e67ed59e1d1-38dc777b8b5mr784324a91.27.1783724483754; 
 Fri, 10 Jul 2026 16:01:23 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/13] include/user/guest-host: Include missing cpu.h
Date: Fri, 10 Jul 2026 16:01:11 -0700
Message-ID: <20260710230116.900171-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

This file dereferences CPUState without including the required header.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/guest-host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index ef83ad8a18..506efc097e 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -10,6 +10,7 @@
 
 #include "exec/vaddr.h"
 #include "user/guest-base.h"
+#include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 
 /*
-- 
2.43.0


