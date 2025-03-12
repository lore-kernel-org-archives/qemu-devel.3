Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233E3C35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLA9-0001dZ-Mz; Wed, 12 Mar 2025 08:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLA6-0001dD-If
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:26:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLA3-0001cQ-FN
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:26:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224100e9a5cso125763375ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741782368; x=1742387168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QzrQ8uhnIfc8O+CnV/ngdUw4/a7C9L4XGZIEZVae+10=;
 b=ZNqgm5PGBGcaHHwthu3bxrg1u3j3L7RYfeKMKaaYUFUMMg8eAfkaSoA76d+9PXTyFx
 VtUOpcFd9xzzjWqxMn6HHkwN7XL8zxpbOAuA9YzbcqsfEGGoaeYdJZpIP0KKYapRiY0z
 E3mdz9cQa3ne29bqNuDRfb6D+eLkFk6ldSr/dXe8OVS96oYgS3PVfelhKw5S+B5/XZqI
 /fvPppJTPgGoElB6p2h9mSu+XmqV5jFD9HYCTskhNkEazk8yUd8mPyjbRSLCd4+B6K61
 sox7yqWKcysSaMqJ3sSM+oNa39iYZCoQ4RArzgGfqCxg7wsoP6KZ7mdPJBVXfibP+9oK
 21AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741782368; x=1742387168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QzrQ8uhnIfc8O+CnV/ngdUw4/a7C9L4XGZIEZVae+10=;
 b=DDAHUnQPKM1Udv23iBGjJISRVqypmFQEJsr+UKQT979qoAvA4rAQJ2IBXUpWfc8qkp
 nQE+9F57WLqiOxPNkHiNUiILa20h+ChZ8HHOBG/c/F7B97n2sp5OzEkB93RfULF5UPVz
 Sb0SSz8SL79BDQL/2Y+KUOYIh/yseSES/aWLi9WtJx2BQOY+4I1q8fQQsHdhOPM5Kzzr
 /2GNkhufhnvtYt1FNt8rknqqYKjbYY3B9i9demSd/GkNs8xwwinPa6vgvLeVNvRY9BN1
 KfVzdN8Dgj6D2O6jftRmbUyZ54qOXZfvWVMr+WbzYJO7GXSu2xvwOfistDKaIo0Kyipf
 h4Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeZrWFmXFwkXlURIMy6ACkN+Bh63JC/Zq2vcfyNt58CnStG2Dwg7Lt93drtFCdiDOWaXrdaItAo/Vz@nongnu.org
X-Gm-Message-State: AOJu0YwFTdwrH0n51nJpJxZc+NYcoNpX+U7ZKydTK0t0fFPIUVgsSwbZ
 cfbfwxmOcbFraUYUU4efaWCC7G4EL0ulqd+cRDginODN32sSYWgOf0/hQQ==
X-Gm-Gg: ASbGncvcnfr7Tk1LMfQkErL658LMEFmAVCpnprFbsLxrR3rKXo0H6VRdKZ5DzU5TakV
 jiAVMwa9nXSx+7V4XPYSBB+Tnql5h47GOu5/VfwCioGjpiFU7zTQAT+rhN/gZIpWbz9fl7ZAkZU
 vsOko82b4AT+8/h2q4Z8Mq2SmJieVjJ5230LgQoGN6t+HPvMbc1QURL0nLrbwNWWWsxaEtD8clQ
 R8N1lerRdhGJwYgOEBswlCfG24eC8bggHsiLwYNzLEXE1KYZPyGnNCllEKLqNOCGpgtILd0PBMo
 awKsTkD9pr/sa4rySFJi4DuMY2rAZZVuIQnZsBC37SpXy4EvQ7JHYpF+S0SA6w==
X-Google-Smtp-Source: AGHT+IEIAmRN9tOGl0SdPFHFRRP81MXvgdR6p07DdlZDJcTlWE92qsxMcNqIf628nEqTBdy/BRWZtQ==
X-Received: by 2002:a17:902:ecc2:b0:221:7e36:b13e with SMTP id
 d9443c01a7336-22428899c47mr346180815ad.12.1741782367854; 
 Wed, 12 Mar 2025 05:26:07 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ab33e1d3sm10842408b3a.132.2025.03.12.05.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 05:26:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] tests/functional/asset: improve partial-download
 handling
Date: Wed, 12 Mar 2025 22:25:55 +1000
Message-ID: <20250312122559.944533-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

v1 discussion:

https://lore.kernel.org/qemu-devel/20250312051739.938441-1-npiggin@gmail.com/T/#md49b293a64207b578600a8c428bccbce3d471e68

Changes since v1:

- Change retry exceeded handling to be a check for no file
- Tidied comments and debug leftover from patch 2
- If downloaded size does not match, the advertised and received
  sizes are now printed in the error log.

Thanks Thomas and Daniel for review comments.

Thanks,
Nick

Nicholas Piggin (3):
  tests/functional/asset: Fail assert fetch when retries are exceeded
  tests/functional/asset: Verify downloaded size
  tests/functional/asset: Add AssetError exception class

 roms/skiboot                        |  2 +-
 tests/functional/qemu_test/asset.py | 58 ++++++++++++++++++++++-------
 tests/lcitool/libvirt-ci            |  2 +-
 3 files changed, 46 insertions(+), 16 deletions(-)

-- 
2.47.1


