Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14231C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 18:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txruc-0008CD-3J; Thu, 27 Mar 2025 14:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txrts-00085n-Qr
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:24:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txrtq-0003VO-LD
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:24:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1743B211A2;
 Thu, 27 Mar 2025 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743099856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNw6SrwpQluiqkqX+Zc1FGZ14KLBocgX2ww8ZI1nhbs=;
 b=OOvsjq/+9GWkHAZ3UodYC9Yx1uBMvU0aSNHD37vZeNmtGEfS/xDjPHaVHPP9TWuQhKnjAL
 DHka79XAylyO1UBMdrqbwIcAH8++yz8z6V65yfefqzAegQ+JpAgCNIirY2EJjv77WQEOOs
 JJxbvbpVksyUrf5juNM7bgw7i79OafQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743099856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNw6SrwpQluiqkqX+Zc1FGZ14KLBocgX2ww8ZI1nhbs=;
 b=UYI/Bi890IkjEutljeTGNzdFe970Paqs8+418hCS1yXmKJJ8T1SGoDjVmlxNbGI+YEvdXL
 PbpRAJXFGyLo0iBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OOvsjq/+";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="UYI/Bi89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743099856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNw6SrwpQluiqkqX+Zc1FGZ14KLBocgX2ww8ZI1nhbs=;
 b=OOvsjq/+9GWkHAZ3UodYC9Yx1uBMvU0aSNHD37vZeNmtGEfS/xDjPHaVHPP9TWuQhKnjAL
 DHka79XAylyO1UBMdrqbwIcAH8++yz8z6V65yfefqzAegQ+JpAgCNIirY2EJjv77WQEOOs
 JJxbvbpVksyUrf5juNM7bgw7i79OafQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743099856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNw6SrwpQluiqkqX+Zc1FGZ14KLBocgX2ww8ZI1nhbs=;
 b=UYI/Bi890IkjEutljeTGNzdFe970Paqs8+418hCS1yXmKJJ8T1SGoDjVmlxNbGI+YEvdXL
 PbpRAJXFGyLo0iBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 843A1139D4;
 Thu, 27 Mar 2025 18:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M+SpEM+X5WeVKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 18:24:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V2] migration: cpr breaks SNP guest
In-Reply-To: <1743087130-429075-1-git-send-email-steven.sistare@oracle.com>
References: <1743087130-429075-1-git-send-email-steven.sistare@oracle.com>
Date: Thu, 27 Mar 2025 15:24:12 -0300
Message-ID: <878qoqmiwj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 1743B211A2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Steve Sistare <steven.sistare@oracle.com> writes:

> With aux-ram-share=off, booting an SNP guest fails with:
>
>   ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.
>
> This is because a CPR blocker for the guest_memfd ramblock is added
> twice, once in ram_block_add_cpr_blocker because aux-ram-share=off so
> rb->fd < 0, and once in ram_block_add for a specific guest_memfd blocker.
>
> To fix, add the guest_memfd blocker iff a generic one would not be
> added by ram_block_add_cpr_blocker.
>
> Fixes: 094a3dbc55df ("migration: ram block cpr blockers")
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reported-by: Michael Roth <michael.roth@amd.com>
> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Queued, thanks!

