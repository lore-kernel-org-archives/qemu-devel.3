Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB13C636F0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 19:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjNwx-0003mK-8c; Wed, 28 Aug 2024 15:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjNwu-0003ll-Vt
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 15:03:21 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjNwt-000546-Cs
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 15:03:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C10EC1FCE6;
 Wed, 28 Aug 2024 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724871797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwxNkd0Cno/3RjrynRaEritiTNdjNphErc/KQM//Rv4=;
 b=ZyLDwz7y+IxLJwfrh6OIdv2JdHLm9djmlJuA3nCFKYqNsVHWNRn1wJzsep4VDtAnr6FVL9
 LIEUZTOGYlAeCu+ASBMbIHk4XzietzPYbqTOjsT7tEO9lvspoRru+iKHXq+3TirZz5aoOo
 giHFsL6YAKBbglZGDP9PlslrHjQ9F5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724871797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwxNkd0Cno/3RjrynRaEritiTNdjNphErc/KQM//Rv4=;
 b=LYAAiEh5spghYQ7o1O301zgzYJJdUOBszoFFMYGetUgK0aoEcfSl99ydmxXzlOzmjyZlU6
 k7sRC5QCGFRxk6Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZyLDwz7y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LYAAiEh5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724871797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwxNkd0Cno/3RjrynRaEritiTNdjNphErc/KQM//Rv4=;
 b=ZyLDwz7y+IxLJwfrh6OIdv2JdHLm9djmlJuA3nCFKYqNsVHWNRn1wJzsep4VDtAnr6FVL9
 LIEUZTOGYlAeCu+ASBMbIHk4XzietzPYbqTOjsT7tEO9lvspoRru+iKHXq+3TirZz5aoOo
 giHFsL6YAKBbglZGDP9PlslrHjQ9F5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724871797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwxNkd0Cno/3RjrynRaEritiTNdjNphErc/KQM//Rv4=;
 b=LYAAiEh5spghYQ7o1O301zgzYJJdUOBszoFFMYGetUgK0aoEcfSl99ydmxXzlOzmjyZlU6
 k7sRC5QCGFRxk6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3667B1398F;
 Wed, 28 Aug 2024 19:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FblnO3R0z2bDEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Aug 2024 19:03:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/17] migration: Add
 save_live_complete_precopy_{begin,end} handlers
In-Reply-To: <afe0bc649007593edaa77f5f3923acb733a24c6a.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <afe0bc649007593edaa77f5f3923acb733a24c6a.1724701542.git.maciej.szmigiero@oracle.com>
Date: Wed, 28 Aug 2024 16:03:14 -0300
Message-ID: <87o75co4gd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C10EC1FCE6
X-Spamd-Result: default: False [-1.67 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; BAYES_HAM(-0.16)[69.39%];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,oracle.com:email,szmigiero.name:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
> These SaveVMHandlers help device provide its own asynchronous
> transmission of the remaining data at the end of a precopy phase.
>
> In this use case the save_live_complete_precopy_begin handler might
> be used to mark the stream boundary before proceeding with asynchronous
> transmission of the remaining data while the
> save_live_complete_precopy_end handler might be used to mark the
> stream boundary after performing the asynchronous transmission.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

