Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5DCC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkZ-0007AY-6k; Mon, 27 May 2024 17:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkX-00079K-Hj
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:21 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkV-0003cy-Tg
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:21 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f69422c090so106607b3a.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844759; x=1717449559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdSVTA5LkaFXZvFnPRCfopV2vzBYraHKbEAZY4LzgSs=;
 b=eeqSYqxzxeAkWyp7zNxiGwHrjWwKb3LkAZNz4be4ooObyrAH7mR1QT9fDEpVmJOkJw
 jkLZFziGFiiSZOqQo4rrwCjLRmvE4L0Mw0Cr42tJD+f5TOn/gdOOrrtD1517uvwisMH3
 EL2LaHzyvuEEnWtrOM1WNMWsU0ZFsO1vtNBF77T6CBNsUvqFY/ujA2/gcysqIFNN2vR8
 dCdgT7hs/Yv1kmdCsAhVBRqn/qHeFLqUGEHS85vlGoUi/vMO7jNJ9S68BembKnssbla0
 nvgptQHqaHu+dZ84jSucjhzxhAlj9vAcWnVAS9/db+Q8lwGfzbDvF8KT/P6K596tDH8H
 YqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844759; x=1717449559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IdSVTA5LkaFXZvFnPRCfopV2vzBYraHKbEAZY4LzgSs=;
 b=gtmg7oVqIgikJN0/eMyAhMd5swCrE2n0Q4non5Y1pKMOM+mh8Gy0KiuP3F23x7ZxVf
 9idWXi7lvEaowZXY1BzO/0EhseLhVDqhO5YH91TrSnRkNzqjU1YUDC1XqKc/VslXiUlA
 BnM7KuOpTUy3RSurHT8jV6WsUudjXSf4Gbo4gzx3lMxVjLOfU9rejPiKnkhVSJreCesr
 eqwuzsfsElC8lePFNflC6UqFmCUKdZlaZpxvxhe+56g90lJLFSRr6NmQbDZzSmRAvt5f
 bai+EZQYo7bdxzR9psg9M6dtHOllTSd5+JTLD/JJb3BQ7RLdmrIgFHeY9byhVDWbqu/K
 m42A==
X-Gm-Message-State: AOJu0YyePkON6jZQ7UEYJ3q27wU8lllYhpVMIUIVlRf1wbT2hI/dk/DV
 Zt+q9va/OYBmRkFEo9wmgVUUYewpwetjH1kLydfLf1pMszyMxgwH/c1zedeR7kbe8e5BAzbALcQ
 B
X-Google-Smtp-Source: AGHT+IEAKtEv/2l0SCfQC4ZPEfHammQtaKJfHylKfyFoAp72Y6vMq3ErFqbD7axSh16tP/qqdBdLDQ==
X-Received: by 2002:a05:6a00:90a8:b0:6f0:bb90:26b9 with SMTP id
 d2e1a72fcca58-6f8f2c576cdmr12702798b3a.5.1716844758703; 
 Mon, 27 May 2024 14:19:18 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 05/18] util/loongarch64: Detect LASX vector support
Date: Mon, 27 May 2024 14:18:59 -0700
Message-Id: <20240527211912.14060-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/loongarch64/host/cpuinfo.h | 1 +
 util/cpuinfo-loongarch.c                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/host/include/loongarch64/host/cpuinfo.h b/host/include/loongarch64/host/cpuinfo.h
index fab664a10b..d7bf27501d 100644
--- a/host/include/loongarch64/host/cpuinfo.h
+++ b/host/include/loongarch64/host/cpuinfo.h
@@ -8,6 +8,7 @@
 
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
 #define CPUINFO_LSX             (1u << 1)
+#define CPUINFO_LASX            (1u << 2)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-loongarch.c b/util/cpuinfo-loongarch.c
index 08b6d7460c..bb1f7f698b 100644
--- a/util/cpuinfo-loongarch.c
+++ b/util/cpuinfo-loongarch.c
@@ -29,6 +29,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     info = CPUINFO_ALWAYS;
     info |= (hwcap & HWCAP_LOONGARCH_LSX ? CPUINFO_LSX : 0);
+    info |= (hwcap & HWCAP_LOONGARCH_LASX ? CPUINFO_LASX : 0);
 
     cpuinfo = info;
     return info;
-- 
2.34.1


