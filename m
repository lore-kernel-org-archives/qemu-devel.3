Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D51C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkW2-0004sz-9z; Wed, 06 Mar 2024 01:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVk-0004qw-38
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:17 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVh-0006Dt-TQ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:15 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e6419cd4ddso1118835b3a.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705532; x=1710310332;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7cIwTl/IOM/1SftnJVpRsXZFbH7wQI3nEBIBuZ4OF8=;
 b=Ywsbp3N/fgO9PZOT6+L8qb9HSrBXi96+hi6D7fruBBeET06LgwUEIoLf4w/AnAMXu+
 ZvTp+2x4jZC8FF1w9/fBF6WGQbB2jJf7zxpxnzStRCCaR3ik/MzireWu4u+emwMQTAHV
 xlF06L9f2kzgdDuTP5sNZDJJZJ1Zw67aZSmIti/p1M/pDbdIvbUISXFx9fWAyY1QqSHI
 g34FDRuGb6MH2r5w9BmnjOkZpn41re7YewRACgxkOqEwvuwUj62kIcC+rR6O8EzbDI15
 2CDyJ4ZCochLPBKe82J6vT0bTOCs/e+Vem/AmoZCD7yrcw3zdIMU5BuCjTQ9dk2p9Ro6
 swBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705532; x=1710310332;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z7cIwTl/IOM/1SftnJVpRsXZFbH7wQI3nEBIBuZ4OF8=;
 b=U4KuKrIctNCSFuvTOA9bG35qvoihLv0MYTzS5zS8YS4vRkL64rZEGQnthxSaYIKLOH
 u2WhskFRgF1KEl1fq8bPZzsztxRqHofd7FTKLTQnoVgTCZNQTi/Lac7XqO7E/gIqj41X
 Iiq1oTIkiWqElXUxpenvRSiUiHrr42csIVATnuYJ+xQoLlcGihRJqYkfU4WUT8577tOq
 B+XnXcQx58K/bDC+Ia+fhV70Tt0y6FSRSqskksT1AAcaoLANLEd/HB8I5MTG9ecF8sGC
 8wD0JOu3DVXzIQAAVeeriEZVNG+Yf69sZQyDPoAgQ4n0cQkx5mCaWztaeKgKDz9k/9uj
 ichA==
X-Gm-Message-State: AOJu0YyQwQ350cS417TQ4jq75VCPmxmhNYsb8zmo5mWi8WPENQTX/Bt2
 qzZOpQWzejOXNudGe02Ex9v8biFJCD5fBkY/K7ucd3wVG42PdA9HRUCGlCMoNio=
X-Google-Smtp-Source: AGHT+IG6O6SbIG3SCI7KbNUK24/j+XjwQlieutY5QRA9rYARy7/8T7diPVLiLKjfHMzundnw8RqrcQ==
X-Received: by 2002:a05:6a00:1492:b0:6e6:2df4:198b with SMTP id
 v18-20020a056a00149200b006e62df4198bmr7355740pfu.4.1709705531903; 
 Tue, 05 Mar 2024 22:12:11 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 s16-20020a62e710000000b006e5a6e83f8esm9059998pfh.134.2024.03.05.22.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:11 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 00/19] contrib/elf2dmp: Improve robustness
Date: Wed, 06 Mar 2024 15:12:06 +0900
Message-Id: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADYJ6GUC/1WMyw6CMBBFf4XM2pp2ChN05X8YF5VOpYkCaU0DI
 fy7hcTX8tzcc2aIHDxHOBYzBE4++r7LoHcFNK3pbiy8zQwosZRaKsF3h/YxCGXIVJVyNZGG/B4
 COz9upfMlc+vjsw/TFk5qXd8N/WkkJaS4siEqD44108maqfPjvukfsEYS/orVV8Qs1uQcKtLGa
 vwTl2V5AQpAWAzYAAAA
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

elf2dmp sometimes fails to work with partially corrupted dumps, and also
emits warnings when sanitizers are in use. This series are collections
of changes to improve the situation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Split patch "contrib/elf2dmp: Conform to the error reporting pattern".
  (Peter Maydell)
- Stated that the relevant value is little-endian in patch
  "contrib/elf2dmp: Use lduw_le_p() to read PDB".
- Added a message saying "Build it only for little endian hosts until
  they are fixed." for patch "contrib/elf2dmp: Build only for little
  endian host".
- Added patch "contrib/elf2dmp: Ensure phdrs fit in file" to fix
  https://gitlab.com/qemu-project/qemu/-/issues/2202 as patch
  "contrib/elf2dmp: Clamp QEMU note to file size" was not really fixing
  the crash.
- Link to v2: https://lore.kernel.org/r/20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com

Changes in v2:
- Added patch "contrib/elf2dmp: Remove unnecessary err flags".
- Added patch "contrib/elf2dmp: Assume error by default".
- Added patch "contrib/elf2dmp: Conform to the error reporting pattern".
- Added patch "contrib/elf2dmp: Build only for little endian host".
- Added patch "contrib/elf2dmp: Use GPtrArray".
- Added patch "contrib/elf2dmp: Clamp QEMU note to file size".
- Changed error handling in patch "contrib/elf2dmp: Ensure segment fits
  in file" (Peter Maydell)
- Added a comment to fill_context() that it continues on failure.
  (Peter Maydell)
- Link to v1: https://lore.kernel.org/r/20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com

---
Akihiko Odaki (19):
      contrib/elf2dmp: Remove unnecessary err flags
      contrib/elf2dmp: Assume error by default
      contrib/elf2dmp: Continue even contexts are lacking
      contrib/elf2dmp: Change pa_space_create() signature
      contrib/elf2dmp: Fix error reporting style in addrspace.c
      contrib/elf2dmp: Fix error reporting style in download.c
      contrib/elf2dmp: Fix error reporting style in pdb.c
      contrib/elf2dmp: Fix error reporting style in qemu_elf.c
      contrib/elf2dmp: Fix error reporting style in main.c
      contrib/elf2dmp: Always check for PA resolution failure
      contrib/elf2dmp: Always destroy PA space
      contrib/elf2dmp: Ensure segment fits in file
      contrib/elf2dmp: Use lduw_le_p() to read PDB
      contrib/elf2dmp: Use rol64() to decode
      MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
      contrib/elf2dmp: Build only for little endian host
      contrib/elf2dmp: Use GPtrArray
      contrib/elf2dmp: Clamp QEMU note to file size
      contrib/elf2dmp: Ensure phdrs fit in file

 MAINTAINERS                 |   1 +
 contrib/elf2dmp/addrspace.h |   6 +-
 contrib/elf2dmp/download.h  |   2 +-
 contrib/elf2dmp/pdb.h       |   2 +-
 contrib/elf2dmp/qemu_elf.h  |   2 +-
 contrib/elf2dmp/addrspace.c |  63 ++++++++++-------
 contrib/elf2dmp/download.c  |  12 ++--
 contrib/elf2dmp/main.c      | 168 ++++++++++++++++++++------------------------
 contrib/elf2dmp/pdb.c       |  61 +++++++---------
 contrib/elf2dmp/qemu_elf.c  | 150 ++++++++++++++++++++++-----------------
 contrib/elf2dmp/meson.build |   2 +-
 11 files changed, 238 insertions(+), 231 deletions(-)
---
base-commit: bfe8020c814a30479a4241aaa78b63960655962b
change-id: 20240301-elf2dmp-1a6a551f8663

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


