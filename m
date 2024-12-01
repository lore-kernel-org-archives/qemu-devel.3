Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B38D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmek-0006CM-V8; Sun, 01 Dec 2024 11:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmW6-0004cL-EX
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:50 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmW4-0000L4-Cj
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:49 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-724e1b08fc7so2897924b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733069385; x=1733674185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cQJ0sQP0WStMTUp5bqiC0Fd83+QZhWD/biVMuU84hkc=;
 b=Z4vAvuV2N9sON8R8dMbO4qLgV2OsoE1m4An+IqavJ5j9ro0/paWhn7yWn1cBlQ4PcQ
 pt+qNlb+I549zhOLq58aW3WYhRoQSleXhwMcGAZLoHxy79ZXv+W6lFynxGgw0qdX6DFx
 ClCpJ5K0fVxl0hlFWDGT1oHBtRn6ftdeNdMG1yT7heaPniV3SSSPQUxgCp1J5yzMNhlx
 GKyzU/GU9kFK8XmTG6+x94GhJPjmKssWrUX1mA+9IlD8cbizkhIxhmrDGOJkdU4v3fQj
 2PajQinSjrAeOYDYL2p1rOWNid4lRqS9K2vG9jdmNYTXKAaQ+w9keOpVl25LtlDKbWPh
 LR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069385; x=1733674185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cQJ0sQP0WStMTUp5bqiC0Fd83+QZhWD/biVMuU84hkc=;
 b=Fxn0NvzZlz1Aw2xnKBSg+xiuURnopJYhDFq1j7747SqBMxW2HQU6FszrSmmYSCG8Ey
 WuFO104x9nrCkqSXVFnf2yk0z0RHrzT8Q0pHpA5mAYyz4+ukWi0d+W3kQ/5lQafjm6D3
 jh3MEtvDPCLdjxsEInQSNu23185//H+jx/kU3fThnizFPKl+I0v0D+l2pOcG+d1uJWZH
 pyPa8csh65wej5PVq8VhttDIbzHFe9L6PbdN4NHbmVPSWEkTVpafg8fJfIlO1Qw3j26T
 z1enAsB5p9AcqqljColcA4nuv1ivjup7N25UeYs14g6aLjiCjixbaOnW5PZjbeWLLGLk
 mwVw==
X-Gm-Message-State: AOJu0Yz9+mCYB6ryySaM0WVtXP3lydRshXqywkkGjKyqp0EakRUQ9pln
 I6WTQgfVx0OXYX2OTld22et3kEKVQWVyxSpVAu52o6iO2PGgxQHvhygRTmkWGyMc
X-Gm-Gg: ASbGncuoj2KdpDk8FOpS5h9vbF10htYtby3FE7uIgX9Rm5SpqewcQ5XxaBgiBTqXfDI
 zdIlcHsA59dH58h35TktaCFpOEGAcpEMD9kX7uOHhuphMHsOaEowSZTrkzr/nS5CLbXOKYFz/sX
 MHV/YprrYCy0k6bTJ9Bws0JaIxs/1aBHg/UX2HeNfB6+WWLKwvTWMNPYbDXgO9j2AdapyRTDTWx
 MO8UfMc0q9DGn47B9R0XlpjYUrF8zAWnK4jZdGhHF19wb1ozkmqt5Hv8cE=
X-Google-Smtp-Source: AGHT+IFjKwNWhWs5GxMc/+lXSw3694YSaogKYVLKuYwHF6h+2P5XpE81j5JHV0L7n5RRH4WcR5nmmQ==
X-Received: by 2002:a05:6a00:21ca:b0:71e:47a2:676 with SMTP id
 d2e1a72fcca58-72530013c8dmr27886952b3a.6.1733069385221; 
 Sun, 01 Dec 2024 08:09:45 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f47asm6785783b3a.43.2024.12.01.08.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:09:44 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 0/8] vfio/igd: Enable legacy mode on more devices
Date: Mon,  2 Dec 2024 00:09:30 +0800
Message-ID: <20241201160938.44355-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Dec 2024 11:18:41 -0500
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

This patchset extends the support of legacy mode igd passthrough to
all Intel Gen 11 and 12 devices (including Ice Lake, Jasper Lake,
Rocket Lake, Alder Lake and Raptor Lake), and emulates GGC register
in MMIO BAR0 for better compatibiltiy (It is tested Windows and GOP
driver will read this MMIO register).

It also replaces magic numbers with macros to improve readability,
and aligns behavior (BDSM registor mirroring and GGMS calculation for
gen7) with i915 driver to avoid possible issues.

The x-igd-gms option removed in 971ca22f041b ("vfio/igd: don't set
stolen memory size to zero") is also added back so that data stolen
memory size can be specified for guest. It is tested that GMS may
related to framebuffer size, a small GMS value may cause display issues
like blackscreen. It can be changed by DVMT Pre-allocated option in
host BIOS, but not all BIOS comes with this option. Having it in QEMU
helps resolves such issues.

This patchset was verified on Intel i9-12900K CPU(UHD 770, 8086:4680)
with custom OVMF firmware [1] and IntelGopDriver extracted from host
bios. IGD device works well in both Windows and Linux guests, and
scored 726 in 3DMark Time Spy Graphics on Windows guest.

[1] https://github.com/tomitamoeko/edk2/commits/igd-pt-adl/

Btw, IO BAR4 seems never be used by guest, and it the IO BAR itself
is not working on Gen11+ devices in my experiments. There is no hints
about that in old commit message and mailing list. It would be greatly
appreciated if someone shares the background.


Tomita Moeko (8):
  vfio/igd: fix GTT stolen memory size calculation for gen 7
  vfio/igd: canonicalize memory size calculations
  vfio/igd: remove unsupported device ids
  vfio/igd: align generation with i915 kernel driver
  vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
  vfio/igd: emulate GGC register in mmio bar0
  vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
  vfio/igd: add x-igd-gms option back to set DSM region size for guest

 hw/vfio/igd.c | 240 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 144 insertions(+), 96 deletions(-)

-- 
2.45.2


