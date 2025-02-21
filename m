Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DC8C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS7H-0006Ps-6H; Fri, 21 Feb 2025 07:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlS72-0006CZ-Ed
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:26:37 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlS6z-0007YM-Oy
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:26:35 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so53971265ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740140791; x=1740745591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YlUi+5h+dTXEv6y1UjiRTHdMrFHrUViOPWH/ccJ3Rq4=;
 b=SlJmIfaNOEFyWiv+w9voDsKCAA45VLhm+WfGNv4HvDGu6LreyJPPQCkAHRKzMg9+pz
 HbPkfwyYlG9bFtuLOqnsWYZFc5ZsdpvK7AXBGhuvSSSVOYDFcYCYiWLwxdeWBjD1BGiB
 lne/ZoW+Ld//c2w4sGFSW/Fml0Qfwwnojl6Syl3tJlyGeg6Yv53drAbTNJgPJVKh6u7t
 8t8+4Y7XTvIozIymYnTWEGktY5tFUFuomsRelpTBOgLjEJaJycP9QICkRptBlBlMiey6
 OpxnRDts1qGktxgo6FM3fcJI8cromWlP0NsMdGxestONwQaPhFWg2jlYcIjSSAPdIYIT
 ynUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140791; x=1740745591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YlUi+5h+dTXEv6y1UjiRTHdMrFHrUViOPWH/ccJ3Rq4=;
 b=cKXPaIF8vyxRuU0rHyEDM81X0zYtXiJwggheRg679EPHx8dExUhkIUFwaGrBgrnLQY
 F0kX6b2s5kP0yuQAjCMBG/GeA/G8nRSJj27I0eb6VeBsLaRNZWpnxmwEpRDQvG1Bviw4
 wMeKIXLVTeCQFph8YicJqFrYxvGgHaJQ9zIjX21L0KbQOYHaUHhgltJduQtGiHmqJGpi
 Hw540GwD6x4J9x6d1XGuR9FrYz/v7KAtue1V0MgTZngF14IG3xcMZpoYc67qcfHFg8Zh
 Lm+l/BLEE9eXbuiMKO9hi7OEkyf5skT4SZWJ1GhsJciF7y5u3YHcsQq3QpF2lIpl5nx9
 1GTg==
X-Gm-Message-State: AOJu0Yy0MABpnZnTJXQnsrWrOud/ZZ4SOV5eVQ5g3D0oyEn8Pd5wwn1s
 AAY5y2Giey26xfgl3mWYh3o3+s0FwLRdHFoB6aRb0oBObpl+1iqylxRik2vzchmOxpk85jWFzUY
 H
X-Gm-Gg: ASbGncsBU6krbGKxDBeWoPnfo7uABdjymWMVrmlVHDDEFiImAnShNjnLTUKYPy+4zf9
 f5CpMkJYoMuX/IQ/kIWTSjHVfqCijZXjTwGy5RTm+vQiz2xb5CZn0UZz293rjnWDo5aLj+AYBjZ
 eC1NR0qtVnhjAMoAz5f8XECNqns1KTPtlXJGT3CG4qN2Z1aiJ/sPY4V07MbuwwWq3ATatuRtKR3
 wO96bNRR0yC3nGTwDeMdfH3tmWmsmCyHtdAzPNi4qZNeViHEB2rUYnKGnydBJNlhMMV11SUXwiC
 KblSBvi2EC6o937YwLcGifImLp4BPpomuGM/YYz7hFHkUrgyjtUCuA==
X-Google-Smtp-Source: AGHT+IFs+lcVpRK96QUKNEET6MbFYyxW+cnk2RRwLTjgmka03HhHmE+oqXYsBQoOzNPeF5bu43uJ9g==
X-Received: by 2002:a17:903:228d:b0:21f:1bd:efd4 with SMTP id
 d9443c01a7336-221a0ed7e4cmr43304115ad.19.1740140790922; 
 Fri, 21 Feb 2025 04:26:30 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545e39bsm137349855ad.124.2025.02.21.04.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:26:30 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/3] target/riscv/kvm: reset time changes
Date: Fri, 21 Feb 2025 09:26:20 -0300
Message-ID: <20250221122623.495188-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

In this version the following changes were made, based on feedback from
Drew in v1:

- patch 2: reworked. Instead of using a different existing 'env' field
  to get/put the 'sie' CSR, we're adding a new helper that contains all
  reset vals for the KVM CSRs we support
- patch 3: reworked. Add two KVM CSRs from the KVM UAPI that we're not
  using.

Link to v1: https://lore.kernel.org/qemu-riscv/20250220161313.127376-1-dbarboza@ventanamicro.com/ 

Patches based on alistair/riscv-to-apply.next. 

Daniel Henrique Barboza (3):
  target/riscv/cpu: ignore TCG init for KVM CPUs in reset_hold
  target/riscv/kvm: add kvm_riscv_reset_regs_csr()
  target/riscv/kvm: add missing KVM CSRs

 target/riscv/cpu.c         |  9 +++++----
 target/riscv/kvm/kvm-cpu.c | 32 +++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.48.1


