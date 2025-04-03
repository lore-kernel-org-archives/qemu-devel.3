Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86327C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UTX-0000I1-2R; Thu, 03 Apr 2025 19:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTT-0008Id-MJ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTR-0002g9-Td
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso14783705e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724792; x=1744329592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OFBiX6dxLbD9pkYgq+eZM6SlUvkzvFJZarT+zK7Jjw=;
 b=KKGPZbVR4BeJea+Tv/0PwDtOiwgF1zk76ZL809g8q9VdCh7pu3LKAM5vij/NOE7FtF
 rnV0aiZRJTne72ZPl0ccSGJAJUKr33+spRCyPSRNds7qtXvvj519rGMjn5xWrVLezvaS
 bsV9X9/5qesJKelW16plezbYeHYYPy17lMhFl52qVkEXLsrpW4yPYZyvgcDuo3xh9QI9
 LnLce8iBgAe8gfpgVgoN4PcY+iyEMO/5nelhW0OKGJupoehtLEDmSc0i+D0GKXIno7Ep
 QinyDn7EZZQggw9VLwuZreP7SDxByqWKLo6oneg7vDdl2aMZ353iFByMpSe9Ftjcb/lY
 HlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724792; x=1744329592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OFBiX6dxLbD9pkYgq+eZM6SlUvkzvFJZarT+zK7Jjw=;
 b=bkXTq1kDwUhU+5/Mv/VLMhvea5lLV3bDU8mIrQH+HeHl7v3uob/P8BdTdXV7KLClxU
 QAUG5uTPbf0arcVofT/TIXhtmQr7yRsPCbP4MeOsaXTiM8hWgB9miv6IduHwskC+wDo5
 gg0sDveFRnDIk5eqIGrP8YBX3Rdn7ye0QdblG+iXpOGZhAuwPyo6aq6vUQaC7AfHIUvM
 Y3WRY+cdGyvwCR0G/SBiMoayolMJwGLkq6BInNIVA9W/Jc02XTLYvSIPFwm6j6/Ba8cK
 1BZsykzbLEC5SMCek4VzhjKWce1QmEx4ArD6oy0zbZLM/pkHdTMNPZyZTiFid2ldcM2E
 K1Kg==
X-Gm-Message-State: AOJu0Yw2yGVAXn0zl+DGwbnRgO24ujbs/3g7FFAMwTUmqdeNfgoghm+d
 KCnK00HtXaEo8C83LEby+poZI7s4pqI5CyHzEq84IqM1GTKE+djhMOjic2Bo/QKKS7QrF8m4QmL
 y
X-Gm-Gg: ASbGncuGf/XMrKqVwNWPuQ7mjt1dIJEUjsPQxmtR4JnQxs4opvaSQJ2pj0DlaMDcIzX
 pz9bAag0/I+PF0+GoSFSFbW2VtJfNCLS1S4BvH4Qetg07sNFsgrbqWHen3hqc5XjPHXAgKzyAeR
 N6X1k/XvHCOXnvoxc9cjmA+53pQM9gXFPxQ1NwmJYg9vAkmH5yclBYA5ucGy4CS4uFBeOxIA8k2
 JEsXVdxh10FoTCXqrMlWT+d8RxSfA+B8friVoGSxfhFky6q5irA2AiavL7YMktTE2RyuAHb3sgL
 cpYx9I2wnPECyHNPBpDXCw1Xplst0c2TL3ZQRFpc9gR9LXn0RdxKivuFTE1Eq6ixrnwF0klUnOS
 6ioU+hTSaNmMOSKsQG6BPBJ6rKSlhMQ==
X-Google-Smtp-Source: AGHT+IHTorD2hQJdL+8jDrgkOq1FqnvDUZtDKohigeF7klfKKIfU2ua8y9nArv9AldSNdLi3Jna4vQ==
X-Received: by 2002:a05:6000:248a:b0:399:6d26:7752 with SMTP id
 ffacd0b85a97d-39d0de66ef0mr433854f8f.38.1743724791871; 
 Thu, 03 Apr 2025 16:59:51 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d6b1sm3023476f8f.62.2025.04.03.16.59.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:59:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 13/39] target/arm/qmp: Include missing 'cpu.h'
 header
Date: Fri,  4 Apr 2025 01:57:55 +0200
Message-ID: <20250403235821.9909-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

arm-qmp-cmds.c uses ARM_MAX_VQ, which is defined in "cpu.h".
Include the latter to avoid when refactoring unrelated headers:

  target/arm/arm-qmp-cmds.c:83:19: error: use of undeclared identifier 'ARM_MAX_VQ'
     83 | QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
        |                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/arm-qmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 883c0a0e8cc..d654be2a619 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-commands-misc-target.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
+#include "cpu.h"
 
 static GICCapability *gic_cap_new(int version)
 {
-- 
2.47.1


