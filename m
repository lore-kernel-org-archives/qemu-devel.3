Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7A1D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUb1-0001Sp-GK; Thu, 29 Jan 2026 11:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaj-0000Tl-GV
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:01 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUae-0006hB-AE
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:55 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4327555464cso973906f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702991; x=1770307791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FyC+DgpopVeoLVyZLyXpQzH/bbdr6d5+zK8/TX4p6T4=;
 b=kUQwT02L3A/sPldVtmREHBqKJiSV87FZ2RyjZbKh02DG21lmlJkFijYHr7KKEKl+vP
 SdClqpQ/FOb1k+eE0fS0FokJEFT0fgVBICy3hGiUVsiKV70VDtGpJ0QNxgE4TYt80d+S
 Kj0PPrxfob9lbRvh9zkZYhn1AfU5HpSlvdCH2x85Yh0kj6uKFyLQ6b+gxN42Owg/dEjD
 ZgsSXh9mi3kK0mK12C8hgtv5QjdK+Wjh9e06PH4f4cXAZg4vh7ssssZWU1vTW5NXIZRZ
 KlGYK3jKibmqgXBful4pf2YBoerWzTRbE9K087EZX0rP+fY+TLZS5yFFGm3wlIfTkeE3
 ZQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702991; x=1770307791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FyC+DgpopVeoLVyZLyXpQzH/bbdr6d5+zK8/TX4p6T4=;
 b=PCzcdZITrfWbyWZXJhX5F31SMTVfQilEwKyEI9BklI0v/q2B8hgYucf4Q4U03PAwnq
 i6P6R4owZsrchl4B4Qmhp+RQ9UwxTGaceyinXTxn/0vfQVEUXgmMubdVo8gOfSXJuo1k
 nrgNTDHiJUdZxnwrnciUs+Lnt14F3ylrqSbASm+ffZ1sakzcfxCLDbRnLHC71XQJCwvj
 U/adRGbUvI2fe1LXvSjHONZ2qZsHF/M7HyD5kQ90zbLFjHuhaTCjBNz0qXljNP+KxkfG
 enNqWuNuIizcd1/a19VHMKx2B+vEQoU7OP4hAkkZHXm7LTXxBWLMrwyHw+4NX/rh6cD4
 iTpg==
X-Gm-Message-State: AOJu0YyuByWnbc8xdwpjtE3l+VaV0RscACJFDwt8R3/mMOXm9nW865ds
 LFvejL0vm29ewe7+L/We3H8+IXdHKrrJFuJhuOyp0T4hzp1FRpOzq1v926QGlQuFF6YeGvakw7U
 Cqj0IM74=
X-Gm-Gg: AZuq6aLo2UsDKBIKeFR0tAvk0GM1AXgFiEn2cgIoqBd64+7nSNTPEUknYeeMdf2K7F6
 wzP/aN8Aj2R7GuOnA8PbBIdom3BfU10dCs5X46uRcs/E2pxocEk/JYNeHYQtPFB93ssUCphkHSv
 zwL1pu6YHlw+la8yIyAsDaWgRdDdHjtzI/0q4I4ol9VOYKfHSeBMNP3ik/huCNYbhBKwnZMIXNB
 U7aZSz27VzFhp2leMtZjsaPgAU7+Z1gQEr8WH6T+vvX1Fj1CB6LzhVEtJzlmsPd/alcvVtuOM7O
 huyKD9vJNLzgYllFOBRYP3S0Pyz+cvFP9ewW8VLP+QCY1wPAiD9wY8266hbZMsiwFrtCkjaf2fb
 0FgwKjd9IR/XlDJ8YsJ6tKFBtbUX/gT3ICzUqtODkz54QSDSb2+i2EQh0ap6fmt2eQOKfgL0zvF
 ekaFT1LJUzy/Z+k62pz8DSkV3whvwWLw==
X-Received: by 2002:a05:6000:2383:b0:432:5bf9:cf2e with SMTP id
 ffacd0b85a97d-435f3a6bab1mr180058f8f.13.1769702990702; 
 Thu, 29 Jan 2026 08:09:50 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/43] tests/qtest/bios-tables-test: Update IORT blobs after
 revision upgrade
Date: Thu, 29 Jan 2026 16:09:00 +0000
Message-ID: <20260129160917.1415092-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shameer Kolothum <skolothumtho@nvidia.com>

Update the reference IORT blobs after revision upgrade for RMR node
support. This affects the aarch64 'virt' IORT tests.

IORT diff is the same for all the tests:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/IORT, Mon Oct 20 14:42:41 2025
+ * Disassembly of /tmp/aml-B4ZRE3, Mon Oct 20 14:42:41 2025
  *
  * ACPI Data Table [IORT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
 [004h 0004 004h]                Table Length : 00000080
-[008h 0008 001h]                    Revision : 03
-[009h 0009 001h]                    Checksum : B3
+[008h 0008 001h]                    Revision : 05
+[009h 0009 001h]                    Checksum : B1
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001
 ...

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-27-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 128 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off       | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 364 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
 tests/qtest/bios-tables-test-allowed-diff.h     |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
index 7efd0ce8a6b3928efa7e1373f688ab4c5f50543b..a234aae4c2d04668d34313836d32ca20e19c0880 100644
GIT binary patch
delta 18
ZcmZo*Y+&T_^bZPYU|?Wi-8hk}3;-#Q1d;#%

delta 18
ZcmZo*Y+&T_^bZPYU|?Wi-aL`33;-#O1d;#%

diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
index c10da4e61dd00e7eb062558a2735d49ca0b20620..0cf52b52f671637bf4dbc9e0fc80c3c73d0b01d3 100644
GIT binary patch
delta 18
ZcmZ3(xQ3C-(?2L=4FdxM>(q%{ivTdM1ttIh

delta 18
ZcmZ3(xQ3C-(?2L=4FdxM^Yn>aivTdK1ttIh

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
index 67be268f62afbf2d9459540984da5e9340afdaaa..43a15fe2bf6cc650ffcbceff86919ea892928c0e 100644
GIT binary patch
delta 19
acmaFE^oEJc(?2LAhmnDS^~6T5Bt`%|fCYU3

delta 19
acmaFE^oEJc(?2LAhmnDS`P4?PBt`%|eg%C1

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
index 41981a449fc306b80cccd87ddec3c593a8d72c07..5779d0e225a62b9cd70bebbacb7fd1e519c9e3c4 100644
GIT binary patch
delta 19
acmbQjG=+)F(?2Lggpq-P)oUXc7b5^FiUXej

delta 19
acmbQjG=+)F(?2Lggpq-P*=Hjc7b5^Fhy$Mh

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3279638ad0..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/IORT",
-"tests/data/acpi/aarch64/virt/IORT.its_off",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


