Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23D9C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCwc-0001hI-LO; Tue, 09 Apr 2024 10:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwa-0001eZ-MX; Tue, 09 Apr 2024 10:59:28 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwY-0005qw-Oz; Tue, 09 Apr 2024 10:59:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C181933A53;
 Tue,  9 Apr 2024 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Iv5zxijU4VTR2socV22qkWlTQ7KvKyxtR+hGxJQFBQw=;
 b=fjNX3ZQ/NjBWV8l9QF9l5cyrwChrDn5gyYKrA1WEeR2hhnCIOuHRtDIMJsiVfgW7B/QIZg
 Rsk4HeAe0BprFq8oH5p55DUShnlaPOz+ZMOVjICXOyKiMsOf0l40w1NtSrW9IRneJLD9Vk
 7Yq0sbdKSMt6tacKxZOvW92taoAicgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Iv5zxijU4VTR2socV22qkWlTQ7KvKyxtR+hGxJQFBQw=;
 b=iYMrb5sFEuuRrKwx5oaXNKufuWaagsgAkCjIfrLoxRwBpsiVOO6Mflm+AlUQrJAhS6WzmM
 gaRvabQrGUl9vVBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KYTb9oyo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4ze+nQpk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Iv5zxijU4VTR2socV22qkWlTQ7KvKyxtR+hGxJQFBQw=;
 b=KYTb9oyo+HeLoAZkiTKUaiIW8DIMYV27ipWJzozY5+2QoTh+tu5svNm2KYX3/9Clmm95TB
 0YqFEZrbh0vUWn2zbu7rMj71R+DLjN8O6tfQOy4gIfq1SYF6Ugm7SKFSKTK+vL6JQBtA1b
 RimvmSgpHVX5oq+MpQn628JUHOG3rKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Iv5zxijU4VTR2socV22qkWlTQ7KvKyxtR+hGxJQFBQw=;
 b=4ze+nQpkAfAEjc+ZASmaUWRSHCdJ/8ZURQBoXhBi3oJBkx+FwwsQ147xm28WusclH6DJfL
 vEYPlQV+C2O8XpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AE5013313;
 Tue,  9 Apr 2024 14:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w0Y6FMhXFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 14:59:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 00/11] block: Convert qmp_query_block into a coroutine
Date: Tue,  9 Apr 2024 11:59:06 -0300
Message-Id: <20240409145917.6780-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C181933A53
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,gitlab.com:url];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi, it's been a while since the last version, so a recap:

This series converts qmp_query_block() & qmp_query_named_block_nodes()
to coroutines so we can yield from them all the way back into the main
loop. This addresses a vcpu softlockup encountered when querying a
disk placed on NFS.

If the NFS server happens to have high latency, an fstat() issued from
raw_co_get_allocated_file_size() could take seconds while the whole
QMP command is holding the BQL and blocks a vcpu thread going out of
the guest to handle IO.

This scenario is clearly undesireable since a query command is of much
lower priority than the vcpu thread doing actual work.

Move the 'fstat' call into the thread-pool and make the necessary
adaptations to ensure the whole QMP command that calls
raw_co_get_allocated_file_size() runs in a coroutine.

Changes since v2:

- Do the changes more gradually to make it easier to reason about the
  safety of the change.

- Patch 4 addresses the issue I asked about recently on the ml [1]
  about how to avoid dispatching the QMP command during an aio_poll().

- Converted qmp_query_block and qmp_query_named_block_nodes in a
  single patch to avoid having hmp_info_block call a coroutine_fn out
  of coroutine context.

On v2, Hanna asked:

  "I wonder how the threading is actually supposed to work.  I assume
  QMP coroutines run in the main thread, so now we run
  bdrv_co_get_allocated_file_size() in the main thread – is that
  correct, or do we need to use bdrv_co_enter() like qmp_block_resize()
  does?  And so, if we run it in the main thread, is it OK not to
  acquire the AioContext around it to prevent interference from a
  potential I/O thread?"

The QMP coroutines and also bdrv_co_get_allocated_file_size() run in
the main thread. This series doesn't change that. The difference is
that instead of bdrv_co_get_allocated_file_size() yielding back to
bdrv_poll(), it now yields back to the main loop.

As for thread safety, that's basically what I asked about in [1], so
I'm still gathering information and don't have a definite answer for
it. Since we don't have the AioContext lock anymore, it seems that
safety is now dependant on not dispatching the QMP command while other
operations are ongoing.

Still, for this particular case of fstat(), I don't think interference
of an I/O thread could cause any problems, as long as the file
descriptor is not closed prematurely. The fstat() manual already
mentions that it is succeptible to return old information in some
cases.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1244905208

1- Advice on block QMP command coroutines
https://lore.kernel.org/r/87bk6trl9i.fsf@suse.de

Initial discussion:
https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03141.html
v1:
https://lore.kernel.org/r/20230523213903.18418-1-farosas@suse.de
v2:
https://lore.kernel.org/r/20230609201910.12100-1-farosas@suse.de

Fabiano Rosas (9):
  block: Allow the wrapper script to see functions declared in qapi.h
  block: Temporarily mark bdrv_co_get_allocated_file_size as mixed
  block: Take the graph lock in bdrv_snapshot_list
  block: Reschedule query-block during qcow2 invalidation
  block: Run bdrv_do_query_node_info in a coroutine
  block: Convert bdrv_query_block_graph_info to coroutine
  block: Convert bdrv_query_image_info to coroutine
  block: Convert bdrv_block_device_info into co_wrapper
  block: Don't query all block devices at hmp_nbd_server_start

João Silva (1):
  block: Add a thread-pool version of fstat

Lin Ma (1):
  block: Convert qmp_query_block and qmp_query_named_block_nodes to
    coroutine

 block.c                            |  9 +++--
 block/file-posix.c                 | 40 +++++++++++++++++--
 block/meson.build                  |  1 +
 block/mirror.c                     |  1 +
 block/monitor/block-hmp-cmds.c     | 34 +++++++++++-----
 block/qapi.c                       | 63 +++++++++++++++---------------
 block/qcow2.c                      | 20 ++++++++++
 block/replication.c                |  1 +
 block/snapshot.c                   |  2 +-
 blockdev.c                         |  8 ++--
 blockjob.c                         |  1 +
 hmp-commands-info.hx               |  1 +
 include/block/block-common.h       |  1 +
 include/block/block-global-state.h |  3 +-
 include/block/block-hmp-cmds.h     |  2 +-
 include/block/qapi.h               | 24 ++++++++----
 include/block/raw-aio.h            |  4 +-
 migration/block.c                  |  1 +
 qapi/block-core.json               |  5 ++-
 qemu-img.c                         |  3 --
 scripts/block-coroutine-wrapper.py |  1 +
 21 files changed, 157 insertions(+), 68 deletions(-)

-- 
2.35.3


