Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122BBD41C17
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTdxm-0001qk-5D; Thu, 11 Dec 2025 05:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vTdxi-0001pV-Fv
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vTdxb-0008DR-0e
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765449105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CNu7aYtpnZTgEr/pYDepnXkeEryWF/o9NrGGdONhRYM=;
 b=BwfI4rvkA8xBZ71Gg57ph6OshqCk9Iej28pTjbPJj9/PIXbhcTgHiDU+2ioWiF2Te5BUVT
 bxVl547qBPONhWXTjC5BGBKBpTZ/AYRlLId37j0/Z1hRFx4ADInXEn7xhBHFgXyTq3d/E1
 AfC2DuwbquxHIm6lB/yecst9n/CqQeI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-ZiSs3Q7RMBKfJBrdM_Hhig-1; Thu,
 11 Dec 2025 05:31:44 -0500
X-MC-Unique: ZiSs3Q7RMBKfJBrdM_Hhig-1
X-Mimecast-MFC-AGG-ID: ZiSs3Q7RMBKfJBrdM_Hhig_1765449103
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19ABD18001E4; Thu, 11 Dec 2025 10:31:43 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.225.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B30111800451; Thu, 11 Dec 2025 10:31:37 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>,
 Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v2 0/3] igvm: Supply MADT via IGVM parameter
Date: Thu, 11 Dec 2025 11:31:33 +0100
Message-ID: <20251211103136.1578463-1-osteffen@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When launching using an IGVM file, supply a copy of the MADT (part of the ACPI
tables) via an IGVM parameter (IGVM_VHY_MADT) to the guest, in addition to the
regular fw_cfg mechanism.

The IGVM parameter can be consumed by Coconut SVSM [1], instead of relying on
the fw_cfg interface, which has caused problems before due to unexpected access
[2,3]. Using IGVM parameters is the default way for Coconut SVSM; switching
over would allow removing specialized code paths for QEMU in Coconut.

In any case OVMF, which runs after SVSM has already been initialized, will
continue reading all ACPI tables via fw_cfg and provide fixed up ACPI data to
the OS as before.

This series makes ACPI table building more generic by making the BIOS linker
optional. This allows the MADT to be generated outside of the ACPI build
context. A new function (acpi_build_madt_standalone()) is added for that. With
that, the IGVM MADT parameter field can be filled with the MADT data during
processing of the IGVM file.

Generating the MADT twice (IGVM processing and ACPI table building) seems
acceptable, since there is no infrastructure to obtain the MADT out of the ACPI
table memory area during IGVM processing.

[1] https://github.com/coconut-svsm/svsm/pull/858
[2] https://gitlab.com/qemu-project/qemu/-/issues/2882
[3] https://github.com/coconut-svsm/svsm/issues/646

v2:
- Provide more context in the message of the main commit
- Document the madt parameter of IgvmCfgClass::process()
- Document why no MADT data is provided the the process call in sev.c

Based-On: <20251118122133.1695767-1-kraxel@redhat.com>
Signed-off-by: Oliver Steffen <osteffen@redhat.com>

Oliver Steffen (3):
  hw/acpi: Make BIOS linker optional
  hw/acpi: Add standalone function to build MADT
  igvm: Fill MADT IGVM parameter field

 backends/igvm-cfg.c       |  8 +++++++-
 backends/igvm.c           | 37 ++++++++++++++++++++++++++++++++++++-
 hw/acpi/aml-build.c       |  7 +++++--
 hw/i386/acpi-build.c      |  8 ++++++++
 hw/i386/acpi-build.h      |  2 ++
 include/system/igvm-cfg.h |  5 ++++-
 include/system/igvm.h     |  2 +-
 target/i386/sev.c         |  5 +++--
 8 files changed, 66 insertions(+), 8 deletions(-)

-- 
2.52.0


