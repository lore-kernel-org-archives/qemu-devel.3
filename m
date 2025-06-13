Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FCFC71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ4aQ-0007dI-Aj; Fri, 13 Jun 2025 09:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ4aO-0007d6-1g
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:36:48 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ4aL-0005d7-N3
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:36:47 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.82])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id 2711A20051;
 Fri, 13 Jun 2025 14:36:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1749821803;
 bh=JGKqCEW8CNklInDdkOaXnVq37puYFFpaFQne6SLWSN4=;
 h=From:To:Cc:Subject:Date:From;
 b=SJEAQSjhuXEBn+CgpvrKvO6bvJ1UvMOTVYZdPH47/5SuZ2xfKWSmu9TV6ZanRT3Ma
 VLVIPt5BTl1c7b7uraddLHqf6eYjGNmkdTVLFiWjvHcqTB6tqjjHu3V/J4gE6C7rj+
 MkM6lMJQHQSXvU0aMrJedz/dN5lEM/FIqUJUXz84=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id A13E7C02FA;
 Fri, 13 Jun 2025 14:36:38 +0100 (BST)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v8 00/16] Introduce support for IGVM files
Date: Fri, 13 Jun 2025 14:36:11 +0100
Message-ID: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Here is v8 of the set of patches to add support for IGVM files to QEMU. This is
based on commit d9ce74873a6a5a7c504379857461e4ae64fcf0cd of qemu.

The previous version of this patch series [1] has only received a few comments
which are now addressed in this new version. Additionally, the series has
benefited from additional reviews and testing from the community. Therefore I
am hoping that this will be the final version and rebase of this patch series.

Suggestions have been received for adding support for setting CPU initial state
for non-confidential guests (Gerd) and for reorganization of the confidential-
guest support modules (dhildenb). These suggestions have not been
implemented in this version of the patch series, but I will look to implement
them in a future patch series.

The only functional change in this version is to fix an issue in patch 16/16
where the pre-parsing of the IGVM file caused an error after rebasing.
Additionally, commit metadata, version numbers and documentation changes have
been made, as suggested in review comments.

As always, thanks to those that have been following along, reviewing and testing
this series. This v8 patch series is also available on github: [2]

For testing IGVM support in QEMU you need to generate an IGVM file that is
configured for the platform you want to launch. You can use the `buildigvm`
test tool [3] to allow generation of IGVM files for all currently supported
platforms. Patch 11/17 contains information on how to generate an IGVM file
using this tool.

Changes in v8:

* Fix an issue found after rebasing where the pre-parsing of the IGVM file
  caused an error.
* Update version numbers for IGVM support to 10.1
* Minor changes to documentation.
* Add metadata to relevant commits.

Patch summary:

1-11: Add support and documentation for processing IGVM files for SEV, SEV-ES,
SEV-SNP and native platforms. 

12-15: Processing of policy and SEV-SNP ID_BLOCK from IGVM file. 

16: Add pre-processing of IGVM file to support synchronization of 'SEV_FEATURES'
from IGVM VMSA to KVM.

[1] Link to v7:
https://lists.gnu.org/archive/html/qemu-devel/2025-02/msg05714.html

[2] v8 patches also available here:
https://github.com/roy-hopkins/qemu/tree/igvm_master_v8

[3] `buildigvm` tool v0.2.0
https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0

Roy Hopkins (16):
  meson: Add optional dependency on IGVM library
  backends/confidential-guest-support: Add functions to support IGVM
  backends/igvm: Add IGVM loader and configuration
  hw/i386: Add igvm-cfg object and processing for IGVM files
  i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with
    IGVM
  sev: Update launch_update_data functions to use Error handling
  target/i386: Allow setting of R_LDTR and R_TR with
    cpu_x86_load_seg_cache()
  i386/sev: Refactor setting of reset vector and initial CPU state
  i386/sev: Implement ConfidentialGuestSupport functions for SEV
  docs/system: Add documentation on support for IGVM
  docs/interop/firmware.json: Add igvm to FirmwareDevice
  backends/confidential-guest-support: Add set_guest_policy() function
  backends/igvm: Process initialization sections in IGVM file
  backends/igvm: Handle policy for SEV guests
  i386/sev: Add implementation of CGS set_guest_policy()
  sev: Provide sev_features flags from IGVM VMSA to KVM_SEV_INIT2

 backends/confidential-guest-support.c       |  43 +
 backends/igvm-cfg.c                         |  51 +
 backends/igvm.c                             | 977 ++++++++++++++++++++
 backends/igvm.h                             |  22 +
 backends/meson.build                        |   5 +
 docs/interop/firmware.json                  |  30 +-
 docs/system/i386/amd-memory-encryption.rst  |   2 +
 docs/system/igvm.rst                        | 173 ++++
 docs/system/index.rst                       |   1 +
 hw/i386/pc.c                                |  12 +
 hw/i386/pc_piix.c                           |  10 +
 hw/i386/pc_q35.c                            |  10 +
 hw/i386/pc_sysfw.c                          |  31 +-
 include/hw/i386/x86.h                       |   3 +
 include/system/confidential-guest-support.h |  88 ++
 include/system/igvm-cfg.h                   |  49 +
 meson.build                                 |   8 +
 meson_options.txt                           |   2 +
 qapi/qom.json                               |  17 +
 qemu-options.hx                             |  28 +
 scripts/meson-buildoptions.sh               |   3 +
 target/i386/cpu.h                           |   9 +-
 target/i386/sev.c                           | 851 +++++++++++++++--
 target/i386/sev.h                           | 124 +++
 24 files changed, 2465 insertions(+), 84 deletions(-)
 create mode 100644 backends/igvm-cfg.c
 create mode 100644 backends/igvm.c
 create mode 100644 backends/igvm.h
 create mode 100644 docs/system/igvm.rst
 create mode 100644 include/system/igvm-cfg.h

-- 
2.43.0


