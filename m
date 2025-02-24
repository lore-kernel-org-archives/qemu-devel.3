Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC459C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdqg-00072B-1b; Mon, 24 Feb 2025 14:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdpH-0005ie-5S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:09:12 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdpD-0004tv-UP
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:09:10 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-221057b6ac4so91920045ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424146; x=1741028946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbbIeWCW4JzTBbeBSfjq8vnpfY5VkBCOXFXILh+yEvQ=;
 b=ho7mdll8Cz2VDQE9g3VtscbTVzvbfMjTfNDIM5Lj1hdGG3KKpfOKn5akbwbFHsEojF
 chluzwHq0L8dcf4HXwAYbtH4FVUpvMWXQnWNGDpm3NdcYCijurmRgmQhXImKGz8O85OM
 zRwMF9FvzFG0cU7GDTQg7b1WzuGj+YCtkeQxZDMJ1uvYLn9qRBMhjfE+B+Ogi2MJa/Hz
 8+cuY92Q7aRqWx9cP4Lp4Qn9MzG4rdxbWTxkG8Xy8ZrkSlarJFLFf8P6ANfxthvoGr9e
 nKayrFoR/Lry/h1y2F+llwOjcIFXXx86jorBiA+pWzpPzrVMkdqk2GMOzn88O6FQ18jp
 cdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424146; x=1741028946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbbIeWCW4JzTBbeBSfjq8vnpfY5VkBCOXFXILh+yEvQ=;
 b=gS+usAeYAdbtDRS/PAmIDr5AU6YDm6240yU3AULQEi/HqBU64i6mI288OkjBNtEA+U
 /552U+yz9wjz5QFEiTlR8eBLmF6YE/7ZI1fo+NNOQ8jozCRa0Z9SHyRew+MiNXg/+9Sj
 Ld7hQQagq6pd/SeapVXNDTDCeaUp5hDE9+0OdP4iPhtPGfsyDx270OotMirU7JCv5uYr
 sRAoSpErumWDU2BnsQFnrrlgaSjwyOIzKPq32/XMYhy9EmSzSEKIjKUIvnOJhTpsLHQK
 0WCFrT0TzoHC+InG4Yzy1GSTZR6r1ziFpP2oAYiP6ZYLSzLHy8pdvbj4UdfydRnXg4ch
 epGA==
X-Gm-Message-State: AOJu0YycGq+o8PQ96gY8Bfz3IBLJaA/y5Qt1ih4vEnw2CFbVpspgDs/T
 s3G4uWgy/fiRRMT7nOz8MldjYvhzjezOFxmjvgHaq3oBpwgAJ9z835/UKWv0bJCtwN6wvLVud3C
 l
X-Gm-Gg: ASbGncuvNLwC40WxgISj+lc+itzuGRhG8mkKrUdJF6mRbnphyNeerLJpe/7MeIjy7uL
 53UtJdz053JKErYs7NBxOyEtayKprbmriGmHSJnjxaRXdCgJG6l9Kvac7fvlOtMYtLv92Tr3Bro
 1z5cEQulfUZ/u8BBT4zlnfe7v1Uap+22xMqM4Uj7kepQsbxl7rekUxYRJvvzAkrYafd7nXiMN9b
 A98Actnzcw7uuHH9Lrddw0yTar20g2+raULI6cLDMztdu28CQfAP2qdCtsVXLKjHXfv53WUAPig
 dHBHmnD7gBZ4V6yU+XcbFGhugS7GtA==
X-Google-Smtp-Source: AGHT+IFTHuNTOowQJrG1m4QWiu3Af76qEeHKl/5mOFzfI7bieZkvXKSTvgSXvQdCpAy8hWN0Pv8GIQ==
X-Received: by 2002:a17:902:ea10:b0:21f:9c7:2d2e with SMTP id
 d9443c01a7336-221a1191916mr256593245ad.40.1740424146294; 
 Mon, 24 Feb 2025 11:09:06 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:09:05 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 11/11] docs/specs/riscv-iommu.rst: add HPM support info
Date: Mon, 24 Feb 2025 16:08:26 -0300
Message-ID: <20250224190826.1858473-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/riscv-iommu.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
index b1538c9ead..000c7e1f57 100644
--- a/docs/specs/riscv-iommu.rst
+++ b/docs/specs/riscv-iommu.rst
@@ -82,6 +82,8 @@ Several options are available to control the capabilities of the device, namely:
 - "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for 'BARE' (passthrough))
 - "s-stage": enable s-stage support
 - "g-stage": enable g-stage support
+- "hpm-counters": number of hardware performance counters available. Maximum value is 31.
+  Default value is 31. Use 0 (zero) to disable HPM support
 
 riscv-iommu-sys device
 ----------------------
-- 
2.48.1


