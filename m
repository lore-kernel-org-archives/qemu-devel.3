Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47A3C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMbf-0002er-Ls; Fri, 11 Jul 2025 18:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYu-0007cj-Ff
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:52 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYc-000056-4y
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:33 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40ba3d91c35so1473598b6e.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 15:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752274168; x=1752878968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYyc4l1Ys1D8hkqY3d5nf+X4jsLM/BFSkkdf36YJhnw=;
 b=m9TVgoZHvKRcLh3g/xQNJ8h6rRCmdrahgH32pBhYN+UvZamoP3B8oG5Q57mt1hRSWc
 apAnF/H9EXVd1EqrMDSHzRwC7m5G9IsCAlrZOJvMQftybYxZ55+9jaGgZKt6dVBGiuC6
 6e9piNJ644/3J2sOaSVt8PZi892xJDxJHDEuCdEyvMpv4Gw+BpZazsedltIcTgsGW1Vx
 TpAyhG+NxQPRACpuYLxpq8YEQ1uMRplsO4zF31GK7qEunvAVMI/lp1dU9BaQT9uEpBIW
 ZVF2PWSW7agJqTGLB7BihCQWOX3IAUCgYmjf8j3AMVodkIeQdO0dgsP1XvyVtxlaHl0c
 /6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752274168; x=1752878968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JYyc4l1Ys1D8hkqY3d5nf+X4jsLM/BFSkkdf36YJhnw=;
 b=f/4hPUcad72e5YrDys3KJ28OhKMOMic8OYZ5Z6i7O47cq7gIZzcM82ZzXQQfyUHjnn
 AYLvC3lhtSnfJF9blck9IZ/Rc50LkAMwO6YndZdw7cAZMYqxgBufRQXZkMUFqK2VL1j9
 k6XeQNZ/1M2KkZtfNgJy0Nup/y2WGVtPRmsqp24ZQhfI9mdO3F9O+1fZw8fQtPwa7gR9
 3v1tTAXtrkSL7AjGfHZ1iAQUmm67GGPV2XkdSHd4QEhHmXZRd/hPfcTLHgQZ4gWeA1o+
 mul8yQDkGjZrVSTODXX4vCLRwgLaeSR/6QKqjEvzaOIt6OC2wU3BSwPxkDnnBy2Db18i
 kurQ==
X-Gm-Message-State: AOJu0YzuzpD/f2oeGTIP9YEX9NOGjC1pOULERSXMprI4wwwZsYmZ+7sN
 ZYpgBq9HfwwywYDRqzX7mS2UEytBDwLcZZEXWKTO4cOBglvURmAzrRJhTh6A7x/9ol1YzhFaeUK
 QjoCKidg=
X-Gm-Gg: ASbGncs2xEHEDN+VihQFc1Ln5Ku2Zacf+i6uTsukfe7MyzLfthtwfEb6tkUrkk4WSJm
 dPlse4Q0WdOUWftf5XdqWu6JOFKHWGxZ9LWg5nq//n6byhzrLPhl1/XHFjtHIq2i7csw6A0l4+3
 /jk55dx40O+uh+/aAH5u0zHKACzxQT5NX8syCCDs67qV8DKhdFMU9uow1dL4updMzye5Ebc5bl3
 olZBYhCbn6zNAfG+lmfNx+uRFOHsq2Mue6FTfF4eAAqd5gBa2lYLdHChLAkKoxRyN5AwKREFPA4
 wE6vmxYMEXrpHsAOkEeqF4m8kBREqzT6X6t8hEnLMWEBlHaRcNZxP8lfJP7EEK/+YuweOwY4K3c
 xj87d5T9x+vqxzxe3LtKqoXZH5eFBRPnLnSYfQEFhpwh3NxGDJMKcYf81qrfMG4+WIs4MQ6ZWfu
 Mx7tFqXrfAZh5DIY1IlbM=
X-Google-Smtp-Source: AGHT+IF+3kBtBrg3gzB3gMKCw2m/2p2GrSRGyXYjuDsb3AOQrJOytctWOPgwtDDckgfD/R7b3FIjyA==
X-Received: by 2002:a05:6808:1796:b0:40b:3631:f757 with SMTP id
 5614622812f47-415393d609bmr3399554b6e.19.1752274168000; 
 Fri, 11 Jul 2025 15:49:28 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c6064sm696638b6e.20.2025.07.11.15.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 15:49:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 8/9] target/arm: Remove outdated comment for ZCR_EL12
Date: Fri, 11 Jul 2025 16:49:14 -0600
Message-ID: <20250711224915.62369-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711224915.62369-1-richard.henderson@linaro.org>
References: <20250711224915.62369-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

The comment about not being included in the summary table
has been out of date for quite a while.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ce981191b3..8c8eea7109 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4548,11 +4548,6 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
           "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
 
-        /*
-         * Note that redirection of ZCR is mentioned in the description
-         * of ZCR_EL2, and aliasing in the description of ZCR_EL1, but
-         * not in the summary table.
-         */
         { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
           "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
         { K(3, 0,  1, 2, 6), K(3, 4,  1, 2, 6), K(3, 5, 1, 2, 6),
-- 
2.43.0


