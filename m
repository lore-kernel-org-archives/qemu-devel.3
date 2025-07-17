Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C57C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLZc-00047x-4Y; Thu, 17 Jul 2025 06:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ucLZ3-0003ZM-Tr
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ucLYx-0006FY-Rw
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752746999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gwrIjKZXPzjGjDfnEc6fu0I6MYM54EUGopYwGukpD9Q=;
 b=NZW16nSHCDwGHbDBHysspmpwLG61mZPvQeWGllmCbWCZIhXuxE3HHXMsOi8IPyC11a6+pc
 g7SEL+iXiMw2kVubsKYFfkcnj4nyQcyMZlS0VFz7M1OXN3oR3v25mb/6vSlERTBnHx+m4r
 y3Fjdvfgzq2zq8RUUMYIfS0VoBoAqFQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-lSrjYRKUMhSVuEZzFhaKrg-1; Thu,
 17 Jul 2025 06:09:57 -0400
X-MC-Unique: lSrjYRKUMhSVuEZzFhaKrg-1
X-Mimecast-MFC-AGG-ID: lSrjYRKUMhSVuEZzFhaKrg_1752746995
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1857F19560A2; Thu, 17 Jul 2025 10:09:55 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6645B180035E; Thu, 17 Jul 2025 10:09:47 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Shaoqin Huang <shahuang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v11 0/3] ramfb: Add property to control if load the romfile
Date: Thu, 17 Jul 2025 06:09:38 -0400
Message-Id: <20250717100941.2230408-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently the ramfb device loads the vgabios-ramfb.bin unconditionally, but only
the x86 need the vgabios-ramfb.bin, this can cause that when use the
release package on arm64 it can't find the vgabios-ramfb.bin.

Because only seabios will use the vgabios-ramfb.bin, load the rom logic
is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
for ramfb, so they don't need to load the romfile.

So add a new property use-legacy-x86-rom in both ramfb and vfio_pci
device, because the vfio display also use the ramfb_setup() to load
the vgabios-ramfb.bin file.

After have this property, the machine type can set the compatibility to
not load the vgabios-ramfb.bin if the arch doesn't need it.

Then I set the use_legacy_x86_rom property to false by default, and only set it
to true on x86 since only x86 will need it.

At the same time, set the "use-legacy-x86-rom" property to true on those
historical versioned machine types in order to avoid the memory layout
being changed.

Changelog:
---------
v10 -> v11:
  - Move TYPE* from hw/vfio/pci.h to hw/vfio/types.h
v9 -> v10:
  - Fix the long line.
  - Add the reviewed-by and ack.
v8 -> v9:
  - Improve the commit message.
v7 -> v8:
  - Set the property in microvm machine type.
v6 -> v7:
  - Set the property into hw_compat_10_0 instead of hw_compat_9_2.
v5 -> v6:
  - Set the property to true on those historical versioned machine types.
v4 -> v5:
  - Fix some typo error.
  - Set the property in piix machine type.
v3 -> v4:
  - Set the new property to false by default, only set it to true on x86.
v2 -> v3:
  - Fix the underscore error.
  - Add a new patch to set the property in arm compatibility.
v1 -> v2:
  - Change the property name.

v9: https://lore.kernel.org/all/20250704030315.2181235-1-shahuang@redhat.com/
v7: https://lore.kernel.org/all/20250702085616.2172722-1-shahuang@redhat.com/
v6: https://lore.kernel.org/all/20250701030549.2153331-1-shahuang@redhat.com/
v5: https://lore.kernel.org/all/20250626034526.2136585-1-shahuang@redhat.com/
v4: https://lore.kernel.org/all/20250617030521.2109305-1-shahuang@redhat.com/
v3: https://lore.kernel.org/all/20250609073408.2083831-1-shahuang@redhat.com/
v2: https://lore.kernel.org/all/20250606070234.2063451-1-shahuang@redhat.com/
v1: https://lore.kernel.org/all/20250605030351.2056571-1-shahuang@redhat.com/

Shaoqin Huang (3):
  ramfb: Add property to control if load the romfile
  vfio: Move the TYPE_* to hw/vfio/types.h
  hw/i386: Add the ramfb romfile compatibility

 hw/core/machine.c             |  2 ++
 hw/display/ramfb-standalone.c |  5 ++++-
 hw/display/ramfb-stubs.c      |  2 +-
 hw/display/ramfb.c            |  6 ++++--
 hw/i386/microvm.c             |  3 +++
 hw/i386/pc_piix.c             | 10 ++++++++++
 hw/i386/pc_q35.c              |  3 +++
 hw/vfio/display.c             |  4 ++--
 hw/vfio/pci.c                 |  2 ++
 hw/vfio/pci.h                 | 11 ++---------
 hw/vfio/types.h               | 21 +++++++++++++++++++++
 include/hw/display/ramfb.h    |  2 +-
 12 files changed, 55 insertions(+), 16 deletions(-)
 create mode 100644 hw/vfio/types.h

-- 
2.40.1


