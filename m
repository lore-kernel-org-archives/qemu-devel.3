Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78594CCFA19
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stmtB-0000pj-6s; Thu, 26 Sep 2024 07:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmt6-0000oa-RB
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:24 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1stmt3-0005kq-N4
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:42:23 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7B6B1F815;
 Thu, 26 Sep 2024 11:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wt3kcYv9qQh8cGTMxRmqa/717oRBIkG70NUbGCMjqnU=;
 b=QKcDgerjOgIYtDGpKw/zMA3wKs6h2+Sc2whGX8guvyuyfRz5ULxTUjTkqcbDPhGzko2rKF
 I8ukTx3cSUtwN6L0qObkvj4a8oEJgKyVWMppUjDeooNqZG+VzAUCqlJBngbAYjUghd8EHx
 u7KWMoVjFb7+SDm57yZj+nE5HageU9I=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=gEJgeUcP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1727350938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wt3kcYv9qQh8cGTMxRmqa/717oRBIkG70NUbGCMjqnU=;
 b=gEJgeUcPBFIvztq4vn9qiJivTGof9uTcSa/RYYRSUiBmD6FpIjOkD2HGBuIk+fWk+H+ZIf
 2ufkoGmS04JLixmOdqFerV+ofPkIhnzQm0MBLGRCJQvKCA10PVyPJde6t1wKROfoKn6Lta
 SCe4mSvzqRAVesXmi9QgN2/vq0avTf8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06FFB13793;
 Thu, 26 Sep 2024 11:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GdtKO5lI9WbcRAAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Thu, 26 Sep 2024 11:42:17 +0000
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
Subject: [PATCH v6 00/16] Introduce support for IGVM files
Date: Thu, 26 Sep 2024 12:41:49 +0100
Message-ID: <cover.1727341768.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7B6B1F815
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.com:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.com:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Here is v6 of the set of patches to add support for IGVM files to QEMU. This is
based on commit a5dd9ee060 of qemu.

This version addresses all of the review comments from v5 [1]. As always, thanks
to those that have been following along, reviewing and testing this series. This
v6 patch series is also available on github: [2]

For testing IGVM support in QEMU you need to generate an IGVM file that is
configured for the platform you want to launch. You can use the `buildigvm`
test tool [3] to allow generation of IGVM files for all currently supported
platforms. Patch 11/17 contains information on how to generate an IGVM file
using this tool.

Changes in v6:

Based on Stefano's review:
* Change ConfidentialGuestSupport check_support() function to return a bool and
  add documentation.
* Ensure igvm_free() is called after successful or failed processing of igvm
  file.
* Add command-line documentation for which machine types support IGVM.
* Update target version from 9.1 to 9.2.

* Add Acked-by and Reviewed-by to relevant commits.

Patch summary:

1-11: Add support and documentation for processing IGVM files for SEV, SEV-ES,
SEV-SNP and native platforms. 

12-15: Processing of policy and SEV-SNP ID_BLOCK from IGVM file. 

16: Add pre-processing of IGVM file to support synchronization of 'SEV_FEATURES'
from IGVM VMSA to KVM.

[1] Link to v5:
https://lore.kernel.org/all/cover.1723560001.git.roy.hopkins@suse.com/

[2] v6 patches also available here:
https://github.com/roy-hopkins/qemu/tree/igvm_master_v6

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

 backends/confidential-guest-support.c      |  43 +
 backends/igvm-cfg.c                        |  52 ++
 backends/igvm.c                            | 967 +++++++++++++++++++++
 backends/igvm.h                            |  23 +
 backends/meson.build                       |   5 +
 docs/interop/firmware.json                 |  30 +-
 docs/system/i386/amd-memory-encryption.rst |   2 +
 docs/system/igvm.rst                       | 173 ++++
 docs/system/index.rst                      |   1 +
 hw/i386/pc.c                               |  12 +
 hw/i386/pc_piix.c                          |  10 +
 hw/i386/pc_q35.c                           |  10 +
 hw/i386/pc_sysfw.c                         |  31 +-
 include/exec/confidential-guest-support.h  |  88 ++
 include/hw/i386/x86.h                      |   3 +
 include/sysemu/igvm-cfg.h                  |  47 +
 meson.build                                |   8 +
 meson_options.txt                          |   2 +
 qapi/qom.json                              |  17 +
 qemu-options.hx                            |  28 +
 scripts/meson-buildoptions.sh              |   3 +
 target/i386/cpu.h                          |   9 +-
 target/i386/sev.c                          | 850 ++++++++++++++++--
 target/i386/sev.h                          | 124 +++
 24 files changed, 2454 insertions(+), 84 deletions(-)
 create mode 100644 backends/igvm-cfg.c
 create mode 100644 backends/igvm.c
 create mode 100644 backends/igvm.h
 create mode 100644 docs/system/igvm.rst
 create mode 100644 include/sysemu/igvm-cfg.h

-- 
2.43.0


