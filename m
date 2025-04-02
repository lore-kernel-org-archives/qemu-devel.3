Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9F4C3601E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 22:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u06V6-0004fD-8Y; Wed, 02 Apr 2025 18:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06V4-0004eX-3Y
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:23:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06Uz-0002OM-Ah
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:23:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so246606f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743632631; x=1744237431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IF+jDmIMfBmIbllVlD3DN4Sv3rGc5cOgP9Etawn2VWg=;
 b=loar4jw58EKWTBXcGk6UVTnz3EzihPh2jO70PJG1zjSKDFmqcWA0072iPYnKE8/u1w
 se+CTPWwS5vDuIeah3DrxgE4OFQTFLSmEd0lz8B98rA9KUxrBhWP+z+ZPqNMBUrmGsuC
 DJOj20dt44N7PLMVxAIoR7kRcmCUCzSUtl0MgntpLRzevVq5hNouC1o64xtm4hb3i1UU
 a5PpYXJ6auf5nFXybb37l83VZrwa/wY/MI5gClZST7oFLExMLHMlW1lSZJ1Ipnf1RiCg
 HpMUltzOOEvHeou7QZMaM+DKcF/OeD3KMS8a3/gYNEG2z4TV8wymUrfAvMyvEpGEjAfx
 dxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743632631; x=1744237431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IF+jDmIMfBmIbllVlD3DN4Sv3rGc5cOgP9Etawn2VWg=;
 b=BNEP7eA+lgKF3lLRIbYR3ZdmOBUkZA/LAI8tIK1MHdmF9zZ7pKC/ddZvRuv5GOExwO
 DSm2ss/fBO1+A3dK0Z30itMpImStOp98BgR+sz297WJ+yUiK0miHn6rSXNZOKfDytfEm
 N0trymtyaJwuYqA0gmKBVDmuoZzL0jEAq7LITjw2CKtxU+mXKAi5PrSYhKJnExh5Ye1c
 YWT4oCYpiQ1pg3s/0vGks41oZX5uB/GHCi37PayZPg3AX7dtnsBEi5W/XhrUiPwryKOh
 tfCA1VG/nPU/15h0dbsSqDV9vjAu71JOwVEY1mjEO4blk8fnEKLSdmYM74omj/LDbmsy
 yveA==
X-Gm-Message-State: AOJu0Yx3v28Xg6Am9An5gX6BX4zZ5eYCthR1KAYy20PwqdP5SQQhjRjw
 Q2T0tuCetbLVNj03NyqG0CVIPs9CWqfuG9L2JFeFHO0+2zM6Kgop5N+M0gPNAf43gTNDABdl7ij
 n
X-Gm-Gg: ASbGnctFgOnfdZB9Z5A/fOIQc2t+IRas3dOJ1CkNdrOtpJfwEpsmc30b18K5edDAobj
 fuA/QGt3ccfiV/Ev+5JPfKJbgnHXuK0sECEbzgeVgI8I+hR311eI9KM+FncaAkt5AEdoMKB0Cf+
 S7vdynjVb3Jpn9JNGnqDHlcCPhZ1pMfU1c7MuHPQcd8x/jTgl603m1Vas4l16wYrqcgouZXgpG7
 3Rhh9pZO9FIXzDb+wN+2D7VFn7eZMYkqQzY+bChdjYsLWARfgpezQkzsSc+P6DcfnYgo6LOWL9x
 rdyceq5lLoot7FaLWWK5ezW1tYBb7fGUt1r1bwqyLO/GI5fk/p48gJcPN7juX1Ktdag/9H4lEuo
 U1xX8xsukVmhneZTPXV8=
X-Google-Smtp-Source: AGHT+IGLPlgUQQ+djZlT+7GOh1vFK7EvhWw6x5xalFotDOccvKy163+ncX5/ZAqEX7fBoWEmeU6JaQ==
X-Received: by 2002:a05:6000:2706:b0:39c:1257:ccae with SMTP id
 ffacd0b85a97d-39c1257ccccmr10250004f8f.57.1743632631213; 
 Wed, 02 Apr 2025 15:23:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a895fsm407675e9.13.2025.04.02.15.23.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 15:23:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 03/13] target/arm/kvm: Include missing 'cpu-qom.h'
 header
Date: Thu,  3 Apr 2025 00:23:23 +0200
Message-ID: <20250402222334.66511-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
---
 target/arm/kvm_arm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 05c3de8cd46..2db2f060e6a 100644
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


