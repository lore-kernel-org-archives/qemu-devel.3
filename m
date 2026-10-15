Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFA8CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLFB-0001Tq-5T; Thu, 15 Oct 2026 09:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHLF7-0001Tc-IJ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:11:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHLF5-0003sE-9s
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:11:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E8281FF60;
 Thu, 15 Oct 2026 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792069889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ne4Ce9SMYL1stVtY0bThXko0Q7wxnFgGPktHIGbRdrw=;
 b=gQkCEQNJKpPB7wK7I18+2cVj4sVJ4sdIT0UpqlqdcHq1MW9+OA69JOzD/MEkF9HdhciHjJ
 1cohBmaQmxLfon2Ux2vYCmcCOoL8Ta7eEt5+1d1IDPpwgZ6LIFmuMMyZXX6I4afYMRT6z0
 znMH1LLhvPg5GMQ+IXPtkLOlnW7M9WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792069889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ne4Ce9SMYL1stVtY0bThXko0Q7wxnFgGPktHIGbRdrw=;
 b=ha4nEINXe8fXY10wx1JIA1B2Tk5eRx3DPMO5lQLYFAFHiDXRaBIuxG/1Vhxe08D/MEG/k3
 KV5/4uU+AbSZIGCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gQkCEQNJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ha4nEINX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792069889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ne4Ce9SMYL1stVtY0bThXko0Q7wxnFgGPktHIGbRdrw=;
 b=gQkCEQNJKpPB7wK7I18+2cVj4sVJ4sdIT0UpqlqdcHq1MW9+OA69JOzD/MEkF9HdhciHjJ
 1cohBmaQmxLfon2Ux2vYCmcCOoL8Ta7eEt5+1d1IDPpwgZ6LIFmuMMyZXX6I4afYMRT6z0
 znMH1LLhvPg5GMQ+IXPtkLOlnW7M9WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792069889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ne4Ce9SMYL1stVtY0bThXko0Q7wxnFgGPktHIGbRdrw=;
 b=ha4nEINXe8fXY10wx1JIA1B2Tk5eRx3DPMO5lQLYFAFHiDXRaBIuxG/1Vhxe08D/MEG/k3
 KV5/4uU+AbSZIGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EECE1132C9;
 Thu, 15 Oct 2026 13:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XOuKOOXQ0GqBQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 Oct 2026 13:11:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>
Subject: Re: [PATCH v2 5/7] migration: Dump type of channel in
 set_incoming_channel tracepoint
In-Reply-To: <20261006182046.3767283-6-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
 <20261006182046.3767283-6-peterx@redhat.com>
Date: Thu, 15 Oct 2026 10:10:50 -0300
Message-ID: <87v773kt2d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8E8281FF60
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> Add this info to be crystal clear on what channel we're installing.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/channel.h    |  3 ++-
>  migration/channel.c    | 10 +++++++++-
>  migration/trace-events |  2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/migration/channel.h b/migration/channel.h
> index a7d0d29058..678712f291 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -24,7 +24,8 @@ typedef enum {
>      CH_NONE,
>      CH_MAIN,
>      CH_MULTIFD,
> -    CH_POSTCOPY
> +    CH_POSTCOPY,
> +    CH_NUM,
>  } MigChannelType;
>  
>  void migration_channel_process_incoming(QIOChannel *ioc);
> diff --git a/migration/channel.c b/migration/channel.c
> index 8407ea46cb..b9065efd03 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -34,6 +34,13 @@
>  #include "trace.h"
>  #include "yank_functions.h"
>  
> +static const char *const mig_channel_str[CH_NUM] = {
> +    [CH_NONE] = "NONE",
> +    [CH_MAIN] = "MAIN",
> +    [CH_MULTIFD] = "MULTIFD",
> +    [CH_POSTCOPY] = "PREEMPT",
> +};
> +
>  void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
>                                  Error **errp)
>  {
> @@ -219,7 +226,8 @@ static bool migration_incoming_channel_install(MigrationIncomingState *mis,
>      }
>  
>      trace_migration_set_incoming_channel(ioc,
> -                                         object_get_typename(OBJECT(ioc)));
> +                                         object_get_typename(OBJECT(ioc)),
> +                                         mig_channel_str[ch]);
>      migration_ioc_register_yank(ioc);
>  
>      if (migration_incoming_setup(ioc, ch, errp)) {
> diff --git a/migration/trace-events b/migration/trace-events
> index c93c9f9e75..8840d82f8d 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -208,7 +208,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
>  
>  # channel.c
>  migration_channel_process_incoming(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> -migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> +migration_set_incoming_channel(void *ioc, const char *ioctype, const char *type) "ioc=%p ioctype=%s type=%s"
>  migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>  
>  # global_state.c

Reviewed-by: Fabiano Rosas <farosas@suse.de>

