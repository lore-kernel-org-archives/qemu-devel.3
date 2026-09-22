Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995F0C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 22:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x991G-0004Ky-UR; Tue, 22 Sep 2026 18:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991D-0004Jk-6L
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:19 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991A-0004Lc-G5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:18 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a985e8fcddso415988a12.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790116274; x=1790721074;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OucnfmacwjBG2iuXVRVUDee1I1ZAiGpPp6MPWah0ta8=;
 b=AfHpXFEObmDO/ZRDXdSGDw9Mw5MNRFoy+jmoXdN+35Eci41hpUDiKvBINQqfxR3gnC
 NcQmnp40GrveNCeG15icMAq4JcF4o9JdPxkcGkRO30eFsUwPXhUKcLQ97EYE2viECGqj
 zXxofJXhZE766bQN2pO4kKiqF3oaWe8qHeiFRjhAO8C0yQZz0jrwGYv6bg7X9SE3cKeE
 bZURxMgYbMPbXVQDDNB+PhhfcAEHZmHcyjZX26IzwNKG5Y92AGr6J+MtVxFnl7+TAuu4
 laQi4pX1pNWqS9nXvHOuBetzqBon5Zui3wuABeIP5P5yP3gtBKEjcb6UZZnoQlqCPXGT
 zKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790116274; x=1790721074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OucnfmacwjBG2iuXVRVUDee1I1ZAiGpPp6MPWah0ta8=;
 b=Y+1bWkc+Mu1uNJdCqWHLFRWSKKdwmd437tm/yR+YJxTcSxJZgmSx2OE1oPB5F4sbaI
 +GTewjf3yQwh4As4Q9oolD2CfOdMAJ0UlLCZahlU6lhNUmhSQoTmMLFfS+f3zcPRE/82
 8/mDvdMgSCtJXUKJyp+t8jzGJQJEun+eyRzCVJLEjRx7xjlebytNcUdpnIJpj+kDIX8b
 pRZ7E9fXc2FVUrzCKnpY0qtyiJGoHcUsyMAaEWj1JIvMIRJQTFjKj6tsLkxAHBCcVxrj
 0p29vh8lZnd6fWKOsZPmQ7WFwKAnc8OsAqzSjZlgTW9q9UcqHeaK6RnXgLjoUDBNJkcn
 PpFA==
X-Gm-Message-State: AFuF++mk6MamOyaKN9VmC/up88t3RfV1lL5WIeeG/FIYwjZ7pasSyAEY
 HlBxIu7cJ61Mr/b21p4wOk9n0ZK/EbQrD3zspc5aZru+1nvvbRfxJk/hMp2tirzH6ihaPoC6q9l
 FPeVpNFs=
X-Gm-Gg: AYBFou04rZ3RlWBNKcqjmgwyhsrjdLBnJMDMUnjKGv7XlYZ/pyrAYjD+43FFhZ+2vGE
 k1HQlMMCB66F/NyzXMeivmgXmjkB6zPmBt8VDyIm2vTEdS+r5CVrh569OSwfT9Ot+Wg9fivbL0l
 JM1wu0g58YsRmyQ8JEtLyEutIrZ+gPIWyY6j3kFmgaWHL3y8IfgJrRynWeY6YWl7JvtQvlymSeq
 Ztg1osw7UGeOAZHzhvl+7kb3YAAwJq4yRqxhrl7FHV2O0Ok7AXG3QyD0EMitBoRW7rnWevaCxC/
 P1pqYzy1gS/PU5nLP6n37bm5CpJpBRCeD8cngwV3ngegCKTfAL1A0AlvCBQliIEQNnYPtZHEq2l
 c8ntTxMSij5+fwWonuVtdyOSe8zeYbERRj6I9R1M/UMmbBCyeI3jCReef/6tA7IOvkOwKC89FhL
 n8/pJPxZGz0g/60iyrdsuG99PhDUku0umC77mhA1T1MVKljSX5QlBniId1FqkxrCW/gvM0tnquC
 s3HsJ1RGbOP/NEaGOnsZKMC6t9CsGqamH5aOovGiC+aYCxnzup5/Uy6PTALTxGVgQ==
X-Received: by 2002:a05:6402:320d:b0:6a7:ee56:6155 with SMTP id
 4fb4d7f45d1cf-6aab3b5e824mr663122a12.23.1790116274103; 
 Tue, 22 Sep 2026 15:31:14 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab3883151sm411663a12.14.2026.09.22.15.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 15:31:12 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 jasowangio@gmail.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com
Subject: [PATCH v2 0/6] hw: Add Cnuas virtual devices
Date: Tue, 22 Sep 2026 22:30:39 +0000
Message-ID: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:33::10;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-ed2-x10.google.com
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

This series adds PCI IDs and QEMU models for the Cnuas virtual network
adapter and CnuasGPU AI/ML accelerator. The models provide compact interfaces
for guest-driver, RDMA, device-memory, and accelerator-fabric development.

The CnuasNIC model exposes a register-driven DMA interface and transports
complete frames over a Linux SOCK_SEQPACKET endpoint. CnuasGPU provides an
MMIO control BAR, a configurable device-memory BAR, and an optional link
transport.

Both models include reset and migration state, MSI and INTx support,
specifications, and qtests. The transport tests exercise host-to-device and
device-to-host data movement rather than only PCI enumeration.

Changes since v1:

- submit the PCI ID allocations with the corresponding device models
- use 1b36:0015 for CnuasNIC and 1b36:0016 for CnuasGPU

The complete QEMU device implementation is included in this patch series.

Regards,

Weqaar Janjua
Packet Five Networks Ltd.
Dublin, Ireland
https://www.packetfive.com

Weqaar Janjua (6):
  pci: Add device ID for CnuasNIC
  hw/net: Add Cnuas virtual network adapter
  tests/qtest: Add Cnuas virtual network adapter tests
  pci: Add device ID for CnuasGPU
  hw/misc: Add CnuasGPU virtual accelerator
  tests/qtest: Add CnuasGPU tests

 MAINTAINERS                   |  10 +
 docs/specs/cnuas-vnic.rst     |  78 +++++
 docs/specs/cnuasgpu.rst       |  91 ++++++
 docs/specs/index.rst          |   2 +
 docs/specs/pci-ids.rst        |   4 +
 hw/misc/Kconfig               |   5 +
 hw/misc/cnuasgpu.c            | 557 ++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |   1 +
 hw/net/Kconfig                |   5 +
 hw/net/cnuas_vnic.c           | 508 +++++++++++++++++++++++++++++++
 hw/net/meson.build            |   1 +
 include/hw/pci/pci.h          |   2 +
 tests/qtest/cnuas-vnic-test.c | 233 ++++++++++++++
 tests/qtest/cnuasgpu-test.c   | 274 +++++++++++++++++
 tests/qtest/meson.build       |   2 +
 15 files changed, 1773 insertions(+)
 create mode 100644 docs/specs/cnuas-vnic.rst
 create mode 100644 docs/specs/cnuasgpu.rst
 create mode 100644 hw/misc/cnuasgpu.c
 create mode 100644 hw/net/cnuas_vnic.c
 create mode 100644 tests/qtest/cnuas-vnic-test.c
 create mode 100644 tests/qtest/cnuasgpu-test.c

-- 
2.43.0

