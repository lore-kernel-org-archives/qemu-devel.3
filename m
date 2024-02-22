Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8DEC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd9YU-00074l-HI; Thu, 22 Feb 2024 08:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rd9YS-00074G-Mo
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:56:04 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rd9YR-0008J6-6w
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:56:04 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93DB6222A7;
 Thu, 22 Feb 2024 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708610161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cNTMpjyj8JqBV7tUBLbGdsxggQdcntrrYyLX1i3+GZE=;
 b=S5d7nt5YbC4n9G8BnTlkxrxcroxVP29I6In1251VL6sWuIYi41hw15gNSbe7oVF8I4oNpb
 SmJkXoZBeYqqZtSZjPmYnWIGW0T48kldkzAcllFDnYPS5D3q9ixhNums4LPcGgUnjajhOB
 +LcG5jOON9piNMYQPCldfXTeoh//OJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708610161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cNTMpjyj8JqBV7tUBLbGdsxggQdcntrrYyLX1i3+GZE=;
 b=RP2YcHzw8ocqC/MEeKcdU1GmrR2dEyEV93bCAAkPwm+90F4Gcyle4A6S9nBh9jgH9qRby/
 5f+xPs0nN7d9LxCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708610161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cNTMpjyj8JqBV7tUBLbGdsxggQdcntrrYyLX1i3+GZE=;
 b=S5d7nt5YbC4n9G8BnTlkxrxcroxVP29I6In1251VL6sWuIYi41hw15gNSbe7oVF8I4oNpb
 SmJkXoZBeYqqZtSZjPmYnWIGW0T48kldkzAcllFDnYPS5D3q9ixhNums4LPcGgUnjajhOB
 +LcG5jOON9piNMYQPCldfXTeoh//OJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708610161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cNTMpjyj8JqBV7tUBLbGdsxggQdcntrrYyLX1i3+GZE=;
 b=RP2YcHzw8ocqC/MEeKcdU1GmrR2dEyEV93bCAAkPwm+90F4Gcyle4A6S9nBh9jgH9qRby/
 5f+xPs0nN7d9LxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A87613A8C;
 Thu, 22 Feb 2024 13:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KD7ENHBS12XLQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Feb 2024 13:56:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/5] migration/multifd: Cleanup TLS iochannel
 referencing
In-Reply-To: <20240222095301.171137-2-peterx@redhat.com>
References: <20240222095301.171137-1-peterx@redhat.com>
 <20240222095301.171137-2-peterx@redhat.com>
Date: Thu, 22 Feb 2024 10:55:58 -0300
Message-ID: <87r0h4a9ht.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.79)[93.72%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> Commit a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to
> blocking handshake") introduced a thread for TLS channels, which will
> resolve the issue on blocking the main thread.  However in the same commit
> p->c is slightly abused just to be able to pass over the pointer "p" into
> the thread.
>
> That's the major reason we'll need to conditionally free the io channel in
> the fault paths.
>
> To clean it up, using a separate structure to pass over both "p" and "tioc"
> in the tls handshake thread.  Then we can make it a rule that p->c will
> never be set until the channel is completely setup.  With that, we can drop
> the tricky conditional unref of the io channel in the error path.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

