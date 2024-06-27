Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2486AC30658
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 07:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMjHQ-0006BI-Kz; Thu, 27 Jun 2024 03:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMjHO-0006AQ-Nh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:10:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMjHN-0004pM-4K
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:10:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-421f4d1c057so59086275e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719472247; x=1720077047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ifmD9XolgANBmWmPZz4cr9fVixRp2g7xKqtLOrjpZoI=;
 b=lkkn+Fp5MUMJAKgSESpQuzcbrB6fBnUvtwE/24zD8pCP7/DEDasUniTKUdxxAXJ++M
 pYKqoAfiEE854hIhsmR8uTHiZ2SU/x1n+IIdssWFH3GigOmGJLdOA6ylUk/NumDn0Z3z
 SVKAG7RIz1TG8tunIBm2O/SMzzuKUhtcCR8ciLH30tR8xEPllOjoJE1wXyMBXdfRQXQ6
 xf0KqjfwDW4icaPDlQ8uJQMfW8Aztsxmk+ew53Y+qaNPNUqjFYXZwknUvISrMhIn6Byn
 sYt8PKeHbyaW//tKcdv006lnFLWNP2TWxgn5fb9cRS2xDzE7kOIW8j9f1utqcPa6WrYG
 qSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719472247; x=1720077047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ifmD9XolgANBmWmPZz4cr9fVixRp2g7xKqtLOrjpZoI=;
 b=jKQkhN3IofV0r2/NQLiDTetrs26JjdPO/PNYn3gYY4HETtfrap/q7kHV5p1lRxSV/Q
 JJNX3J35RtnXq6WuMckMc6/N6ttnAMg/vIN9FVkg27/CJt392TweGIacakz044WNW8J+
 Bzkdf/mBFKrHrvtM9l7GZdMywdCtlvF1ko8MfcjqW40KaZDYXkPIg6UTZ2Afh+AJu21A
 4Sddx+6bV0tN25WVkLQ6eqTj6+IplcPVPB7fet3hoJKKBpgE6P1Uod7b5LrigLwawFku
 ZCCEm95kojScXrHuXxPr/LGjbYWwfknL/FmmoGTWCfdhIk1xW0R9Td17LobZnjjL43AY
 dR0Q==
X-Gm-Message-State: AOJu0YxQMkwYYYdtJLxW/50W46bEp68GExeoz7INjia0H7/gsOwhtJUl
 tPe6xOeHhOiErVS5Hr10NChoEJnoEL7QmphoBR6C+ASRrRDBwdrrMXb8KiZ4c8XS0BloTM401xB
 Ajmo=
X-Google-Smtp-Source: AGHT+IFMuk0FXhQeNP//v7igOful5DTowMC0oSnsVt66D20I4HrVj9pzfJtU6CMc4oUFxoUQKyFhJg==
X-Received: by 2002:a05:600c:26d5:b0:425:6262:1cc2 with SMTP id
 5b1f17b1804b1-42562621d7dmr13384915e9.34.1719472246981; 
 Thu, 27 Jun 2024 00:10:46 -0700 (PDT)
Received: from localhost.localdomain (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bb6caasm12151685e9.33.2024.06.27.00.10.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 00:10:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 devel@lists.libvirt.org, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 0/3] hw/sd/sdcard: Deprecate support for spec v1.10
Date: Thu, 27 Jun 2024 09:10:36 +0200
Message-ID: <20240627071040.36190-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Deprecate SD spec v1.10, use v3.01 as new default.

Philippe Mathieu-Daudé (3):
  hw/sd/sdcard: Deprecate support for spec v1.10
  hw/sd/sdcard: Use spec v3.01 by default
  hw/sd/sdcard: Remove support for spec v1.10

 docs/about/removed-features.rst |  5 +++++
 include/hw/sd/sd.h              |  1 -
 hw/sd/sd.c                      | 14 +++-----------
 3 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.41.0


