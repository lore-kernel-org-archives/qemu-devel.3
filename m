Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7056C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzEH-0005Ju-1C; Mon, 05 May 2025 13:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzDv-0005HV-SN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:24 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzDt-0003Ww-9i
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:23 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so67069045ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464598; x=1747069398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E+Ze121Upacfoz8IaBGcogAwWWb1bzoTy2H3UXVQ56c=;
 b=R0CJrhRcDEEgJP2hBNQah5jk9uWWFrlTQ4mvhYb/tPhCejX7PTvGBS2OGKmCPxHBC2
 od1w5WjiUh8vs13GotcXYfluLSYo2eu/ixP/0WtLv9k/6VKCnaYLEN2U21KofKpCvLrQ
 ow78CWZxYUUoHP6wnYNHKcz4VJAQsse18O7TewgjTpJ0S31udFKEm4ghYOsKGKLpBuR5
 FtuWUsSuyX3fdJ5ZkO21MDc2x9b00ooV73Ai/CCexpEEsAX/lR4oLYp3U+fwmrn9mgYj
 ELeL5k5ymkXrxCg64SKTMAEQvpGB9V6KgiBZJ2R7w+jXB3fJfkE0aV4E3wQIrqH/KDB0
 G+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464598; x=1747069398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+Ze121Upacfoz8IaBGcogAwWWb1bzoTy2H3UXVQ56c=;
 b=WX+w009S6lVps0yvWK6nCGCrH/Q5Fr85uqupSCVn9Wc+vEQw6YdQrPhZqNC2uK3wsF
 aywjZVzU4Mm0bULLtdfPKZeLgzXCclrTdF9qCkOpRu4w5F3TnZvcpFLe/QDHrtxxZ3Rv
 2vND2AjlF1qkyX5k64cBSRJ18S7BWywKQWB7aGjMECP2Fl1kO1fVaZ+TNpoLMvzz/6a8
 0cbqxhINjeX2OOIPI0NXoQkw/tIWq+6yHF99rX97nGGCc2n7N7VLZm4MRO+xLq/aRbL3
 +DLL60ZXLkLXnIIVUofECCjOiSW59NvqyPpyuyZEl+7OBg8ZUBAaz5hgYVHBn8PMdv1o
 A3Nw==
X-Gm-Message-State: AOJu0YyaU9sl/7eTahCED+CuydZih8s/2S+m81CwK1E8W6gBqnMefFem
 TfYptb0gwkBhp6/BLeJHlLGL+W6UkJkLTwQtGB0J9SK01sTMPwCdibp5F1jxX7w6
X-Gm-Gg: ASbGnctl+rf6phZeBYxvYNTX8zjL6ab/m5FlWQ3Dz8zqHnzv/SAwlXUSvkpRs0qZ5jS
 JMhbGTpNH4CR/jbXbGRw1Dj2t/67nL4kP+PfSRdH1mKKA7DOqKT45Pj+qRLxVumu3DygVfewGh3
 VBc9vujBuVXtJ0VB/9iXyosUy+M8d0SZRW1UWcB3p3nw4YJr8WVHyAR87I0dN4LFA9sL0d3MjJ+
 ba/EiLFyI2sS1SpG7hUNDQgBN70E9fIp9G4NWLx0H6Tx1w8wWkFgu4lsq8DFc7+3h0zuZdl1fPF
 Nqit/c2mRgwxTaE4BDRFUClMwmcj3+d7v6jezcoWzXajeoCit9Uspw9A
X-Google-Smtp-Source: AGHT+IETM5X+ddqNxGm5o5IZzifYLeGgckQPh1iMccPiOGJN9ko+QiKkRrzWRjAjD53h6JCTkdFPWA==
X-Received: by 2002:a17:902:fc86:b0:223:635d:3e38 with SMTP id
 d9443c01a7336-22e18b94ab5mr145407795ad.15.1746464596879; 
 Mon, 05 May 2025 10:03:16 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:16 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 0/9] vfio/igd: Detect IGD by OpRegion and enable OpRegion
 automatically
Date: Tue,  6 May 2025 01:02:56 +0800
Message-ID: <20250505170305.23622-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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


[1] https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com
[2] https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/


Changelog:
v3:
* Addressed a nit in patch #8
Link: https://lore.kernel.org/qemu-devel/20250428161004.35613-1-tomitamoeko@gmail.com
v2:
* Removed "Allow hotplugging with OpRegion enabled", hotplugging is
  always forbidden.
* Test device is not hotplugged and get opregion in a single function.
* Update documentation along with code changes.
* Minor code style fixes.
Link: https://lore.kernel.org/qemu-devel/20250421163112.21316-1-tomitamoeko@gmail.com


Tomita Moeko (9):
  vfio/igd: Restrict legacy mode to Gen6-9 devices
  vfio/igd: Always emulate ASLS (OpRegion) register
  vfio/igd: Detect IGD device by OpRegion
  vfio/igd: Check vendor and device ID on GVT-g mdev
  vfio/igd: Check OpRegion support on GVT-g mdev
  vfio/igd: Enable OpRegion by default
  vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on Gen9+
  vfio/igd: Only emulate GGC register when x-igd-gms is set
  vfio/igd: Remove generation limitation for IGD passthrough

 docs/igd-assign.txt |  11 ++-
 hw/vfio/igd.c       | 220 ++++++++++++++++++++++++++------------------
 hw/vfio/pci.c       |   2 +-
 3 files changed, 138 insertions(+), 95 deletions(-)

-- 
2.47.2


