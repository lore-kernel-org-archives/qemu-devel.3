Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC804C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfH0-0001AY-8s; Fri, 21 Jun 2024 10:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfGz-0001AI-9d
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:29:53 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfGx-0005fe-07
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:29:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CCC4521B39;
 Fri, 21 Jun 2024 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4D1V4yQP6b0TDTMLCIza+aKR4iSlmKYTAQMfMFlvAjs=;
 b=rllOsFht+78aOzHMOyhlowMAfQ17YSpoeLwQ5KeaIGCGZSxdEf87aLTHp3HRmw/dOEc5F/
 v755I/a0k/kEUw4ZM5igGkApo7syU1vCGNzr7LsRjkSaBZmpSzIaQtDRl6170ZiNUmzIOq
 4XTYk/PNosJjc3Zopd/fbmHKXz9rDvg=
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=e5OLdBws
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4D1V4yQP6b0TDTMLCIza+aKR4iSlmKYTAQMfMFlvAjs=;
 b=e5OLdBwsbh7Z8B7foFSJKvxHa5L4RxQ/Z/ojom7YR4PMhCLASB+p1cHR7P1vhfGWZ212Vj
 4O2s2Za2aGthu+Re17AC8FmsUXHKOc0hvgJ/83qCA4VXp4W1Abi0B+g4ATvS26aNsLdbGy
 v9OrtvrISwhT9Xn6vIVL6w0eg/r9qpg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1806313ABD;
 Fri, 21 Jun 2024 14:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GyrBA1qOdWbwKQAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Fri, 21 Jun 2024 14:29:46 +0000
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
Subject: [PATCH v3 00/15] Introduce support for IGVM files
Date: Fri, 21 Jun 2024 15:29:03 +0100
Message-ID: <cover.1718979106.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.com:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 ARC_NA(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.com:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CCC4521B39
Received-SPF: pass client-ip=195.135.223.130;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
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

Based-on: 02d9c38236

Here is v3 of the set of patches to add support for IGVM files to QEMU.

Firstly, apologies for the long gap between v2 and v3. This was due to a number
of factors, but particularly holding back until SEV-SNP support landed in QEMU
as well as for some changes to be merged in the upstream IGVM specification and
library. The delay meant that I could include the SEV-SNP IGVM changes that I
had been separately maintaining for COCONUT-SVSM into this series, giving full
support for the full range of SEV technologies.

Thank-you to everyone who reviewed the previous set of patches [1]. I
have hopefully addressed all of the comments in those reviews. Some of these
changes required a reasonable amount of rework. Along with the inclusion of
support for SEV-SNP, this has resulted in a fairly large set of differences from
v2. This v3 patch series is also available on github: [2]

For testing IGVM support in QEMU you need to generate an IGVM file that is
configured for the platform you want to launch. I have updated the `buildigvm`
test tool [3] to allow generation of IGVM files for all currently supported
platforms. 

In my own testing I have launched guests using IGVM files for each supported
platform. In addition, I have verified that the launch measurement for SEV,
SEV-ES and SEV-SNP when using QEMU with IGVM matches the pre-calculated 
measurement using the COCONUT-SVSM `igvmmeasure` tool [4]. This same tool
was used to sign the SEV-SNP IGVM file to verify the correct operation of
the new support for ID_BLOCKs in v3.

This patch series requires version v0.3.2 of the IGVM library to be installed
[5].

Changes in v3:

* Added support for SEV-SNP on top of SEV and SEV-ES.
* Introduced a new `IgvmCfg` user accessible object to configure and process the
  IGVM file, moving this from `ConfidentialGuestSupport` where it resided in v2.
  `ConfidentialGuestSupport` is still used to abstract the implementation of
  guest configuration.
* The IGVM processing code will use the `ConfidentialGuestSupport` functions if
  provided, but will allow processing of a supported subset of directives if a
  CGS instance is not provided, allowing non-confidential guest to be configured
  with an IGVM file.
* Added support for setting platform policy via the IGVM file.
* Added ID_BLOCK support as part of SEV-SNP for using the platform to verify the
  measurement and signature of the IGVM file.
* Update documentation to describe configuring IGVM using the `igvm-cfg` object
  and referring to it from `-machine`.
* Pre-processing of the IGVM file during KVM initialization to determine the
  `sev_features` to pass to the new KVM_SEV_INIT2 ioctl.
* Tidying/rework of code as per previous review comments. In particular, the
  IGVM library dependency has been updated to remove potential namespace
  clashes.

Patch summary:

The patches have been organized so the first patches in the series mostly match
those in v2 but with additional support for SEV-SNP and native platforms.
This hopefully simplifies the review process for those that have already looked
at the previous series.

1-10: Add support and documentation for processing IGVM files for SEV, SEV-ES,
SEV-SNP and native platforms. 

11-14: Processing of policy and SEV-SNP ID_BLOCK from IGVM file. 

15: Add pre-processing of IGVM file to support synchronization of 'SEV_FEATURES'
from IGVM VMSA to KVM.

[1] Link to v2:
https://lore.kernel.org/qemu-devel/cover.1712138654.git.roy.hopkins@suse.com/

[2] v3 patches also available here:
https://github.com/roy-hopkins/qemu/tree/igvm_master_v3

[3] `buildigvm` tool v0.2.0
https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0

[4] `igvmmeasure` tool 
https://github.com/coconut-svsm/svsm/tree/main/igvmmeasure

[5] IGVM library v0.3.2
https://github.com/microsoft/igvm/releases/tag/igvm-v0.3.2

Roy Hopkins (15):
  meson: Add optional dependency on IGVM library
  backends/confidential-guest-support: Add functions to support IGVM
  backends/igvm: Add IGVM loader and configuration
  hw/core/machine: Add igvm-cfg object and processing for IGVM files
  i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with
    IGVM
  sev: Update launch_update_data functions to use Error handling
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
 docs/system/igvm.rst                       | 157 ++++
 docs/system/index.rst                      |   1 +
 meson.build                                |   8 +
 qapi/qom.json                              |  16 +
 backends/igvm.h                            |  37 +
 include/exec/confidential-guest-support.h  |  96 +++
 include/hw/boards.h                        |   2 +
 include/sysemu/igvm-cfg.h                  |  54 ++
 target/i386/sev.h                          | 124 +++
 backends/confidential-guest-support.c      |  43 +
 backends/igvm-cfg.c                        |  66 ++
 backends/igvm.c                            | 948 +++++++++++++++++++++
 hw/core/machine.c                          |  20 +
 hw/i386/pc_sysfw.c                         |  23 +-
 target/i386/sev.c                          | 830 ++++++++++++++++--
 backends/meson.build                       |   5 +
 meson_options.txt                          |   2 +
 qemu-options.hx                            |  25 +
 scripts/meson-buildoptions.sh              |   3 +
 21 files changed, 2393 insertions(+), 78 deletions(-)
 create mode 100644 docs/system/igvm.rst
 create mode 100644 backends/igvm.h
 create mode 100644 include/sysemu/igvm-cfg.h
 create mode 100644 backends/igvm-cfg.c
 create mode 100644 backends/igvm.c

-- 
2.43.0


