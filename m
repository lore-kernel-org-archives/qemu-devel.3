Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7BFC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxpg-0000qr-KJ; Tue, 25 Feb 2025 11:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxpa-0000p5-GK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:30:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxpW-0006Tb-IM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740501041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9GehLNe7etmLkUbv+QQdgr0lKutwB8VUIijA7YUk4QY=;
 b=NoG8Htdobjt3j5c0TsJCc4bNT7aNdDqzLh2zpsiXK0SaRjTB0OnD3OfcIqeikUKLMo+LeJ
 5ZNIABJCnFI3c94vIewfq63qnoECZnpit6njQDVE+4NLEuHDoo49Hu83vyqHfwfVpgKY0m
 xTHRyqoc7zf2Xs922EnKeWRG0Gq6zRc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-c-UnSNBbNaqiqt7VStVemg-1; Tue,
 25 Feb 2025 11:30:38 -0500
X-MC-Unique: c-UnSNBbNaqiqt7VStVemg-1
X-Mimecast-MFC-AGG-ID: c-UnSNBbNaqiqt7VStVemg_1740501035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59639190F9CB; Tue, 25 Feb 2025 16:30:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E02801800366; Tue, 25 Feb 2025 16:30:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 79C5F1800091; Tue, 25 Feb 2025 17:30:31 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 00/24] hw/uefi: add uefi variable service
Date: Tue, 25 Feb 2025 17:30:04 +0100
Message-ID: <20250225163031.1409078-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v5 changes:
 - improve qapi documentation (Markus)
 - fixes etc/hardware-info code (byte order, double free).
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
 hw/uefi/hardware-info.c            |  31 ++
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
 qapi/uefi.json                     |  55 +++
 33 files changed, 3893 insertions(+)
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


