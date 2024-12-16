Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60641E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCk4-0008Q5-EJ; Mon, 16 Dec 2024 10:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNCk1-0008Po-Vs; Mon, 16 Dec 2024 10:10:38 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNCk0-0007Xu-8M; Mon, 16 Dec 2024 10:10:37 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F11A1F37E;
 Mon, 16 Dec 2024 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734361832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2s3zaW5SfPkzLlPhHYwpTTuN8ANpdkY0Kay9cEeCacc=;
 b=nhkll28cMVK0oMXaRR2lKvaIBlj9lB4Sxm/5EqzRiQN1ppkj4RTilR+Vwy+he1SM9vgQpg
 XVRUkoOTvX01Kb/WetYHvUAGN6K2sWGNs9dqm7ZXdek3feQb9DKCiTWxgx4J8F1sxAhtFx
 UDKb0r/X9+kmZCeGeTyh72u1oyaoNLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734361832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2s3zaW5SfPkzLlPhHYwpTTuN8ANpdkY0Kay9cEeCacc=;
 b=fMvV5B59xJ57geBsEqqe/zN3beYwmz/tbd4W3FoH+rZus7IkKvR1agouAZsXwo59wScm+5
 Tg8oYBvggm6nZyBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734361832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2s3zaW5SfPkzLlPhHYwpTTuN8ANpdkY0Kay9cEeCacc=;
 b=nhkll28cMVK0oMXaRR2lKvaIBlj9lB4Sxm/5EqzRiQN1ppkj4RTilR+Vwy+he1SM9vgQpg
 XVRUkoOTvX01Kb/WetYHvUAGN6K2sWGNs9dqm7ZXdek3feQb9DKCiTWxgx4J8F1sxAhtFx
 UDKb0r/X9+kmZCeGeTyh72u1oyaoNLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734361832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2s3zaW5SfPkzLlPhHYwpTTuN8ANpdkY0Kay9cEeCacc=;
 b=fMvV5B59xJ57geBsEqqe/zN3beYwmz/tbd4W3FoH+rZus7IkKvR1agouAZsXwo59wScm+5
 Tg8oYBvggm6nZyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82DEF13418;
 Mon, 16 Dec 2024 15:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6yf1EedCYGeeEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Dec 2024 15:10:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Andrey
 Drobyshev <andrey.drobyshev@virtuozzo.com>, Eric Blake
 <eblake@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin
 Wolf <kwolf@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/6] qmp/cont: Only activate disks if migration
 completed
In-Reply-To: <20241206230838.1111496-3-peterx@redhat.com>
References: <20241206230838.1111496-1-peterx@redhat.com>
 <20241206230838.1111496-3-peterx@redhat.com>
Date: Mon, 16 Dec 2024 12:10:28 -0300
Message-ID: <877c7zy87v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.66 / 50.00]; BAYES_HAM(-2.86)[99.41%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[12]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> As the comment says, the activation of disks is for the case where
> migration has completed, rather than when QEMU is still during
> migration (RUN_STATE_INMIGRATE).
>
> Move the code over to reflect what the comment is describing.
>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

