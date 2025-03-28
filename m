Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AC1C36014
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 06:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty3b0-0004MZ-QY; Fri, 28 Mar 2025 02:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty3av-0004Lh-HL
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 02:53:33 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty3as-0005Kz-SK
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 02:53:32 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so4098763a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743144809; x=1743749609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/R+xXFP2DtT7bnCBgR/WcCWpSoZRhHsSh5/jC3ZG6ZU=;
 b=jp9X+AJPNGWw1s9n6MrAaWySLyQW/4dalpaI+yhtdb0YdEPjv16pp+84sZppvbVg27
 ifINvAlNvP4ixsFGkVe7LnpkGoDOZ6VP2b3d/8BtSfulkoUFDnuxsvCQdupy4QlKOR07
 7mI+CtuFFcnPs7vmd0yn1y9q4PzmowyUMzK6dFC5eHvzzvBhUlyDt6IeYnE3xr3P8M7F
 P7FUZLObJH/jg91zYVCmvxS1/mqAM4SHEMvChJ7jau8exJYMtxzoHq/f5YjMHfDZBCNg
 9IrG8lbx7sRp71q42CTXlvWvBXIYmdeQJtkKWuY9u1pSJ7gorQmdafzH/K2aYTzDR+4C
 FGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743144809; x=1743749609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/R+xXFP2DtT7bnCBgR/WcCWpSoZRhHsSh5/jC3ZG6ZU=;
 b=rCurPSfYr9u1kXSg2S5/cSOexmxyemlupTMr9CwSwN9RN4n+4pb7st5/DYalinShlM
 1QlgprlppeCc+JJoqlKDSL4YYFh9W8xHADhviuhwZe2IGFr8cWo4NIJPiNoAEj6aL83I
 nsi1JGtmmNW6ixcvM4eduiyql7akIRjMvfspQoI8k1iIaceLzaaPfTB3TAzWSqcweEJY
 k9ffM2DvRgF2snqPT3/BC9hqgFHU1qmnRWz0CAXgcSKx0GSSlI001fvrNfUCvSG73QJc
 zjHa1qJ6V4MBu1qube85rSsazsLgKjpVA8sDfoOaQca8OXjYyU9ECYKGc6U7lQaIllih
 4S2g==
X-Gm-Message-State: AOJu0Yysb7/WbSWLam+adnv7wjGzu695ejaCR5BI0kPFt6g7sMpA9PLz
 8SKeOabNQtcxoK1OxAfXD7qeP01zEB+1Uh4q7Bb0CGOItL39PO1YST9qVA==
X-Gm-Gg: ASbGncvZ0cd3DsHbFGWIUt0tB/29RrX8e8UP0YEw2AuDbMqjpvN9wEr8HM9hxIBry8/
 Lp+M56ibbGZC2yFWbtGsUQGCN0UCCOgW7W2NGeq0ABCbAs1kfHZdHS0BO5+0TAwnbd+dl/Pwgsm
 gCZSyzoq5a+d4Ev8hZh6HfqUBz/CgD27slYhcQMbyGzKHi4hNzeM6EPkM8hc+kFhoiF/qDc1pz3
 8zobLDqkfHZGZBv4HRCzQP9PZsc058Nm08+XqQAj/KrAmNXglgSlv7aP/k1bx9COonUkkuywveg
 GFEgs1uww0QP7P8S6zXcrux4bZ5ewVcsQ2S96DWXDIdPwPGNGL5usGBc0iLyzxVxCxM4lgIEJj5
 2MqJN3xDove5P/5gaIG6IHM8aL1krK41K/Ug0Y3VgiFRCA9+wuZisME5wqTqhlQ==
X-Google-Smtp-Source: AGHT+IEmCGOmU9HSJh8mK+VxFGuBJtMnykSp0eI4ItIUm/CG86FznIp70z9qZKInnbhooDH0yrZoqw==
X-Received: by 2002:a17:90b:3802:b0:2ff:52e1:c4a1 with SMTP id
 98e67ed59e1d1-303a83c3580mr10215083a91.24.1743144808895; 
 Thu, 27 Mar 2025 23:53:28 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1cf8fesm10633025ad.110.2025.03.27.23.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 23:53:28 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 1/3] docs: Added docs/specs/riscv-iommu.rst in MAINTAINERS file.
Date: Fri, 28 Mar 2025 16:53:16 +1000
Message-ID: <20250328065318.1990698-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328065318.1990698-1-alistair.francis@wdc.com>
References: <20250328065318.1990698-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
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

From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>

Added docs/specs/riscv-iommu.rst under `RISC-V TCG CPUs` section in
in MAINTAINERS file since
`scripts/get_maintainer.pl -f docs/specs/riscv-iommu.rst` doesn't list any
maintainers.

Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250323140151.9994-1-hemanshu.khilari.foss@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f470a1c9b..27f2cfd833 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -319,6 +319,7 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: configs/targets/riscv*
 F: docs/system/target-riscv.rst
+F: docs/specs/riscv-iommu.rst
 F: target/riscv/
 F: hw/char/riscv_htif.c
 F: hw/riscv/
-- 
2.48.1


