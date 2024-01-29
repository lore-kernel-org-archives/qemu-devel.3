Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F88EC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUec-0000l7-P3; Mon, 29 Jan 2024 11:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUUeb-0000kn-1j; Mon, 29 Jan 2024 11:38:37 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUUeZ-0001RI-FH; Mon, 29 Jan 2024 11:38:36 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so1517713a12.1; 
 Mon, 29 Jan 2024 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706546313; x=1707151113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l3oD1/kE4ZOEtb13iqXQI6UtXT+YvwVYaudk4ZLMHqo=;
 b=MyU7m1LeJqJE4e+P0Gs82PNI2IJEztsUWjx20fPGyZ4tb3qvJg3vR12VKXTkDiNERF
 KHnmm4Ev4tegbkbgmzYJWPj3nmzCmz8bS3lbtMQAxwe4LAyZpEZRTFiSqhi7uY7FL2ia
 FQAG/teLm5yfSVsoSe/N014aU4vYxKYdHpWV/xD5USbvEjNvx+yq7jGGXIEqHhTYlryq
 XPNQebgPygAvlQgZdDoIXu6BA5PwayhMRcczcvWlkpLPLhyO291cs36XuO6+WkhB5qZI
 gUT8+ipRdSxgFHOw78nCZWfJDYQ58s4DGrdjihB80L7Gco+bY7FEC/W50fQD/ntRus2E
 DSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546313; x=1707151113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3oD1/kE4ZOEtb13iqXQI6UtXT+YvwVYaudk4ZLMHqo=;
 b=T+MXZQggQcLoUFWUiwOqC0IXNM//P71zTLxXlcALGGk0FU3+OHunu6SHw0j+4Qyrm0
 lbk+LgBZQMXMM4xT6pCmPS8r+psJPtZW+gfQBcEHlwwz3+C3dlY7XA/FXhLW7O3Ye40z
 vaVLrwZWcpNFZfdRcIHkUvXXfZy5QBRM9GA/Fiz14pObpabQjk7IYK0OCFAW6XlB7Tua
 pU+oHjaJPRJ2G3x3W+O28lsIqCkpI/Qnb2GXgATH+EO4T/Cdw+aA7m9Ezi5D+L7hjYih
 j3UlNeJ5xC9In65zB2lTVJ+jWBaRHxejTgAoltkl9n7OlG62VlwxZYOXC8K1DEBvxs4B
 vzOA==
X-Gm-Message-State: AOJu0Yz9/uMKOAg6hD5rWkjWZL6/XG5GsUokhBJNMD0QuNnO1M9tLqL8
 /0iHsHAN1kxNyAIpoUjZ6zfQa1+aUsEmdzRRnLwkS4K/wZZwEL911UklBbw7cKyHtQ==
X-Google-Smtp-Source: AGHT+IE6bhTzsoteBnuinZxhYFLESIvJuDHwlF6prZlE8Wkn+wRUQ3JvLLEBfPQ72z+dXOyuR6eOrA==
X-Received: by 2002:a17:90a:fb51:b0:28f:eeda:e9ad with SMTP id
 iq17-20020a17090afb5100b0028feedae9admr3620534pjb.28.1706546313115; 
 Mon, 29 Jan 2024 08:38:33 -0800 (PST)
Received: from localhost.localdomain ([49.47.195.100])
 by smtp.gmail.com with ESMTPSA id
 nb5-20020a17090b35c500b0029464b5fcdbsm6107239pjb.42.2024.01.29.08.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 08:38:32 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: rayhan.faizel@gmail.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v3 0/2] Add BCM2835-SPI0 to BCM2835
Date: Mon, 29 Jan 2024 22:08:00 +0530
Message-Id: <20240129163801.2790257-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series implements the SPI controller for BCM2835 boards.

Please disregard v1 and v2 as I ran into issues with email submission.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Rayhan Faizel (2):
  hw/ssi: Implement BCM2835 SPI Controller
  hw/arm: Connect SPI Controller to BCM2835

 docs/system/arm/raspi.rst            |   3 +-
 hw/arm/Kconfig                       |   1 +
 hw/arm/bcm2835_peripherals.c         |  17 +-
 hw/ssi/Kconfig                       |   4 +
 hw/ssi/bcm2835_spi.c                 | 288 +++++++++++++++++++++++++++
 hw/ssi/meson.build                   |   1 +
 include/hw/arm/bcm2835_peripherals.h |   3 +-
 include/hw/ssi/bcm2835_spi.h         |  81 ++++++++
 8 files changed, 392 insertions(+), 6 deletions(-)
 create mode 100644 hw/ssi/bcm2835_spi.c
 create mode 100644 include/hw/ssi/bcm2835_spi.h

-- 
2.34.1


