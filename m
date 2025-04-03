Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F206C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UTk-0001Tk-Vt; Thu, 03 Apr 2025 20:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTh-0001Hl-NK
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:10 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTf-0002ix-P6
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso937828f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724803; x=1744329603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/hYdhB/qBclFHB0dhTATnM1BEowxhG26HVaZBLKHNI=;
 b=S2F0UDsbralmicgewmsCM8p6IW7gvnOU0KBjLYC3zgonowdBDmEhoUvyLJkWzUJGDy
 362KgGNWJE7zJOLo1JLhv3XCSQ6e9FkFkaWAn/w/lUS8aXUDjzU1URXVqezU/5moRSlV
 eWIfrdqSC54ptt/0uoAvvRMXCVra6XXkbS2vk0uPKAzpYHYIdsCixPFDq/DdvgkIPG29
 nNFi6AD/Kw66KQyF3vQ3bj+noqCEv3p/ymyN1gUND9edrQtja00pOUr72E+yKo2Ct6FO
 3fE5A0sjfBmVpN7m11d6pBq//tHKH0PD6OmzRZiuBIbP5YBZGOiDPM5ubchoe94lw7oR
 NVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724803; x=1744329603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/hYdhB/qBclFHB0dhTATnM1BEowxhG26HVaZBLKHNI=;
 b=V3WmDBevcXVhi+wKcBBfvWVK5ITTTZMvCXTke8p2XYjf3SVpnXDhqhzXd+ulSRbeLW
 hlzIWOHj2/uGCW7+TeYCDNcLef2vn3VTdnCikvKYS4cPQHcZ+Ma5BVhE4L9fPzMXjw+/
 plkqRkKt7An39eFA+MYCykP13wR1gtwAgmwmcsYmefWxJtNIz57McvuOk6lxaO/nMVI5
 zTt0aP9e5Gf4LoulfZZBKr5XxKvtJ9Aw/H/JXudnflzBv7omQiN4NfZudJYG5OZrDh7y
 5fzg9kVGwRNf0gqEOm7C6rF9/MDTXsvVTFKroLOQe0zaLdIEBUr7ue6JRvj2UV8cJwE9
 ZkYQ==
X-Gm-Message-State: AOJu0YzIJ7fvbvUQzeKPWBXc5YjTOD19bXPb5RyLdFmv3ls1DqYwlXjg
 BflgIP5AI+UkRofvkPY6fbLAlm/POHf2srci8GXtEl2sX+sqy0TKwAh/12CIUGN5XnLgI9kVZiq
 g
X-Gm-Gg: ASbGncv3ks/sZHQiGB7CP8aKiqglzDWfmWmNoEC2IefxlgwIMFS4leA8kldnFVGMnJD
 fMC8sPXLw34D1zJXEKdP90+A449jhgCdRUQP0WDTjtuU9TDI+XsbVo3y1rtWZdLgb+AxxPfWjlZ
 pIGhUzbXo7tMdDF06bS+nMv0IkF8qoz9KCmQUmm3lzRlyQ8BJhlHS8GCyyasgMjPuGiKH1tNDhW
 sZoqnrhRlhT0QZ3hiwLGsfaDCvemsnfxdAVPfOVT7axnnW3Y7UKeQj1KkX+VrB9r94cRAP5/WxW
 Dtchvmc3g8KM3mmUqSbezMSTNv6yduR/7SNcx81lPFCFW7phG8+mn6YbHdwRXu5/Z/iM5Kj6bOq
 YEOB6CzvoN8dI1zyE5io=
X-Google-Smtp-Source: AGHT+IHrCZUfK51c0Csq0xsrVSRro/RsfmTfFbp1yd57fBdVtfnQzNYtY5sfV/V4mbppUIDArGNMZA==
X-Received: by 2002:a05:6000:2d0c:b0:39c:1257:dbab with SMTP id
 ffacd0b85a97d-39d1476309fmr283778f8f.59.1743724803393; 
 Thu, 03 Apr 2025 17:00:03 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c300968c4sm3012877f8f.9.2025.04.03.17.00.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:00:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 15/39] target/arm/hvf: Include missing
 'cpu-qom.h' header
Date: Fri,  4 Apr 2025 01:57:57 +0200
Message-ID: <20250403235821.9909-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

ARMCPU typedef is declared in "cpu-qom.h". Include it in
order to avoid when refactoring unrelated headers:

  target/arm/hvf_arm.h:23:41: error: unknown type name 'ARMCPU'
     23 | void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
        |                                         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/hvf_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 26c717b3826..ee5545f2d10 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
-#include "cpu.h"
+#include "target/arm/cpu-qom.h"
 
 /**
  * hvf_arm_init_debug() - initialize guest debug capabilities
-- 
2.47.1


