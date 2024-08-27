Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5315AC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Gs-0000rE-Tc; Tue, 27 Aug 2024 13:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj0Gp-0000p6-KN
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:46:19 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sj0Gn-0000UD-Db
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:46:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B020B21B1B;
 Tue, 27 Aug 2024 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724780772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LuIpdPeRgCasEsSviWm2FdJss6pAdk7EFqIOa5w4QlQ=;
 b=OZeo0ozk9kdRe27VqBeVVg/lpdU8pWuaOD/Fdrp/I7rGgvqwWud9IjLJ3t5JE13iytPpdo
 fFY9Yk5e9Vk/oS/jzirkW/n8KYXz0+aXBKjOh89dsu8m4EiT7ekAadmsTan7F7WGdbKCwb
 Kj1wzP6BPVFEkoNOWTTs4WvqX41RNLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724780772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LuIpdPeRgCasEsSviWm2FdJss6pAdk7EFqIOa5w4QlQ=;
 b=zSR3yhTuGGhD6hT4RHNuGX47AMpWVkDaHWbtnmJAUStMWSsoL0gWF2VcWCK/M4azLl3DIC
 wBhCPXqjbPREr0Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=N4N5YboM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AalM21Iw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724780770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LuIpdPeRgCasEsSviWm2FdJss6pAdk7EFqIOa5w4QlQ=;
 b=N4N5YboMM6F5Wxe4KGj/nokibdbOLEkGSFTvopv3v4na0Nqm/LLHpEW9x83fYZZagzjooE
 GVMjgWFJHVJVl4tgG2mMhR3Utk+VgDgciUDDtdsTbJpk0SMgyPJ00UNMVhE3/jOZlmaQMJ
 liqbw2tr93mRCaT0HGXUnJnkOC4IU7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724780770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LuIpdPeRgCasEsSviWm2FdJss6pAdk7EFqIOa5w4QlQ=;
 b=AalM21IwZ+1hGZXt3jJ7dKEc8cuynhvMV9m7TVbU405D+oSWz6wJxZthaCT6eib3k9sp8C
 wcP2TyobVYMV0rBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49BD013A20;
 Tue, 27 Aug 2024 17:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eBAeBOEQzma+UAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Aug 2024 17:46:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 00/19] migration/multifd: Remove multifd_send_state->pages
Date: Tue, 27 Aug 2024 14:45:47 -0300
Message-Id: <20240827174606.10352-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B020B21B1B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Added some docs for the multifd methods since I removed the docstrings
from the various implementations.

For the recv packet cleanup, I decided to go with the const packet
suggestion. I generally prefer to not have that sort of side effect,
even if it's for sanitization.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1429203972

================================================================
v5:
https://lore.kernel.org/r/20240826195322.16532-1-farosas@suse.de

Hi, thank you all for the reviews. One more version to address a
couple of cleanups suggested by Philippe.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1427843439

v4:
https://lore.kernel.org/r/20240823173911.6712-1-farosas@suse.de

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

Fabiano Rosas (19):
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
  migration/multifd: Make MultiFDMethods const
  migration/multifd: Stop changing the packet on recv side
  migration/multifd: Add documentation for multifd methods

 migration/file.c              |   3 +-
 migration/file.h              |   2 +-
 migration/meson.build         |   1 +
 migration/multifd-nocomp.c    | 388 +++++++++++++++++++++++
 migration/multifd-qpl.c       |  79 +----
 migration/multifd-uadk.c      | 102 ++-----
 migration/multifd-zero-page.c |  13 +-
 migration/multifd-zlib.c      |  99 ++----
 migration/multifd-zstd.c      |  98 ++----
 migration/multifd.c           | 557 ++++++----------------------------
 migration/multifd.h           | 152 ++++++++--
 migration/ram.c               |  10 +-
 migration/trace-events        |   9 +-
 13 files changed, 709 insertions(+), 804 deletions(-)
 create mode 100644 migration/multifd-nocomp.c

-- 
2.35.3


