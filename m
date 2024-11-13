Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CD1D637A3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBH0M-00007w-4R; Wed, 13 Nov 2024 12:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0L-00007o-6L
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:09 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0J-0003ju-Nj
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:08 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so64478115ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731518283; x=1732123083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UHVe9CY4lpulvqbim1lRpytAm970j/RmzHBlLdorJnY=;
 b=Z49xI/dEzLG1J+G+VI6p6xPseqEcjMpZpq7i4AIdd/l7OOS7IcOiQOpZoILlApWhNU
 nI3H4DEyPNyXmEQ/B6B7CGq2/8Kyxfj7l+E/qzVcjLCRf38jIO2Vx1+6KF1I2+8/tdkN
 Ec8AxMjoOpxes6RFD/VNQPMQ+apY2aG2SW8bfbU+IWga6gRPInnRfv/f1LX/fqfj1lBe
 NSIB3s+dH8fEzP+kQP0GTuLdN6LwCCCKPDxCD7yTnh31M+mD5BJzzYNRHCaUrfYc4vMU
 TiJZlf9l85saDL3HiA5+kHK1kkce0akIlDrDjJRX218KORLHF8rWYiMH99376VCqyN9F
 WAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731518283; x=1732123083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UHVe9CY4lpulvqbim1lRpytAm970j/RmzHBlLdorJnY=;
 b=CCjg7hc0BjKpqhmrQF42MKU9Z8e8i2UmSZoL7fBobUXYJp6D3kcTTqy75CW7GJ+6C8
 RA92c1U47p50mVMpcfQSmBgubHXyCqeUudhNvL7fOve3TN/6mjWcI7XERJLhIz+C23oL
 Wsbj44oz9XuLTz4ssCbnZgJzb+ptdfhOKufod7mF4xVZ7WsciMjkQIpAQ84ZL5EUMLdn
 PxP4gMcRMkFhKEVDk6Yb4uvMcZS4bEfrOlB71e+HByinM/2mTPI6FYtlkVh1v7BMglco
 RThdy1XZcFyNfz8C7T54eznWY6T5gRKvO3A5ybwkJJQTFDTo2YavurAKJHfoJqUM7DTj
 GSOQ==
X-Gm-Message-State: AOJu0YzbjTgmkKNCSmMfPqFBfL3+sxDT4GTKP0GblqkVF5HCfvUozG1c
 GJmoXCryLwtRw5bZgZu7OSf6z9zOb0qiIJi8dPRjQfxFljijpeaqSltyMwRPH77SudNtBFPW7mZ
 z
X-Google-Smtp-Source: AGHT+IG0mN+hz2Gg84ojNR+hBWeZDwlQmQmVDDzIdAy8QmB/bBciIOSV/wiPQXTE4rwlpbBNOaiXUg==
X-Received: by 2002:a17:902:d54e:b0:20b:6d82:acb with SMTP id
 d9443c01a7336-21183d56cf7mr268638065ad.23.1731518283244; 
 Wed, 13 Nov 2024 09:18:03 -0800 (PST)
Received: from grind.. ([187.101.65.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9063sm13392889b3a.75.2024.11.13.09.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:18:02 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 0/9] target/riscv: add 'sha' support
Date: Wed, 13 Nov 2024 14:17:46 -0300
Message-ID: <20241113171755.978109-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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

'sha' is defined in RVA22 as "augmented hypervisor extension" and
consists of a set of named features that must be enabled.

RVA23 makes 'sha' mandatory, so let's add official support for it in
preparation to support RVA23 later. 

Most of the named features added here are always implemented by TCG.
Only 'ssstateen' has a runtime dependency. 


Daniel Henrique Barboza (9):
  target/riscv/tcg: hide warn for named feats when disabling via
    priv_ver
  target/riscv: add ssstateen
  target/riscv: add shcounterenw
  target/riscv: add shvstvala
  target/riscv: add shtvala
  target/riscv: add shvstvecd
  target/riscv: add shvsatpa
  target/riscv: add shgatpa
  target/riscv/tcg: add sha

 target/riscv/cpu.c         | 10 ++++++++++
 target/riscv/cpu_cfg.h     |  2 ++
 target/riscv/tcg/tcg-cpu.c | 30 ++++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.47.0


