Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C05C369BD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 00:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5CiH-00041U-45; Wed, 16 Apr 2025 20:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiF-00040i-Ve
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:39 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiE-0006Oe-5a
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:39 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3f6aa4b3a7fso43894b6e.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1744848150; x=1745452950;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bq6ntJYTCPosHeiK/1PEVTCfOsXUesQA8t5Bz6bnCO0=;
 b=QHTwsKbwE71/ApgFazuDqeY4uMDh3ApI9j30BY9iEUNPFw14ZIXS9XHslQ5fLxO2u/
 A5bOOMt/A4YW3nd+0EK8SXyhplMD4Ux+QoUtCClzhnE/vTS4RIsGSd7N9R0iYXKPgIkX
 +onUzemH9wFp+r+SX3dLZxTMTHfsL/dyDBMgXSMANbNNe/ISsfqxemRjZ4qpZ6fUbgY2
 /m+Gd+xXs+FLEjnngjFjUh+duktPRzjXZiabcSqjLX9fVOWfysGbBkRikioQoVyLCbVX
 jm4tv6iU4xpL4HhKrliLp4Q11Nc0z9ZY1aEh4lYBhynX/VHWTwu/CWHQ1XfYsPxLjLVj
 Zhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744848150; x=1745452950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bq6ntJYTCPosHeiK/1PEVTCfOsXUesQA8t5Bz6bnCO0=;
 b=ljwuGHG75+wLuQV85ymz01PgWgtuS6e6ngZAJvuavWzrzYENhK1gG3OwJM2ApYyB0u
 nhSgOoSEzC13EyGEn2+2zCP0vqj9NDjHq1bTER4hf92lkipuemrrByIqLpTaN851Hr6h
 3LPpZT0cpfC8A3LlBvcT+xv2AzfSgCvxrjdMYieNbwDvYh5GKnASmJ80gBofc0b5yqzn
 WwSm8IpLwjwlmHA4mTYZVaVOgCfq8sH1Fy7gaDuS3F5FHxFGEH45Aq20EJkFpMIbcxFG
 MkQlcrjF4JpDeTmcE6d41yRwhpJrX4QrC9/HLvHTXqZ5jVLL7QVrLAAhqDLExWe9KK4T
 4SCg==
X-Gm-Message-State: AOJu0YwRl3FJfjbgOS0YZOy16gy/Sl+Udv/gnwT2NimCp8+n28hFYxXd
 IjZeDHhNOV5zsq6sE3VK8C9DfLwl76/zVDS969sd5VEkJwCUpAmkmQURSBqKC8ReIPgZ6mEOle3
 U
X-Gm-Gg: ASbGnctkv+O6DYDe/mDpXxSGKoUQXCyLa6/HY+mXUzCVsdQJIqUffWLBMz7trC9d1Vs
 CUbH9zaSOGY2i72F1Bz/LbCV/9udQfmbMw4nv0lvQn/OoFqYFBQPiMGMr/5I+tUwLgwYZMcbxeS
 mWXtZKy16eAMgaoBF+sCp01BPiUUb7vTMFxPe635r6dk5kD+nP4lBO57ALojGbicqK5BS5loOY1
 tAf1u0+k2ax6eFs1P5xqOmHgRPl4qLp7Z7cBLyDOMs9iFfdw8ntvXc3e3DoSV+6Zec+IDm6iiTq
 YZ09eUhe4TYlvEuHmz+71sP1QcJJwsaAK1Q99u4sXSuExg==
X-Google-Smtp-Source: AGHT+IESZ2dQizpJ21dt4q36GAbAoZ7SfShWHapkJvRqkoX/TqKEGNBnYvLYSNW7ZxmGD8pZOAKkCg==
X-Received: by 2002:a05:6808:14cf:b0:3f9:28b9:7013 with SMTP id
 5614622812f47-400b023c7abmr2308296b6e.39.1744848150147; 
 Wed, 16 Apr 2025 17:02:30 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8795:e9fb:beca:ef25])
 by smtp.gmail.com with UTF8SMTPSA id
 5614622812f47-4007639de56sm3003609b6e.34.2025.04.16.17.02.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 17:02:28 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] ipmi: Miscellaneous fixes
Date: Wed, 16 Apr 2025 18:59:04 -0500
Message-ID: <20250417000224.3830705-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=corey@minyard.net; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Nothing terribly critical, but little things that need to go in at some
point.

The following changes since commit 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365:

  Update version for v10.0.0-rc3 release (2025-04-09 04:33:10 -0400)

are available in the Git repository at:

  https://github.com/cminyard/qemu.git tags/ipmi-for-qemu-10.0

for you to fetch changes up to dacb3e70ef73d1c9a2d0d4cfd65031deff49f742:

  ipmi/bmc-sim: add error handling for 'Set BMC Global Enables' command (2025-04-11 10:50:43 -0500)

----------------------------------------------------------------
Some minor fixes for various things

----------------------------------------------------------------
Corey Minyard (1):
      hw/ipmi: Move vmsd registration to device class

Nicholas Piggin (5):
      ipmi/pci-ipmi-bt: Rename copy-paste variables
      ipmi: add fwinfo to pci ipmi devices
      ipmi/bmc-sim: Add 'Get Channel Info' command
      ipmi/bmc-sim: implement watchdog dont log flag
      ipmi/bmc-sim: add error handling for 'Set BMC Global Enables' command

 hw/acpi/ipmi.c             |   3 +-
 hw/ipmi/ipmi_bmc_extern.c  |   3 +-
 hw/ipmi/ipmi_bmc_sim.c     | 107 +++++++++++++++++++++++++++++++++++++++------
 hw/ipmi/ipmi_bt.c          |   2 +
 hw/ipmi/ipmi_kcs.c         |   1 +
 hw/ipmi/isa_ipmi_bt.c      |   4 +-
 hw/ipmi/isa_ipmi_kcs.c     |  13 +++---
 hw/ipmi/pci_ipmi_bt.c      |  50 +++++++++++++--------
 hw/ipmi/pci_ipmi_kcs.c     |  11 +++++
 hw/smbios/smbios_type_38.c |   7 ++-
 include/hw/ipmi/ipmi.h     |  15 +++++++
 11 files changed, 170 insertions(+), 46 deletions(-)


