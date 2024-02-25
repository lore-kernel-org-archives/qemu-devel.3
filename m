Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2DCC54798
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 17:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reI7K-0001rZ-FJ; Sun, 25 Feb 2024 12:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reI7J-0001qm-D6
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:16:45 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reI7H-0003vb-4w
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:16:45 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso1190425f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 09:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708881401; x=1709486201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb2EkkM4HFBzPufUcNJ/oJaQMVNp/FOLKGxdMc6L4GE=;
 b=fCj/b/PTKYbehiBJ450x2N7BMGfTf+cJqKt/DAby3sb8riWQ/SORxCi+Blt8s3MLFo
 3fFHsJdJB2pOBEhlPFLiFbLW3E6Mx1fx8oRZuVrtrPpkP9OIVMc3ykPHez3YBGxrBHn7
 YCrYJ6iZspy5n0gdyiiUJtr5iLBM1+GYrIkZ+soijo0K23+tOzG5Cgle1+Lpn8QXJTMx
 mRVwo52u0NJOnPEA81mfr6hQUPSN4rR9jORLGaSxSsgPYZz+mxGroGu3fi6pghb4ROup
 fKd1OwcduVAJlb9hqVI7+eC3aT+L7Rs0Eoj5yn85bSCReh0lcFC0qo9ncfdGYkij3+39
 2nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708881401; x=1709486201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nb2EkkM4HFBzPufUcNJ/oJaQMVNp/FOLKGxdMc6L4GE=;
 b=AhBI+aVihYhzLPj7p0n4igFZGhkJSK/PY5fNWhNPKQJ2HjYP7ArCigsLnznOY8d/PM
 ogXNyvEg3qQxS1hfR42kXs9NS98KWAmAJSQabudcobsN+TCdx62I9vimJeiNii+JsTLG
 u9lwoDk+nL0KT7DLQ5HIyOt9qb2h9gv1PHQusfcBu5/Mz5Rcfz02ZNM4ep3KmBU71JVC
 RRetsCjT6upuuDE+BEwei1KlMHwGjLwgDlu3hxK+dmA1TGDTX82wyIpY5YM1/e8t8q/Y
 7lhYbBLiR/t9emBnHbhPioU2eMtzzdxhsHJhPCN5yrYmE6evpau1d8BjiCy/Rm4bDCwa
 KM1g==
X-Gm-Message-State: AOJu0YwXpLuml5VLE5+FXDHR7hXtXOyNk7RMSmGMsgUtXy7QmdY4T/bV
 6LeenOGZPBlMY2yEInsmdKKTh4B5JKphzV21hax4fPyeirwEeMENSnWe3cgyhxutNva6Q91PA49
 o
X-Google-Smtp-Source: AGHT+IEsuvO84CjhDWGJNooUMUqefkyHGiuRed5d5w26eSfLpurmDxAmkp/YoALCDjcSOd5hhqHc8A==
X-Received: by 2002:a5d:49ce:0:b0:33d:1392:7469 with SMTP id
 t14-20020a5d49ce000000b0033d13927469mr3042088wrs.67.1708881400800; 
 Sun, 25 Feb 2024 09:16:40 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a5d4bcb000000b0033db2fe4d76sm5669594wrt.4.2024.02.25.09.16.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Feb 2024 09:16:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] hw/ide: Make "ide_internal.h" really internal
Date: Sun, 25 Feb 2024 18:16:34 +0100
Message-ID: <20240225171637.4709-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
 include/hw/ide/internal.h => hw/ide/ide_internal.h |  0
 include/hw/misc/macio/macio.h                      |  2 +-
 hw/arm/sbsa-ref.c                                  | 11 ++---------
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
 19 files changed, 19 insertions(+), 26 deletions(-)
 rename include/hw/ide/internal.h => hw/ide/ide_internal.h (100%)

-- 
2.41.0


