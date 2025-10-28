Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF24CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 19:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDpl4-0000NG-AL; Tue, 28 Oct 2025 15:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vDpl1-0000N7-R4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 15:53:27 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vDpkq-00085N-Ry
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 15:53:27 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E750121A5D;
 Tue, 28 Oct 2025 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761681191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltWaN+wZkxgGLLrGGwCPo5fEiKwIsEKxsY/OlFxbWro=;
 b=TRbhC8+DdaV8EaSyD0lf/b/1e/2GU3BiEsPKlrCG62bEeiZh/n2lpP5m9idp9qhx1t9Bno
 +SJCPHN6QgE5fxriMW+O6kOzHeetT6Oycz09gsBl/w7EJViGYmMpUOeBkTWhX0w7V+IIW1
 Kss4h0jXITUsYcZn1OF5eCsW+Q/qjPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761681191;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltWaN+wZkxgGLLrGGwCPo5fEiKwIsEKxsY/OlFxbWro=;
 b=pUMwRWJTj6JSvRjs3bfkaaex1erLgg5xFURsQCCB4LBdsAJT6TUkyuDEd9OezLcMOJJ6o0
 WAcnLRC03KmEMAAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JkXNkr0I;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TvC4qGub
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761681190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltWaN+wZkxgGLLrGGwCPo5fEiKwIsEKxsY/OlFxbWro=;
 b=JkXNkr0IyZcUzjNwyQbz3BCMufBy8DC5OAC1XH/1/+dw7aHd97XHC0CHVIqqYIMlTemwLm
 KomoQxuWlaUc9cx4XidZxj04UilE9KkmC3P3vPuRjO59tvlrwg+GMGGcfSfb29Q200O2v9
 aGA1TmfraL9HIZ6wAvJQ4dlOf0+oZOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761681190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltWaN+wZkxgGLLrGGwCPo5fEiKwIsEKxsY/OlFxbWro=;
 b=TvC4qGub2V0fUtXwKzfGOjaB5RHrSKAhx/6DFOfZUiocN7YGHj3uW3JKGptbta0ESgEXHm
 ea/ANjtSPOKUASBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63DAE13A7D;
 Tue, 28 Oct 2025 19:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9NUWCSYfAWnfAQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Oct 2025 19:53:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Darren
 Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>
Subject: Re: [PATCH] docs/devel/testing/fuzzing: Note that you can get qtest
 to read from a file
In-Reply-To: <20251028165236.3327658-1-peter.maydell@linaro.org>
References: <20251028165236.3327658-1-peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 16:53:07 -0300
Message-ID: <871pmmerbw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E750121A5D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FREEMAIL_ENVRCPT(0.00)[outlook.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,bu.edu,oracle.com,outlook.com];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Peter Maydell <peter.maydell@linaro.org> writes:

> It is possible to get qtest to read fuzzer reproducers from a file
> rather than directly from stdio; this is useful when you want to run
> QEMU under gdb to debug the failure.  Document how to do this, which
> was previously only written down in the commit message for
> 5b18a6bf44b9 ("chardev: Allow setting file chardev input file on the
> command line").
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I got bored of looking up the commit message in the git log
> every time :-)
> ---
>  docs/devel/testing/fuzzing.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/docs/devel/testing/fuzzing.rst b/docs/devel/testing/fuzzing.rst
> index c3ac084311b..c43f815f320 100644
> --- a/docs/devel/testing/fuzzing.rst
> +++ b/docs/devel/testing/fuzzing.rst
> @@ -263,6 +263,15 @@ generic-fuzz target.
>  
>  - Report the bug and send a patch with the C reproducer upstream
>  
> +QEMU can also read the reproducer directly from a file rather than
> +from standard input::
> +
> +    $QEMU_PATH $QEMU_ARGS -qtest chardev:repro \
> +      -chardev file,id=repro,path=/dev/null,input-path=/tmp/reproducer
> +
> +This is useful if you want to run QEMU under a debugger to investigate
> +the failure.
> +
>  Implementation Details / Fuzzer Lifecycle
>  -----------------------------------------

Reviewed-by: Fabiano Rosas <farosas@suse.de>

