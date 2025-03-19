Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08A8C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuyzY-0007LW-NA; Wed, 19 Mar 2025 15:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tuyzW-0007Kx-2O
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:22:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tuyzU-0002BN-D5
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:22:13 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2260c91576aso71774545ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1742412130; x=1743016930; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k980bTdpUIcRaX51EE8/DXEZJIPi5WHQDz/qa7wLLhw=;
 b=E6tOzclR3pKvlsqAC72AAPjLCA63D9j1tRSFqpBEDz/hP+xsnrW+qt5WeVwZ6i2UCG
 Pa+8jC9p5Ddw8cz7m10RTd0T8IRiq3+4o9tScaxi+RfXbi5VPyKjTTPmCMccPHp2pCLL
 fwnF3UZ6dUApzmYXHwW31UHqzDURuCD/UTzZZFY3loxBxISjkLyeKPtLA6mKIA4YUcgm
 1DSHv9/TM/Qtpm6lDjBFdIiixDqdHxsNLsinnvpKGaR08Gifdvropcl7/rAasCdweWaf
 jbd+C/HZqzF9oVEaTFdhX4UWC2Hh4ub6UTmrI3k0eeFIbsnvof+lAt5QmRZP6OWcE4pL
 oUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412130; x=1743016930;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k980bTdpUIcRaX51EE8/DXEZJIPi5WHQDz/qa7wLLhw=;
 b=gQJ/QC92Ydt6epCNHRPIqw0ZKqUZPb5bpDDcbAn3tYD6TCtshCMaBvXg56N+LYwmCO
 Qnl4WrMeqiwrI8dsS8MxHpuhCpPJOlpCzCjklKf5X1+9vA0SuBQrNQRCrNstCAv02w4S
 WrlwomNr4F3xgXn/223oyGgP82zmDnGQZazkmWI/QjT+Cq8iVpvDEkLQdYPc7LNP2BI+
 iKzzvqnEjztk8kf3s71mULEiv45Ec9pRr2v2wXBNOdCK3SspeQPbhjedXZFqQnE4xPn0
 1s9U1xpiM9Kc+KkQtsaFY9vwmDm7jUQ24VM78jBmigR3EdFnxOvtml06ewyHoJ1Ns12F
 iknA==
X-Gm-Message-State: AOJu0YzG3cZ0Rto1LlUCRcdtZ7rsUaFF0XOtA7W42KCSL44w/qgychl1
 iojuoWCaWQh0ipEYkxh/fuvS1Y9NYHxHdMRlNFojlppKly3GXlXB+4qLiEy14NKwdzglrxDQeJ5
 1z+PzvtAQTTY5qVqRB91krHDLhRwuOjouH66xYsRaUsF1jXBS79XXQWVE46eun7R+PAKIyH311G
 K6rYqxM7BbpNiRBmzRXuGAd24W2TYGC/i/xw==
X-Gm-Gg: ASbGncvWfQ/OJ3XDY0dF7c8e181YKacIsgO5jIwYQAr5FkXTC/sMNX8WzyXfGBmoFG0
 0TDwDpO76eP/bL6ynUvqPOyxkn6khgvMQCoBGv2A8EygdHp7QeRgV1yLN9Mo9SApaC27VKsGMOI
 pxDVK+3eKgNdqARebT4f2gB+0Q5C3LRdX80LzJadocM0UKW23WN+6h8PB3vVB5Q9AJIpGjNuPyT
 GhngKK927JOk74oR4J4FIsn5BzzCqWXizniB8WsQ4H8/qhwU8IPKyg7JMdu3/WeDYhbPv/V0Vpa
 qmiNLBq1HGO6+kV+furjik8idQqqlQweQlz+uZ0zCrB89GQl3u6pjzI5OBF8HpHEQdA=
X-Google-Smtp-Source: AGHT+IHnjzBHwLV6SCyvX5X7yctBBz1mYb6DUq7eRBzNLTtWYWXDXcynAp9T9jvrdkRfXFNPk3qeFw==
X-Received: by 2002:a05:6a21:6494:b0:1f5:8622:5ecb with SMTP id
 adf61e73a8af0-1fbecd36c0amr7693017637.34.1742412130221; 
 Wed, 19 Mar 2025 12:22:10 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea947a4sm11432175a12.70.2025.03.19.12.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:22:09 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 0/4] Several sstc extension fixes
Date: Thu, 20 Mar 2025 03:21:49 +0800
Message-Id: <20250319192153.28549-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x631.google.com
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

This patch series contains several sstc fixes:

(1) Writing to ACLINT mtime should also update the period of S/VS-mode
    timer, just like M-mode timer.
(2) VSTIP bit of $mip CSR should check both M-mode and H-mode STCE.
(3) Writing to STCE bit may enable/disable sstc extension in S/VS-mode,
    which should update the timer and IRQ pending bits.

Jim Shu (4):
  target/riscv: Add the checking into stimecmp write function.
  hw/intc: riscv_aclint: Fix mtime write for sstc extension
  target/riscv: Fix VSTIP bit in sstc extension.
  target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed

 hw/intc/riscv_aclint.c     |  5 +++
 target/riscv/csr.c         | 53 ++++++++++++++++++++++++++++-
 target/riscv/time_helper.c | 70 ++++++++++++++++++++++++++++++++++++--
 target/riscv/time_helper.h |  1 +
 4 files changed, 126 insertions(+), 3 deletions(-)

-- 
2.17.1


