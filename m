Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADE3CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 00:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Yoo-0000Ej-V5; Sun, 05 Oct 2025 20:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v5YoY-0000Be-Tb
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 20:10:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v5YoW-0004Du-Ka
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 20:10:54 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso3744044b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 17:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759709448; x=1760314248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OuS7+ZKbuBk4SP5WM6xYOzaowjiA7XoTY6cu4+HNTpc=;
 b=JwYtd9PTusXMXW1ekWHIw7W2diwdtMUQiJj/nfiijq7QekpabSCQmBRSf73TcdjUcV
 XZMcwESRIT141iBWehSyG+JK4rafqQTHU8Q0oPMrEzy7P3ZMLACDa0i2XzlTs7pt44Hs
 SoLTEMcOcL+VLoE6Lvtx3qjM44aGG5qUdHrlLoXf2vj3oPz4i7ddUwl2bOW/DWojBdGf
 m1vDHFnNdHfT3IWlYiwNzR83HDaeKVf+dwNagntg02NMtoda7g6VkI+K0lGsPzJKJH+d
 gYc/xg8jV74PidHjYqlCcTMAFXtqXnMxR4RXE/lgoFhE3VTkeIYMqP+SjV3svDv1masR
 AChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759709448; x=1760314248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OuS7+ZKbuBk4SP5WM6xYOzaowjiA7XoTY6cu4+HNTpc=;
 b=sGZPAc93DyqrZgwCWMO9WwVa/50rXl7BPvPasivWpP3VUGm65P9Q4DXAgaGf4ruNfx
 ab2OYfY/ZEfzuDTZAxUhcXVx3sI9J8UIcNKBh3VP5kfMhVjvpgCneIz4t+HgXI427MP0
 eULGO4XRppvjdHWf6NeFGaH+F9iPefjPV2NTJwK+dZi72SBT3Rw1xuTRvPF4ZqFOct3S
 eD1DUiyqoM9zKLTACmDf7+MdfYyF9uc3USixmOSJdg979qBvOZST7sAxBEnQjONmIIsb
 Il28nbhQtZSHTMW6TN81BXZGkbdRnzrKBGH39hysh9P/h4f06Jj4wNm0cQa3l/99xl4W
 rmHA==
X-Gm-Message-State: AOJu0YzEarRbgFIChY8E232n8dr7LGlYqKRbXGYXO6TM5WjrSZXPR1aW
 8m0IUH5UIs8wXspGX03iOoybxwbA/S3jLgc/k6C00kD17WmYMTygJ/muhwT3Zu+i/qp8nFQ0iek
 por/Q
X-Gm-Gg: ASbGncsbPFgfONKR8IVLowdRJnPMPKSL5BOQ6va8pkoXNg6cEQSQ52cZt63MNpirPDm
 tTKnlBXER7x0lXSzrH3llGc1/u4JEYdGckVgSBiLJzIdH/p869nyIX1/Uj19QcHyD8MxjnDG681
 tHmA5eCptQiLY0H2s9puxF3axNqlHBEtBtO3ujyaron8PrlgxZuObTzjighVnQp8m+Ktbxe4UML
 +TdvstgtCwt6F099Fi68ZK56XxvsYfqdhSVYl84XmKeHwl37ngADJdgNW102910+xrDQ1oFl+Yi
 DNGci0gqYdNx4M4RiWxl0grfZVZ433SGi9aGX9+S3ztQnyHRVEpXsoNVQ32W6iUPyAtDy4Yyhef
 vQWYv7+GLovA4OaZFq2VRdKHK4S1qI13ux8IHTmzxOZgLuKduq5x0fw53
X-Google-Smtp-Source: AGHT+IEyarihjdgmKFJ/vIIUmuIRZG6MmBWTkimtj9qZdB8dyUT9TO5e/3FZ6Cm0kQC0P2NTkteafw==
X-Received: by 2002:a05:6300:6145:b0:32b:7334:edcd with SMTP id
 adf61e73a8af0-32b7334ee86mr10626906637.60.1759709447989; 
 Sun, 05 Oct 2025 17:10:47 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339c4a48584sm8804881a91.23.2025.10.05.17.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 17:10:47 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v10 0/3] target/arm: Add FEAT_MEC to max cpu
Date: Mon,  6 Oct 2025 00:10:15 +0000
Message-Id: <20251006001018.219756-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x436.google.com
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

This series adds support for all FEAT_MEC registers and cache
instructions to the Arm64 max CPU.

It includes the FEAT_MEC registers and cache maintenance instructions,
but does not modify the translation regimes to support the MECIDs, so no
encryption is supported yet. However, software stacks that rely on
FEAT_MEC should work properly at this point.


Cheers,
Gustavo

v10:
- Addressed comment from pm215 that registers with opc1 == 4 or 5 must
  actually not trap when nested virtualization is turned on. This
  resulted in one additional patch in the series:
  "Add a cpreg flag to indicate no trap in NV".

All previous versions of this series can be found in:

https://patchew.org/QEMU/20250727074202.83141-1-richard.henderson@linaro.org/

Please note that the patches related to FEAT_SCTRL2 and FEAT_TCR2, which
are prerequisites for this series, have already been merged into master.


Gustavo Romero (3):
  target/arm: Add a cpreg flag to indicate no trap in NV
  target/arm: Implement FEAT_MEC registers
  target/arm: Enable FEAT_MEC in -cpu max

 docs/system/arm/emulation.rst |   3 +
 target/arm/cpregs.h           |  11 +++-
 target/arm/cpu-features.h     |   5 ++
 target/arm/cpu.c              |   3 +
 target/arm/cpu.h              |  10 ++++
 target/arm/helper.c           | 109 ++++++++++++++++++++++++++++++++++
 target/arm/internals.h        |   3 +
 target/arm/tcg/cpu64.c        |   1 +
 8 files changed, 142 insertions(+), 3 deletions(-)

-- 
2.34.1


