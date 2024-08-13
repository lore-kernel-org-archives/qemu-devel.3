Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFE3C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdrkv-0003QM-RL; Tue, 13 Aug 2024 09:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sdrko-0003GJ-Ab
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:40:03 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sdrkg-0005IC-03
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:40:02 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4f5153a3a73so1858472e0c.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723556392; x=1724161192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ed5VskrPgWyRABr0mUXQNmuEGsqla2BbWPqqyaV7J8=;
 b=a906ZO3Mvl4HnmHwVMBnMYrUIOoVgfy/h74cFeQ+pBHDqz1BmDWKFNKbTi+0WlsUtm
 E1mocmm199SfWuCLo8w4Baol/IFxIUUmg/oAWC/oev0XedunLOpKTB6OXVNr5psskCEK
 LjO83YmoqR+Kq+rJXHesIqAsa1MVJEkqwm//4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723556392; x=1724161192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Ed5VskrPgWyRABr0mUXQNmuEGsqla2BbWPqqyaV7J8=;
 b=miy3cJDrAzZMBCOwPht3iyH3hZczrHXtt0cKgfD/NiTsFb4+RapU9Q5zpE+urfWLc6
 0G6QXHX2iV/85LXUv6uxDtx1qhQlnp0ToN4W9zQIRXBhA6qSmn/25P0AMm/nmG2ctZTT
 1l3n0Y9RbDz5fNeCH9/HkSxvzWMoVwiFxyRt2I36V+xEl9l9YcCaHf+yPuERewvXzwpf
 ESk/ZoNf/5i33wr+ohMARgkXv7d4bYQ8C/bTfq4v10Vx5ycL7ZI2HW9QE7XI90dppimA
 rflcEaEW0rupVIuqt0zztXfBo+THpI4xKiuA/EZKp4rCCReNZqNvAgWjvldzG8wMkX3i
 DMPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiPOoyAZxzdlBunRhbURpVcEx1Qnq37yUrwgvnHjv5YompzxmOdly39IfsadP0bXknaOn3FxtGuswh8oQ/LbgAtQAENB0=
X-Gm-Message-State: AOJu0YwZzBxt2hv8m9BTIcZQb2FUrybKF/MF6h9Ca9pXYw8M5MFrIFEe
 MCmO9wVGTpWeEnGAZewPIZrVXDORq3/yC19d7VVsc+jhvS+h/5G1JW3R9w8cGg==
X-Google-Smtp-Source: AGHT+IGrKKwe1+hyAvA/LnQ/JYnvsfrWqgkaOG6XYgE8j4BTVun+baJv6aPtBCDW2U9ey4RdOgVDLw==
X-Received: by 2002:a05:6122:3c85:b0:4f5:1c87:ce75 with SMTP id
 71dfb90a1353d-4fabf083261mr4582234e0c.11.1723556391882; 
 Tue, 13 Aug 2024 06:39:51 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4531c28fdcfsm32182061cf.90.2024.08.13.06.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 06:39:51 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Andrea Righi <andrea.righi@canonical.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/3] hw/i386/acpi: Pre-compute the _PRT table
Date: Tue, 13 Aug 2024 13:39:11 +0000
Message-ID: <20240813133936.1175467-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=ribalda@chromium.org; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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


