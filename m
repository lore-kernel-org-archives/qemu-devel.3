Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FBAC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reynO-0006Ka-N1; Tue, 27 Feb 2024 09:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynM-0006HJ-La
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:00 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1reynK-0004UL-9y
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:51:00 -0500
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0C831F460;
 Tue, 27 Feb 2024 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v82oTOj/P1Rmn3WLRdHU78q+ddfcnPDjbhT+i40BBnY=;
 b=kCcmJ2lRAY/ZEvHqhb+4f/1mPbfZZYpjAMT/vMnPGWEQKvnem655b/gBdbQKUP1N1waX6k
 nfCjB5KK54sicVGe5xr3tLG4+y/EXAE8E2HxEe61AKHLVlSYoJfTrRQa3czzwbut6UiWdi
 BbQcuJFGP0O72yXmKhRriKcCOk3DBgg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1709045455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v82oTOj/P1Rmn3WLRdHU78q+ddfcnPDjbhT+i40BBnY=;
 b=kCcmJ2lRAY/ZEvHqhb+4f/1mPbfZZYpjAMT/vMnPGWEQKvnem655b/gBdbQKUP1N1waX6k
 nfCjB5KK54sicVGe5xr3tLG4+y/EXAE8E2HxEe61AKHLVlSYoJfTrRQa3czzwbut6UiWdi
 BbQcuJFGP0O72yXmKhRriKcCOk3DBgg=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E71B513419;
 Tue, 27 Feb 2024 14:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 0ibnNc723WXMAQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Tue, 27 Feb 2024 14:50:54 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH 0/9] Introduce support for IGVM files
Date: Tue, 27 Feb 2024 14:50:06 +0000
Message-ID: <cover.1709044754.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=kCcmJ2lR
X-Spamd-Result: default: False [-0.31 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL1cdfboiju7js16zrknyuzw5d)];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.com:+];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_TWELVE(0.00)[16]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C0C831F460
X-Spamd-Bar: /
Received-SPF: pass client-ip=195.135.223.131;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi everyone,

This initial patch series submission adds the capability to configure
confidential guests using files that conform to the Independent Guest Virtual
Machine (IGVM) file format. The series is based on the master branch commit
1b330da. Alternatively, the series is available here:
https://github.com/roy-hopkins/qemu/tree/igvm_master_v1

I look forward to welcoming your comments!

Why do we need Independent Guest Virtual Machine (IGVM) files?
==============================================================

IGVM files describe, using a set of directives, the memory layout and initial
configuration of a guest that supports isolation technologies such as AMD
SEV-SNP and Intel TDX. By encapsulating all of this information in a single
configuration file and applying the directives in the order they are specified
when the guest is initialized, it becomes straightforward to pre-calculate the
cryptographic measurement of the guest initial state, thus aiding in remote
attestation processes.

IGVM files can also be used to configure non-standard guest memory layouts,
payloads or startup configurations. A good example of this is to use IGVM to
deploy and configure an SVSM module in the guest which supports running at
multiple VMPLs. The SVSM can be configured to start directly into 32-bit or
64-bit code. This patch series was developed with this purpose in mind to
support the COCONUT-SVSM project:
https://github.com/coconut-svsm/svsm

More information and background on the IGVM file format can be found on the
project page at:
https://github.com/microsoft/igvm

What this patch series introduces
=================================

This series adds a build-time configuration option (--enable-igvm) to add
support for launching a guest using an IGVM file. It extends the current
ConfidentialGuestSupport object to allow an IGVM filename to be specified.

The directives in the IGVM file are parsed and the confidential guest is
configured through new virtual methods added to the ConfidentialGuestSupport
object. These virtual functions have been implemented for AMD SEV and AMD
SEV-ES.

Many of the IGVM directives require capabilities that are not supported in SEV
and SEV-ES, so support for IGVM directives will need to be considered when
support for SEV-SNP, TDX or other technologies is introduced to QEMU. Any
directive that is not currently supported results in an error report.

Dependencies
============

In order to enable IGVM support, you will need the IGVM library installed.
Instructions on building and installing it can be found here:
https://github.com/microsoft/igvm/tree/main/igvm_c

As mentioned above, this series was developed as part of the effort for
COCONUT-SVSM. COCONUT-SVSM requires support for AMD SEV-SNP which is not
available in current QEMU. Therefore this series has also been applied on top of
the AMD SEV-SNP branch (https://github.com/AMDESE/qemu/tree/snp-v3-wip). You can
find that version of the series here:
https://github.com/roy-hopkins/qemu/commits/snp-v3-wip-igvm_v2/

Generating IGVM files
=====================

To try this out you will need to generate an IGVM file that is compatible with
the SEV platform you are testing on. I've created a tool that can create a
simple IGVM file that packages an OVMF binary for AMD SEV or AMD SEV-ES. The
tool is available here:
https://github.com/roy-hopkins/buildigvm

I have tested this on an AMD EPYC Genoa system configured to support SEV. Both
SEV and SEV-ES have been tested using IGVM files generated using the buildigvm
tool. The SEV-SNP alternative patch set has also been tested using COCONUT-SVSM.

Roy Hopkins (9):
  meson: Add optional dependency on IGVM library
  backends/confidential-guest-support: Add IGVM file parameter
  backends/confidential-guest-support: Add functions to support IGVM
  backends/igvm: Implement parsing and processing of IGVM files
  i386/pc: Process IGVM file during PC initialization if present
  i386/pc: Skip initialization of system FW when using IGVM
  i386/sev: Refactor setting of reset vector and initial CPU state
  i386/sev: Implement ConfidentialGuestSupport functions for SEV
  docs/system: Add documentation on support for IGVM

 backends/confidential-guest-support.c     |  69 +++
 backends/igvm.c                           | 718 ++++++++++++++++++++++
 backends/meson.build                      |   4 +
 docs/system/igvm.rst                      |  58 ++
 docs/system/index.rst                     |   1 +
 hw/i386/pc.c                              |  12 +-
 hw/i386/pc_piix.c                         |   4 +
 hw/i386/pc_q35.c                          |   4 +
 include/exec/confidential-guest-support.h | 107 ++++
 include/exec/igvm.h                       |  35 ++
 meson.build                               |   8 +
 meson_options.txt                         |   2 +
 qapi/qom.json                             |  13 +
 qemu-options.hx                           |   8 +-
 scripts/meson-buildoptions.sh             |   3 +
 target/i386/sev.c                         | 365 ++++++++++-
 target/i386/sev.h                         | 110 ++++
 17 files changed, 1489 insertions(+), 32 deletions(-)
 create mode 100644 backends/igvm.c
 create mode 100644 docs/system/igvm.rst
 create mode 100644 include/exec/igvm.h

--
2.43.0


