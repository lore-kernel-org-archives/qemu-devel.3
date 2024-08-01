Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D76C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV2A-0000ZY-1R; Thu, 01 Aug 2024 08:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1p-0008Pu-HG
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:34 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1h-0000jP-IS
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D454E1FB4E;
 Thu,  1 Aug 2024 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0dDz8nC9uRIk9He5M4Pf1z8JEGHcwgmBDtR+1AqaMgE=;
 b=B+cSDUfSxfEKWZmolKFT+jtlJzErRqUxwElpWSIGvbSkUEsWecZM1Z6NXZC3PJeGDI9vml
 1GmrertoSHeK9FH0+bMwfmmDzCNkxoFuHXy1eYvGClQNGiIzL7n4V0nmXRuY8tgBj1GJnf
 qMwY1yxp63jDnkE2lsOzpXimCDaKXlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0dDz8nC9uRIk9He5M4Pf1z8JEGHcwgmBDtR+1AqaMgE=;
 b=qsDehYI4haVh8YwGxG+cVJjtXN2xvwfCOScjSIbM2GPDRFRklKFRnwkafbkNg3KOWSeKCp
 /lWoO094ZTncrKCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0dDz8nC9uRIk9He5M4Pf1z8JEGHcwgmBDtR+1AqaMgE=;
 b=B+cSDUfSxfEKWZmolKFT+jtlJzErRqUxwElpWSIGvbSkUEsWecZM1Z6NXZC3PJeGDI9vml
 1GmrertoSHeK9FH0+bMwfmmDzCNkxoFuHXy1eYvGClQNGiIzL7n4V0nmXRuY8tgBj1GJnf
 qMwY1yxp63jDnkE2lsOzpXimCDaKXlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0dDz8nC9uRIk9He5M4Pf1z8JEGHcwgmBDtR+1AqaMgE=;
 b=qsDehYI4haVh8YwGxG+cVJjtXN2xvwfCOScjSIbM2GPDRFRklKFRnwkafbkNg3KOWSeKCp
 /lWoO094ZTncrKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB0C813946;
 Thu,  1 Aug 2024 12:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AJBPHAaBq2YEYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 12:35:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 00/14] migration/multifd: Remove multifd_send_state->pages
Date: Thu,  1 Aug 2024 09:35:02 -0300
Message-Id: <20240801123516.4498-1-farosas@suse.de>
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
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
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

Hi,

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

Fabiano Rosas (14):
  migration/multifd: Reduce access to p->pages
  migration/multifd: Inline page_size and page_count
  migration/multifd: Remove pages->allocated
  migration/multifd: Pass in MultiFDPages_t to file_write_ramblock_iov
  migration/multifd: Introduce MultiFDSendData
  migration/multifd: Make MultiFDPages_t:offset a flexible array member
  migration/multifd: Replace p->pages with an union pointer
  migration/multifd: Move pages accounting into
    multifd_send_zero_page_detect()
  migration/multifd: Isolate ram pages packet data
  migration/multifd: Don't send ram data during SYNC
  migration/multifd: Replace multifd_send_state->pages with client data
  migration/multifd: Allow multifd sync without flush
  migration/multifd: Register nocomp ops dynamically
  migration/multifd: Move ram code into multifd-ram.c

 migration/file.c              |   3 +-
 migration/file.h              |   2 +-
 migration/meson.build         |   1 +
 migration/multifd-qpl.c       |  20 +-
 migration/multifd-ram.c       | 400 +++++++++++++++++++++++++
 migration/multifd-uadk.c      |  45 +--
 migration/multifd-zero-page.c |  13 +-
 migration/multifd-zlib.c      |  16 +-
 migration/multifd-zstd.c      |  15 +-
 migration/multifd.c           | 535 ++++++----------------------------
 migration/multifd.h           |  66 +++--
 migration/ram.c               |  10 +-
 migration/trace-events        |   9 +-
 13 files changed, 613 insertions(+), 522 deletions(-)
 create mode 100644 migration/multifd-ram.c


