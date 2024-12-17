Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122A4E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZT3-0000qg-Oq; Tue, 17 Dec 2024 10:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNZT1-0000qF-Jz
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:26:35 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNZSz-00057M-TF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:26:35 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D4211F392;
 Tue, 17 Dec 2024 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734449188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZDB3fcFVU4129eajeeMY2oMjHdmlUIrEBkrQ99A6cU=;
 b=F0n+RaPa8+cviV23Yy4KZQDYzVfn6qKkky5Vz45O4KSVKtea8LO7/zjnt24o2rjQ6VyRFJ
 dbrRToFOsyPjZrCzh0kZ5/WOgE1YBlYQS+c+QAJ+guYsYK7XXZsn4EzJTmAZsCuLpzpUFF
 3IoOlxH7TR8dCMgc70+QmuZuEeJ5Zsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734449188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZDB3fcFVU4129eajeeMY2oMjHdmlUIrEBkrQ99A6cU=;
 b=IlAy/kG5YjYY+SeLVVM18uQKEWa3wiiLMZXFtzQMg/hPRop7XQkkhvwbVEHNX0o0L9sdJe
 XBauNt0Iiefa93CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734449188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZDB3fcFVU4129eajeeMY2oMjHdmlUIrEBkrQ99A6cU=;
 b=F0n+RaPa8+cviV23Yy4KZQDYzVfn6qKkky5Vz45O4KSVKtea8LO7/zjnt24o2rjQ6VyRFJ
 dbrRToFOsyPjZrCzh0kZ5/WOgE1YBlYQS+c+QAJ+guYsYK7XXZsn4EzJTmAZsCuLpzpUFF
 3IoOlxH7TR8dCMgc70+QmuZuEeJ5Zsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734449188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZDB3fcFVU4129eajeeMY2oMjHdmlUIrEBkrQ99A6cU=;
 b=IlAy/kG5YjYY+SeLVVM18uQKEWa3wiiLMZXFtzQMg/hPRop7XQkkhvwbVEHNX0o0L9sdJe
 XBauNt0Iiefa93CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 122F1132EA;
 Tue, 17 Dec 2024 15:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QMU+MiOYYWfdIwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 15:26:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>
Subject: Re: [PATCH v3 0/7] migration/multifd: Some VFIO / postcopy
 preparations on flush
In-Reply-To: <20241206224755.1108686-1-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
Date: Tue, 17 Dec 2024 12:26:25 -0300
Message-ID: <87jzbywcta.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> CI: https://gitlab.com/peterx/qemu/-/pipelines/1577280033
>  (note: it's a pipeline of two patchsets, to save CI credits and time)
>
> v1: https://lore.kernel.org/r/20241205185303.897010-1-peterx@redhat.com
> v2: https://lore.kernel.org/r/20241206005834.1050905-1-peterx@redhat.com
>
> v3 changelog:
> - R-bs collected
> - Update commit message of patch 1 [Fabiano]
> - English updates [Fabiano]
> - Update comment for MULTIFD_SYNC_ALL [Fabiano]
> - In multifd_send_sync_main(), assert on req type [Fabiano]
> - Some more comments and cleanup for RAM_SAVE_FLAG_* movement [Fabiano]
> - Update the last document patch [Fabiano]
>
> This series provides some changes that may be helpful for either VFIO or
> postcopy integration on top of multifd.
>
> For VFIO, only patches 1 & 2 are relevant.
>
> For postcopy, it's about patches 3-7, but it needs to be based on 1+2
> because of a context dependency.
>
> All these patches can be seen as cleanups / slight optimizations on top of
> master branch with/without the VFIO/postcopy work.
>
> Besides CI, qtests, and some real-world multifd tests just to monitor the
> sync events happen all correct, I made sure to cover 7.2 machine type
> (which uses the legacy sync) so it still works as before - basically sync
> will be more frequent, but all thing keeps working smoothly so far.
>
> Thanks,
>
> Peter Xu (7):
>   migration/multifd: Further remove the SYNC on complete
>   migration/multifd: Allow to sync with sender threads only
>   migration/ram: Move RAM_SAVE_FLAG* into ram.h
>   migration/multifd: Unify RAM_SAVE_FLAG_MULTIFD_FLUSH messages
>   migration/multifd: Remove sync processing on postcopy
>   migration/multifd: Cleanup src flushes on condition check
>   migration/multifd: Document the reason to sync for save_setup()
>
>  migration/multifd.h        | 27 ++++++++++--
>  migration/ram.h            | 28 ++++++++++++
>  migration/rdma.h           |  7 ---
>  migration/multifd-nocomp.c | 74 ++++++++++++++++++++++++++++++-
>  migration/multifd.c        | 17 +++++---
>  migration/ram.c            | 89 +++++++++++++++++---------------------
>  6 files changed, 173 insertions(+), 69 deletions(-)

Queued, thanks!

