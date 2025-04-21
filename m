Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B34EC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u3y-0007ph-Ao; Mon, 21 Apr 2025 12:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u3v-0007p8-Hz
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:03 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u3t-0003GH-DI
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:03 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2255003f4c6so46922235ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253119; x=1745857919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qnlmOE4B78MGjrUjFe3AZSg2QY5RPesYv4t6F2DHU/w=;
 b=nszlT05752fSffZgUlrlFYzYEcV/oh6t8pYODyZ1CWqje67ZB7wCds77qH/PHEM7dw
 Zg9hg2sP0xQYJ0mi9ZNMX5IINXsWnoRQNVY3/jHFTXHewRF70V4S8TnDtmdvWflSq23x
 TdvaiClLyBTKtHx6oUO8y0gJxyGktpg2xuvL+65CS1x2oaEPNZXBSNS5G3rOXv+W6Tw9
 JDGEAc0wTv5AXXLYdDmuR6lnytfNTdGUZuL4BECkfWdreJdb3dPiYJudqKd2H3QxMLAd
 Y5fHz+lmIP8ZCHVwmyqbq2UoeJT8hESdvGWG2BRs67h0/O59gPj3aj3wvSjBR0vizrWj
 0AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253119; x=1745857919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qnlmOE4B78MGjrUjFe3AZSg2QY5RPesYv4t6F2DHU/w=;
 b=k4NE/rNP/E/Vq+vnLr4VNPntAS756memjq/uaFX2gFmvN2c+Bxqa4XsBE34GbQgeTW
 Z7pLmgj4+e5vsisZ1kI6AmemWXkBCW/oSQQTTaG+0K6TN40VuXcfBFY5joC93654iWnE
 376vu2xAQlwzcIqtErml4HSGUy2Xk4ltV10fVwiMqcVmhI1zni1p9eoYytmFqaPEl8M4
 7nyGAP+sBRlDoTry0TK+lsCD7/VZCcbeYNuSptjA4dnZ0AZWbdexh6NPNa4mzsfuj17A
 CK6/1qIcgFwntb5JZ3sVE0/fBhZ2B78JbtwihnJoVw0/qrPTro/1xsJHKy5dKRAu0XyK
 sCUQ==
X-Gm-Message-State: AOJu0YyywgVdHUF5e+NDhe69BjgNdQsZJ+w0TaKHq6ZBpRcJNZ0M/RXL
 n2eoKdERBG9CM4KDdrnjZ2eHqyR0h+hW3ScW2MmxdI0HTCiEnjs=
X-Gm-Gg: ASbGncu2gEXKeuUFJM1S3Y+HEnFez0cJxk/x1mftsIMDvG/XC2D8kNKuHq45NYj7GUE
 OH5aWHjwO/6vDi2l8s/DPUJ7gpRN+HuxdY68e257Qn+HYOo6XBoAWLxmSSttYHJlO884ff3qD+V
 0Vc/ShxFHTv9/p6DWvtFoWUVPjXb0lla9rlTffhcpsOwPhGKjKPquKfmZWPvpee42/pRYPBZqlZ
 OG5qL3jIN6MKk1XLTYOvQOfh49WqmWXKR/jVO4xk95EIsItyLImBjxupfu5L9zDjgsgp4klBCVa
 4VkyJlL9eaY/d64EEXyJ752mljhDdaBT34+/oYnyQ4KHu+wUAJPnQA==
X-Google-Smtp-Source: AGHT+IHztwTX8pOlY/L2S4CQvJhB1AiAQfxvWj7WNQSGG++8YdKTELj4peactvV/GaHHxv08cWt9TA==
X-Received: by 2002:a17:902:ec90:b0:229:1717:8826 with SMTP id
 d9443c01a7336-22c535b4a1cmr183429215ad.28.1745253119429; 
 Mon, 21 Apr 2025 09:31:59 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:31:59 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 00/11] vfio/igd: Detect IGD by OpRegion and enable OpRegion
 automatically
Date: Tue, 22 Apr 2025 00:31:00 +0800
Message-ID: <20250421163112.21316-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
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

As proposed in a previous discussion [1], detect IGD devices based on
whether it has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION exposed by kernel
and enables OpRegion access by default. This enables out-of-the-box
display output support for IGD passthrough without having to manually
set x-igd-opregion=on, which probably saves effort for libvirt users.

This patchset also limits legacy mode to Gen6-9 devices, as Intel no
longer provides CSM support and VBIOS on newer IGD, and Seabios does not
support setting up the 64 bit BDSM register on Gen 11+ devices. Exposing
VGA ranges to guests by default on platforms without VGA mode support is
undesirable.

Additionally, as we enables OpRegion on IGD devices by default, and
Intel removes the BDSM register from Meteor Lake [2]. There seems to be
no extra register quirks rather than OpRegion required on newer devices.
To support them (and probably future devices), the generation limit is
removed, with BDSM quirk only applied to known Gen 6-12 devices. 

Note: I have not been able to test this on Meteor Lake or newer
platforms due to lack of hardware.


[1] https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com/T/
[2] https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/

Tomita Moeko (11):
  vfio/igd: Restrict legacy mode to Gen6-9 devices
  vfio/igd: Always emulate ASLS (OpRegion) register
  vfio/igd: Detect IGD device by OpRegion
  vfio/igd: Remove vfio_pci_igd_setup_opregion
  vfio/igd: Check vendor and device ID on GVT-g mdev
  vfio/igd: Enable OpRegion by default
  vfio/igd: Allow hotplugging with OpRegion enabled
  vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on Gen9+
  vfio/igd: Only emulate GGC register when x-igd-gms is set
  vfio/igd: Remove generation limitation for IGD passthrough
  vfio/igd: Update IGD passthrough documentation

 docs/igd-assign.txt |  11 +-
 hw/vfio/igd.c       | 257 ++++++++++++++++++++++++--------------------
 hw/vfio/pci.c       |   2 +-
 3 files changed, 153 insertions(+), 117 deletions(-)

-- 
2.47.2


