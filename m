Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B96C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwE9-0005AS-7V; Fri, 16 May 2025 10:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFwE7-000589-Dn
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:39:55 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFwE4-0001Fp-Kr
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:39:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B1BB1FB7F;
 Fri, 16 May 2025 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747406388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v1X0sHp2+4TkOzMF3Rr25JqVD/S5j8klCZDCruABgCk=;
 b=fx86EvgdmRRxoDzFhIKMj9DtnEFpb4T0GYa40W2JlhQSdwFCouQXcX+XEuEMTxWZIq7ZqS
 2oeq0qQEUcs67RcVMyWyVmURXmb1ajmlC+0ERr26IpBk4MsrndWxSbapt+RyY7vcu9/2rv
 esbXDrj2abe4LBYTWkGsdsSDe6q8UYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747406388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v1X0sHp2+4TkOzMF3Rr25JqVD/S5j8klCZDCruABgCk=;
 b=vhtzTmqZx3y4f7PLWjpxc6Z3r2Ix8+lJHgLtyENHf3sKPvY/B0cJHi33R9UylX75eSpKQt
 TMFUOeCulVjiDFBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747406388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v1X0sHp2+4TkOzMF3Rr25JqVD/S5j8klCZDCruABgCk=;
 b=fx86EvgdmRRxoDzFhIKMj9DtnEFpb4T0GYa40W2JlhQSdwFCouQXcX+XEuEMTxWZIq7ZqS
 2oeq0qQEUcs67RcVMyWyVmURXmb1ajmlC+0ERr26IpBk4MsrndWxSbapt+RyY7vcu9/2rv
 esbXDrj2abe4LBYTWkGsdsSDe6q8UYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747406388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v1X0sHp2+4TkOzMF3Rr25JqVD/S5j8klCZDCruABgCk=;
 b=vhtzTmqZx3y4f7PLWjpxc6Z3r2Ix8+lJHgLtyENHf3sKPvY/B0cJHi33R9UylX75eSpKQt
 TMFUOeCulVjiDFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F50F13411;
 Fri, 16 May 2025 14:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EY2uLzNOJ2h7UQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 16 May 2025 14:39:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration/multifd: Don't send device state packets with
 zerocopy flag
In-Reply-To: <3bd5f48578e29f3a78f41b1e4fbea3d4b2d9b136.1747403393.git.maciej.szmigiero@oracle.com>
References: <3bd5f48578e29f3a78f41b1e4fbea3d4b2d9b136.1747403393.git.maciej.szmigiero@oracle.com>
Date: Fri, 16 May 2025 11:39:45 -0300
Message-ID: <87a57c8vri.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.27 / 50.00]; BAYES_HAM(-2.97)[99.88%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> If zerocopy is enabled for multifd then QIO_CHANNEL_WRITE_FLAG_ZERO_COPY
> flag is forced into all multifd channel write calls via p->write_flags
> that was setup in multifd_nocomp_send_setup().
>
> However, device state packets aren't compatible with zerocopy - the data
> buffer isn't getting kept pinned until multifd channel flush.
>
> Make sure to mask that QIO_CHANNEL_WRITE_FLAG_ZERO_COPY flag in a multifd
> send thread if the data being sent is device state.
>
> Fixes: 0525b91a0b99 ("migration/multifd: Device state transfer support - send side")
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

