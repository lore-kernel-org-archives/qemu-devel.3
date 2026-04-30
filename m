Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570FFFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJrD-0006mk-DS; Thu, 30 Apr 2026 01:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIJrC-0006mF-AQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:22:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIJrA-0006T6-Su
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:22:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b941cd869cso2970805ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777526555; x=1778131355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zglM3fCY+SQjEWXlZqniJXtYbtvWTZBMJy9hZhgaAJw=;
 b=obe0tcJvTbAU9Bt9vaKe1mNsNyuyDv9dg1GhBx+d8dDPga0x5Vq9bgz8nMs2miwyPv
 5HjfrefQgwOq/5U9XzWHGD/ZcHzZQV6SRPrdj6NmIfqrXxo5dZYNXObhW3OcDID7OtYv
 kK3aVOHJNPs/jd2yfWqTWW9oTBHGwv7+AKAuldq01B94cv+ylbhbn4zhDgyYzxMmvhd5
 4qj1PhqPwfm+FVJLF0+ngcJNKRXhr2i5fPKq4Gr4j3QSCXeWptYxmMOguCMnotgYe9Wz
 o+eWUq/D0hwngyTe8y/ljI+rvUtDz03kvQz9l1Y56d4FSl1cZUmFsEdvfvH+aAKSy2hy
 UttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526555; x=1778131355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zglM3fCY+SQjEWXlZqniJXtYbtvWTZBMJy9hZhgaAJw=;
 b=ZtaVlNLNDz96BDJtur9KoKzb9i73wzNCaJgsN6FDqiFgeP1GBqC7RV6Pz+Y/CQ7EW8
 kGJM3B/tDL47PfjhUsgrsJkAB3ogKZnhdIH/TWlfpAYxSGasgtd91Ts+oWqVw+k7LUNa
 fl5bJXfiPQ9hvqIMnAXftq2mjlx9OFEShGkJCvBWUNRr/FANaxyRNSEYDQQjpXqA/kOx
 aVkcOzRCnqZtCVSkzWHbQyLmjSBTxDNBZcL6rTM/VE02J/bnCalNnBcJ0grT5cWrH8Nq
 rbUx/p3x1RTfMk8lBkHc9iXT5NYoaa8OjUM3nJOhcaYhfX1rTNdIHreINr0dIYXXXR22
 0uOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ajtviAZThp1LrGPtmjoiySBQnw4mjbAOAUqNt7Uxrfw38PkFteWC/nHiAqUsO9TwtbR/5xE774HlJ@nongnu.org
X-Gm-Message-State: AOJu0YyB2pSIDFSz4tEwWOn8BH1tvszGjFYMG9ztHeQKKVlQz9vPExKP
 HXaeyOHYWyLPH7b7aLpoRDrD0QLb6hFZOz5AdudTssY5mRooS4N+HRTIiaXNfw==
X-Gm-Gg: AeBDiet9LnRuNFeRVf/bxqiq8DglUJ4NPtsD6x3nsyNM2tYPV3R96xXcnn5W0cYSA4+
 2Uor3wVmjjJOOlEXg2unQXzNt68HFXZCl7/EDROt5ZyxjjWJTYhbTIfj4+2JeWIWkbm6y2VYrpL
 qxXbAQnNqjEsyh25TO4Wa6dSSoRdSUUm52VFYv0H8/ffIBhnaO7AGkcQfJLBeWRx0hg6TLevI/1
 wEUv6cF0ZNdFAmdPcO2ZtecTJb1ntgFgnZgvC1PrUaINlXRJKfFrf5F60gpehTAvrdN4jBwtSdE
 fqDvV+HOGVqMdZw8B+foKLetnPOvvl7+sC03y799XuudbqUhOrU10It63xMsHPej5/tshPvjVT8
 Rz7TzUJ6IKIhLKXSK/NEoYnPlRufJFBDLVzdHWqgGrRBrws8LQYzLUDAUp+ZY/rnDIQFPktBR0e
 wfUERNkgH/T29UC3r+YQm+cECzUW5kB+egCSHFhm4UgvUZsQHO6QyM
X-Received: by 2002:a17:902:c406:b0:2b2:4a9a:b149 with SMTP id
 d9443c01a7336-2b9a233d195mr15649275ad.9.1777526554864; 
 Wed, 29 Apr 2026 22:22:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988985b52sm38934965ad.75.2026.04.29.22.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 22:22:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/2] target/riscv: Update deprecated machines
Date: Thu, 30 Apr 2026 15:22:16 +1000
Message-ID: <20260430052218.771358-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

This series removes spike as the default machine following a long
depreation timeline.

We also deprecate the now unmaintained shakti_c machine.

Alistair Francis (2):
  target/riscv: Remove spike as default machine
  target/riscv: Deprecate the shakti_c machine

 docs/about/deprecated.rst | 19 ++++---------------
 hw/riscv/shakti_c.c       |  1 +
 hw/riscv/spike.c          |  1 -
 3 files changed, 5 insertions(+), 16 deletions(-)

-- 
2.53.0


