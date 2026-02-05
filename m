Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5415DEA795C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpeB-0008SR-20; Wed, 04 Feb 2026 22:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpe8-0008Rl-4g
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:09 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpe6-0007ZG-Dp
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:07 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c2a9a9b43b1so215258a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260585; x=1770865385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BP9Iqg4Qa8S8x0+sJHthJWxHpyosowqh56jgcdyTMLI=;
 b=sVqQtzPnY9BNQgY38tUOnirSWCpidd8bZiG3+6tHyfZT3a/syT4i1Ty1wcCDYj/Ema
 t5iOO2kyH7TbBIw1nnQJQl442EdXfhCUSg6QPGEV2H92wc8N8d63PnhI7WFun7n7Q8GP
 qU9EYwT2FVUMMJla6+f7RS1pOYHjcBz8Ex9o4YP9X1i4pbqGkJhZAnUkDN6tdYR+AIZV
 VvBpW3cZHV6usXV6HOmo/okn0Fu0r8S54XsVpODMSUVEg2RZRL+QOBhVJkL5WSVSQNz0
 CLUEvxq2tOPT31x6L+DYnyqLkQF6XtyZFZe81MrDAMZN2VSbZYLZQBLYbnofl/ifPTVj
 6cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260585; x=1770865385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BP9Iqg4Qa8S8x0+sJHthJWxHpyosowqh56jgcdyTMLI=;
 b=H2DUZBg6Uz5EFhr8r3CQCRI2Uf/22t1ti+2Jfj8bvx07daRZ64kQnts/rUk9LEMU3E
 NdHjsBuDvdH4Nzd3Cov451jWMn4kf0izi1hky3xofo0dvpzfMx6APFWiefmPRmpbfGmR
 emSqi9IRiiyUgVNc01+aLHw0ZNROD9MqkeGLVC09icJqex4fl/6Xou3x3vbNbqjji1M4
 1JFZB3pCYvQ6ePPodOOCuPvxEdKO1HpCw1ffp3AdnCeqMkn8yAlYsG3HHCfoPAEL2YZL
 bcC/6u2ZhnDAHM/pdS/Fn9kN4JY9uE1y/BMsaT0NoClNewbOt65J63bSXPGEHgqjaqik
 XJyA==
X-Gm-Message-State: AOJu0YxZDeyLdFmlG2CyT1UXcW6NL74Z03IysASsbmzno59aMQrxSdhl
 rMp0vps3H60uo5gTM5TzwlxE+jMNdl3RsLuXIEDmuWO0a+nDwcx+W1IuyXozRCm6sj020WNR7Bi
 17ZzNA7Ss8w==
X-Gm-Gg: AZuq6aLuPo6AFk5RdVwPj7PMN0c7eR0tjuaUuHv/buXk7iYalIVCgJp8yjJb62XlTly
 JHo2JobMZfZG/HA1cBNcJ7l3wEF3EeIL//JC7yyc4jTtz7ykV6RwaAewqEALPWpsvdZghoh9zcn
 mW4aLYH2+l7lYYxglPrCcE05gnIBFaRDzd9TfkuJk3NOzlcy7hME35X0XimdFCNWeVUD1nEM3nY
 90bxs59iR3eASpr0EUMOmidhwHw4dSBRKd9Yw6dJBJ0jXuwN/LFOCEaZm2z31Bm/mO+tRXJTUGd
 p6r1LzlXZaYGo9cUeS3KvbLWDQO5WUGLPU3fdleZcpkhx4O5QuMJXJ5oETgvhYd5nWVu1WPzprj
 nk3+WUULNQEtUAs94vMGu/RDzzPMXy6fszroZpG/k9+UIS60h2OOH1q3IHE2rPMq8CsJ1PhslSh
 fxRkN2UEpx/sv6pwlemWsfKaP5wAQoN0M=
X-Received: by 2002:a05:6a21:1304:b0:393:700:40f6 with SMTP id
 adf61e73a8af0-393725e2196mr5178951637.71.1770260584994; 
 Wed, 04 Feb 2026 19:03:04 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8572b4e7sm3395480a12.33.2026.02.04.19.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:03:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	shorne@gmail.com
