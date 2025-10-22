Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25C1CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 13:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZ66-0003ig-NJ; Wed, 22 Oct 2025 09:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBZ62-0003iG-Iv
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:41:46 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBZ60-0007f6-Rq
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:41:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A855D211B0;
 Wed, 22 Oct 2025 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761140496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=peGN2N1aZwSPEvZPdVjIAxOcktRwXsLvSrX4IfnhDZg=;
 b=o8ciQvlrFZXknGc7S6CTUz5g5u2WcQ/wa6MrT4EOCoVtLu15+YyhPZqUmIA3Ki0WW4+tQ2
 1VTiQ2V9kE5PkHUhBpbPwIWDDAlV0h/ourrDdOf7XHhq+RxYmN6+aGli4CSTDHuNrXQAHG
 x5MWRGTg4O7M+CjDIYQMM+0LCpDn/M8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761140496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=peGN2N1aZwSPEvZPdVjIAxOcktRwXsLvSrX4IfnhDZg=;
 b=1SjGnzjnbJZyFTFzFx8M98sbzFM7F0rfAuUQlKInZQGEblqSq6cn1OKsMsrSL0qVLB4ECB
 Y579jSox+C8MTMBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FUR1h7Vf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sNd5dV1j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761140492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=peGN2N1aZwSPEvZPdVjIAxOcktRwXsLvSrX4IfnhDZg=;
 b=FUR1h7VfPBdcoxdspXsmYMXV4glXH+PwhYBNbo7I7eBkDjTAknSDMKs2eRt7RdJkfmTQwt
 w7vYg2sqIKGtY1bBeQk+Cu9cuUOl7/sXN5Knf7Lujoh8tRhpNf53bycGUY8MZ4hzCdagjR
 FWNl4s93yh/QazpmmkxQUlFPEvxv6j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761140492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=peGN2N1aZwSPEvZPdVjIAxOcktRwXsLvSrX4IfnhDZg=;
 b=sNd5dV1jMCZ19bP1YsirkdApwTLVrt5m5x/N8wlEDyt42hzzvaEcFi+iMNxzVEvpsOWgsX
 fTzhQJFjKZmYGIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26DAA1339F;
 Wed, 22 Oct 2025 13:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1jL6NQvf+GikdAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Oct 2025 13:41:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Arun Menon <armenon@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>
Subject: Re: [PATCH 2/3] migration/cpr: Fix coverity report in
 cpr_exec_persist_state()
In-Reply-To: <aPjTSkQHHCdSdiFv@x1.local>
References: <20251021184132.2635958-1-peterx@redhat.com>
 <20251021184132.2635958-3-peterx@redhat.com> <87o6q0t1z0.fsf@suse.de>
 <aPf7R-F0uv1RSqXh@x1.local> <87frbbt98m.fsf@suse.de>
 <aPjTSkQHHCdSdiFv@x1.local>
Date: Wed, 22 Oct 2025 10:41:29 -0300
Message-ID: <874irrt5o6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A855D211B0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Wed, Oct 22, 2025 at 09:24:25AM -0300, Fabiano Rosas wrote:
>> Remember to copy Oracle folks.
>
> Do you know who's taking this over from Steve?  If we know, we should
> update the MAINTAINERS file.

I'm not sure about maintainership but I'd be already glad to get testing
and reviews. Steve mentioned Mark Kanda on his email. I'm CCing Mark
here and he can tell us about it. =) No pressure, just making sure CPR
work is not falling between the cracks really.

