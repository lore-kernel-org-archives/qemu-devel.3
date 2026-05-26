Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CEDCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyYY-00024y-29; Tue, 26 May 2026 16:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyY9-0001NR-49
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyY7-0007pH-MF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44b330c5cc6so8488238f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827929; x=1780432729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCYbJMob4vkCYkGheUetdxBZMcAjBWQS3OWY1ktJ//s=;
 b=nJ4eG2x0dojqfSh+rk8GhpcjPEEuZQ03uj+CoKqINBkdy1wDKYnO41zyy1ce2jHww9
 vS/jOO7U2TgJBtpOrDLcB5TiyDP3x/bbph2XOmnGrBiqIyTsGyjILfH3GF1g6HOGa5ck
 48hAfVsQCDT8N1EYRi76ZYRSfK1DfSuSlHC+qsKCUSFSX+F7kdcG3/J1iPQyy3SgQgK9
 6LhsMjoxlcpCdsZWt93U5fPe1UY6XvejR6euIbzF9l1HbjNgqMNxog4oMWxdhjkb/UJa
 9+pMVMQ+Vo2JiT2wCSD0eduQBhpHdTFcls5dfwrjTxSLWA62GtQlm75h6RQGoGSWn4vs
 Z0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827929; x=1780432729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nCYbJMob4vkCYkGheUetdxBZMcAjBWQS3OWY1ktJ//s=;
 b=Si32rvVjUbLh0buk4U2l/Sf+KoAocsLW0s4j86wB9Ggt/kMsBBLijI1n0nVQLUBYxI
 HK9KVP7l93X5IumrjUusLBo8t1qSvyi5Na19L4NphVwPwEBQQCW3BvT6mTSa8UEQZMox
 fjPQc4+b3bZ16ygNctofKfkoffxZm6QGcMGiW2ppMXOuATkoNxikhlUqoxhDOwcHquBN
 f1iDyIwqVkpvqidAveCWbjeREgFgMIJzZawe0FvI429xcFoIDxtGSShQj98cmj6DIVCi
 cTXdX+eOMTNJg/MLgK9iwsbqWC9L4oYBGvwHzUsubXO83nBmDTuvJQnVWei0EhTKpL9D
 nCoA==
X-Gm-Message-State: AOJu0YxGpDFC6q6mZ/Cnzo+XqWXxM4Yt6k9PqrSyiUBCdh2AzEsIkDbG
 WxQ4uMOnmIaV/bz4XMSOntkXk7dtxsA4ppPGpQPGRUvwAOsH5X5Qcx0+ETB4YFyVit8MW+sAZtB
 sVv23UsQmcQ==
X-Gm-Gg: Acq92OFrs+mCQUnh7qs2Lp3NO9T4HartS02Q/Tqg7Sfh4VR3gMTT8sgbZyLYkChYAHI
 pgI9Cw09DUYmyATDNJMQ+qMwaeZMy03ZyjHZtmmwB1/Cpg2PBPCR6BfFabB+WTSU/B2mZ1w4UD2
 aUA08OVEl9M6HD6uzLx7dqphtOMmtk6yVwXag6e9L7x5rzmjS1gCSYnwS2SvEILuBb/lJKL5SWv
 RkPquNAuXz13P/P8zhKgmR+x4pxbFHjO+Mr5HIvybBhTPhUtJdX6JHHr3xcc447Thyn59HpIlLN
 qoEDoaZjhWnxcY+OVp652QDat720Xi+cbCiKCxA7SFI7MbDM1o9Ai3GontyFJ//C2J3WYqrg23p
 w1RMVzd/DtCDCqgIzMWA0pG8ZNmhQ9iZrhjsSCrptAAYyxOivXwXkCfhOS5wTm05kw8LTu97pXH
 EvOXNmR5BmmHJVZ5SkUDuBZ5q9Zf+rixHOxrieCYLTiXMH/1YvkyRgaJo=
X-Received: by 2002:a05:6000:1acd:b0:45d:484b:ec10 with SMTP id
 ffacd0b85a97d-45eb3689147mr33073775f8f.2.1779827929303; 
 Tue, 26 May 2026 13:38:49 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b1a28sm735903f8f.26.2026.05.26.13.38.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:38:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 12/17] target/arm: Only set %kvm_target when KVM is enabled
Date: Tue, 26 May 2026 22:37:17 +0200
Message-ID: <20260526203722.79463-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index b38a78aac3f..7b2f09cf8ec 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -701,7 +701,9 @@ static void aarch64_a57_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
-    cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
+    if (kvm_enabled()) {
+        cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
+    }
     cpu->midr = 0x411fd070;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
-- 
2.53.0


