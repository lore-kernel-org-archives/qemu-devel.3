Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34538C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIQ-0000zS-Jr; Fri, 07 Mar 2025 10:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIO-0000yT-Ga
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:28 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIL-0008H2-J5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:27 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so192411f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360044; x=1741964844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y41BX0LJZfpDpcW2N8rAeN5eJqcWg7U9y6aGyYB7vHI=;
 b=cS2fqHtwq0T47Nv0BwJ5jerXL3UF4js+QsUGu+kEE8hg7rAnOlbfJY8i/e0xo5DPt5
 zLmkrpLgc/bukZ71RiWyBSwUthb9pGvrrld4gGv8+kVdMGSysu1Ysi6t7EeUQLqi0Y+x
 cQTRFbWJcaBgwOfDI4Bol3gRCC6JcwN7fTDcncki+uR3ibaEkf70cVWGuFs6mSOmSrQs
 ewIZMtwZc71TEaB66sByfOmJAy0HMSMalm6tCUf8u3zM2lr40deIOg6HOFIpYOGCLVcZ
 AWKxCj7FpCzS7x7az5uxy6yNiBfnXDR0Jks9XiENiaEjmtikSTeHTB91Fd/PI0vg+x9m
 n/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360044; x=1741964844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y41BX0LJZfpDpcW2N8rAeN5eJqcWg7U9y6aGyYB7vHI=;
 b=AfWF7c/bcPj3XhY0WUBxvUUv9xUjZgzoeKD5dRX582FcfILm6UTJZHR8X4ynH7Sxa5
 dlywEhz3lkg8wv1yA5H1nTFQQYhbPGiudLc6wxXpJrHudTsZ6vYub8wjEgBEHJrxmSp1
 +xfdTuslnJV0pXlTJpgZd8t1TEyMUA4hH6eputh4TSCslIXwJ/0s45euMQVlU1xqt9f+
 9ZA/ZP1lrZeFj7WjcQbrpbV0d9pCaoDIimpVTUNLmaYInlaC2kneSBwPWJoSiSHHrhp+
 Rf5ZHi/mcWFJKBkYCkg9P+36/kShbJPEUI/GqmmUkXZNeK7jrW6EJ51Hq7yJDG8kLSMn
 ayCw==
X-Gm-Message-State: AOJu0YyvejlGAK08w8MEwHYB4jsjWXr+ansP4Mt8v93bUaFUvnfqNCNi
 h9ongnk9xN8dDPWm9LgQVPDSFoqah1pVrMS5Rj+WeCj0zNsbS3wyiUtrRoal6AElI0jmGJ2FwVS
 s
X-Gm-Gg: ASbGnctMhSH/ByAh2ZpeUyalfCfc9dX/ttlULHjKhkhRZZMOd+8sVMxPQzRMYNrvsBl
 zS463jSNbTJhvzhvss1O1cw0pde1XMbvJp6dGY9OLTcLPysF4i29b9bw4Dr6HbvMsOGvW1NyEFq
 Z0MzEpSs7NtpX/RyZC8J3XfDUpcPJ/nrD9aY/p2/4skybl0uBhJL+oQk4DHh7XK8jxTQLJL/N9o
 C7RMSUeayrFIlZ5On10BJdh9dxb+jdboNC9i6pBJ4hz3JILpvc3B5OTfPUlYjfiMarv8cpi7fem
 3lukOsWgjaDXy9L7kyMzbYQ8FEWV6am7y7Yyl4IXeEwNHQoCUr4=
X-Google-Smtp-Source: AGHT+IFSd3bC3wHsvyi4BkO/+GbFn+PUqRcbDs4LMVOJtPClH/PegcJK+rLfHfEZVqAeVep86vdQuQ==
X-Received: by 2002:a05:6000:1447:b0:391:30b9:557b with SMTP id
 ffacd0b85a97d-39132d5a940mr2407754f8f.29.1741360043666; 
 Fri, 07 Mar 2025 07:07:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/21] target/arm: Document the architectural names of our
 GTIMERs
Date: Fri,  7 Mar 2025 15:06:57 +0000
Message-ID: <20250307150708.3222813-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

As we are about to add more physical and virtual timers let's make it
clear what each timer does.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250204125009.2281315-8-peter.maydell@linaro.org
[PMM: Add timer register name prefix to each comment]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/gtimer.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
index 0e89b8e58d0..d49c63cbf87 100644
--- a/target/arm/gtimer.h
+++ b/target/arm/gtimer.h
@@ -10,11 +10,11 @@
 #define TARGET_ARM_GTIMER_H
 
 enum {
-    GTIMER_PHYS     = 0,
-    GTIMER_VIRT     = 1,
-    GTIMER_HYP      = 2,
-    GTIMER_SEC      = 3,
-    GTIMER_HYPVIRT  = 4,
+    GTIMER_PHYS     = 0, /* CNTP_* ; EL1 physical timer */
+    GTIMER_VIRT     = 1, /* CNTV_* ; EL1 virtual timer */
+    GTIMER_HYP      = 2, /* CNTHP_* ; EL2 physical timer */
+    GTIMER_SEC      = 3, /* CNTPS_* ; EL3 physical timer */
+    GTIMER_HYPVIRT  = 4, /* CNTHV_* ; EL2 virtual timer ; only if FEAT_VHE */
     GTIMER_S_EL2_PHYS = 5, /* CNTHPS_* ; only if FEAT_SEL2 */
     GTIMER_S_EL2_VIRT = 6, /* CNTHVS_* ; only if FEAT_SEL2 */
 #define NUM_GTIMERS   7
-- 
2.43.0


