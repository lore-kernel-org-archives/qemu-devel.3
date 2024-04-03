Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B45CCD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryY3-0002Vt-Lc; Wed, 03 Apr 2024 07:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryXz-0002As-BU
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:51 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryXd-0007R7-Sh
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:51 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2C435CB82;
 Wed,  3 Apr 2024 11:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1712142742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cVX+RztzCCxLOlQEqL+0mU3DLmOj6ka5S+6p6DO9tew=;
 b=H5QIQQEVQhXfQTSh29bNltV4dXPrcUaFtoYV/2nk3VdNmNMrCRkVMFSXTFsSJfDpYCvZt5
 93rNz41PpilO0eIW5db1t3Fn91msAOIQVX+I2uw8PhIEal6/ZntGogcnRF21TU5jFyW3ak
 VzKNfqn1UIY+qtHpqb6AZstpUUqneJw=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C722713357;
 Wed,  3 Apr 2024 11:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Y4bdLZU5DWayHQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Wed, 03 Apr 2024 11:12:21 +0000
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
Subject: [PATCH v2 00/10] Introduce support for IGVM files
Date: Wed,  3 Apr 2024 12:11:31 +0100
Message-ID: <cover.1712138654.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.20 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_TWELVE(0.00)[19]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Here is v2 of the set of patches to add support for IGVM files to QEMU. These
address all of the comments on v1 [1]. These patches are also available
to view on github: [2].

Changes in v2:

  * Fixed various spelling and documentation errors from Stefano.
  * Addressed readability and other suggested code changes from Daniel.
  * igvm.c: Fix issue in prepare_memory() which resulted in the wrong start index
     being used at the start of a page range if the next or last directive did
     not follow the previous one.
  * igvmc: Fix usage of IGVM compatibility mask.
  * igvm.c: Fix issue in page_attrs_equal() which treated zero and normal pages
    as equal. This could affect the SEV measurement.
  * Improve and clarify handling of IGVM to VMSA to KVM CPU state conversion.
    The specific registers that are synchronized are now documented and a check
    is performed during IGVM file parsing to determine if any registers outside
    the supported set are non-zero making it easier to determine the cause of
    any mismatch of launch measurement.
  * Significant rework of error handling in ConfidentialGuestSupport and the
    IGVM parser.
  * confidential-guest-support: Remove TDX and other non-currently-supported
    platforms.
  * Exit with error if any unknown IGVM directives are encountered.
  * Rework handling of firmware so if an IGVM file is provided in addition to
    a firmware file then an error is generated.
  * Update firmware.json to add an 'igvm' firmware device.

Thanks to Daniel, Stefano, Ani and everyone else that has taken time to review
this so far.

[1] Link to v1:
https://lore.kernel.org/qemu-devel/cover.1709044754.git.roy.hopkins@suse.com/

[2] v2 patches also available here:
https://github.com/roy-hopkins/qemu/tree/igvm_master_v2

Roy Hopkins (10):
  meson: Add optional dependency on IGVM library
  backends/confidential-guest-support: Add IGVM file parameter
  backends/confidential-guest-support: Add functions to support IGVM
  backends/igvm: Implement parsing and processing of IGVM files
  i386/pc: Process IGVM file during PC initialization if present
  i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with
    IGVM
  i386/sev: Refactor setting of reset vector and initial CPU state
  i386/sev: Implement ConfidentialGuestSupport functions for SEV
  docs/system: Add documentation on support for IGVM
  docs/interop/firmware.json: Add igvm to FirmwareDevice

 backends/confidential-guest-support.c      |  75 +++
 backends/igvm.c                            | 744 +++++++++++++++++++++
 backends/meson.build                       |   4 +
 docs/interop/firmware.json                 |   9 +-
 docs/system/i386/amd-memory-encryption.rst |   2 +
 docs/system/igvm.rst                       | 129 ++++
 docs/system/index.rst                      |   1 +
 hw/i386/pc_piix.c                          |   4 +
 hw/i386/pc_q35.c                           |   4 +
 hw/i386/pc_sysfw.c                         |  22 +-
 include/exec/confidential-guest-support.h  | 105 +++
 include/exec/igvm.h                        |  36 +
 meson.build                                |   8 +
 meson_options.txt                          |   2 +
 qapi/qom.json                              |  13 +
 qemu-options.hx                            |   8 +-
 scripts/meson-buildoptions.sh              |   3 +
 target/i386/sev.c                          | 425 +++++++++++-
 target/i386/sev.h                          | 110 +++
 19 files changed, 1671 insertions(+), 33 deletions(-)
 create mode 100644 backends/igvm.c
 create mode 100644 docs/system/igvm.rst
 create mode 100644 include/exec/igvm.h

--
2.43.0


