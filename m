Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADE3C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcC5-00086C-1h; Tue, 01 Apr 2025 10:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcBn-0007sc-Hr
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:05 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcBl-0000OD-Ed
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22622ddcc35so32809615ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743516120; x=1744120920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wHJp3mOzC9AVWUB09CFtdysPyIqdv35aj1gSx0lNkL8=;
 b=FtRIqj8BC6Zw9s/tEPzSch6QtRW3Zaq3lDf5sJObBehmGB+ONKkNB70voIZXJS41I6
 no8HRhA0nni13AWspIdQulIFM6+zl02PzXWJdeXzrcO8yOLaxWhIts6ZzOIKzZ3UWxxP
 8NlnxXQ3tMWU6eLKsuPhFShSbxIVpdIuZdrya0reZQoeEdznybO5Lip87rD9HtdEk8/u
 sYf+6vtgdhLZRBscmG1H+X68B7h2CXvErI3SfOpPAWZhkKP2t/7Hj7iMyg2fu5gVmMnB
 htEYfpM/m6joE5IWYMosSW7OrKCggiEWLupNopSwK3f5O+wMnltlDdxnZxlSzDIofddO
 O8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516120; x=1744120920;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wHJp3mOzC9AVWUB09CFtdysPyIqdv35aj1gSx0lNkL8=;
 b=laKzPkItp/fDiqmzeaWJ8FU0MMac9QAlr0GcSjcot0E9epD0p/HWZaeYTm+ijPKOAB
 8WmBWDMRZ0EatqsqGIK9PYddswjW9hLxG58myUffAHy+x25oG2jj0oJSMW8DxBN5ENbQ
 rTg2ZgOUmF97EkxruMeVAyalP4zkvGbiSNFsQ48oyv8cAF13biR+7ULrU2SdNOMCMnVy
 aUAIrtjpNtHMEaBoNZYsS0kz7H2aEQYeL2tWAiR4DL77w+TUwv94y/cCFf4CtY6df0le
 KRxr9E1kcReesl6URnYQxfP0k/BvRa2KChJN1T1A/lKlA3919li6OVyXkVl8p2fuQuRt
 Iiug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfUgaEUMYIauUwUI+BeNM5UT9Ck1V/1qjDFuJExB8X33xDBbCQRFuCI1GdhScthTzF6vcdHnT8up6X@nongnu.org
X-Gm-Message-State: AOJu0YwVK0D49d7zzO5JeIWre18D0uucPhsY+VrzQ0BRhgvHk2N6DRi/
 jEV2eNDqFNgTQAEVQUSUj0Qj+WVX4AJEAiiVFZkgbfOvovEPNOZH
X-Gm-Gg: ASbGncv4tZROX7/MeprhpvhvtlnHIvfJ5AC1r+40AkEQ+ScM+72GAHMd7qW5LrXsPWR
 Na6ABwHRroLGV8iI5N/1vKgPUEzlsjPG54uc5cB+n0XllAHN7rKW8/lsMIUkyepzuLRvT4YCqgM
 5ZySyEoui62P+N91LbjT/s7ksOw5aI85IN9BsR+en6pMyr1WkwcAhiwBe9GETkMGe214/AGKMU1
 b3PRmKMh1k4T78IPt6jy7XvxENz2t03hgNx7SICScH31Y73oU+QaoHlS9hgajg2mEiZhGwtITAH
 buSigSaA7/l2uQHDBDG08z7vGIAqpY1SqDxU6g7wnF0ZNDepRQ==
X-Google-Smtp-Source: AGHT+IHgs0BqqRYmXp5N8kw/u0vRr8vDl9VALCyYAt45bJryiuKYKyH/oYAukoap9ZMVCn0r+yYYtA==
X-Received: by 2002:a17:903:19ee:b0:224:10a2:cad5 with SMTP id
 d9443c01a7336-2292f942a6amr247359225ad.10.1743516119726; 
 Tue, 01 Apr 2025 07:01:59 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f5774sm87768455ad.214.2025.04.01.07.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:01:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] ipmi: bmc-sim improvements
Date: Wed,  2 Apr 2025 00:01:47 +1000
Message-ID: <20250401140153.685523-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

These little things came up when looking at behaviour of IPMI with
the bmc-sim implementation running the ppc powernv machine, and
trying to clean up error messages and missing features.

Since v1 (thanks to Corey for review and suggestions):
- Added fwinfo to PCI devices
- Report interrupt number in Get Channel Info for ISA, PCI, and
  unknown/unassigned.
- Fix error reporting for Get Channel Info unsupported channels.
  Verify it is the correct error code that ipmitool looks for
  https://github.com/ipmitool/ipmitool/blob/master/lib/ipmi_channel.c#L256C16-L256C45
- Change _CH_ to _CHANNEL_ in some defines names.
- Also avoid adding event logs with watchdog don't log flag.

Since v2:
- Don't log watchog flag should not apply to watchdog expiry
  field.
- Moved protocol type field from class to IPMIFwInfo.
- Rename new FwInfo member irq to irq_source.
- Add comments about handling PCI devices to  existing callers
  of ->fwinfo

Thanks,
Nick


Nicholas Piggin (5):
  ipmi/pci-ipmi-bt: Rename copy-paste variables
  ipmi: add fwinfo to pci ipmi devices
  ipmi/bmc-sim: Add 'Get Channel Info' command
  ipmi/bmc-sim: implement watchdog dont log flag
  ipmi/bmc-sim: add error handling for 'Set BMC Global Enables' command

 include/hw/ipmi/ipmi.h     |  15 ++++++
 hw/acpi/ipmi.c             |   3 +-
 hw/ipmi/ipmi_bmc_sim.c     | 104 ++++++++++++++++++++++++++++++++-----
 hw/ipmi/ipmi_bt.c          |   2 +
 hw/ipmi/ipmi_kcs.c         |   1 +
 hw/ipmi/isa_ipmi_bt.c      |   1 +
 hw/ipmi/isa_ipmi_kcs.c     |   1 +
 hw/ipmi/pci_ipmi_bt.c      |  50 +++++++++++-------
 hw/ipmi/pci_ipmi_kcs.c     |  11 ++++
 hw/smbios/smbios_type_38.c |   7 ++-
 10 files changed, 162 insertions(+), 33 deletions(-)

-- 
2.47.1