Subject: [PATCH 5/6] docs/system/or1k: Rename from openrisc
Date: Thu,  5 Feb 2026 13:02:43 +1000
Message-ID: <20260205030244.266447-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205030244.266447-1-richard.henderson@linaro.org>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Also rename docs/system/target-or1k.rst from target-openrisc.rst,
and update all toctree entries to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                                          | 4 ++--
 docs/system/{openrisc => or1k}/cpu-features.rst      | 0
 docs/system/{openrisc => or1k}/emulation.rst         | 0
 docs/system/{openrisc => or1k}/or1k-sim.rst          | 0
 docs/system/{openrisc => or1k}/virt.rst              | 0
 docs/system/{target-openrisc.rst => target-or1k.rst} | 8 ++++----
 docs/system/targets.rst                              | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)
 rename docs/system/{openrisc => or1k}/cpu-features.rst (100%)
 rename docs/system/{openrisc => or1k}/emulation.rst (100%)
 rename docs/system/{openrisc => or1k}/or1k-sim.rst (100%)
 rename docs/system/{openrisc => or1k}/virt.rst (100%)
 rename docs/system/{target-openrisc.rst => target-or1k.rst} (96%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 208628cb8b..b739cd59b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -302,7 +302,7 @@ F: tests/tcg/mips/
 OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
 S: Odd Fixes
-F: docs/system/openrisc/cpu-features.rst
+F: docs/system/or1k/cpu-features.rst
 F: target/or1k/
 F: hw/or1k/
 F: include/hw/or1k/
@@ -1491,7 +1491,7 @@ OpenRISC Machines
 or1k-sim
 M: Jia Liu <proljc@gmail.com>
 S: Maintained
-F: docs/system/openrisc/or1k-sim.rst
+F: docs/system/or1k/or1k-sim.rst
 F: hw/intc/ompic.c
 F: hw/or1k/openrisc_sim.c
 F: tests/functional/or1k/test_sim.py
diff --git a/docs/system/openrisc/cpu-features.rst b/docs/system/or1k/cpu-features.rst
similarity index 100%
rename from docs/system/openrisc/cpu-features.rst
rename to docs/system/or1k/cpu-features.rst
diff --git a/docs/system/openrisc/emulation.rst b/docs/system/or1k/emulation.rst
similarity index 100%
rename from docs/system/openrisc/emulation.rst
rename to docs/system/or1k/emulation.rst
diff --git a/docs/system/openrisc/or1k-sim.rst b/docs/system/or1k/or1k-sim.rst
similarity index 100%
rename from docs/system/openrisc/or1k-sim.rst
rename to docs/system/or1k/or1k-sim.rst
diff --git a/docs/system/openrisc/virt.rst b/docs/system/or1k/virt.rst
similarity index 100%
rename from docs/system/openrisc/virt.rst
rename to docs/system/or1k/virt.rst
diff --git a/docs/system/target-openrisc.rst b/docs/system/target-or1k.rst
similarity index 96%
rename from docs/system/target-openrisc.rst
rename to docs/system/target-or1k.rst
index 22cb2217a6..b1ee2a34a2 100644
--- a/docs/system/target-openrisc.rst
+++ b/docs/system/target-or1k.rst
@@ -55,17 +55,17 @@ Board-specific documentation
 .. toctree::
    :maxdepth: 1
 
-   openrisc/or1k-sim
-   openrisc/virt
+   or1k/or1k-sim
+   or1k/virt
 
 Emulated CPU architecture support
 =================================
 
 .. toctree::
-   openrisc/emulation
+   or1k/emulation
 
 OpenRISC CPU features
 =====================
 
 .. toctree::
-   openrisc/cpu-features
+   or1k/cpu-features
diff --git a/docs/system/targets.rst b/docs/system/targets.rst
index 38e2418801..5b12858b21 100644
--- a/docs/system/targets.rst
+++ b/docs/system/targets.rst
@@ -21,8 +21,8 @@ Contents:
    target-loongarch
    target-m68k
    target-mips
+   target-or1k
    target-ppc
-   target-openrisc
    target-riscv
    target-rx
    target-s390x
-- 
2.43.0


