Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2EECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeUk-0001bR-Hv; Tue, 28 Oct 2025 03:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeUZ-0001Ut-Fo
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:51:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeUV-0007Wv-TK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:51:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47719ad0c7dso4046845e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637898; x=1762242698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fnD+hCc2mdU4naImyfEXieGQuHfdgsBV07f/58jWTc=;
 b=pgdhqpoGBWFsGNBc4Tft1puGyPQKTtW69Mkx0QE+AHjRKFY2aN2vBB3z/85HuGjtJg
 z339DrhdMrpDI42lIfcrJ9jEApOVxQpvpQJu/513W1HAbVTQDQOmwyuzsYer9aGQ5t/I
 TxR9G29D8SSsBPAQp/z60sntAAVV/6RajmPaX3n4L+4bl1CP2RrmNVIanXY2erqdUquy
 heYO9rs7SkoLsFd+329mdJAB4uvIKDrr1ZO0rKTBNBvBc6LZYMKZYcSysrCVyygE4UEZ
 FsNG7Yyq3IDBN2J2KgvXTM5KkmaulMJYkARS574Gyzh4Tt6/Cj+c7rZGNNTrVEFKfxi5
 Zo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637898; x=1762242698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fnD+hCc2mdU4naImyfEXieGQuHfdgsBV07f/58jWTc=;
 b=jdoYpplFrvIdZsUgrOmrbPj+4bvjTjPy7huNoFg7MIYdQBs1wz7vZ8pBW8/L49dHqt
 xFeBdNNk94wmoKvPUZwcQTwDECMQ+jRqy+C38MAHlbfGQTVPF9IIfG56h8viwMwySZYL
 cmFdPqmOamsI/8eDefpTnJvCCjOblrxsLnTysfsgfcPMqctluGlPCBjgyhqxRjMvtFyS
 NrrQLNLoJ/DE4+o4LnH/T9w3qooI7Xewrtr83x4c9QVd8/qHwtIQvCksMTpJAQCv9lGU
 jaoityo4CCjFo9gGkuZh0O5AhM5bn3cbFOI4F/8fLzM7R5K30/Km6o4UrhwmoAzQCMj7
 LwuA==
X-Gm-Message-State: AOJu0Yz0y/fNc50Puven7wiwDD6JfvJCC1ehAtv2B4vQio5xl2aG+Y7j
 8zMYTxNMLIUHp8rmSJt5wcKwWwiww9+uIiG/Ej6P8yz1KG8lit8+Z1wytyHuwHo3cUOHuWt8MpD
 WdW58OSQ=
X-Gm-Gg: ASbGnctIczOdfGnmNn0J/eum9wjaf8cAnu4sYeGGANIb8yeGC0nlvt+nxAP7MZAtVcz
 FaExJaqzx30jnr7O2QrpddnL4zEpkyKpgDHm45z9jLZrhAR/FFmDZWSG80UD8UJWhlf04rYRVfw
 TEplFJ9m8Howv5IWwrZihQQzmOdfonvN9NXl0o3xfV2unCYZqgBIMXvcbfOQaQtz5oz/XQlsm6k
 9xqHzibarbKiWSoFhtURRpZdT/XW4S2QokRyZtZk2Kb6z3Ptp5aka1zKQksdOCIVFZibjl4QCFu
 JXWxbMbTe3JLSlIPwmR5Sk/BNLCCoDdzrigYV7FhqQf/4gdddVCoM4C4op+/BJUbnQHaGtA1qhy
 a73TBYMVdvbXjEqXvTUxgVbCNPHRVNGnGyhrK5lTpKM5lIdBLzEVZUmnGgBlif2xS1nAsraJFgO
 J3fqLhMhKJwdAzRw0qwcUHp7UgXuM3PbiKZpfiJO45XYRnP/HfA6Li8yI=
X-Google-Smtp-Source: AGHT+IGGp1aglM6ApwmlDr6vFy1zOHaNLMplccfUwbB8hLP410lJjwlbWe2FI1zwNEuM/iDVPeAMKw==
X-Received: by 2002:a05:600c:45d5:b0:46f:b42e:ed87 with SMTP id
 5b1f17b1804b1-47717e62bd2mr19303325e9.40.1761637897675; 
 Tue, 28 Oct 2025 00:51:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd035dc2sm183617865e9.5.2025.10.28.00.51.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:51:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org
Subject: [PULL 07/23] hw/pci-host/raven: Simplify host bridge type declaration
Date: Tue, 28 Oct 2025 08:48:43 +0100
Message-ID: <20251028074901.22062-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Use OBJECT_DECLARE_SIMPLE_TYPE macro instead of open coding it and
change state struct name to match the previous typedef.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e14793737092eac0642aa87214801a1f4bb1e2e7.1761232472.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index fa76e5170c8..ea5ad69547a 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -39,11 +39,9 @@
 #define TYPE_RAVEN_PCI_DEVICE "raven"
 #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
 
-typedef struct PRePPCIState PREPPCIState;
-DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
-                         TYPE_RAVEN_PCI_HOST_BRIDGE)
+OBJECT_DECLARE_SIMPLE_TYPE(PREPPCIState, RAVEN_PCI_HOST_BRIDGE)
 
-struct PRePPCIState {
+struct PREPPCIState {
     PCIHostState parent_obj;
 
     OrIRQState *or_irq;
-- 
2.51.0


