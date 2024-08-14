Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F131AC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCdP-00044E-Rf; Wed, 14 Aug 2024 07:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1seCdN-000416-QM
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:57:45 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1seCdM-0003XY-5Z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:57:45 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-492a01bce97so2300398137.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723636663; x=1724241463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5HgKv16iVxwQfwScMaNGnAY3+6Nxz4ksJ0KeJnbS76A=;
 b=aSvuWlhJVHgGhX28eba3QI1YO+gsV6CWHCJpRXODKdGbs8Q2Bk5HjAMP2siLdNi1DK
 oeBcAFO4ZZnV2bAvm2yZOVmTHYGsgK9q2iNEbvvsFH97znZ4T0ypInMAIacgm12QyuMr
 Lw82BMqDArOkbjpO7LEC2TKve9kAi6pBtEdQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723636663; x=1724241463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5HgKv16iVxwQfwScMaNGnAY3+6Nxz4ksJ0KeJnbS76A=;
 b=q2NlN9ZJzU0gjYB4lAgTxST9D2GN6VdCGbwQX+wHrnhd/ooXwQH3wiyp0m+ggGGEkS
 D8PBUF5NpKpWm9OZRtOEyFs/KvwG0XGUhRfzN4hPlYc9LvuuBbzPxZylbjZcGVnvNv4Z
 F26bwVy0B50im4yciKUAZ0x/jQRSgDcFdfQGI8Rcw+k/JPWJkB/TUb3WqC39i5KLwOKO
 Pn7DUxCE6yae8v6mlKiLF9Uo/6OyBcLRNC5Xlti29wHjQTKD6kzgUOEC1W/4VraqIXHG
 1Tc9qCVh+auprf+z5kVvOsvaKtom3pyqBb+T4abQXWsBa9W7EWTcDvCM+JBX+XLeFn4b
 +Eig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7H6kX0bOJmcRfP0R8Ss9wI9SG5HZ6ZSlrBDQiQEX4soPXAUyodRSSEDPhPSoI/eHgoQDC5sylD6HMdjAhq1IEi1wO1XM=
X-Gm-Message-State: AOJu0YxdLpqlcz0bpakCW0g3VCWshUVmlZK0BCXENVew9HMA8Mjo5SZm
 A+aziJnhkWmFJda1/2KCoJCrAPB0EVeF3NgCtL7U5o3EJ8vZ0+7f2ehJP6OPXQ==
X-Google-Smtp-Source: AGHT+IEFYvA+QBzicW2wIC4WRnvGgadCkAZ7gUGbFIAPALtDxxtDiTc6KvxyNzphzr5w0LXKlBwHXA==
X-Received: by 2002:a05:6102:390a:b0:492:aa42:e0ce with SMTP id
 ada2fe7eead31-497599d6ca1mr3003013137.20.1723636662850; 
 Wed, 14 Aug 2024 04:57:42 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bd82c5f375sm43001586d6.14.2024.08.14.04.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 04:57:42 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 righi.andrea@gmail.com
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/3] hw/i386/acpi: Pre-compute the _PRT table
Date: Wed, 14 Aug 2024 11:56:08 +0000
Message-ID: <20240814115736.1580337-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=ribalda@chromium.org; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Today for x86 the _PRT() table is computed in runtime.
Under some configurations, computing the _PRT table can take more than
30 seconds and the ACPI timeout is violated.

This patchset modifies _PRT() to return a pre-computed table.

Changelog v3->v4 Thanks Richard:
- Make link_name struct static

Changelog v3->v4 Thanks Igor:
- Add missing files to tests/qtest/bios-tables-test-allowed-diff.h

Changelog v2->v3 Thanks Michael:
- Code style
- Add cover letter

Ricardo Ribalda (3):
  tests/acpi: pc: allow DSDT acpi table changes
  hw/i386/acpi-build: Return a pre-computed _PRT table
  tests/acpi: pc: update golden masters for DSDT

 hw/i386/acpi-build.c                 | 120 +++++----------------------
 tests/data/acpi/x86/pc/DSDT          | Bin 6830 -> 8527 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst | Bin 6741 -> 8438 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat | Bin 8155 -> 9852 bytes
 tests/data/acpi/x86/pc/DSDT.bridge   | Bin 13701 -> 15398 bytes
 tests/data/acpi/x86/pc/DSDT.cphp     | Bin 7294 -> 8991 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm  | Bin 8484 -> 10181 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge | Bin 6781 -> 8478 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot | Bin 3337 -> 5034 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs  | Bin 6902 -> 8599 bytes
 tests/data/acpi/x86/pc/DSDT.memhp    | Bin 8189 -> 9886 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet   | Bin 6688 -> 8385 bytes
 tests/data/acpi/x86/pc/DSDT.numamem  | Bin 6836 -> 8533 bytes
 tests/data/acpi/x86/pc/DSDT.roothp   | Bin 10623 -> 12320 bytes
 tests/data/acpi/x86/q35/DSDT.cxl     | Bin 9714 -> 13148 bytes
 tests/data/acpi/x86/q35/DSDT.viot    | Bin 9464 -> 14615 bytes
 16 files changed, 22 insertions(+), 98 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


