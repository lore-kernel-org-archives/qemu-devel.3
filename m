Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E081BC3065A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz7y-0001Xf-1O; Tue, 25 Jun 2024 01:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz7w-0001UD-Ht
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz7u-0001Ve-SC
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42198492353so42944635e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294837; x=1719899637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=804adpboUNUGoA4+SC+knsCmSvv2ypFpRddNkdj212U=;
 b=khhbhqOSNw1NXkN54+mnpJ1aEidlRFZJK8sBoLs1K0rSVxlbiZWr/kz8HQes05exPj
 XRavPZbpsHWvJn9IB1qxVYmLU7iz/dJcWSiUgYirpqoGAf4xfk1P602FrbGBZaz7pZl2
 WNwpQQNODsMguFIfqiPZiIAnMc+uOkqk1MUxLqMSeyGy2/r4RLgw5a710SZLLhwpgPEQ
 KtiJDSRzCpu0HVRT40FWcAd7WkRzMKHjM1dcPlYrG1XiVmdx98krgagHRj2o4+2Hnpzp
 DfRc+CGUvhW5IlUDVKT0jeSl0qh5NE3JSat0+TJtKKlvB9oPQe4vcB8fdq8DFpavUG5t
 WhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294837; x=1719899637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=804adpboUNUGoA4+SC+knsCmSvv2ypFpRddNkdj212U=;
 b=gxDlN+/6QwfuIQwb2GCkq3pf+Mb7zXOIBwhUqJ98GdGtQv0iJbISiFY2zTnE9Jas+8
 oOwXIVOCK9a4giREX6FcuFLxBGNGKENDO4ixbYNgyhUagbEOA82WaLwosurrV/L7I2bF
 QbfCbhOLIpVw0eMRzWxVA1uIMnAEhKPOudFStIcQK2xmzvEZPEyjSVaYvRlwT9g5wZ6b
 oij5G8cy6mVMTwekoRAritnDIqJzaOEVqQcqlONesMC1q1hcfNun9MNIpH3+9qrIRGeY
 KqnzPXbFkIHM5GS6wXFePc6XgWd5+C+zmSyHTl89c1WfGaKXDEdoVyT+3rlZxfY/kyZ8
 txOg==
X-Gm-Message-State: AOJu0Yz5VmZswdEFqyvOzhKvrfO5tNdmvUWDjrmqdX63Cy4ZPnkL9l2l
 szmygyN2N/k0US7mbBMh67ktEz/FEZavkIN/YgMUbKmKqrbLC8civuxXU+MCzv6V/9v62/dlyCK
 h
X-Google-Smtp-Source: AGHT+IFoo+kPnu+PM0y+CXXTwn8nPy+ObjU/cNMedYnnoChzlIaDNG/9Bu0OsUH/wzj42ktrzZYpSQ==
X-Received: by 2002:adf:e990:0:b0:35f:1bc3:50b0 with SMTP id
 ffacd0b85a97d-366e9652995mr4101611f8f.63.1719294837063; 
 Mon, 24 Jun 2024 22:53:57 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8cb6d2sm11843817f8f.111.2024.06.24.22.53.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:53:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 00/12] hw/sd/sdcard: Accumulation of cleanups and fixes
Date: Tue, 25 Jun 2024 07:53:41 +0200
Message-ID: <20240625055354.23273-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since v1:
- various patches merged, few more added

Various SD card cleanups and fixes accumulated over
the years. Various have been useful to help integrating
eMMC support (which will come later).

Philippe Mathieu-Daudé (12):
  tests/qtest: Disable npcm7xx_sdhci tests using hardcoded RCA
  hw/sd/sdcard: Generate random RCA value
  hw/sd/sdcard: Track last command used to help logging
  hw/sd/sdcard: Trace block offset in READ/WRITE data accesses
  hw/sd/sdcard: Do not store vendor data on block drive (CMD56)
  hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
  hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first (ACMD22)
  hw/sd/sdcard: Use READY_FOR_DATA definition instead of magic value
  hw/sd/sdcard: Assign SDCardStates enum values
  hw/sd/sdcard: Simplify sd_inactive_state handling
  hw/sd/sdcard: Restrict SWITCH_FUNCTION to sd_transfer_state (CMD6)
  hw/sd/sdcard: Add direct reference to SDProto in SDState

 hw/sd/sd.c                       | 119 ++++++++++++++++---------------
 tests/qtest/npcm7xx_sdhci-test.c |   7 ++
 hw/sd/trace-events               |   4 +-
 3 files changed, 70 insertions(+), 60 deletions(-)

-- 
2.41.0


