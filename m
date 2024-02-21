Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD3EC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoX8-0002NV-S3; Wed, 21 Feb 2024 10:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcoOh-00031g-3R
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:20:37 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcn45-0004ZM-AV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:55:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E52C622215;
 Wed, 21 Feb 2024 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708523711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3R3voEcqQsH8I82vTjHH785Oy/T6sRnWXadVuBifyc=;
 b=ua4hQrirzkbKKri4TO1gYFim1I1ZYwPWmsU4ZV3J3f8cImqYyEpUaaiUwv0/pTyZjYqsqU
 c/gk+w25hgjHd4aTJCl1QEJ52xi5WrxAjwj75OQE+779pWUGpO6VbqURxZ0tDcMZQPbHjq
 bxNI3kJTwxrAZf/Bfio8pHUYPU3Tmc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708523711;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3R3voEcqQsH8I82vTjHH785Oy/T6sRnWXadVuBifyc=;
 b=8G+zoAv77J2+FAVRh7o6x05bq4ZN6qKiXhknIqm4aQOimc/GY/U0MIwdoNUURzgzU83Yu1
 LLI3bT5QXHog3dAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708523709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3R3voEcqQsH8I82vTjHH785Oy/T6sRnWXadVuBifyc=;
 b=kjcQtxgTYIh1ulPBLShyZnlZOnPv86qHs+mzroRPGZLp45CLBhZ8az/kQLrgRjpMArJtC7
 egM7QTwJ5n6FUTOs0icyRWjBH36q2hNgucK4wDLAj7scf2t2zanlcTAqBD7H7FybD9DC6n
 uUHWLW+eaIrF0kFu88eJgnq3/XogAmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708523709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3R3voEcqQsH8I82vTjHH785Oy/T6sRnWXadVuBifyc=;
 b=/vMmA+ESVRZrvcJmwM02zrV5F/47rhqk6VVF6jG9Wef9I8UoZgnC7d+kSlJwFE8lbyWZPg
 ZX3pBzRW40kwdECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F6C913A69;
 Wed, 21 Feb 2024 13:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8dGcDb0A1mXaeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 13:55:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V4 5/5] migration: simplify exec migration functions
In-Reply-To: <1705099758-211963-6-git-send-email-steven.sistare@oracle.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-6-git-send-email-steven.sistare@oracle.com>
Date: Wed, 21 Feb 2024 10:55:06 -0300
Message-ID: <87msrtc479.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kjcQtxgT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/vMmA+ES"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.33 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-2.82)[99.24%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,oracle.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: E52C622215
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Simplify the exec migration code by using list utility functions.
>
> As a side effect, this also fixes a minor memory leak.  On function return,
> "g_auto(GStrv) argv" frees argv and each element, which is wrong, because
> the function does not own the individual elements.  To compensate, the code
> uses g_steal_pointer which NULLs argv and prevents the destructor from
> running, but argv is leaked.
>
> Fixes: cbab4face57b ("migration: convert exec backend ...")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

