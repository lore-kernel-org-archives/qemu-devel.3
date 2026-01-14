Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1DAD38FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 17:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg50j-0001le-Nd; Wed, 14 Jan 2026 12:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vg50j-0001lO-0O
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:50:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vg50h-0008Sr-7m
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768413020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wXFRdfgha3IAcabnT3zx5QHsWtqFvEa1mHJ7Qyzdn18=;
 b=ZpZ83HKurrVqz0+hIir85ZoOsw4BVoDI4LrHsWFHNTvy/X36eA9WyMSXhOZmwh513BRW9F
 pJYqEtb+copHFSFAjsBlJ7jA7lHyRmdjYAktepUzptFodjUe76IMya3aUYYQ2xt17smLKj
 ALeG9CR7WCDpb0N5NZClJcF9D4XBquA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-xaFClcQKMoGxL-5YPBqFNQ-1; Wed,
 14 Jan 2026 12:50:17 -0500
X-MC-Unique: xaFClcQKMoGxL-5YPBqFNQ-1
X-Mimecast-MFC-AGG-ID: xaFClcQKMoGxL-5YPBqFNQ_1768413016
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4B44195605B; Wed, 14 Jan 2026 17:50:15 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.224.90])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 960BB1800665; Wed, 14 Jan 2026 17:50:09 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v4 0/5] igvm: Supply MADT via IGVM parameter
Date: Wed, 14 Jan 2026 18:50:02 +0100
Message-ID: <20260114175007.90845-1-osteffen@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When launching using an IGVM file, supply a copy of the MADT (part of the ACPI
tables) via an IGVM parameter (IGVM_VHY_MADT) to the guest, in addition to the
regular fw_cfg mechanism.

The IGVM parameter can be consumed by Coconut SVSM [1], instead of relying on
the fw_cfg interface, which has caused problems before due to unexpected access
[2,3]. Using IGVM parameters is the default way for Coconut SVSM; switching
over would allow removing specialized code paths for QEMU in Coconut.

Coconut SVSM needs to know the SMP configuration, but does not look at
any other ACPI data, nor does it interact with the PCI bus settings.
Since the MADT is static and not linked with other ACPI tables, it can
be supplied stand-alone like this.

Generating the MADT twice (IGVM processing and ACPI table building) seems
acceptable, since there is no infrastructure to obtain the MADT out of the ACPI
table memory area during IGVM processing.

In any case OVMF, which runs after SVSM has already been initialized, will
continue reading all ACPI tables via fw_cfg and provide fixed up ACPI data to
the OS as before.

This series makes ACPI table building more generic by making the BIOS linker
optional. This allows the MADT to be generated outside of the ACPI build
context. A new function (acpi_build_madt_standalone()) is added for that. With
that, the IGVM MADT parameter field can be filled with the MADT data during
processing of the IGVM file.

[1] https://github.com/coconut-svsm/svsm/pull/858
[2] https://gitlab.com/qemu-project/qemu/-/issues/2882
[3] https://github.com/coconut-svsm/svsm/issues/646

v4:
- Add ACPI table checksum calculation without BIOS linker, used
  for the standalone MADT.
- Don't pass ConfidentialGuestState into the IGVM backend anymore.
  Not needed, since we already have the full MachineState there now.
- Move the NULL check patch out into a new series (to be posted).
- Address remaining cleanup comments.

v3:
- Pass the machine state into IGVM file processing context instead of MADT data
- Generate MADT from inside the IGVM backend
- Refactor: Extract common code for finding IGVM parameter from IGVM parameter handlers
- Add NULL pointer check for igvm_get_buffer()

v2:
- Provide more context in the message of the main commit
- Document the madt parameter of IgvmCfgClass::process()
- Document why no MADT data is provided the process call in sev.c

Based-on: <20251118122133.1695767-1-kraxel@redhat.com>
Signed-off-by: Oliver Steffen <osteffen@redhat.com>

Oliver Steffen (5):
  hw/acpi: Make BIOS linker optional
  hw/acpi: Add standalone function to build MADT
  igvm: Add common function for finding parameter entries
  igvm: Pass machine state to IGVM file processing
  igvm: Fill MADT IGVM parameter field

 backends/igvm-cfg.c       |   2 +-
 backends/igvm.c           | 179 +++++++++++++++++++++++---------------
 hw/acpi/aml-build.c       |  29 +++++-
 hw/i386/acpi-build.c      |   9 ++
 hw/i386/acpi-build.h      |   2 +
 include/system/igvm-cfg.h |   3 +-
 include/system/igvm.h     |   5 +-
 target/i386/sev.c         |   3 +-
 8 files changed, 155 insertions(+), 77 deletions(-)

-- 
2.52.0


