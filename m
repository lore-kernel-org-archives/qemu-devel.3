Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D525C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthV-0002IS-JN; Thu, 11 Jul 2024 09:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthH-0001mm-HX
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:55 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth7-00063j-8m
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:55 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ee9b098bd5so11973221fa.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703911; x=1721308711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ypv6DeqQN8aPqPXZjj+x08m0qdLCJxHNVeV3KulHgUo=;
 b=bMmSzzbWEs0GuTwetUC+pQmT5yMA0vczJrFi3tq8e6fPnK759nxkfD2p8L9M1SMwkY
 Cuu1Yg8WK5VMd5zGW1aIlSB8NFrYMlEoybT4SsKDOJ3b18eWIgLD9CXyYe8CBPs/bI3y
 n68ZPn3CPSmFQ9zi5ssjNphaodr17kHbR6ll3OLBWHbg6n3vUoT92NpA6iEqLd3sxx9o
 Fxj4oX3laSaIz1NuINHXfkGtZEbrCioiNf4MkykiDxW/MGB2XNnEsw34yxP05kq4Fpgt
 l82HHAwQ5RZdnisCWlkRBbI0/OZWqpepsdkckmirW4S/KZ/PBBF9W5/XrIPV7eSoD5qT
 L+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703911; x=1721308711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypv6DeqQN8aPqPXZjj+x08m0qdLCJxHNVeV3KulHgUo=;
 b=QcTnt3WlUlyfGD3mDegxTUAXprTb+kIL5GRSh9G9djT31DpZoYTE5OQ5Je2tzkEhaf
 KG43ODNCAadmCesRmHuBBAYqdIPz5C3mPGHz2TAmGXI/BlQoKQaEPixIo2z+z0Euag5T
 BbwF8fhInKKTnOEycYwkPKkfTPFfyBjqzZpOgD/aDTWSJlf3lnKL5GfPR+bIrXVpk4Gz
 C95YVWplsIrqVyt6F/Yv23jpQ410IlNhpW8cICb0EDW6X71zOwHK98FyVNkcFTJQGH3l
 wmP+0k1CWRLPJJFD1sGVVSAy9lYWp0CRarB5rps9H8XyEQIzHCJGJ35ORuoExL5+SYOt
 hn5A==
X-Gm-Message-State: AOJu0YyxkfoZm0g6CGQ3ANGvXUcOeLv5zuSOhIUW73H1iYpI50MkN0bZ
 1zlUg3u6XzxKC6VdB07syKZ4466ude+kOv1f2lIR0/f6a4lA2iunBNVGaCtwXEppjRRLDWvIjwI
 /gTg=
X-Google-Smtp-Source: AGHT+IFjfHgou9FbBSRVIMw+7rJXa/nByzr6fVzzp2We+ViEMhWsPRR6hGyB/URDH+eJvvZ7Aunmxw==
X-Received: by 2002:a2e:8297:0:b0:2ee:8aed:ddba with SMTP id
 38308e7fff4ca-2eeb30b8ae7mr67114591fa.4.1720703910814; 
 Thu, 11 Jul 2024 06:18:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/24] target/arm: Use cpu_env in cpu_untagged_addr
Date: Thu, 11 Jul 2024 14:18:10 +0100
Message-Id: <20240711131822.3909903-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

In a completely artifical memset benchmark object_dynamic_cast_assert
dominates the profile, even above guest address resolution and
the underlying host memset.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240702154911.1667418-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4c656bdbb76..a12859fc533 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3354,8 +3354,8 @@ extern const uint64_t pred_esz_masks[5];
  */
 static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    if (cpu->env.tagged_addr_enable) {
+    CPUARMState *env = cpu_env(cs);
+    if (env->tagged_addr_enable) {
         /*
          * TBI is enabled for userspace but not kernelspace addresses.
          * Only clear the tag if bit 55 is clear.
-- 
2.34.1


