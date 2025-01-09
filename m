Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE10E7719C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtGj-0005dB-Gj; Thu, 09 Jan 2025 09:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVtGf-0005c6-7m
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:12:13 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVtGc-0000Ur-5z
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:12:12 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A065C2116D;
 Thu,  9 Jan 2025 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8IGjtnnXGvE+nZIcqQL445TPVshW+M1g0wDcJCATfHc=;
 b=tKj18m5JvXnnQV69P2UHHaZdL/hWjnyef2QjebHBSc/kwjaOQjScNQP4DoblwYcvnKJutS
 Jzra9xs7jr7xueOfMzGS+WXO5o7nyCYQavPbDskRdOM61KWoy8KjTC/KtnIaItiIPXj7vW
 FrHjYf3041JC6jKxhwSuTRBov8qDkeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8IGjtnnXGvE+nZIcqQL445TPVshW+M1g0wDcJCATfHc=;
 b=tCgIafniDGZXyju9YQ+riCprt1B9SWZ7Nax36aViegwo1UoxofuvVhAyneHDavLtqZDVoy
 OyrvzEqNB0UxUiCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8IGjtnnXGvE+nZIcqQL445TPVshW+M1g0wDcJCATfHc=;
 b=RSe8E/r+yCWxlqwrpnzs0OBpgsPfqrdK8rXa6+S/6u2C7aRhE+0YpsON5sUaFfEi0vlk4O
 ISBDLHTXOlODBqPsbOR5Nkz5NOHPmxbYMSMV43p/wkc6Dpf0vC4cXD8BbC1GFS+VqoVfgg
 u6b+ud4o0+FVzQU4Q/T2L+MhrTcZ9SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8IGjtnnXGvE+nZIcqQL445TPVshW+M1g0wDcJCATfHc=;
 b=+ynX/4QMT0vBwtd611iPohW3Qpp6ofma+hWhGlO6VbDBviYx4h4KoZlszMscr7k3ZwIff6
 kmCBJBdG/0n07jBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CEBA13876;
 Thu,  9 Jan 2025 14:12:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hxyFDDbZf2fOWgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 14:12:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 0/7] migration: Fix s390 regressions + migration script
Date: Thu,  9 Jan 2025 11:09:52 -0300
Message-Id: <20250109140959.19464-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,gitlab.com:url];
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

changes from v1:

- dropped comments patch
- new patch 4: rename the field to nullptr
- patch 6: add a sample JSON, fix the appending code

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1616920974

v1:
https://lore.kernel.org/r/20250107195025.9951-1-farosas@suse.de

Hi,

The situation that broke the last migration PR was:

1) emitting of JSON data by QEMU for
   VMSTATE_ARRAY_OF_POINTER_TO_STRUCT when NULL pointers are present
   has been broken for a while;

2) parsing of s390x migration stream by analyze-script.py has been
   broken for a while;

   (there's indications that it worked on s390x hosts, I'm assuming due
   to byte order coincidences)

3) s390x CSS migration has been broken for a while;

The s390x CSS migration uses VMSTATE_ARRAY_OF_POINTER_TO_STRUCT with
NULL pointers, triggering #1, but hidden due to #2 on TCG hosts and
due to #3 overall.

- patches 1: just to make rebase easier
- patches 2-3: cleanups
- patch 4: fixes #2
- patches 5-6: fix #1
- patch 7: fixes #3

Fabiano Rosas (6):
  migration: Add more error handling to analyze-migration.py
  migration: Remove unused argument in vmsd_desc_field_end
  migration: Fix parsing of s390 stream
  migration: Rename vmstate_info_nullptr
  migration: Fix arrays of pointers in JSON writer
  s390x: Fix CSS migration

Peter Xu (1):
  migration: Dump correct JSON format for nullptr replacement

 hw/s390x/s390-virtio-ccw.c   |   2 +-
 migration/vmstate-types.c    |   2 +-
 migration/vmstate.c          | 151 ++++++++++++++++++++++++++++-------
 scripts/analyze-migration.py | 144 ++++++++++++++++++++++++---------
 4 files changed, 230 insertions(+), 69 deletions(-)

-- 
2.35.3


