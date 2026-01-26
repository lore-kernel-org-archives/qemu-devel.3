Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284F4D1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUhY-00038O-0z; Mon, 26 Jan 2026 17:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkUhW-000388-1v
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:04:50 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkUhT-0000i5-R0
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:04:49 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A989B5BCDE;
 Mon, 26 Jan 2026 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769465081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXJ1LeH1+PcjoNqOxgBQB2g3Iw2nswPWI0u564bKdpY=;
 b=vhS0SwUg86kaMowaUkk11j8Kw5Ipv7cRm5+CFPyLCddy/i+ViyOSZiq8gOQLw5IFh6Y7y9
 vod70WgLFHUYAmqySozTo6gyf6AKRB4zPA4h26kVmESv0Tfp3ZJBrqlMHw2Au6DHyGBmBC
 FIgxUpHN0wH+ARn8+awiPsBd/iaKb6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769465081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXJ1LeH1+PcjoNqOxgBQB2g3Iw2nswPWI0u564bKdpY=;
 b=9sTJTrOFDsE/iJD4aDfqXq7DxqYHB1eANlkzV9E5Ga7yQVhCQRbrdwe88FHH2wIlpgjdAP
 r4RuhE1l7NVLsXCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769465081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXJ1LeH1+PcjoNqOxgBQB2g3Iw2nswPWI0u564bKdpY=;
 b=vhS0SwUg86kaMowaUkk11j8Kw5Ipv7cRm5+CFPyLCddy/i+ViyOSZiq8gOQLw5IFh6Y7y9
 vod70WgLFHUYAmqySozTo6gyf6AKRB4zPA4h26kVmESv0Tfp3ZJBrqlMHw2Au6DHyGBmBC
 FIgxUpHN0wH+ARn8+awiPsBd/iaKb6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769465081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXJ1LeH1+PcjoNqOxgBQB2g3Iw2nswPWI0u564bKdpY=;
 b=9sTJTrOFDsE/iJD4aDfqXq7DxqYHB1eANlkzV9E5Ga7yQVhCQRbrdwe88FHH2wIlpgjdAP
 r4RuhE1l7NVLsXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C248139F0;
 Mon, 26 Jan 2026 22:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5eFVM/jkd2naYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Jan 2026 22:04:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 0/5] migration: Notifier fixes for 11.0
In-Reply-To: <20260126213614.3815900-1-peterx@redhat.com>
References: <20260126213614.3815900-1-peterx@redhat.com>
Date: Mon, 26 Jan 2026 19:04:38 -0300
Message-ID: <87y0lkf2tl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> CI: https://gitlab.com/peterx/qemu/-/pipelines/2287309287
>
> v2:
> - Collected r-bs / a-bs
> - Patch 2: update comment for possible sequence of notifies [Fabiano]
>
> v1: https://lore.kernel.org/r/20260122230331.3543312-1-peterx@redhat.com
>
> Two major goals for this small series:
>
> - Fix postcopy issue where DONE and FAILED notifiers will be invoked twice
>
> - Move FAILED notifier to be before vm_start() if the failure happens
>   during switchover (where we will stop the VM first)
>
> The 2nd goal will be needed by Stefan's ongoing work on block persistent
> reservations, where a fallback should be required on src to happen before
> vm_start().  Instead of introducing another FAILED_BEFORE_START, this
> patchset should make FAILED work instead.
>
> Patch 1 adds a tracepoint for me to verify this fix.
>
> Patch 2-3 are the real changes of above two.
>
> Patch 3-4 are some cleanups alone the context that we can do, hence
> attached at the end.
>
> More details in commit logs individually.  Comments welcomed, thanks.
>
> Peter Xu (5):
>   migration: Add a tracepoint for invoking migration notifiers
>   migration: Fix double notification of DONE/FAIL for postcopy
>   migration: Notify migration FAILED before starting VM
>   migration: Drop explicit block activation in postcopy fail path
>   migration: Rename MIG_EVENT_PRECOPY_* to MIG_EVENT_*
>
>  include/migration/misc.h | 20 ++++++++++++--------
>  hw/intc/arm_gicv3_kvm.c  |  2 +-
>  hw/net/virtio-net.c      |  4 ++--
>  hw/vfio/cpr-legacy.c     |  2 +-
>  hw/vfio/cpr.c            |  8 ++++----
>  hw/vfio/migration.c      |  4 ++--
>  migration/cpr-exec.c     |  6 +++---
>  migration/migration.c    | 29 ++++++++++++++++++++---------
>  net/vhost-vdpa.c         |  4 ++--
>  ui/spice-core.c          |  7 ++++---
>  migration/trace-events   |  1 +
>  11 files changed, 52 insertions(+), 35 deletions(-)

Queued, let me know if you want to change patch 2.

