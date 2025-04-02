Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55BCC3601E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 22:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u06V0-0004e1-6A; Wed, 02 Apr 2025 18:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06Ux-0004dT-NN
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:23:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06Uu-0002NE-I4
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:23:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso2281185e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 15:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743632626; x=1744237426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUYX2kXnCOGEv2tsFjiwF/vNelOghwEQOe8hhegma5c=;
 b=e17PYVKBg4+8Bqx7YckLknY4Aizh7GHFTzpcHSYQWM0IiiepDHiSN9AEp89s2woYuH
 j7WEikHob8vlV8pikYXZfHyjL/QZVbQO4E+TnWR7BG7jv1ox77QYWS1FjCpatWFixV1P
 BWVUvECsu7bvOYKuDURzjVu08P4BySgfTzBNSwOg7E8/yOALfT7+mbTReHsYlsW10mZ5
 nIklxlEvM9O3e2VJJ2wBdMMaKeL5/wsaG38N1kFU0w5u/9oFKSDjojTZ+rYcA17K+4Au
 JgSlpOZ9iaVEBHxkTPAbbZJ7agVez99HZ/g0Ple0+EUCCY6pOdYkkVCWHFCkZ96QRFwm
 jxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743632626; x=1744237426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUYX2kXnCOGEv2tsFjiwF/vNelOghwEQOe8hhegma5c=;
 b=kcl4oJgjXEvPxOZvzeM6VR2LycFsIQ2SmPGXLzwgv6838JmjD6hDnJ7fNdDhtdNNR1
 GabLg6P3S8jw3bDMpp07Eypzr1Bg3oeNxb09dxfW6lnUchM7Cic+Sob1eoz3Xylw5KbX
 fKY1t15BuEiYRPEy+k5c0tEgQ/pqipmR4/QR9qnIwMf3+8SVhssx98V0aCQud3WtWYxi
 GV6MsQHPGMHfFtqq774zt/mkHBT2ghFr9QR8BxaYhla0K9HCNVRbOPMC4gNsmz3EpkKx
 Ql3ZniQTdBbksq0P8FNRTapcm6VVpGfpfy3HdxdNeK7GKmxEoSqltuuAittSOL/zOd+d
 VPAg==
X-Gm-Message-State: AOJu0YzEFdZbjpOxbfqAvmcZkOQWdbSiu9yN28sXsGQxKwzlj41dBElp
 0OAT1p1ideA1FlnJGPkBcBwhXf9b6WRTBfgKHpnq5d6AttB3zRtCU9r7f/TLCnnGIVhlKejZbbT
 f
X-Gm-Gg: ASbGncvk1GD3rLA4CoCBc/UuXxZ/G6LqFnnwfl6ePM+/9RYgnAV+lkjBR+f/PIIdoxs
 avJ7LKrxCKFQC7FxYN4CsKxRtjHXnLhjbwi8TerLWUUpsdq5lFWODuI8T2Gn7y9di1v2cIb8Tbh
 3EzL/UvXwtwoykB5zvZPw99Mn3ZCvELldFinl60RhgrS88fMSPxkusGAb8pIoqcx5nrd7g7IUxG
 rESmJwpsD81VSILEDTC5i+2+QTw4Q1W89YRvvN9xuj6LVBxYtU6a0rkujn+XzNspXM3hIClGYep
 x7hsnQPZ3PMtqVEwwbyt45z9PtE3i0U+M4lat0rnkqnpnbN87a9QenBDpf2MnB72CuJ6O2mYvpk
 Xm9kNHd8MOS77rAP5KCs=
X-Google-Smtp-Source: AGHT+IEtwHSpAG7QgYFQ7vmzhyQB3sRtTE/nXTAQI8Daucjt/1LyUyNl5mVOFiMBAUEITZNWmrhJmg==
X-Received: by 2002:a05:600c:4f03:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-43eb5c2bee4mr34103485e9.18.1743632626544; 
 Wed, 02 Apr 2025 15:23:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364ec90sm178875e9.27.2025.04.02.15.23.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 15:23:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 02/13] target/arm/qmp: Include missing 'cpu.h' header
Date: Thu,  3 Apr 2025 00:23:22 +0200
Message-ID: <20250402222334.66511-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

arm-qmp-cmds.c uses ARM_MAX_VQ, which is defined in "cpu.h".
Include the latter to avoid when refactoring unrelated headers:

  target/arm/arm-qmp-cmds.c:83:19: error: use of undeclared identifier 'ARM_MAX_VQ'
     83 | QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
        |                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


