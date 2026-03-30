Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19001061B1E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Hjc-0007iF-Q9; Mon, 30 Mar 2026 14:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7HjB-0007h1-L2
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Hj7-00038N-N6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so1506686f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774896759; x=1775501559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VFLEgdeK9MrPgVlvZ79oVnxNf2CY9N24g1es3dvD1Yc=;
 b=QEdDx7N5D2UySMC2xxOQHl0GQ8IhJJUgNnxyDemcZ9VDMIVqbLPvMM/1T9dXASLb7D
 vpwiPOtDrUONt9FFXxt+6SWFpK4vqwO/TPThXSLefEjUQiUkMJ/a+0G8bzHem0AYxeVc
 uAHjKO6C6i8eyaL2wDMV3OjkU53XPS5M8vfzoMbxLWPvcolWfF87ULEDwWUoTPgOlAhS
 OsxXyDuqXE9KHFZYFNsJ2UbyI5I1fDAeNdYHg5YudKKCIjEQMPh4tbzITnIinvmNhWms
 KPs1D63WAYgq+iPQSOEx2iJVZKnptyGf7do0NVT/hk1uAjRCI2IlQOatJ4/rklAyOnqI
 XvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896759; x=1775501559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFLEgdeK9MrPgVlvZ79oVnxNf2CY9N24g1es3dvD1Yc=;
 b=sduE3P4aUAwa4GxL7SgEIAvHWIct/b5NHUzXshLEVLdFyww9wuEhxZYT5gXC04/gKW
 2Q/hfFVjaU6BeH3fvynxvHOAgH2+Rg5BkaYhpOoJNuv1oLMXl1meoRK7ySoMOywCqDzl
 Tkb6sCqk8XmC1pvgN7SXXGKo4SSBGaqMrdyOfLydM+vYbeKMwW0mcwkXVUfhJylcDIe9
 fKahDqur119l8PbEGLHeDIwSjE6irfhrbk4J+vT3o7iKUtnk7f1HR4hCweAbgN9t/jyz
 6/pFiNEKUaOMUJv8UUZwVHeaW5TJtzwKlB74iQiv9n80KK7qWvxFALPr0j/LqTQwiZWd
 G4aA==
X-Gm-Message-State: AOJu0YzkxDGMO+5JYykkNQHI9v7RkHIzo1ePbIn0wBI2epioRK17F9KR
 CveC14QWBYJx+X/6PRXFHfJpWgqLIhrWF1jgkALZMPc4rcybRRr7VKDh++SQtka/UBjOz+lZdoo
 itg3gHjQ=
X-Gm-Gg: ATEYQzx6pSKqhadWR1zqnVsNOgiVYKlbkSto5wuGeuR6/LEjb5J3sQtLxYVs7lXrdxr
 Zxkpsd2uSoVuz3M55+xu067LS/QvUiWr+ZA7ZNcGdmzEvaZfJVeAEgW4feN5vG8qDQhK23juBME
 2PamlHlckkQkZuEf17mUCMK9pXAVjfSL7HhuNReTsGwxp9fIh19J55c1Z2plOu601HkY0jryYYp
 FC8flYIg458l767cD6tWyL3cFV8N5wgxcmNP3iQLrY3wECDAHAB04O9XdwbQ3GH6JjpcN2eOFJu
 XEp/bWZNCqCEES41uAkV0SOxmqGaFemA7jmMjOPTPmjJlu+2nenNXkbUuyLsKP2BdTg62xxXfkz
 oY6mMNYzqabuwJbIXfGKBGlhjDWzAk7rJxyObWrnaO29Rzd4Hspcgf+5N6UhPdRgq4dQUCUZTt0
 bFBzyPmAeAyzho1ZQMXgU/mUtT41PbxJPN9oKNXN1DyeRipvxiX2jUv4PAx8Dgm4rO3CYqk7kHM
 6dUNuePS9+8aScnLrWnnnvR4IDsbQM=
X-Received: by 2002:a05:6000:2902:b0:43b:45f5:eec with SMTP id
 ffacd0b85a97d-43b9e9d8c84mr23053145f8f.4.1774896758342; 
 Mon, 30 Mar 2026 11:52:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f1749sm21229400f8f.14.2026.03.30.11.52.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:52:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] target-arm queue
Date: Mon, 30 Mar 2026 19:52:31 +0100
Message-ID: <20260330185236.1905636-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

The following changes since commit dd3ee9c63d96b223c8d41bf5d65392eb898be626:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-30 13:54:56 +0100)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260330

for you to fetch changes up to 36212b4e859d1ccb25ab37deac152d67421ac425:

  hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode option values (2026-03-30 16:18:07 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Don't skip access flag fault for AccessType_AT
 * hw/net/rocker: Avoid double-free of l2_flood.group_ids
 * MAINTAINERS updates
 * hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode option values

----------------------------------------------------------------
Peter Maydell (4):
      hw/net/rocker: Avoid double-free of l2_flood.group_ids
      MAINTAINERS: Remove Riku Voipio
      MAINTAINERS: Remove Igor Mitsyanko
      hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode option values

Zenghui Yu (1):
      target/arm: Don't skip access flag fault for AccessType_AT

 MAINTAINERS                   |  4 +---
 hw/arm/xilinx_zynq.c          |  8 ++++----
 hw/net/rocker/rocker_of_dpa.c |  1 +
 target/arm/ptw.c              | 18 ++++++++++--------
 4 files changed, 16 insertions(+), 15 deletions(-)

