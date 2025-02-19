Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A455AC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 07:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkeIT-0002HZ-0I; Wed, 19 Feb 2025 02:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeID-00029l-5L
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeI8-0004x1-KP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739949282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H0ly+Ik9R8QxBVmgfFGjfY1mlDOzgNavtHRoKYMQm7Y=;
 b=EAp9XS3izwQQOZfAunjw3ehuDPpcJ3HjIJaeiQH2/sBZRDyFECvMnlx3c0LyD8zvA/gfS5
 hA8cawV25awzlEORzse5NY56JlSS9QADHFcEG9dLWckQStGrJbhl9UlG8+5azG2Fxj2taV
 jwJK2jUSI2bvRKkARWNoNJZwfiXAITo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-M7A5Lu5jPxeZ2gLUX3aq0w-1; Wed,
 19 Feb 2025 02:14:38 -0500
X-MC-Unique: M7A5Lu5jPxeZ2gLUX3aq0w-1
X-Mimecast-MFC-AGG-ID: M7A5Lu5jPxeZ2gLUX3aq0w_1739949276
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5947A180036F; Wed, 19 Feb 2025 07:14:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.78])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EAB21955BCB; Wed, 19 Feb 2025 07:14:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E07521800082; Wed, 19 Feb 2025 08:14:31 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 graf@amazon.com, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 00/24] hw/uefi: add uefi variable service
Date: Wed, 19 Feb 2025 08:14:02 +0100
Message-ID: <20250219071431.50626-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds a virtual device to qemu which the uefi firmware can use
to store variables.  This moves the UEFI variable management from
privileged guest code (managing vars in pflash) to the host.  Main
advantage is that the need to have privilege separation in the guest
goes away.

On x86 privileged guest code runs in SMM.  It's supported by kvm, but
not liked much by various stakeholders in cloud space due to the
complexity SMM emulation brings.

On arm privileged guest code runs in el3 (aka secure world).  This is
not supported by kvm, which is unlikely to change anytime soon given
that even el2 support (nested virt) is being worked on for years and is
not yet in mainline.

The design idea is to reuse the request serialization protocol edk2 uses
for communication between SMM and non-SMM code, so large chunks of the
edk2 variable driver stack can be used unmodified.  Only the driver
which traps into SMM mode must be replaced by a driver which talks to
qemu instead.

A edk2 test branch can be found here (build with "-D QEMU_PV_VARS=TRUE").
https://github.com/kraxel/edk2/commits/devel/secure-boot-external-vars

The uefi-vars device re-implements the privileged edk2 protocols
(i.e. the code running in SMM mode).

v4 changes:
 - drop the isa variant in favor of a x64-specific sysbus variant using
   mmio to expose the device registers.
 - use etc/hardware-info for device discovery on x64.
 - add pio transfer mode support.
v3 changes:
 - switch sysbus device variant to use the qemu platform bus.
 - misc minor changes.
v2 changes:
 - fully implement authenticated variables.
 - various cleanups and fixes.

enjoy & take care,
  Gerd

Gerd Hoffmann (24):
  Add support for etc/hardware-info fw_cfg file
  hw/uefi: add include/hw/uefi/var-service-api.h
  hw/uefi: add include/hw/uefi/var-service-edk2.h
  hw/uefi: add include/hw/uefi/var-service.h
  hw/uefi: add var-service-guid.c
  hw/uefi: add var-service-utils.c
  hw/uefi: add var-service-vars.c
  hw/uefi: add var-service-auth.c
  hw/uefi: add var-service-policy.c
  hw/uefi: add var-service-core.c
  hw/uefi: add var-service-pkcs7.c
  hw/uefi: add var-service-pkcs7-stub.c
  hw/uefi: add var-service-siglist.c
  hw/uefi: add var-service-json.c + qapi for NV vars.
  hw/uefi: add trace-events
  hw/uefi: add UEFI_VARS to Kconfig
  hw/uefi: add to meson
  hw/uefi: add uefi-vars-sysbus device
  hw/uefi-vars-sysbus: qemu platform bus support
  hw/uefi-vars-sysbus: add x64 variant
  hw/uefi-vars-sysbus: allow for arm virt
  hw/uefi-vars-sysbus: allow for pc and q35
  hw/uefi: add MAINTAINERS entry
  docs: add uefi variable service documentation

 include/hw/uefi/hardware-info.h    |  35 ++
 include/hw/uefi/var-service-api.h  |  48 ++
 include/hw/uefi/var-service-edk2.h | 227 +++++++++
 include/hw/uefi/var-service.h      | 191 ++++++++
 hw/arm/virt.c                      |   2 +
 hw/core/sysbus-fdt.c               |  24 +
 hw/i386/pc_piix.c                  |   2 +
 hw/i386/pc_q35.c                   |   2 +
 hw/uefi/hardware-info.c            |  33 ++
 hw/uefi/var-service-auth.c         | 361 ++++++++++++++
 hw/uefi/var-service-core.c         | 321 +++++++++++++
 hw/uefi/var-service-guid.c         |  99 ++++
 hw/uefi/var-service-json.c         | 243 ++++++++++
 hw/uefi/var-service-pkcs7-stub.c   |  16 +
 hw/uefi/var-service-pkcs7.c        | 436 +++++++++++++++++
 hw/uefi/var-service-policy.c       | 370 +++++++++++++++
 hw/uefi/var-service-siglist.c      | 212 +++++++++
 hw/uefi/var-service-sysbus.c       | 124 +++++
 hw/uefi/var-service-utils.c        | 241 ++++++++++
 hw/uefi/var-service-vars.c         | 725 +++++++++++++++++++++++++++++
 MAINTAINERS                        |   6 +
 docs/devel/index-internals.rst     |   1 +
 docs/devel/uefi-vars.rst           |  68 +++
 hw/Kconfig                         |   1 +
 hw/meson.build                     |   1 +
 hw/uefi/Kconfig                    |   3 +
 hw/uefi/LIMITATIONS.md             |   7 +
 hw/uefi/meson.build                |  21 +
 hw/uefi/trace-events               |  17 +
 meson.build                        |   1 +
 qapi/meson.build                   |   1 +
 qapi/qapi-schema.json              |   1 +
 qapi/uefi.json                     |  45 ++
 33 files changed, 3885 insertions(+)
 create mode 100644 include/hw/uefi/hardware-info.h
 create mode 100644 include/hw/uefi/var-service-api.h
 create mode 100644 include/hw/uefi/var-service-edk2.h
 create mode 100644 include/hw/uefi/var-service.h
 create mode 100644 hw/uefi/hardware-info.c
 create mode 100644 hw/uefi/var-service-auth.c
 create mode 100644 hw/uefi/var-service-core.c
 create mode 100644 hw/uefi/var-service-guid.c
 create mode 100644 hw/uefi/var-service-json.c
 create mode 100644 hw/uefi/var-service-pkcs7-stub.c
 create mode 100644 hw/uefi/var-service-pkcs7.c
 create mode 100644 hw/uefi/var-service-policy.c
 create mode 100644 hw/uefi/var-service-siglist.c
 create mode 100644 hw/uefi/var-service-sysbus.c
 create mode 100644 hw/uefi/var-service-utils.c
 create mode 100644 hw/uefi/var-service-vars.c
 create mode 100644 docs/devel/uefi-vars.rst
 create mode 100644 hw/uefi/Kconfig
 create mode 100644 hw/uefi/LIMITATIONS.md
 create mode 100644 hw/uefi/meson.build
 create mode 100644 hw/uefi/trace-events
 create mode 100644 qapi/uefi.json

-- 
2.48.1