base-commit: 3cce8bd4d737f2ca688bbdcb92cd5cc683245bbd
prerequisite-patch-id: 13fb8c983c330913887987533e1e69bb6a4ed613
prerequisite-patch-id: 3d95428f94bd2126417f309aa7448f6261a8f2f8
prerequisite-patch-id: 71687ba9c29408b37eb25a784965690cfb9698f8
prerequisite-patch-id: 4b935fefd5ef932d45323c5ebeef130cc1587f72
prerequisite-patch-id: d81df6a9e428a82fe9f0a04c13e3b36341c9ffda
prerequisite-patch-id: b0f171771de7cd44e68d8ade8588d49f6bf03d8a
prerequisite-patch-id: e0e973dee5d548a5667e0512650fa1c5b88c90c2
prerequisite-patch-id: 944d3a14068acf1f3ff5ae04beae442347474ae5
prerequisite-patch-id: 35e4690cfcb51cccacec5ba7c03fd32004c0ca67
prerequisite-patch-id: 9f3085d6702c691cae5b5767fe20b008d0e128b2
prerequisite-patch-id: dc6423ec895b9e28e8f6edd97113536242e95c01
prerequisite-patch-id: 53b1c7680fac959f5c2ef786a0fd2c5fd5711524
prerequisite-patch-id: 9392b7caa794ed8a871a4d1986914c99309c9b96
prerequisite-patch-id: 15a7b92cd04c871f2577360475be4c0233837422
prerequisite-patch-id: 5424a98773296ea3f782f199c61f40d948222d6b
prerequisite-patch-id: ea27cd0a9855caf3b5d88940c0988a4d1a76c809
prerequisite-patch-id: f922d0deec9376de12f83dccdf9c146ad96d5953
prerequisite-patch-id: 06ec6991abae625119bc4fb1021fef068a34531b
prerequisite-patch-id: dd0d83e0bc7407ac090eee2c04a4179ac7a29ed7
prerequisite-patch-id: 56d976d50f3179c2ad72ce9757b905cd88be43b5
prerequisite-patch-id: 21b2e1e07f57622742647c1f1be1010f7c1a345c
prerequisite-patch-id: 690216d1b858779a9d5b8b87e5740428c084eff8
prerequisite-patch-id: dd7720e6a8a37181726eb1382236e54a89b5d518
prerequisite-patch-id: e52a32da796a00ace9d5b6aeaecc9238719a222f
prerequisite-patch-id: bc3a88d2a1a55257df56404e1b41b52e24e2bb6a
prerequisite-patch-id: e04e47ceced2b728a04034f08ec4d6b39060ca04
prerequisite-patch-id: 7a450ee99f6a11bb1a511175989b615c818d792f
prerequisite-patch-id: a27b6e2cfa162eb2294920983389c82e2e2aafc4
prerequisite-patch-id: 81d915f5136a90552f794e28f007bc5eada6ced3
prerequisite-patch-id: 1e6be5ba2ca0869009aa2e98269c6d07cd1c073c
prerequisite-patch-id: a7071e107ca7012c21a272063aece5bf6a165234
prerequisite-patch-id: acf2e421fbbe7480311224f0080321bd24bace72
prerequisite-patch-id: c6b305efc098b716b5fd86974486610c35310bf9
prerequisite-patch-id: b2ea0671b1ca8ace09a5be5bc8789e1f9ed362e9
prerequisite-patch-id: dbb0b9c95dc9be1b5f4397afa0e88ec0cc61e17d
prerequisite-patch-id: 20b540d8c51706dfad625fa6747b03f87f85b214
prerequisite-patch-id: 221419287e45a25205d7d854a7fca8f3515d89bd
prerequisite-patch-id: 041d82f9a313815769a294e2dd5323f1e47a9960
prerequisite-patch-id: f23f851a6c0bcb9bf7c3c35e8991f35308275e29
prerequisite-patch-id: 079dc1b0988e3895b2e587909fd569dd1e3e4bfa
prerequisite-patch-id: ef20808cb5817567b151c290304d2407ead5b4d2
prerequisite-patch-id: 11ba2c5120a650e489e49e1dd8859cbeb0385081
prerequisite-patch-id: d06198e7597766a7f620c26c53f1f4ddff088c0c
prerequisite-patch-id: c0e5474ff1e06e3650ac210f0f6d23c71b26f694
prerequisite-patch-id: d190df2ffd206a2f473a47d53da8302254d3c0b7
prerequisite-patch-id: 9bae8b536d05070c5b142ca238ad98c08fcb892f
prerequisite-patch-id: 39719510e3d8000a693f59966c5d6be0a51c60e7
prerequisite-patch-id: 0ada1d54ec5ca0e87bb497b042aa9e447afc9b3c
prerequisite-patch-id: 52bd66de61e3b394eacf88debb333b352cdd27f1
prerequisite-patch-id: a4cb433552382d323e361491a10f21bd3ea5b146
prerequisite-patch-id: 3e1bc2bce418c96703e328db3366aea3050c685f
prerequisite-patch-id: 0f3f6d353e7274ae6c042b32f51ef89af5a913ca
prerequisite-patch-id: bc75f89192c8d1420556c7977f93102ed38cf1f7
prerequisite-patch-id: 7fb07c996e4229d1edaeb94fed9c03eb710e894c
prerequisite-patch-id: d62bbbc43d995fbd0016e05e7c71aed38478ab07
prerequisite-patch-id: 3faca00d83f7cfc29d31df2cb972b1b97f57e505
prerequisite-patch-id: d276940aaf4fa4ef2358a28008ef13b731a39629
prerequisite-patch-id: b8a268e1585faac7c99a5a49cd0ba02b4ea04fc7
prerequisite-patch-id: 8ceeef85cb7108e965defb5dcd38ced0b1e4eb43
prerequisite-patch-id: 17c85eb4e53c93833d2983fafa8e74ac11f3ce9a
prerequisite-patch-id: 9db5aa84bdb09ccd1c89a65f9fe00a5b967a1fa4
prerequisite-patch-id: 8a98f58e3d04dabce63e5a73605052ec8f99e77d
prerequisite-patch-id: d0bbfe026091c750b52a87a837f25444a1671e2d
prerequisite-patch-id: 56ec9da207926c5cee8bcd090fb01782e3c8f94d
prerequisite-patch-id: 5efc4ef57b1fb632e38dc1a0c8db294745fe7651
prerequisite-patch-id: aa4f714be6f0e4f47edaa2c7ab08c0a124cc8f10
prerequisite-patch-id: 96161dfcc9b8be7ab2f7d8b45b84c6dab46e261e
prerequisite-patch-id: fa09bb268a192039476c21e0826a5cd6b3a3814e
prerequisite-patch-id: 9dea8db103a584ef8217bc8b8cef6577b082810e
prerequisite-patch-id: 7486f1a89780da95370873a5ef54cba0768a3a76
prerequisite-patch-id: 743c04b4fca6f3c872571fd6409260fc022a378d
prerequisite-patch-id: f72522e4b88a8f0253bb42b7a0f2c8b2cd556faf
prerequisite-patch-id: b87feef9f763eb9abb52ff4002fab9e383170b7c
prerequisite-patch-id: 4d1a35c120848cefac2cae61525d68cc7f2e9225
prerequisite-patch-id: 5a17fd53cc2d5b1ce9648f5da88159fc1b71f386
prerequisite-patch-id: efabe93b4dd446e98a18a95e0d6458f5754d0b22
prerequisite-patch-id: d5096ebd2a916dbb553d1fa87afaab2f022b1ccc
prerequisite-patch-id: e127d6b1738baac49f5771be941bf46e9249ed1e
prerequisite-patch-id: ec959712db5cf3994d67a8e63901f8e9bc9a5ff6
prerequisite-patch-id: ca7dfa5a6be16b670b4f3ef78ea30dae32441785
prerequisite-patch-id: 6eefed2e2e07fecf02ff59082750d15d69da3308
prerequisite-patch-id: f51f1fc9d9551d23d593d1fd00fc1705fc13bbe3
prerequisite-patch-id: a26a1a49f1c0aa37facd754357c7c662e906302f
prerequisite-patch-id: b9842ad176b1464d14c6c2c3738513a4a9dee4aa
prerequisite-patch-id: 60bda711f65550428d0c71db40c40e988488ddd4
prerequisite-patch-id: 34eb77fabced2ee263ac741c0655a7bf08a4ab6d
prerequisite-patch-id: 963ee62cced18c3c670ac37205d214a2e7685e81
prerequisite-patch-id: b89b171328298b015df107d929f51cbf4d014cf7
prerequisite-patch-id: a72b6c6e6466da6d3331b0f81342ec10d4d5b284
prerequisite-patch-id: 03c31a68fce3b7c376b7cc5af90682e5b01fd0df
prerequisite-patch-id: 873751126726c46b946273d2be7f7f27248cd1bb
prerequisite-patch-id: ecbe43e43396941f0c53da3c37d8c5d802b9ac05
prerequisite-patch-id: b681715a6d736c2be8d8fec32aba8eed1e6f9078
prerequisite-patch-id: 939558921113ff8049eef6670a8cc029ef05543e
prerequisite-patch-id: bd17dc99ece68b5bab3ff9daf7fc8e499e1ebc6b
prerequisite-patch-id: f98b097eb060620a5abab23e6b1e7a844d93e34f
prerequisite-patch-id: d18c958b3170513ba516a684a012e614e5fffb24
prerequisite-patch-id: c5dc0d8523e1ec5350aade0f26fdf7b0fe2512dc
prerequisite-patch-id: 85a9994d9c832ce1b93b88596a4907fca9f6eef9
prerequisite-patch-id: db1e0e6af4396d4d1aea022bbf0accb42df1d95c
prerequisite-patch-id: aeec629b49de4924e258f703c80004ab2372028a
prerequisite-patch-id: 6e7604117c7a60a516d040f96a5b2e0003e769fa
prerequisite-patch-id: a7603aee0aa6ffeca0e6cf61bfa3f86999f03075
prerequisite-patch-id: 37a53f691313007b37d0710aca98d2135017c1df
prerequisite-patch-id: 9ae8ac17cc02abe3e1edf0433882f25a56d071e0
prerequisite-patch-id: 09bf6d466076368108476f838f1cedb69bbfc1d3
prerequisite-patch-id: 6b2d5a9254dad9516992a254c4222a5cabd820b0
prerequisite-patch-id: d5ac270f9afe46a59c9cd242c8c6891b2ef11dbc
prerequisite-patch-id: 891d6e87aa83dc113c14136f5f68aa1ac3407bcb
prerequisite-patch-id: f620362deac56665b85f3fb3feee9a52c380a642
prerequisite-patch-id: bc3c5c647832c31e554f4db529b652ad611a6f6d
prerequisite-patch-id: 2cf2edb8b7fb86f2b15e0577919539a4968e6c55
prerequisite-patch-id: 9adea6cc53fd14a958fa6526609069e1d2f08b17
prerequisite-patch-id: 2b2449c503dd43b1fc076c7aeb6f9a88d414f9aa
prerequisite-patch-id: 6f3f7bae420d5cd3f5336d03586c74649bdec5ae
prerequisite-patch-id: 72e3fa6afc8abeffe053d0b4fda8a1a92f439ccb
prerequisite-patch-id: 399beb1082afa887e2ed8f6366e9ff0fadb1add2
prerequisite-patch-id: 6d2257580f53bbcc3019372bfa71b7802fb443be
prerequisite-patch-id: 5373234aa561a7ad4882ee1297a722a2cd563483
prerequisite-patch-id: 72770bf2d749881a5050ef1967e376e323a953fa
prerequisite-patch-id: ea475a629d03117fab36bf15479a8b0f9d2c3d44
prerequisite-patch-id: 6194f6893c70ee15284f8004be19322ef27a7153
prerequisite-patch-id: b817779acaeef58d74508709c5315c6ff9639761
prerequisite-patch-id: 56fdfa5291464155be2a22d5f1773a3875ba53ea
prerequisite-patch-id: c5f55ac00f159a79d625ca24239c0198c663e807
prerequisite-patch-id: 1742d4904cae5a1faf79668ac2b18be284b9aa30
prerequisite-patch-id: bcf9a9f7e117c6d135dc53f5e0e41d2e10a24b4d
prerequisite-patch-id: 2801f2428ec6fa368e55556cd1c4f1633f82b371
prerequisite-patch-id: e48d9b78d4e0c59797a93c27366c0e8e7b40831a
prerequisite-patch-id: 9d378c3fcc3defb5990e9b4fac0481b4d9cbf998
prerequisite-patch-id: 30a79f47815477c6626c59770ba09e401785a095
prerequisite-patch-id: 8bd103d6b2d89ae3ac5e38a041b47a531ed41e40
prerequisite-patch-id: 61e8832b8c1f293cddeeceaaaf30ae9709d99cf2
prerequisite-patch-id: 0c27b5ed30dc34d6c6b1158822d687afc570af53
prerequisite-patch-id: 30218ba738c05231a97a239a7b7db263b9fa3e00
prerequisite-patch-id: de4606a7b886fe844979bf396dec51fcbb6dde0a
prerequisite-patch-id: 96c8fd8f3835ea9ab2dd1494a7716f4a65579554
prerequisite-patch-id: d7eb400ef0b6474bd1a4ae562a2989ee7f09a38e
prerequisite-patch-id: 10100b6534f56912a29a165b8709f9e00ebfb423
prerequisite-patch-id: 4aa8159251d656ee0ac1d23930533ac3e2a63aec
prerequisite-patch-id: 1583345b2b64479d2a3255e8e1f633c46c36bb94
prerequisite-patch-id: a7e6527566e0c715a3b07af5d6b1ec2477cd2e0e
prerequisite-patch-id: 84ef10eb1a1b0456fadbb166267a94662d0606ff
prerequisite-patch-id: f2049657d1fa03cd95a6be6ce152b6a155aff063
prerequisite-patch-id: a6474c935071bdf3cba1a1b2e067f7119f77513a
prerequisite-patch-id: 6ba32fbc28136539958b000c47032d8ccd9fba51
prerequisite-patch-id: e5adff7e7c035831ddb7fc2e518c23e1e6cf6369
prerequisite-patch-id: 4f07f2a5c4ac917a2d3bb5b1e988c11264a0fc93
prerequisite-patch-id: 99a1e21173e5f25502866539e23a8be9beee9d3c
prerequisite-patch-id: 22fe9bf6a8a79c33d4f87b5ca395e65bff1721b7
prerequisite-patch-id: 3e1ab4b997e26be7ded8af84ff934fa38337f517
prerequisite-patch-id: feab895cda6daab7368c9eccfad561262178e772
prerequisite-patch-id: 1488d6151031bc38309677c5b34b83322a062eff
prerequisite-patch-id: 3a533bdde4bf66a9096e0fda7ee0b945d99e7f53
prerequisite-patch-id: 6524f2c8d3366b5767a937b15b3e0c256d18ceea
prerequisite-patch-id: 4578afb3b16b6fb60edc4309f0b6895867707396
prerequisite-patch-id: d17ec591d5951b6b0929fc0cb0eedcbad473d5e0
prerequisite-patch-id: c2c0be108c4cfc5fbd7f371b3bcf8e3a7fbb293c
prerequisite-patch-id: 7c72b99380179c2342c6d4a45445709ccfcc1525
prerequisite-patch-id: 6eff34ed40cef45df4b3fa9831e4bdd3fb6cbe01
prerequisite-patch-id: 28051ebaadce4361b951f0e33d8b6729eec44fe0
prerequisite-patch-id: 4145960f8ce4d8ac3a2e6c1b983245a545e7fbd2
prerequisite-patch-id: 567ab210666266b8566798223b6f86cf511981c7
prerequisite-patch-id: 7039619fae616a73255d0e309b827795c8fcdae4
prerequisite-patch-id: f802c83e5ca45642f1efb2ee24be6d69a831e654
prerequisite-patch-id: 6fc655fd9dd8e6e33e1dae0b603d89b59d0889e3
prerequisite-patch-id: 0f17452e2988269385fbec6a7c49eee867cf6995
prerequisite-patch-id: e00b304f28d1b602bfb228a99c7338cd352577ce
prerequisite-patch-id: d409d879b604278d1142da46257cdb506c6a327c
prerequisite-patch-id: abbd22811acacdbcf1bc3e7aab071df609f4b5e7
prerequisite-patch-id: 48154ad8726f2e7839ee5b7ab937527d2752f670
prerequisite-patch-id: 693d29957da2544f09651bf63f2df66335c784af
prerequisite-patch-id: d4fdd1f5cc03bf7544edc9ffab8eb6576053ec8d
prerequisite-patch-id: ed843b76ff082fcd8fe2bb2098333e67049bb724
prerequisite-patch-id: 7b1184dbb311148e8cd7638fac8ef0da5bcc7736
prerequisite-patch-id: 463e54d104b912c7e5a889c472f108dada39935b
prerequisite-patch-id: cdf627d2db55db40ff6135ccd1caef4ba040b65e
prerequisite-patch-id: 505f3b47cf39030805b5bc55271222bd5269ecb7
prerequisite-patch-id: afe92aa2cc06dd6c2ead36a8a75e5d4db3e39216
prerequisite-patch-id: abcc6b86f2739c9bf24d8311ac1085d196ec86ae
prerequisite-patch-id: bfe8fa1d7b92e78f868a1115fe34b0e7705e7270
prerequisite-patch-id: f6c12160e8c18342e212913ab446abaf0c1fa4ef
prerequisite-patch-id: 4f77617bceba99ff696734c39787cf13e637e4aa
prerequisite-patch-id: 19fc9d4f0fb10ceb5f9b44cc06014de8ccbe9b08
prerequisite-patch-id: 145fa70dbad65ce73309a9eb3b68698dd4d87bce
prerequisite-patch-id: 632ece0cbce4600b2920d8692eb54f29cc3780f7
prerequisite-patch-id: 492005e007760cb30207694288683d1afa2b8da2
prerequisite-patch-id: aef029cdfe24b3eb7a6e57202d3937c0973b66a2
prerequisite-patch-id: 2b1421f93dcaf115e7d95af6dbe1e187a4206224
prerequisite-patch-id: f37070ef2ea84b81a3c0166b3e48e06f9c42b7fd
prerequisite-patch-id: c491e100f717942929306a711fed782954f619f0
prerequisite-patch-id: 709fe575604297bc824e269787d6214f271eab44
prerequisite-patch-id: cb5b779a69c709562a00b20b5f17edcec759584b
prerequisite-patch-id: 70e23e7d5d17b0a40b0222ed1e9f601de0641e43
prerequisite-patch-id: 406a69894a1b8b1d8569eda0708c3c2ce8512ac7
prerequisite-patch-id: 4aa66ad0c58e5db7d3006e5b01ec07cd334d194a
prerequisite-patch-id: 46e029947ece9be7d6dd62c52777ff663f603513
prerequisite-patch-id: f7e74cf4e29abbf89f757d0057de236be65ccbbb
prerequisite-patch-id: e4cde74b826dfcda173263446482fa2279b22daf
prerequisite-patch-id: 60df1811efdf86a39285528668c49064d5b635fc
prerequisite-patch-id: 07ee1e34207e626feaa9383e95e46744946fcf7d
prerequisite-patch-id: 1218747de1943091b3e2a2b7edba586204711b94
prerequisite-patch-id: 0ea0a831ea8d77a44feed1312184292a1933b406
prerequisite-patch-id: 2fb210c9318e3baa065ad0fe319cd0bf5500253c
prerequisite-patch-id: afb12a368a0eab1bd0fc8ec8d2031d87b1400628
prerequisite-patch-id: bcf116b7685ab717b31a73d6204e2c3396945a4d
prerequisite-patch-id: ccf321d3d877ad63aafae004d61e677c3b9e0e4d
prerequisite-patch-id: 785c406be98b9abcdf556f32b87bd3abc291b565
prerequisite-patch-id: ce08905deae2f43f5785c7c3cefe6e2ff7202566
prerequisite-patch-id: 67a48c522f6917694df79a7da2cacb124639b1fc
prerequisite-patch-id: 28d33665f3057d9c568b1be55793186ee8bf2a3b
prerequisite-patch-id: 141d789226542c2208b6cc93c8c730dae78f3206
prerequisite-patch-id: 4cae9bcfc9da364a22443c0d3388d5656130f3a7
prerequisite-patch-id: 9b0bcc495cd71e84c091144a946b3072fedd6cef
prerequisite-patch-id: 378a972aa8c88bc4e13de334be029e28b7324390
prerequisite-patch-id: 769159abc5615c77664ccf96cddb999d1615a60d
prerequisite-patch-id: 241522598e54a7f2e5e447d4387c1d362c9f3db9
prerequisite-patch-id: 886c2e24efa498a77d02df142ac1774de79d1bc2
prerequisite-patch-id: c6baa832d495ea6b198f90da386f08ef3bd862b8
prerequisite-patch-id: 68f5c44b96aaf718340edb9966c816a16dbb8592
prerequisite-patch-id: 7ceb5858eb2bd5898d0c77e275df7cebdb4f7e3a
prerequisite-patch-id: 1c91f782de2190318034e2d57e5c87e927fb50a6
prerequisite-patch-id: 664634677db2ec49ce28bbf074f6c154ead544c7
prerequisite-patch-id: 9556e94a915387c81566b0ca7c60d281e7375612
prerequisite-patch-id: ea59a5c8d09896a094a82781da9139f6fcadea0e
prerequisite-patch-id: efebadc8ba5f01a43e24516eb573ab9b98a12861
prerequisite-patch-id: 2999043154c3940962c8f26f4cfe96757ea2b73c
prerequisite-patch-id: f15fe9c0881b7f2c20dfbd9b0f07bdc6d62fbeb1
prerequisite-patch-id: 412ef91a0859ccbe9ef069095c4b79f0437e160f
prerequisite-patch-id: bbfdf78a5e6cfc46c23cc84a87d56db1b5f2e789
prerequisite-patch-id: 3a2f80b2de6b840432e6733dc8da4cbecab59256
prerequisite-patch-id: b6bb72fccc5289501d277b60650064cf6761a02b
prerequisite-patch-id: dec5790d783ad8311ba2713c89c630311f7bfe5c
prerequisite-patch-id: 2b165ec700bd20a09fed5981b9152f477fe1aaed
prerequisite-patch-id: 13334380aba5ef0dbc9307ab77f741fe1bb263c6
prerequisite-patch-id: 75aab74d9d395b905a5f18cee9e50eb57b931c54
prerequisite-patch-id: e29d1706bdb9035f8d9b167ac961b843601da27d
prerequisite-patch-id: 75dce6dc0a6974218a1ffe8012eea6c37d43c38a
prerequisite-patch-id: 916fa02f68d06a204db518e0fc14655bda5b9f3e
prerequisite-patch-id: 396c5598baa18a4ff1d387a720e90279d4e84b32
prerequisite-patch-id: b1a6de346564ee6cd734026fc73886abf820ef27
prerequisite-patch-id: d42fb9c343fd156d75ec9fc9385f3a102ad61e69
prerequisite-patch-id: f58200f6a9646b8bcf3885df434eb01c0b72e463
prerequisite-patch-id: dc1810c55e1873f4fed2d1ed46cd6293e77729ff
prerequisite-patch-id: f31326c9f9aa5b1add2affc97552abcbb65b24da
prerequisite-patch-id: c62adb1b1209a1b5b415f44f7cbcd6d3463378a7
prerequisite-patch-id: 5d72b5607e606b78c17dc3225c401d74b126b1d4
prerequisite-patch-id: 56ee1388e8241ea3f1eab4a90a8f0e59352e356f
prerequisite-patch-id: e4ac9158310c24026fc3a0d1efca03263387bc91
prerequisite-patch-id: 6c9af50cce8d8326a8b1dd936dc2e979e6acb105
prerequisite-patch-id: 2e2ba3c600a7b17b0e3078594602599fbc9eb105
prerequisite-patch-id: c652c2d7694e9739b273dbd77e36d44c50e06387
prerequisite-patch-id: d06de4cdba195d531aeffdd69202f98e0c188351
prerequisite-patch-id: 13bad1eb0834f971fac89a768978c98a6d910f64
prerequisite-patch-id: d849f83159c17c55369be6ef85df1583ee419aab
prerequisite-patch-id: d600006c8e584eeb61223733a016a8bc618627d9
prerequisite-patch-id: 2ff12f99fbc489c5329f2fec1bbb26186aa8f9f6
prerequisite-patch-id: 48c736893871c5d1157746f7ac9242ce0db11bb3
prerequisite-patch-id: 3ad2087492141825c298e301deee1e4cfe624679
prerequisite-patch-id: d971d4c794cddeac920f6f99a93af0e7bd99f245
prerequisite-patch-id: 7812ab1b04f502164366797259a33cf7ee9a56b9
prerequisite-patch-id: efcdab55b35dc1ae7a1bbef1119687667306cd58
prerequisite-patch-id: c79dbe78ce5d943b7a02adf3777b9923107c27f4
prerequisite-patch-id: 56125b0bbbcb907bfbd08e45c476d5bb067dbf02
prerequisite-patch-id: 34e5515352cac12ddfbf031916d2e158cef8ee37
prerequisite-patch-id: 2a3d9e59f9d314d6c3b40025f065b51401d94aaf
prerequisite-patch-id: bea3bdd12c52a3b7f95b4aec4e29c201db932517
prerequisite-patch-id: 301eb6c90f186e5752d5b81396052b049a9e0539
prerequisite-patch-id: 8ddfb7aede4fd11bbd904450cf167e8812f19e36
prerequisite-patch-id: aadeae7c6978d4b11c30944cbf71c85d17a1751c
prerequisite-patch-id: 2befd9c5a50db6814a7d01010c655642ec914717
prerequisite-patch-id: 47fbf48e91e065fec612dd5615f54e252b649b0c
prerequisite-patch-id: 49c8f7619a807a1e02cec593973db1fb542bbe4d
prerequisite-patch-id: 8fdb47e6c8d670c65f907a790abae32d39da780f
prerequisite-patch-id: 4c1108ea87cba0bbaadaec52d4ecd25f87f5d206
prerequisite-patch-id: 96c5da475e96cddb3a69a26d36240934446af4b5
prerequisite-patch-id: 9d44defb04c763fe9039160dd51d63aee3aa6f32
prerequisite-patch-id: fac5f84794e83cd4e64b452ec7a89e81a653f78b
prerequisite-patch-id: 39a76f46b875f097bb4016be1423f981ffd7c803
prerequisite-patch-id: ccf635b303726f328d5e314b3903aa516bc7088d
prerequisite-patch-id: 853c7ce13865cbdeffb20619d2a90c3679eb7a80
prerequisite-patch-id: 8038e519eed44408ad8712fc6c2b6529562c9efb
prerequisite-patch-id: 45f5c900fa54c8a8854fde60a796b21182456d78
prerequisite-patch-id: 0b3644404517e9a07e8ce562da4b9118e8c62114
prerequisite-patch-id: 322059db28c778851ccc8be51f99307bc723550b
prerequisite-patch-id: 3ca9206fa843f693765baa56509fc3827f37d63f
prerequisite-patch-id: f16c111772453869e52e2136bcf579287e86a56d
prerequisite-patch-id: 96a5aa53078ce3da06950e3c82dfd22abbe03e8b
prerequisite-patch-id: 2cbe2ea6ef41c14a3fdf1db339d15b2515fa50da
prerequisite-patch-id: 8879f4043b7f2905c37c5e7be16bbcb7c281a397
prerequisite-patch-id: baa117d25b0e9680f39d4e2ff2416c5c3bcf4b40
prerequisite-patch-id: 23310473e76a776b2b948fe35ee730bc64e88d88
prerequisite-patch-id: 5d61126c42534dcaa2695ee379e6ce1f8cb99a28
prerequisite-patch-id: c9d9c91a1b9c0261aab7acc79d73f46eeb1e01b8
prerequisite-patch-id: 3cb48173784349c652c593ec294539f70195bf84
prerequisite-patch-id: 0ffcc57ba70989723ded660482e9d323e8ab9374
prerequisite-patch-id: df54768710d624bb304bfbdedd94c245934b44bc
prerequisite-patch-id: c371905e5bc98c1f25d41af1b4568fc5de4a408d
prerequisite-patch-id: 277ae9aea67428a1a2b822cbd79f860ec57d19d2
prerequisite-patch-id: eb1c53b4be23b527c5e12a9d45862a94e874bb25
prerequisite-patch-id: 147e16e6aa66276e1eaab589396a05f215a98d9f
prerequisite-patch-id: de3e5c45e2f41caabdfe2924a6eea5403ba84005
prerequisite-patch-id: 905379d7e277957b68bc8b1620e99d7d20eab2ab
prerequisite-patch-id: d88c5521bfadda59ca49f7c851ce8c6b77066de9
prerequisite-patch-id: 1ce55ae23b721b6f9dc7a9e71a436a54e124ab6c
prerequisite-patch-id: 1ba305947ab60e8597af982ca908ca31bdd5219a
prerequisite-patch-id: 1413d26013fb85655c26a79254087a124c0addfb
prerequisite-patch-id: f41f1b8988b52ca3dd1ebc910475fca064650b98
prerequisite-patch-id: 6e3cec0197efb5d9733758cb160b4dcff1bf0d11
prerequisite-patch-id: 450de6916e7ea02414df2ffccb2df4444d520e67
prerequisite-patch-id: 1b37abc1e237f22f80c0dda647764e754169752e
prerequisite-patch-id: 04b3b9b48c01e32abfb6efd3bf9be5f02e9d1c53
prerequisite-patch-id: e6c320c58fc1bf51d86e9e408c0f2882d9f3a2c9
prerequisite-patch-id: 0032ecefff5b77534359c6cb0981fc9d1f80b7a7
prerequisite-patch-id: 5812bf877034429957e4ad0181de2f7c98325d65
prerequisite-patch-id: d99f11246891f6bc6569162e3a497e442d72af03
prerequisite-patch-id: 77d87342c5fc325bcc9a233b144b577355f01d74
prerequisite-patch-id: e15e24c79fa689fd86a3dee9656d9bf02dc28f51
prerequisite-patch-id: 776174c7f7bea4443a51a654cd65f2f2d36eb8fc
prerequisite-patch-id: c415036c8a2a0fb8a9d0f035eb8a696ab5b6b837
prerequisite-patch-id: 01a13de44433e986d7f9f4486c88666a7b631454
prerequisite-patch-id: 66438751ea421e920c7429ef69005722bc91f114
prerequisite-patch-id: d506fe9a8feef7daa8fcf4e1b2e557431cc129b6
prerequisite-patch-id: 74fc5477a7d9c6ab0a600d0738e21ead087808f9
prerequisite-patch-id: 0a889b3f7a62226c4a8ee993163a240fc3bfcc91
prerequisite-patch-id: 17f3dadad0df0802e251ef45fabbced1b0604a03
-- 
2.35.3


