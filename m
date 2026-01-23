Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD86AD74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjInG-00070J-NY; Fri, 23 Jan 2026 10:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInD-0006xz-1t
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInB-000305-Fo
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so24432695e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180983; x=1769785783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fXiS0gXaJKLHeJaB2gpXG9fi3g1HNSXjqN1jMBdY7BM=;
 b=XRCnX2Azu80ebOKdZ94KvxWigUTNt8dggxPIZLY24hEX947xykV5HwpCi6pZBtHuXC
 URtTprt4OSwj2YBwD+Fgz3RZZ1rFG4s7rwOjyriZ+YN9PB3iYeyLzUuD6B7uanV16glj
 VjJuXcbhbKewJ0y/al7goHhtpBjHad000bk0bn7Nye1aeZAu91j6Qtd3/oookMXwoOi9
 1IQJPgISYoARhcFfy5pW1ZD7zTd2KYmH5SLJnhqiYnHkcL3bH3OW+VCwpFBvCrsE9p3A
 +Y9sm54eIs/uW9qv577ly5QCfXnZQtlGq9bsLJmGkgCa4OF/1PO3iOQTowZBhV20fPVY
 Qzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180983; x=1769785783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fXiS0gXaJKLHeJaB2gpXG9fi3g1HNSXjqN1jMBdY7BM=;
 b=hIu5EeGSfzgpBjgMzDec6K3J715ZWSWzGcSyWzBHLp3q3/ogmxm2AFNvxfTzCnWyJO
 Rr4LLap3ix9lrdsn4hzeB7gKNibDc3YuJoNRcXq5cqtEhj4Ki/EcnEV+QINUtSHUrkA6
 Jb1XzSG5g8XiPDHTRVCiloD8xtSSrww4589bQc8c3tcxTml4pBSOqqBmr4tFbWlRLNzr
 NkiiElCtxCWYbpwPHBgdW7TfRJcpN0FL9NJFdqq2qx/N4N9ngpSSabriUsWeFdTVKqvx
 6W2Q0RSU6lDBeAuSHks11o5hBWsrMPkxXcythRm5TU3EsFAWQKzaV6duFZkzFGR1SLOZ
 N/0A==
X-Gm-Message-State: AOJu0Yzz+i6/UwNaRe4qFOGgqp4E5zg/E4j4fHmm9pW4BN3cP1eSL5zp
 m92prTS5s5s729c2Y3buQ19NhKpfstYO+8WAmSKo8Ir/6DYuzdlD+fe5/g7wxodqSj79I94vqoj
 nElQY+P8=
X-Gm-Gg: AZuq6aKGIgGRy2waEcX02CiD+vA1/WKyBB3avQWb+rEfxEz+KPQDzpJ7ZapXAsVWm64
 q18smYOX0j4acMTEnDj8grXET2/lhWUbiHKyLuhZQ2Ld9MUdrLbmslriy9q8PauusO8WjcEPBkG
 HvY4UwH0cP+sWcjWW3iOxKoOzDoa4Xp5uOZzDihYcpP1PFO1fUj4phsf2WQkxL1aib0/ubNtXay
 UKlQLcGmHJ5a8fgKjSdQdueJsDf5/saxutppE/lzVgnBoiPdqc1XDK7dSJmbC81RtNNXBz1iIfP
 6zVsVpeHLxrrozeilLTdvsdBiusAiGnEW1dXtv7oNiYiEtrSZ2JwjnZADc6FHEDD5AXo9lkSM0B
 Ahj2e8XG3tPQWx7AmSdTmi0R/IxTJPf8gWUsl3lBAw3us3VRPDQMutnoloKUx56tTZMEOysV2aX
 wxRY/u6sz/xlbKmPr4zpzjxZxO3nmRXXQ3HjjuhakBgMr1sAs/ug26
X-Received: by 2002:a05:600c:5494:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-4804c94810fmr52024855e9.8.1769180983436; 
 Fri, 23 Jan 2026 07:09:43 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/22] hw/arm/imx8mp-evk: Provide some defaults matching real
 hardware
Date: Fri, 23 Jan 2026 15:09:19 +0000
Message-ID: <20260123150941.1877768-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Having four CPUs and 6 GiB of RAM matches real hardware. Fix the machine
defaults to make its use more ergonomic and less error-prone.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20260114213227.3812-2-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst | 2 +-
 hw/arm/imx8mp-evk.c            | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 75c8fbd366..79600cf39a 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -54,7 +54,7 @@ Now that everything is prepared the machine can be started as follows:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M imx8mp-evk -smp 4 -m 3G \
+  $ qemu-system-aarch64 -M imx8mp-evk \
       -display none -serial null -serial stdio \
       -kernel Image \
       -dtb imx8mp-evk.dtb \
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 0af5aad583..b84ac91a17 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -117,8 +117,10 @@ static void imx8mp_evk_machine_init(MachineClass *mc)
 {
     mc->desc = "NXP i.MX 8M Plus EVK Board";
     mc->init = imx8mp_evk_init;
+    mc->default_cpus = 4;
     mc->max_cpus = FSL_IMX8MP_NUM_CPUS;
     mc->default_ram_id = "imx8mp-evk.ram";
+    mc->default_ram_size = 6 * GiB;
     mc->get_default_cpu_type = imx8mp_evk_get_default_cpu_type;
 }
 
-- 
2.47.3


