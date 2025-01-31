Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF239C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 13:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdrSw-0001Te-3N; Fri, 31 Jan 2025 08:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tdrSt-0001TN-QE; Fri, 31 Jan 2025 08:53:47 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tdrSq-0004Xs-Lc; Fri, 31 Jan 2025 08:53:46 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D7F41F38D;
 Fri, 31 Jan 2025 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738331620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SkDlXVZltxneLHkpjP0IQ5YhXaHIjYgPt5BhQKrBYf4=;
 b=HZxFZAHx0qist9+U8Loo3tZTt8xFuCgDGF5Cel/mWI+4wNbiJpQhniRrHNFxMKS90e1FHs
 E+LJn0plOBOumx+CJ6uzAJYUt+hpOC4b8frQ0L29t2/1AXbaJ9MjkzmCMKJTvELelwvCoa
 30sqL2+8I8w+Hskyl2WdJFilCSplIps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738331620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SkDlXVZltxneLHkpjP0IQ5YhXaHIjYgPt5BhQKrBYf4=;
 b=GhGMIoEoeoGy/W/+3POYGHq4J1vBSxUz4w5OLpDC4Ia4tEx2esOZYGIzBp7HXO6XA1uNWD
 aluvtgeWw3w0WhBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738331620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SkDlXVZltxneLHkpjP0IQ5YhXaHIjYgPt5BhQKrBYf4=;
 b=HZxFZAHx0qist9+U8Loo3tZTt8xFuCgDGF5Cel/mWI+4wNbiJpQhniRrHNFxMKS90e1FHs
 E+LJn0plOBOumx+CJ6uzAJYUt+hpOC4b8frQ0L29t2/1AXbaJ9MjkzmCMKJTvELelwvCoa
 30sqL2+8I8w+Hskyl2WdJFilCSplIps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738331620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SkDlXVZltxneLHkpjP0IQ5YhXaHIjYgPt5BhQKrBYf4=;
 b=GhGMIoEoeoGy/W/+3POYGHq4J1vBSxUz4w5OLpDC4Ia4tEx2esOZYGIzBp7HXO6XA1uNWD
 aluvtgeWw3w0WhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA562133A6;
 Fri, 31 Jan 2025 13:53:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U8cMGuPVnGc5bwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 Jan 2025 13:53:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/15] block: Managing inactive nodes (QSD migration)
In-Reply-To: <20250130171240.286878-1-kwolf@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
Date: Fri, 31 Jan 2025 10:53:36 -0300
Message-ID: <877c6bgkdb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Kevin Wolf <kwolf@redhat.com> writes:

> This series adds a mechanism that allows the user or management tool to
> manually activate and inactivate block nodes instead of fully relying on
> the automatic management in the migration code.
>
> One case where this is needed is for migration with shared storage and
> devices backed by qemu-storage-daemon, which as an external process is
> not involved in the VM migration. Management tools can manually
> orchestrate the handover in this scenario. The new qemu-iotests case
> qsd-migrate demonstrates this.
>
> There are other cases without qemu-storage-daemon where manual
> management is necessary. For example, after migration, the destination
> VM only activates images on 'cont', but after migrating a paused VM, the
> user may want to perform operations on a block node while the VM is
> still paused.
>
> This series adds support for block exports on an inactive node (needed
> for shared storage migration with qemu-storage-daemon) only to NBD.
> Adding it to other export types will be done in a future series.
>
> v2:
> - Added a comprehensive test case that tests how inactive nodes
>   interoperate with many operations
> - Added a couple of fixes for bugs uncovered by the tests (that would
>   usually lead to crashes when an unsupported operation is performed on
>   inactive nodes)
> - Added 'active' status to query-block information
>
> Kevin Wolf (15):
>   block: Add 'active' field to BlockDeviceInfo
>   block: Inactivate external snapshot overlays when necessary
>   migration/block-active: Remove global active flag
>   block: Don't attach inactive child to active node
>   block: Allow inactivating already inactive nodes
>   block: Fix crash on block_resize on inactive node
>   block: Add option to create inactive nodes
>   block: Add blockdev-set-active QMP command
>   block: Support inactive nodes in blk_insert_bs()
>   block/export: Don't ignore image activation error in blk_exp_add()
>   block/export: Add option to allow export of inactive nodes
>   nbd/server: Support inactive nodes
>   iotests: Add filter_qtest()
>   iotests: Add qsd-migrate case
>   iotests: Add (NBD-based) tests for inactive nodes
>
>  qapi/block-core.json                          |  44 ++-
>  qapi/block-export.json                        |  10 +-
>  include/block/block-common.h                  |   1 +
>  include/block/block-global-state.h            |   6 +
>  include/block/export.h                        |   3 +
>  migration/migration.h                         |   3 -
>  block.c                                       |  62 +++-
>  block/block-backend.c                         |  16 +-
>  block/export/export.c                         |  29 +-
>  block/monitor/block-hmp-cmds.c                |   5 +-
>  block/qapi.c                                  |   1 +
>  blockdev.c                                    |  48 +++
>  migration/block-active.c                      |  46 ---
>  migration/migration.c                         |   8 -
>  nbd/server.c                                  |  17 +
>  tests/qemu-iotests/iotests.py                 |   8 +
>  tests/qemu-iotests/041                        |   4 +-
>  tests/qemu-iotests/165                        |   4 +-
>  tests/qemu-iotests/184.out                    |   2 +
>  tests/qemu-iotests/191.out                    |  16 +
>  tests/qemu-iotests/273.out                    |   5 +
>  tests/qemu-iotests/tests/copy-before-write    |   3 +-
>  tests/qemu-iotests/tests/inactive-node-nbd    | 303 ++++++++++++++++++
>  .../qemu-iotests/tests/inactive-node-nbd.out  | 239 ++++++++++++++
>  tests/qemu-iotests/tests/migrate-bitmaps-test |   7 +-
>  tests/qemu-iotests/tests/qsd-migrate          | 132 ++++++++
>  tests/qemu-iotests/tests/qsd-migrate.out      |  51 +++
>  27 files changed, 986 insertions(+), 87 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/inactive-node-nbd
>  create mode 100644 tests/qemu-iotests/tests/inactive-node-nbd.out
>  create mode 100755 tests/qemu-iotests/tests/qsd-migrate
>  create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out

Series:

Acked-by: Fabiano Rosas <farosas@suse.de>

I checked that this series doesn't regress the original double
inactivate issue fixed by Peter Xu [1]. I also ported the tests[2] on
top of this and everything looks good. Thanks!

1- 8597af7615 (migration/block: Rewrite disk activation, 2024-12-06)
2- https://lore.kernel.org/r/20241125144612.16194-6-farosas@suse.de


