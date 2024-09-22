Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59540CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 14:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssNdS-0005cp-0l; Sun, 22 Sep 2024 10:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1ssNdQ-0005bL-Ni
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 10:32:24 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1ssNdN-0008Tz-Uy
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 10:32:24 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6c548eb3354so28241226d6.2
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727015541; x=1727620341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6n8uu98JW3p9HIkkqL6tJyuEOISV6y2Jmx3W9SB87lg=;
 b=RWTdqC+YZ+LShPPCI5LBI3WCDoQfDlC/PFElkkkKPoOMpB5ccrA/QCfHkti6x52hKr
 WpB3RANpOenp4LOubGBj++yPhI0yrQ2sYDT7vUI2Q5bdppWZTxTn1lkluUX+MRjOQCVE
 KM3Rm95Vhx/gIMOksbOvm5kGUtb/EzQmIJbu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727015541; x=1727620341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6n8uu98JW3p9HIkkqL6tJyuEOISV6y2Jmx3W9SB87lg=;
 b=b/4R2i1hJNmLIicRaqfDBPRdRhp+16mQ1QDAwZ4qWN6urQv+z+ZQBmcdV4GOkuQvsT
 0j/pAwGf+iQg4AohINjL5MM+CBDKKWrMWMc9mg/WP/CKZwJ3Uil03OA3oNr1ipAPDDcM
 sRVLKofOgcMVN8wzJgCCCbSGfujEnPTMPJthPPGUTIhBl+UeoioNlExnOm9KVKtZABCN
 NALO3AMAmhrNrFDJFNSlcIzDH2yqEC73G64Uuk3MnUNsJyY3BfNkbMDVRSlHrETLnCzN
 W7jJ5yZYFitQGY6SnAP5lL/YX0b/xLhANtFgQYsujI3nSZInbRbe1/r8ZFXrVNzel9Dj
 bp3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj+2k8yijB09hg7dOU7AVxogS13bT5m6jLLYJOu8b1sBjdFc2zlbGXKfseDxjqU/HHfeGr7rYRuobG@nongnu.org
X-Gm-Message-State: AOJu0YyJxgmOBz3le7UTzKkaIE+tKyJ4evYj31GFt5qgF0jGOM5nBOqa
 ojpNpFRI6yDnzYPot/MIePnJBO9DAhO1AEDSZjSVj0Ic0sm6eq6qXl6Kjeqehg==
X-Google-Smtp-Source: AGHT+IEOW1lHmBpHqJRjdv3TRzWdC8qqi4QXxOYsWfbZ9JhhucrEJr06ZZ5n9qJp/xLLIDZ2afKTUg==
X-Received: by 2002:a05:6214:54c3:b0:6c3:5db2:d99d with SMTP id
 6a1803df08f44-6c7bd54841bmr156122896d6.21.1727015540882; 
 Sun, 22 Sep 2024 07:32:20 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (122.213.145.34.bc.googleusercontent.com. [34.145.213.122])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e557d6csm37956366d6.98.2024.09.22.07.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 07:32:20 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] Fix WinXP ISO boot using the dc390/am53C974 SCSI device
Date: Sun, 22 Sep 2024 14:31:08 +0000
Message-ID: <20240922143216.662873-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=ribalda@chromium.org; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.129,
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

Ricardo Ribalda (3):
  tests/acpi: pc: allow DSDT acpi table changes
  hw/i386/acpi-build: return a non-var package from _PRT()
  tests/acpi: pc: update golden masters for DSDT

 hw/i386/acpi-build.c                 |   2 +-
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
 16 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.46.0.792.g87dc391469-goog


