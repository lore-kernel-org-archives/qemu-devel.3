Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662CCC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 18:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxJp-0002op-FW; Mon, 22 Jul 2024 13:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJj-0002mw-V1
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:23 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJg-00034z-Dj
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:23 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A766D21AE5;
 Mon, 22 Jul 2024 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YYXfV6x0e8fmkyJKyhxzcRg35uJCR1PBQcXAjXly+Ks=;
 b=mthr2olm/3PwGQMdss8cp0rhYYwuWBGTbn0h0/z59S4IbAhEeUurE37qx+362OMMqLXaFd
 tfZhWRG6Em9TS48DRejuUZxVbtPvxPzq8bjgdVfZNhxcIH1p+/oaNMycJMZQMai7cn4JkE
 f86zLDJBwUYLu9sKRi0sWdYgbURmKhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YYXfV6x0e8fmkyJKyhxzcRg35uJCR1PBQcXAjXly+Ks=;
 b=CtTxIBpPZy8gO5en8Qr0w/g1bvQYCsDsD1fUC5iNhnjCdWG1gABhjkgajOlWtRr+zj4O88
 dDvavPCJnQfhhYAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YYXfV6x0e8fmkyJKyhxzcRg35uJCR1PBQcXAjXly+Ks=;
 b=mthr2olm/3PwGQMdss8cp0rhYYwuWBGTbn0h0/z59S4IbAhEeUurE37qx+362OMMqLXaFd
 tfZhWRG6Em9TS48DRejuUZxVbtPvxPzq8bjgdVfZNhxcIH1p+/oaNMycJMZQMai7cn4JkE
 f86zLDJBwUYLu9sKRi0sWdYgbURmKhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YYXfV6x0e8fmkyJKyhxzcRg35uJCR1PBQcXAjXly+Ks=;
 b=CtTxIBpPZy8gO5en8Qr0w/g1bvQYCsDsD1fUC5iNhnjCdWG1gABhjkgajOlWtRr+zj4O88
 dDvavPCJnQfhhYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D15613996;
 Mon, 22 Jul 2024 17:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1kuCDPWdnmYnCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 17:59:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH v2 0/9] migration/multifd: Remove multifd_send_state->pages
Date: Mon, 22 Jul 2024 14:59:05 -0300
Message-Id: <20240722175914.24022-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.40 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

In this v2 I took Peter's suggestion of keeping the channels' pointers
and moving only the extra slot. The major changes are in patches 5 and
9. Patch 3 introduces the structure:

typedef enum {
    MULTIFD_PAYLOAD_NONE,
    MULTIFD_PAYLOAD_RAM,
} MultiFDPayloadType;

struct MultiFDSendData {
    MultiFDPayloadType type;
    union {
        MultiFDPages_t ram;
    } u;
};

I added a NONE type so we can use it to tell when the channel has
finished sending a packet, since we'll need to switch types between
clients anyway. This avoids having to introduce a 'size', or 'free'
variable.

WHAT'S MISSING:

- The support for calling multifd_send() concurrently. Maciej has this
  in his series so I didn't touch it.

- A way of adding methods for the new payload type. Currently, the
  compression methods are somewhat coupled with ram migration, so I'm
  not sure how to proceed.

- Moving all the multifd ram code into multifd-ram.c after this^ is
  sorted out.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1381005020

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

Fabiano Rosas (9):
  migration/multifd: Reduce access to p->pages
  migration/multifd: Pass in MultiFDPages_t to file_write_ramblock_iov
  migration/multifd: Introduce MultiFDSendData
  migration/multifd: Make MultiFDPages_t:offset a flexible array member
  migration/multifd: Replace p->pages with an union pointer
  migration/multifd: Move pages accounting into
    multifd_send_zero_page_detect()
  migration/multifd: Isolate ram pages packet data
  migration/multifd: Don't send ram data during SYNC
  migration/multifd: Replace multifd_send_state->pages with client data

 migration/file.c              |   3 +-
 migration/file.h              |   2 +-
 migration/multifd-qpl.c       |  10 +-
 migration/multifd-uadk.c      |   9 +-
 migration/multifd-zero-page.c |   9 +-
 migration/multifd-zlib.c      |   4 +-
 migration/multifd-zstd.c      |   4 +-
 migration/multifd.c           | 239 +++++++++++++++++++++-------------
 migration/multifd.h           |  37 ++++--
 migration/ram.c               |   1 +
 10 files changed, 201 insertions(+), 117 deletions(-)


base-commit: a7ddb48bd1363c8bcdf42776d320289c42191f01
-- 
2.35.3


