Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7504CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqYUW-0003ii-RN; Fri, 07 Mar 2025 09:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqYUQ-0003fb-Bf
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:15:51 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqYUO-0007si-I9
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:15:50 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38AF921196;
 Fri,  7 Mar 2025 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741356944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40EqZFHMzTTXgMYXyjH28dAOUsUqjWExefczeC6h+ZQ=;
 b=hHhcdpEVvM2ysKqsQvODFmLkZrSE/G0IeHEO5Yc9cz3ebESOnHCa3cEsn0QqDSIu7EVsKN
 icAYUc4txPIOvhp2GKOCKwlkeMji+zz/moGnypVsJ0Bo7IAerfwzvSmjZVFcZ3E6lNPFYU
 b23UalOw2Q2s0tVqyZdkta043Rm7OmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741356944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40EqZFHMzTTXgMYXyjH28dAOUsUqjWExefczeC6h+ZQ=;
 b=hUqnBMZ6jtT30vUvOKr+yHgk5VwfDP24AHI8y+jxBl/x/4ysGnOJlJo1dCzFwKbH5+NgYd
 +hXo3MYk/fYmuTCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hHhcdpEV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hUqnBMZ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741356944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40EqZFHMzTTXgMYXyjH28dAOUsUqjWExefczeC6h+ZQ=;
 b=hHhcdpEVvM2ysKqsQvODFmLkZrSE/G0IeHEO5Yc9cz3ebESOnHCa3cEsn0QqDSIu7EVsKN
 icAYUc4txPIOvhp2GKOCKwlkeMji+zz/moGnypVsJ0Bo7IAerfwzvSmjZVFcZ3E6lNPFYU
 b23UalOw2Q2s0tVqyZdkta043Rm7OmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741356944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40EqZFHMzTTXgMYXyjH28dAOUsUqjWExefczeC6h+ZQ=;
 b=hUqnBMZ6jtT30vUvOKr+yHgk5VwfDP24AHI8y+jxBl/x/4ysGnOJlJo1dCzFwKbH5+NgYd
 +hXo3MYk/fYmuTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A54C213A22;
 Fri,  7 Mar 2025 14:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jqBpGI//ymcEKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 14:15:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Li Zhijian via <qemu-devel@nongnu.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v5 0/6] migration/rdma: fixes, refactor and cleanup
In-Reply-To: <20250305062825.772629-1-lizhijian@fujitsu.com>
References: <20250305062825.772629-1-lizhijian@fujitsu.com>
Date: Fri, 07 Mar 2025 11:15:40 -0300
Message-ID: <8734fpudtf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 38AF921196
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Li Zhijian via <qemu-devel@nongnu.org> writes:

> - It fix the RDMA migration broken issue
> - disable RDMA + postcopy
> - some cleanups
> - Add a qtest for RDMA at last
>
> Changes since V4:
>  - collect Reviewed-tags
>  - Address comments in patch "migration: Add qtest for migration over RDMA" from Fabiano Rosas <farosas@suse.de>
>
> Changes since V3:
> - check RDMA and capabilities are compatible on both sides # renamed from
>   previous V3's "migration: Add migration_capabilities_and_transport_compatible()"
>
> Changes since V2:
> - squash previous 2/3/4 to '[PATCH v3 5/6] migration: Unfold  control_save_page()'
> - reorder the patch layout to prevent recently added code from being deleted again.
> - collect Reviewed tags from Peter
>
> Changes since V1[0]:
> Add some saparate patches to refactor and cleanup based on V1
>
> [0] https://lore.kernel.org/qemu-devel/20250218074345.638203-1-lizhijian@fujitsu.com/
>
> Li Zhijian (6):
>   migration: Prioritize RDMA in ram_save_target_page()
>   migration: check RDMA and capabilities are compatible on both sides
>   migration: disable RDMA + postcopy-ram
>   migration/rdma: Remove redundant migration_in_postcopy checks
>   migration: Unfold control_save_page()
>   migration: Add qtest for migration over RDMA
>
>  MAINTAINERS                           |  1 +
>  migration/migration.c                 | 30 ++++++++----
>  migration/options.c                   | 25 ++++++++++
>  migration/options.h                   |  1 +
>  migration/ram.c                       | 41 +++++-----------
>  migration/rdma.c                      | 11 ++---
>  migration/rdma.h                      |  3 +-
>  scripts/rdma-migration-helper.sh      | 48 +++++++++++++++++++
>  tests/qtest/migration/precopy-tests.c | 67 +++++++++++++++++++++++++++
>  9 files changed, 178 insertions(+), 49 deletions(-)
>  create mode 100755 scripts/rdma-migration-helper.sh

Queued, thanks!

