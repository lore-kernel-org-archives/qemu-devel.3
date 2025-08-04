Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52FDC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0nk-0008Lm-Ss; Mon, 04 Aug 2025 15:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uizgs-0008D7-JR
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:13:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uizgq-0003XI-Eg
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:13:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A113E1F453;
 Mon,  4 Aug 2025 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754331217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EqJVgEGFDiLUPbSN+tynGh/c+ux8oy/JnUixkoJJu4=;
 b=ODhK3HDTgR6EoSHEc9TfFR3uhWtVVfj65TpIlWoi6AVrLJv56Giu6hPCLHWkvAk1n32R2T
 O3lRTrgqn6nr8zL1eK1ACvhr2W1uBbW3JIKgbW5gOjGhE+nwEtGkx2788fIyWKFLqrCD+j
 J/zhRg0sUhT4JgiXTZk3wKB0K2kvT+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754331217;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EqJVgEGFDiLUPbSN+tynGh/c+ux8oy/JnUixkoJJu4=;
 b=knax8t3VLzg6eKdw8aAGIQHHGRS3ZqUwahBPsXEnMhTheb/lFPS3LFHPKyvTwGjqi3yY9M
 Szubkap8h55jOdDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754331217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EqJVgEGFDiLUPbSN+tynGh/c+ux8oy/JnUixkoJJu4=;
 b=ODhK3HDTgR6EoSHEc9TfFR3uhWtVVfj65TpIlWoi6AVrLJv56Giu6hPCLHWkvAk1n32R2T
 O3lRTrgqn6nr8zL1eK1ACvhr2W1uBbW3JIKgbW5gOjGhE+nwEtGkx2788fIyWKFLqrCD+j
 J/zhRg0sUhT4JgiXTZk3wKB0K2kvT+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754331217;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EqJVgEGFDiLUPbSN+tynGh/c+ux8oy/JnUixkoJJu4=;
 b=knax8t3VLzg6eKdw8aAGIQHHGRS3ZqUwahBPsXEnMhTheb/lFPS3LFHPKyvTwGjqi3yY9M
 Szubkap8h55jOdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE32133D1;
 Mon,  4 Aug 2025 18:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5ZtvNFD4kGgfKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Aug 2025 18:13:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] migration: fix workaround for gnutls thread safety
In-Reply-To: <20250801170212.54409-3-berrange@redhat.com>
References: <20250801170212.54409-1-berrange@redhat.com>
 <20250801170212.54409-3-berrange@redhat.com>
Date: Mon, 04 Aug 2025 15:13:34 -0300
Message-ID: <87pldb2bw1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> In previous commits
>
>   eb3618e9 migration: activate TLS thread safety workaround
>   edea8183 io: add support for activating TLS thread safety workaround
>   24ad5e19 crypto: implement workaround for GNUTLS thread safety problems
>
> an attempt was made to workaround broken gnutls thread safety when
> TLS 1.3 rekeying is performed.
>
> Those patches acquired locks before calling gnutls_record_{send|recv}
> but temporarily dropped the locks in the push/pull functions, in the
> mistaken belief that there was a race inside gnutls that did not cross
> execution of the push/pull functions.
>
> A non-deterministic reproducer mislead into thinking the workaround
> was operating as expected, but this was wrong. Juraj demonstrated
> that QEMU would still see errors from GNUTLS as well as crashes.
>
> The issue is that a pointer to internal state is saved before the
> the push/pull functions are called, and after they return this
> saved pointer is potentially invalid. IOW, it is never safe to
> temporarily drop the mutexes inside the push/pull functions. The
> lock must be held throughout execution of gnutls_record_{send|recv}.
>
> This would be possible with QEMU migration, except that the return
> path thread sits in a blocking read waiting for data that very
> rarely arrives from the destination QEMU. This blocks ability to
> send any migration data in the other thread.
>
> It is possible to workaround this issue, however, by proactively
> calling poll() to check for available incoming data before trying
> the qio_channel_read() call.
>
> Reported-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

