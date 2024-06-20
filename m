Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3334FC2BBCA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 21:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKPDg-0000rP-UG; Thu, 20 Jun 2024 17:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKPDb-0000qp-My
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 17:21:20 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKPDZ-0007FI-VF
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 17:21:19 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE1D51F8B4;
 Thu, 20 Jun 2024 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718918476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aVaFH4XdMgxk7t/Mo3rThFB3GkHGVkhOTNlHefWZn+w=;
 b=ZqOUai+lX17f9h2zIMyeaJuo3Crgg71LCaHeTcZ3Qyq1K76mUbjZyPmOv3DwEE9++WHiGq
 FrTiyUWDzSOnjnDHvcpGtSFedb1weNgSbiWwkpih77NDkjteYBuS5lF9Hycwl/3v3LgFLk
 gWY6JCP6Jju5Pq0j1Pley0FnlkwCJFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718918476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aVaFH4XdMgxk7t/Mo3rThFB3GkHGVkhOTNlHefWZn+w=;
 b=M6ofqWiyE1EKyIXcJ4aFyv8o9QZS1zXdFGzy7ELQf+xqlmO9i0IpV6/sb620gTTjsB59D2
 oUTJKr4OgmuH+tBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718918474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aVaFH4XdMgxk7t/Mo3rThFB3GkHGVkhOTNlHefWZn+w=;
 b=v0y6JuHlite1lx+J5R6WUzo7DdAHhRYb5iawws/wudCabLYVUUfjnmo/UzipIb9l3ILOc4
 1KP7koqcZ5/U8jR1qm8U3cO0Lkn0gsO9pDBR4MZ0hR+X9Prjiha2xln05wh8z6ylAZ+zbg
 nClhhPfy3S/8+dMVNtiIhYLhUp830wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718918474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aVaFH4XdMgxk7t/Mo3rThFB3GkHGVkhOTNlHefWZn+w=;
 b=JEDj0o/T3aUcortx5PYaem2gNIOdtbQ+b3suKpmhd8hcYXSGkjF7vfJwxqqKm3JsrQQsuu
 hM5GJhrsUcFB8ADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6C1F1369F;
 Thu, 20 Jun 2024 21:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WtkXI0mddGabYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Jun 2024 21:21:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH 0/7] migration/multifd: Introduce storage slots
Date: Thu, 20 Jun 2024 18:21:04 -0300
Message-Id: <20240620212111.29319-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Hi folks,

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

Fabiano Rosas (7):
  migration/multifd: Reduce access to p->pages
  migration/multifd: Pass in MultiFDPages_t to file_write_ramblock_iov
  migration/multifd: Replace p->pages with an opaque pointer
  migration/multifd: Move pages accounting into
    multifd_send_zero_page_detect()
  migration/multifd: Isolate ram pages packet data
  migration/multifd: Move payload storage out of the channel parameters
  migration/multifd: Hide multifd slots implementation

 migration/file.c              |   3 +-
 migration/file.h              |   2 +-
 migration/multifd-qpl.c       |   8 +-
 migration/multifd-uadk.c      |   9 +-
 migration/multifd-zero-page.c |   6 +-
 migration/multifd-zlib.c      |   4 +-
 migration/multifd-zstd.c      |   4 +-
 migration/multifd.c           | 263 ++++++++++++++++++++++++----------
 migration/multifd.h           |  28 +++-
 migration/ram.c               |   1 +
 10 files changed, 232 insertions(+), 96 deletions(-)


base-commit: 79e6ec66ba1067a135394a330fec14b50cf49534
-- 
2.35.3


