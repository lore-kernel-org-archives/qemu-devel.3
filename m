Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E878C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZDh-000839-GQ; Wed, 24 Apr 2024 05:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzZDf-00082R-Ew
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:47:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzZDd-0006J4-BL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:47:15 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e83a2a4f2cso38140515ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713952031; x=1714556831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pjr70G2j0okcAKa9B3Ycs4M/p/U4C6krFHySQG7Bkhc=;
 b=bRwF/nkkrt8wAi1Yn2xFi6uWvwnc6iddqLFbRWC+ZO0ntVTaZrtTUNvdCJaQxPTzDF
 iJsgpnXPxGYmtu4vxWQTFdXvIcOmAb8UiPMycw8XVW+SZIMzhHvLNzH3ZjiZUyzQwRSW
 d/O4GuLMCtXOHAYb8qKqO+NnQ6cxmQWXPPmkTWpGe7SqbTs4gFeFwIJyLNULB5b9zuG1
 Ddz2M0ebHDsGXPBuHKYxXtT+Lwv4+VMTaEmwSCO7znVfmc8QZQeouQDMawZ7+j+nUVIL
 AdwT7xGX8NWK2ihVDo4Bu7Gf8vGI8xytK0DZ1wKE3D43CSQ+UwbTjxqO8DaRZQq0KDWF
 2AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952031; x=1714556831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pjr70G2j0okcAKa9B3Ycs4M/p/U4C6krFHySQG7Bkhc=;
 b=RG+9IVfv2IVJ+0oP41XqpvqkViF/7sFOshzq6Zuun4PFhMCtPnOuQ3m9GulDDV6GCo
 zlYyLIgsHa5kPqbGS6l+5nWOVpBOcVVxK9dSDjfbvyHwYlvJo8wrjb0a1QOXQV5BxGRO
 2rJIgdK5Vn4TqHJegsJokwETi8SKztIe3EKGiDZ1rBfpr0GeGrmJcfM2LlDj7/63F/ZV
 bPZc6ph7YlqAh5lMjdfLu2VT1O/BWIiSN0rC/dbKxEi/oezsfbFm3ZRptuoql7XrBfKb
 4W3AqLHwJVYCDCf5LQqYs9mKbkUU2r6DHuPEVHZeW7N3xCubvkrVD0wss88lfrTvFSB8
 zYMA==
X-Gm-Message-State: AOJu0YxlyU+sd7+ZxAlH0rrN+OxD+lnMAVDmzMuB7fuIZ5eBT9DB6CdU
 El/vHm8umz21nsPykzyx8k2eSgcfM+kzKdlClxaJj1bR7PA7sgdIxSXWVOkPpo0SeBN86H2RvpO
 y
X-Google-Smtp-Source: AGHT+IHtoVFUxRODk42R53WBWKPTpxqRGPbEBezzFFi3j6ePuEgoszGdu+j/slBPXZqaIbYiEgeehw==
X-Received: by 2002:a17:902:d2c5:b0:1e3:dfdb:ac6b with SMTP id
 n5-20020a170902d2c500b001e3dfdbac6bmr2554144plc.4.1713952031182; 
 Wed, 24 Apr 2024 02:47:11 -0700 (PDT)
Received: from grind.. ([191.255.35.121]) by smtp.gmail.com with ESMTPSA id
 y24-20020a1709027c9800b001e0d62e077esm11513389pll.247.2024.04.24.02.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 02:47:10 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 mjt@tls.msk.ru, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/2] riscv,kvm: remove another strerrorname_np() 
Date: Wed, 24 Apr 2024 06:46:58 -0300
Message-ID: <20240424094700.453356-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
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

Hi,

strerrorname_np() was removed last December due to problems with musl
libc builds. And then I ended up adding another instance during the 9.0
cycle (commit ).

So here I am removing the newly added instance and, this time, patching
checkpatch.pl to forbid this function from showing up again.

Michael, patch 1 is qemu-stable material.

Daniel Henrique Barboza (2):
  target/riscv/kvm: remove sneaky strerrorname_np() instance
  checkpatch.pl: forbid strerrorname_np()

 scripts/checkpatch.pl      | 4 ++++
 target/riscv/kvm/kvm-cpu.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.44.0


