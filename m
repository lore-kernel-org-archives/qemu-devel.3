Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B5ECD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkUB-0005iR-9c; Mon, 08 Apr 2024 04:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkU9-0005i3-PS
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:36:14 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkU7-0002jw-Lw
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:36:13 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a465ddc2c09so302599866b.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712565368; x=1713170168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3HJQ9lkLK7OifKOhDNfZy/LVOzu1RDJsguWbxUFrQk=;
 b=vrGQlqm+BHRWoS6SxRhGAGoP9C5V3kn4+Pxfi/W6vF7k4NwujLy0t/IgvyCE9kIar0
 NVKaguixWrkkSCgYWgbStVM39biYvzu1z/bocNCAxJ47HNCF9PQik1ji0jbDu3Wi5Mrm
 ZXpS6jBUFsvJFQDfqgt9vmeR1kS/3KxbWhy4UnXKG1nx2Hvpo1O6tsklmVQojuEBZp6X
 qdJa0wNL60Gvhqs0/U2v2B7d6DgRCIpgBqphq5a9NQh8JoJjF2auceQwSYpkAaEURXOG
 ngUfvMkzaaGhwJqQ6Bkrr0Grz0Rtn1OY8zTaV4D/1EZFLjvTrMRe/VrnHiWdKtpLHurQ
 ScMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712565368; x=1713170168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z3HJQ9lkLK7OifKOhDNfZy/LVOzu1RDJsguWbxUFrQk=;
 b=dRCvUhiRTAzRdy1HdvQbgZGtZy8GQz0KtWy4sDkAQ+5BF/mjKOv7Su+F7rvQDx/UaQ
 we5P637iVTSVkpPsZd6psewO7leWjnLLWPyLQ6LDhaOIREs5ch99tyygU9QumGBBwyqV
 29O7kiVlNKIRBM8GBX4TLHwiWLAZpvV91PJJWDL2heJlHmKR4V5Ju4/8clhlqHkAd0Qe
 8znwPZPIDUhj/+Z6eyBlRuy4XMe2UlMn7J8gFgnAPCfbvjzwdsiOaW7ZflIHJYp7z+iz
 JU4ULqio7n0agsRzmqVm1SNgw0Ezdzv4wPGND3rIws8fUtQEx/e/StvnO0QukifqUSTt
 OnmQ==
X-Gm-Message-State: AOJu0YzQY/nyRYZT5VQGtJDHIOxGNtLXcITc4ApOuCeBWCdxIoTeaFd0
 qVeEAszH0p9+tzvyPfsiuRHlohoZLrvLds76N/jTju+kJeaq9218xw5vG64jh2h7eEhDE4IAPiG
 W
X-Google-Smtp-Source: AGHT+IEaKs6Nuu0NLsOTil1qPHPy9dHVxxOpRYUR5l0BW6TYlEjMJjU415xVLNatbjXB09cXaRW7rg==
X-Received: by 2002:a50:9313:0:b0:568:abe3:52b2 with SMTP id
 m19-20020a509313000000b00568abe352b2mr8076011eda.23.1712565368621; 
 Mon, 08 Apr 2024 01:36:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 fi9-20020a056402550900b0056bdc4a5cd6sm3784985edb.62.2024.04.08.01.36.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 01:36:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 0/3] hw/block/nand: Fix out-of-bound access in NAND
 block buffer
Date: Mon,  8 Apr 2024 10:36:02 +0200
Message-ID: <20240408083605.55238-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Fix for https://gitlab.com/qemu-project/qemu/-/issues/1446

Philippe Mathieu-Daudé (3):
  hw/block/nand: Factor nand_load_iolen() method out
  hw/block/nand: Have blk_load() return boolean indicating success
  hw/block/nand: Fix out-of-bound access in NAND block buffer

 hw/block/nand.c | 50 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

-- 
2.41.0


