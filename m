Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52386C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtnD-0007qL-P1; Tue, 13 May 2025 13:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtc0-0000GX-3L
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbw-0003N3-Ak
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:40:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-442ed8a275fso7593625e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158010; x=1747762810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Yt1id2RxlQ9HmFh2CVejYPkAilxVPKGmzO8+uGHOl0=;
 b=y0MTgd2+hSlRFN1atAMenypXJU4gBRYzjY0te4ZAHs7qd0NnDPvYm5AME1AM0LeoaE
 PTsgGvh6Y0ORIDKevsaAXggpoSIL5L2NoidvwIVU7RwSHha6SSzVJipl8TbzZSZ6Ol3L
 hjD5/ANpsFnwhgrnK4MHRaBGGZCXT/aYydntJaVYYunJJlYkQN6psZxZCtD3zhIIENQh
 Kw+U/JduWLzmpmlRxY2Oj5wLp51bASdq++Wg1/g5CupuxiGvIPiHv9nt48LLdcBmN/1F
 XgkbeDAwJeLeOuAcfeWMZxXsQ3lT3XSG3ekYD/3U6i0Cu+sobv+W5WvE/aMvNkpVM0O2
 rLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158010; x=1747762810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Yt1id2RxlQ9HmFh2CVejYPkAilxVPKGmzO8+uGHOl0=;
 b=jUIwgZB5Jm71657+Qh2pdlg3t2KL8hhQa7SOhpXH5PoivCNNInZxnZt6F3w7Cb/ExG
 P4y8uOFMQfbeJkKVlbMUQjfuA2RrkG2YSN4+t+nZpRzFxIMECATD/Z+tpy7mZTEUCzWR
 SpAjYd6GGyp0S0pmJnkoMMUqFjTkSRFp04RN5xpP7rfrl4f10y8uNC3zL6vscA+U8DWg
 SyEmMpTgNiaPVka/YV+dNoGIf67JkRKPsXb0C+tKsdDUYWhNhkMqEIaxwg7IsyFJVAZI
 osHlS1tJsxSIsqAwLbUMtFzYZgd6g0tmTydKv2U74J2bGpKr7GQe2XWqEhIv2Cgctm7l
 soMA==
X-Gm-Message-State: AOJu0Yw7pnBryWa4+uhe2QAkzzw/unNZyzOcCr3KNSgR3ofGp2rbPpWL
 EwX6Y8UuumTkvAsQSgMLq6q0z5Ee2QLRSBmZxxgofJz75+LN48LlOQQug6R/bl2Rc/6p5lHlB7L
 Q8JA=
X-Gm-Gg: ASbGncuLjRMCNbK3OIHW6lutUBWrNAslQIKSuUWo6TaihK5CJau+BBmGmNKAieyiQEo
 4PCzwgyvqFzzNAr/rV8VXboiUYxofhp47TzqLtUAV/FDBOIM18DJy/VQc6VtqjaRlmHko06pLp+
 s/xdlLCq2drcqLnwf3WNDLrUwKNlzZyFdT5lWu5dbQRxkI3EM0YUbpLVpOpXdhuMQ5T333XE9+e
 q6saC8eBkxgz7LGvDt2XVc/2CTggtpppLExXFCv2e5SobJY4+HBbbkRLHgRALYvBdfnd/YF28Bk
 Jb+wkQXvMD9ecUXxANuDB5R4M0wdFE4ZqdgObkkuWORmM5DyxQ0ODsdvInogkpE90b/que6D/pY
 /IUzZy8jzyMHsmfT1X03u/vFXPDTC
X-Google-Smtp-Source: AGHT+IHGBB7tUbgk9f0C1lkMNkSEujNqHeKu3vgXEenTK4Rk8EJKharVRXy2ZXuKhdgERLBXIqJrww==
X-Received: by 2002:a05:6000:4023:b0:3a0:b294:cceb with SMTP id
 ffacd0b85a97d-3a34994f2a9mr127385f8f.54.1747158010084; 
 Tue, 13 May 2025 10:40:10 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2961sm16974292f8f.45.2025.05.13.10.40.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:40:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/19] target/arm/kvm: Include missing 'cpu-qom.h' header
Date: Tue, 13 May 2025 18:39:17 +0100
Message-ID: <20250513173928.77376-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
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

ARMCPU typedef is declared in "cpu-qom.h". Include it in
order to avoid when refactoring unrelated headers:

  target/arm/kvm_arm.h:54:29: error: unknown type name 'ARMCPU'
     54 | bool write_list_to_kvmstate(ARMCPU *cpu, int level);
        |                             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index c4178d1327c..7dc83caed5c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -12,6 +12,7 @@
 #define QEMU_KVM_ARM_H
 
 #include "system/kvm.h"
+#include "target/arm/cpu-qom.h"
 
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
-- 
2.47.1


