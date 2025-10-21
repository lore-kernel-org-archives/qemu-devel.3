Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5966CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7yF-0008IL-B6; Tue, 21 Oct 2025 04:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yD-0008HP-3M
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:43:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yA-0000t0-P4
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:43:52 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso62617385e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036228; x=1761641028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+muwu4Xam5XibOYlX8DzcnL82BrVMx7yrTWGjYkAmmU=;
 b=lmI1Pos+NcOntgIHxnI8DVl1wTATWnpxVNm7sGXwsTbKU500lyFEDStYhICpNhPqiA
 WnyMLIT7Dx05c37UYPh8pew9koVZ6ArAHJ3KTbFGW537ysPFajo8HRpXrBQwh3lu26rD
 8fKC/9NhTSfnswNgVVWBgKdaJicx8xr2rntPdE2NHubKCZzAWtK+O0DrIMfyDZTZ9WYD
 q9UNqTbwE4BuNIHReXj2p9XWMXwDJZlvJXy5zhjLRowFNggTmc2TXWSxVTexlAyTriGr
 yoMW1Z1lQPLYslt1J0Ga82P1wt/eKjZ5PIs3+P0kdYtEbJlzubhS6n9syAm0bWno9RZQ
 ovzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036228; x=1761641028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+muwu4Xam5XibOYlX8DzcnL82BrVMx7yrTWGjYkAmmU=;
 b=pkEJ8jeyO2S+JaIBsXvOR80w9kxA4Bpl/dot4fyhfDSnSO1kBoPNMy2iHdvMCfYUEo
 xPaMnDdy8VB8iVE5AhGzmkEb54W4RRkADRUM47XpVwflEUC4FGQ3cV9c/O0OPUpVJREy
 LC356R4Qlgksm61oA/P6aXs2pCIf5V0AMBn78Or8E6ff/l/8MGLhClWcvgqQu1CcOy4F
 xtGuAaBDoozvVz0D92BEXlmaFH/2/gErKrv7wUN+9H7MTamEIUXId+l5J9IY7cSPvSGr
 8PyTFAMLLAvhr80GX/clDkUfRLyMdc9yVrmrwMP3NfDkNOHsZVjpPz0wYv8ejfdvii/Y
 SdBg==
X-Gm-Message-State: AOJu0YwFe206heOTxV/pi1n+jdV27yqDs6L8yXwUHiX+FNkXTg3F/N3k
 6lAejhh0ByDYeMlRUheqWzpit4bLU5OgKqyTq/UY9U6HFyk1Q5GmZ1ZIvAvR6zzaurEKcIwInsj
 Y+VNnIws=
X-Gm-Gg: ASbGnctYDUn/ud+xi7xgOo6dKm59tildftJqfJpXD4h7Wyk/zYwFytdv56iBm3udMn6
 Qko5YAYDGh+RMTTeOEgZ5CcKc9PJmwjbeAZ4aiEXE6zbSsuLrPx2v1ED/YPsoav4RWIvPKM+Vfv
 LhuAaE7pyiwsL4rpBb4FXHGvqc9VjJX7OObMeQ+HxndBbbwVm40wX8ZiOvLvS1adAPEO3+u5iwb
 CMYO0bka00pBwHiMrnJNfR0t8ql9kd1GmhY+72b3IyQOr8tCqfmqKCr+GceEFZNmitFDSfgAHL6
 pilSNgFjUpg1qdgV3tDUaRvbyWX1zelWbWXiVZrW8GM9tOkWf/8nSKjW6f7sXFH2poZDwFgY5+P
 Ec87HJDbODL5wJWQOFsLCddtXDCWrjs0zpbrzKaD6ZgFYriv1IucUGkUIXXmnyohkZU9sD1+24n
 4URHyz+1dk8CF6wgAa5C/TE58jpqeD+gYM6pPmggpm2KWi0HyTaw==
X-Google-Smtp-Source: AGHT+IE7GtUSdaMfEfq7t++7TU2o9GEgYfFa/E+TGLczbRaZ8WXh9AgLbbe349k38YMAGQbyuc2DBg==
X-Received: by 2002:a05:600c:4e0b:b0:46d:27b7:e7ff with SMTP id
 5b1f17b1804b1-4711791f4e1mr112188045e9.36.1761036227949; 
 Tue, 21 Oct 2025 01:43:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d269dbsm11269195e9.11.2025.10.21.01.43.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:43:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/11] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
Date: Tue, 21 Oct 2025 10:43:34 +0200
Message-ID: <20251021084346.73671-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

v2: Rebased on https://lore.kernel.org/qemu-devel/20251009184057.19973-1-harshpb@linux.ibm.com/

Remove the deprecated pseries-3.0 up to pseries-4.2 machines,
which are older than 6 years. Remove resulting dead code.

Harsh Prateek Bora (5):
  ppc/spapr: remove deprecated machine pseries-3.0
  ppc/spapr: remove deprecated machine pseries-3.1
  ppc/spapr: remove deprecated machine pseries-4.0
  ppc/spapr: remove deprecated machine pseries-4.1
  ppc/spapr: remove deprecated machine pseries-4.2

Philippe Mathieu-Daudé (6):
  hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs field
  hw/ppc/spapr: Inline spapr_dtb_needed()
  hw/ppc/spapr: Inline few SPAPR_IRQ_* uses
  target/ppc/kvm: Remove kvmppc_get_host_serial() as unused
  target/ppc/kvm: Remove kvmppc_get_host_model() as unused
  hw/ppc/spapr: Remove SpaprMachineClass::phb_placement callback

 include/hw/ppc/spapr.h     |  16 --
 include/hw/ppc/spapr_irq.h |   1 -
 target/ppc/kvm_ppc.h       |  12 --
 hw/ppc/spapr.c             | 299 ++++++++-----------------------------
 hw/ppc/spapr_caps.c        |  12 +-
 hw/ppc/spapr_events.c      |  20 +--
 hw/ppc/spapr_hcall.c       |   5 -
 hw/ppc/spapr_irq.c         |  36 +----
 hw/ppc/spapr_pci.c         |  32 +---
 hw/ppc/spapr_vio.c         |   9 --
 target/ppc/kvm.c           |  11 --
 11 files changed, 77 insertions(+), 376 deletions(-)

-- 
2.51.0


