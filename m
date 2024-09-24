Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D6BCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5X3-0004ov-Ui; Tue, 24 Sep 2024 09:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1st5X0-0004ie-Sj
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:24:42 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1st5Wz-0002vu-5W
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:24:42 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4581e0ed0f2so53516701cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727184279; x=1727789079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=My/SSfrXFxfEwFJIIpw6G7rBWumzz76QNdrts7qfjC4=;
 b=XK/pMzwVTmHUDaNS4+FH0RD7ZRFCQkNN3YDlxD32jgeav90rvay/C8ZR7DkMO0fXCk
 5mRD6whu6jhOmnBVGz1m5Wbn13sBRwA1qZaWiLfok6G3GNTOP2IDM/20qXcvGPphAGcb
 bDIa+jjUmJKa7swaJiBlAo5+5m01FEHiZeUo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727184279; x=1727789079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=My/SSfrXFxfEwFJIIpw6G7rBWumzz76QNdrts7qfjC4=;
 b=NtSpnsCXuoh/aYV2DWDJB2iQdGcewU4C4XQ55lb5tgZDpXatQP4GuLxJBD6fugWoim
 G56awpf0TNErI6OByElXVbb1kWkLDohq75N/JKck/esf1fnSpuj6lrDVGRh0dN6hC+YO
 j9+b69sQyIVb4aMOnvj4EQf8Ry7LnRLXrHn93bb1wFmKjzoHUflWlHQq9chciKYaN8cL
 fdoS6BgjJODcZnxEuAI1MLlJugux/VceIErYVbirPthiifcUlmPjILvGCr7KLV6Ozkio
 HqPxY/bh9bmY5wMnl+1rlsWaRM0JIPNaE6HoWnkcMF4X5+CNAJMXhek4lku6gZeyv4TO
 eMRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEJVX66hCZK/Uzkf6027+hn2JqaTxf5y4JAIxPf7mKreYAirzUY/+T1s7LIlwQU4kwK1Ut+BoVSTQW@nongnu.org
X-Gm-Message-State: AOJu0YwqDD8BDvjlR4oN6g6yi/BalaubgN4jJ2VoVvpIVqIg9q/nVGiM
 bEOYK+auO/VkAB67C6RxcgTdpu+ic+awgx1/JrQIoxp1WgF2t2WTzx4YnuAbmQ==
X-Google-Smtp-Source: AGHT+IGWDhmEPKYZ61x8nyPP0m5IvVvTfJrxxFayPu4RNfKJRm/+FS8JYtoKhQ380v+ZRVTiHN4KcQ==
X-Received: by 2002:ac8:7d4c:0:b0:458:209b:5ec2 with SMTP id
 d75a77b69052e-45b4fa22749mr53984471cf.29.1727184279295; 
 Tue, 24 Sep 2024 06:24:39 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b52579daesm6248411cf.25.2024.09.24.06.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 06:24:38 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/3] Fix WinXP ISO boot using the dc390/am53C974 SCSI device
Date: Tue, 24 Sep 2024 13:24:09 +0000
Message-ID: <20240924132417.739809-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=ribalda@chromium.org; helo=mail-qt1-x833.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Mark Cave-Ayland reported that after landing the pre-computed _PRT, the
above mentioned testcase failed to pass.

It seems that it is due to WinXP not handling properly a variable
package. Let's replace it.


Unfortunately, the ASL diff is not the best (or I cannot produce
something better):

12c12
<  *     Length           0x00003917 (14615)
---
>  *     Length           0x00003914 (14612)
14c14
<  *     Checksum         0xD9
---
>  *     Checksum         0x09

Diff v1:
  - Add assert(), Thanks Igor

Ricardo Ribalda (3):
  tests/acpi: pc: allow DSDT acpi table changes
  hw/i386/acpi-build: return a non-var package from _PRT()
  tests/acpi: pc: update golden masters for DSDT

 hw/i386/acpi-build.c                 |   3 ++-
 tests/data/acpi/x86/pc/DSDT          | Bin 8527 -> 8526 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst | Bin 8438 -> 8437 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat | Bin 9852 -> 9851 bytes
 tests/data/acpi/x86/pc/DSDT.bridge   | Bin 15398 -> 15397 bytes
 tests/data/acpi/x86/pc/DSDT.cphp     | Bin 8991 -> 8990 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm  | Bin 10181 -> 10180 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge | Bin 8478 -> 8477 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot | Bin 5034 -> 5033 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs  | Bin 8599 -> 8598 bytes
 tests/data/acpi/x86/pc/DSDT.memhp    | Bin 9886 -> 9885 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet   | Bin 8385 -> 8384 bytes
 tests/data/acpi/x86/pc/DSDT.numamem  | Bin 8533 -> 8532 bytes
 tests/data/acpi/x86/pc/DSDT.roothp   | Bin 12320 -> 12319 bytes
 tests/data/acpi/x86/q35/DSDT.cxl     | Bin 13148 -> 13146 bytes
 tests/data/acpi/x86/q35/DSDT.viot    | Bin 14615 -> 14612 bytes
 16 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.46.0.792.g87dc391469-goog


