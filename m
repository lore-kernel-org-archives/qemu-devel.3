Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBECD1A61E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCND-00070c-6g; Fri, 09 Jan 2026 08:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCMp-0006wz-9Z
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:17:30 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCMn-0005qz-4a
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:17:27 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0fe77d141so34183335ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 05:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767964643; x=1768569443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=1Iw04MMwLGA6t4YCdXdITwXoYyAryedVdQjv0cAR8/I=;
 b=WbegU+exTt9p0SDGx15qyCOijBWWwWYBMYO7BYy9EB4Trt3znt2VLfiM+10r8QJs9y
 FbwtxbyzLISRVH1JF02BYu1EJulvH8mM+ryiq9nMdHaJdBBGKT6geoF/B8XYi6iEiM1f
 hQHwJM2J7X5tTDpiBTHWloVokRaNB3I2BUMrWHhdA0w0O1qWzJXTI69FRXg4HocqLBMk
 IGB6F8n04gKJQvursqnL8H6uA5BaNs8DUGa97kzp7vV5F8SECU9VCvwNa3KkIu6r7gxk
 jXkfEmI/Rn7dHqXTAr3mig8NXAYfb1rAXmqiPnmkkI4+w8dlC0E2DxZ5jH7IeDN5jNv6
 rVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767964643; x=1768569443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Iw04MMwLGA6t4YCdXdITwXoYyAryedVdQjv0cAR8/I=;
 b=j00xSxdePli7/oGvMtWqLtYZpK5BWSHPY7ax44AAcKsqgt5mIzSdu5h6ekCUB63Fs1
 AIYTTFEjlRqbDSd/SJ+NyBBlk8kgVg4qf68RhRMl+Tl73QsZAV+WSQeP0RThG/i0cBER
 nIREUn0kJWrJ04k1TYcFCcX6ZfSP1yX6qJPT0mJGUVimYToGoKibYL9zZvE9WNWoaAKr
 wWyU3pke/sHqODGzNZzC9orsD1TDTibY5sc3MhEdpr2KdiMEBwYri3oSY5QGTYifVK+q
 Kdab7GBaei6GfxM1KYAA72ZmRnD4Rb3X99wkoxsk9+PDJ1AzaVsSx5lKkAFFDzfvMQAa
 uGBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2gxMbO1yDA/crAo/IMXu9wEccw0NVnb32UWhFHU348qmCPZAro0rwa/xM74wcBK6cbW3NBdpU0SlT@nongnu.org
X-Gm-Message-State: AOJu0YyipoWh7oUZD6IKkt282qaJvybEp3TV6N7i9AmFbX8N7gIl0xIE
 Zx0rt/EQlU/BlpJmjX66BmEHUBNBU+acYgSp/KIi/XjLOzs335aItATR
X-Gm-Gg: AY/fxX5LPdBHYI4jE/qBxpfNbr6REOp12FjcZeQUjB3N5FjrH07DKlLtDV9f40oLFM6
 WRvytLRPXRmMo7cru0XvT6KZxCIZpWz/YFisJIzmumYLzhyZOocVAI0s2YdtJqM6OtDdKdiYu18
 eeJDAqqNWWnr4BlZQkcL4dubWpPEP9DH1WOwgKOJlxJBCAjKXa6qzwMe5+IdyP4VJc2Nvh/6Ks5
 484lKkNJKuzkQpmSPGd3d6xjYtcPvBzzp+XstxY6LkEY7gz7QaR9vGtdl3J5oC1Idiqssf0G+Sv
 TdBUgjaEkUs2g1ox6fNiNZrFLwoy4mfp7cMzVJwdvGfh9uRPYOrOq7YSoh2IfImC0lBpp4vYdV+
 Au+kJuLI2AMfRnjbb+Z0AWPpH/DJnDA50Gfq1qkEnNmbXoHcpRCqvBZYsuRYPxjyVvLkf8dS3Gs
 LvvIW64dvPAItS7hJaAJN2
X-Google-Smtp-Source: AGHT+IEuiBciDSQ9CJri2b+xevRcdp79Xp9/goxv5Ika+HcdkV+8BkMPQQx4w5KFk/ehR9UxJuQVJQ==
X-Received: by 2002:a17:902:cecd:b0:29f:e787:2b9b with SMTP id
 d9443c01a7336-2a3ee4da376mr92071185ad.41.1767964643427; 
 Fri, 09 Jan 2026 05:17:23 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47390sm106103735ad.25.2026.01.09.05.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 05:17:22 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 0/4] hw/riscv: Boot setup improvements
Date: Fri,  9 Jan 2026 23:46:51 +1030
Message-ID: <20260109131657.396794-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The first two patches improve the boot infrastructure for riscv so
machines with split memory regions can load payloads into the correct
region. 

The second two patches improve usability when attempting to run opensbi
in less common situations.

This series are prerequisites for the Atlantis machine.

Nicholas Piggin (4):
  hw/riscv/boot: Describe discontiguous memory in boot_info
  hw/riscv/boot: Account for discontiguous memory when loading firmware
  hw/riscv/boot: Warn if a ELF format file is loaded as a binary
  hw/riscv/boot: Provide a simple halting payload

 include/hw/riscv/boot.h    | 14 +++++++-
 hw/riscv/boot.c            | 73 ++++++++++++++++++++++++++++++++------
 hw/riscv/microchip_pfsoc.c |  6 ++--
 hw/riscv/opentitan.c       |  6 ++--
 hw/riscv/shakti_c.c        |  6 +++-
 hw/riscv/sifive_u.c        |  3 +-
 hw/riscv/spike.c           |  6 ++--
 hw/riscv/virt.c            |  7 ++--
 hw/riscv/xiangshan_kmh.c   |  6 +++-
 9 files changed, 104 insertions(+), 23 deletions(-)

-- 
2.47.3


