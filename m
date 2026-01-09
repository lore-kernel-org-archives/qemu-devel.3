Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFF3D1A610
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBiD-0000Os-O5; Fri, 09 Jan 2026 07:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBiC-0000MQ-OG
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:35:28 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBiB-0006ds-0B
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:35:28 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D448C5C00A;
 Fri,  9 Jan 2026 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6w7vlQitSVHjOB7bZfmHLEoehHser6gqQZ7RMszpve0=;
 b=A2PcSrV97xqv1qyyj/R6HvUY+X+UvyX6iy62FZ14USqTTzdtauz0v6x90EVs7AP9ADclyu
 cU1iCG4rRNE4c87/SjCqnJEjyQKcIPMevkeZDFRslv6l95gAe8FuoCAWz3jidKSpEmtlHh
 ZQEBoYLVm0zm0zK+wiT3dMazvtAelzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6w7vlQitSVHjOB7bZfmHLEoehHser6gqQZ7RMszpve0=;
 b=k4XESQJXbRUAj46JS4RlBfXlekZUoyZ5pyZkDFHIqap57tjl5hIzzox8AszL1X34wove0v
 A0kYiEPoAUFQ4HDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6w7vlQitSVHjOB7bZfmHLEoehHser6gqQZ7RMszpve0=;
 b=A2PcSrV97xqv1qyyj/R6HvUY+X+UvyX6iy62FZ14USqTTzdtauz0v6x90EVs7AP9ADclyu
 cU1iCG4rRNE4c87/SjCqnJEjyQKcIPMevkeZDFRslv6l95gAe8FuoCAWz3jidKSpEmtlHh
 ZQEBoYLVm0zm0zK+wiT3dMazvtAelzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6w7vlQitSVHjOB7bZfmHLEoehHser6gqQZ7RMszpve0=;
 b=k4XESQJXbRUAj46JS4RlBfXlekZUoyZ5pyZkDFHIqap57tjl5hIzzox8AszL1X34wove0v
 A0kYiEPoAUFQ4HDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A1C03EA63;
 Fri,  9 Jan 2026 12:35:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TV/hEgr2YGlqPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:35:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	peterx@redhat.com
Subject: [PATCH v3 0/2] ppc: Fix migration issue with quiesced state
Date: Fri,  9 Jan 2026 09:35:17 -0300
Message-ID: <20260109123519.28703-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Changes in v3:
- removed extra include
- changed the test to set the machine earlier

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2252213960

v2:
https://lore.kernel.org/r/20251217164549.4311-1-farosas@suse.de

A while back, Fabian reported two issues with migration on ppc64le,
one of which was already fixed. There remains this one from the
previous series:

pseries migration causes a guest hang after migration due to a new
variable used to track the stopped state of vcpus, which is not
migrated. Fix is to migrate the new variable. To avoid breaking
backward migration, a compat property is added. For forward migration,
a heuritics based on the known QEMU code is used.

Thanks

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2220496446

v1:
https://lore.kernel.org/r/20250819223905.2247-1-farosas@suse.de

Fabiano Rosas (2):
  target/ppc: Fix env->quiesced migration
  tests/functional: Add a OS level migration test for pseries

 hw/ppc/spapr.c                           |  6 +++
 target/ppc/cpu.h                         |  1 +
 target/ppc/cpu_init.c                    |  7 +++
 target/ppc/machine.c                     | 62 ++++++++++++++++++++++++
 tests/functional/ppc64/test_migration.py | 12 +++++
 tests/functional/ppc64/test_pseries.py   | 35 +++++++++++++
 6 files changed, 123 insertions(+)

-- 
2.51.0


