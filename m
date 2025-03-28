Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9295AC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 06:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty3aw-0004Lc-1P; Fri, 28 Mar 2025 02:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty3as-0004LI-CS
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 02:53:31 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty3aq-0005Ke-Jx
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 02:53:30 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso3098581a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 23:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743144806; x=1743749606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OHNarUGlXtjwIopY/we/xfcYuqVTydUgWVuaPaaAq1Y=;
 b=B1oZui5J1HiKN66jpDEU0d5aNTVrxZW3O7GKMBEh9Hxlz/h7ri2nOv6TAElF+9QqH7
 1MbKcUj0O57XazOKoQAAtmVIezvKodd8q7YcqBLfXS8XEu8kpdRUpSnpsESzV7UH0i43
 EulJhko8KhqQLn4FaR7j95mtzs6yMou4vz1IWO0p+3itv5KHhHSKbtT4FSW7MuGcVpMX
 EUjmTXI7rP/OfZ9k24iJHUbVe5go6PxpWJgUdBk8ZhFq99Go2OQodDzqMyIYaTRQhiAE
 vS0Mpvn1wJFaIJnkomu6gZ4UlLreT76A9yFS0oV1GKh16HS3/IzLLvkeLjx7K0XOPRxP
 Ezxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743144806; x=1743749606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OHNarUGlXtjwIopY/we/xfcYuqVTydUgWVuaPaaAq1Y=;
 b=NdJ7mCCt6S+HETnWLa6ljtL5smscaBSzvZupuJt1CE8k31D1vPHiyJrXOwniQitrA6
 H7dMTPY/1u2mk/K6dlDqqmGauuxcJ7lA8ek3w1aFxAPfWRJnC9qy5Vw3Iq57obhzJOou
 S7WqK2P5ee26qfc1ik18mcE3sNVE9OXeG0GL10Gmlw/0dZrkAB0joh/Olcx6di/tvUBf
 +vCRDgO/7FrfgZopsdFTbERFrgxgaMgGv35WU89EZhLr5Ds8H+jbRHjTkrewl9LOOH0O
 616uU7NnVN1AXV0FQyI6GX662cZsxQArsTk8wSk9j42w8W3/t7hZE8y4RadK5IQLGUqk
 BpYg==
X-Gm-Message-State: AOJu0YysMmTOnqVrOMlllJA+SDhByQ7lHUEiXKLMQGFfk6CMNWtz9pqh
 0PLBRcLlyl3bmuLBTb/jMkVya7HXwi9x5n70ZBovQ4zQrOkwAQ3X6hH94Q==
X-Gm-Gg: ASbGncvIKUSDg9oiGRN5mhOZBbgs7JS1yEF4yxxpsfUVaRdxW7/qY9f+2FZ6jB/gxB2
 oMzIee7hMurV1DWep4ViRFC3IHd+5Bmu9Oe6/oshz2w6DpbkMEjOWPj/b5G7+cXB8Sac67lbN3s
 6jOzVhapkEvtr8zbkHYLaOjOBvPxSkhge6lRX6ME65pdJrBQlq37CY0WmYcdJ5Ee3cuFdQEitSb
 DWcfnPRI70bPcxcKbt9ZliLf6vBJhRU5hrluTAO73Kivo+sTnTxfUvGwK8oin4Is8BMOCXq7Fyv
 SyHtY8zFn5U/EYvQx8+5KhiQJES23ESoxT3N4PSu7kuG2UruNdJ/h0mi+3p/N4gFzCtqJjodFyh
 UOYGsbLvlM4MOtgo7XblECeRWgpXd+1Icd8umVgK/rvH8iYkt+kQ=
X-Google-Smtp-Source: AGHT+IE0ASWNPIyaY8bObc8ul2m4wjJ1HQjJk5fJPh75lcJo1aHQEI9bGTsGCMsiM9utDVPwHhIBvg==
X-Received: by 2002:a17:90b:5485:b0:2fe:6942:3710 with SMTP id
 98e67ed59e1d1-303a7c5b782mr9076846a91.3.1743144806128; 
 Thu, 27 Mar 2025 23:53:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1cf8fesm10633025ad.110.2025.03.27.23.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 23:53:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/3] riscv-to-apply queue
Date: Fri, 28 Mar 2025 16:53:15 +1000
Message-ID: <20250328065318.1990698-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

The following changes since commit b876e721f1c939f3e83ac85bd3c1c2821e12b3fa:

  Update version for v10.0.0-rc1 release (2025-03-25 13:58:14 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20250328

for you to fetch changes up to 897c68fb795cf03b89b6688a6f945d68a765c3e4:

  Revert "target/riscv/kvm: add missing KVM CSRs" (2025-03-28 16:50:25 +1000)

----------------------------------------------------------------
Fifth RISC-V PR for 10.0

* Add docs/specs/riscv-iommu.rst to MAINTAINERS
* Fix broken link to external risv iommu document
* Revert scounteren and senvcfg to fixup older kernel boots

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      Revert "target/riscv/kvm: add missing KVM CSRs"

hemanshu.khilari.foss (2):
      docs: Added docs/specs/riscv-iommu.rst in MAINTAINERS file.
      docs/specs/riscv-iommu: Fixed broken link to external risv iommu document

 MAINTAINERS                | 1 +
 docs/specs/riscv-iommu.rst | 6 +++---
 target/riscv/kvm/kvm-cpu.c | 6 ------
 3 files changed, 4 insertions(+), 9 deletions(-)

