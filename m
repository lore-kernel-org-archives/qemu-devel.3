Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA78E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJbes-0004lo-OI; Fri, 06 Dec 2024 11:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJber-0004lf-NZ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:58:25 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJbeq-0003Xy-8X
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:58:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C8F61F38D;
 Fri,  6 Dec 2024 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733504301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGq/6wjNmUsgXA8KvKQuN/KoqQJ2HjNndWrpn7iyvaw=;
 b=bn3LIvXJP10du5WArD5Yeb6yxrbnIk2m6MAPgHsaoHNfAUCmZcjIs5Iwfpi/Z9MtFCplB0
 tqtEGlUEbFBqyhnoqTyAHVH8TXLfrEBmP0tbAoomcj1pKAvTCmcZ/fhu2z4AaYW8a2sLfP
 TGMPcyMELDKubc+nRKhuhiAVTIcY2sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733504301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGq/6wjNmUsgXA8KvKQuN/KoqQJ2HjNndWrpn7iyvaw=;
 b=xShcVdH5p3d1LYEq6G8GuFHD+rCKFDi5QpoFmRRDs+J5bb64BOO/gsXSa6RBWWDRgtHJnh
 NAuOJ5h3UEWk+SBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bn3LIvXJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xShcVdH5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733504301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGq/6wjNmUsgXA8KvKQuN/KoqQJ2HjNndWrpn7iyvaw=;
 b=bn3LIvXJP10du5WArD5Yeb6yxrbnIk2m6MAPgHsaoHNfAUCmZcjIs5Iwfpi/Z9MtFCplB0
 tqtEGlUEbFBqyhnoqTyAHVH8TXLfrEBmP0tbAoomcj1pKAvTCmcZ/fhu2z4AaYW8a2sLfP
 TGMPcyMELDKubc+nRKhuhiAVTIcY2sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733504301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGq/6wjNmUsgXA8KvKQuN/KoqQJ2HjNndWrpn7iyvaw=;
 b=xShcVdH5p3d1LYEq6G8GuFHD+rCKFDi5QpoFmRRDs+J5bb64BOO/gsXSa6RBWWDRgtHJnh
 NAuOJ5h3UEWk+SBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B843113647;
 Fri,  6 Dec 2024 16:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YuRfHywtU2dsFgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 16:58:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 3/7] migration/ram: Move RAM_SAVE_FLAG* into ram.h
In-Reply-To: <Z1McP5JSSMNAHGGk@x1n>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-4-peterx@redhat.com> <874j3hc4fw.fsf@suse.de>
 <Z1MSKpiMiPsidzJO@x1n> <87ldwsc0eh.fsf@suse.de> <Z1McP5JSSMNAHGGk@x1n>
Date: Fri, 06 Dec 2024 13:58:17 -0300
Message-ID: <87ikrwbvfa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 3C8F61F38D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> On Fri, Dec 06, 2024 at 12:10:46PM -0300, Fabiano Rosas wrote:
>> > Wanna me to add a comment for that in this patch?
>> 
>> Yes, please.
>
> When I did it, I also did a few other things:
>
>   - Rearranged the comment section, put all things together
>   - Remove RAM_SAVE_FLAG_ZERO directly
>   - Reindents
>
> The plan is to squash below diff in v3 post, feel free to comment before
> that.
>
> ===8<===
> From 593227f1b9e678418f5b99ac51525884fa0adfc6 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 6 Dec 2024 10:43:25 -0500
> Subject: [PATCH] fixup! migration/ram: Move RAM_SAVE_FLAG* into ram.h
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

LGTM


