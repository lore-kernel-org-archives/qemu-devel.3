Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E385CC7112F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 20:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjPYu-0002Dm-Lz; Wed, 28 Aug 2024 16:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjPYt-0002Cw-Ql
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 16:46:39 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjPYr-00088m-T3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 16:46:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B16291FCED;
 Wed, 28 Aug 2024 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724877995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=81/z8Zfl1dHWyjKFibLNZgcZea2snU51dbL98IVRhY8=;
 b=cNzvP28p+jjPIZdDkQgd79NKFnOw7LffBEIydbOdHvo86LdBXPn97Zb758Us8NkcGsfX+V
 VsMcKcV/uTz2EaGCOqQCz4r6GXY1l1n0jcSekvZnpypTe1uO3FTgg2qW71NJZjyeWYQmst
 1wpW4ZTfRVZQFwXMO/E7d+/L49n/ZG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724877995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=81/z8Zfl1dHWyjKFibLNZgcZea2snU51dbL98IVRhY8=;
 b=uXNe6bcqbu0nfJBmt8ymv1fTZs0VCKFMg8P3Cjgw4QwmH5GYOqTFmoDzINd2ErqT0B3vu7
 p6s9MvtC4VYPFMAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724877995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=81/z8Zfl1dHWyjKFibLNZgcZea2snU51dbL98IVRhY8=;
 b=cNzvP28p+jjPIZdDkQgd79NKFnOw7LffBEIydbOdHvo86LdBXPn97Zb758Us8NkcGsfX+V
 VsMcKcV/uTz2EaGCOqQCz4r6GXY1l1n0jcSekvZnpypTe1uO3FTgg2qW71NJZjyeWYQmst
 1wpW4ZTfRVZQFwXMO/E7d+/L49n/ZG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724877995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=81/z8Zfl1dHWyjKFibLNZgcZea2snU51dbL98IVRhY8=;
 b=uXNe6bcqbu0nfJBmt8ymv1fTZs0VCKFMg8P3Cjgw4QwmH5GYOqTFmoDzINd2ErqT0B3vu7
 p6s9MvtC4VYPFMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F3001398F;
 Wed, 28 Aug 2024 20:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id optBOaqMz2ZcLQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Aug 2024 20:46:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/17] Multifd =?utf-8?Q?=F0=9F=94=80?= device state
 transfer support with VFIO consumer
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
Date: Wed, 28 Aug 2024 17:46:32 -0300
Message-ID: <87jzg0nzo7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.27 / 50.00]; BAYES_HAM(-2.97)[99.88%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.990]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> This is an updated v2 patch series of the v1 series located here:
> https://lore.kernel.org/qemu-devel/cover.1718717584.git.maciej.szmigiero@oracle.com/
>
> Changes from v1:
> * Extended the QEMU thread-pool with non-AIO (generic) pool support,
> implemented automatic memory management support for its work element
> function argument.
>
> * Introduced a multifd device state save thread pool, ported the VFIO
> multifd device state save implementation to use this thread pool instead
> of VFIO internally managed individual threads.
>
> * Re-implemented on top of Fabiano's v4 multifd sender refactor patch set from
> https://lore.kernel.org/qemu-devel/20240823173911.6712-1-farosas@suse.de/
>
> * Moved device state related multifd code to new multifd-device-state.c
> file where it made sense.
>
> * Implemented a max in-flight VFIO device state buffer count limit to
> allow capping the maximum recipient memory usage.
>
> * Removed unnecessary explicit memory barriers from multifd_send().
>
> * A few small changes like updated comments, code formatting,
> fixed zero-copy RAM multifd bytes transferred counter under-counting, etc.
>
>
> For convenience, this patch set is also available as a git tree:
> https://github.com/maciejsszmigiero/qemu/tree/multifd-device-state-transfer-vfio

With this branch I'm getting:

$ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p /x86_64/migration/multifd/tcp/uri/plain/none
...
qemu-system-x86_64: ../util/thread-pool.c:354: thread_pool_set_minmax_threads: Assertion `max_threads > 0' failed.
Broken pipe


$ ./tests/qemu-iotests/check -p -qcow2 068
...
+qemu-system-x86_64: ../util/qemu-thread-posix.c:92: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.


