Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83B0D37E32
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0qE-0006WH-NS; Wed, 14 Jan 2026 08:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg0qC-0006Vy-QM
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:23:17 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg0qB-0006dw-30
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:23:16 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FCD95C733;
 Wed, 14 Jan 2026 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768396993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g42Bxfyrn0Ro3TvSlV7MlM9aeIACGCYQmB5BFRQRoT4=;
 b=KsZe/VCfPBMHGal4vRpGOZ5LWQoCWkKBTk09bvV7JUJX9JE4AdOxBHMLFlpdZc8wnSpdKA
 m19ZvZVcZ/b2N4TyC9bdtRy+wRIlSgb5Crh1F4LEiV9UrMObp6t3SHjM5bNDsqPQOMkcs9
 7ItPozzYsNWCHO6761ey5bUqgL7CGtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768396993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g42Bxfyrn0Ro3TvSlV7MlM9aeIACGCYQmB5BFRQRoT4=;
 b=9xO1k+ibXvO7zipG30o5LMXXOjURSHZUr5yAfnnz9bEWZ3PRiqyFJG98IbfyITRHsVJ0P8
 L+e7dFkZF7sZc9Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768396993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g42Bxfyrn0Ro3TvSlV7MlM9aeIACGCYQmB5BFRQRoT4=;
 b=KsZe/VCfPBMHGal4vRpGOZ5LWQoCWkKBTk09bvV7JUJX9JE4AdOxBHMLFlpdZc8wnSpdKA
 m19ZvZVcZ/b2N4TyC9bdtRy+wRIlSgb5Crh1F4LEiV9UrMObp6t3SHjM5bNDsqPQOMkcs9
 7ItPozzYsNWCHO6761ey5bUqgL7CGtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768396993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g42Bxfyrn0Ro3TvSlV7MlM9aeIACGCYQmB5BFRQRoT4=;
 b=9xO1k+ibXvO7zipG30o5LMXXOjURSHZUr5yAfnnz9bEWZ3PRiqyFJG98IbfyITRHsVJ0P8
 L+e7dFkZF7sZc9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B4013EA63;
 Wed, 14 Jan 2026 13:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dVJbN7+YZ2nxBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 13:23:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	armbru@redhat.com
Subject: [PATCH 0/5] qapi: Use visitors for migration parameters handling
Date: Wed, 14 Jan 2026 10:23:04 -0300
Message-ID: <20260114132309.5832-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2262453042

Fabiano Rosas (5):
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
  qapi: Implement qapi_dealloc_present_visitor
  qapi: Add QAPI_MERGE
  migration/options: Use QAPI_MERGE in migrate_params_test_apply

 include/qapi/dealloc-visitor.h |   6 +
 include/qapi/type-helpers.h    |  40 +++++
 migration/options.c            | 282 ++++-----------------------------
 qapi/qapi-dealloc-visitor.c    | 173 +++++++++++++++++++-
 4 files changed, 246 insertions(+), 255 deletions(-)

-- 
2.51.0


