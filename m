Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D99C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLlK-0006S4-2Y; Wed, 28 May 2025 14:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKLlB-0006Mr-Ru
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:44:20 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKLl9-0000Mw-3I
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:44:17 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-52d9a275c27so40578e0c.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748457853; x=1749062653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J9vaYbI6OPKjlA89Q/NPDKgmHC6DQpntnN6kslToiNE=;
 b=kGPJS81ZgE2US4VQ5ISwret1gPWSAd56MonPbXhKPBq4tdUc9hl++16IvF5VgwlULT
 3MacGrIrTKxIyXw/ClmRJ7WCU/v1y/lzh2RkiJZ+fYdMuVAQ91j49i7fgloomIMj4RtQ
 fqdynbSkiT6AmGozMF4QXKrtJByofh0qd5tZLH+yFmdnU4SDJivITUEEXG1a8iKK5agZ
 dGCFOfbZQnrlKejRAp7t6pPMPrHD/c9enSiqiWSFSz+UqKzHiylODS5iIgHe41x/ZweC
 0HoFgD+pRmfPItO1IphF8UL3HKa7kWuTrl/hbPrwFki7qJZ5Aq2u+Q6kilGzxO/1GEPv
 ABWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748457853; x=1749062653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9vaYbI6OPKjlA89Q/NPDKgmHC6DQpntnN6kslToiNE=;
 b=d2B4vSItqv0S4Oylb0E647prTJtpTlAQTmAxzExbL1sSUmJ8tGzxcLH81rXRbupVa5
 hdBeYPZR53ymmEErIM9T6VQ6wxPCoyYN+J7zdpBGocgEz3pl4r4BuUMJY4xcjnIJk7dO
 GqdIk1vV3GT8qGILfaS/ZYeIVJo1+fQzrb6+H4FdM9S/1zm8nimPuaRIqRHYOUsVKUmZ
 U9NVvYF4RV3IpeH9LX5VWCvvQ0+SNgM6AoOOyVUDm3WIW3SboDxVE9Goml45GksiWnpJ
 TrjLdf7ZnhVAFSVCui6Xca0Jv28DsZqm7wDKZg2cXpvgFeZZ7/TODDCdIP9kuW3dJHgd
 0zGQ==
X-Gm-Message-State: AOJu0Yx3ujX9mbhIdX3qygCx777c4KOZFloVzdaGw/LJdrVWs9BmX0pP
 0FggwXcno2NUoEgLDkaP7YQ+9p5xtQUobY9KkYpcpYLi8fS4A0ci15rSbvIqlqQntHUgwglPbYE
 f3tIh
X-Gm-Gg: ASbGnctRmBsB2NWSq3BQS0UOJMntfXR48wICf9JmgQkX9ZSzTufV/DCiIXprjoBNmfV
 thjxRFQaqCuIEZxUuwlD3zWkJG42em3oK6kymnek+C3ge8+o4iG7lZ7/ddIaZ2d00xVHseDabQt
 ZiLaRAAX+L4ZA5C15ovnLKsLRWTtDBZL0b2i09QrkWr5vsJ4PlpUTK+VuOhfZRIo7XA94b8NhtG
 0HDZRXhkAy42G1YbTueTpUyIpuIVL8EqMNs2uRDnOBNHSvby/1q7zIV1z0xtpM93OfqRcJN0//v
 IxAM8euDPV+MXrLPBsta3F5rgbFEFURgY5gLRUyAAZ6YXqJt1EpcHw==
X-Google-Smtp-Source: AGHT+IGQcwdtslO8BLogosCuE9TiA0NR3W7EulBylE+bfm252+jO8AwZl2Dgu/wgFbFmMtvJeyAd2g==
X-Received: by 2002:a05:6122:4d88:b0:530:5680:b48c with SMTP id
 71dfb90a1353d-5305680e16bmr7409693e0c.3.1748457852835; 
 Wed, 28 May 2025 11:44:12 -0700 (PDT)
Received: from grind.. ([191.255.35.190]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53066945971sm1568512e0c.30.2025.05.28.11.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 11:44:12 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, ajones@ventanamicro.com,
 bjorn@rivosinc.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/3] target/riscv: profile handling fixes
Date: Wed, 28 May 2025 15:44:04 -0300
Message-ID: <20250528184407.1451983-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa33.google.com
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

Hi,

In this version I removed an extra signed-off-by in patch 3.

No other changes made. Patches based on alistair/riscv-to-apply.next.

All patches acked.

Changes from v1:
- patch 3:
  - removed a duplicated Signed-off-by tag
- v1 link: https://lore.kernel.org/qemu-riscv/20250520172336.759708-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (3):
  target/riscv/tcg: restrict satp_mode changes in cpu_set_profile
  target/riscv/tcg: decouple profile enablement from user prop
  target/riscv: add profile->present flag

 target/riscv/cpu.h            |  15 ++++
 target/riscv/riscv-qmp-cmds.c |   2 +-
 target/riscv/tcg/tcg-cpu.c    | 138 +++++++++++++++++-----------------
 3 files changed, 86 insertions(+), 69 deletions(-)

-- 
2.49.0


