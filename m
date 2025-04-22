Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB54CC369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F2B-0006sY-Hf; Tue, 22 Apr 2025 10:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F29-0006re-K9
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:37 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F27-0005By-Pk
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso3289522f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333727; x=1745938527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cjOcSs5mbhxyNi9CGbhSoHxduGzG92ImG84oID1+1U=;
 b=Mp/7mUk/8cT+MM5JtSSIFW1uzEclwkJltvbhWK/Eq0qU5ncjnN/oM+oesAVLMfVVhp
 aVSFLObG9QzdpHPh+PQkcQbaZ/TkNCjZno9+5k8efbN7cPVgr0JtMn/MG4XgDRmNWoJC
 vMQZf/8eG7yc5cSPKlkzkovVfLZrHnNLnLX52ddWVM/4Odk/1DCHnwhqVL93+3eSevKr
 7ZiTVQ6NntNZgeAPAHTtlYV2fD6O7budtVcMnS6ged/aonvKvXr+a87u+X4rFQC61dzZ
 ++/ZFTJEvuKUrd+ArEWmReoSNKIW+A0vH3c08EN1pic2SsUlUxh3Bq5xKQiRlmA/JiXH
 /zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333727; x=1745938527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cjOcSs5mbhxyNi9CGbhSoHxduGzG92ImG84oID1+1U=;
 b=KsdiUgsQXLyBgQB+GgoAOCQW/IKcfbwOGFeKuFP2nADE818MrHFK1lW6LW1o6HT+kr
 aX1A48nYMJq3zskLjumq4YlTk11MwooodhfMTRkNyLWh7swqt1755u9PWmcEwwb7hVkl
 24NNmCXspz8/28di2qG6qyH2HWNU0QINxvDpCWwWwwgrtA56lIU6oc64Kcvx1cTyQf/C
 BQwnEv068TJK8fL9WEQ+pZf8Er8HIEZvC9V6jkPNBJDnYNX/TW6urVt3jPAz+SbFpsNC
 lCFfpbj01+pem2of+9xZFYYcGp2vGdt5QXMO0CulVgm+7rYbPnjuK3zoUikc5tzZURQe
 Xbwg==
X-Gm-Message-State: AOJu0YzS5mYZiRD6/CJwTfv7NHMqFpCNFypQREX/bl6PQv6INl31+Hv6
 IdpE0eYb9+x1wDxryzQLnBa4m1Bm5MLvnwiif337+qAglRsfecdLiJqM3kXi+etcKJNxW9ZPoXj
 H
X-Gm-Gg: ASbGncsvbH4/bEi8zBE5S7KaiKIOTME+eeYbngNqfysiq6RECiaBdlboZqvAyVzcqwF
 oxyVOQmee67nzr4f54m8F9E4DxQtuMSrEKgBKtHbq2mIF9VRwdEIF8cnqJMbpedbypiCapRBYd9
 DAbDx8NNgMYq4hNAX9vwHcSY8PPnljYezOewnFY3laFWr1wPuUzeAucakwn+jC07PMJR2vZYl1W
 tC5JysNqqyT+72T2TtrybwJevua/PuDoHleko4WxfQ4b+MxsXyfbIEcudPraG264viV44jNhdVW
 wkkb3qrKANiwnSo8b2ln+cmiAKmrxWQZEupROUIKoM5CsGdX3iu1yYO784YHv+PBQ/gCfzceMyG
 rnScpoCrNYIqnClc=
X-Google-Smtp-Source: AGHT+IGqJNMJjehh3t4bgxyUR8vVPk/s4wkcezgNfgXbkKdt+uoKgxy4tcS3z8+UpUpX96Yho3iAeA==
X-Received: by 2002:a05:6000:381:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-39efba5f84cmr13052423f8f.29.1745333727621; 
 Tue, 22 Apr 2025 07:55:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a49b5sm15482164f8f.86.2025.04.22.07.55.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 05/19] hw/core: Allow ARM/Aarch64 binaries to use the
 'none' machine
Date: Tue, 22 Apr 2025 16:54:47 +0200
Message-ID: <20250422145502.70770-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

When we'll start to use target_machine_typename() to filter
machines for the ARM/Aarch64 binaries, the 'none' machine
will be filtered out. Register the proper interfaces to keep
it available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/core/null-machine.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 1ccaf652eb4..dd56d7cb7e5 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,6 +16,7 @@
 #include "hw/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
+#include "hw/arm/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -62,6 +63,11 @@ static const TypeInfo null_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("none"),
         .parent         = TYPE_MACHINE,
         .class_init     = null_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
-- 
2.47.1


