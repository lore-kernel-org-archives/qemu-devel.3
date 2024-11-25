Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44268D59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFM-0005Gv-Ux; Mon, 25 Nov 2024 14:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFG-00058n-Cd
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:42 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF9-0004qU-Ls
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:42 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a45f05feso4467105e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564774; x=1733169574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88wZi6u0Mqk3kSDzeuh2IkFT8p2T9s3ILqB4KFRDi3Y=;
 b=hETvNF74qAZq/GbILjT55FJGJ0u4OClIyOZ3QKQbIUCrzuybXDINENsjBkHHcNzFh7
 /Np1ukBqhEpKZhvqmXBpuCQsbcdnTsc1xk6pEZ9Y8i7fwtQpWUOtdoNe092pxG4GLLCJ
 yWz2/OK4A/5VMwbfobFPbzrP6SIriI7CUWHkW+xjq9dAPJCZHb6sAOCKtxHSQzEaS6ht
 KWa/+OAeWNKiZ/Da3vXsTu0jTmszCKculo9rcYOgBisIMcw7ZpSr6QDBgEW4ci6gdJC9
 7rem+LqsftFOa1MDbMzOXRmx3mXma80p43IzID0j18g4WOqgRohIusKJj9VEgcXccN3F
 BoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564774; x=1733169574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88wZi6u0Mqk3kSDzeuh2IkFT8p2T9s3ILqB4KFRDi3Y=;
 b=RKk8ybdaTNVzUqsjdzHOA/Om59Xl4mFlfoIdWyiX9hXAB5xt+e0JBexXdmd7rFaUza
 GESAiFMyhV3tP6N8Kgzegt0ss0zRTpAxtyjnzAT2xPilfRBhNo1Xik50yo//PfEmLes4
 7prCULn0AcbTBvBU3vqg7gdtsFTShMcQ8EWdnY1ApNk7ITkUf1w33pLfdNIpFnFCe9eE
 ursSRsxIAqDmJ3w2EG6RaGf92rvN9GrsKCWQe6eRjBAAk8c7dB+rFhm2pxZDq1o305XN
 W/s6qXxThFRkumpCC6xHGPsqxhK+TVKweKbC16OuRjs/ucyFRv+dBJYBjOu+CV/DBCV7
 HX4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLS1I9bOf4urtrS2wakUhzAyxB9X7M1ciQsB9oAyuBMBrNdBDylr7KFJd1W9RcAKRTiu4iyDHCK4bQ@nongnu.org
X-Gm-Message-State: AOJu0YwrI5yzfT5CRhYw2sPXEi1ooraE5hhFw1MzWgvbqzzJ93UGKfWL
 elWGSKq9/A0K2BDQFJB0hhJwwNJ8G+7ZfTg46nm+Ty1XXV/A0N0cHbLk2lSlnHM=
X-Gm-Gg: ASbGncu6HGS/WEfDnSeHNBDOohwyGtmEBc1sKrBxZwJO+x+FSHmwHvPVS6lDEihO0yP
 SK/RM3WFKesOvzyRheMUYmYaeZM8s8Y+u8ZbS8mW+bMZsk8fCFCx7Gc1/P55QOeoyx2KZqpvkxS
 TYxFtSuJMUAYihsQuzfIYFxD1q5aRESuDC0UVkmcKg2xnjPLLwSR1ceTst/MuqhXXrwUR+m7FW/
 QyPkghle+9AadeydEV9IloSAgWydkSwtnwY6hckHiK+fOW6mSY3qQTMfAJdSIuygBAZ
X-Google-Smtp-Source: AGHT+IFTlfcnMQ8Q4NF57sJVKIYTBVoT9UNzBHBtzEnmlddW54qtujZLRGCe/OHa5mHxjA4P3prFAA==
X-Received: by 2002:a05:6000:1866:b0:382:4921:21b5 with SMTP id
 ffacd0b85a97d-38260bc6a49mr15718516f8f.43.1732564774327; 
 Mon, 25 Nov 2024 11:59:34 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:34 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 17/26] hw/arm/virt: Reserve one bit of guest-physical
 address for RME
Date: Mon, 25 Nov 2024 19:56:16 +0000
Message-ID: <20241125195626.856992-19-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x329.google.com
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

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/arm/virt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9836dfbdfb..eb94997914 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3035,14 +3035,24 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int rme_vm_type = kvm_arm_rme_vm_type(ms);
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
+    if (rme_vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
 
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
-- 
2.47.0


