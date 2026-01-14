Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8073D30CDB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 01:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfph9-0004Yh-Ts; Tue, 13 Jan 2026 20:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfph8-0004YQ-FU
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 20:29:10 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfph6-0004aR-4t
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 20:29:10 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso5157655b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 17:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768354146; x=1768958946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=DfSsqrY4m5l9wqNcAohTwErrcLasKN+T9wMXTT1IpDs=;
 b=X0t7ZHT2dWnDhww6MKa6xCsfnhhPLxX/NrpBCKuA/XYEQSR36jE7fbX8JIxecaBBg9
 Z8m1ZCkM/g5YReNFqZ2R/MBis+RzlVXjrouHP9u5XYE6LP4T6Q8NaoNILz2Ieo03aTBJ
 ghwNBvdv+6GG2GaI085QVdwg8RhwRT9CXyIEc/b8MQlAWFhS7Yo4zLiNNQRChC6jJeYt
 qJQOIOrOuO1cY6dyWItpou4Rcwo+6EUHsn6Mdillh6EpoQzTuMcuHab40Kypz+rjHkhF
 AiKEzNzVMX8z9netwAK4qOyJJyAYIeiY6oGAwbeoWgQtBvCen+JS/5wkJ9S2Byxx+Y33
 tSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768354146; x=1768958946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfSsqrY4m5l9wqNcAohTwErrcLasKN+T9wMXTT1IpDs=;
 b=VGC17eqfjKaj4dm1RtDiD5ynTBWbFlACyUzY8sd2Jzk1cd464ByWSFetPcPlrgWHhg
 Ro59BGFZP6dijpi/kfycWBiehLtlOjelujLp/9bS3lG9kTFIu7WeELKzi4iyhapGLqId
 EEPtmgDgVyDE9h0/XGsI8SROjvvO8XWmAHRcROqXKJk7bvwMkIY/exsf6h5GsPZm0IPj
 lWoKXEDcN5zK+qU5fHMW5mYx/1Gjo7Hj16l7DqMwiKPIRh4lIfagvX/WbHvwDP8uFMMF
 dXA1C3XVRTICPqF0uUMDfGNnMSQs9PSxAVTe2V1ZNT/sa2jHTsUsqD+IXdbhG2IGpunN
 52vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7JxXDPeyX3lL5QF/v2BQmpXjPrtgk8lKA1dIkMZaxW/plM2UprUNqDJJadIFVsZPC5vpWCLxISLgF@nongnu.org
X-Gm-Message-State: AOJu0Yxtk676mzxsk99flxQV7qyN3rz8s4SJhFnL2NbOoeZ+des9+vl8
 mEjNmZOag+Kx2AolpuDetsF899QtNi7HyZKmLm0DLB1SYSGb9QOBfEXV
X-Gm-Gg: AY/fxX4pwBXBiAo/IWCLlYbtnDLPxp+oJnEy6D0yURRKSh6iNpJgtlaneGwrLaOe5uA
 UU7Q3gPCjSBo/xbLVX82Dwjqw/zXd+U38XMbW8Mk9HLEbMmKqvkwIVWCRUt9NSsKn3n2VmsTe1v
 4zHs1PCoOcZ9ok7VX6P+0lacFfg5Kd6msXqgO0yjADkT1ufr19VUyVnEMJ1YuePzijaBlJhlng+
 uDdcO0mpaXhTcALYb9oPF0ZMFImUzBBevtoCnxTzn87+F90n+jGHFdWIUWL2Ok2ux7jLz0MHUwx
 W59yBerx8P/IwbQeOI+lBMeXa7r29zDvK51f1CTJS3sH+UTOqwdWp/Ia2O/oAIodHMxwtZX8JRV
 I2b/pApRVKQRqN/LbqmT73fkKiKQiqjHZ58R8EuR90UkvmyBGxNdLuNdorCEy1DiODcoUie0kj7
 /0rx0x4fEIK3eqc6kV7eVd
X-Received: by 2002:a05:6a00:1c95:b0:81f:3ae9:3f71 with SMTP id
 d2e1a72fcca58-81f83cc2c99mr432030b3a.28.1768354146143; 
 Tue, 13 Jan 2026 17:29:06 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f3909d2cbsm10704108b3a.48.2026.01.13.17.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:29:05 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 0/2] hw/riscv: Make virt AIA setup reusable 
Date: Wed, 14 Jan 2026 11:58:42 +1030
Message-ID: <20260114012846.981884-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v2: Add assert for number of irq sources

Sharing the AIA setup code looked like a good idea when I was
implementing a machine with AIA. It will be used by Atlantis initially.

Atlantis will use 128 IRQ sources so the second patch makes that
configurable as part of the setup. I initially changed it globally and
that broke the virt acpi tests as the number is encoded in acpi
blob.

Joel Stanley (2):
  hw/riscv/virt: Move AIA initialisation to helper file
  hw/riscv/aia: Provide number of irq sources

 hw/riscv/aia.h             | 59 ++++++++++++++++++++++++
 include/hw/riscv/virt.h    | 30 +------------
 hw/riscv/aia.c             | 92 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/virt-acpi-build.c | 27 +++++++----
 hw/riscv/virt.c            | 87 +++++------------------------------
 hw/riscv/meson.build       |  2 +-
 6 files changed, 182 insertions(+), 115 deletions(-)
 create mode 100644 hw/riscv/aia.h
 create mode 100644 hw/riscv/aia.c

-- 
2.47.3


