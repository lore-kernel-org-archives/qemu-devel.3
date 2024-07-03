Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4537AC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxos-0004pb-1G; Wed, 03 Jul 2024 07:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxon-0004nh-Lx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOxoc-0006Uq-Un
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:06:27 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A51151FCD7;
 Wed,  3 Jul 2024 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iJI8eZlacjF+JIrWoMYB2IYBGCqYSJYrsfwtQskDw3Y=;
 b=WuHyKivdwbLxoZTFDnlClXPj5+KlLNIhUN/NbvICJbfLGLKeIB1qlcoUEcyN4E0q3nd6GD
 sAOYL7CfrGTY3VrDYdOOna1ecPp5AU96DIuFA8iSgtd/naUx/xGmwhwa3GlryGd28LAxWI
 r5+yPnp/d9JzA8ar9B3be1KhG/G4Vsg=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=WuHyKivd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1720004777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iJI8eZlacjF+JIrWoMYB2IYBGCqYSJYrsfwtQskDw3Y=;
 b=WuHyKivdwbLxoZTFDnlClXPj5+KlLNIhUN/NbvICJbfLGLKeIB1qlcoUEcyN4E0q3nd6GD
 sAOYL7CfrGTY3VrDYdOOna1ecPp5AU96DIuFA8iSgtd/naUx/xGmwhwa3GlryGd28LAxWI
 r5+yPnp/d9JzA8ar9B3be1KhG/G4Vsg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0A2913974;
 Wed,  3 Jul 2024 11:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6qBiNKgwhWZ6cgAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Wed, 03 Jul 2024 11:06:16 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v4 00/17] Introduce support for IGVM files
Date: Wed,  3 Jul 2024 12:05:38 +0100
Message-ID: <cover.1720004383.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A51151FCD7
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
 TAGGED_RCPT(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.com:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Here is v4 of the set of patches to add support for IGVM files to QEMU. This is
based on commit 1a2d52c7fc of qemu.

This version addresses all of the review comments from v3 along with a couple of
small bug fixes. This is a much smaller increment than in the previous version
of the series [1]. Thanks once again to the reviewers that have been looking at
this series. This v4 patch series is also available on github: [2]

The previous version had a build issue when building without debug enabled.
Patch 8/17 has been added to fix this and I've updated my own process to test
both debug and release builds of QEMU.

For testing IGVM support in QEMU you need to generate an IGVM file that is
configured for the platform you want to launch. You can use the `buildigvm`
test tool [3] to allow generation of IGVM files for all currently supported
platforms. Patch 11/17 contains information on how to generate an IGVM file
using this tool.

Changes in v4:

* Remove unused '#ifdef CONFIG_IGVM' sections
* Add "'if': 'CONFIG_IGVM'" for IgvmCfgProperties in qom.json
* Use error_fatal instead of error_abort in suggested locations
* Prevent addition of bios code when an IGVM file is provided and pci_enabled is false
* Add patch 6/17 to fix error handling from sev_encrypt_flash()
* Revert unrequired changes to return values in sev/*_launch_update() functions
* Add documentation to igvm.rst to describe how to use 'buildigvm'
* Various convention and code style changes as suggested in reviews
* Fix handling of sev_features for kernels that do not support KVM_SEV_INIT2
* Move igvm-cfg from MachineState to X86MachineState

Patch summary:

1-12: Add support and documentation for processing IGVM files for SEV, SEV-ES,
SEV-SNP and native platforms. 

13-16: Processing of policy and SEV-SNP ID_BLOCK from IGVM file. 

17: Add pre-processing of IGVM file to support synchronization of 'SEV_FEATURES'
from IGVM VMSA to KVM.

[1] Link to v3:
https://lore.kernel.org/qemu-devel/cover.1718979106.git.roy.hopkins@suse.com/

[2] v4 patches also available here:
https://github.com/roy-hopkins/qemu/tree/igvm_master_v4

[3] `buildigvm` tool v0.2.0
https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0

Roy Hopkins (17):
  meson: Add optional dependency on IGVM library
  backends/confidential-guest-support: Add functions to support IGVM
  backends/igvm: Add IGVM loader and configuration
  hw/i386: Add igvm-cfg object and processing for IGVM files
  i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with
    IGVM
  sev: Fix error handling in sev_encrypt_flash()
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

 docs/interop/firmware.json                 |   9 +-
 docs/system/i386/amd-memory-encryption.rst |   2 +
 docs/system/igvm.rst                       | 173 ++++
 docs/system/index.rst                      |   1 +
 meson.build                                |   8 +
 qapi/qom.json                              |  17 +
 backends/igvm.h                            |  23 +
 include/exec/confidential-guest-support.h  |  96 +++
 include/hw/i386/x86.h                      |   3 +
 include/sysemu/igvm-cfg.h                  |  54 ++
 target/i386/cpu.h                          |   9 +-
 target/i386/sev.h                          | 124 +++
 backends/confidential-guest-support.c      |  43 +
 backends/igvm-cfg.c                        |  66 ++
 backends/igvm.c                            | 958 +++++++++++++++++++++
 hw/i386/pc.c                               |  12 +
 hw/i386/pc_piix.c                          |  10 +
 hw/i386/pc_q35.c                           |  10 +
 hw/i386/pc_sysfw.c                         |  31 +-
 target/i386/sev.c                          | 844 ++++++++++++++++--
 backends/meson.build                       |   5 +
 meson_options.txt                          |   2 +
 qemu-options.hx                            |  25 +
 scripts/meson-buildoptions.sh              |   3 +
 24 files changed, 2447 insertions(+), 81 deletions(-)
 create mode 100644 docs/system/igvm.rst
 create mode 100644 backends/igvm.h
 create mode 100644 include/sysemu/igvm-cfg.h
 create mode 100644 backends/igvm-cfg.c
 create mode 100644 backends/igvm.c

-- 
2.43.0


