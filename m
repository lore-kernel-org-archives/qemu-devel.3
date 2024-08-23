Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9AFC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYFr-0007Ez-OP; Fri, 23 Aug 2024 13:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYFq-0007D2-Iw
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:18 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYFo-0008Q4-FR
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:18 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C12F42035D;
 Fri, 23 Aug 2024 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TBaisGr2TFBtYkrQsLqFweBh+RLbVxjcK8P1EQguu9o=;
 b=uJTR3RRcqnoPvPl1/RpnzAlABSsOFZNpn5XJS9G51UeQT3/lWeriYc636NQwNWmLXwe3hZ
 MsO4IufCTBlsl+GLIXSEhUHgVVDot109yzhBHog9qPfWQet3ZqCCMeQEtBoxLIREGsk9pf
 m4va2H0CO8vBlY0SodThfUGyqCoFwE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TBaisGr2TFBtYkrQsLqFweBh+RLbVxjcK8P1EQguu9o=;
 b=Q8h1gQujPvZYWlDwF6kBhC0v5aqO2Un4GM+YuAPTxRcU1GYQHpP8q34cOfmR+ooCz4/xjP
 SObw4zslN7Vy9wDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TBaisGr2TFBtYkrQsLqFweBh+RLbVxjcK8P1EQguu9o=;
 b=uJTR3RRcqnoPvPl1/RpnzAlABSsOFZNpn5XJS9G51UeQT3/lWeriYc636NQwNWmLXwe3hZ
 MsO4IufCTBlsl+GLIXSEhUHgVVDot109yzhBHog9qPfWQet3ZqCCMeQEtBoxLIREGsk9pf
 m4va2H0CO8vBlY0SodThfUGyqCoFwE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TBaisGr2TFBtYkrQsLqFweBh+RLbVxjcK8P1EQguu9o=;
 b=Q8h1gQujPvZYWlDwF6kBhC0v5aqO2Un4GM+YuAPTxRcU1GYQHpP8q34cOfmR+ooCz4/xjP
 SObw4zslN7Vy9wDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9863B1333E;
 Fri, 23 Aug 2024 17:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SPCbF0HJyGb2LwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 17:39:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 00/16] migration/multifd: Remove multifd_send_state->pages
Date: Fri, 23 Aug 2024 14:38:55 -0300
Message-Id: <20240823173911.6712-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

Not much changed sinced v3, the most notable is that I kept the nocomp
names and created multifd-nocomp.c. I think "plain" is even more
misterious, so let's keep what we are already used to.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1425141484

v3:
https://lore.kernel.org/r/20240801123516.4498-1-farosas@suse.de

This v3 incorporates the suggestions done by Peter in v2. Aside from
those, of note:

- fixed the allocation of MultiFDSendData. The previous version didn't
  account for compiler-inserted holes;

- kept the packet split patch;

- added some patches to remove p->page_count, p->page_size,
  pages->allocated. These are all constants and don't need to be
  per-channel;

- moved the code into multifd-ram.c.

  However, I left the p->packet allocation (depends on page_count) and
  p->normal + p->zero behind because I need to see how the device
  state patches will deal with the packet stuff before I can come up
  with a way to move those out of the MultiFD*Params. It might not be
  worth it adding another struct just for the ram code to store
  p->normal, p->zero.

With this I'm pretty much done with what I think needs to be changed
as a prereq for the device state work. I don't have anything else in
mind to add to this series.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1395572680

v2:
https://lore.kernel.org/r/20240722175914.24022-1-farosas@suse.de

v1:
https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de

First of all, apologies for the roughness of the series. I'm off for
the next couple of weeks and wanted to put something together early
for your consideration.

This series is a refactoring (based on an earlier, off-list
attempt[0]), aimed to remove the usage of the MultiFDPages_t type in
the multifd core. If we're going to add support for more data types to
multifd, we first need to clean that up.

This time around this work was prompted by Maciej's series[1]. I see
you're having to add a bunch of is_device_state checks to work around
the rigidity of the code.

Aside from the VFIO work, there is also the intent (coming back from
Juan's ideas) to make multifd the default code path for migration,
which will have to include the vmstate migration and anything else we
put on the stream via QEMUFile.

I have long since been bothered by having 'pages' sprinkled all over
the code, so I might be coming at this with a bit of a narrow focus,
but I believe in order to support more types of payloads in multifd,
we need to first allow the scheduling at multifd_send_pages() to be
independent of MultiFDPages_t. So here it is. Let me know what you
think.

(as I said, I'll be off for a couple of weeks, so feel free to
incorporate any of this code if it's useful. Or to ignore it
completely).

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1340992028

0- https://github.com/farosas/qemu/commits/multifd-packet-cleanups/
1- https://lore.kernel.org/r/cover.1718717584.git.maciej.szmigiero@oracle.com

Fabiano Rosas (16):
  migration/multifd: Reduce access to p->pages
  migration/multifd: Inline page_size and page_count
  migration/multifd: Remove pages->allocated
  migration/multifd: Pass in MultiFDPages_t to file_write_ramblock_iov
  migration/multifd: Introduce MultiFDSendData
  migration/multifd: Make MultiFDPages_t:offset a flexible array member
  migration/multifd: Replace p->pages with an union pointer
  migration/multifd: Move pages accounting into
    multifd_send_zero_page_detect()
  migration/multifd: Remove total pages tracing
  migration/multifd: Isolate ram pages packet data
  migration/multifd: Don't send ram data during SYNC
  migration/multifd: Replace multifd_send_state->pages with client data
  migration/multifd: Allow multifd sync without flush
  migration/multifd: Standardize on multifd ops names
  migration/multifd: Register nocomp ops dynamically
  migration/multifd: Move nocomp code into multifd-nocomp.c

 migration/file.c              |   3 +-
 migration/file.h              |   2 +-
 migration/meson.build         |   1 +
 migration/multifd-nocomp.c    | 394 +++++++++++++++++++++++++
 migration/multifd-qpl.c       |  77 +----
 migration/multifd-uadk.c      | 100 ++-----
 migration/multifd-zero-page.c |  13 +-
 migration/multifd-zlib.c      |  97 ++-----
 migration/multifd-zstd.c      |  96 ++----
 migration/multifd.c           | 531 ++++++----------------------------
 migration/multifd.h           |  74 +++--
 migration/ram.c               |  10 +-
 migration/trace-events        |   9 +-
 13 files changed, 628 insertions(+), 779 deletions(-)
 create mode 100644 migration/multifd-nocomp.c

-- 
2.35.3


