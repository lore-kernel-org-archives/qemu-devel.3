Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD5EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reW0Y-0004Yf-RC; Mon, 26 Feb 2024 03:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reW0X-0004XX-B8
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:06:41 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reW0U-0001bj-Oe
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:06:41 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-512e1991237so2114864e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934797; x=1709539597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QpvoCsIbtwiY1HT5bcdk+eqvDrOmo4Ep9MNjGeKLbL8=;
 b=qRHjyq9OIgfdfugl3Xq2T/6C9wQ/PYGwWWXEUrz84CRdyHWO0CeHS0nyNZuU8/6l0/
 qkMa2V8Np7wxlRk/vRanLGJ8ndtYsICY4+hF+AhVY6EB/2fdg1fsa2bQnlGGLAbOfTEb
 z2TR7OqyFWiI+/+pulbYrwVSQq/fEy+teiaXaOMxyxdUw6T4l92oh3E221GlvXcuGv6D
 XqAqw+3txazo4wzWuv8VVX1ERi9Qqa/9VPean86ng55TAiidOlVA+mP82GELyJf/BZKM
 oUttJLIhK+33o27QGsmaR5a417GQqidhmnnbqI4HRPIuoCYoWVnBZ+HynYgkOxBx2SAa
 NumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934797; x=1709539597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpvoCsIbtwiY1HT5bcdk+eqvDrOmo4Ep9MNjGeKLbL8=;
 b=OIeuwHG+3E1BacANUj/EGK3F7fdJA9iBxF19qHUxuplCPtw5LL/6saKUpH3UeK1e3r
 Fke+bBgwXfATwpg5yuItnGOKUTpqOcxRcUFaeTHMe1nrWhZyNVIg8+S5jRdgZ7kA0u4H
 6x+zv1m1603B7aMzFb+WMNVWYN4Ixmp494ma56ckfB4B6MIAvLReuIsD2RdLwz4TOMbA
 sNop0I48xCbAlilDDdA3wTXy6pKkjOIypOpENAef+5ii1cuSzyeUyFjknqG8toOFpWo6
 7ffQd48eOFwq3gL1Vg8nMElT3qNPFNyAhZLFONN3XrsI29AzVJYSYYn/UVgKZdabHEHw
 vWVw==
X-Gm-Message-State: AOJu0Yy5057rC472EB6dJbGmCVvdXBHNguxKgpaCdqxOniP/k1PW0BIT
 OvsaJiTy5ENuvVRyaoZq+rpITKkHpaEh6D2KIBe5DmZ9ZuRmwd9/Rzs6Bx9ZU5HCZDTcD5/GDzf
 j
X-Google-Smtp-Source: AGHT+IGhPhxQBg5UCRWmPKpyYNLmhzOF/f1t+2tx1sTKr2jd9F/y5jjss3+yDlxRsv1LCqg+uc81cw==
X-Received: by 2002:ac2:4145:0:b0:511:463c:32c1 with SMTP id
 c5-20020ac24145000000b00511463c32c1mr1591499lfi.19.1708934796730; 
 Mon, 26 Feb 2024 00:06:36 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 o26-20020ac25b9a000000b00512e1361dacsm754030lfn.299.2024.02.26.00.06.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 00:06:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-block@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/3] hw/ide: Make "ide_internal.h" really internal
Date: Mon, 26 Feb 2024 09:06:28 +0100
Message-ID: <20240226080632.9596-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Missing review: 3

Since v2:
- Remove local 'ahci' variable
- Rename "ide_internal.h" -> "ide-internal.h" (Zoltan)

Since v1:
- Remove use of "ahci_internal.h" in SBSA-Ref
- Rename "internal.h" -> "ide_internal.h"

Supersedes: <20240223142633.933694E6004@zero.eik.bme.hu>

BALATON Zoltan (1):
  hw/ide: Remove last two uses of ide/internal.h outside of hw/ide/

Philippe Mathieu-Daudé (2):
  hw/arm/sbsa-ref: Do not open-code ahci_ide_create_devs()
  hw/ide: Include 'ide_internal.h' from current path

 hw/ide/ahci_internal.h                             |  2 +-
 include/hw/ide/internal.h => hw/ide/ide-internal.h |  0
 include/hw/misc/macio/macio.h                      |  2 +-
 hw/arm/sbsa-ref.c                                  | 13 ++-----------
 hw/ide/ahci.c                                      |  2 +-
 hw/ide/atapi.c                                     |  2 +-
 hw/ide/cmd646.c                                    |  2 +-
 hw/ide/core.c                                      |  2 +-
 hw/ide/ide-bus.c                                   |  2 +-
 hw/ide/ide-dev.c                                   |  2 +-
 hw/ide/ioport.c                                    |  2 +-
 hw/ide/isa.c                                       |  2 +-
 hw/ide/macio.c                                     |  2 +-
 hw/ide/microdrive.c                                |  2 +-
 hw/ide/mmio.c                                      |  2 +-
 hw/ide/pci.c                                       |  2 +-
 hw/ide/piix.c                                      |  2 +-
 hw/ide/sii3112.c                                   |  2 +-
 hw/ide/via.c                                       |  2 +-
 19 files changed, 19 insertions(+), 28 deletions(-)
 rename include/hw/ide/internal.h => hw/ide/ide-internal.h (100%)

-- 
2.41.0


