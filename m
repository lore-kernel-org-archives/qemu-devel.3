Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C281D17141
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 22:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t30ZK-0004Cf-KR; Mon, 21 Oct 2024 18:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t30ZI-0004CL-SL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 18:08:04 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t30ZH-0008Bb-4s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 18:08:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78D231F838;
 Mon, 21 Oct 2024 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729548479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2PfJ26vcdtwx/dWHpiPVsgKUwmYuENFE9ikx44MUGM=;
 b=FOJ7DIw5Ma171NncIp3o3qmDhcPs/g/3SOL7dbVWbbVFYQYYO3q+R39vQ93EboiVlGqsTy
 J9c26isVrBQfhKPIdyYbuTnbMrAHCuSM3ahLzn8qmniW0pT9kU9n23oH0Yxv/l9fz+6x5G
 3mLvnrlmOyYOwcIGEl3VW482q7Gg14I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729548479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2PfJ26vcdtwx/dWHpiPVsgKUwmYuENFE9ikx44MUGM=;
 b=l1FlwuJEsxpxtbjLaB6fKO3r6+geJo7RReMELLDxUkxyr4vKOPMr8pLu37cXoiYIcL60e7
 kvfrgiejPRb2gCAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729548478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2PfJ26vcdtwx/dWHpiPVsgKUwmYuENFE9ikx44MUGM=;
 b=ccob0h0cTs4xwWOcWIgyUzfEfCBAv4NfOr324Yj4CsHt36xM/H03BOvOMUPObAEyMfH38y
 n7mdc3KEAI4egDdMnmaXCkHft272qo3LpVSAaiE9k+UvOzgmijrrIMGgGy6jYzt4lkJJdR
 Nc2TAgonGvFonnQt/mx5P/4D5POeOFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729548478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2PfJ26vcdtwx/dWHpiPVsgKUwmYuENFE9ikx44MUGM=;
 b=8ZNAtHnpvDIo9f+7+jJ7qwvbB373Yu+OT9q91SpGK6KhpKsAL//k0Ou18Z+iQR/3C1rKYY
 HeVqI9RfhCSevoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3E3C139E0;
 Mon, 21 Oct 2024 22:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XGQnLr3QFmcSXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Oct 2024 22:07:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, Juraj Marcin
 <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>, =?utf-8?Q?Danie?=
 =?utf-8?Q?l_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Julia Suvorova <jusual@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH] migration: Deprecate query-migrationthreads command
In-Reply-To: <20241021215220.982325-1-peterx@redhat.com>
References: <20241021215220.982325-1-peterx@redhat.com>
Date: Mon, 21 Oct 2024 19:07:55 -0300
Message-ID: <87y12hcdok.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> Per previous discussion [1,2], this patch deprecates query-migrationthreads
> command.
>
> To summarize, the major reason of the deprecation is due to no sensible way
> to consume the API properly:
>
>   (1) The reported list of threads are incomplete (ignoring destination
>       threads and non-multifd threads).
>
>   (2) For CPU pinning, there's no way to properly pin the threads with
>       the API if the threads will start running right away after migration
>       threads can be queried, so the threads will always run on the default
>       cores for a short window.
>
>   (3) For VM debugging, one can use "-name $VM,debug-threads=on" instead,
>       which will provide proper names for all migration threads.
>
> [1] https://lore.kernel.org/r/20240930195837.825728-1-peterx@redhat.com
> [2] https://lore.kernel.org/r/20241011153417.516715-1-peterx@redhat.com
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

