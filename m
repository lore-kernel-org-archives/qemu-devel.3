Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A22FE7FDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2bZ-0007OW-3B; Mon, 02 Feb 2026 17:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bY-0007Ns-45
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:12 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vn2bW-0000gK-FH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:41:11 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 625563E6C5;
 Mon,  2 Feb 2026 22:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=23+Lhh4JKsZ1CevdHJLPw7EWvlRFYIluhoa5F1qV5oc=;
 b=YDHNrIcK4wsiov/edtsvXNDimYZRTpXy0eVFws06s6xS0nBoIcfAwzSsjx7wldjYJJ0W1v
 fEfPGbiLr85YkU6j2B3LwhAcFdZc5aqLIhoT0IEybk7FyXTA4G3Q+OHyAEHHJvu9TFNwRg
 EBggKw4XgBz6rh10FfE/jB9e27mY/sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=23+Lhh4JKsZ1CevdHJLPw7EWvlRFYIluhoa5F1qV5oc=;
 b=wQHqCU2U09iv7gC1a82RezTYpB0xi3Mava9CBTRLaTtOw5SPWkVvMdiMqfpPAypz3k/uCT
 jJccnXzB+w6U3jDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770072066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=23+Lhh4JKsZ1CevdHJLPw7EWvlRFYIluhoa5F1qV5oc=;
 b=YDHNrIcK4wsiov/edtsvXNDimYZRTpXy0eVFws06s6xS0nBoIcfAwzSsjx7wldjYJJ0W1v
 fEfPGbiLr85YkU6j2B3LwhAcFdZc5aqLIhoT0IEybk7FyXTA4G3Q+OHyAEHHJvu9TFNwRg
 EBggKw4XgBz6rh10FfE/jB9e27mY/sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770072066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=23+Lhh4JKsZ1CevdHJLPw7EWvlRFYIluhoa5F1qV5oc=;
 b=wQHqCU2U09iv7gC1a82RezTYpB0xi3Mava9CBTRLaTtOw5SPWkVvMdiMqfpPAypz3k/uCT
 jJccnXzB+w6U3jDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C582F3EA62;
 Mon,  2 Feb 2026 22:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ddLTIAAogWl8XgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 22:41:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	armbru@redhat.com,
	ppandit@redhat.com
Subject: [PATCH v2 0/9] qapi: Use visitors for migration parameters handling
Date: Mon,  2 Feb 2026 19:40:52 -0300
Message-ID: <20260202224101.20568-1-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Hi, just a few more patches until options.c is fully using QAPI_CLONE
instead of open-coding options handling, we're almost there.

In this v2:

- [NEW] patch 1/9 - Cleanup of a previous mistake.

- Properly freeing ptr members in patch 2/9 as spotted by Peter.

- Moved has_block_bitmap_mapping=true from patch 2 to patch 3.

- [NEW] patch 7/9 - Prasad's suggestion to keep the entire process of
  applying parameters in one place.

- [NEW] patch 8/9 - Replaced calls to qapi_free_* with
  qapi_dealloc_visitor.

- [NEW] patch 9/9 - Used the new migrate_params_free() for the
  instance finalize as well.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2301775498

v1:
https://lore.kernel.org/r/20260114132309.5832-1-farosas@suse.de

I split this series from the original[0] because these changes are
more QAPI-related and self-contained.

The idea is to use QAPI_CLONE_MEMBERS and (the new) QAPI_MERGE to
reduce the amount of open-coded parameters handling in options.c, such
as checks to QAPI's has_* fields and manual inclusion of future
parameters.

- Patches 1 & 2 are unchanged

- Patch 3 adds a new variant of the dealloc visitor to free the to-be
  unreferenced memory when the input visitor eventually allocates new
  memory and overwrites the pointers.

- Patches 4 & 5 are mostly unchanged, but now use the new visitor.

0 - migration: Unify capabilities and parameters
https://lore.kernel.org/r/20251215220041.12657-1-farosas@suse.de

Fabiano Rosas (9):
  migration/options.c: Don't export migrate_tls_opts_free
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
  qapi: Implement qapi_dealloc_present_visitor
  qapi: Add QAPI_MERGE
  migration/options: Use QAPI_MERGE in migrate_params_test_apply
  migration/options: Open code migrate_params_apply
  migration/options: Stop freeing s->parameters members individually
  migration: Use migrate_params_free during finalize

 include/qapi/dealloc-visitor.h |   6 +
 include/qapi/type-helpers.h    |  40 +++++
 migration/migration.c          |   3 +-
 migration/options.c            | 304 ++++-----------------------------
 migration/options.h            |   2 +-
 qapi/qapi-dealloc-visitor.c    | 173 ++++++++++++++++++-
 6 files changed, 257 insertions(+), 271 deletions(-)

-- 
2.51.0


