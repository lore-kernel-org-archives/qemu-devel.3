Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90890E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfgv-0007Rx-Pm; Fri, 20 Dec 2024 11:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgd-0007Gk-8o
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:12 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgb-0007yA-Jg
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:10 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436341f575fso22755935e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711428; x=1735316228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAijDkm3Xd2tCsSGiuQSmawH8n8MmwtVpeR9il534Fw=;
 b=wurX5ENkrgKeGP2CPnF1guxXbgUudEdWovONE9zclUiXJoVoPXjO03bnID7KXDuD0d
 onZWfCNTaWhd34z+RdJsREmuo+2snzC7Y21Vk2ekFq7EDUzFdif2JFyO/TIIZMXPAb71
 I5u7vag4uQQh5XkpZY7EYFi1Ef9hfjGDHxtAcaTmTrY+CmFKmhOPjb16VGVeSioS71Q3
 FsWguSyLNvh4BAI8LCib4DfTV027Zhw4EBRHa0LOjbfC2kLljMDhsD3uKOoVASCGRwla
 9sVLOVoyTaFo9S0ROvBBbHLEVNp1Ms2aeikr/2A8Tpu5nQR/uIP/6FLctgCG+Osu8D1c
 Y+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711428; x=1735316228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAijDkm3Xd2tCsSGiuQSmawH8n8MmwtVpeR9il534Fw=;
 b=lqE/AZVydwvRB5iMLiUmQx8Mz0NXvx2/DfXDXkl6HNunY12Tw2gJvZuObJRIcCVoVC
 Vz23NiizgAC/nAfIBSX9JlrRAQTrsYZsHk6EtwLoQcIAcppkKmYXzgdifaOZcfuwebWO
 0FOxCPNqC1nd+jTra11dpn3IDhst7DNwUpRkbudCr/D1aCj3DA0JoLtaaMbQ2FsdJ70u
 Oflr/Tout2jF3KYR1I7YQTNEjp1CRTdWU8Vger9uHEOrg/xrI9/j77EvizPxi9TYTWfL
 D5drMgaiuGXedEpuxTEP4e7gMy4iT77rQnlu4RDM87TKLJ7bUOUCnuT9zfL1/sH7mS+T
 0HyQ==
X-Gm-Message-State: AOJu0Yw+hu8rfjrpwhTrdzFCI6FFiSqI8od7Uv95YSFKGjyftftMfNP8
 OZQd4dHQMkO1XaJfLuuBF/Jb2kPy6b09mj1nddU7ACEdHWKe65wAzxj3CovX09sHMMmEzo4FN2S
 i
X-Gm-Gg: ASbGncv55BnZgHABAx6bWcHOfP8rQZCAO5J/MSQ3IgiG/rO2hJbRZf3maLScMMzMee0
 L4JJK9y5sp96JDBq2+Z0BL360tSGJLiPzRi+hfSx9MkfCoVf1Qwajq3k4wco8Ck+Y8ttclFj9hJ
 3phk8X3+CfS2lwNg+vvJN+V9md/dRaMFANNxCTTZpLWntWgRtEpJdGTw1Tom8Jsa10x59Ta2gVc
 QbBb9txVJMmKvCypf3VwwNB7S+UhWzQFUeDHHKn/vJLyQYSZcsM6vujnZgeTYjv+mKHn9MU8lk=
X-Google-Smtp-Source: AGHT+IEj5fIbZqWi6GL7HjXWm2yFhcEqTRRR8XiCbMsBCuoWbWgUsZPZLjM4j4w4kGoY3WHVKcERvQ==
X-Received: by 2002:a05:600c:1c25:b0:434:f4fa:83c4 with SMTP id
 5b1f17b1804b1-43668b5f691mr33173635e9.29.1734711427658; 
 Fri, 20 Dec 2024 08:17:07 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a62asm48908805e9.44.2024.12.20.08.17.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/59] exec/cpu-all: Include missing 'exec/cpu-defs.h' header
Date: Fri, 20 Dec 2024 17:15:07 +0100
Message-ID: <20241220161551.89317-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

TARGET_PAGE_BITS is defined in each target "cpu-param.h",
itself included by "exec/cpu-defs.h".
Include the latter in order to avoid when refactoring:

  In file included from ../../system/watchpoint.c:23:
  include/exec/cpu-all.h:356:19: error: use of undeclared identifier 'TARGET_PAGE_BITS'
    356 | QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
        |                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241114011310.3615-2-philmd@linaro.org>
---
 include/exec/cpu-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 45e66769380..1c40e276728 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -136,7 +136,7 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 #endif
 
 /* page related stuff */
-
+#include "exec/cpu-defs.h"
 #ifdef TARGET_PAGE_BITS_VARY
 # include "exec/page-vary.h"
 extern const TargetPageBits target_page;
-- 
2.47.1


