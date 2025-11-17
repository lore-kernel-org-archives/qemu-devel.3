Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F8ECEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1VJ-00046f-3g; Mon, 17 Nov 2025 10:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vL1VF-000416-Ly
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:53 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vL1VE-0008Jt-5g
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EADE211C4;
 Mon, 17 Nov 2025 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763394650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXAPh18vI7HzW726G2z85BEmaXGSSASnPcMI+fjlSPk=;
 b=DEk0nyXwuu3sVxgo0upgdxebOGw1Y1RuF0E5YVdRU4/KdqPEhh1/4CfMk4R90Yafo47Mu/
 cW9vo5c1+8GFKS92/FJMxNHkLQT2stb6VDxcEseFMjSXWD1Xld1NAq/4lqPUVa9wcMriIc
 IDhP8i/uUwGrVCC/rOsbssE/pOZkgOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763394650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXAPh18vI7HzW726G2z85BEmaXGSSASnPcMI+fjlSPk=;
 b=yjFnkvbViwEsY2CZHA2PQYRZu16CBdWU2j3QCmtaoIBsrhQ/Rxl/1u+SyYlefbJt2dq6TE
 KC4tGsUjQBzQIVDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0oY6Caa4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h8dZZms6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763394649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXAPh18vI7HzW726G2z85BEmaXGSSASnPcMI+fjlSPk=;
 b=0oY6Caa4azy+1MO3pXkOJ/NacTeqUPdmc+A2nM0iD3drMgMCV5zXSb44iLhKaR+LUvryQl
 AazSGWRt3ApJhdlof9W+cTorhhNyaIvvAJU9oTRUIWpkEqSdciHP2M8HJBYn2Vj/Cimslp
 oucgkZZQfrFuxt3/WiRukvoNeNbDnGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763394649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXAPh18vI7HzW726G2z85BEmaXGSSASnPcMI+fjlSPk=;
 b=h8dZZms6NApWkHCudNx8SNJEqCzYTguvYllxlwYZdv79vS1rWUxPNpdSHRZ2UoaAUiaAzt
 MZVDomH6UYLfzZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CDF03EA61;
 Mon, 17 Nov 2025 15:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CY2mM1hEG2lCfwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Nov 2025 15:50:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH 3/3] migration/postcopy-ram: Improve error reporting
 after loadvm failure
In-Reply-To: <20251115083500.2753895-4-armbru@redhat.com>
References: <20251115083500.2753895-1-armbru@redhat.com>
 <20251115083500.2753895-4-armbru@redhat.com>
Date: Mon, 17 Nov 2025 12:50:46 -0300
Message-ID: <87zf8kbquh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9EADE211C4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.41 / 50.00]; BAYES_HAM(-2.90)[99.57%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:mid, suse.de:dkim]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Markus Armbruster <armbru@redhat.com> writes:

> One of two error messages show __func__.  Drop it; it doesn't help
> users, and developers can grep for the message.  This also permits
> de-duplicating the code to prepend to the error message.
>
> Both error messages show a numeric error code.  I doubt that's
> helpful, but I'm leaving it alone.
>
> Use error_append_hint() for explaining that some dirty bitmaps may be
> lost.  Polish the prose.
>
> Don't faff around with g_clear_pointer(), it's not worth its keep
> here.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

